import unittest
from app import get_transactions, net_change


class TestTransactions(unittest.TestCase):
    def test_transactions_for_account(self):
        self.assertEqual(len(get_transactions("1001")), 2)

    def test_net_change(self):
        self.assertEqual(net_change("1001"), 3800)

    def test_unknown_account(self):
        self.assertEqual(get_transactions("9999"), [])
        self.assertEqual(net_change("9999"), 0)


if __name__ == "__main__":
    unittest.main()
