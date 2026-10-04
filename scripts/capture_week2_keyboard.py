"""Run the real Android keyboard test and capture the whole emulator display."""
import os
from pathlib import Path
import subprocess
import sys

root = Path(__file__).resolve().parent.parent
device = sys.argv[1] if len(sys.argv) > 1 else 'emulator-5554'
sdk = Path(os.environ.get('ANDROID_HOME', Path.home() / 'Library/Android/sdk'))
command = ['flutter', 'test', 'integration_test/signup_keyboard_test.dart',
           '-d', device, '--dart-define=CAPTURE_PAUSE_SECONDS=5']
process = subprocess.Popen(command, cwd=root, stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT, text=True)
captured = False
for line in process.stdout:
    print(line, end='', flush=True)
    if 'WEEK2_KEYBOARD_READY:' in line:
        png = subprocess.check_output([str(sdk / 'platform-tools/adb'),
                                       '-s', device, 'exec-out', 'screencap', '-p'])
        if not png.startswith(b'\x89PNG\r\n\x1a\n'):
            raise RuntimeError('Device screenshot was not a PNG')
        (root / 'docs/screenshots/week-2-keyboard.png').write_bytes(png)
        captured = True
code = process.wait()
if code or not captured:
    raise SystemExit(code or 1)
