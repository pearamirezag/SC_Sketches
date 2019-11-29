s.boot;

{Splay.ar(SinOsc.ar(SinOsc.ar(5), mul: 20))}.play;

{Clip.ar(SinOsc.ar(SinOsc.ar(MouseX.kr(maxval: 300))*400, mul: 0.5))}.play;


(
{
	Splay.ar(
		SinOsc.ar(
			SinOsc.ar(
				MouseX.kr(maxval: 300))*800,
			mul: EnvGen.kr(Env.perc(), Dust.kr(2), doneAction: 0)

	)
	)

}.play;
) //playfull FM


s.scope;
