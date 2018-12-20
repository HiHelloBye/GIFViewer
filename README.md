# GIFViewer
Read Gif file from default album application.


<div>
<img width="200" src="https://user-images.githubusercontent.com/28393778/50256525-00d3b700-043a-11e9-85bd-595e14044b0d.jpg"></img>
<img width="200" src="https://user-images.githubusercontent.com/28393778/50256552-1f39b280-043a-11e9-85a9-8294f4cc597f.gif"></img>
</div>
<br>

<h3> You need CocoaPods! </h3>  
<h4> -Installation</h4>

  1.   open your Terminal
```c
$ sudo gem install cocoapods
```
  2. enter the project path you want to apply the Cocoapods library.
```c
$ pod init
```
  3. and then you can see the Podfile in your project folder.  
     Editing this Podfile, you can download libraries. 
     <br>
     (I use vi command, but you can also use the nano command.)  
```$ nano Podfile ```
```$ vi Podfile ```     

  4.  You can write the desired library in the source code 'target 'CocoaPodsTest' do ~.  
```c
target 'MyApp' do   
  pod 'FLAnimatedImage', '~> 1.0'  
  pod 'PinterestLayout'
 end
``` 
<br>

5. Save your Podfile.  
   Run  ``` $ pod install ```  
   Open the MyApp.xcworkspace.



