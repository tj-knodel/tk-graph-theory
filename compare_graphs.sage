# file to compare graph files from complement_check vs known crit graphs

def compare_graphs(g1, g2):
    return g1.is_isomorphic(g2)

def compare_graph_lists(list1, list2):
    # if the lists are different sizes, then obviously the lists
    # are the not the same
    if (list1.len != list2.len):
        return False
    
    # loop over the two lists, stopping if we see two non-isomorphic graphs.
    for g1, g2 in zip(list1, list2):
        if not compare_graphs(g1, g2):
            return false;
    # if we've made it this far, they are the same
    return true

# simple unit test
def test_compare_graphs(expected, g1, g2):
    if (expected != compare_graphs(g1,g2)):
        print("Expected " + expected + " but got " + compare_graphs(g1,g2))
        return
    print("Passed")

g1 = graphs.PathGraph(4)
g2 = graphs.PathGraph(4)
test_compare_graphs(True, g1, g2)

g2 = graphs.PathGraph(3)
test_compare_graphs(False, g1, g2)

if len(sys.argv) <= 1:
	print("Usage: sage compare_graphs [file1] [file2]")
	sys.exit()

with open(sys.argv[1]) as f1, open(sys.argv[2]) as f2:
    for line1 in f1:
        print(line1)
        for line2 in f2:
            print(line2)
            print(compare_graphs(Graph(line1.strip()), Graph(line2.strip())))
            #if compare_graphs(Graph(line1), Graph(line2)):
            #    print(line1 + " = " + line2)
        f2.seek(0)
    #print("Graphs are isomorphic")


