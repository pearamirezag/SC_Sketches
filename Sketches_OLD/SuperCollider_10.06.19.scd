Server.local.boot;



x = {SinOsc.ar(220*SinOsc.kr(0.5))};

y = x.play;

y.free;




(
z = {arg freq=440, harme = 4;
	var sig;
	sig = Blip.ar(freq, harme)
}.play;
)

z.play;
z.set(\freq, 220);
z.set(\freq, 120);
z.set(\harme, 8);
z.set(\freq, 80);
z.free;


(
v = {arg mod;
	var sig, out;

	// now for a twist
	(
		a = Signal.fill(256, { |i|
			    var t = i/255.0;
			    t + (0.1 * (max(t, 0.1) - 0.1) * sin(2pi * t * 80 + sin(2pi * 25.6 * t)))
		})
	);

	//a.plot;

	d = (a.copy.reverse.neg) ++(Signal[0])++ a;

	//d.plot;

	//d.size    //must be buffer size/2 + 1, so 513 is fine

	b.sendCollection(d.asWavetableNoWrap);  // may also use loadCollection here

	//b.plot; // wavetable format!


	mod = MouseY.kr(0.1,2, 0, 0.9);
	sig = Crackle.ar(mod, 0.5);
	out = Shaper.ar( b, sig,0.9)
}.play;
)

v.play;
v.free;



b = Buffer.alloc(s, 512, 1, { |buf| buf.chebyMsg([1,0,1,1,0,1])});

(
{
    Shaper.ar(
        b,
        SinOsc.ar(300, 0, Line.kr(0,1,6)),
        0.5
    )
}.scope;
)