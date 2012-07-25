# hump.camera

Original LOVE thread: [link] (https://love2d.org/forums/viewtopic.php?f=5&t=10124)

This is an edit of vrld's camera module. See for details: [HUMP] (http://vrld.github.com/hump/)

It requires the shapes module from vrld to work! See for details: [Hardon Collider] (http://vrld.github.com/HardonCollider/index.html)

This version allows each camera object to have a custom shape. This allows you to limit drawing operations to the shape's boundary. The function to create a new camera object has a new argument to determine its shape. Shapes must be convex to work properly.

````lua
newCamera = require 'camera'
cam1 = newCamera(shape,x,y,r,sx,sy) -- where shape is a shape defined by the shapes module
````

## Camera Functions

You can transform the scene like the original module with the camera's methods. There are also some new functions to play with:

**Note that `camera.zoom` was removed and is now replaced with `camera.sx`,`camera.sy`**

`camera:setScale(sx,sy)` sets the scene's scale, sy is equal to sx if omitted

`camera:scale(sx,sy)` scales the scene by this amount, sy is equal to sx if omitted

`camera:worldContains(x,y)` returns `true` if your scene's point is within the shape.

`camera:worldBbox()` returns `x1,y1,x2,y2`, which are the scene's coordinates of your viewport's axis aligned bounding box. `(x1,y1)` and `(x2,y2)` are the opposite vertices of the box.

`camera:worldIntersectsRay(x,y,dx,dy)` returns `true` if your scene's ray is intersecting your shape.

## Shape Functions

Using the shape's methods for each camera object allows you to manipulate its shape without transforming the scene. There also two new methods for each shape:

`camera.shape:setScale(s)` sets the absolute scale of the shape.

`camera.shape:getScale(s)` returns the absolute scale of the shape.

## Example

````lua
shapes = require'shapes'
cam = require'camera'

-- create a new camera object
-- Whence created, the camera will have a circular shape at point (0,0) with radius = 100. The camera will also center on point (10,10) in the scene. 
cam1 = cam(10,10,1,0,shapes.newCircleShape(0,0,100))

-- move the camera 10 units along the x-axis, and increase the size of the shape
cam1.shape:move(10,0), cam1.shape:scale(2)

-- move the scene 10 units along the y-axis, and rotate the scene
cam1:move(0,10), cam1.r = cam1.r + math.pi
````

## Demos

LOVE demo's can be found in the downloads section.