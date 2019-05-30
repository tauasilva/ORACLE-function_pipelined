# ORACLE-function_pipelined
Exemplo de criação de funções pipelined no ORACLE

*CREATE OR REPLACE FUNCTION FUN_PIPELINED_EXEMPLO_01 (p_param NUMBER)
RETURN TP_NUMERO 
PIPELINED IS
    i_loop INTEGER;
    numeros TP_NUMERO := TP_NUMERO();
BEGIN
	/* Inicio da regra que a função vai conter*/
    *IF (p_param IN (1,2,3)) THEN 
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

![Alt Text](https://github.com/tauasilva/ORACLE-function_pipelined/blob/master/Select_usando_pipelined.PNG)

Projeto possui dois exemplos de uso para a function pipelined.

#Pipelined Table Functions
Data is said to be pipelined if it is consumed by a consumer (transformation) as soon as the producer (transformation) produces it, without being staged in tables or a cache before being input to the next transformation.

Pipelining enables a table function to return rows faster and can reduce the memory required to cache a table function's results.

A pipelined table function can return the table function's result collection in subsets. The returned collection behaves like a stream that can be fetched from on demand. This makes it possible to use a table function like a virtual table.

Pipelined table functions can be implemented in two ways:

In the native PL/SQL approach, the consumer and producers can run on separate execution threads (either in the same or different process context) and communicate through a pipe or queuing mechanism. This approach is similar to co-routine execution.

In the interface approach, the consumer and producers run on the same execution thread. Producer explicitly returns the control back to the consumer after producing a set of results. In addition, the producer caches the current state so that it can resume where it left off when the consumer invokes it again.

The interface approach requires you to implement a set of well-defined interfaces in a procedural language.

The co-routine execution model provides a simpler, native PL/SQL mechanism for implementing pipelined table functions, but this model cannot be used for table functions written in C or Java. The interface approach, on the other hand, can. The interface approach requires the producer to save the current state information in a context object before returning so that this state can be restored on the next invocation.

In the rest of this chapter, the term table function is used to refer to a pipelined table function— a table function that returns a collection in an iterative, pipelined way.


Font: https://docs.oracle.com/cd/B28359_01/appdev.111/b28425/pipe_paral_tbl.htm









