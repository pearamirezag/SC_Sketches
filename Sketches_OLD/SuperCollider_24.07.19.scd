s.boot;

(
SynthDef.new("harpsichord1", { arg out, freq = 440, amp = 0.1, pan = 0;
    var env, snd;
	env = EnvGen.kr(Env.perc(level: amp),Dust.kr(2));
	freq = LFNoise0.kr(3).exprange(300,1200).round(300);
	snd = Pulse.ar(freq, 0.25, 0.75);
	snd = snd * env;
	Out.ar(out, Pan2.ar(snd, pan));
}).add;

SynthDef.new(\dist, {
	arg in = 2, out = 0,  numChan = 1, preGain = 0.5, postGain = 0.5;
	var sig;
	sig = In.ar(in, 2);
	sig = (sig * preGain).fold2 * postGain;
	sig = Clip.ar(sig);
	Out.ar(out, sig);
}).add;

)




~fxBus = Bus.audio(s, 1);
~srcBus = Bus.audio(s, 1);
~srcBus = Group.new;
~fxBus = Group.after(~srcBus);

x = Synth.new(\harpsichord1, [\out, ~fxGroup]);
y = Synth.new(\dist, [\in, ~fxGroup, \out, 0, \preGain, 150, \postGain, 2], x, \addAfter);

//Aprendiendo a usar buses
//Todavía no entiendo muy bien la lógica detrás de los buses, es decir la sintaxis y todas esas cosas. Averiguar Group y Bus UGEN. Como se usan y etc.