/*Tipo de registro que a função vai retornar*/
CREATE OR REPLACE   TYPE TP_NUMERO IS TABLE OF NUMBER;




/*Exemplo 01*/
CREATE OR REPLACE FUNCTION FUN_PIPELINED_EXEMPLO_01 (p_param NUMBER)
RETURN TP_NUMERO 
PIPELINED IS
    i_loop INTEGER;
    numeros TP_NUMERO := TP_NUMERO();
BEGIN
	/* Inicio da regra que a função vai conter*/
    IF (p_param IN (1,2,3)) THEN 
        numeros := TP_NUMERO(10,20,30); 
        i_loop := 3;
    ELSIF (p_param IN (4,5,6)) THEN
        numeros := TP_NUMERO(40,50,60);
        i_loop := 3;
    ELSE
        numeros := TP_NUMERO(1);
        i_loop := 1;
    END IF;    
	/* fim da regra que a função vai conter*/

  FOR i IN 1.. i_loop LOOP
    PIPE ROW(numeros(i));
	/* Vai retornar registro por registro */
  END LOOP;
  RETURN;
END;
         
		 
		 
		 
		 
/*Exemplo 02*/		 
CREATE OR REPLACE FUNCTION FUN_PIPELINED_EXEMPLO_02
RETURN TP_NUMERO 
PIPELINED IS
  numeros TP_NUMERO := TP_NUMERO(21,242,32,42,5432);
BEGIN
  FOR i IN 1..5 LOOP
    PIPE ROW(numeros(i));
  END LOOP;
  RETURN;
END;		 
		 
		 
		 
         
--Exemplo de como usar o select
SELECT *  FROM TABLE(FUN_PIPELINED_EXEMPLO_01(1))

SELECT *  FROM TABLE(FUN_PIPELINED_EXEMPLO_02())