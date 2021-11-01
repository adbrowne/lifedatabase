const express = require('express')
const app = express()
const port = process.env.PORT || 3000

app.get('/', (req: any, res: any) => {
  res.send('Hello World!')
})

app.get('/echo', (req: any, res: any) => {
  res.send(req.headers)
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
