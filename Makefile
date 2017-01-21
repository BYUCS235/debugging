CFLAGS=-std=c++11 -g

debug: debug.cpp
	g++ $(CFLAGS) debug.cpp -o debug
