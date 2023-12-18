{
   Implementar un programa que procese información de propiedades que están a la venta
en una inmobiliaria.
Se pide:
a) Implementar un módulo para almacenar en una estructura adecuada, las propiedades
agrupadas por zona. Las propiedades de una misma zona deben quedar almacenadas
ordenadas por tipo de propiedad. Para cada propiedad debe almacenarse el código, el tipo de
propiedad y el precio total. De cada propiedad se lee: zona (1 a 5), código de propiedad, tipo
de propiedad, cantidad de metros cuadrados y precio del metro cuadrado. La lectura finaliza
cuando se ingresa el precio del metro cuadrado -1.
b) Implementar un módulo que reciba la estructura generada en a), un número de zona y un tipo de
propiedad y retorne los códigos de las propiedades de la zona recibida y del tipo recibido.
}


program Ejercicio2;
type
	
	propiedad=record
		zona: integer;
		codigo:integer;
		tipo:String;
		cantMetros:integer;
		precioMetros:integer;
	end;
	
	prop=record
		codigo:integer;
		tipo:String;
		precioTotal:integer;
		end;
	
	listaP= ^datosPropiedades;
		datosPropiedades=record
			dato:prop;
			sig:listaP;
		end;	
	vectorZonas= array[1..5] of listaP;
//------------------------------------------------------		
Procedure insertarOrdenado(var lp:listaP; prop2:prop);
var nue,act,ant:listaP;
begin
	new(nue);
	nue^.dato := prop2;
	act:=lp;
	ant:=lp;
	while((act<>nil) and(act^.dato.codigo < prop2.codigo)) do
	begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant)then
		lp:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
//----------------------------------------------------------
Procedure leerPropiedad(var prop:propiedad);
begin
	write('Ingrese precio por metro '); readln(prop.precioMetros);
	if(prop.precioMetros<>-1)then 
	begin
	write('Ingrese zona '); readln(prop.zona);
	write('Ingrese codigo '); readln(prop.codigo);
	write('Ingrese tipo '); readln(prop.tipo);
	write('Ingrese cantidad de metros '); readln(prop.cantMetros);
	end;
end;
//---------------------------------------------------------------

Procedure cargarProp(var prop:propiedad; var prop2:prop);
begin
	prop2.codigo:=prop.codigo;
	prop2.tipo:=prop.tipo;
	prop2.precioTotal:=(prop.precioMetros*prop.cantMetros);
end;
//---------------------------------------------------------

procedure cargarVectorListas(var vec:vectorZonas; var lp:listaP);
var p:propiedad; prop2:prop;
begin
	leerPropiedad(p);
	while(p.precioMetros<>-1) do
	begin
		cargarProp(p,prop2);
		insertarOrdenado(lp,prop2);
		vec[p.zona]:=lp;
		leerPropiedad(p);
	end;
end;
//-------------------------------------------------------------
Procedure buscarPropiedad(vec:vectorZonas; z:integer; t:String);
begin
	while (vec[z]<>nil) do 
	begin
		if(vec[z]^.dato.tipo=t) then
			writeln(vec[z]^.dato.codigo);
		vec[z]:=vec[z]^.sig;
	end;
end;
//---------------------------------------------------------------
var vec:vectorZonas; lp:listaP; z:integer; t: String;
BEGIN
	cargarVectorListas(vec,lp);
	write('Ingrese una zona a buscar: ');
	readln(z);
	write('Ingrese tipo a buscar');
	readln(t);
	buscarPropiedad(vec, z,t);
END.

