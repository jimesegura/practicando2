{
vi. Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a
un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.

x. Informe los números de socio pares en orden decreciente.
}
//-----------------------------------------------------------------
{a. Implemente un módulo que lea información de socios de un club y las almacene en un árbol
binario de búsqueda. De cada socio se lee número de socio, nombre y edad. La lectura finaliza
con el número de socio 0 y el árbol debe quedar ordenado por número de socio.}
program untitled;
type
	socio=record
		numero:integer;
		nombre:String;
		edad:integer;
	end;
	
	arbol=^datosSocios;
		datosSocios=record
			datos:socio;
			hi:arbol;
			hd:arbol;
		end;
//-------------------------------------------
Procedure cargarSocios(var a:arbol);

	Procedure agregarSocio(var a:arbol; s:socio);
		begin
			if(a=nil) then
			begin
				new(a);
				a^.datos:=s;
				a^.hi:=nil;
				a^.hd:=nil;
			end
			else
				if(s.numero<=a^.datos.numero) then
					agregarSocio(a^.hi,s)
					else
						agregarSocio(a^.hd,s);
		end;	
		//-----------------------------------------
		Procedure leerSocio(var s:socio);
		begin
			s.numero:=random(10);
			write('Ingrese nombre: ');readln(s.nombre);
			s.edad:=random(100);
		end;
		//-----------------------------------------
var s:socio;
begin
	leerSocio(s);
	while (s.numero<>0) do
	begin
		agregarSocio(a,s);
		leerSocio(s);
	end;
end;


//------------------------------------------------
{i. Informe el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.}
Procedure buscarMax(a:arbol; var max:integer);
begin
	if(a<>nil) then 
	begin
		if(a^.datos.numero>max) then
			max:=a^.datos.numero;
		buscarMax(a^.hd,max);
	end;
end;


//--------------------------------------------
{ii. Informe los datos del socio con el número de socio más chico. Debe invocar a un módulo
recursivo que retorne dicho socio.}
Procedure buscarMin(a:arbol; var min:integer);
begin
	if(a<>nil)then
	begin
		if(a^.datos.numero<min)then
			min:=a^.datos.numero;
		buscarMIn(a^.hi,min);
	end;
end;



//-------------------------------------------
{iii. Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que
retorne dicho valor.}
Function mayorEdad(a:arbol; var maxEdad:integer):integer;
begin
	if(a<>nil)then
	begin
		if(a^.datos.edad>maxEdad)then
			maxEdad:=a^.datos.edad;
		mayorEdad(a^.hi,maxEdad);
		mayorEdad(a^.hd, maxEdad);
	end;
	mayorEdad:=maxEdad;
end;


//--------------------------------------------
{iv. Aumente en 1 la edad de todos los socios.}
procedure aumentarEdad(var a:arbol);
begin
	if(a<>nil) then
	begin
		aumentarEdad(a^.hi);
		a^.datos.edad:=a^.datos.edad+1;
		aumentarEdad(a^.hd);
	end;
end;


//------------------------------------------------
{v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a
un módulo recursivo que reciba el valor leído y retorne verdadero o falso.}
Function buscarElemento(a:arbol; elem:integer):boolean;
begin
	if(a=nil)then
		buscarElemento:=false
	else		if(a^.datos.numero=elem)then
			buscarElemento:=true
		else
			if(elem<a^.datos.numero)then
				buscarElemento:=buscarElemento(a^.hi, elem)
			else 
				buscarElemento:=buscarElemento(a^.hd,elem);
end;


//-----------------------------------------------
{vi. Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a
un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.}
Procedure nombreSocio(a:arbol);
	Function buscarNombre(a: arbol; nom:String):boolean;
	begin
		if(a=nil)then
			buscarNombre:=false
		else
			if(a^.datos.nombre=nom)then
				buscarNombre:=true
			else begin
				buscarNombre:=buscarNombre(a^.hi,nom);
				buscarNombre:=buscarNombre(a^.hd,nom);
				writeln(a^.datos.nombre);
			end;
	end;
	
var nom:String;
begin
	writeln('Ingrese un nombre');
	readln(nom);
	if(buscarNombre(a,nom)) then 
		writeln('Existe')
	else
		writeln('No existe');
end;	


//---------------------------------------------------
{vii. Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha
cantidad.}
procedure contar(a:arbol);
Function cantSocios(a:arbol; var cant:integer):integer;
begin
	if(a<>nil)then
	begin
		cantSocios:=cantSocios(a^.hi, cant);
		cant:=cant+1;
		cantSocios:=cantSocios(a^.hd, cant);
		
	end;
	cantSocios:=cant;
end;


//-------------------------------------------------
{viii. Informe el promedio de edad de los socios. Debe invocar al módulo recursivo del inciso}
Procedure promedioEdad(a:arbol; cant:integer;var prom:real; var suma:integer);
begin
	if(a=nil)then
		prom:=suma/cant
	else begin
		suma:=suma+a^.datos.edad;
		promedioEdad(a^.hi,cant,prom,suma);
		promedioEdad(a^.hd,cant,prom,suma);
	end;
end;

var cant:integer; suma:integer; prom:real;
begin	
	prom:=0;
	cant:=0;
	suma:=0;
	writeln(cantSocios(a,cant));
	promedioEdad(a,cant, prom,suma);
	writeln(prom:2:2);
end;


//----------------------------------------
{vii e invocar a un módulo recursivo que retorne la suma de las edades de los socios.}
Procedure sumarEdades(a:arbol);
	procedure sumar(a:arbol; var suma:integer);
	begin
		if(a<>nil)then
		begin
			suma:=suma+a^.datos.edad;
			sumar(a^.hi, suma);
			sumar(a^.hd,suma);
		end;
	end;


var suma:integer;
begin
	suma:=0;
	sumar(a,suma);
	writeln(suma);
end;


//-----------------------------------------------------
{xi. Informe los números de socio en orden creciente.}
Procedure imprimirCreciente(a:arbol);
begin
	if(a<>nil)then
	begin
	imprimirCreciente(a^.hi);
	writeln(a^.datos.numero);
	imprimirCreciente(a^.hd);
	end;
end;


//------------------------------
Procedure imprimirDecreciente(a:arbol);
begin
	if(a<>nil)then
	begin
	imprimirCreciente(a^.hd);
	imprimirCreciente(a^.hi);
	writeln(a^.datos.numero);
	end;
end;


//---------------------------------
Procedure imprimirArbol(a:arbol);
begin
	if(a<>nil) then
	begin
		imprimirArbol(a^.hi);
		write('numero: ',a^.datos.numero,' -');
		writeln(' ');
		write('edad:',a^.datos.edad,' -');
		imprimirArbol(a^.hd);
		
	end;
end;


//programa principal
var a:arbol; max, min, maxEdad,elem:integer; 
BEGIN
	maxEdad:=-1;
	max:=-1;
	min:=10;
	randomize;
	a:=nil;
	cargarSocios(a);
	imprimirArbol(a);
	buscarMax(a, max);
	writeln('maximo: ',max);
	buscarMin(a,min);
	writeln('minimo: ',min);
	writeln('Mayor edad: ',mayorEdad(a,maxEdad));
	aumentarEdad(a);
	imprimirArbol(a);
	writeln('Ingrese un valor');
	readln(elem);
	writeln(buscarElemento(a,elem));
	nombreSocio(a);
	contar(a);
	sumarEdades(a);
	imprimirCreciente(a);
	writeln('--------');
	imprimirDecreciente(a);
END.


