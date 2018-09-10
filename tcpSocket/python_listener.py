"""
Listens for network communication from MaxScript.

From:
	http://techarttiki.blogspot.com/2009/12/maxscript-dotnet-sockets-with-python.html

Thanks to all who posted in the "dotNet + MXS" thread on CGTalk.
	http://forums.cgsociety.org/showthread.php?f=98&t=551473
The info there put me on the right trail to making this work.

Adam Pletcher, Technical Art Director, Volition/THQ
	adam.pletcher@gmail.com
	http://techarttiki.blogspot.com
	http://www.volition-inc.com
"""

import wx
import wx.lib.newevent

import socket
import threading

class Socket_Listen_Thread( threading.Thread ):
	"""
	Creates a socket listener on a separate thread.  Useful for listening for updates in
	a wx tool, leaving it free in the main loop to process the UI main loop.

	*Arguments:*
		* ``window``		The window object for the tool.  Typically this is the frame, or "self".
		* ``event_class``	The class of the custom wx event to post when a socket update is received.

	*Keyword Arguments:*
		* ``port``			TCP/IP port to listen on.
		* ``buffer_size``	Size of data buffer to read from socket.  Generally you want this to be
								a power of two, larger than the largest data message you'll receive.
	"""
	def __init__( self, port = 5432, buffer_size = 512 ):
		threading.Thread.__init__( self )

		# Window to post event to later
		# self.window = window
		# self.event_class = event_class
		self.buffer_size = buffer_size
		self.data_ = ""

		# Set up our socket
		self.socket = socket.socket( socket.AF_INET, socket.SOCK_STREAM )
		self.socket.bind( ( '', port ) )
		self.socket.listen( 5 )
		self.socket.setblocking( False )

		self.running = False

	def run( self ):
		self.running = True

		while ( self.running ):
			# Starting server...
			# Listen for connection.  We're in non-blocking mode so it can
			# check for the signal to shut down from the main thread.
			try:
				client_socket, clientaddr = self.socket.accept( )
				data_received = True
			except socket.error:
				data_received = False

			if ( data_received ):
				# Set new client socket to block.  Otherwise it will inherit
				# the non-blocking mode of the server socket.
				client_socket.setblocking( True )

				# Connection found, read its data then close
				data = client_socket.recv( self.buffer_size )
				client_socket.close( )

				# Create wx event and post it to our app window
				# event = self.event_class( data = data )
				# wx.PostEvent( self.window, event )
				# self.data_ = data
				# print data
				exec(data)


	def stop( self ):
		self.running = False

		if ( self.socket ):
			self.socket.close( )


# class Tool_Frame( wx.Frame ):
# 	"""
# 	"""
# 	def __init__( self, parent, title ):
# 		wx.Frame.__init__( self, parent, -1, title, pos=(150, 150), size=(350, 100) )
# 		self.SetBackgroundColour( ( 200,200,200 ) )

# 		# Create a new Event class and a EVT binder function
# 		( Max_Update_Event, EVT_3DS_MAX_UPDATE ) = wx.lib.newevent.NewEvent( )

# 		# CONTROLS
# 		self.st_text1		= wx.StaticText( self, -1, "Selected Objects:" )
# 		self.tc_obj_names = wx.TextCtrl( self, -1, '', size=(300, -1) )

# 		self.main_sizer = wx.BoxSizer( wx.VERTICAL )

# 		self.main_sizer.Add( self.st_text1, 0, wx.ALL, 5 )
# 		self.main_sizer.Add( self.tc_obj_names, 0, wx.ALL, 5 )

# 		# Create instance of our listener thread, and start it running
# 		self.max_monitor = Socket_Listen_Thread( self, Max_Update_Event )
# 		self.max_monitor.start( )

# 		# EVENT BINDINGS
# 		self.Bind( wx.EVT_CLOSE, self.on_close )

# 		# Bind handler to our custom event
# 		self.Bind( EVT_3DS_MAX_UPDATE, self.on_3ds_max_update )

# 		# FINAL SETUP
# 		self.SetSizer( self.main_sizer )
# 		self.Layout( )

# 	def on_3ds_max_update( self, event ):
# 		"""
# 		Event handler for our custom Max_Update_Event, setting the text control's
# 		value to the data received.  Which in this case is a string containing the names
# 		of the objects selected in 3ds Max.
# 		"""
# 		self.tc_obj_names.SetValue( event.data )

# 	def on_close( self, event ):
# 		"""
# 		Tells the listener thread to stop, then unregisters the Max callback.
# 		"""
# 		# Stop the socket listening thread
# 		self.max_monitor.stop( )

# 		self.Destroy( )

### MAIN ###
if (__name__ == '__main__'):
	# wx_app = wx.App( redirect=False )

	# frame	= Tool_Frame( None, 'Test Frame' )

	# frame.Show( True )
	# wx_app.MainLoop( )

	s = Socket_Listen_Thread()
	s.start()
	# s.stop()

