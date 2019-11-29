s.boot;








5.do({"heelo".postln});

(
5.do(
	{
	arg freq;
	freq = freq*400;
	SinOsc.ar(freq!2, mul: EnvGen.kr( Env.perc(), doneAction: 2))};
).play;
)



(

SynthDef.new(\iter, {
	arg freq = 400;
	var temp, sum;
	sum = 0;
	5.do{
		arg count;
		temp = SinOsc.ar(freq*count, mul: EnvGen.kr( Env.perc(), doneAction: 2));
		sum = sum + temp;
	};
	sum = sum * 0.05;
	Out.ar(0, sum);
}).add;2
)

x = Synth.new(\iter);