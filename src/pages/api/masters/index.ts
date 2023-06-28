import type { NextApiRequest, NextApiResponse } from 'next'
import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()
 
type ResponseData = {
  message: string
}
 
export default function handler(
    req: NextApiRequest,
    res: NextApiResponse<ResponseData>
) {
    let data:any = prisma.master.findMany()

    res.status(200).json(data)
}