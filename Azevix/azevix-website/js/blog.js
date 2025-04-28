document.addEventListener("DOMContentLoaded", function() {
    const newsContainer = document.getElementById("news-container");

    newsData.forEach(news => {
        const newsItem = document.createElement("div");
        newsItem.className = "news-item";

        const newsTitle = document.createElement("h3");
        newsTitle.textContent = news.title;

        const newsDate = document.createElement("p");
        newsDate.textContent = `Publicado em: ${news.date}`;

        const newsSummary = document.createElement("p");
        newsSummary.textContent = news.summary;

        const newsLink = document.createElement("a");
        newsLink.href = news.link;
        newsLink.textContent = "Leia mais";

        newsItem.appendChild(newsTitle);
        newsItem.appendChild(newsDate);
        newsItem.appendChild(newsSummary);
        newsItem.appendChild(newsLink);

        newsContainer.appendChild(newsItem);
    });
});
