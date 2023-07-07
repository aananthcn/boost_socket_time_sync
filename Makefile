
.DEFAULT_GOAL := all


ifeq ($(OS),Windows_NT)
	target_os := windows
else
	target_os := linux
endif



win_client:
	g++ time_client.cpp -o time_client.exe -l boost_system-mt -l boost_iostreams-mt -l ws2_32 -l boost_chrono-mt -l boost_thread-mt

win_server:
	g++ time_server.cpp -o time_server.exe -l boost_system-mt -l boost_iostreams-mt -l ws2_32



linux_client:
	g++ time_client.cpp -o time_client.exe -l boost_system -l boost_iostreams -l boost_chrono -l boost_thread

linux_server:
	g++ time_server.cpp -o time_server.exe -l boost_system -l boost_iostreams


windows:
	$(MAKE) win_client
	$(MAKE) win_server

linux:
	$(MAKE) linux_client
	$(MAKE) linux_server


all:
	@echo Building for ${target_os}....
	$(MAKE) ${target_os}