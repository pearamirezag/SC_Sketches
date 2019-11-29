Pbind(\degree, 1).play;

Pbind(\degree, 3, \dur, 0.2).play;

Pbind(
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], inf),
	\dur, Pseq([0.2, 0.5, 2, 0.4, 0.1, 0.5], inf)
).play;

(
Pbind(
\degree, Pseq([0, −1, 2, −3, 4, −3, 7, 11, 4, 2, 0, −3], 5),
\dur, Pseq([0.2, 0.1, 0.1], inf),
\amp, Pseq([0.7, 0.5, 0.3, 0.2], inf),
\legato, 0.8
).play;

)

(
Pbind(
\degree, Prand([2, 3, 4, 5, 6], inf),
\dur, Prand([2, 1, 0, 0.05, 0.08],inf),
\amp, Prand([0.2, 0.5, 0.1, 0, 0.05, 0.08],inf),
\legato, Pseq([2, 1, 0, 0.05, 0.8, 0.08],inf)
).play;
)

(
Pbind(
\freq, Pwhite(100, 500),
\dur, Prand([2, 1, 0, 0.05, 0.8],inf),
\amp, Prand([0.2, 0.5, 0.1, 1, 0.05, 0.08],inf),
\legato, Pseq([2, 1, 0.3, 0.05, 0.8, 0.08],inf)
).trace.play;
)

//Pser
(
Pbind(
	\note, Pser([0, 2, 3, 5, 7, 8, 11, 12], 11),
	\dur, 0.15;
).trace.play;
)