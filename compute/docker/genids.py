f = open("/etc/subuid", "a+")
start = 1000

for uid in range(start, 65536):
    f.write("%d:%d:65536\n" %(uid,uid*65536))
f.close()

f = open("/etc/subgid", "a+")
for uid in range(start, 65536):
    f.write("%d:%d:65536\n" %(uid,uid*65536))
f.close()