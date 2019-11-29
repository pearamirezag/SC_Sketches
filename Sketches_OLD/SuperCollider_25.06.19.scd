s.boot;


(

 x = SynthDef.new(\greath, {
	arg freq = 440;
	var sig, amp;
	sig = SinOsc.ar([1,2,3,4]*freq);
	amp = LFPulse.kr([3,4,6,12]);
	sig = sig * amp;
	sig = GlitchBPF.ar(sig,MouseX.kr(200, 10000));
	sig = Splay.ar(sig);
	Out.ar(0, sig);
}).add;

)


(

 x = SynthDef.new(\greathe, {
	arg freq = 440;
	var sig, amp;
	sig = SinOsc.ar([1,2,3,4]*freq);
	amp = LFPulse.kr([3,4,6,12]);
	sig = sig * amp;
	sig = SineShaper.ar(sig);
	sig = GlitchBPF.ar(sig,MouseX.kr(200, 10000));
	sig = Splay.ar(sig);
	Out.ar(0, sig);
}).add;

)


x = Synth(\greath);
y = Synth(\greathe);
x.set(\freq, 220);
x.free;
y.free;