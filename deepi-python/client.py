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
        self.frame = np.empty((640,480), dtype=np.uint8)  
        self.streaming = False
        self.sock = socket.socket()
        self.sock.connect(self.addr)                                          
        self.conn = self.sock.makefile('rb')            
        self.start()

    def run(self):                                                           
        try:
            while True:
                n = struct.calcsize('<L')
                sz = struct.unpack('<L',self.conn.read(n))[0]
                stream = io.BytesIO()           
                stream.write(self.conn.read(sz))
                stream.seek(0)
                self.frame = np.frombuffer(stream.read(),dtype=np.uint8)

        finally:             
            self.conn.close()
            sock.shutdown(1)
            sock.close()
            self.join()








class CtlSocket():                             
    pass                                       

if __name__=='__main__':                       
    import cv2                                 
    feed = FeedSocket('raspberrypi.local',8000)
    while feed.is_alive():
        print(feed.frame)
    #     cv2.imshow(cv2.imdecode(feed.frame,1))
    #     cv2.waitKey(1)
    # cv2.destroyAllWindows() 
