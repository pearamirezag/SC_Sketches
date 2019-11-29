~noisies = Array.new;

~folder = PathName.new("C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/musicradar-contact-mic-madness-samples/Cymbal");

(
~folder.entries.do({
	arg path;
	~noisies = ~noisies.add(Buffer.read(s, path.fullPath));
});
)
~noisies[15].play;


BufFrames(1);

(
SynthDef.new(\samp, {
	arg out = 0, rate = 1, buf = 0, start, end;
	var sig, phases;
	phases = Phasor.ar(0,BufRateScale.kr(buf)*rate,start, end);
	sig = BufRd.ar(2, buf, phases);
	Out.ar(out, sig);
}).add;
)

x = Synth.new(\samp, [\buf, 20, \start, ~noisies[20].numFrames-1, \end, 0]);

x.set(\rate, -0.2);

s.freeAll;