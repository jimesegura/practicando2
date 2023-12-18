{Una agencia dedicada a la venta de autos ha organizado su stock y, dispone en papel de la
información de los autos en venta. Implementar un programa que:
a) Lea la información de los autos (patente, año de fabricación (2010..2018), marca y
modelo) y los almacene en dos estructuras de datos:
i. Una estructura eficiente para la búsqueda por patente.
ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
almacenar todos juntos los autos pertenecientes a ella.}


Program Ejercicio1;
type
	anioF=2010..2018;

	autos=record
		patente:String;
		anioFabricacion:anioF;
		marca:String;
		modelo:String;
	end;
	
	arbol=^nodoAuto;
	nodoAuto=record
		dato:autos;
		hi:arbol;
		hd:arbol;
	end;
	
	autoSinMarca=record
		patente:String;
		anioFabricacion:anioF;
		modelo:String;
	end;
	
	listaA=^nodoAutoSinMarca;
	nodoAutoSinMarca=record
		dato:autoSinMarca;
		sig:listaA;
	end;
		
	
{
	autoMarca=record
		marca:String;
		lista:listaA;
	end;
}
	
	arbol2=^nodoAutoMarca;
	nodoAutoMarca=record
		marca:String;
		lista:listaA;
		hi:arbol2;
		hd:arbol2;
	end;
	
	autoSinAnio=record
		patente:String;
		marca:String;
		modelo:String;
	end;
	
	listaF=^nodolista;
	nodolista=record
		dato:autoSinAnio;
		sig:listaF;
	end;
		
	
	arbol3=^nodoAnioFabricacion;
	nodoAnioFabricacion=record
		anio:anioF;
		lista:listaF;
		hi:arbol3;
		hd:arbol3;
	end;
	

Procedure cargarArboles(var a1:arbol; var a2:arbol2);



	Procedure leerAuto(var a:autos);
	begin
		writeln('Ingrese una patente: ');readln(a.patente);
		if(a.patente<>'zzz')then
		begin
			writeln('Ingrese anio de fabricacion: ');readln(a.anioFabricacion);
			writeln('Ingrese una marca: ');readln(a.marca);
			writeln('Ingrese una modelo: ');readln(a.modelo);
		end;
	end;

	Procedure agregarA1(var a1:arbol; a:autos);
	begin
		if(a1=nil)then
		begin
			new(a1);
			a1^.dato:=a;
			a1^.hi:=nil;
			a1^.hd:=nil;
		end
		else
			if(a.patente<a1^.dato.patente)then
				agregarA1(a1^.hi,a)
			else 
				agregarA1(a1^.hd,a);
	end;
	
	Procedure cargarA2(var a2:arbol2;a:autos);
		Procedure igualarRegistros(var aSinM:autoSinMarca;a:autos);
		begin
				aSinM.patente:=a.patente;
				aSinM.anioFabricacion:=a.anioFabricacion;
				aSinM.modelo:=a.modelo;
		end;
		Procedure agregarEnLista(aSinM:autoSinMarca; var l:listaA);
			var aux:listaA;
			begin
				new(aux);
				aux^.dato:=aSinM;
				aux^.sig:=l;
				l:=aux;
			end;
{
		Procedure cargarAM(var aConM:autoMarca; a:autos; var aux:listaA;var aSinM:autoSinMarca);		
		var  l:listaA;
		begin
			aConM.marca:=a.marca;
			igualarRegistros(aSinM,a);
			agregarEnLista(aSinM,l);
			aConM.lista:=l;
		end;
}
		
	var aSinM:autoSinMarca; //q:autoMarca;
	begin
		if(a2=nil)then
		begin
			new(a2);
			a2^.marca:=a.marca;
			//a2^.dato:=aConM;
			a2^.lista:=nil;
			igualarRegistros(aSinM,a);
			agregarEnLista(aSinM,a2^.lista);
			a2^.hi:=nil;
			a2^.hd:=nil;
		end
		else
			if(a.marca=a2^.marca)then begin
				igualarRegistros(aSinM,a);
				agregarEnLista(aSinM,a2^.lista);
			end
			else
				if(a.marca<a2^.marca)then
					cargarA2(a2^.hi,a)
				else
					cargarA2(a2^.hd,a);
	end;


var a:autos;
begin
	leerAuto(a);
	while (a.patente<>'zzz')do
	begin
		agregarA1(a1,a);
		cargara2(a2,a);
		leerAuto(a);
	end;
end;

Procedure imprimir(a1:arbol);
begin
	if(a1<>nil)then
	begin
		imprimir(a1^.hi);
		writeln(a1^.dato.patente);
		imprimir(a1^.hd);
	end;
end;

Procedure imprimir2(a2:arbol2);
	Procedure imprimirLista(l:listaA);
	begin
		while (l<>nil)do
		begin
			writeln(l^.dato.patente);
			l:=l^.sig;
		end;
	end;
begin
	if(a2<>nil)then
	begin
		imprimir2(a2^.hi);
		writeln('Lista');
		imprimirLista(a2^.lista);
		imprimir2(a2^.hd);
	end;
end;

{Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
cantidad de autos de dicha marca que posee la agencia.}
Procedure buscarMarcaA1(a1:arbol);
	Function buscar(a1:arbol; marcaBuscar:String):integer;
	begin
		if(a1=nil)then
			buscar:=0
		else
			if(a1^.dato.marca=marcaBuscar)then
				buscar:=1+buscar(a1^.hi,marcaBuscar)+buscar(a1^.hd,marcaBuscar)
			else
				if(marcaBuscar<a1^.dato.marca)then
					buscar:=buscar(a1^.hi,marcaBuscar)
				else
					buscar:=buscar(a1^.hd,marcaBuscar);
	end;

var cant:integer; marcaBuscar:String;
begin
	write('Ingrese marca: ');readln(marcaBuscar);
	cant:=buscar(a1,marcaBuscar);
	writeln('Cantidad de autos de esa marca : ', cant);
end;
{Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
la cantidad de autos de dicha marca que posee la agencia.}
Procedure buscarMarcaA2(a2:arbol2);
	Function buscar(a2:arbol2;marcaBuscar:String):integer;
		Function contarLista(l:listaA):integer;
		var cant:integer;
		begin
			cant:=0;
				while(l<>nil)do 
				begin
					cant:=cant+1;
					l:=l^.sig;
				end;
			contarLista:=cant;
		end;
			
	begin
		if(a2=nil)then
			buscar:=0
		else
		if(a2^.marca=marcaBuscar)then 
			buscar:=contarLista(a2^.lista)
		else 
			if(marcaBuscar<a2^.marca)then
				buscar:=buscar(a2^.hi,marcaBuscar)
			else
				buscar:=buscar(a2^.hd,marcaBuscar);
	end;

var cant:integer; marcaBuscar:String;
begin
	write('Ingrese marca: ');readln(marcaBuscar);
	cant:=buscar(a2,marcaBuscar);
	write('Cantidad de autos de esa marca: ', cant);
end;
{Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
la información de los autos agrupados por año de fabricación.}
Procedure cargarA3(var a3:arbol3; a1:arbol);
	Procedure cargarArbol3(a:autos; var a3:arbol3);
		Procedure igualarRegistros(var aSinA:autoSinAnio; a:autos);
		begin
			aSinA.patente:=a.patente;
			aSinA.marca:=a.marca;
			aSinA.modelo:=a.modelo;
		end;
		Procedure agregarLista(aSinA:autoSinAnio;var l:listaF);
		var aux:listaF;
		begin
			new(aux);
			aux^.dato:=aSinA;
			aux^.sig:=l;
			l:=aux;
		end;
	var aSinA:autoSinAnio;
	begin
		if(a3=nil)then
		begin
			new(a3);
			a3^.anio:=a.anioFabricacion;
			a3^.lista:=nil;
			igualarRegistros(aSinA,a);
			agregarLista(aSinA,a3^.lista);
			a3^.hi:=nil;
			a3^.hd:=nil;
		end
		else
			if(a.anioFabricacion=a3^.anio)then begin
				igualarRegistros(aSinA,a);
				agregarLista(aSinA,a3^.lista);
			end
			else
				if(a.anioFabricacion<a3^.anio)then
					cargarArbol3(a,a3^.hi)
				else
					cargarArbol3(a,a3^.hi);
	end;
begin
	if(a1<>nil)then begin
		cargarArbol3(a1^.dato,a3);
		cargarA3(a3,a1^.hi);
		cargarA3(a3,a1^.hd);
		
	end
end;

Procedure imprimirA3(a3:arbol3);
	Procedure imprimirLista(l:listaF);
	begin
		while(l<>nil)do begin
			writeln(l^.dato.patente);
			l:=l^.sig;
		end;
	end;

begin
	if(a3<>nil)then
	begin
		imprimirA3(a3^.hi);
		writeln('lista');
		imprimirLista(a3^.lista);
		writeln('anio');
		writeln(a3^.anio);
		imprimirA3(a3^.hd);
	end;
end;
{Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
modelo del auto con dicha patente.}
Procedure buscarModelo(a1:arbol);
	Function buscarModelo(a1:arbol;patente:String):String;
	begin
		if(a1=nil)then
			buscarModelo:='no se encontro'
		else
			if(patente=a1^.dato.patente)then
				buscarModelo:=a1^.dato.modelo
			else
				if(patente<a1^.dato.patente)then
					buscarModelo:=buscarModelo(a1^.hi,patente)
				else
					buscarModelo:=buscarModelo(a1^.hd,patente);
	end;

var modelo:String; patente:String;
begin
	write('Ingrese patente: ');readln(patente);
	modelo:=buscarModelo(a1,patente);
	writeln('El modelo es: ', modelo);
end;


var a1:arbol;a2:arbol2;a3:arbol3;

begin
	a1:=nil;
	a2:=nil;
	a3:=nil;
	cargarArboles(a1,a2);
	writeln('Arbol1');
	imprimir(a1);
	writeln('Arbol2');
	imprimir2(a2);
	buscarMarcaA1(a1);
	buscarMarcaA2(a2);
	cargarA3(a3,a1);
	writeln('Arbol3');
	imprimirA3(a3);
	buscarModelo(a1);
end.
