



2.rand
2.0.rand
2.rand2
rrand(2,4)

[3,6,8,19].choose

15.0.linrand

Array.fill(1000,{linrand(1.0)}).sort.plot //see this visually by creating 1000 numbers using this generator, sorting them in order, then plotting the results

1.0.bilinrand //similar, goes between positive and negative 1.0, more weight towards 0 in all cases


Array.fill(1000,{bilinrand(1.0)}).sort.plot //see this visually

1.0.sum3rand //sum of 3 uniform random numbers between plus and minus 1.0 (will come out with more chance of numbers nearer 0, since values can cancel between positive and negative; in general, a sum of distributions tends to a centre-weighted normal distribution)



Array.fill(1000,{sum3rand(1.0)}).sort.plot //see this visually

//show similarity

Array.fill(1000,{({1.0.rand2}!3).sum * 0.33}).sort.plot //see this visually by creating 1000 numbers using this generator, sorting them in order, then

exprand(1.0,10.0)	//uniform choice, but over an exponentially mapped range, more likely to choose low

Array.fill(1000,{exprand(1.0,10.0)}).sort.plot

Array.fill(1000,{gauss(0.0,1.0)}).sort.plot //see this visually

[60,62,64,67].wchoose([0.5, 0.25, 0.2, 0.05]) //the first array is the array of options; the second is the array of weights

Array.fill(1000,{ [60,62,64,67].wchoose([0.5, 0.25, 0.2, 0.05]) }).sort.plot(minval:50, maxval:72) //see this visually



0.5.coin //fair coin, equal chance of heads or tails: true or false as output

0.2.coin //unfair coin, 20% chance true

0.95.coin //unfair coin, 95% chance true

//1st order Markov system example

(

var markovmatrix;

var currentstate=3.rand; //start in one of three states



markovmatrix= [

[0.7,0.2,0.1],

[0.0,0.5,0.5],

[0.3,0.4,0.3]

];





{

	20.do{

			Synth(\acsound,[\freq, [48,60,64].at(currentstate).midicps]);



			//which probability distribution to use depends on what state we're in right now

			currentstate = [0,1,2].wchoose(markovmatrix[currentstate]);



			0.25.wait;

			};



}.fork;

)


// run this line

a = Pbind.new.play(quant:1.0);



a.stop;		// Or stop it with cmd+period;



// now run this line

Pbind(\freq, 440).play(quant:1.0);



// run this, go back and run some of the others at the same time

(

Pbind(

	\dur,0.125,

	\midinote, Pseq([0, 4, 0, 7, 4, 0, 0] + 60,inf),

	\amp, Prand([0.125, 0.2, 0.25],inf)

).play(quant:1.0)

)

(

Pbind(

	\freq, 460		// try changing me to another number!

).play;

)

Togg


(

Pbind(

	\freq, Pseq([100,200,300],inf)       // try a different list

).play;

)


Pwrand([0,1,2,3], [0.5,0.3,0.1,0.1], 1)

[Streams]
