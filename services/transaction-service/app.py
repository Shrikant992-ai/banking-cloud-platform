import json
from http.server import BaseHTTPRequestHandler, HTTPServer

TRANSACTIONS = [
    {"id": "T1", "account_id": "1001", "type": "credit", "amount": 5000},
    {"id": "T2", "account_id": "1001", "type": "debit", "amount": 1200},
    {"id": "T3", "account_id": "1002", "type": "debit", "amount": 300},
]


def get_transactions(account_id):
    return [t for t in TRANSACTIONS if t["account_id"] == account_id]


def net_change(account_id):
    total = 0
    for t in get_transactions(account_id):
        total += t["amount"] if t["type"] == "credit" else -t["amount"]
    return total


class Handler(BaseHTTPRequestHandler):
    def _send(self, code, body):
        data = json.dumps(body).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def do_GET(self):
        if self.path == "/health":
            self._send(200, {"status": "ok", "service": "transaction-service"})
        elif self.path.startswith("/transactions/"):
            account_id = self.path.split("/")[-1]
            self._send(200, {
                "account_id": account_id,
                "transactions": get_transactions(account_id),
                "net_change": net_change(account_id),
            })
        else:
            self._send(404, {"error": "not found"})


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", 5002), Handler).serve_forever()
