#!/bin/zsh
#
# https://github.com/ineo6/hosts/blob/master/src/constants.ts
#
# https://rubyfish.cn/dns-query?name=www.google.com&type=A
# http://dns.alidns.com/resolve?name=github.com&type=1&short=1
# curl http://ip-api.com/json/github.com | jq '.query'
# dog -q raw.github.com -t A -n 1.1.1.1 --short
# https://github.com/ogham/dog/releases/download/v0.1.0/dog-v0.1.0-x86_64-unknown-linux-gnu.zip

local urls=(
  "github.com" 
  "raw.githubusercontent.com"
  "user-images.githubusercontent.com"
  "favicons.githubusercontent.com"
  "avatars5.githubusercontent.com"
  "avatars4.githubusercontent.com"
  "avatars3.githubusercontent.com"
  "avatars2.githubusercontent.com"
  "avatars1.githubusercontent.com"
  "avatars0.githubusercontent.com"
  "avatars.githubusercontent.com"
  # "raw.github.com" 
  # "github.githubassets.com"
  # "central.github.com"
  # "desktop.githubusercontent.com"
  # "assets-cdn.github.com"
  # "camo.githubusercontent.com"
  # "github.map.fastly.net"
  # "github.global.ssl.fastly.net"
  # "gist.github.com"
  # "github.io"
  # "api.github.com"
  # "codeload.github.com"
  # "githubstatus.com"
  # "github.community"
  # "media.githubusercontent.com"
  # "objects.githubusercontent.com"
  # "copilot-proxy.githubusercontent.com"
  # "github-cloud.s3.amazonaws.com"
  # "github-com.s3.amazonaws.com"
  # "github-production-release-asset-2e65be.s3.amazonaws.com"
  # "github-production-user-asset-6210df.s3.amazonaws.com"
  # "github-production-repository-file-5c1aeb.s3.amazonaws.com"
)

local dns_list=(
  8.8.8.8
  223.5.5.5
  8.8.8.8
  114.114.114.114
  180.76.76.76
  119.29.29.29
  1.1.1.1
  199.85.126.10
  208.67.222.222
  84.200.69.80
)
local dns=$dns_list[2]
local min=9999
testDns() {
  for i ($dns_list) {
    local ttl=$(dog $urls[1] --json -n $i | jq '.responses[0].answers[0].ttl' || 9999)
    if [[ $ttl -lt $min ]] {
      min=$ttl
      dns=$i
    }
  }
}

local result
local out_file=output.log
getIp() {
  echo -n >! $out_file
  echo "# use dns $dns $(date '+%Y-%m-%d %H:%M:%S')" >> $out_file
  for i ($urls) {
    # local ip=$(dog -1 -n $dns $i)
    local adr=$(dog $i --json -n $dns  | jq '.responses[0].answers[0].address')
    # result+="${adr//\"}\t$i\n"
    result="${adr//\"}\t$i"
    echo $result >> $out_file
  }
  # echo $result
  # echo $result >> $out_file
}

# testDns
getIp
