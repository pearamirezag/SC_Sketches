s.boot;

~glitchy = Array.new;


~folder = PathName.new("C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/glitchy");

(
~folder.entries.do({
	arg path;
	~glitchy = ~glitchy.add(Buffer.read(s, path.fullPath));
});
)

~glitchy[5].play;
~glitchy[6].play;
~glitchy[6].numFrames;
BufFrames.kr(6)


(
SynthDef.new(\samplr, {
	arg rate = 1, buf = 1, loop = 1, start = 0, end = 1, out = 0;
	var sig, ptr;
	ptr = Phasor.ar(0, BufRateScale.kr(buf)*rate, start, BufFrames.kr(buf) - end);
	sig = BufRd.ar(2, buf, ptr * rate, loop);
	Out.ar(out, sig);
}).add;
)


{Phasor.ar(0, BufRateScale.kr(1)*2, 0, BufFrames.kr(1) - 1)}.plot;
{Phasor.ar(0, BufRateScale.kr(1)*0.5, 150, BufFrames.kr(1) - 1)}.plot;
{SinOsc.ar(4, 3pi/2).range(0, BufFrames.kr(1)-1)}.plot;

{SinOsc.ar(440, 3pi/2)}.plot;
{SinOsc.ar(440, 0)}.plot;

{BufRd.ar(2, 2,Phasor.ar(0, BufRateScale.kr(1)*0.5, 150, BufFrames.kr(1) - 1) , loop: 0)*EnvGen.kr(Env.perc, doneAction:2)}.play;

{BufDur.kr(1)}.plot;

(
SynthDef.new(\samplr_sine, {
	arg rate = 1, buf = 1, loop = 0, start = 0, end = 1, out = 0, freq = 1, amp = 1, pan_freq = 0.4, pan_mul = 1, rele = 1, interpol = 1;
	var sig, ptr, vol;
	vol = EnvGen.kr(Env.perc(releaseTime: BufDur.kr(buf)), doneAction:2);
	ptr = SinOsc.ar(freq, 3pi/2).range(start, BufFrames.kr(buf)-end);
	sig = BufRd.ar(1, buf, ptr, loop, interpol);
	Out.ar(out, Pan2.ar(sig, LFNoise0.kr(pan_freq),pan_mul));
}).add;
)

s.plotTree;

x = Synth.new(\samplr);
y = Synth.new(\samplr_sine, [\loop, 0 ]);
x.set(\rate, -1);
x.set(\buf, 5);
x.set(\start, 150);
y.set(\buf, 8);
y.set(\freq, 0.9, \loop, 0);
y.set(\start, 000, \end, 000);
y.free;

(
p = Pbind(

	\instrument, \samplr_sine,
	\freq, Prand([0.5, 0.25, 1, 2, -1, -2, -0.5, -0.25, 4, 6, 2.5],inf),
	\amp, Pwhite(0.2, 0.9),
	\dur, Pexprand(0.2,2,inf),
	\pan_freq, Pshuf([0.1, 0.6, 1, 2, 6, 4, 9 , 2],inf),
	\buf, Pxrand([1,2,3,4,5,6,7,8,9,10,11,12],inf),
	\rele, Prand([1, 1, 1.5, 2, 0.5, 0.2, 0.1, 0.5],inf),
	\interpol, Prand([1, 1, 1, 1, 2,2 , 2, 2, 2, 4, 4],inf)

).play;
)



