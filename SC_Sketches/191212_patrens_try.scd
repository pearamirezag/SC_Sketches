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


a=Scale.minor;

(

Pdef(\pit1,
    Pbind(
        \instrument, \avsynth,
        \scale, a,
        \degree, Pseq([Pstutter(3,Pseq([0,2],2)), 0, 4, 6], inf),
        \dur, Pseq([0.5,0.13,0.13],inf),
        \filtAmt, Pseq([200,250,300,200], inf)
        )
    ).play;
)

(

Pdef(\pit,
    Pbind(
        \instrument, \avsynth,
        \scale, a,
        \degree, Pseq([Pseq([7,8],4), 0, 4, 6, 0,3,2], inf),
        \octave, Pstutter(4,Prand([3,4,5],inf)),
        \dur, Prand([0.13, 0.13, 0.25,0.13],inf),
        \legato, 0.7,
        \filtAmt, Pseq([200,250, 900, 950,700, 400,200], inf)
        )
    ).play;
)


Pdef(\put1).play;

Synth.new(\avsynth);
