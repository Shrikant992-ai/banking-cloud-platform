import unittest
from app import get_account


class TestAccounts(unittest.TestCase):
    def test_existing_account(self):
        self.assertEqual(get_account("1001")["owner"], "Asha Patil")

    def test_missing_account(self):
        self.assertIsNone(get_account("9999"))


if __name__ == "__main__":
    unittest.main()
