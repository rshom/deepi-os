#! /usr/bin/env python3
'''Socket server creates a socket and waits for a connection

Combine this with socketserver.service
'''
import io
import socket
import struct
import time
from threading import Thread
from picamerax import PiCamera
from time import sleep


class SplitFrames(object):
    '''Records video but splits at each frame
    
    See picamerax recipes
    '''

    def __init__(self, connection):
        self.connection = connection
        self.stream = io.BytesIO()
        self.count = 0
        
    def write(self, buf):
        if buf.startswith(b'\xff\xd8'):
            # Start of new frame; send the old one's length then the
            # data
            size = self.stream.tell()
            if size > 0:
                self.connection.write(struct.pack('<L', size))
                self.connection.flush()
                self.stream.seek(0)
                self.connection.write(self.stream.read(size))
                self.count += 1
                self.stream.seek(0)
        self.stream.write(buf)

if __name__=='__main__':

    addr = '0.0.0.0'            # accept all addresses
    port = 8000

    resolution = 'VGA'
    framerate = 30

    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.bind((addr,port))
        print("Waiting for connection...")
        sock.listen(0)
        conn = sock.accept()[0].makefile('wb')
        output = SplitFrames(conn)
        print('Connection opened')
        with PiCamera(resolution=resolution,framerate=framerate) as camera:
            sleep(2)
            camera.start_recording(output, format='mjpeg')
            while True:
                camera.wait_recording(1)

