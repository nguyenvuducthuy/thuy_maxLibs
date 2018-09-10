/*
mxs_socket struct allows network communication with other tools via dotnet socket.
The rest of this scripts shows how to do something useful with that using
a MaxScript callback.

From:
	http://techarttiki.blogspot.com/2009/12/maxscript-dotnet-sockets-with-python.html

Thanks to all who posted in the "dotNet + MXS" thread on CGTalk.
	http://forums.cgsociety.org/showthread.php?f=98&t=551473
The info there put me on the right trail to making this work.

Example usage:
	socket = mxs_socket port:1234 ip_address:"123.45.67.8"
	result = socket.send "One, two, five!  Three sir!  Three!"
	format "result = % bytes sent\n" result

Adam Pletcher, Technical Art Director, Volition/THQ
	adam.pletcher@gmail.com
	http://techarttiki.blogspot.com
	http://www.volition-inc.com
*/

struct mxs_socket (
	ip_address	= "192.168.1.6",		-- "localhost" is also valid for same machine
	port			= 2323,				-- override this to your favorite integer

	-- <dotnet socket>connect <string>ip_string <int>port_int
	--
	-- Description:
	-- Takes IP address, port and connects to socket listener at that address
	fn connect ip_string port_int = (
		socket = dotNetObject "System.Net.Sockets.Socket" ( dotnetclass "System.Net.Sockets.AddressFamily" ).InterNetwork ( dotnetclass "System.Net.Sockets.SocketType" ).Stream ( dotnetclass "System.Net.Sockets.ProtocolType" ).Tcp
		socket.Connect ip_string port_int

		socket	-- return
	),

	-- <int>send <string>data
	--
	-- Description:
	-- Converts a string (or any object that can be converted to a string) to dotnet ASCII-encoded byte
	-- sequence and sends it via socket.  Uses ip_address and port defined in struct above, or set by client.
	---Returns integer of how many bytes were sent.
	fn send data = (
		-- Convert string to bytes
		ascii_encoder = dotNetObject "System.Text.ASCIIEncoding"
		bytes = ascii_encoder.GetBytes ( data as string )

		-- Connect, send bytes, then close
		socket = connect ip_address port
		result = socket.Send bytes		-- result is # of bytes sent
		socket.Close()

		result	-- return # of bytes sent
	),

	fn receive = (
	    dotNetIPAddress = (DotNetClass "System.Net.IPAddress").Parse ip_address
	    tcpListener = DotNetObject "System.Net.Sockets.TcpListener" dotNetIPAddress port
	    tcpListener.Start()
	    msgReceived = ""
	    print ("listening on " + (ipAddress as string) + ":" + (port as string))
	    while true do
	    (
	        print("waiting for a client socket")
	        socket = tcpListener.AcceptSocket()
	        print("client socket accepted")
	        while msgReceived != "exit" do
	        (
	            sendByteStream = DotNetObject "System.Byte[]" 10000
	            socket.Receive sendByteStream
	            encoding = DotnetClass "System.Text.UTF8Encoding"
	            msgReceived = trimright (encoding.UTF8.GetString(sendByteStream))

	            if msgReceived == "socketClosing" then (
	                print("closing socket")
	                socket.Close()
	                exit
	            )
	            else (
	                if msgReceived != "" then (
	                    print("execute : " + msgReceived)
	                    -- execute msgReceived
	                    try(
	                        result = execute(msgReceived)
	                    ) catch (
	                        error_str = "***" + getCurrentException() +"***\n" 
	                        print(error_str)
	                    )
	                    -- send result
	                    ascii_encoder = dotNetObject "System.Text.ASCIIEncoding"
	                    bytes = ascii_encoder.GetBytes (result as string)
	                    result = socket.Send bytes
	                )
	            )
	        )
	    )
	)
)

-- send_obj_names
--
-- Description:
-- Send commad-delineated list of object name strings to listener on port 5432.
fn send_obj_names = (
	obj_names = ""
	for obj in selection do (
		obj_names += obj.name + ", "
	)
	try (
		socket = mxs_socket port:5432	-- port # must match one used by listener
		socket.send obj_names
	) catch (
		format "Socket server not responding.  Try again later.\n"
		-- Due to the timeout delay when server isn't responding, you may want to put a callbacks.removeScripts
		-- here in the catch, to disable the callback until it's re-registered again.  Traditionally the tool script/code
		-- would be telling Max (over COM) to register/unregister the callback when the tool opens and closes.
		-- I skipped that step here to keep it simple.
	)
)

-- format "Setting up socket callback..."
-- callbacks.removescripts #selectionSetChanged id:#socket_test
-- callbacks.addscript #selectionSetChanged "send_obj_names()" id:#socket_test
-- format "done\n"


msg =
"
import sys
path = r'D:\Dropbox\anhungxadieu_3d\3dsmax\maxscripts\thuy_maxLibs\tcpSocket'
if path not in sys.path:
	sys.path.append(path)
import anhungxadieu
reload(anhungxadieu)
anhungxadieu.run()
"





for o in selection do(
	msg = StringStream ""
	for i=1 to 3 do format "%," o.pos[i] to:msg
	socket = mxs_socket port:5432
	socket.send (msg as string)
)

-- fn BackgroundTcpListenerDoWork theSender theEvent =
-- (
--     port = 5431
--     try (
--         socket = mxs_socket port:port
-- 		socket.receive()
--         exit
--     )
--     catch(
--         print("server crashed or port " + (port as string) + " is already used")
--     )
-- )

-- BackgroundWorker = DotNetObject "System.ComponentModel.BackgroundWorker"
-- DotNet.AddEventHandler BackgroundWorker "DoWork" BackgroundTcpListenerDoWork
-- BackgroundWorker.WorkerSupportsCancellation = true
-- BackgroundWorker.RunWorkerAsync()

