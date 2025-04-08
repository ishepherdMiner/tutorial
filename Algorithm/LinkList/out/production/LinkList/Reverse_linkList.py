# -*- coding:utf-8 -*-

# 单链表的节点
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reverse(self,head):
        # 空链表/只有一个节点的链表
        if head is None or head.next is None:
            return head
            
        pre = None
        cur = head          # cur指向头节点
        node = head         # node指向头节点
        while cur:          # cur == False 说明到最后一个节点
            node = cur      # 0. 保存当前节点
            next = cur.next # 1. next指针指向下一个节点的地址
            cur.next = pre  # 2. 当前节点的next指向改为pre指针指向的地址 - 反转
            pre = cur       # 3. pre指针指向这一轮的当前节点即下一轮的上一个节点
            cur = next      # 4. cur指针指向这一轮的下一个节点即下一轮的当前节点
        return node

head = ListNode(1)
p1 = ListNode(2)
p2 = ListNode(998)
p3 = ListNode(4)
head.next = p1
p1.next = p2
p2.next = p3
p = Solution().reverse(head)
while p:
    print(p.val)
    p = p.next