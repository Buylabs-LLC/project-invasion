import type { NextApiRequest, NextApiResponse } from 'next'
 
type ResponseData = {
  message: string
}
 
export default function handler(
    req: NextApiRequest,
    res: NextApiResponse<ResponseData>
) {
    let data:any = [
        {
          "Name": "James",
          "Id": 1,
          "Action": "Logging",
          "LastSeen": "2023-06-25",
          "Active": true
        }
    ]

    res.status(200).json(data)
}