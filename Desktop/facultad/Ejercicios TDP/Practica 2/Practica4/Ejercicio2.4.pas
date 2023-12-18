{Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN -1. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).}
program Ejercicio2;
type
	prestamos=record
		isbn:integer;
		numeroSocio:integer;
		dia:integer;
		mes:integer;
		cantDiasPrestados:integer;
	end;
	
	PrestamoPuntoG=record
		isbn:integer;
		cantPrestamos:integer;
	end;
	
	lista=^datosPrestamos;
	datosPrestamos=record
		dato:prestamos;
		sig:lista;
	end;
	
	arbol=^datosPrestamo;
	datosPrestamo=record
		dato:prestamos;
		hi:arbol;
		hd:arbol;
	end;
	
	arbol2=^datosLista;
	datosLista=record
		dato:lista;
		hi:arbol2;
		hd:arbol2;
	end;
	
	listaPG=^datosPuntoG;
	datosPuntoG=record
		dato:prestamoPuntoG;
		sig:listaPG;
	end;
//----------------------------------------
Procedure cargarArboles(var a:arbol; var a2:arbol2);

	Procedure leerPrestamo(var p:prestamos);
	begin
		write('Ingrese isbn: ');readln(p.isbn);
		if(p.isbn<>-1)then 
		begin
			write('Ingrese numero de socio: ');readln(p.numeroSocio);
			write('Ingrese dia: ');readln(p.dia);
			write('Ingrese mes: ');readln(p.mes);
			write('Ingrese cantidad de dias prestados: ');readln(p.cantDiasPrestados);
		end;
	end;
	//----------
	Procedure agregarArbol1(var a:arbol;p:prestamos);
	begin
		if(a=nil)then
		begin
			new(a);
			a^.dato:=p;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(p.isbn<a^.dato.isbn)then
				agregarArbol1(a^.hi,p)
			else
				agregarArbol1(a^.hd,p);
	end;
	//-------------------
	Procedure agregarArbol2(var a2:arbol2;p:prestamos; i:integer);	
		
		Function cumple(isbn:integer; l:lista):boolean;
		begin
			if(isbn=l^.dato.isbn)then
				cumple:=true
			else
				cumple:=false;
		end;
		//-------
		Function cumple2(isbn:integer; l:lista):boolean;
		begin
			if(isbn<l^.dato.isbn)then
				cumple2:=true
			else
				cumple2:=false;
		end;
		//----------
		Procedure agregarLista(var a2:arbol2;p:prestamos);
		var n:lista;
		begin
			new(n);//nuevo nodo de la lista
			n^.dato:=p;
			n^.sig:=a2^.dato;
			a2^.dato:=n;
		end;
	var aux:lista;
	begin
		if(a2=nil)then
		begin
			new(a2);//creo nueva hoja del arbol
			
			new(aux);// creo la lista de la hoja
			aux^.dato:=p;
			aux^.sig:=nil;
			
			a2^.dato:=aux;//agrego la lista
			a2^.hi:=nil;
			a2^.hd:=nil;
		end
		else 
			if(cumple(p.isbn,a2^.dato))then
				agregarLista(a2,p)//paso el arbol no la lista
			else
				if(cumple2(p.isbn,a2^.dato))then
					agregarArbol2(a2^.hi,p,i)
				else
					agregarArbol2(a2^.hd,p,i);
	end;
	
	
var p:prestamos; i:integer;
begin
	leerPrestamo(p);
	while (p.isbn<>-1)do
	begin
		i:=p.isbn;
		agregarArbol1(a,p);
		agregarArbol2(a2,p,i);
		leerPrestamo(p);
	end;
end;	

Procedure imprimirA1(a:arbol);
begin
	if(a<>nil) then
	begin
		imprimirA1(a^.hi);
		writeln('ISBN: ',a^.dato.isbn);
		imprimirA1(a^.hd);
	end;
end;
//----------------------------------
Procedure imprimirA2(a2:arbol2);
	Procedure imprimirLista(l:lista);
	begin
		while(l<>nil)do begin
			writeln('ISBN: ',l^.dato.isbn);
			l:=l^.sig;
		end;
	end;
begin
	if(a2<>nil) then
	begin
		imprimirA2(a2^.hi);
		imprimirLista(a2^.dato);
		writeln('l');
		imprimirA2(a2^.hd);
	end;
end;
//---------------------
{Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.}
Procedure busarIsbnMasGrande(a:arbol);
	Function isbnMaGrande(a:arbol):integer;
	begin
		if(a=nil)then
			isbnMaGrande:=-1
		else
		begin
			if(a^.hd<>nil)then
				isbnMaGrande:=isbnMaGrande(a^.hd)//recorro toda la derecha
			else
				isbnMaGrande:=a^.dato.isbn;
		end;
	end;
	
var max:integer;
begin
	max:=isbnMaGrande(a);
	writeln('ISBN mas grande: ', max);
end;
{Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.}
Procedure buscarISBNMasChico(a2:arbol2);
	function buscarMin(a2:arbol2):integer;
		function devolverISBN(l:lista):integer;
		begin
			devolverISBN:=l^.dato.isbn;
		end;
	begin
		if(a2=nil)then
			buscarMin:=0
		else
			if(a2^.hi<>nil)then
				buscarMIn:=buscarMIn(a2^.hi)
			else
				buscarMin:=devolverISBN(a2^.dato);
	end;
var min:integer;
begin
	min:=buscarMin(a2);
	writeln('ISBN mas chico: ',min);
end;
{Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.}
Procedure calcularPrestamosA1(a:arbol);
	function cantPrestamos(a:arbol;numSocio:integer):integer;
	begin
		if(a<>nil)then
		begin
			if(numSocio=a^.dato.numeroSocio)then
				cantPrestamos:=1+cantPrestamos(a^.hi,numSocio)+cantPrestamos(a^.hd,numSocio)
			else begin
				cantPrestamos:=cantPrestamos(a^.hi,numSocio);
				cantPrestamos:=cantPrestamos(a^.hd,numSocio);
			end;
		end
		else
			cantPrestamos:=0;
	end;
var cant,numSocio:integer;
begin
	write('Ingrese numerode socio: ');readln(numSocio);
	cant:=cantPrestamos(a,numSocio);
	writeln('La cantidad de pedidos de ese socio es de: ', cant);
end;
{Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.}
Procedure calcularPrestamosA2(a2:arbol2);
	function contarPrestamo(a2:arbol2; numSocio:integer):integer;
		Procedure recorrerLista(l:lista;var cant:integer;numSocio:integer);
		begin
			if(l<>nil)then
			begin
				if(l^.dato.numeroSocio=numSocio)then
					cant:=cant+1;
			end;
		end;
	var cant:integer;
	begin
		if(a2<>nil)then
		begin
			cant:=0;
			recorrerLista(a2^.dato,cant,numSocio);
			contarPrestamo:=cant+contarPrestamo(a2^.hi,numSocio)+contarPrestamo(a2^.hd,numSocio);
			//contarPrestamo(a2^.hi,numSocio);
			//contarPrestamo(a2^.hd,numSocio);????????????????????????????????????
		end
		else
			contarPrestamo:=0;
	end;

var cant,numSocio:integer;
begin
	writeln('Ingrese numero de socio: ');readln(numSocio);
	cant:=contarPrestamo(a2,numSocio);
	writeln('la cantidad de prestamos es de: ',cant);
end;
{Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.}

{Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.}
procedure puntoG(a2:arbol;var a3:arbol3);
	Procedure contarPrestamos(l:lista;var cant:integer);
	begin
		while(l<>nil)do begin
			cant:=cant+1;
			l:=l^.sig;
		end;
	end;
	Procedure cargarArbol3(l:lista;var a3:arbol3;cant:integer);
			Procedure cargarPrestamo(l:lista;cant:integer;var p:prestamoPuntoF);
			begin
				p.isbn:=l^.dato.isbn;
				p.cantPrestamos:=cant;
			end;
	var p:prestamoPuntoF;
	begin
		new(a3);
		cargarPrestamo(l;cant;p);
		a3^.dato:=p;
		a3^.hi:=nil;
		a3^.hd:=nil;
		
	end;

var cant:integer; p:prestamoPuntoF
begin
	if(a2<>nil)then
	begin
		cant:=0;
		contarPrestamos(a2^.dato,cant);
		cargarArbol3(a2^.dato;a3,cant);
	end;
end;

var a:arbol;a2:arbol2;a3:arbol3;
BEGIN
	cargarArboles(a,a2);
	imprimirA1(a);
	imprimirA2(a2);
	busarIsbnMasGrande(a);
	buscarISBNMasChico(a2);
	calcularPrestamosA1(a);
	calcularPrestamosA2(a2);
	puntoG(a,a3);
END.

