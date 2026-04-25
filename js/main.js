// Branded preloader transition.
    const preloader = document.getElementById("preloader");
    const hidePreloader = () => {
      if (!preloader) return;
      preloader.classList.add("hidden");
      document.body.classList.remove("is-loading");
    };

    window.addEventListener("load", () => {
      setTimeout(hidePreloader, 1500);
    });

    // Safety fallback if any external asset hangs.
    setTimeout(hidePreloader, 2500);

    // Reveal-on-scroll animation for sections and cards.
    const revealItems = document.querySelectorAll(".reveal");
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("visible");
            observer.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.14, rootMargin: "0px 0px -40px 0px" }
    );

    revealItems.forEach((item) => observer.observe(item));

    // Simple active state for nav links while scrolling.
    const sections = document.querySelectorAll("main section[id]");
    const navLinks = document.querySelectorAll(".menu a");

    window.addEventListener("scroll", () => {
      const marker = window.scrollY + 120;
      sections.forEach((section) => {
        const top = section.offsetTop;
        const height = section.offsetHeight;
        const id = section.getAttribute("id");
        if (marker >= top && marker < top + height) {
          navLinks.forEach((link) => {
            const isCurrent = link.getAttribute("href") === "#" + id;
            link.style.color = isCurrent ? "var(--metal-strong)" : "";
          });
        }
      });
    });
