
## Create app
### Build and run devbase docker image
```
docker build -f docker/Dockerfile.dev --target devtools -t pwa-react:devtools .
docker run --rm -it -p 3000:3000 -v .:/app -v pwa-react_docker-home:/home/node --name=pwa pwa-react:devtools
```


### Create react app

```
npx create-react-app pwa-app
npm install react-bootstrap bootstrap 
```


## Developer image

```
docker build -f docker/Dockerfile.dev -t pwa-react:dev .
docker run --rm -it -p 3000:3000 -v .:/app -v pwa-react_docker-home:/home/node --name=pwa pwa-react:dev
```


## Production image
```
docker build -f docker/Dockerfile.prod -t pwa-react:prod .
docker run --rm -it -p 3000:3000 --name=pwa pwa-react:prod
```


<!-- # Install Nerd Fonts on your local terminal
# sh -c '\
#     wget -P ~/Downloads \
#     https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf && \
#     wget -P ~/Downloads \
#     https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf && \
#     wget -P ~/Downloads \
#     https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf && \
#     wget -P ~/Downloads \
#     https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf && \
#     mkdir -p ~/.local/share/fonts/ && mv ~/Downloads/*.ttf ~/.local/share/fonts/ && \
#     fc-cache -f -v \
#     ' -->
