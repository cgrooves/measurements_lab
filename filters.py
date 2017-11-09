# -*- coding: utf-8 -*-
"""
Created on Thu Nov  2 10:06:40 2017

@author: pizzaslayer
"""
import numpy as np

class LPFilter:
    
    def __init__(self, fc, k):
        self.fc = float(fc)
        self.k = float(k)
        
    def magnitude(self, f):
        return 1/np.sqrt(1+(f/self.fc)**(2*self.k))
        
    def mag_dB(self, f):
        return 20*np.log10(self.magnitude(f))
        
    def error(self, f):
        return (self.magnitude(f) - 1.) * 100.
        

def choose_R(M,f,C):
    
    R = 1/(2*np.pi*C*np.sqrt(f**2/(1/M**2-1)))
    return R


if __name__ == "__main__":
    freq = [400, 500, 600]

    print "\n\n5th order Low Pass Filter Response\n"
    
    for f in freq:
        filter = LPFilter(500,5)
        print "Frequency %f Hz" % (f)
        print "Magnitude (linear): %f" % (filter.magnitude(f))
        print "Magnitude (dB): %f" % ( filter.mag_dB(f))
        print "Dynamic Error: %f" % (filter.error(f))
        print ""