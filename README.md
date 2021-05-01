# photo_manager_migration
Flutter PhotoManager Migration Issue Demo

In photo_manager version 0.5.8, the memory usage does not exceed 300MB.
![0.5.8](https://user-images.githubusercontent.com/26322627/116773846-30c40800-aa93-11eb-89df-c1c74e6eb325.png)

But version 0.6.0, the memory usage is close to 700MB and sometimes OOM occurs.
![0.6.0](https://user-images.githubusercontent.com/26322627/116773848-33266200-aa93-11eb-9ab6-c6369f0fdefc.png)

|0.5.8|0.6.0|
|:-:|:-:|
|fast|slow|
|<video src="https://user-images.githubusercontent.com/26322627/116774005-4dad0b00-aa94-11eb-866c-f74c1dbc6eb2.MP4" />|<video src="https://user-images.githubusercontent.com/26322627/116774009-57cf0980-aa94-11eb-922b-077edc22d814.MP4"/>|

test device : iPhone 8
