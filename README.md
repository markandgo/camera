# hump.camera ##########

Original LOVE thread: [link] (https://love2d.org/forums/viewtopic.php?f=5&t=10124)

This is an edit of vrld's camera module. See for details: [HUMP] (http://vrld.github.com/hump/)

You can use the shapes module from vrld to augment the camera! See for details: [Hardon Collider] (http://vrld.github.com/HardonCollider/index.html)

This version allows each camera object to have an *optional* shape, which limits drawing operations to the shape's boundary by using stencils **+0.8.0**. The function to create a new camera object has a new argument to determine its shape.

````lua
new		= require 'camera'
camera	= new(shape,x,y,r,sx,sy,kx,ky) -- where shape is a shape defined by the shapes module
````

To use the camera module without the shapes module, omit the shape argument:

````lua
new		= require 'camera'
camera	= new(x,y,r,sx,sy,kx,ky)
````

You can add/remove/change a shape at anytime by changing `camera.shape` value. Some functions are not available when shapeless.

## New Functions ##########

**`camera.zoom` has been replaced with `camera.sx` and `camera.sy`**

You can transform the scene like the original module with the camera's methods. The following functions are new:

-------------------
`camera:setScale(sx,sy)` 

Arguments:

**number** `sx` `sy` 

Scales to set along the x and y axis. Shortcut for `camera.sx = sx` `camera.sy = sy`

Returns:

**nothing**

-------------------
`camera:scale(sx,sy)`

Arguments:

**number** `sx` `sy` 

Scale factors along the x and y axis. Shortcut for `camera.sx = camera.sx*sx` `camera.sy = camera.sy*sy`

Returns:

**nothing**

-------------------
`camera:setShear(kx,ky)` 

Arguments:

**number** `kx` `ky` 

Set shear factors along the x and y axis. Shortcut for `camera.kx = kx` `camera.ky = ky`

Returns:

**nothing**

-------------------
`camera:shear(kx,ky)`

Arguments:

**number** `kx` `ky` 

Shear factors along the x and y axis. Shortcut for `camera.kx = camera.kx*kx` `camera.ky = camera.ky*ky`

Returns:

**nothing**

## New Queries ##########

**Not available when shapeless**

`contain = camera:worldContains(x,y)` 

Arguments:

**number** `x` `y` 

Coordinates of the point in the scene

Returns:

**boolean** `contain`

True if the camera's shape contains the scene's point

-------------------
`x1,y1,x2,y2 = camera:worldBbox()` 

Arguments:

**nothing**

Returns:

**number** `x1,y1,x2,y2`

The upper left (x1,y1) and lower right vertices (x2,y2) of the shape's bbox in scene coordinates

-------------------
`intersect = camera:worldIntersectsRay(x,y,dx,dy)` 

Arguments:

**number** `x,y,dx,dy` 

The origin and direction of the ray

Returns:

**boolean** `intersect` 

true if the scene's ray intersects the camera's shape


## Example ##########

````lua
shapes = require'shapes'
cam = require'camera'

-- create a new camera object
-- Whence created, the camera will have a circular shape at point (0,0) with radius = 100. The camera will also center on point (10,10) in the scene. 
cam1 = cam(shapes.newCircleShape(0,0,100),10,10,0,1)

-- move the camera 10 units along the x-axis, and increase the size of the shape
cam1.shape:move(10,0), cam1.shape:scale(2)

-- move the scene 10 units along the y-axis, and rotate the scene
cam1:move(0,10), cam1.r = cam1.r + math.pi
````

## Demos

LOVE demo's can be found in the downloads section.