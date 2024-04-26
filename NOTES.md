
## Create app
### Build and run devbase docker image
```
docker build -f docker/Dockerfile.dev --target devtools -t pwa-react:devtools .
docker run --rm -it -p 3000:3000 -v .:/app -v debian-devtools:/home/debian --name=pwa pwa-react:devtools
```


### Create react app

```
npx create-react-app pwa-app
npm install react-bootstrap bootstrap 
npm install react-router-dom
```



## Developer image

```
docker build -f docker/Dockerfile.dev -t pwa-react:dev .
docker run --rm -it -p 3000:3000 -v .:/app -v debian-devtools:/home/debian --name=pwa pwa-react:dev
```


## Production image
```
docker build -f docker/Dockerfile.prod -t pwa-react:prod .
docker run --rm -it -p 3000:3000 --name=pwa pwa-react:prod
```
