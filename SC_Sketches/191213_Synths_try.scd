s.boot;

p = ProxySpace.push(s);
m = ProxyMixer(p, 8);

s.scope;

{SinOsc.ar(4)%SinOsc.ar(3)}.play;

~wuy = {SinOsc.ar(440)|SinOsc.ar(400)};
~wuy = {SinOsc.ar(440)%SinOsc.ar(400)};
~wuy = {SinOsc.ar(4)%SinOsc.ar(3)!2};
~wuy = {arg freq = 4;Saw.ar(freq!2)};
~wuy1 = {arg freq = 4;Saw.ar(freq!2)};
~wuy2 = {arg freq = 4, pan = 0;Pan2.ar(Saw.ar(freq), pan)};

~wuy.fadeTime = 5;
~wuy1.set(\freq, 11);
~wuy.set(\freq, 14.8);
~wuy2.set(\freq, ~lfo1);
~wuy2.set(\pan, ~lfo1);



~lfo2 = {LFNoise0.kr(10,1200, 2000)};

~lfo1 = {LFNoise0.kr(2, 15, 1)};
~lfo1.scope;

~lfo2.scope;

~out = ~wuy%~wuy1;
~out = ~wuy%~wuy1%~wuy2;
~out = ~wuy|~wuy1;
~out = {arg freq = 400; Resonz.ar(~wuy2, freq)};

~out.set(\freq, ~lfo2);


~out.play;


~out.play;

~wuy.play;
~wuy.free;
~wuy1.free;


s.record(duration:10);

Quarks.gui;
