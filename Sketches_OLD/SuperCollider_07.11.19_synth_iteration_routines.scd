s.boot;


(
SynthDef.new(\sawtone, {
	arg freq=400, amp=0.1, out=0;
	var sig, freqCtrl, env;
	env = EnvGen.kr(Env.new([0,1,0], [2,2], [2, -2]), doneAction:2
	);
	freqCtrl = freq * LFNoise1.kr(2!8).range(-0.25,0.25).midiratio;
	sig = VarSaw.ar(freqCtrl) * env * amp;
	sig = Splay.ar(sig);
	Out.ar(out,sig);
}).add;
)

(
SynthDef.new(\sawtooone, {
	arg freq=400, amp=0.1, out=0, gate=1, rel=2;
	var sig, freqCtrl, env;
	env = EnvGen.kr(Env.asr(2,1,rel,[2, -2]),gate,  doneAction:2
	);
	freqCtrl = freq * LFNoise1.kr(2!8).range(-0.25,0.25).midiratio;
	sig = VarSaw.ar(freqCtrl) * env * amp;
	sig = Splay.ar(sig);
	Out.ar(out,sig);
}).add;
)


(
[49, 56, 60, 65].do({
	arg note, index;
	Synth.new(\sawtone, [\freq, (note-5).midicps]);

})
)

//{rrand(40,90).round(5)}!8
// crea un array de 9 valores random entre 40 y 90 y los aproxima a multiplos de 5


(
({rrand(40,90).round(5)}!8).do({
	arg note, index;
	Synth.new(\sawtone, [\freq, (note-5).midicps]);

})
)

// con collect se puede editar cada elemento en particular del arreglo,
// lo que hace es que crea un arreglo de sintes, guardados en x
// se puede acceder a ellos independientemente citando el índice de cada uno
// collection CAPTURA cada sinte


(
x = [49, 56, 60, 65].collect({
	arg note, index;
	Synth.new(\sawtooone, [\freq, (note-5).midicps]);

})
)


x[3].set(\gate, 0 );


///////////////////////ITERACIÓN//////////////////

//itero para apagar todos los sintes de una

(
x.do({
	arg syn;
	syn.set(\gate, 0, \rel, rrand(2,10));
});
)







///////ROUTINES//////////////

// {funcion}.fork -------> rutina también
// Routine.new({funcion}).play

//Arpegia, secuencia

(
Routine.new({
x = [49, 56, 60, 65].collect({
	arg note, index;
		1.wait;
	Synth.new(\sawtooone, [\freq, (note-5).midicps]);

});
}).play;
)


(
Routine.new({
	x.do({
		arg syn;
		syn.set(\gate, 0, \rel,2);
		1.wait;
	});
}).play
)


s.plotTree;



{rrand(1,100)}!5