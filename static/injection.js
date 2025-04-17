async function Search() {
    const query = document.getElementById('search-input').value;
    const resultsDiv = document.getElementById('results');
    const security = document.getElementById('toggle-insecure').checked;
    
    if (query.trim() === '') {
        resultsDiv.innerHTML = '<p>Please enter a search term.</p>';
        return;
    }
    
    try {
        const response = await fetch('/search', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ security, query })
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        
        const data = await response.json();

        if (data.error) {
            resultsDiv.innerHTML = `<p style="color: red;">${data.error}</p>`;
        } else {
            let security = data.mode;
            let output = `<h3>Results (${security ? "Secure" : "<span style='color: red;'>Insecure</span>"} mode):</h3><ul>`;
            
            data.results.forEach(item => {
                output += "<li><strong>Item:</strong> <ul>";
                for (const [key, value] of Object.entries(item)) {
                    output += `<li><strong>${key}:</strong> ${value}</li>`;
                }
                output += "</ul></li>";
            });
            
            output += "</ul>";
            
            resultsDiv.innerHTML = output;            
        }

    } catch (error) {
        resultsDiv.innerHTML = "<p style='color: red;'>Error fetching results.</p>";    }
}

// async function Test() {
//     const query = document.getElementById('search-input').value;
//     const resultsDiv = document.getElementById('results');
    
//     if (query.trim() === '') {
//         resultsDiv.innerHTML = '<p>Please enter a search.</p>';
//         return;
//     }
    
//     try {
//         const response = await fetch('/test', {
//             method: 'POST',
//             headers: {
//                 'Content-Type': 'application/json'
//             },
//             body: JSON.stringify({ query })
//         });

//         if (!response.ok) {
//             throw new Error('Network response was not ok');
//         }
        
//         const data = await response.json();

//         if (data.error) {
//             resultsDiv.innerHTML = `<p style="color: red;">${data.error}</p>`;
//         } else {
//             let output = ``;
            
//             data.results.forEach(item => {
//                 output += "<li><strong>Item:</strong> <ul>";
//                 for (const [key, value] of Object.entries(item)) {
//                     output += `<li><strong>${key}:</strong> ${value}</li>`;
//                 }
//                 output += "</ul></li>";
//             });
            
//             output += "</ul>";
            
//             resultsDiv.innerHTML = output;            
//         }

//     } catch (error) {
//         resultsDiv.innerHTML = "<p style='color: red;'>Error fetching results.</p>";    }
// }