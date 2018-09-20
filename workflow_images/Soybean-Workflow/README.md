## Soybean-Workflow

### How to run

First, you must run the container

```
docker run -d --rm -it --name soybean soybean
```

Next, you must enter the container. You can confirm that you are inside of the container by the prompt

```
root@docker-instance:~# docker exec -ti -u workflow:workflow soybean bash
workflow@a0f861e6fbc4:~$ 
workflow@a0f861e6fbc4:~$ cd soykb/
workflow@a0f861e6fbc4:~/soykb$ ./workflow-generator --exec-env distributed
```

And follow the instructions of Pegasus