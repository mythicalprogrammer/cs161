CXX	= g++
CXXFLAGS= -g -W -Wall -Werror -ansi -pedantic
PROGRAM	= cache
OBJS	= cache.o main.o

$(PROGRAM): $(OBJS)
	$(CXX) $^ -o $@

%.o: %.cc
	$(CXX) $(CXXFLAGS) -c -g  $<

clean:
	rm -f *~ *.o $(PROGRAM)

