import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["email", "password"];

  connect() {
    // this.element.textContent = "Hello World!";
  }

  submit(event) {
    event.preventDefault(); // 폼의 기본 제출 동작을 방지
    const email = this.emailTarget.value;
    const password = this.passwordTarget.value;
    const data = {
      user: {
        email: email,
        password: password,
      },
    };

    // console.log(`Email: ${email}, Password: ${password}`);

    // AJAX 요청을 보내거나, 추가 로직을 여기에 구현...

    // CSRF 토큰 읽기
    const csrfToken = document
      .querySelector("meta[name='csrf-token']")
      .getAttribute("content");

    fetch("/users", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken, // CSRF 토큰을 헤더에 추가
      },
      body: JSON.stringify(data),
    })
      .then((response) => {
        console.log("response", response);
      })
      .catch((error) => {
        console.error("error", error);
      });
  }

  login(event) {
    event.preventDefault(); // 폼의 기본 제출 동작을 방지
    const email = this.emailTarget.value;
    const password = this.passwordTarget.value;
    const data = {
      user: {
        email: email,
        password: password,
      },
    };

    // CSRF 토큰 읽기
    const csrfToken = document
      .querySelector("meta[name='csrf-token']")
      .getAttribute("content");

    fetch("/users/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken, // CSRF 토큰을 헤더에 추가
      },
      body: JSON.stringify(data),
    })
      .then((response) => {
        console.log("response", response);
      })
      .catch((error) => {
        console.error("error", error);
      });
  }

  logout(event) {
    console.log("logout");

    // CSRF 토큰 읽기
    const csrfToken = document
      .querySelector("meta[name='csrf-token']")
      .getAttribute("content");

    fetch("/users/logout", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken, // CSRF 토큰을 헤더에 추가
      },
    });
  }
}
