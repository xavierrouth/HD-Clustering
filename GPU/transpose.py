import csv 

cluster_result = open('cluster_results.csv', newline='')
train_labels = open('train_labels.csv', newline='')

cluster_reader = csv.reader(cluster_result, delimiter=',', quotechar='|')
train_reader = csv.reader(train_labels, delimiter=',', quotechar='|')

cluster_list = list(cluster_reader)
train_list = list(train_reader)

print (len(train_list[0]))
print (len(cluster_list[0]))
for i in range(6238):
    print(train_list[0][i], cluster_list[0][i])
