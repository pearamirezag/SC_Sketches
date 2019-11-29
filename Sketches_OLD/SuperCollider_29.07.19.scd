

~buf = Buffer.alloc(s, s.sampleRate * 5);

( SynthDef.new(\cosa, {
	arg rate = 5, amp, freq = 50, attk = 0.01, rls = 1, out = 5;
	var sig, lfo;
	sig = PinkNoise.ar();
	lfo = LFNoise1.kr(freq);
	amp = EnvGen.kr( Env.perc(attk,rls), Dust.kr(rate), doneAction: 0);
	sig = Pan2.ar(sig, lfo, amp);
	Out.ar(out, sig)
}
).add;
)

( SynthDef.new(\pingi, {
	arg in = 4, out = 0, bufnum = 0, dlytime = 5;
	var sig, rate;

	sig = In.ar(in, 2);
	sig = PingPong.ar(bufnum, sig, dlytime);
	Out.ar(out, sig);
}
).add;
)


(
~fxbus = Bus.audio(s, 1);
~srcBus = Bus.audio(s, 1);
~srcBus = Group.new;
~fxBus = Group.after(~srcBus);
)


x = Synth.new(\cosa, [\out, ~fxbus]);
y = Synth.new(\pingi, [\in, ~fxbus, \bufnum, b.bufnum], x, \addAfter);
x.set(\out, 0);
x.set(\rate, 0.1, \freq, 20);

x.free;
s.plotTree;


//TO-DO
// LOGRAR CONECTAR EL SINTE A LOS EFECTOS POR MEDIO DE BUSES 