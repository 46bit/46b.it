provider "aws" { }

resource "aws_key_pair" "miki" {
  key_name   = "miki-ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKtCTZlqBtE2vxnh5VEMKFgCqTaHKPsAT83DruEDlrZou38mQkfkxMzE87DKqhyT2u6zwdxA8GZx54SQgWaO8Bi51mvfn380FdgXjG6ngIS0WkCK6W8ginujRp9TiOjzO2YKNy0wxCJLgLXP5keZfnt/5qyhXDZkKEYDG9lQYpZQo7r+9/GxcB7OCofMAr7ANbCj9ujxVIilqx96Lg0TIhMPgqwdlw+ktyIu1tRZnptcisxeholXwZ27t7FLG5ebtb06OJSPwc/G0avzEmMjQLRDIL5biI0wsBNJqPxC70VUSAnrrI/gTQSb48ZkfR7UeUO9voHt5KM0yZ0imGw9/5 fortysix@electryon"
}
