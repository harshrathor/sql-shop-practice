from collections import Counter

def top_k_frequent(nums, k):
    frequency = Counter(nums)
    return [item for item, count in frequency.most_common(k)]

nums = [1, 1, 1, 2, 2, 3]
k = 2

print(top_k_frequent(nums, k))
