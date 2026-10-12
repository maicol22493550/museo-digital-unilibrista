/* Portada inspirada en el prototipo de Figma. Conserva el backend y las
   pantallas de aportes, validación y administración de app.js. */
(() => {
  const sectionCards = [
    ["historia", "📜", "Historia", "Línea del tiempo y memoria histórica"],
    ["proyecto", "⚙️", "Proyectos", "Innovación, software e impacto"],
    ["investigacion", "🔬", "Investigación", "Grupos, semilleros y publicaciones"],
    ["premio", "🏆", "Premios", "Logros y reconocimientos nacionales"],
    ["persona", "⭐", "Hall de la Fama", "Personas que dejaron huella"],
    ["galeria", "🖼️", "Galería", "Fotos, videos y documentos"]
  ];
  let projectCategory = "Todos";
  let hallCategory = "Todos";
  let awardIndex = 0;

  const sectionHead = (overline, title, link = "") => `
    <div class="section-heading">
      <div><p class="eyebrow">${overline}</p><h2>${title}</h2></div>
      ${link ? `<a class="all-link" href="${link}">Ver todo →</a>` : ""}
    </div>`;
  const empty = (message) => `<p class="empty">${message}</p>`;
  const cards = (records, message) => records.length
    ? `<div class="grid feature-grid">${records.slice(0, 6).map(card).join("")}</div>`
    : empty(message);
  const section = (id, overline, title, records, message, tone = "") => `
    <section id="${id}" class="museum-section ${tone}">
      <div class="wrap">${sectionHead(overline, title, `#${id === "historia" ? "historia" : id}`)}
        ${cards(records, message)}</div>
    </section>`;
  const stat = (value, label) => `<div><strong>${value}</strong><span>${label}</span></div>`;

  home = function () {
    const published = Array.isArray(items) ? items.filter((x) =>
      x.source !== "Contenido demostrativo" &&
      !String(x.source || "").startsWith("Archivo demostrativo;")) : [];
    const history = published.filter((x) => x.kind === "historia")
      .sort((a, b) => Number(a.year) - Number(b.year));
    const projects = published.filter((x) => x.kind === "proyecto");
    const research = published.filter((x) => x.kind === "investigacion");
    const awards = published.filter((x) => x.kind === "premio");
    const people = published.filter((x) => x.kind === "persona");
    const events = published.filter((x) => x.kind === "evento");
    const gallery = published.filter((x) => x.image && x.kind !== "galeria");
    const categories = ["Todos", ...new Set(projects.map((x) => x.category).filter(Boolean))];
    const hallCategories = ["Todos", ...new Set(people.map((x) => x.category).filter(Boolean))];
    if (!history.some((x) => x.id === selectedYear)) selectedYear = history[0]?.id || 0;
    if (!categories.includes(projectCategory)) projectCategory = "Todos";
    if (!hallCategories.includes(hallCategory)) hallCategory = "Todos";
    if (awardIndex >= awards.length) awardIndex = 0;
    const milestone = history.find((x) => x.id === selectedYear);
    const award = awards[awardIndex];
    const shownProjects = projectCategory === "Todos" ? projects : projects.filter((x) => x.category === projectCategory);
    const shownPeople = hallCategory === "Todos" ? people : people.filter((x) => x.category === hallCategory);
    const upcoming = events.filter((x) => Number(x.year) >= new Date().getFullYear());
    const past = events.filter((x) => Number(x.year) < new Date().getFullYear());

    main.innerHTML = `
      <section id="portada" class="hero">
        <div class="hero-pattern" aria-hidden="true"></div>
        <div class="wrap hero-inner">
          <p class="hero-overline">Memoria · Innovación · Comunidad</p>
          <h1>Museo Digital<br>Unilibrista</h1>
          <p>La historia que construimos.<br>El legado que compartimos.</p>
          <div class="actions">
            <a class="btn btn-white" href="#inicio/secciones">Explorar el museo</a>
            <a class="btn btn-transparent" href="#inicio/historia">Recorrer la línea del tiempo</a>
          </div>
        </div>
      </section>

      <section id="secciones" class="museum-section">
        <div class="wrap">
          ${sectionHead("Navega el museo", "Explora nuestra memoria")}
          <div class="section-grid">
            ${sectionCards.map(([key, icon, title, description]) => `
              <a class="section-tile" href="#inicio/${key}">
                <span class="section-emoji" aria-hidden="true">${icon}</span>
                <h3>${title}</h3><p>${description}</p>
              </a>`).join("")}
          </div>
        </div>
      </section>

      <section id="historia" class="museum-section history-section">
        <div class="wrap">
          ${sectionHead("Historia", "Un recorrido por nuestra historia", "#historia")}
          <p class="lead">30 años construyendo ingenieros, conocimiento y comunidad.</p>
          ${history.length ? `
            <div class="timeline-tabs" aria-label="Seleccionar año">
              ${history.map((x) => `<button class="timeline-tab ${x.id === selectedYear ? "active" : ""}" type="button" data-year="${x.id}" aria-pressed="${x.id === selectedYear}">${escapeHTML(x.year)}</button>`).join("")}
            </div>
            <article class="history-detail">
              <div class="history-tag">Hito · ${escapeHTML(milestone.year)}</div>
              <h3>${escapeHTML(milestone.title)}</h3>
              <p>${escapeHTML(milestone.description)}</p>
              ${milestone.image ? `<img class="history-image" src="${safeURL(milestone.image)}" alt="${escapeHTML(milestone.alt || "Imagen ilustrativa del acontecimiento")}" loading="lazy">` : ""}
              <div class="row-actions">
                <button class="btn btn-soft" type="button" data-year-step="-1" ${selectedYear === history[0].id ? "disabled" : ""}>← Anterior</button>
                <button class="btn btn-soft" type="button" data-year-step="1" ${selectedYear === history.at(-1).id ? "disabled" : ""}>Siguiente →</button>
                <a class="btn" href="#detalle/${milestone.id}">Ver historia</a>
              </div>
            </article>` : empty("Todavía no se han publicado hitos históricos.")}
        </div>
      </section>

      <section id="proyecto" class="museum-section">
        <div class="wrap">
          ${sectionHead("Proyectos", "Proyectos destacados", "#proyecto")}
          <div class="filter-pills" aria-label="Filtrar proyectos">
            ${categories.map((x, i) => `<button type="button" class="pill ${x === projectCategory ? "active" : ""}" data-project="${i}">${escapeHTML(x)}</button>`).join("")}
          </div>
          ${cards(shownProjects, "Todavía no hay proyectos publicados en esta categoría.")}
        </div>
      </section>

      ${section("investigacion", "Investigación", "Conocimiento creado en comunidad", research, "Todavía no hay investigaciones publicadas.", "soft-section")}

      <section id="premio" class="museum-section awards-section">
        <div class="wrap">
          ${sectionHead("Reconocimientos", "Premios y reconocimientos")}
          ${award ? `<div class="award-showcase">
            <div class="award-image"><img src="${safeURL(award.image || demoImages.premio)}" alt="${escapeHTML(award.image ? award.alt || award.title : "Imagen ilustrativa del premio")}" loading="lazy"></div>
            <div class="award-info">
              <div class="award-dots">${awards.map((_, i) => `<button type="button" class="award-dot ${i === awardIndex ? "active" : ""}" data-award="${i}" aria-label="Ver premio ${i + 1}"></button>`).join("")}</div>
              <span class="award-year">★ ${escapeHTML(award.year)}</span>
              <h3>${escapeHTML(award.title)}</h3>
              <p>📍 ${escapeHTML(award.category || "Reconocimiento")}</p>
              <p>👥 ${escapeHTML(award.protagonist || "Comunidad unilibrista")}</p>
              <div class="row-actions">
                <button class="round-button" type="button" data-award-step="-1" aria-label="Premio anterior">←</button>
                <a class="btn btn-gold" href="#detalle/${award.id}">Ver detalle</a>
                <button class="round-button" type="button" data-award-step="1" aria-label="Premio siguiente">→</button>
              </div>
            </div>
          </div>` : empty("Todavía no hay premios publicados.")}
        </div>
      </section>

      <section id="persona" class="museum-section">
        <div class="wrap">
          ${sectionHead("Hall de la Fama", "Personas que dejaron huella", "#persona")}
          <div class="filter-pills" aria-label="Filtrar perfiles">
            ${hallCategories.map((x, i) => `<button type="button" class="pill ${x === hallCategory ? "active" : ""}" data-person="${i}">${escapeHTML(x)}</button>`).join("")}
          </div>
          ${cards(shownPeople, "Todavía no hay perfiles publicados en esta categoría.")}
        </div>
      </section>

      <section id="evento" class="museum-section soft-section">
        <div class="wrap">
          ${sectionHead("Agenda", "Próximos eventos", "#evento")}
          <h3 class="subheading">Próximos</h3>
          ${cards(upcoming, "No hay eventos próximos publicados.")}
          ${past.length ? `<h3 class="subheading past-heading">Realizados</h3>${cards(past, "")}` : ""}
        </div>
      </section>

      ${section("galeria", "Galería", "Memorias para ver y compartir", gallery, "Todavía no hay imágenes publicadas.")}

      <section class="museum-section impact">
        <div class="wrap">
          ${sectionHead("Impacto", "Nuestra historia en cifras")}
          <div class="numbers">
            ${stat(stats.proyecto || 0, "Proyectos")}
            ${stat(stats.premio || 0, "Premios")}
            ${stat(stats.investigacion || 0, "Investigaciones")}
            ${stat(stats.persona || 0, "Personas destacadas")}
            ${stat(stats.evento || 0, "Eventos")}
            ${stat(stats.historia || 0, "Hitos históricos")}
          </div>
        </div>
      </section>

      <section class="cta">
        <div class="wrap cta-inner">
          <h2>Nuestra historia también la construyes tú</h2>
          <p>Comparte una memoria, un proyecto, un logro o un testimonio. Tu aporte enriquece el legado del programa.</p>
          <a class="btn btn-white" href="#aporte">Comparte una memoria →</a>
        </div>
      </section>`;

    main.querySelectorAll("[data-year]").forEach((el) => {
      el.onclick = () => { selectedYear = Number(el.dataset.year); home(); document.getElementById("historia")?.scrollIntoView(); };
    });
    main.querySelectorAll("[data-year-step]").forEach((el) => {
      el.onclick = () => {
        const i = history.findIndex((x) => x.id === selectedYear) + Number(el.dataset.yearStep);
        if (history[i]) { selectedYear = history[i].id; home(); document.getElementById("historia")?.scrollIntoView(); }
      };
    });
    main.querySelectorAll("[data-project]").forEach((el) => {
      el.onclick = () => { projectCategory = categories[Number(el.dataset.project)]; home(); document.getElementById("proyecto")?.scrollIntoView(); };
    });
    main.querySelectorAll("[data-person]").forEach((el) => {
      el.onclick = () => { hallCategory = hallCategories[Number(el.dataset.person)]; home(); document.getElementById("persona")?.scrollIntoView(); };
    });
    main.querySelectorAll("[data-award]").forEach((el) => {
      el.onclick = () => { awardIndex = Number(el.dataset.award); home(); document.getElementById("premio")?.scrollIntoView(); };
    });
    main.querySelectorAll("[data-award-step]").forEach((el) => {
      el.onclick = () => { awardIndex = (awardIndex + Number(el.dataset.awardStep) + awards.length) % awards.length; home(); document.getElementById("premio")?.scrollIntoView(); };
    });
  };

  function scrollToSection() {
    const [route, sectionId] = decodeURIComponent(location.hash.slice(1)).split("/");
    if (route !== "inicio" || !sectionId) return;
    const target = sectionId === "secciones" ? "secciones" : sectionId;
    requestAnimationFrame(() => document.getElementById(target)?.scrollIntoView({ behavior: "smooth" }));
  }
  window.addEventListener("hashchange", scrollToSection);
  window.addEventListener("load", () => setTimeout(scrollToSection, 100));

  const extraStyles = document.createElement("style");
  extraStyles.textContent = `
    .history-image { display:block; width:100%; max-height:240px; object-fit:cover;
      margin:25px 0 0; border-radius:12px }
    .gallery-grid { columns:4; column-gap:16px }
    .gallery-card { break-inside:avoid; overflow:hidden; margin-bottom:16px;
      border:1px solid #eee; border-radius:12px; background:#fff; cursor:pointer }
    .gallery-card img { display:block; width:100%; height:auto }
    .gallery-card p { margin:0; padding:10px 12px; color:#686868; font-size:12px }
    .gallery-modal { position:fixed; z-index:110; inset:0; display:grid; place-items:center;
      padding:28px; background:#000e }
    .gallery-modal-content { position:relative; max-width:920px; width:100%; text-align:center; color:#fff }
    .gallery-modal img { max-width:100%; max-height:75vh; object-fit:contain; border-radius:9px }
    .gallery-modal button { position:absolute; top:-47px; right:0; border:0; background:none;
      color:#fff; font-size:26px }
    @media(max-width:900px) { .gallery-grid { columns:3 } }
    @media(max-width:600px) { .gallery-grid { columns:2 } }
  `;
  document.head.append(extraStyles);

  // El prototipo usa una galería con las fotos de todos los contenidos.
  const originalExplorer = explorer;
  explorer = function (kind = "") {
    if (kind !== "galeria") return originalExplorer(kind);
    const allPhotos = (Array.isArray(items) ? items : []).filter((x) =>
      x.image && x.kind !== "galeria" && x.source !== "Contenido demostrativo" &&
      !String(x.source || "").startsWith("Archivo demostrativo;"));
    const years = [...new Set(allPhotos.map((x) => x.year))].sort((a, b) => b - a);
    main.innerHTML = `<section class="section wrap">
      <p class="eyebrow">Galería</p><h1 class="page-title">Archivo visual histórico</h1>
      <p class="lead">Fotografías ilustrativas reunidas desde las secciones del museo.</p>
      <label for="galleryYear">Año</label>
      <select id="galleryYear"><option value="">Todos</option>
      ${years.map((x) => `<option value="${x}">${x}</option>`).join("")}</select>
      <p id="galleryCount" class="muted"></p><div id="galleryResults"></div>
    </section>`;
    function draw() {
      const year = document.getElementById("galleryYear").value;
      const records = allPhotos.filter((x) => !year || String(x.year) === year);
      document.getElementById("galleryCount").textContent = `${records.length} fotografías`;
      document.getElementById("galleryResults").innerHTML = `<div class="gallery-grid">
        ${records.map((x) => `<article class="gallery-card" data-photo="${x.id}" tabindex="0" role="button" aria-label="Ampliar ${escapeHTML(x.title)}">
          <img src="${safeURL(x.image)}" alt="${escapeHTML(x.alt || "Imagen ilustrativa")}" loading="lazy">
          <p>${escapeHTML(x.year)} · ${escapeHTML(x.title)}</p>
        </article>`).join("")}</div>`;
      document.querySelectorAll("[data-photo]").forEach((el) => {
        const open = () => {
          const x = records.find((r) => r.id === Number(el.dataset.photo));
          if (!x) return;
          const overlay = document.createElement("div");
          overlay.className = "gallery-modal";
          overlay.setAttribute("role", "dialog");
          overlay.setAttribute("aria-modal", "true");
          overlay.setAttribute("aria-label", x.title);
          overlay.innerHTML = `<div class="gallery-modal-content">
            <button type="button" aria-label="Cerrar imagen">×</button>
            <img src="${safeURL(x.image)}" alt="${escapeHTML(x.alt || "Imagen ilustrativa")}">
            <p>${escapeHTML(x.title)}</p><a class="btn" href="#detalle/${x.id}">Ver contenido →</a>
          </div>`;
          overlay.onclick = (event) => {
            if (event.target === overlay || event.target.closest("button") || event.target.closest("a")) { overlay.remove(); el.focus(); }
          };
          overlay.onkeydown = (event) => {
            if (event.key === "Escape") { overlay.remove(); el.focus(); }
            if (event.key === "Tab") {
              const controls = overlay.querySelectorAll("button,a");
              if (event.shiftKey && document.activeElement === controls[0]) { event.preventDefault(); controls[controls.length-1].focus(); }
              else if (!event.shiftKey && document.activeElement === controls[controls.length-1]) { event.preventDefault(); controls[0].focus(); }
            }
          };
          document.body.append(overlay);
          overlay.querySelector("button").focus();
        };
        el.onclick = open;
        el.onkeydown = (event) => { if (event.key === "Enter") open(); };
      });
    }
    document.getElementById("galleryYear").onchange = draw;
    draw();
  };

  // El identificador de importación queda en la base de datos para evitar
  // duplicados, pero en pantalla mostramos la procedencia en lenguaje claro.
  const originalDetail = detail;
  detail = async function (id) {
    await originalDetail(id);
    const source = main.querySelector(".detail .panel .small.muted");
    if (source && source.textContent.includes("[FIGMA:")) {
      source.textContent = source.textContent.replace(
        /EJEMPLO FICTICIO DEL PROTOTIPO FIGMA \[FIGMA:[^\]]+\]\. No es un hecho verificado de Universidad Libre Barranquilla\. Referencia mencionada en el prototipo, sin verificar:/,
        "Contenido del prototipo académico, pendiente de verificación institucional. Referencia indicada:"
      );
    }
  };

})();
