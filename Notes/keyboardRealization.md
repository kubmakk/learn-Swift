Давай подытожим все изменения, чтобы у тебя перед глазами была четкая картина. Вот ровно те куски кода, которые нужно было изменить или добавить в твой изначальный `LoginViewController`.

### 1. Изменения в методе `setupUI()`

Мы отвязали скролл от клавиатуры, убрали ограничение по высоте контента (чтобы вьюха не "резиновилась" от каждого движения) и поменяли тип скрытия клавиатуры.

**Было:**

Swift

```
scrollView.snp.makeConstraints { make in
    make.top.left.right.equalTo(view.safeAreaLayoutGuide)
    make.bottom.equalTo(view.keyboardLayoutGuide.snp.top) // <-- Из-за этого всё прыгало
}
scrollView.keyboardDismissMode = .interactive // <-- Тянуло клавиатуру за пальцем
// ...
contentView.snp.makeConstraints { make in
    // ...
    make.height.equalTo(scrollView.frameLayoutGuide.snp.height).priority(.low) // <-- Ломало верстку
}
```

**Стало:**

Swift

```
scrollView.snp.makeConstraints { make in
    make.edges.equalTo(view.safeAreaLayoutGuide) // <-- Теперь скролл просто на весь экран
}
scrollView.keyboardDismissMode = .onDrag // <-- Плавно скрывает по свайпу вниз
// ...
contentView.snp.makeConstraints { make in
    make.edges.equalTo(scrollView.contentLayoutGuide.snp.edges)
    make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
    // Строку с make.height мы просто удалили!
}
```

### 2. Регистрация наблюдателей (Добавили новые методы)

Чтобы контроллер реагировал на клавиатуру, мы добавили подписки в жизненный цикл экрана.

**Добавили этот код в класс:**

Swift

```
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
}

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
}
```

### 3. Логика сдвига клавиатуры (Добавили в `//MARK: - Actions`)

Вместо того чтобы двигать саму вьюху, мы теперь просто добавляем `scrollView` "подушку безопасности" снизу (`contentInset`) и просим его докрутить экран до кнопки.

**Добавили этот код:**

Swift

```
@objc private func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
    
    // Добавляем отступ снизу размером с клавиатуру + 60 поинтов для кнопки
    let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 60, right: 0)
    scrollView.contentInset = insets
    scrollView.verticalScrollIndicatorInsets = insets
    
    // Заставляем скролл прокрутиться так, чтобы кнопка полностью попала в кадр
    DispatchQueue.main.async {
        self.scrollView.scrollRectToVisible(self.loginButton.frame, animated: true)
    }
}

@objc private func keyboardWillHide(notification: NSNotification) {
    // Убираем отступы, когда клавиатура прячется
    scrollView.contentInset = .zero
    scrollView.verticalScrollIndicatorInsets = .zero
}
```

------

Вот и весь секрет! Теперь у тебя правильная архитектура: высота контента зависит от элементов, скролл не ломается, а клавиатура мягко сдвигает экран ровно до кнопки.

Ну что, добавляем тот самый жест `UITapGestureRecognizer`, чтобы клавиатура пряталась просто по клику в любую пустую область экрана? Пользователям будет гораздо удобнее!

