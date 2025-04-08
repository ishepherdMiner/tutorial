import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

 class ListNode {
     int val;
     ListNode next;
     ListNode() {}
     ListNode(int val) { this.val = val; }
     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 }


/**
 * 反转单链表
 * https://leetcode.cn/problems/UHnkqh/description/
 */
class Solution {
    /**
     *  用4个指针
     *  pre  指向上一个
     *  cur  指向当前
     *  next 指向下一个
     *  node 链表
     *  每次cur.next指向pre的指向后,再用pre指向当前节点,cur指向下一个节点
     */
    public static ListNode reverse(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }
        ListNode node = null;
        ListNode pre = null;
        ListNode cur = head;
        ListNode next = head.next;
        while (cur != null) {
            node = cur;
            next = cur.next;
            cur.next = pre;
            pre = cur;
            cur = next;
        }
        return node;
    }

    /**
     * 用栈实现,先入栈,然后再出栈即可
     */
    public static ListNode reverse_stack(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }
        ListNode node = head;
        Stack<ListNode> list = new Stack<ListNode>();
        ArrayList<ListNode> result = new ArrayList<ListNode>();
        while (head != null) {
            list.push(head);
            head = head.next;
        }

        ListNode cur = null;
        while(list.size() > 0) {
            ListNode newNode = list.pop();
            if (cur == null) {
                cur = newNode;
                head = newNode;
            } else {
                newNode.next = null;
                cur.next = newNode;
                cur = newNode;
            }
        }

        return head;
    }


    public static void main(String[] args) {
        ListNode head = new ListNode(1);
        ListNode p1 = new ListNode(2);
        ListNode p2 = new ListNode(998);
        ListNode p3 = new ListNode(4);
        head.next = p1;
        p1.next = p2;
        p2.next = p3;
        ListNode list = Solution.reverse(head);
        // ListNode list = Solution.reverse_stack(head);
        while (list != null) {
            System.out.println(list.val);
            list = list.next;
        }
    }
}