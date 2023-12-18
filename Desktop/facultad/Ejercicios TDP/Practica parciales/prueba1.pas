program Prueba1;
const 
	dimF=12;
type 
	d=1..31;
	m=1..12;
	compras=record
		videojuego:integer;
		cliente:integer;
		dia:d;
		mes:m;
	end;
	
	comprasSinCodCli=record
		videojuego:integer;
		dia:d;
		mes:m;
	end;
	
	arbol=^nodocompras;
	nodocompras=record
		dato:compras;
		hi:arbol;
		hd:arbol;
	end;
	
	vectorComprasMes=array[m] of integer;
	
	//modulo b
	
	listaC=^nodoLista;
	nodoLista=record
		dato:comprasSinCodCli;
		sig:listaC;
	end;


Procedure cargarEstructuras(var a:arbol; var v:vectorComprasMes);
	Procedure leerCompras(var c:compras);
	begin
		c.cliente:=Random(100);
		if(c.cliente<>0)then begin
			c.dia:=Random(31)+1;
			c.mes:=Random(12)+1;
			c.videojuego:=Random(20000)+1;
		end;
	end;
	
	Procedure cargarArbol(var a:arbol; c:compras);
	begin
		if(a=nil)then
		begin
			new(a);
			a^.dato:=c;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(c.cliente<a^.dato.cliente)then
				cargarArbol(a^.hi,c)
			else
				cargarArbol(a^.hd,c);
	end;
	
	Procedure cargarVector(var v:vectorComprasMes; mes:integer);
	begin
		v[mes]:=v[mes]+1;
	end;

var c:compras;
begin
	leerCompras(c);
	while (c.cliente<>0)do begin
		cargarArbol(a,c);
		cargarVector(v,c.mes);
		leerCompras(c);
	end;
end;

Procedure inicializarV(var v:vectorComprasMes);
var i:integer;
begin
	for i:=1 to 12 do begin
		v[i]:=0;
	end;
end;

procedure imprimirarbol(a:arbol);
begin
	if(a<>nil)then
	begin
		imprimirarbol(a^.hi);
		writeln('cliente: ',a^.dato.cliente);
		writeln('mes: ',a^.dato.mes);
		imprimirarbol(a^.hd);
	end;
end;

Procedure imprimirV(var v:vectorComprasMes);
var i:integer;
begin
	for i:=1 to 12 do begin
		writeln('cantV: ',i, ': ', v[i]);
	end;
end;

Procedure retornarCompras(a:arbol; var l:listaC; codC:integer);
	
	Procedure igualarRegistros(c:compras; var c2:comprasSinCodCli);
	begin
		c2.videojuego:=c.videojuego;
		c2.dia:=c.dia;
		c2.mes:=c.mes;
	end;
	
	Procedure agregarAlista(c2:comprasSinCodCli; var l:listaC);
	var aux:listaC;
	begin
		new(aux);
		aux^.dato:=c2;
		aux^.sig:=l;
		l:=aux;
	end;
	
var c2:comprasSinCodCli;
begin
	if(a<>nil)then begin
		if(codC=a^.dato.cliente)then
		begin
			igualarRegistros(a^.dato,c2);
			agregarAlista(c2,l);
		end;
			if(codC<a^.dato.cliente)then
				retornarCompras(a^.hi,l,codC)
			else
				retornarCompras(a^.hd,l,codC);
	end;
end;

Procedure imprimirLista(l:listaC);
begin
	while(l<>nil)do begin
		writeln('mes: ',l^.dato.mes);
		writeln('dia: ',l^.dato.dia);
		writeln('videojuego: ',l^.dato.videojuego);
		l:=l^.sig;
	end;
end;

Procedure ordenarVector(var v:vectorComprasMes);
var	i,j,pos: integer; item:integer;
begin
	for i:=1 to dimF-1 do begin
		pos:=i;
		for j:=i+1 to dimF do 
			if(v[j]<v[pos])then
				pos:=j;
				
			item:=v[pos];
			v[pos]:=v[i];
			v[i]:=item;
	end;
end;
	
var a:arbol; v:vectorComprasMes; l:listaC; codC:integer;
BEGIN
	l:=nil;
	inicializarV(v);
	Randomize;
	cargarEstructuras(a,v);
	imprimirarbol(a);
	imprimirV(v);
	writeln('-------------Modulo B------------');
	write('Ingrese codigo de cliente: '); readln(codC);
	retornarCompras(a,l, codC);
	imprimirLista(l);
	writeln('-----Modulo C--------------------');
	ordenarVector(v);
	imprimirV(v);
END.

