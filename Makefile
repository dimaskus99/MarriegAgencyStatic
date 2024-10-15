CXX = g++
CXXFLAGS = -Wall -std=c++11
TARGET = bin/agency
LIBNAME = libagency.a

INCDIR = include
LIBDIR = lib
SRCDIR = src

OBJS = $(SRCDIR)/main.o $(LIBDIR)/$(LIBNAME)

all: $(TARGET)

$(LIBDIR)/$(LIBNAME): $(SRCDIR)/Client.o $(SRCDIR)/Database.o
	ar rcs $(LIBDIR)/$(LIBNAME) $(SRCDIR)/Client.o $(SRCDIR)/Database.o

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS) -L$(LIBDIR) -lagency

$(SRCDIR)/main.o: $(SRCDIR)/main.cpp $(INCDIR)/Client.h $(INCDIR)/Database.h
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/main.cpp -I$(INCDIR) -o $(SRCDIR)/main.o

$(SRCDIR)/Client.o: $(SRCDIR)/Client.cpp $(INCDIR)/Client.h
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/Client.cpp -I$(INCDIR) -o $(SRCDIR)/Client.o

$(SRCDIR)/Database.o: $(SRCDIR)/Database.cpp $(INCDIR)/Database.h $(INCDIR)/Client.h
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/Database.cpp -I$(INCDIR) -o $(SRCDIR)/Database.o

clean:
	rm -f $(SRCDIR)/*.o $(TARGET) $(LIBDIR)/$(LIBNAME)
