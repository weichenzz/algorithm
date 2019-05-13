//
//  LinearSort.swift
//  Sort
//
//  Created by ggl on 2019/5/7.
//  Copyright © 2019 ggl. All rights reserved.
//

import Foundation

/// 桶排序
func bucketSort(_ array: [Double]) -> [Double] {
    if array.isEmpty {
        return array
    }
    
    // 1.遍历数组得到最大值和最小值
    var max = array[0]
    var min = array[0]
    for num in array {
        if num > max {
            max = num
        }
        
        if num < min {
            min = num
        }
    }
    
    // 2.分桶
    // 桶的区间划分（这里桶的数量与元素数量相同
    // 区间跨度 = (最大值 - 最小值) / (桶的数量)
    // Int类型区域跨度以及数组下标求法：
    //    跨度=(max-min)/bucketNum + 1
    //    下标=(num-min)/跨度
    // Double类型区域跨度以及数组下标求法：
    //    跨度=(max-min)/Double(bucketNum)
    //    下标=(num-min-1)/跨度
    let bucketNum = array.count
    let d = (max - min) / Double(bucketNum)
    var bucketTotalArray = [[Double]]()
    for _ in 0..<bucketNum {
        let bucketArray = [Double]()
        bucketTotalArray.append(bucketArray)
    }
    
    // 3.遍历原始数组，将元素放入对应的桶中，并进行排序
    for num in array {
        let n = Int((num - min - 1) / d)
        bucketInnerSort(&bucketTotalArray[n], num: num)
    }
    
    // 4.将排序好的桶元素输出到一个数组中
    var sortedArray = [Double]()
    for bucketArray in bucketTotalArray {
        sortedArray.append(contentsOf: bucketArray)
    }
    
    return sortedArray
}

/// 桶排序内部排序算法（采用插入排序思想）
///
/// - Parameters:
///   - array: 需要插入元素的桶数组
///   - num: 需要插入的元素
func bucketInnerSort(_ array: inout [Double], num: Double) {
    for i in (0..<array.count).reversed() {
        let sortedNum = array[i]
        if sortedNum > num {
            continue
        }
        array.insert(num, at: i+1)
        return
    }
    array.insert(num, at: 0)
}

//MARK: - Counting Sort
/// 计数排序
/// 计数排序只能用在数据范围不大的场景中，数据范围如果比要排序的数据大很多，就不适合用计数排序(数据要有重复)
/// 计数排序只能给非负整数排序，其他类型的话，需要将其在不改变相对大小的情况下，转换为非负整数
func countingSort(_ array: [Int]) -> [Int] {
    if array.count <= 1 {
        return array
    }
    
    // 查找数组中的数据范围
    var max = array[0]
    for num in array {
        if num > max {
            max = num
        }
    }
    
    // 计算每个元素的个数，放入数组中
    var countingArray = [Int](repeating: 0, count: max+1)
    for num in array {
        countingArray[num] += 1
    }
    print(countingArray)
    
    // 依次累加数据
    for i in 1..<countingArray.count {
        countingArray[i] += countingArray[i-1]
    }
    print(countingArray)
    
    // 从后往前遍历，将数据输出到排序数组中
    var sortArray = [Int](repeating: 0, count: array.count)
    for num in array.reversed() {
        let index = countingArray[num] - 1
        sortArray[index] = num
        countingArray[num] -= 1
    }
    
    return sortArray
}

//MARK: - Radix Sort
/// 基数排序
/// 10万个手机号码从小到大排序，手机号码有11位，范围太大，不适用于桶排序、计数排序
/// 手机号码规律：比较两个手机号码a,b大小，如果在前面几位中，a手机号码已经比b手机号码大，那后面的几位就不用看了
/// 需要注意，按照每位来排序的排序算法要是稳定的
/// 根据每一位来排序，可以使用桶排序或者计数排序，它们的时间复杂度O(n)。如果要排序的数据有K位，那么我们就需要K次桶排序
/// 或者计数排序，总的时间复杂度是O(k*n)
func radixSort(_ array: [String]) -> [String] {
    return []
}
