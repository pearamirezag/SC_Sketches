{LFSaw.ar(1)}.play //non-band limited
{Saw.ar(1)}.play  //band limited - not generating frequencies >22050 (half s.r.)

{Limiter.ar(Saw.ar(1)%Saw.ar(8))}.play
{Limiter.ar(Saw.ar(1)|Saw.ar(8))}.play
{Limiter.ar(Saw.ar(1)<Saw.ar(8))}.play
{Limiter.ar(Saw.ar([1, 1.1])<Saw.ar(8))}.play
{Limiter.ar(Saw.ar(1)&Saw.ar(8))}.play
{sin(Saw.ar(1)+Saw.ar(8)+Saw.ar(0.25))}.play
{Limiter.ar(Saw.ar(8, SinOsc.ar([50, 51])))}.play
{Limiter.ar(Saw.ar(8, Saw.ar([50, 51])))}.play

{Limiter.ar(Saw.ar(100)*Saw.ar(8)%Saw.ar(1.25))}.play
{Limiter.ar(Saw.ar(-8)*Saw.ar([50, 51]))}.play
{Limiter.ar(Saw.ar(-8)%Saw.ar([50, 51]))}.play
{Limiter.ar(Saw.ar(-8)%Saw.ar([50, 51])%Saw.ar(5))}.play
{sin(Saw.ar(0.1)+Saw.ar(0.2)+Saw.ar(0.3)+Saw.ar(0.4)+Saw.ar(0.5))}.play
{cos(Saw.ar(0.1)+Saw.ar(0.2)+Saw.ar(0.3)+Saw.ar(0.4)+Saw.ar(0.5))}.play

{LFPulse.ar}.plot //non-band limited
{Pulse.ar}.plot  //band limited

{Limiter.ar(Pulse.ar(1)%Pulse.ar(10000))}.play
{Limiter.ar(Pulse.ar([1,0.9])*Pulse.ar(10000))}.play
{sin(Pulse.ar(1.5)+Pulse.ar(1.4)+Pulse.ar(1.3)+Pulse.ar(1.2)+Pulse.ar(1.1))}.play


{Limiter.ar(GlitchBPF.ar(Saw.ar([500, 600]), -2, 1000))}.play
{Limiter.ar(FreeVerb.ar(GlitchBPF.ar(Saw.ar, Saw.ar(1), SinOsc.ar([0.4, 0.5])*2000)))}.play
{Limiter.ar(GlitchRHPF.ar(SinOsc.ar(1000), Saw.ar(8)*2, SinOsc.ar([4.01, 3.06])*2000))}.play

{GlitchRHPF.ar(GbmanN.ar([2300,1150]),LFSaw.ar(Pulse.ar(4,[1,2]/8,1,LFPulse.ar(1/8)/5+1))+2)}.play//#SuperCollider

{SinOsc.ar(0.1, GlitchRHPF.ar(SinOsc.ar(MouseY.kr(1, 9999, 1), 2pi), 1/MouseX.kr(1, 99, 1), 4), 1)!2}.play

{LeakDC.ar(Saw.ar(0.1, GlitchRHPF.ar(Saw.ar(MouseY.kr(1, 9999, 1), 2pi), 1/MouseX.kr(1, 99, 1), 4), 1)!2)}.play

{Limiter.ar(MoogFF.ar(Saw.ar(10), 500000*Saw.ar(3), 4*Saw.ar(2.01)))}.play


({GlitchRHPF.ar(
    BrownNoise.ar([1,1]),
    LFSaw.kr(FSinOsc.kr(0.06,0.7,0.15),0.79,LFSaw.kr(0.06,1,2)),
    FSinOsc.kr(FSinOsc.kr(0.3,0.5,0.49),0.5,0.5)
).clip2(0.6)}.play)
