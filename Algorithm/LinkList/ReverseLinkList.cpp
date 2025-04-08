#include <iostream>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
public:
    ListNode* reverseList(ListNode* head) {
        if(head == nullptr || head->next == nullptr) {
            return head;
        }
        
        ListNode *prev = nullptr;
        ListNode *cur = head;
        ListNode *next = head->next;
        ListNode *node = head;
        while(cur != nullptr) {
            node = cur;
            next = cur->next;
            cur->next = prev;
            prev = cur;
            cur = next;
        }
        return node;
    }
};

int main() {
    ListNode *head = new ListNode(1);
    head->next = new ListNode(2);
    head->next->next = new ListNode(3);
    head->next->next->next = new ListNode(4);
    Solution s = Solution();
    ListNode *result = s.reverseList(head);
    while(result != nullptr) {
        cout << result->val << " ";
        result = result->next; // Move to the next node in the reversed list
    }
}

