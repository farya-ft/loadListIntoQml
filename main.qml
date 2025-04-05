import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    title: "User Info Form"

    // 📦 مدل لیست کاربران
    ListModel {
        id: usersListModel
    }

    Rectangle {
        width: 320
        height: 550
        anchors.centerIn: parent
        color: "#F5F5F5"
        radius: 12
        border.color: "#BDBDBD"
        border.width: 1.5

        Column {
            anchors.centerIn: parent
            spacing: 16

            // 📝 عنوان فرم
            Text {
                text: "User Information"
                font.pointSize: 16
                font.bold: true
                color: "#333"
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }

            // ✏️ نام
            TextField {
                id: nameInput
                placeholderText: "Name"
                width: 220
                background: Rectangle {
                    color: "#3498db"
                    radius: 6
                }
            }

            // ✉️ ایمیل
            TextField {
                id: emailInput
                placeholderText: "Email"
                width: 220
                background: Rectangle {
                    color: "#3498db"
                    radius: 6
                }
            }

            // 💾 دکمه ذخیره اطلاعات
            Button {
                text: "Save"
                background: Rectangle {
                    color: "#3498db"
                    radius: 6
                }
                onClicked: {
                    if (nameInput.text.length > 0 && emailInput.text.length > 0) {
                        userHandler.submitUserInfo(nameInput.text, emailInput.text)
                    } else {
                        statusText.text = "Please fill in all fields ❗"
                    }
                }
            }

            // 📃 دکمه نمایش کاربران
            Button {
                text: "Show Users"
                background: Rectangle {
                    color: "#2ecc71"
                    radius: 6
                }
                onClicked: {
                    let users = userHandler.loadUsers()
                    usersListModel.clear()
                    for (let i = 0; i < users.length; i++) {
                        usersListModel.append({ "text": users[i] })
                    }
                }
            }

            // 📋 نمایش لیست کاربران
            ListView {
                width: 250
                height: 160
                model: usersListModel
                delegate: Text {
                    text: model.text
                    color: "#444"
                    font.pointSize: 12
                }
            }

            // ✅ پیام وضعیت ذخیره
            Text {
                id: statusText
                text: ""
                color: "#009688"
                font.pointSize: 12
                wrapMode: Text.WordWrap
                width: 250
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    // 📡 اتصال به سیگنال‌های C++
    Connections {
        target: userHandler

        onUserSaved: {
            statusText.text = "Information saved successfully ✅"
        }

        onUserSaveFailed: (error) => {
            statusText.text = "Save failed ❌: " + error
        }
    }
}