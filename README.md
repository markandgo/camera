# hump.camera ##########

Original LOVE thread: [link] (https://love2d.org/forums/viewtopic.php?f=5&t=10124)

This is an edit of vrld's camera module. See for details: [HUMP] (http://vrld.github.com/hump/)

You can use the shape class from vrld to augment the camera! See for details: [Hardon Collider] (http://vrld.github.com/HardonCollider/index.html)

This version allows each camera object to have an *optional* shape, which limits drawing operations to the shape's boundary by using stencils **+0.8.0**. The function to create a new camera object has a new argument to determine its shape.

````lua
new     = require 'camera'
camera  = new(shape,x,y,r,sx,sy)

-- no shape
camera  = new(x,y,r,sx,sy)
````

You can add/remove a shape at anytime by changing `camera.shape` value. Some functions are not available when shapeless.

## Functions ##########

**camera.rotate**`(self,phi)`

**camera.rotateTo**`(self,phi)`

**camera.move**`(self,dx,dy)`

**camera.moveTo**`(self,x,y)`

**camera.setScale**`(self,sx,sy or sx)`

**camera.scale**`(self,sx,sy or sx)`

**camera.attach**`(self)`
Apply camera transformation

**camera.detach**`(self)`
Remove camera transformation

**camera.draw**`(self,func)`  
Same as:
````lua
camera:attach()
func()
camera:detach()
````
**camera.worldCoords**`(self,x,y)`

**camera.cameraCoords**`(self,x,y)`

**camera.mousePos**`(self)`

## Extra Functions ##########

**Not available when shapeless**

`boolean`     = **camera.worldContains**`(self,x,y)` 

`x1,y1,x2,y2` = **camera.worldBbox**`(self)` 

`x1,y1,x2,y2` = **camera.bbox**`(self)` 

`boolean`     = **camera.intersectsWorldRay**`(self,x,y,dx,dy)` 