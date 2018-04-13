# Create 10 linearly spaced arrangements of rectangles, then rotate them.
 
import bpy
import numpy
import mathutils
import math
 
context = bpy.context
scene = context.scene
 
f = 2;
# Nanofin Dimensions
L = 0.3;                                         # length of nanofin
W = 0.1;                                          # width of nanofin
H = 0.8;
 
NUM = 20; # Number of pillars per side
 
# One way of producing angles; DOES NOT abide by the Phase Profile Equation
fit = 360/(NUM-1)
angles = numpy.zeros((NUM,NUM))
for i in range(0,NUM-1):
    angles[i,:] = numpy.linspace(i*fit, 360+i*fit, NUM)
 
     
# Plane/ Substrate
bpy.ops.mesh.primitive_cube_add(location = (0,0,-0.2))
cube = context.active_object
cube.scale[0] = NUM/2
cube.scale[1] = NUM/2
cube.scale[2] = 0.2
cube.name = "Substrate"
 
for r in numpy.linspace(1,5,5): 
    #3rd parameter determines the number of rings
    x = numpy.linspace(-r, r, 5*r) 
    #3rd parameter determines the number of pillars per ring
    #3rd parameter also determines the discretization of i
    #the higher the 3rd parameter, the more pillars & less distinct difference in angle
    #
     
    # Debugging Statements
    #print(r)
    #print(type(r))
    #print(x)
    #print(type(x))
    for i in x:
        #print(type(i))
        y = round(numpy.sqrt(r**2-i**2),3)
        z = H
        #print(y)
        #print(type(y))
        bpy.ops.mesh.primitive_cube_add(location=(i,y,z))
        cube = context.active_object
        cube.scale[0] = L
        cube.scale[1] = W
        cube.scale[2] = H
     
        angle = 2*numpy.pi - 2*numpy.pi/0.532 * (numpy.sqrt(i**2+y**2+f**2)-f)
        cube.rotation_euler[2] = angle/2
         
        y = numpy.sqrt(r**2-i**2) * -1 # negative solutions
        bpy.ops.mesh.primitive_cube_add(location = (i,y,z))
        cube = context.active_object
        cube.scale[0] = L
        cube.scale[1] = W
        cube.scale[2] = H
         
        angle = 2*numpy.pi - 2*numpy.pi/0.532 * (numpy.sqrt(i**2+y**2+f**2)-f)
        cube.rotation_euler[2] = angle/2
 
 
'''
for i in range(0,NUM-1):
    for j in range(0,NUM-1):
        x = i
        y = j
        z = H
        bpy.ops.mesh.primitive_cube_add(location=(x,y,z))
        cube = context.active_object
        cube.scale[0] = L
        cube.scale[1] = W
        cube.scale[2] = H
        #cube.rotation_euler[2] = angles[i,j]
         
        #Using Phase Profile Equation with assumptions xf = 0, yf = 0, zf = f
        angle= 2*numpy.pi - (2*numpy.pi/0.532 * (numpy.sqrt((x)**2 + (y)**2 + (z-f)**2)-f));
        cube.rotation_euler[2] = angle/2
        #cube.
        scene.objects.link(cube)
'''
