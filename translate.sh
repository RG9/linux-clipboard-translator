#!/bin/sh

urlencode() {
  printf %s "$1" | jq -s -R -r @uri
}

source_language=$1 #e.g. "de"
target_language=$2 #e.g. "en"
translated_words_file_path='./translated_words.txt'

clipboard=$(xclip -o) #get clipboard content

search_result=$(grep "$clipboard" $translated_words_file_path) #was it previously searched?
if [ "$search_result" != "" ]; then
    xmessage -center "$search_result" #if translation exists, show it in popup
    exit 1	
fi

echo "$clipboard [] - " >> $translated_words_file_path #save word to file for further notes

encoded=$(urlencode "$clipboard") #encoding clipboard to put in URL
xdg-open "https://translate.google.com/#${source_language}/${target_language}/${encoded}" #open Google Translation in web browser
