(
SynthDef.new(\hola, {
	arg freq = 400, out = 0;
	var onda, friki;
	friki = LFTri.kr(0.2,0,0.2,1);
	freq = freq * friki;
	onda = Saw.ar(freq);
	Out.ar(out, onda);

}).add;
)

s.plotTree;


(
SynthDef.new(\aloh, {
	arg freq = 6000, out = 1;
	var onda, friki;
	friki = LFTri.kr(0.2,0,0.2,1);
	freq = freq * friki;
	onda = Saw.ar(freq);
	Out.ar(out, Pan2.ar(onda, SinOsc.kr(15)));

}).add;
)

(
SynthDef.new(\reverb, {
	arg in, out=0, mix = 0.33, room = 0.2;
	var sig;
	sig = In.ar(in,1);
	sig = FreeVerb.ar(sig, mix, room)!2;
	Out.ar(out, sig);
}).add;
)


(
SynthDef.new(\dusty, {
	arg freq = 20, out = 0, pfreq = 10, amt = 1;
	var sig, paneo;
	paneo = SinOsc.kr(pfreq,0,amt);
	sig = Dust.ar(freq);
	Out.ar(out, Pan2.kr(sig, paneo));

}).add;
)


b = Synth(\dusty);
x = Synth(\hola);
y = Synth(\hola);
u = Synth(\aloh);
u.free;

x.free;
y.free;
x.set("freq", 60, "out", 1);
x.set("freq", 30);
y.set("freq", 5);
x.set("out",1);
z.set("mix", 1);
x.set("freq", 10);


{SinOsc.kr(0.2,)}.plot;

z = Synth.new(\reverb, [\in,1]);

Dust.kr