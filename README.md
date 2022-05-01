# expense

### How to generate code
- Generate the code then terminate (don't watch the changes real time).
```
flutter packages pub run build_runner build
```

- Generate the code and stay watching the changes real time, when there is a change, re-generate new code.
```
flutter packages pub run build_runner watch --delete-conflicting-outputs
```