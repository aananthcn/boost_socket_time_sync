

win_client:
	g++ time_client.cpp -o time_client.exe -l boost_system-mt -l boost_iostreams-mt -l ws2_32 -l boost_chrono-mt -l boost_thread-mt

win_server:
	g++ time_server.cpp -o time_server.exe -l boost_system-mt -l boost_iostreams-mt -l ws2_32