CFLAGS=-std=c++11 -g


pinewood: pinewood.o Race.o Car.o Panda.o Rocket.o
	g++ $(CFLAGS) pinewood.o Race.o Car.o Panda.o Rocket.o -o pinewood
	
pinewood.o: pinewood.cpp Race.h
	g++ $(CFLAGS) -c pinewood.cpp
		
Race.o: Race.cpp Race.h CarInterface.h Rocket.h Panda.h RaceInterface.h Car.h
	g++ $(CFLAGS) -c Race.cpp

Car.o: Car.cpp Car.h CarInterface.h 
	g++ $(CFLAGS) -c Car.cpp
		
Panda.o: Panda.cpp Panda.h Car.h CarInterface.h 
	g++ $(CFLAGS) -c Panda.cpp
		
Rocket.o: Rocket.cpp Rocket.h Car.h CarInterface.h 
	g++ $(CFLAGS) -c Rocket.cpp
debug: debug.cpp
	g++ $(CFLAGS) debug.cpp -o debug
clean:
	rm pinewood.o Race.o Car.o Panda.o Rocket.o