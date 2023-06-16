create or replace PROCEDURE DeletarProduto 
(P_ID IN PRODUTO.ID%TYPE) AS
    v_used number(1);
    v_status number(1);
    vProdutoUsadoOutraTabela EXCEPTION;
    vProdutoInativo EXCEPTION;
    PRAGMA EXCEPTION_INIT(vProdutoUsadoOutraTabela, -20001);
    PRAGMA EXCEPTION_INIT(vProdutoInativo, -20002);
BEGIN
    SELECT COUNT(*) INTO v_used FROM PRODUTO_PRECO WHERE ID_PRODUTO = P_ID;
    SELECT STATUS INTO v_status FROM PRODUTO WHERE ID = P_ID;
    IF v_used > 0 THEN
        RAISE vProdutoUsadoOutraTabela;
    END IF;
    IF v_status = 0 THEN
        RAISE vProdutoInativo;
    END IF;

    DELETE FROM PRODUTO WHERE ID = P_ID;

    COMMIT;

    EXCEPTION
        WHEN vProdutoUsadoOutraTabela THEN
            DBMS_OUTPUT.PUT_LINE('Erro Customizado: Produto usado em outro tabela'); 
        WHEN vProdutoInativo THEN
            DBMS_OUTPUT.PUT_LINE('Erro Customizado: Produto está desativado na tabela');
END;

EXECUTE DeletarProduto(7);