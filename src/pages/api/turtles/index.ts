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
          "Action": "Mining",
          "LastSeen": "2023-06-25",
          "Active": true
        },
        {
          "Name": "Emily",
          "Id": 2,
          "Action": "Idle",
          "LastSeen": "2023-06-26",
          "Active": true
        },
        {
          "Name": "John",
          "Id": 3,
          "Action": "Expantion",
          "LastSeen": "2023-06-24",
          "Active": true
        },
        {
          "Name": "Sarah",
          "Id": 4,
          "Action": "N/A",
          "LastSeen": "2023-06-25",
          "Active": false
        },
        {
          "Name": "Michael",
          "Id": 5,
          "Action": "Servalance",
          "LastSeen": "2023-06-26",
          "Active": true
        },
        {
          "Name": "Emma",
          "Id": 6,
          "Action": "Farming",
          "LastSeen": "2023-06-25",
          "Active": true
        }
    ]

    res.status(200).json(data)
}