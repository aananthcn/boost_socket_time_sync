#include <iostream>
#include <boost/array.hpp>
#include <boost/asio.hpp>
#include <boost/chrono.hpp>
#include <boost/thread/thread.hpp>

using boost::asio::ip::tcp;


int time_sync(int argc, char *argv[]) {
	try {
		boost::asio::io_context io_context;

		tcp::resolver resolver(io_context);
		tcp::resolver::results_type endpoints = resolver.resolve(argv[1], "daytime");

		tcp::socket  socket(io_context);
		boost::asio::connect(socket, endpoints);

		for (;;) {
			boost::array<char, 128> buf;
			boost::system::error_code error;

			size_t len = socket.read_some(boost::asio::buffer(buf), error);

			if (error == boost::asio::error::eof) {
				break;
			}
			else if (error) {
				throw boost::system::system_error(error); // some other error
			}

			std::cout.write(buf.data(), len);
		}
	}

	catch (std::exception &e) {
		std::cerr << e.what() << std::endl;
	}

	return 0;
}


int main(int argc, char *argv[]) {
	if (argc != 2) {
		std::cerr << "Usage: client <host>" << std::endl;
		return 1;
	}

	for (;;) {
		time_sync(argc, argv);
		boost::this_thread::sleep(boost::posix_time::seconds(1));
	}
}