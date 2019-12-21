(
s.boot;
p = ProxySpace.push(s);
)

(
SynthDef(\bpfsaw, {
	arg atk=2, sus=0, rel=3, ts=1, c1=1, c2=(-1), freq=500, detune=0.02, pan=0, cfhzmin=0.1, cfhzmax=0.3, cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2, lsf=200, ldb=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]),timeScale:ts,doneAction:2);
	sig = Saw.ar(freq*{LFNoise1.kr(0.5,detune).midiratio}!2);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin,cfhzmax)
		).exprange(cfmin,cfmax)}!2,
		{LFNoise1.kr(0.1).exprange(rqmin,rqmax)}!2
	);
	sig = BLowShelf.ar(sig,lsf,0.5,ldb);
	sig = Balance2.ar(sig[0],sig[1],pan);
	sig = sig*env*amp;
	Out.ar(out,sig);
}).add;
);

(
SynthDef(\bpfsaw2, {
	arg atk=2, sus=0, rel=3, ts=1, c1=1, c2=(-1), freq=500, detune=0.02, pan=0, cfhzmin=0.1, cfhzmax=0.3, cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2, lsf=200, ldb=0, amp=1, out=0;
	var sig, env, fruq;
	env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]),timeScale:ts,doneAction:2);
	fruq = ExpRand(freq-200.rand, freq+800.rand);
	sig = Saw.ar(fruq*{LFNoise1.kr(0.5,detune).midiratio}!2);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin,cfhzmax)
		).exprange(cfmin,cfmax)}!2,
		{LFNoise1.kr(0.1).exprange(rqmin,rqmax)}!2
	);
	sig = BLowShelf.ar(sig,lsf,0.5,ldb);
	sig = Balance2.ar(sig[0],sig[1],pan);
	sig = sig*env*amp;
	Out.ar(out,sig);
}).add;
);

(
	SynthDef(\sawa, {
		arg freq = 440, amp = 0.2, ts=1, atk =0.001,detune=0.02, sus = 0.8, rel = 0.5 , c1=1, c2=(-1);
		var sig, fruq, env;
		env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]),timeScale:ts,doneAction:2);
		fruq = ExpRand(100.0, 800.0);
		sig = BPF.ar(
			Saw.ar(fruq*{LFNoise1.kr(0.5,detune).midiratio}!2),800);
		sig = sig*env;
		Out.ar(0, sig);
		}).add;
)

(
55.do{
Synth.new(\sawa, [\atk, 17.rand, \rls, 16.rand]);
}
)






s.plotTree;

(
10.do{
	Synth.new(\bpfsaw, [\freq, 500.rand]);
}
)

Synth.new(\bpfsaw, [\freq, 500.rand]);
