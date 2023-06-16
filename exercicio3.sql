SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE ExibirTodosProdutos IS
    CURSOR C IS 
        SELECT * FROM PRODUTO;
BEGIN
    FOR I IN C LOOP
        DBMS_OUTPUT.PUT_LINE('ID: '||I.ID||
                          ' | DESCRICAO: '||I.DESCRICAO||
                          ' | STATUS: '||I.STATUS||
                          ' | CADASTRO: '||I.CADASTRO||
                          ' | QUANTIDADE EM ESTOQUE: '||I.QUANTIDADE_EM_ESTOQUE);
    END LOOP;
END;

EXECUTE ExibirTodosProdutos;