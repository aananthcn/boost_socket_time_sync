
.DEFAULT_GOAL := all


ifeq ($(OS),Windows_NT)
	target_os     := Windows
	CLIENT_LFLAGS := -l boost_system-mt -l boost_iostreams-mt -l ws2_32 -l boost_chrono-mt -l boost_thread-mt
	SERVER_LFLAGS := -l boost_system-mt -l boost_iostreams-mt -l ws2_32
else
	target_os     := Linux
	CLIENT_LFLAGS := -l boost_system -l boost_iostreams -l boost_chrono -l boost_thread -l pthread
	SERVER_LFLAGS := -l boost_system -l boost_iostreams -l pthread
endif


%.o: %.cpp
	g++ -c -o $@ $^

client_objs := \
		time_client.o

server_objs := \
		time_server.o


time_client.exe: ${client_objs}
	@echo Building time_client for ${target_os}....
	g++ ${client_objs} -o $@ ${CLIENT_LFLAGS}

time_server.exe: ${server_objs}
	@echo Building time_server for ${target_os}....
	g++ ${server_objs} -o $@ ${SERVER_LFLAGS}


targets := time_client.exe time_server.exe

all: ${targets}
	@echo Build complete!

clean:
	$(RM) ${targets} ${client_objs} ${server_objs}