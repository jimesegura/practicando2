program Prueba2;
const meses=12;
type
	subMes=1..12;
	compras=record
		cliente:integer;
		monto:real;
		mes:subMes;
	end;
	
	vectorC=array[subMes]of real;
	
	cliente=record
		codigo:integer;
		v:vectorC;
	end;
	
	arbol=^nodoarbol;
	nodoArbol=record
		dato:cliente;
		hi:arbol;
		hd:arbol;
	end;
	
Procedure cargarArbol(var a:arbol);
	Procedure leerCompra(var c:compras);
	begin
		c.cliente:=Random(100);
		if(c.cliente<>0)then begin
			c.monto:=random(20000)/(random(10)+1);
			c.mes:=random(12)+1;
		end;
	end;
	
	Procedure agregarAlArbol(var a:arbol; c:compras; var c2:cliente);
		Procedure inicializarDatos(c:compras; var c2:cliente);
		var i:integer;
		begin
			for i:=1 to meses do begin
				c2.v[i]:=0;
			end;
			c2.codigo:=c.cliente;
			c2.v[c.mes]:=c.monto;
		end;
	
	begin
		if(a=nil)then
		begin
			new(a);
			inicializarDatos(c,c2);
			a^.dato:=c2;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(c.cliente=a^.dato.codigo)then
				a^.dato.v[c.mes]:=a^.dato.v[c.mes]+c.monto
			else
				if(c.cliente<a^.dato.codigo)then
					agregarAlArbol(a^.hi,c,c2)
				else
					agregarAlArbol(a^.hd,c,c2);
	end;

var c:compras; c2:cliente;
begin
	leerCompra(c);
	while (c.cliente<>0)do begin
		agregarAlArbol(a,c,c2);
		leerCompra(c);
	end;
end;

Procedure imprimirArbol(a:arbol);
	Procedure imprimirVec(v:vectorC);
	var i:integer;
	begin
		for i:=1 to meses do
			writeln('mes: ', i,' monto: ', v[i]:2:2);
	end;
begin
	if(a<>nil)then begin
		imprimirArbol(a^.hi);
		writeln('cliente: ', a^.dato.codigo);
		imprimirVec(a^.dato.v);
		imprimirArbol(a^.hd);
	end;
end;
//--------------------------Modulo B----------------------------
Procedure mesConMayorGasto(a:arbol;cliente:integer);

	Function buscarMes(v:vectorC;cliente:integer):subMes;
	var i:integer; ok:real; ok2:subMes;
	begin
		ok:=0;
		for i:=1 to meses do begin
			if(v[i]>ok)then begin
				ok:=v[i];
				ok2:=i;
			end;
		end;
		buscarMes:=ok2;
	end;

var mes:subMes;
begin
	if(a<>nil)then
	begin 
		if(a^.dato.codigo=cliente)then begin
			mes:=buscarMes(a^.dato.v,cliente);
			writeln('el mes con mayor gasto es: ', mes);
		end
		else 
			if(cliente<a^.dato.codigo)then
				mesConMayorGasto(a^.hi,cliente)
			else
				mesConMayorGasto(a^.hd,cliente);
	end;
end;

Procedure cantidadSinCompras(a:arbol ;mes:subMes);

	Procedure cantidadSinCompras1 (a:arbol ;mes:subMes; var cant:integer);
		Procedure contar(v:vectorC; mes:subMes; var cant:integer);
		begin
			if(v[mes]=0)then
				cant:=cant+1;
		end;
	begin
		if(a<>nil)then begin
			contar(a^.dato.v, mes, cant);
			cantidadSinCompras1(a^.hi,mes,cant);
			cantidadSinCompras1(a^.hd,mes,cant);
		end;
	end;
var cant:integer;
begin
	cant:=0;
	cantidadSinCompras1(a,mes,cant);
	writeln('cantidad de clientes sin compras en el mes: ', mes,'es de: ', cant);
end;	

var a:arbol; cli:integer; mesSinC:subMes;
BEGIN
	writeln('-----------------Modulo A----------');
	randomize;
	a:=nil;
	cargarArbol(a);
	imprimirArbol(a);
	writeln('-----------------Modulo B----------');
	write('Ingrese codigo de cliente: ');readln(cli);
	mesConMayorGasto(a,cli);
	writeln('-----------------Modulo C-----------');
	write('Ingrese mes: ');readln(mesSinC);
	mesConMayorGasto(a,cli);
	cantidadSinCompras(a,mesSinC);
END.

