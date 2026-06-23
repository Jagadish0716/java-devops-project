<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>E-Commerce Application</title>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background: #f4f7fb;
      color: #1f2937;
    }
    main {
      max-width: 920px;
      margin: 0 auto;
      padding: 48px 20px;
    }
    h1 {
      margin-bottom: 8px;
    }
    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 16px;
      margin-top: 28px;
    }
    .product {
      background: #fff;
      border: 1px solid #d7dee8;
      border-radius: 8px;
      padding: 18px;
    }
    .price {
      font-weight: 700;
      color: #047857;
    }
  </style>
</head>
<body>
  <main>
    <h1>E-Commerce Application</h1>
    <p>Sample storefront deployed through Jenkins, Maven, Docker, Docker Hub, and Docker Swarm.</p>
    <section class="grid" aria-label="Featured products">
      <article class="product">
        <h2>Wireless Headphones</h2>
        <p>Noise-isolating headphones for everyday listening.</p>
        <p class="price">$79</p>
      </article>
      <article class="product">
        <h2>Smart Watch</h2>
        <p>Fitness tracking and notifications in one compact device.</p>
        <p class="price">$129</p>
      </article>
      <article class="product">
        <h2>Travel Backpack</h2>
        <p>Durable storage for work, trips, and daily carry.</p>
        <p class="price">$59</p>
      </article>
    </section>
  </main>
</body>
</html>
