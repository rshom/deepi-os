#!/usr/bin/env python

import io
import socket
import struct
import numpy as np
from threading import Thread
import time                 

class FeedSocket(Thread):   

    def __init__(self,addr='raspberrypi.local',port=8000):
        Thread.__init__(self)                             
        self.addr = (addr,port)                           
        self.frame = None
        self.streaming = False

        self.sock = socket.socket()
        print("Connecting")
        self.sock.connect(self.addr)                                          
        self.conn = self.sock.makefile('rb')
        self.grabframe()        

    def grabframe(self):
        n = struct.calcsize('<L')
        sz = struct.unpack('<L',self.conn.read(n))[0]
        stream = io.BytesIO()           
        stream.write(self.conn.read(sz))
        stream.seek(0)
        self.frame = np.frombuffer(stream.read(),dtype=np.uint8)

    def run(self):
        self.streaming = True
        while self.streaming:
            self.grabframe()
        self.conn.close()
        self.sock.shutdown(1)
        self.sock.close()

    def stop(self):
        self.streaming = False
        self.join()



if __name__=='__main__':
    import cv2                                 
    feed = FeedSocket('raspberrypi.local',8000)

    print("Starting")
    feed.start()
    
    print("Ready")
    try:
        while feed.is_alive():
            img = cv2.imdecode(feed.frame,1)

            cv2.imshow("frame",img)
            if cv2.waitKey(1) == 27:
                print("Closing")
                break

    finally:
        feed.stop()
        cv2.destroyAllWindows() 
