s.boot;


s.plotTree;


(
x = {
	var sig, env;
	env = Line.kr(1, 0, 1, doneAction:2);
	sig = Pulse.ar(ExpRand(30,500)) * env;
}.play;
)

(
x = {
	var sig, env, freq;
	freq = XLine.kr(800, 110, 1, doneAction:2);
	env = XLine.kr(1, 0.01, 1, doneAction:2);
	sig = Pulse.ar(freq) * env;
}.play;
)

(
x = {
	arg t_gate = 0;
	var sig, env;
	env = EnvGen.kr(Env.new(
		[0.01 , 1, 0.2, 0.01],
		[0.5, 1, 2], \lin),
	    t_gate);

	sig = Pulse.ar(ExpRand(30, 500)) * env;
}.play;
)




(
x = {
	arg t_gate = 0;
	var sig, env;
	env = EnvGen.kr(Env.new(
		[0, 1, 0.2, 0],
		[0.5, 1, 2],
		[3, -3, 0]),t_gate);
	sig = Pulse.ar(LFPulse.kr(8).range(600,900)) * env;
}.play;
)

x.set(\t_gate, 1);










EnvGen

Env.new.plot;
Env.new([0.01, 1, 0.2, 0.01],[0.5, 1, 2],\exp).plot;