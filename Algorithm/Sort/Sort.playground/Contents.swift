import Foundation

/**
 冒泡排序
 算法步骤
 1.比较相邻元素：从列表的第一个元素开始，比较相邻的两个元素。
 2.交换位置：如果前一个元素比后一个元素大，则交换它们的位置。
 3.重复遍历：对列表中的每一对相邻元素重复上述步骤，直到列表的末尾。
 这样，最大的元素会被"冒泡"到列表的最后。
 4.缩小范围：忽略已经排序好的最后一个元素，重复上述步骤，直到整个列表排序完成。
 
 // inout:值类型以引用方式传递
 平均时间复杂度: O(n^2)
 最好情况: O(n)   正序(从小到大)
 最坏情况: O(n^2) 逆序
 排序方式: 原地排序
 */
func bubbleSort(arr: inout [Int]) {
    for i in 0..<arr.count - 1 {
        // -i 已排序部分不需要再参与下一轮
        // flag 用于提前退出
        var flag = false
        for j in 0..<arr.count - 1 - i {
            if arr[j] > arr[j+1] {
                arr.swapAt(j, j+1)
                flag = true
            }
        }
        if !flag {
            break
        }
    }
}

/**
 插入排序
 算法步骤
 1.初始化：将列表分为已排序部分和未排序部分。初始时，已排序部分只包含第一个元素，未排序部分包含剩余元素。
 2.选择元素：从未排序部分中取出第一个元素。
 3.插入到已排序部分：将该元素与已排序部分的元素从后向前依次比较，找到合适的位置插入。
 4.重复步骤：重复上述步骤，直到未排序部分为空，列表完全有序。
 */
func insertionSort(arr: inout [Int]) {
    for i in 1..<arr.count {
        let temp = arr[i]
        // 30, 56, 76, 26, 18, 56, 4, 50, 21, 83, 45
        // for i in 1..<10
        // i = 1; 30认为是有序的,待排序的元素从56开始
        // reversed() 说明从后往前比较
        // for j in 0, j = 0
        // arr[j] = 30 不满足 arr[j] > temp => 结束循环
        // i = 2; temp = 76 同样不需要交换就可以结束循环
        // i = 3; temp = 26
        // for j in 2,1,0
        // arr[j] = 76 76 > 26 => 76和26交换 30,56,26,76
        // arr[j] = 56 56 > 26 => 56和26交换 30,26,56,76
        // 因为只有比待排序的元素大时才交换,所以每次j+1就是待排序的元素,被排到前一个位置
        for j in (0..<i).reversed() {
            if arr[j] > temp {
                arr.swapAt(j, j+1)
            }
        }
    }
}

/**
 选择排序
 
 算法步骤
 1.初始化：将列表分为已排序部分和未排序部分。初始时，已排序部分为空，未排序部分为整个列表。
 2.查找最小值：在未排序部分中查找最小的元素。
 3.交换位置：将找到的最小元素与未排序部分的第一个元素交换位置。
 4.更新范围：将未排序部分的起始位置向后移动一位，扩大已排序部分的范围。
 5.重复步骤：重复上述步骤，直到未排序部分为空，列表完全有序。
 */
func selectionSort(arr: inout [Int]) {
    for j in 0..<arr.count - 1 {
        var minIndex = j
        // 每次都找最小的索引值,然后和当前遍历的索引进行交换
        for i in j..<arr.count {
            if arr[minIndex] > arr[i] {
                minIndex = i
            }
        }
        arr.swapAt(j, minIndex)
    }
}

/**
 希尔排序
 
 算法步骤
 1.选择增量序列：选择一个增量序列（gap sequence），用于将列表分成若干子列表。常见的增量序列有希尔增量（n/2, n/4, ..., 1）等。
 2.分组插入排序：按照增量序列将列表分成若干子列表，对每个子列表进行插入排序。
 3.缩小增量：逐步缩小增量，重复上述分组和排序过程，直到增量为 1。

 最终排序：当增量为 1 时，对整个列表进行一次插入排序，完成排序
 最坏情况: O(n^2) 当增量序列选择不当时
 最好情况: O(nlogn) 当增量序列选择合适时
 平均情况: O(nlogn)到O(n^2)之间
 */
func shellSort(arr: inout [Int]) {
    // [11, 55, 24, 64, 79, 98, 25, 65, 72, 52, 17]
    // n = 10,gap = 5 10个元素 分成5组
    // gap > 0
    // 遍历 5..<10
    // i = 5,temp = 98
    let n = arr.count
    var gap = n % 2
    while gap > 0 {
        for i in gap..<n {
            let temp = arr[i]
            var j = i
            // 在子列表找合适的位置插入
            while j >= gap && arr[j - gap] > temp {
                arr[j] = arr[j - gap]
                j -= gap
            }
            arr[j] = temp
        }
        gap = gap / 2
    }
}

func quickSort(arr: [Int]) -> [Int] {
    guard arr.count > 1 else {
        return []
    }
    
    // 选择基准元素
    let pivot = arr[arr.count - 1]
    
    // 分区: 小于基准的元素放在左侧,大于基准的元素放在右侧
    var leftArr:[Int] = []
    var rightArr:[Int] = []
    for x in 0..<arr.count - 1 {
        if arr[x] <= pivot {
            leftArr.append(arr[x])
        } else {
            rightArr.append(arr[x])
        }
    }
    // 递归排序并合并
    return quickSort(arr: leftArr) + [pivot] + quickSort(arr: rightArr)
}

func testSort () {
    // 生成随机数数组进行排序操作
    var list:[Int] = []
    for _ in 0...10 {
        list.append(Int(arc4random_uniform(100)))
    }
    print("原始:\(list)")
    // bubbleSort(arr:&list)
    // insertionSort(arr: &list)
    // selectionSort(arr: &list)
    // shellSort(arr: &list)
    list = quickSort(arr: list)
    print("排序:\(list)")
    
}

testSort()

