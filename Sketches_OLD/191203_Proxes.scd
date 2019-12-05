(
	s.boot;
	p = ProxySpace.push(s);
	m = ProxyMixer(p, 8);
m.parent.alwaysOnTop_(true); // show mixer in front of IDE
)


~sine = { arg freq = 440; SinOsc.ar(freq, 0.5, 0.2)!2};
~vol={Saw.ar(100,0,1)!2};
~sine2= {~sine * ~vol};

~sine.set(\freq, ~pe);
~sine.play;
~sine.free;


{~sine2*~out}.play;

{SinOsc.ar(440, 0.5, 0.5)!2}.play;



// play some output to the hardware busses, this could be any audio rate key.
~out.play;

~out = { SinOsc.ar([400, 408] * 0.8, 0, 0.2) };


// replacing the node. the crossfade envelope is created internally.
~out = { SinOsc.ar([443, 600 - Rand(0,200)], 0, 0.2) };
~out = { Resonz.ar(Saw.ar(40 + [0,0.2], 1), [1200, 1600], 0.1) + SinOsc.ar(60 * [1,1.1],0,0.2) };
~out = { Pan2.ar(PinkNoise.ar(0.1), LFClipNoise.kr(2)) };

~out = { arg rate = 2; Pan2.ar(PinkNoise.ar(0.1), LFClipNoise.kr(rate)) };
~out.set(\rate, 30);
~out = { arg rate = 2; Pan2.ar(Dust.ar(2000, 0.2), LFClipNoise.kr(rate)) };
~out.set(\rate, 2);
~out.set(\rate, ~lfo);


~lfo = { LFNoise2.kr(30, 300, 500) };
~out = { SinOsc.ar(~lfo.kr, 0, 0.15) };
~out = { SinOsc.ar(~lfo.kr * [1, 1.2], 0, 0.1) * Pulse.ar(~lfo.kr * [0.1, 0.125], 0.5) };
~lfo = { LFNoise1.kr(30, 40) + SinOsc.kr(0.1, 0, 200, 500) };
~out = { SinOsc.ar(~lfo.kr * [1, 1.2], 0, 0.1) };
~lfo = 410;


// unary operators
~lfo2 = { SinOsc.kr(0.5, 0, 600, 100) };
~lfo = ~lfo2.abs;
~lfo2 = { SinOsc.kr(1.3, 0, 600, 100) };

// binary operators
~lfo3 = { LFTri.kr(0.5, 0, 80, 300) };
~lfo = ~lfo2 + ~lfo3;
~lfo = ~lfo3;
~lfo = (~lfo3 / 50).sin * 200 + 500 * { LFTri.kr(~lfo.kr * 0.0015, 0, 0.1 * ~lfo3.kr / 90, 1) };
~lfo3 = { Mix(~lfo2.kr * [1, 1.2]) };

currentEnvironment.free; // free all node proxies
~out.stop; // free the playback synth.


~out.play;

~out1 = { SinOsc.ar(600, 0, 0.1) };
~out2 = { SinOsc.ar(500, 0, 0.1) };
~out3 = { SinOsc.ar(400, 0, 0.1) };
~out = ~out2 + ~out1 + ~out3;

~out = ~out1 + ~out2;
~out = ~out1;

// another way is:
~out = { SinOsc.ar(600, 0, 0.1) };
~out.add({ SinOsc.ar(500, 0, 0.1) });
~out.add({ SinOsc.ar(400, 0, 0.1) });

// or with direct access:
~out[1] = { SinOsc.ar(500 * 1.2, 0, 0.1) };
~out[2] = { SinOsc.ar(400 * 1.2, 0, 0.1) };



~out.play;

~out.fadeTime = 15;
~out = { SinOsc.ar(Rand(800, 300.0) * [1,1.1], 0, 0.1) };
~out = { SinOsc.ar(Rand(800, 300.0) * [1,1.1], 0, 0.1) };
~out.fadeTime = 0.01;
~out = { SinOsc.ar(Rand(800, 300.0) * [1,1.1], 0, 0.1) };
~out = { SinOsc.ar(Rand(800, 300.0) * [1,1.1], 0, 0.1) };

~out.free(3);    // release the synths and the group with a given fadeTime without changing proxy time
~out.stop;    // stop monitor





/////////////////////////////////////////////////////////////Patterns///////////////////////////////////////////

// example

(
SynthDef(\who, { arg amp=0.1, freq=440, detune=0, gate=1, out=0, ffreq=800;
    var env;
    env = Env.asr(0.01, amp, 0.5);
    Out.ar(out, Pan2.ar(
        Formant.ar(freq + detune, ffreq, 30, EnvGen.kr(env, gate, doneAction: Done.freeSelf)), Rand(-1.0, 1.0))
    )
}).add;

)

~out.play;
~out.fadeTime = 0.1;

~out = Pbind(\instrument, \who, \freq, [600, 601], \ffreq, 800, \legato, 0.02);


// embed a control node proxy into an event pattern:
// this does not work for indirect assignment as \degree, \midinote, etc.,
// because there is calculations in the event! if needed, these can be done in the SynthDef.

~lfo = { SinOsc.kr(2, 0, 400, 700) };
~out = Pbind(\instrument, \who, \freq, 500, \ffreq, ~lfo, \legato, 0.02);

~lfo = { SinOsc.kr(SinOsc.kr(0.2, Rand(0,pi), 10, 10), 0, 400, 700) };

~lfo = { LFNoise1.kr(5, 1300, 1500) };
~lfo = { MouseX.kr(100, 5500, 1) };


(
~out = Pbind(
        \instrument, \who,
        \freq, Pseq([500, 380, 300],inf),
        \legato, 0.1,
        \ffreq, Pseq([~lfo, 100, ~lfo, 100, 300, 550], inf), // use it in a pattern
        \dur, Pseq([1, 0.5, 0.75, 0.125]*0.4, inf)
    );
)

// note that when you use a proxy within a non-event pattern it gets embedded as an object,
// so this functionality is still standard

// works only with control rate proxies. multichannel control rate proxies cause
// multichannel expansion of the events:

~lfoStereo = { LFNoise1.kr([1, 1], 1300, 1500) }; // 2 channel control rate proxy
~out = Pbind(\instrument, \who, \ffreq, ~lfoStereo, \legato, 0.02).trace;
~lfoStereo = { [MouseX.kr(100, 15500, 1), SinOsc.kr(SinOsc.kr(0.2, 0, 10, 10), 0, 400, 700)] }

// btw: setting the clock will cause the pattern to sync:
p.clock = TempoClock.default;
p.clock.tempo = 2.0;
p.clock.tempo = 1.0;


// patterns also crossfade, if an \amp arg is defined in the synthdef:
// (evaluate a couple of times)
~out.fadeTime = 3.0;
(
~out = Pbind(
        \instrument, \who,
        \freq, Pshuf([500, 380, 200, 510, 390, 300, 300],inf) * rrand(1.0, 2.0),
        \legato, 0.1,
        \ffreq, Pshuf([~lfo, 100, ~lfo, 100, 300, 550], inf),
        \dur, 0.125 * [1, 2, 3, 2/3].choose
    );
)
