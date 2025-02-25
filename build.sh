VERSION=$1

export GOOS=linux
export GOARCH=amd64
export CGO_ENABLED=0
export GO111MODULE=on

go build -v -a -tags netgo -o release/linux/amd64/drone-npm

docker build   --label org.label-schema.build-date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")   --label org.label-schema.vcs-ref=$(git rev-parse --short HEAD)   --file docker/Dockerfile.linux.amd64 --tag jinbangyi/plugins-npm:$VERSION .

docker push jinbangyi/plugins-npm:$VERSION
