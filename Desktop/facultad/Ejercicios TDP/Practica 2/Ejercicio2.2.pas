{
  Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número
leído, sus dígitos en el orden en que aparecen en el número. Debe implementarse un módulo
recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 256, se debe
imprimir 2 5 6
}


program Ejercicio2;

Procedure inciso();
	Procedure leerNum(n:integer);
	var dig:integer;
	begin
		if(n>0) then
		begin                                    
			dig:=n mod 10;
			n:=n div 10;
			leerNum(n);
			write(dig,' ');
		end;
	end;

var n:integer;
begin
	write('Numero'); readln(n);
	while (n<>0) do 
	begin
		leerNum(n);
		writeln();
		write('Numero: ');readln(n);
	end;
end;

begin
	inciso();
END.

