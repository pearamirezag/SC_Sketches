s.boot;


(

x = SynthDef.new(\yunta, {
	arg rls = 0.5, amt = 5, dens = 5;
	var sig, lfo, amp;
	sig = VarSaw.ar(ExpRand(20,3000)!amt, width: ExpRand());
	amp = EnvGen.kr( Env.perc(releaseTime: rls), Dust2.kr(dens), doneAction: 0)!amt;
	sig = Splay.ar(sig);
	sig = sig * amp;
	Out.ar(0, sig);
}).add;
)

(

x = SynthDef.new(\yunta, {
	arg rls = 0.5, amt = 5, dens = 5;
	var sig, lfo, amp;
	sig = VarSaw.ar({ExpRand(20,3000)}!8, width: ExpRand());
	amp = EnvGen.kr( Env.perc(releaseTime: rls), {Dust2.kr(dens)}!8, doneAction: 0);
	sig = Splay.ar(sig) * amp;
	Out.ar(0, sig);
}).add;
)
//Implementé multichannel expansion
//Tuve problemas con generar multiples valores del UGen con un random y un !
//Para solucionarlo revisé el video de Fieldsteel para darme cuenta que es
//Necesario envolver el UGen dentro de { }

//Descubri que generando múltiples valores de un Sawwave suena como el
//SuperSaw de Lorenzo Senni

x = Synth.new(\yunta);
x.set(\rls, 0.1);
x.set(\dens, 10);
x.free;


s.boot;
s.plotTree;
s.scope;


