//--boot the server
s.boot;
s.meter;
s.scope;

{SinOsc.ar(MouseX.kr(400, 4000, 1)).dup}.play;
//press cmd+. to stop (ctrl+. on windows)

//--load sounds and effects
(
SynthDef(\avsynth, {|out= 0, freq= 400, atk= 0.01, rel= 0.1, cur= -4, amp= 0.1, gate= 1, pan= 0, mod= 1, filtAmt= 200, filtQ= 0.1, filtLag= 0|
    var env= EnvGen.ar(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
    var snd= VarSaw.ar(freq, 0, LFDNoise3.ar(env*mod, 0.5, 0.5));
    filtAmt= filtAmt.clip(4, 4000);
    snd= BLowPass4.ar(snd, env.lag(filtLag)*filtAmt+(filtAmt*4), 1-env+filtQ.clip(0.01, 30));
    Out.ar(out, Pan2.ar(snd*env, pan, amp));
}).add;
SynthDef(\avverb, {|in= 0, out= 0, room= 1, drylevel= 0.1|
    var snd= In.ar(in, 2);
    var efx= Mix({AllpassN.ar(HPF.ar(snd, {50.0.rrand(100)}!2), 0.1, {0.005.rrand(0.1)}!2, 3*room, 0.15)}!8);
    efx= efx+Mix({AllpassN.ar(HPF.ar(efx, {100.0.rrand(300)}!2), 0.25, {0.05.exprand(0.25)}!2, 4*room, 0.1)}!4);
    Out.ar(out, snd*drylevel+efx);
}).add;
SynthDef(\avdist, {|in= 0, out= 0, dist= 20|
    var snd= In.ar(in, 2);
    snd= (snd*(dist+1)).sin*(1/(dist+1));
    Out.ar(out, snd);
}).add;
)

//--start playing
(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pseq([200, 400, 600, 700], inf),  //change these
    \dur, 0.25,
    \legato, 0.01,  //change this from 0 to 1
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pseq([200, 400, 600, 700], inf),  //first tone is lower
    \dur, 0.25,
    \legato, 0.5,  //all tones longer
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pseq([200, 400, 600, 700, 800, 500, 400, 300], inf),  //more
    \dur, 0.25,
    \legato, 0.05,  //shorter
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pseq([200, 400, 600, 700, 800, 500, 400, 300], inf),
    \dur, 0.125,  //everything faster
    \legato, 0.05,
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pseq([200, Pseq([300, 1200], 4), 600, 700, 800, 500, 400, 300], inf),  //nested patterns
    \dur, 0.125,
    \legato, 0.05,
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pseq([Pseq([Pseq([100, 300, 400], 2), 1200], 3), 600, 700, 800, 500, 400, 300], inf),  //nested nested patterns
    \dur, 0.125,
    \legato, Pseq([Pseq([0.1], 8), 0.5, 0.6, 0.7, 0.8, 0.9, 1], inf),  //8 repeats instead of inf
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pseq([Pseq([Pseq([250, 300, 350], 2), 1200], 3), 600, 700, 800, 500, 400, 300], inf)*0.5,  //scale (transpose down 1 octave)
    \dur, 0.125,
    \legato, Pseq([Pseq([0.1], 8), 0.5, 0.6, 0.7, 0.8, 0.9, 1], inf)*2,  //scale (double duration)
)).play;
)

//back to simple
(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pseq([300, 500, 600, 700], inf),
    \dur, 0.125,
    \legato, 0.1,
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pstutter(2, Pseq([300, 500, 600, 700], inf)),  //stutter twice
    \dur, 0.125,
    \legato, 0.1,
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pstutter(2, Pseq([300, 500, 600, 700, Pstutter(4, Pseq([800], 1))], inf)),  //nested stutter
    \dur, 0.125,
    \legato, 0.1,
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pstutter(2, Pseq([300, 500, 600, 700, Pstutter(4, Pseq([800], 1))], inf)),
    \dur, 0.125,
    \legato, 0.1,
    \atk, 0,  //change attack
    \rel, 0.3,  //change release
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pstutter(2, Pseq([300, 500, 600, 700, Pstutter(4, Pseq([800], 1))], inf)),
    \detune, Pseq([0, 0, -10, 100, 0, 0, 0], inf),  //also added detune
    \dur, 0.125,
    \legato, 0.1,
    \atk, Pseq([0, 0, 0.1], inf),  //can also be pattern
    \rel, Pstutter(8, Pseq([0.5, 0.1], inf)),  //can also be pattern
)).play;
)

//now a second sequencer. note the new name pat2
(
Pdef(\pat2, PmonoArtic(\avsynth,
    \freq, Pseq([100, 200, 300, 300], inf),
    \dur, 0.125,
    \legato, 0.1,
    \atk, 0.01,
    \rel, 0.5,
)).play;
)

(
Pdef(\pat2, PmonoArtic(\avsynth,
    \freq, Pseq([100, 200, 300, 300], inf),
    \dur, 0.125,
    \legato, 0.1,
    \atk, 0.01,
    \rel, 0.5,
    \pan, Pseq([-0.5, 0, 0.5], inf),  //panning left-right
)).play;
)

(
Pdef(\pat2, PmonoArtic(\avsynth,
    \freq, Pseq([100, 200, 300, 300], inf)*2,  //transpose up one octave
    \dur, 0.125,
    \legato, 0.1,
    \atk, 0.01,
    \rel, 0.5,
    \pan, Pseq([-0.5, 0, 0.5], inf),
)).play;
)

(
Pdef(\pat2, PmonoArtic(\avsynth,
    \freq, Pseq([100, 200, 300, 300], inf)*Pstutter(8, Pseq([1, 1, 1, 1.25, 0.75, 0.75, 1.5, 0.5], inf)),  //scaling can also be a pattern
    \dur, 0.125,
    \legato, 0.1,
    \atk, 0.01,
    \rel, 0.5,
    \pan, Pseq([-0.5, 0, 0.5], inf),
)).play;
)

//a third sequencer (kickdrum)
(
Pdef(\pat3, PmonoArtic(\avsynth,
    \freq, Pseq([50, 60], inf),
    \dur, 0.25,
    \legato, 0.01,
    \atk, 0,
    \rel, 0.1,
    \filtAmt, 100,  //careful. if you change these filter parameters to something crazy sound might explode
    \filtQ, 1,
    \amp, Pseq([0.4, 0.1], inf),
)).play;
)

(
Pdef(\pat3, PmonoArtic(\avsynth,
    \freq, Pseq([50, 60], inf),
    \dur, 0.25,
    \legato, 0.01,
    \atk, 0,
    \rel, 0.1,
    \filtAmt, Pseq([Pseq([1], 17), 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2]*100, inf),
    \filtQ, 1,
    \amp, Pseq([0.4, 0.1], inf),
)).play;
)

Pdef(\pat1).stop;
Pdef(\pat2).stop;
Pdef(\pat3).stop;
Pdef(\pat3).play;
Pdef(\pat2).play;
Pdef(\pat1).play;

//back to editing pat1
(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pstutter(2, Pseq([300, 500, 600, 700, Pstutter(4, Pseq([800], 1))], inf)),
    \detune, Pseq([0, 0, -10, 100, 0, 0, 0], inf),
    \dur, 0.125,
    \legato, Pseq([1, 0.1, 0.1], inf),  //added pattern for legato
    \atk, Pseq([0, 0, 0.1], inf),
    \rel, Pstutter(8, Pseq([0.5, 0.1], inf)),
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pstutter(2, Pseq([300, 500, 600, 700, Pstutter(4, Pseq([800], 1))], inf)),
    \detune, Pseq([0, 0, -10, 100, 0, 0, 0], inf),
    \dur, 0.125,
    \legato, Pseq([1, 0.1, 0.1], inf),
    \atk, Pseq([0, 0, 0.1], inf),
    \rel, Pstutter(8, Pseq([0.5, 0.1], inf)),
    \mod, 10,  //added modulator scaling
    \filtAmt, Pseq([Pseq([200], 6), 1000], inf),  //added filter parameter
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pstutter(2, Pseq([300, 500, 600, 700, Pstutter(4, Pseq([800], 1))], inf)),
    \detune, Pseq([0, 0, -10, 100, 0, 0, 0], inf),
    \dur, 0.125,
    \cur, 4,  //curvature for envelope
    \legato, Pseq([1, 0.1, 0.1], inf),
    \atk, Pseq([0, 0, 0.1], inf),
    \rel, Pstutter(8, Pseq([0.5, 0.1], inf)),
    \mod, 10,
    \filtAmt, Pseq([Pseq([200], 6), 1000], inf),
)).play;
)

//--effects
a.free; a= Synth(\avdist, [\in, 50, \dist, 40]);  //distorion on bus 50
b.free; b= Synth(\avverb, [\in, 60, \room, 10]);  //reverb on bus 60

(
Pdef(\pat2, PmonoArtic(\avsynth,
    \freq, Pseq([100, 200, 300, 300], inf)*Pstutter(8, Pseq([1, 1, 1, 1.25, 0.75, 0.75, 1.5, 0.5], inf)),  //scaling can also be a pattern
    \dur, 0.125,
    \legato, 0.1,
    \atk, 0.01,
    \rel, 0.5,
    \pan, Pseq([-0.5, 0, 0.5], inf),
    \out, 50,  //distort everything by sending to bus 50
)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pstutter(2, Pseq([300, 500, 600, 700, Pstutter(4, Pseq([800], 1))], inf)),
    \detune, Pseq([0, 0, -10, 100, 0, 0, 0], inf),
    \dur, 0.125,
    \cur, 4,  //curvature for envelope
    \legato, Pseq([1, 0.1, 0.1], inf),
    \atk, Pseq([0, 0, 0.1], inf),
    \rel, Pstutter(8, Pseq([0.5, 0.1], inf)),
    \mod, 10,  //added modulator scaling
    \filtAmt, Pseq([Pseq([200], 6), 1000], inf),
    \out, Pseq([60, 0, 0], inf),  //reverb on every third note
)).play;
)

(
Pdef(\pat3, PmonoArtic(\avsynth,
    \freq, Pseq([50, 200, 50, 2000], inf),  //change frequencies
    \dur, 0.125,
    \legato, 0.01,
    \atk, 0,
    \rel, 0.1,
    \filtAmt, Pseq([Pseq([1], 17), 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2]*100, inf),
    \filtQ, 0.05,
    \mod, 10,  //scale up modulation
    \amp, Pseq([0.4, 0.1], inf),
    \out, 50,  //distort
)).play;
)

//set effect parameters
a.set(\dist, 80);  //more distortion
a.set(\dist, 2);  //less distortion
b.free;  //turn off reverb
a.free;  //free distortion

Pdef(\pat1).stop;
Pdef(\pat2).stop;
Pdef(\pat3).stop;

//--something different
(
b.free; b= Synth(\avverb, [\in, 60, \room, 15]);
a.free; a= Synth(\avdist, [\in, 50, \dist, 30]);
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pseq([Pseq([300, 400, 200], 2), Pseq([600, 700], 2), 700], inf),
    \dur, Pseq([Pseq([0.125], 2), Pseq([0.125/4], 16)], inf),
    \atk, Pstutter(8, Pseq([0, 0, 0, 0.1, 0.1, 0.1, 0.2, 0.3, 1], inf)),
    \rel, 0.3,
    \legato, Pseq([0.1, 1, 1, 0.5, 1], inf),
    \out, Pseq([50, 0, 60, 50, 50], inf),
    \pan, Pseq([0.5, 0, -0.5], inf),
)).play;
)

//another thing
(
b.free; b= Synth(\avverb, [\in, 60, \room, 1]);
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pseq([400, 600, 700], inf),
    \dur, 0.25,
    \out, 60,
)).play;
Pdef(\pat2, PmonoArtic(\avsynth,
    \freq, Pseq([400, 600, 700, \rest], inf)*0.5,  //rests can be used in freq pattern
    \dur, 0.75,
    \legato, 0.25,
    \out, 60,
)).play;
)

//another
(
b.free; b= Synth(\avverb, [\in, 60, \room, 1]);
Pdef(\pat1, PmonoArtic(\avsynth,
    \freq, Pseq([1, 2, 3], inf)*400,
    \dur, 0.1,
    \amp, Pstutter(2, Pseq([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2, 1, Pseq([0], 16)], inf)*0.01),  //fade in/out
    \legato, 0.5,
    \rel, 3,
    \out, 60,
)).play;
Pdef(\pat2, PmonoArtic(\avsynth,
    \freq, Pstutter(Pseq([1, 2, 3, 4, 3, 2], inf), Pseq([400, 600, 700, 200], inf))*0.75*Pseq([0.5, 0.75, 1, 1, 1, 2], inf),
    \dur, 0.125/3*4,
    \atk, 0.001,
    \rel, 3*Pseq([1, 2, 3, 2, 1, 0.75, 0.5, 0.5, 0.5], inf),
    \mod, Pseq([0, 1, 0, 0, 10], inf),
    \pan, Pseq([0.5, -0.5], inf),
    \filtAmt, Pstutter(5, Pseq([200, 400, 500, 600, 700, 2000], inf))*2,
    \filtQ, Pstutter(5, Pseq([0.1, 0.05, 0.01], inf)),
    \filtLag, Pseq([0.1, 0, 0, 0], inf),
    \legato, Pseq([0.1, 0.2, 0.5, 2]*0.1, inf),
    \out, 0,
)).play;
)

//yet different - oneliners
(
b.free; b= Synth(\avverb, [\in, 60, \room, 1]);
a.free; a= Synth(\avdist, [\in, 50, \dist, 20]);
Pdef(\pat1, PmonoArtic(\avsynth, \freq, Pseq([400, 600, 700], inf), \legato, Pseq([0.5, 1.5], inf), \dur, 0.1)).play;
Pdef(\pat2, PmonoArtic(\avsynth, \freq, Pseq([Pseq([300, 400, 200], 2), 600, 700], inf), \legato, Pseq([0.5, 1.5], inf), \dur, 0.1)).play;
Pdef(\pat3, PmonoArtic(\avsynth, \freq, Pseq([Pseq([160], 16), Pseq([120], 32)], inf), \legato, 0.2, \dur, 0.1)).play;
)

(
Pdef(\pat1, PmonoArtic(\avsynth, \freq, Pseq([1, 2, 3, 4]*800, inf), \legato, Pseq([0.5, 0.9, 1.5], inf), \dur, 0.1, \amp, Pseq([0, 0, 1, 1, 1]*0.1, inf))).play;
Pdef(\pat2, PmonoArtic(\avsynth, \freq, Pseq([Pseq([300, 400, 200], 2), 600, 700], inf), \legato, Pseq([0.5, 1.5], inf), \dur, 0.1)).play;
Pdef(\pat3, PmonoArtic(\avsynth, \freq, Pseq([Pseq([160], 16), Pseq([120], 32)], inf), \legato, 0.2, \dur, 0.1, \out, Pseq([0, 0, 60], inf))).play;
)

(
Pdef(\pat3, PmonoArtic(\avsynth, \freq, Pseq([Pseq([160, 360, 400], 4), Pseq([120, Pseq([50, 60, 70]*5, 4)], 3)], inf), \legato, Pseq([0.2, 0.4, 0.1, 2], inf), \dur, 0.1, \out, Pseq([50, 0, 0, 0, 0, 60], inf), \pan, Pseq([-0.7, 0.7, 0], inf))).play;
)

//--things to explore
TempoClock.tempo= 0.9;
TempoClock.tempo= 0.8;
TempoClock.tempo= 0.7;

PdefAllGui();  //simple gui

Pdef(\pat1).fadeTime= 8;  //set crossfade time
Pdef(\pat2).fadeTime= 8;
Pdef(\pat3).fadeTime= 8;

Pdef(\pat1).quant= 4;  //start next 4/4 bar
Pdef(\pat2).quant= 4;
Pdef(\pat3).quant= 4;
Pdef(\pat3).stop;
Pdef(\pat2).stop;
Pdef(\pat1).stop;
Pdef(\pat3).play;
Pdef(\pat2).play;
Pdef(\pat1).play;

//etc. lots more to learn about pdef and patterns (Prand, Pwhite, Pseg)
