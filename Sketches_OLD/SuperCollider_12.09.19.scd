s.boot;

(
x = SynthDef.new(\sinte, {
	arg freq = 1, amp = 1;
	var sig;
	sig = SinOsc.ar(200* freq, 0, 0.2);
	sig = sig + SinOsc.ar(MouseX.kr(200,300), 0, 0.2);
	sig = sig * EnvGen.kr( Env.linen(3,1,5, amp), doneAction: 2);
	Out.ar(0, sig!2);
}
).add;
)

b = Buffer.read(s, "C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/city-ambience-exterior-cars-passing-processed.wav");

(
SynthDef.new(\samplr, {
	arg rate = 1, buf = 1, loop = 1, start = 0, end = 1, out = 0;
	var sig, ptr;
	ptr = Phasor.ar(0, BufRateScale.kr(buf)*rate, start, BufFrames.kr(buf) - end);
	sig = BufRd.ar(2, buf, ptr * rate, loop);
	Out.ar(out, sig);
}).add;
)

(
p = Pbind(

	\instrument, \sinte,
	\freq, Prand([0.5, 0.25, 1, 2, -1, -2, -0.5, -0.25, 4, 6, 2.5],inf),
	\amp, Pwhite(0.02, 0.2),
	\dur, Pexprand(1,5,inf),

).play;
)

s.plotTree;

x = Synth(\samplr);
x.set(\rate, 0.5);
x.set(\buf, 4);