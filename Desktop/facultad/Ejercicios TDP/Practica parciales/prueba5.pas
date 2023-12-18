program prueba5;
type
	rangoDias=1..31;
	registro=record
		codCliente:integer;
		dia:rangoDias;
		cantProductos:integer;
		monto:real;
	end;

	compra=record
		dia:rangoDias;
		cantProductos:integer;
		monto:real;
	end;
	
	listaC=^nodoLista;
	nodolista=record
		dato:compra;
		sig:listaC;
	end;
	
	registroA=record
		codigo:integer;
		lista:listaC;
	end;
	
	arbol=^nodoarbol;
	nodoarbol=record
		dato:registroA;
		hi:arbol;
		hd:arbol;
	end;
		
		
		
Procedure cargarArbol(var a:arbol);
	Procedure leerRegistro(var r: registro;var c: compra);
	begin
		r.cantProductos:=random(30);
		if(r.cantProductos<>0)then begin
			r.codCliente:=1+random(99);
			r.monto:=150.80+random(8000);
			r.dia:=1+random(31);
		end;
		
		c.dia:=r.dia;
		c.cantProductos:=r.cantProductos;
		c.monto:=r.monto;
	end;
	Procedure agregarArbol(var a:arbol; r:registro; c:compra);
		procedure agregarLista(var l:listaC; c:compra);
		var aux:listaC;
		begin
			new(aux);
			aux^.dato:=c;
			aux^.sig:=l;
			l:=aux;
		end;
	begin
		if(a=nil)then begin
			new(a);
			a^.dato.codigo:=r.codCliente;
			a^.dato.lista:=nil;
			agregarLista(a^.dato.lista,c);
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(r.codCliente=a^.dato.codigo)then begin
				a^.dato.codigo:=r.codCliente;
				agregarLista(a^.dato.lista,c);
				writeln('agregarLista');
			end
			else 
				if(r.codCliente<a^.dato.codigo)then
					agregarArbol(a^.hi,r,c)
				else
					agregarArbol(a^.hd,r,c);
	end;
var r:registro; c:compra;
begin
	leerRegistro(r,c);
	while(r.cantProductos<>0)do begin
		agregarArbol(a,r,c);
		leerRegistro(r,c);
	end;
end;		
		
Procedure imprimir(a:arbol);	
	Procedure imprimirLista(l:listaC);
	begin
		
		while(l<>nil)do begin
			writeln('dia: ', l^.dato.dia);
			writeln('cantProductos: ', l^.dato.cantProductos);
			writeln('monto: ', l^.dato.monto:2:2);
			l:=l^.sig;
		end;
	end;
begin
	if(a<>nil)then begin
		imprimir(a^.hi);
		writeln('CODIGO--------------------------------: ', a^.dato.codigo);
		imprimirLista(a^.dato.lista);
		imprimir(a^.hd)
	end;
end;		


procedure buscarCliente(a:arbol; var l:listaC; codC:integer);
	Procedure agregarLista(la:listaC; var l:listaC);
	var aux:listaC;
	begin
		while(la<>nil)do begin
			new(aux);
			aux^.dato:=la^.dato;
			aux^.sig:=l;
			l:=aux;
			la:=la^.sig;
		end;
	end;

begin
	if(a<>nil)then begin
		if(a^.dato.codigo=codC)then 
			agregarLista(a^.dato.lista, l)
		else
			if(codC<a^.dato.codigo)then
				buscarCliente(a^.hi,l,codC)
			else
				buscarCliente(a^.hd,l,codC);
	end;
{
	while(l<>nil)do begin
		writeln('dia: ', l^.dato.dia);
		writeln('cantProductos: ', l^.dato.cantProductos);
		writeln('monto: ', l^.dato.monto:2:2);
		l:=l^.sig;
	end;
}
end;
Procedure imprimir2(l:listaC);
begin
	while(l<>nil)do begin
		writeln('dia: ', l^.dato.dia);
		writeln('cantProductos: ', l^.dato.cantProductos);
		writeln('monto: ', l^.dato.monto:2:2);
		l:=l^.sig;
	end;
end;

Procedure buscarCompraMaxP(l:listaC);
	Procedure buscarP(l:listaC; var maxP:integer; var maxM:real);
	begin
		if(l<>nil)then begin
			if(l^.dato.cantProductos>maxP)then begin
				maxp:=l^.dato.cantProductos;
				maxM:=l^.dato.monto;
			end;
				buscarP(l^.sig, maxP,maxM);
		end
	end;

var  maxP:integer; maxM:real;
begin
	maxP:=-1;
	maxM:=0;
	buscarP(l, maxP,maxM);
	writeln('moonto de la compra con mas productos: ', maxM:2:2);
end;
		
var a:arbol; l:listaC; codC:integer;
BEGIN
	writeln('------------------Modulo C-------------------');
	randomize;
	a:=nil;
	cargarArbol(a);
	imprimir(a);
	writeln('------------------Modulo B-------------------');
	l:=nil;
	write('ingrese codigo a buscar: '); readln(codC);
	buscarCliente(a,l,codC);
	imprimir2(l);
	writeln('------------------Modulo C-------------------');
	buscarCompraMaxP(l);
END.

