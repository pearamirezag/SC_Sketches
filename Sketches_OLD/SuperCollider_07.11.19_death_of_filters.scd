(
 {
	var sig;
	sig = WhiteNoise.ar(0.7)!2;
	sig = BPF.ar(sig, MouseX.kr(-1000,20000).poll,MouseY.kr(1, -1000));
	sig = LeakDC.ar(sig).tanh * 0.5;

}.play;
)

s.boot;