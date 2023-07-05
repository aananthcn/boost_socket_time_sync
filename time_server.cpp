#include <ctime>
#include <iostream>
#include <string>
#include <boost/asio.hpp>


using boost::asio::ip::tcp;

std::string make_daytime_string() {
	using namespace std; // for time_t, time, and ctime;
	time_t now = time(0);
	return ctime(&now);
}


int main() {
	try {
		boost::asio::io_context io_context;

		// A ip::tcp::acceptor object needs to be created to listen for new connections. 
		// It is initialised to listen on TCP port 13, for IP version 4.
		tcp::acceptor acceptor(io_context, tcp::endpoint(tcp::v4(), 13));

		for (;;) {
			tcp::socket socket(io_context);
			acceptor.accept(socket); // wait for the connection

			// A client is accessing our service. Determine the current time and transfer this information to the client. 
			std::string message = make_daytime_string();

			boost::system::error_code ignored_error;
			boost::asio::write(socket, boost::asio::buffer(message), ignored_error);
		}
	}

	catch (std::exception& e) {
		std::cerr << e.what() << std::endl;
	}

	return 0;
}


