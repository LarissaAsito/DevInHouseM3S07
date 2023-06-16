SET SERVEROUTPUT ON
DECLARE
    CURSOR C IS 
        SELECT P.ID, P.STATUS, PP.VALOR 
          FROM PRODUTO P, 
               PRODUTO_PRECO PP 
         WHERE P.ID = PP.ID_PRODUTO 
           AND P.STATUS = 1
           AND PP.STATUS = 1
           AND PP.VALOR < 1000.00;
BEGIN
    FOR I IN C LOOP
        DBMS_OUTPUT.PUT_LINE('ID: '||I.ID||' | STATUS: '||I.STATUS||' | PRECO: '||I.VALOR);
    END LOOP;
END;