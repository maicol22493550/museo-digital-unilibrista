/* Acceso con el diseño de Figma y autenticación del servidor Python. */
(() => {
  // Pantalla de acceso con la presentación del prototipo y las operaciones
  // reales de login y registro del servidor Python.
  const loginStyles = document.createElement("style");
  loginStyles.textContent = `
    .login-page { min-height:calc(100vh - 70px); display:grid; place-items:center;
      padding:56px 20px 70px; background:#f6f6f6 }
    .login-layout { width:100%; max-width:440px }
    .login-brand { display:flex; justify-content:center; align-items:center;
      gap:12px; margin-bottom:26px; font-family:Montserrat,sans-serif }
    .login-brand strong { display:block; font-size:15px; line-height:1.3 }
    .login-brand small { display:block; color:#c8102e; font-weight:700; font-size:11px }
    .login-card { padding:30px 32px; border-radius:15px; background:#fff;
      box-shadow:0 5px 20px #00000016 }
    .login-card h1 { margin:0 0 6px; font-size:22px; font-weight:800 }
    .login-intro { margin:0 0 22px; color:#686868; font-size:14px }
    .login-demo { padding:13px; margin-bottom:22px; border:1px solid #f0d1d7;
      border-radius:11px; background:#fff7f8 }
    .login-demo-title { margin:0 0 9px; color:#c8102e; font:700 10px Montserrat,sans-serif;
      text-transform:uppercase; letter-spacing:.1em }
    .login-user { display:flex; align-items:center; width:100%; gap:9px;
      padding:8px 10px; margin-top:7px; border:1px solid #e9e9e9;
      border-radius:7px; background:#fff; text-align:left }
    .login-user:hover { border-color:#c8102e; background:#fff9fa }
    .login-user img { width:29px; height:29px; flex:none; border-radius:50%; object-fit:cover }
    .login-user strong { display:block; font:700 12px Montserrat,sans-serif }
    .login-user small { display:block; color:#686868; font-size:10px }
    .login-divider { display:flex; align-items:center; gap:10px; margin:25px 0 22px;
      color:#888; text-align:center; font-size:11px }
    .login-divider:before,.login-divider:after { content:""; flex:1; height:1px; background:#e8e8e8 }
    .login-card form label { display:block; margin-bottom:15px;
      font:700 12px Montserrat,sans-serif }
    .login-card form input:not([type="checkbox"]) { display:block; width:100%;
      min-height:42px; margin-top:6px; padding:10px 12px; border:1px solid #ddd;
      border-radius:6px; background:#fff; font:13px Inter,sans-serif }
    .login-card .btn { width:100%; margin-top:10px }
    .login-minor { padding:0; border:0; background:none; color:#c8102e;
      font:500 12px Inter,sans-serif }
    .login-bottom { margin:20px 0 0; text-align:center; color:#686868; font-size:12px }
    .login-password { margin:16px 0 0; color:#686868; text-align:center; font-size:11px }
    .login-alert { padding:10px 12px; margin:12px 0; border-radius:6px;
      background:#fff0f2; color:#8a1026; font-size:12px }
    .registration { margin-top:18px; padding-top:18px; border-top:1px solid #eee }
    .registration summary { color:#c8102e; cursor:pointer; text-align:center;
      font:700 12px Montserrat,sans-serif }
    .registration h2 { margin:20px 0 14px; font-size:17px }
    .registration label.checkbox { display:flex; align-items:center; gap:9px;
      font-family:Inter,sans-serif; font-weight:500 }
    .registration input[type="checkbox"] { width:auto; margin:0 }
    @media(max-width:480px) { .login-page { padding:32px 16px 50px }
      .login-card { padding:24px 19px } }
  `;
  document.head.append(loginStyles);

  access = function () {
    main.innerHTML = `
      <section class="login-page">
        <div class="login-layout">
          <div class="login-brand">
            <svg width="40" height="44" viewBox="0 0 40 44" aria-hidden="true">
              <path d="M20 2 4 8v14c0 10 7 18.5 16 20 9-1.5 16-10 16-20V8L20 2Z" fill="#c8102e" stroke="#8a1026" stroke-width="1.5"/>
              <path d="M20 6 7 11v12c0 8 5.8 15 13 16.5C27.2 38 33 31 33 23V11L20 6Z" fill="#8a1026"/>
              <text x="20" y="27" text-anchor="middle" fill="white" font-size="12" font-weight="700">UL</text>
            </svg>
            <span><strong>MUSEO DIGITAL</strong><small>INGENIERÍA DE SISTEMAS</small></span>
          </div>
          <div class="login-card">
            <h1>Iniciar sesión</h1>
            <p class="login-intro">Accede con tu correo institucional de la Universidad Libre.</p>
            <div class="login-demo">
              <p class="login-demo-title">Acceso rápido de demostración</p>
              <button class="login-user" type="button" data-demo="estudiante@unilibre.edu.co">
                <img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop&auto=format" alt="">
                <span><strong>Laura Pineda</strong><small>Estudiante · estudiante@unilibre.edu.co</small></span>
              </button>
              <button class="login-user" type="button" data-demo="docente@unilibre.edu.co">
                <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&h=150&fit=crop&auto=format" alt="">
                <span><strong>Ing. Camila Morales</strong><small>Docente · docente@unilibre.edu.co</small></span>
              </button>
              <button class="login-user" type="button" data-demo="admin@unilibre.edu.co">
                <img src="https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&auto=format" alt="">
                <span><strong>Coordinación del Museo</strong><small>Administrador · admin@unilibre.edu.co</small></span>
              </button>
            </div>
            <div class="login-divider">o ingresa manualmente</div>
            <form id="login" autocomplete="on">
              <label>Correo institucional *<input type="email" name="email" placeholder="correo@unilibre.edu.co" autocomplete="username" required></label>
              <label>Contraseña *<input type="password" name="password" autocomplete="current-password" required></label>
              <button id="passwordHelp" class="login-minor" type="button">¿Olvidaste tu contraseña?</button>
              <p id="loginMessage" class="login-alert" role="alert" hidden></p>
              <button class="btn" type="submit">Iniciar sesión</button>
            </form>
            <p class="login-bottom">¿Primera vez? <a href="#inicio" class="login-minor">Explora el museo sin cuenta</a></p>
            <details class="registration" id="registration">
              <summary>Solicitar cuenta institucional</summary>
              <h2>Solicitar cuenta</h2>
              <form id="register">
                <label>Nombre completo *<input name="name" autocomplete="name" required></label>
                <label>Correo institucional *<input name="email" type="email" autocomplete="email" required></label>
                <label>Contraseña *<input name="password" type="password" autocomplete="new-password" minlength="8" placeholder="Mayúscula, número y mínimo 8 caracteres" required></label>
                <label class="checkbox"><input name="consent" type="checkbox" required> Acepto el tratamiento de mis datos.</label>
                <button class="btn" type="submit">Enviar solicitud</button>
              </form>
            </details>
          </div>
          <p class="login-password">Para acceder a las cuentas de prueba, la contraseña es: <strong>Museo2026!</strong></p>
        </div>
      </section>`;

    const loginForm = main.querySelector("#login");
    loginForm.onsubmit = async (event) => {
      event.preventDefault();
      const submit = loginForm.querySelector('[type="submit"]');
      const error = main.querySelector("#loginMessage");
      submit.disabled = true;
      error.hidden = true;
      try {
        await api("/login", Object.fromEntries(new FormData(loginForm)));
        await refresh();
        location.hash = "#panel";
        render();
      } catch (failure) {
        error.textContent = failure.message;
        error.hidden = false;
      } finally {
        submit.disabled = false;
      }
    };
    main.querySelectorAll("[data-demo]").forEach((button) => {
      button.onclick = () => {
        loginForm.elements.email.value = button.dataset.demo;
        loginForm.elements.password.value = "Museo2026!";
        loginForm.requestSubmit();
      };
    });
    main.querySelector("#passwordHelp").onclick = () => {
      const message = main.querySelector("#loginMessage");
      message.textContent = "Para recuperar tu acceso, solicita ayuda a la administración del museo.";
      message.hidden = false;
    };
    main.querySelector("#register").onsubmit = async (event) => {
      event.preventDefault();
      try {
        const data = Object.fromEntries(new FormData(event.target));
        data.consent = Boolean(data.consent);
        const result = await api("/register", data);
        toast(result.message);
        event.target.reset();
        main.querySelector("#registration").open = false;
      } catch (failure) {
        toast(failure.message);
      }
    };
  };
})();
