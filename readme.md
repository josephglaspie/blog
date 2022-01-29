# Blog with Hugo-Kiera

My cheatsheet for adding to the blog

1. Create new post  
   ` hugo new posts/example1.post.md`
1. Check that the site is working locally including drafts  
   `hugo server -D`
1. Ensure the draft is set to false to publish

1. Build out the static files  
   `hugo -t hugo-kiera`
1. Push the static files to the git pages  
   `./deploy.sh`

### TODO

- Setup Github Actions to auto deploy when changes are made to the public directory and pushed up
