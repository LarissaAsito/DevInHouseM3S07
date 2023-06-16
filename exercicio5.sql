create or replace PROCEDURE AtualizarProdutoPreco 
(P_ID IN PRODUTO.ID%TYPE, 
P_VALOR IN PRODUTO_PRECO.VALOR%TYPE) AS
    v_count number(2);
    v_exists number(1);
    v_status number(1);
    vProdutoNaoExiste EXCEPTION;
    vProdutoInativo EXCEPTION;
    PRAGMA EXCEPTION_INIT(vProdutoNaoExiste, -20001);
    PRAGMA EXCEPTION_INIT(vProdutoInativo, -20002);
BEGIN
    begin
        SELECT STATUS INTO v_status FROM PRODUTO WHERE ID = P_ID;
        v_exists := 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        v_exists := 0;
    END;
    
    IF v_exists = 0 THEN
        RAISE vProdutoNaoExiste;
    END IF;
    IF v_status = 0 THEN
        RAISE vProdutoInativo;
    END IF;

    select count(*) into v_count from produto_preco;

    UPDATE PRODUTO_PRECO
    SET STATUS = 0
    WHERE ID_PRODUTO = P_ID
    AND STATUS = 1;

    INSERT INTO PRODUTO_PRECO(ID, ID_PRODUTO, VALOR, STATUS, CADASTRO) 
    VALUES(v_count+1, P_ID, P_VALOR, 1, SYSDATE);

    COMMIT;

    EXCEPTION
        WHEN vProdutoNaoExiste THEN
            DBMS_OUTPUT.PUT_LINE('Erro Customizado: Produto não existe'); 
        WHEN vProdutoInativo THEN
            DBMS_OUTPUT.PUT_LINE('Erro Customizado: Produto está desativado na tabela');
END;

BEGIN
    AtualizarProdutoPreco(4, 126);
END;