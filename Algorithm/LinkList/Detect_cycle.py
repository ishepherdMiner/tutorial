# -*- coding=utf-8 -*-
# leetcode 单链表环
# https://leetcode.cn/problems/linked-list-cycle/description/
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def detectCycle(self,head):
        if head == None:
            return head

        slow,fast = head,head
        while fast != None:
            slow = slow.next
            if fast.next != None:
                fast = fast.next.next
            else:
                return None

            if fast == slow:
                ptr = head
                while ptr != slow:
                    ptr = ptr.next
                    slow = slow.next
                return ptr
        return None

head = ListNode(1)
p1 = ListNode(2)
p2 = ListNode(998)
p3 = ListNode(4)
p4 = ListNode(6)
p5 = ListNode(777)
p6 = ListNode(123)

head.next = p1
p1.next = p2
p2.next = p3
p3.next = p4
p4.next = p5
p5.next = p6
p6.next = p3

cycle_node = Solution().detectCycle(head)
if cycle_node:
    print(cycle_node.val)



