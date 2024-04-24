
## Create app
### Build and run devbase docker image
```
docker build --target devbase -t pwa-react:devbase .
docker run --rm -it -p 3000:3000 -v .:/home/node/app --name=pwa pwa-react:devbase
```


### Create react app

```
npx create-react-app pwa-app
npm install react-bootstrap bootstrap 
```


## Developer image

```
docker build --target development -t pwa-react:dev .
docker run --rm -it -p 3000:3000 -v .:/home/node/app -v /home/node/app/node_modules --name=pwa pwa-react:dev
```





