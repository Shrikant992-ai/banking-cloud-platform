import json
from http.server import BaseHTTPRequestHandler, HTTPServer

ACCOUNTS = {
    "1001": {"id": "1001", "owner": "Asha Patil", "type": "savings", "balance": 52000},
    "1002": {"id": "1002", "owner": "Ravi Kulkarni", "type": "current", "balance": 18500},
}


def get_account(account_id):
    return ACCOUNTS.get(account_id)


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
            self._send(200, {"status": "ok", "service": "account-service"})
        elif self.path.startswith("/accounts/"):
            account = get_account(self.path.split("/")[-1])
            if account:
                self._send(200, account)
            else:
                self._send(404, {"error": "account not found"})
        else:
            self._send(404, {"error": "not found"})


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", 5001), Handler).serve_forever()
