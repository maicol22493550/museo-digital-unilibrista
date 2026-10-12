const $ = (selector) => document.querySelector(selector);
const main = $("#main");

let me = null;
let items = [];
let stats = {};
let selectedYear = 0;
let viewMode = "grid";

const kinds = {
  historia: "Historia",
  proyecto: "Proyectos",
  investigacion: "Investigación",
  premio: "Premios",
  persona: "Hall de la Fama",
  evento: "Eventos",
  galeria: "Galería"
};

const icons = {
  historia: "📜",
  proyecto: "⚙️",
  investigacion: "🔬",
  premio: "🏆",
  persona: "⭐",
  evento: "📅",
  galeria: "🖼️"
};

const demoImages = {
  historia:
    "https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=800&h=500&fit=crop&auto=format",
  proyecto:
    "https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=800&h=500&fit=crop&auto=format",
  investigacion:
    "https://images.unsplash.com/photo-1525921429624-479b6a26d84d?w=800&h=500&fit=crop&auto=format",
  premio:
    "https://images.unsplash.com/photo-1567427018141-0584cfcbf1b8?w=800&h=500&fit=crop&auto=format",
  persona:
    "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=800&h=500&fit=crop&auto=format",
  evento:
    "https://images.unsplash.com/photo-1523580494863-6f3031224c94?w=800&h=500&fit=crop&auto=format",
  galeria:
    "https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=800&h=500&fit=crop&auto=format"
};

function escapeHTML(value) {
  return String(value ?? "").replace(
    /[&<>"']/g,
    (character) => ({
      "&": "&amp;",
      "<": "&lt;",
      ">": "&gt;",
      '"': "&quot;",
      "'": "&#39;"
    })[character]
  );
}

function safeURL(value) {
  return /^https?:\/\//i.test(String(value || ""))
    ? escapeHTML(value)
    : "#";
}

async function api(path, body) {
  const response = await fetch("/api" + path, {
    method: body === undefined ? "GET" : "POST",
    headers: {
      "Content-Type": "application/json"
    },
    credentials: "same-origin",
    body: body === undefined
      ? undefined
      : JSON.stringify(body)
  });

  const data = await response.json().catch(() => ({}));

  if (!response.ok) {
    throw new Error(
      data.error || "No se pudo completar la acción"
    );
  }

  return data;
}

function toast(message) {
  const element = $("#toast");
  element.textContent = message;
  element.classList.add("visible");

  setTimeout(() => {
    element.classList.remove("visible");
  }, 4000);
}

function button(label, href, className = "btn") {
  return `
    <a class="${className}" href="${href}">
      ${label}
    </a>
  `;
}

function pageTitle(eyebrow, heading, description = "") {
  return `
    <span class="eyebrow">${eyebrow}</span>
    <h1 class="page-title">${heading}</h1>
    ${description
      ? `<p class="lead">${description}</p>`
      : ""}
  `;
}

function card(item) {
  const image = item.image || demoImages[item.kind];
  const category = kinds[item.kind] || "Memoria";
  const description = String(item.description || "");

  return `
    <article class="card museum-card">
      <a
        class="museum-card-image"
        href="#detalle/${item.id}"
        aria-label="Ver ${escapeHTML(item.title)}"
      >
        <img
          src="${safeURL(image)}"
          alt="${
            item.image
              ? escapeHTML(item.alt || item.title)
              : "Fotografía ilustrativa de " +
                escapeHTML(category)
          }"
          loading="lazy"
        >

        <span
          class="museum-card-symbol"
          aria-hidden="true"
        >
          ${icons[item.kind] || "✦"}
        </span>
      </a>

      <div class="card-body">
        <span class="meta">
          ${escapeHTML(category)} ·
          ${escapeHTML(item.year)}
        </span>

        <h3>${escapeHTML(item.title)}</h3>

        <p>
          ${escapeHTML(description.slice(0, 145))}
          ${description.length > 145 ? "…" : ""}
        </p>

        <a
          class="text-link"
          href="#detalle/${item.id}"
        >
          Conocer más →
        </a>
      </div>
    </article>
  `;
}

function home() {
  const history = items
    .filter((item) => item.kind === "historia")
    .sort((a, b) => a.year - b.year);

  const projects = items.filter(
    (item) => item.kind === "proyecto"
  );

  const research = items.filter(
    (item) => item.kind === "investigacion"
  );

  const awards = items.filter(
    (item) => item.kind === "premio"
  );

  const people = items.filter(
    (item) => item.kind === "persona"
  );

  const events = items.filter(
    (item) => item.kind === "evento"
  );

  const gallery = items.filter(
    (item) => item.kind === "galeria"
  );

  const sections = [
    [
      "historia",
      "Historia",
      "Línea del tiempo y memoria histórica"
    ],
    [
      "proyecto",
      "Proyectos",
      "Innovación, software e impacto"
    ],
    [
      "investigacion",
      "Investigación",
      "Grupos, semilleros y publicaciones"
    ],
    [
      "premio",
      "Premios",
      "Logros y reconocimientos"
    ],
    [
      "persona",
      "Hall de la Fama",
      "Personas que dejan huella"
    ],
    [
      "galeria",
      "Galería",
      "Fotografías y documentos"
    ]
  ];

  if (
    !selectedYear ||
    !history.some((item) => item.id === selectedYear)
  ) {
    selectedYear = history[0]?.id || 0;
  }

  const active = history.find(
    (item) => item.id === selectedYear
  );

  function feature(key, label, entries, description) {
    return `
      <section
        class="museum-section wrap"
        id="${key}"
      >
        <div class="section-heading">
          <div>
            <span class="eyebrow">${label}</span>
            <h2>${description}</h2>
          </div>

          <a
            href="#${key}"
            class="all-link"
          >
            Ver todo →
          </a>
        </div>

        <div class="grid feature-grid">
          ${entries.length
            ? entries.slice(0, 3).map(card).join("")
            : `
              <p class="empty">
                Aún no hay contenido publicado
                en esta sección.
              </p>
            `}
        </div>
      </section>
    `;
  }

  main.innerHTML = `
    <section class="hero" id="portada">
      <div class="wrap hero-inner">
        <span class="eyebrow">
          Memoria · Innovación · Comunidad
        </span>

        <h1>
          Museo Digital<br>
          Unilibrista
        </h1>

        <p>
          La historia que construimos.<br>
          El legado que compartimos.
        </p>

        <div class="actions">
          <a class="btn" href="#secciones">
            Explorar el museo
          </a>

          <a
            class="btn btn-outline"
            href="#linea"
          >
            Recorrer la línea del tiempo
          </a>
        </div>
      </div>
    </section>

    <section
      class="museum-section wrap"
      id="secciones"
    >
      <div class="section-heading">
        <div>
          <span class="eyebrow">
            Navega el museo
          </span>

          <h2>Explora nuestra memoria</h2>
        </div>

        <a
          class="all-link"
          href="#explorar"
        >
          Ver todo →
        </a>
      </div>

      <div class="section-grid">
        ${sections.map(
          ([key, label, description]) => `
            <a
              href="#${key}"
              class="section-tile"
            >
              <span
                class="icon"
                aria-hidden="true"
              >
                ${icons[key]}
              </span>

              <h3>${label}</h3>
              <p>${description}</p>
            </a>
          `
        ).join("")}
      </div>
    </section>

    <section
      class="museum-section history-section"
      id="linea"
    >
      <div class="wrap">
        <span class="eyebrow">Historia</span>

        <h2>
          Un recorrido por nuestra historia
        </h2>

        <p class="lead">
          Selecciona un año para descubrir
          un acontecimiento.
        </p>

        ${history.length ? `
          <div class="timeline-tabs">
            ${history.map((item) => `
              <button
                class="timeline-tab ${
                  item.id === selectedYear
                    ? "active"
                    : ""
                }"
                data-year="${item.id}"
                aria-pressed="${
                  item.id === selectedYear
                }"
              >
                ${item.year}
              </button>
            `).join("")}
          </div>

          <div class="history-detail">
            <div class="history-tag">
              Hito · ${active.year}
            </div>

            <h3>
              ${escapeHTML(active.title)}
            </h3>

            <p>
              ${escapeHTML(active.description)}
            </p>

            <div class="row-actions">
              <button
                class="btn btn-soft"
                data-step="-1"
                ${
                  history[0].id === selectedYear
                    ? "disabled"
                    : ""
                }
              >
                ← Anterior
              </button>

              <button
                class="btn btn-soft"
                data-step="1"
                ${
                  history.at(-1).id === selectedYear
                    ? "disabled"
                    : ""
                }
              >
                Siguiente →
              </button>

              <a
                class="btn btn-outline"
                href="#detalle/${active.id}"
              >
                Ver historia
              </a>
            </div>
          </div>
        ` : `
          <p class="empty">
            Aún no hay hitos publicados.
          </p>
        `}
      </div>
    </section>

    ${feature(
      "proyecto",
      "Proyectos destacados",
      projects,
      "Ideas que se convirtieron en soluciones"
    )}

    ${feature(
      "investigacion",
      "Investigación",
      research,
      "Conocimiento creado en comunidad"
    )}

    ${feature(
      "premio",
      "Premios y reconocimientos",
      awards,
      "Logros que nos inspiran"
    )}

    ${feature(
      "persona",
      "Hall de la Fama",
      people,
      "Personas que dejaron huella"
    )}

    ${feature(
      "evento",
      "Eventos",
      events,
      "Encuentros de nuestra comunidad"
    )}

    ${feature(
      "galeria",
      "Galería",
      gallery,
      "Memorias para ver y compartir"
    )}

    <section class="museum-section impact">
      <div class="wrap">
        <span class="eyebrow">
          Impacto en cifras
        </span>

        <h2>
          Una historia que sigue creciendo
        </h2>

        <div class="numbers">
          ${[
            ["proyecto", "Proyectos"],
            ["premio", "Premios"],
            ["evento", "Eventos"],
            ["persona", "Personas destacadas"],
            ["investigacion", "Investigaciones"]
          ].map(([key, label]) => `
            <div>
              <strong>
                ${stats[key] || 0}
              </strong>

              <span>${label}</span>
            </div>
          `).join("")}
        </div>
      </div>
    </section>

    <section class="cta">
      <div class="wrap cta-inner">
        <div>
          <h2>
            Nuestra historia también
            la construyes tú
          </h2>

          <p>
            Comparte una memoria, un proyecto
            o un reconocimiento.
          </p>
        </div>

        <a
          class="btn btn-outline"
          href="#aporte"
        >
          Aportar contenido →
        </a>
      </div>
    </section>
  `;

  main
    .querySelectorAll("[data-year]")
    .forEach((element) => {
      element.onclick = () => {
        selectedYear = Number(
          element.dataset.year
        );

        home();

        document
          .getElementById("linea")
          .scrollIntoView();
      };
    });

  main
    .querySelectorAll("[data-step]")
    .forEach((element) => {
      element.onclick = () => {
        const currentIndex = history.findIndex(
          (item) => item.id === selectedYear
        );

        const nextIndex =
          currentIndex +
          Number(element.dataset.step);

        selectedYear = history[nextIndex].id;

        home();

        document
          .getElementById("linea")
          .scrollIntoView();
      };
    });

  main
    .querySelectorAll('a[href^="#"]')
    .forEach((element) => {
      const target = element
        .getAttribute("href")
        .slice(1);

      if (
        target === "secciones" ||
        target === "linea"
      ) {
        element.onclick = (event) => {
          event.preventDefault();

          document
            .getElementById(target)
            ?.scrollIntoView({
              behavior: "smooth"
            });
        };
      }
    });

}

function explorer(initialKind = "") {
  const years = [
    ...new Set(items.map((item) => item.year))
  ].sort((a, b) => b - a);

  const categories = [
    ...new Set(items.map((item) => item.category))
  ].sort();

  main.innerHTML = `
    <section class="wrap section">
      ${pageTitle(
        "Colección pública",
        initialKind
          ? escapeHTML(kinds[initialKind])
          : "Explora nuestra historia",
        "Busca y filtra las memorias del programa."
      )}

      <form id="filters" class="toolbar">
        <label>
          Palabra clave
          <input
            name="q"
            placeholder="Buscar historias"
          >
        </label>

        <label>
          Tipo
          <select name="kind">
            <option value="">Todos</option>

            ${Object.entries(kinds).map(
              ([key, label]) => `
                <option
                  value="${key}"
                  ${
                    initialKind === key
                      ? "selected"
                      : ""
                  }
                >
                  ${label}
                </option>
              `
            ).join("")}
          </select>
        </label>

        <label>
          Año
          <select name="year">
            <option value="">Todos</option>

            ${years.map((year) => `
              <option>${year}</option>
            `).join("")}
          </select>
        </label>

        <label>
          Categoría
          <select name="category">
            <option value="">Todas</option>

            ${categories.map((category) => `
              <option>
                ${escapeHTML(category)}
              </option>
            `).join("")}
          </select>
        </label>

        <button class="btn" type="submit">
          Buscar
        </button>

        <button
          class="btn btn-soft"
          type="button"
          id="clear"
        >
          Limpiar
        </button>
      </form>

      <div
        class="filter-view"
        aria-label="Modo de visualización"
      >
        <button class="btn" data-view="grid">
          Cuadrícula
        </button>

        <button
          class="btn btn-soft"
          data-view="list"
        >
          Lista
        </button>

        <button
          class="btn btn-soft"
          data-view="timeline"
        >
          Cronología
        </button>
      </div>

      <p id="count" class="muted"></p>
      <div id="results"></div>
    </section>
  `;

  function showResults() {
    const filters = new FormData(
      $("#filters")
    );

    const results = items.filter((item) => {
      const searchable = [
        item.title,
        item.description,
        item.protagonist,
        item.tags
      ].join(" ").toLowerCase();

      return (
        (
          !filters.get("kind") ||
          item.kind === filters.get("kind")
        ) &&
        (
          !filters.get("year") ||
          String(item.year) ===
            filters.get("year")
        ) &&
        (
          !filters.get("category") ||
          item.category ===
            filters.get("category")
        ) &&
        (
          !filters.get("q") ||
          searchable.includes(
            String(
              filters.get("q")
            ).toLowerCase()
          )
        )
      );
    });

    if (viewMode === "timeline") {
      results.sort(
        (a, b) => a.year - b.year
      );
    }

    $("#count").textContent =
      `${results.length} resultado` +
      (results.length === 1 ? "" : "s");

    $("#results").innerHTML = results.length
      ? `
        <div class="grid ${
          viewMode === "grid"
            ? ""
            : "list-view"
        }">
          ${results.map(card).join("")}
        </div>
      `
      : `
        <p class="empty">
          No encontramos resultados.
          Cambia o limpia los filtros.
        </p>
      `;
  }

  $("#filters").onsubmit = (event) => {
    event.preventDefault();
    showResults();
  };

  $("#clear").onclick = () => {
    location.hash = "#explorar";
    explorer();
  };

  main
    .querySelectorAll("[data-view]")
    .forEach((element) => {
      element.onclick = () => {
        viewMode = element.dataset.view;

        main
          .querySelectorAll("[data-view]")
          .forEach((other) => {
            other.classList.toggle(
              "btn-soft",
              other !== element
            );
          });

        showResults();
      };
    });

  showResults();
}

async function detail(id) {
  const item = await api(
    "/contents/" + id
  );

  const comments = await api(
    "/comments?content_id=" + id
  );

  main.innerHTML = `
    <div class="wrap detail">
      <div class="breadcrumbs">
        <a href="#inicio">Inicio</a>
        /
        <a href="#${item.kind}">
          ${escapeHTML(kinds[item.kind])}
        </a>
        /
        ${escapeHTML(item.title)}
      </div>

      <section class="section">
        <span class="badge">
          ${escapeHTML(kinds[item.kind])}
          · ${item.year}
        </span>

        <h1>${escapeHTML(item.title)}</h1>

        <p class="lead">
          ${escapeHTML(item.protagonist)}
          · ${escapeHTML(item.category)}
        </p>

        <div class="panel">
          <p>
            ${escapeHTML(
              item.description
            ).replace(/\n/g, "<br>")}
          </p>

          ${item.image ? `
            <img
              src="${safeURL(item.image)}"
              alt="${escapeHTML(item.alt)}"
              style="
                width: 100%;
                max-height: 480px;
                object-fit: cover;
                border-radius: 10px;
              "
            >
          ` : ""}

          ${item.evidence ? `
            <p>
              <a
                class="text-link"
                href="${safeURL(item.evidence)}"
                target="_blank"
                rel="noopener noreferrer"
              >
                Consultar evidencia ↗
              </a>
            </p>
          ` : ""}

          <p class="small muted">
            Fuente: ${escapeHTML(item.source)}
            · Autor del aporte:
            ${escapeHTML(item.author)}
          </p>

          <p class="small muted">
            Etiquetas:
            ${escapeHTML(
              item.tags || "Sin etiquetas"
            )}
          </p>
        </div>

        <div class="row-actions">
          <button
            class="btn btn-outline"
            id="share"
          >
            Copiar enlace
          </button>

          ${me ? `
            <button
              class="btn btn-soft"
              id="favorite"
            >
              ☆ Guardar favorito
            </button>
          ` : ""}
        </div>

        <div class="panel">
          <h2>Conversación</h2>

          ${comments.length
            ? comments.map((comment) => `
                <div class="record">
                  <p>
                    <b>
                      ${escapeHTML(
                        comment.name
                      )}
                    </b>

                    ${
                      comment.status ===
                      "pendiente"
                        ? "(pendiente de moderación)"
                        : ""
                    }

                    <br>

                    ${escapeHTML(
                      comment.body
                    )}
                  </p>
                </div>
              `).join("")
            : `
              <p class="muted">
                Todavía no hay
                comentarios publicados.
              </p>
            `}

          ${me ? `
            <form id="commentForm">
              <label>
                Tu comentario

                <textarea
                  name="body"
                  maxlength="1000"
                  required
                ></textarea>
              </label>

              <button class="btn">
                Enviar comentario
              </button>
            </form>
          ` : `
            <p>
              <a
                class="text-link"
                href="#acceso"
              >
                Inicia sesión para comentar
              </a>
            </p>
          `}
        </div>
      </section>
    </div>
  `;

  $("#share").onclick = async () => {
    try {
      await navigator.clipboard.writeText(
        location.href
      );

      toast("Enlace copiado");
    } catch {
      toast("No se pudo copiar el enlace");
    }
  };

  if (me) {
    $("#favorite").onclick = async () => {
      try {
        const result = await api(
          "/favorites",
          { content_id: item.id }
        );

        toast(
          result.saved
            ? "Guardado en favoritos"
            : "Eliminado de favoritos"
        );
      } catch (error) {
        toast(error.message);
      }
    };

    $("#commentForm").onsubmit = async (
      event
    ) => {
      event.preventDefault();

      try {
        const form = new FormData(
          event.target
        );

        const result = await api(
          "/comments",
          {
            content_id: item.id,
            body: form.get("body")
          }
        );

        toast(result.message);
        detail(id);
      } catch (error) {
        toast(error.message);
      }
    };
  }
}

function access() {
  main.innerHTML = `
    <section class="section wrap">
      <div class="inset">
        ${pageTitle(
          "Acceso",
          "Tu espacio en el museo",
          "Ingresa para aportar y seguir tus contenidos."
        )}

        <div class="panel">
          <h2>Iniciar sesión</h2>

          <form
            id="login"
            class="form-grid"
          >
            <label class="wide">
              Correo institucional

              <input
                type="email"
                name="email"
                required
              >
            </label>

            <label class="wide">
              Contraseña

              <input
                type="password"
                name="password"
                required
              >
            </label>

            <button class="btn">
              Ingresar
            </button>
          </form>
        </div>

        <div class="panel">
          <h2>Solicitar cuenta</h2>

          <form
            id="register"
            class="form-grid"
          >
            <label class="wide">
              Nombre completo

              <input
                name="name"
                required
              >
            </label>

            <label class="wide">
              Correo institucional

              <input
                name="email"
                type="email"
                required
              >
            </label>

            <label class="wide">
              Contraseña

              <input
                name="password"
                type="password"
                minlength="8"
                required
                placeholder="8 caracteres, mayúscula y número"
              >
            </label>

            <label class="wide checkbox">
              <input
                name="consent"
                type="checkbox"
                required
              >

              Acepto el tratamiento
              de mis datos.
            </label>

            <button class="btn">
              Enviar solicitud
            </button>
          </form>
        </div>

        <p class="notice">
          Cuentas de prueba:
          estudiante@unilibre.edu.co,
          docente@unilibre.edu.co y
          admin@unilibre.edu.co.

          Contraseña: Museo2026!
        </p>
      </div>
    </section>
  `;

  $("#login").onsubmit = async (event) => {
    event.preventDefault();

    try {
      await api(
        "/login",
        Object.fromEntries(
          new FormData(event.target)
        )
      );

      await refresh();

      location.hash = "#panel";
      render();
    } catch (error) {
      toast(error.message);
    }
  };

  $("#register").onsubmit = async (
    event
  ) => {
    event.preventDefault();

    try {
      const data = Object.fromEntries(
        new FormData(event.target)
      );

      data.consent = Boolean(
        data.consent
      );

      const result = await api(
        "/register",
        data
      );

      toast(result.message);
      event.target.reset();
    } catch (error) {
      toast(error.message);
    }
  };
}

function requireLogin() {
  if (me) return true;

  location.hash = "#acceso";
  access();

  return false;
}

function requireAdmin() {
  if (!requireLogin()) return false;

  if (me.role !== "administrador") {
    location.hash = "#panel";
    toast(
      "Acceso exclusivo de administración"
    );

    return false;
  }

  return true;
}

function panel() {
  if (!requireLogin()) return;

  const adminLinks =
    me.role === "administrador"
      ? `
        <a class="tile" href="#revision">
          <span class="icon">✅</span>
          <h3>Validación</h3>
          <p>Revisar aportes.</p>
        </a>

        <a class="tile" href="#gestion">
          <span class="icon">▣</span>
          <h3>Gestión</h3>
          <p>Publicar o archivar.</p>
        </a>

        <a class="tile" href="#usuarios">
          <span class="icon">👥</span>
          <h3>Usuarios</h3>
          <p>Administrar cuentas.</p>
        </a>

        <a class="tile" href="#moderacion">
          <span class="icon">💬</span>
          <h3>Comentarios</h3>
          <p>Moderar comentarios.</p>
        </a>

        <a class="tile" href="#auditoria">
          <span class="icon">◷</span>
          <h3>Auditoría</h3>
          <p>Ver historial.</p>
        </a>
      `
      : "";

  main.innerHTML = `
    <section class="section wrap">
      ${pageTitle(
        "Mi museo",
        `Bienvenido, ${escapeHTML(me.name)}`,
        `Rol: ${escapeHTML(me.role)}`
      )}

      <div class="grid">
        <a class="tile" href="#aporte">
          <span class="icon">✎</span>
          <h3>Nuevo aporte</h3>
          <p>Crear una memoria.</p>
        </a>

        <a class="tile" href="#mis-aportes">
          <span class="icon">▤</span>
          <h3>Mis aportes</h3>
          <p>Consultar estados.</p>
        </a>

        <a class="tile" href="#favoritos">
          <span class="icon">☆</span>
          <h3>Favoritos</h3>
          <p>Contenido guardado.</p>
        </a>

        ${adminLinks}
      </div>

      <div class="actions">
        <button
          class="btn btn-outline"
          id="logout"
        >
          Cerrar sesión
        </button>
      </div>
    </section>
  `;

  $("#logout").onclick = async () => {
    await api("/logout", {});
    await refresh();

    location.hash = "#inicio";
    render();
  };
}

const formFields = [
  ["title", "Título", "text"],
  ["kind", "Tipo", "kind"],
  ["year", "Año", "number"],
  ["category", "Categoría", "text"],
  ["protagonist", "Protagonistas", "text"],
  ["description", "Descripción", "textarea"],
  ["source", "Fuente verificable", "text"],
  ["tags", "Etiquetas", "text"],
  ["image", "URL de imagen", "url"],
  ["evidence", "URL de evidencia", "url"],
  ["credit", "Crédito", "text"],
  ["alt", "Texto alternativo", "text"]
];

async function contribution(id) {
  if (!requireLogin()) return;

  const item = id
    ? await api("/contents/" + id)
    : {};

  if (
    id &&
    !["borrador", "requiere_ajustes"]
      .includes(item.status)
  ) {
    toast(
      "Este aporte no puede editarse"
    );

    location.hash = "#mis-aportes";
    return;
  }

  main.innerHTML = `
    <section class="section wrap">
      <div class="inset">
        ${pageTitle(
          "Participa",
          id
            ? "Editar aporte"
            : "Comparte una memoria",
          "Guarda tu borrador o envíalo a revisión."
        )}

        ${item.note ? `
          <p class="notice">
            Observaciones:
            ${escapeHTML(item.note)}
          </p>
        ` : ""}

        <form
          id="contribution"
          class="panel form-grid"
        >
          ${formFields.map(
            ([key, label, type]) => {
              const wide = [
                "description",
                "source",
                "tags",
                "image",
                "evidence",
                "credit",
                "alt"
              ].includes(key);

              let control;

              if (type === "kind") {
                control = `
                  <select
                    name="kind"
                    required
                  >
                    ${Object.entries(kinds)
                      .map(([kind, name]) => `
                        <option
                          value="${kind}"
                          ${
                            item.kind === kind
                              ? "selected"
                              : ""
                          }
                        >
                          ${name}
                        </option>
                      `).join("")}
                  </select>
                `;
              } else if (
                type === "textarea"
              ) {
                control = `
                  <textarea
                    name="${key}"
                    required
                  >${escapeHTML(
                    item[key] || ""
                  )}</textarea>
                `;
              } else {
                const required = [
                  "title",
                  "year",
                  "category",
                  "protagonist",
                  "source"
                ].includes(key);

                control = `
                  <input
                    name="${key}"
                    type="${type}"
                    value="${escapeHTML(
                      item[key] || ""
                    )}"
                    ${
                      key === "year"
                        ? 'min="1900" max="2100"'
                        : ""
                    }
                    ${
                      required
                        ? "required"
                        : ""
                    }
                  >
                `;
              }

              return `
                <label class="${
                  wide ? "wide" : ""
                }">
                  ${label}
                  ${control}
                </label>
              `;
            }
          ).join("")}

          <label class="wide checkbox">
            <input
              name="rights"
              type="checkbox"
              ${
                item.rights
                  ? "checked"
                  : ""
              }
            >

            Autorizo el uso de
            imágenes y evidencias.
          </label>

          <p class="wide small muted">
            Si agregas imagen, indica
            crédito, texto alternativo
            y autorización.
          </p>

          <div class="wide row-actions">
            <button
              class="btn btn-soft"
              name="intent"
              value="draft"
            >
              Guardar borrador
            </button>

            <button
              class="btn"
              name="intent"
              value="submit"
            >
              Enviar a revisión
            </button>
          </div>
        </form>
      </div>
    </section>
  `;

  $("#contribution").onsubmit =
    async (event) => {
      event.preventDefault();

      const data = Object.fromEntries(
        new FormData(event.target)
      );

      const submit =
        event.submitter?.value ===
        "submit";

      data.rights = Boolean(
        data.rights
      );

      data.submit = submit;
      data.action = submit
        ? "submit"
        : "save";

      try {
        await api(
          id
            ? "/contents/" + id
            : "/contents",
          data
        );

        toast(
          submit
            ? "Enviado a revisión"
            : "Borrador guardado"
        );

        location.hash =
          "#mis-aportes";

        render();
      } catch (error) {
        toast(error.message);
      }
    };
}

async function myItems() {
  if (!requireLogin()) return;

  const rows = await api(
    "/contents?own=1"
  );

  main.innerHTML = `
    <section class="section wrap">
      ${pageTitle(
        "Participación",
        "Mis aportes"
      )}

      ${button(
        "Crear nuevo aporte",
        "#aporte"
      )}

      <div class="panel">
        ${rows.length
          ? rows.map((item) => `
              <div class="record">
                <div>
                  <strong>
                    ${escapeHTML(
                      item.title
                    )}
                  </strong>

                  <span class="badge">
                    ${escapeHTML(
                      item.status
                    )}
                  </span>

                  ${item.note ? `
                    <p>
                      Observaciones:
                      ${escapeHTML(
                        item.note
                      )}
                    </p>
                  ` : ""}
                </div>

                ${
                  [
                    "borrador",
                    "requiere_ajustes"
                  ].includes(item.status)
                    ? button(
                        "Editar",
                        "#aporte/" +
                          item.id
                      )
                    : button(
                        "Ver",
                        "#detalle/" +
                          item.id
                      )
                }
              </div>
            `).join("")
          : `
            <p class="empty">
              No tienes aportes.
            </p>
          `}
      </div>
    </section>
  `;
}

async function favorites() {
  if (!requireLogin()) return;

  const rows = await api(
    "/favorites"
  );

  main.innerHTML = `
    <section class="section wrap">
      ${pageTitle(
        "Colección personal",
        "Mis favoritos"
      )}

      <div class="grid">
        ${rows.length
          ? rows.map(card).join("")
          : `
            <p class="empty">
              Aún no tienes favoritos.
            </p>
          `}
      </div>
    </section>
  `;
}

async function reviewQueue() {
  if (!requireAdmin()) return;

  const rows = await api(
    "/contents?queue=1"
  );

  main.innerHTML = `
    <section class="section wrap">
      ${pageTitle(
        "Gestión editorial",
        "Bandeja de validación"
      )}

      <div class="panel">
        ${rows.length
          ? rows.map((item) => `
              <div class="record">
                <div>
                  <strong>
                    ${escapeHTML(
                      item.title
                    )}
                  </strong>

                  <span class="badge">
                    ${escapeHTML(
                      item.status
                    )}
                  </span>
                </div>

                ${button(
                  "Revisar",
                  "#revisar/" +
                    item.id
                )}
              </div>
            `).join("")
          : `
            <p class="empty">
              No hay aportes pendientes.
            </p>
          `}
      </div>

      ${button(
        "Gestionar publicaciones",
        "#gestion",
        "btn btn-outline"
      )}
    </section>
  `;
}

async function review(id) {
  if (!requireAdmin()) return;

  const item = await api(
    "/contents/" + id
  );

  const checks = [
    ["accuracy", "Exactitud"],
    ["duplicates", "Sin duplicados"],
    ["metadata", "Metadatos"],
    [
      "accessibility",
      "Accesibilidad"
    ],
    [
      "rights_check",
      "Derechos de uso"
    ],
    ["relevance", "Pertinencia"]
  ];

  main.innerHTML = `
    <section class="section wrap">
      <div class="inset">
        ${pageTitle(
          "Validación",
          escapeHTML(item.title)
        )}

        <div class="panel">
          <p>
            <span class="badge">
              ${escapeHTML(
                item.status
              )}
            </span>

            ${escapeHTML(
              item.author
            )}
          </p>

          <p>
            ${escapeHTML(
              item.description
            )}
          </p>

          <p>
            <b>Fuente:</b>
            ${escapeHTML(
              item.source
            )}
          </p>

          <p>
            <b>Protagonistas:</b>
            ${escapeHTML(
              item.protagonist
            )}
          </p>

          <p>
            <b>Créditos:</b>
            ${escapeHTML(
              item.credit ||
              "No indicados"
            )}
          </p>

          <p>
            <b>Autorización:</b>
            ${
              item.rights
                ? "Sí"
                : "No"
            }
          </p>
        </div>

        ${
          item.status ===
          "en_revision"
            ? `
              <form
                class="panel"
                id="decision"
              >
                <h3>
                  Lista de verificación
                </h3>

                <div class="checklist">
                  ${checks.map(
                    ([key, label]) => `
                      <label>
                        <input
                          type="checkbox"
                          name="${key}"
                        >

                        ${label}
                      </label>
                    `
                  ).join("")}
                </div>

                <label>
                  Observaciones

                  <textarea
                    name="note"
                  ></textarea>
                </label>

                <div class="actions">
                  <button
                    type="button"
                    class="btn btn-soft"
                    data-action="return"
                  >
                    Devolver
                  </button>

                  <button
                    type="button"
                    class="btn"
                    data-action="approve"
                  >
                    Aprobar
                  </button>
                </div>
              </form>
            `
            : ""
        }

        ${
          item.status ===
          "aprobado"
            ? `
              <button
                class="btn"
                data-action="publish"
              >
                Publicar
              </button>
            `
            : ""
        }

        ${
          item.status ===
          "publicado"
            ? `
              <button
                class="btn btn-outline"
                data-action="archive"
              >
                Retirar
              </button>
            `
            : ""
        }

        ${
          item.status ===
          "archivado"
            ? `
              <button
                class="btn"
                data-action="restore"
              >
                Volver a publicar
              </button>
            `
            : ""
        }
      </div>
    </section>
  `;

  main
    .querySelectorAll(
      "[data-action]"
    )
    .forEach((element) => {
      element.onclick =
        async () => {
          const action =
            element.dataset.action;

          const form =
            $("#decision");

          const data = form
            ? Object.fromEntries(
                new FormData(form)
              )
            : {};

          data.action = action;

          try {
            await api(
              "/contents/" +
                id,
              data
            );

            toast(
              "Decisión registrada"
            );

            await refresh();

            location.hash =
              action === "approve" ||
              action === "return"
                ? "#revision"
                : "#gestion";

            render();
          } catch (error) {
            toast(
              error.message
            );
          }
        };
    });
}

async function manage() {
  if (!requireAdmin()) return;

  const rows = await api(
    "/contents?manage=1"
  );

  main.innerHTML = `
    <section class="section wrap">
      ${pageTitle(
        "Gestión",
        "Publicaciones"
      )}

      <div class="panel">
        ${rows.length
          ? rows.map((item) => `
              <div class="record">
                <div>
                  <strong>
                    ${escapeHTML(
                      item.title
                    )}
                  </strong>

                  <span class="badge">
                    ${escapeHTML(
                      item.status
                    )}
                  </span>
                </div>

                ${button(
                  "Abrir",
                  "#revisar/" +
                    item.id
                )}
              </div>
            `).join("")
          : `
            <p class="empty">
              No hay publicaciones.
            </p>
          `}
      </div>
    </section>
  `;
}

async function users() {
  if (!requireAdmin()) return;

  const rows = await api(
    "/users"
  );

  main.innerHTML = `
    <section class="section wrap">
      ${pageTitle(
        "Administración",
        "Cuentas y permisos"
      )}

      <div class="panel">
        ${rows.map((user) => `
          <div class="record">
            <div>
              <strong>
                ${escapeHTML(
                  user.name
                )}
              </strong>

              <br>

              ${escapeHTML(
                user.email
              )}
            </div>

            <form
              class="row-actions user-form"
            >
              <input
                type="hidden"
                name="id"
                value="${user.id}"
              >

              <select
                name="role"
                aria-label="Rol"
              >
                ${[
                  "estudiante",
                  "docente",
                  "administrador"
                ].map((role) => `
                  <option
                    ${
                      role ===
                      user.role
                        ? "selected"
                        : ""
                    }
                  >
                    ${role}
                  </option>
                `).join("")}
              </select>

              <label class="checkbox">
                <input
                  type="checkbox"
                  name="active"
                  ${
                    user.active
                      ? "checked"
                      : ""
                  }
                >

                Activo
              </label>

              <button class="btn">
                Guardar
              </button>
            </form>
          </div>
        `).join("")}
      </div>
    </section>
  `;

  main
    .querySelectorAll(
      ".user-form"
    )
    .forEach((form) => {
      form.onsubmit =
        async (event) => {
          event.preventDefault();

          const data =
            Object.fromEntries(
              new FormData(form)
            );

          data.active =
            Boolean(
              data.active
            );

          try {
            await api(
              "/users",
              data
            );

            toast(
              "Usuario actualizado"
            );

            users();
          } catch (error) {
            toast(
              error.message
            );
          }
        };
    });
}

async function audit() {
  if (!requireAdmin()) return;

  const rows = await api(
    "/audit"
  );

  main.innerHTML = `
    <section class="section wrap">
      ${pageTitle(
        "Administración",
        "Historial de cambios"
      )}

      <div class="panel">
        ${rows.map((entry) => `
          <div class="record">
            <span>
              Contenido
              ${entry.content_id}
              ·
              ${escapeHTML(
                entry.action
              )}
            </span>

            <span>
              ${escapeHTML(
                entry.created_at
              )}
            </span>
          </div>
        `).join("")}
      </div>
    </section>
  `;
}

async function moderation() {
  if (!requireAdmin()) return;

  const rows = await api(
    "/moderation"
  );

  main.innerHTML = `
    <section class="section wrap">
      ${pageTitle(
        "Comunidad",
        "Moderar comentarios"
      )}

      <div class="panel">
        ${rows.length
          ? rows.map((comment) => `
              <div class="record">
                <div>
                  <strong>
                    ${escapeHTML(
                      comment.name
                    )}
                  </strong>

                  <p>
                    ${escapeHTML(
                      comment.body
                    )}
                  </p>
                </div>

                <div class="row-actions">
                  <button
                    class="btn"
                    data-id="${comment.id}"
                    data-status="aprobado"
                  >
                    Aprobar
                  </button>

                  <button
                    class="btn btn-outline"
                    data-id="${comment.id}"
                    data-status="oculto"
                  >
                    Ocultar
                  </button>
                </div>
              </div>
            `).join("")
          : `
            <p class="empty">
              No hay comentarios
              pendientes.
            </p>
          `}
      </div>
    </section>
  `;

  main
    .querySelectorAll(
      "[data-status]"
    )
    .forEach((element) => {
      element.onclick =
        async () => {
          try {
            await api(
              "/moderation",
              {
                id:
                  element.dataset.id,
                status:
                  element.dataset.status
              }
            );

            moderation();
          } catch (error) {
            toast(
              error.message
            );
          }
        };
    });
}

async function refresh() {
  [me, items, stats] =
    await Promise.all([
      api("/me"),
      api("/contents"),
      api("/stats")
    ]);

  $("#accessLink").textContent =
    me ? "Mi panel" : "Ingresar";

  $("#accessLink").href =
    me ? "#panel" : "#acceso";
}

async function render() {
  const path =
    decodeURIComponent(
      location.hash
        .slice(1)
        .split("?")[0] ||
        "inicio"
    );

  const [route, argument] =
    path.split("/");

  try {
    if (route === "inicio") {
      home();
    } else if (
      route === "explorar" ||
      Object.hasOwn(
        kinds,
        route
      )
    ) {
      explorer(
        route === "explorar"
          ? ""
          : route
      );
    } else if (
      route === "detalle"
    ) {
      await detail(
        Number(argument)
      );
    } else if (
      route === "acceso"
    ) {
      me
        ? panel()
        : access();
    } else if (
      route === "panel"
    ) {
      panel();
    } else if (
      route === "aporte"
    ) {
      await contribution(
        argument
          ? Number(argument)
          : null
      );
    } else if (
      route === "mis-aportes"
    ) {
      await myItems();
    } else if (
      route === "favoritos"
    ) {
      await favorites();
    } else if (
      route === "revision"
    ) {
      await reviewQueue();
    } else if (
      route === "revisar"
    ) {
      await review(
        Number(argument)
      );
    } else if (
      route === "gestion"
    ) {
      await manage();
    } else if (
      route === "usuarios"
    ) {
      await users();
    } else if (
      route === "auditoria"
    ) {
      await audit();
    } else if (
      route === "moderacion"
    ) {
      await moderation();
    } else {
      home();
    }

    if (route !== "inicio") {
      window.scrollTo(0, 0);
    }
  } catch (error) {
    main.innerHTML = `
      <section class="section wrap">
        <h1>
          No se pudo abrir
          esta sección
        </h1>

        <p>
          ${escapeHTML(
            error.message
          )}
        </p>

        ${button(
          "Volver al inicio",
          "#inicio"
        )}
      </section>
    `;
  }
}

$("#menuButton").onclick = () => {
  const navigation = $("#nav");
  const isOpen =
    navigation.classList.toggle(
      "open"
    );

  $("#menuButton").setAttribute(
    "aria-expanded",
    String(isOpen)
  );

  $("#menuButton")
    .firstChild.textContent =
      isOpen ? "× " : "☰ ";
};

$("#nav").onclick = (event) => {
  if (
    event.target.closest("a")
  ) {
    $("#nav").classList.remove(
      "open"
    );

    $("#menuButton").setAttribute(
      "aria-expanded",
      "false"
    );
  }
};

window.addEventListener(
  "hashchange",
  render
);

refresh()
  .then(render)
  .catch((error) => {
    main.innerHTML = `
      <section class="section wrap">
        <h1>
          No se pudo iniciar
          el museo
        </h1>

        <p>
          ${escapeHTML(
            error.message
          )}
        </p>
      </section>
    `;
  });