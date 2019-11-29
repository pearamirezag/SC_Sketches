s.boot;

~b0 = Buffer.read(s, "C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/bus-air-brake-a.wav");


~b0.read("C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/bus-air-brake-a.wav");


~b1 = Buffer.read(s, "C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/chain-door-squeak.wav");



~b2 = Buffer.read(s, "C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/van-sliding-door.wav");


~b0.play;
~b1.play;
~b2.play;

~b0.zero;

//FRAMES
~b0.numFrames;       //

//CHANNELS
~b0.numChannels;        //stereo or not

numSamples = numFrames * numChannels

~b4 = Buffer.readChannel(s, "C:/Users/Admin/Desktop/VALE_PEDRO/PEDROALEJANDRO/SuperCollider/soundfiles/subverse-sexy.wav");

s.meter;


//DURATION
~b0.duration;

//BUFFER NUMBERS (bufnum)
~b0.bufnum;
~b1.bufnum;
~b2.bufnum;

//BUFFER SAMPLE RATE
~b0.sampleRate;


