import type { NextApiRequest, NextApiResponse } from 'next'
import { uniqueNamesGenerator, Config, adjectives, colors, animals } from 'unique-names-generator'
import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

type json = {
    id: number,
    Action: string | undefined,
    type: string
}


const customConfig: Config = {
    dictionaries: [adjectives, colors, animals],
    separator: '-',
    length: 8,
};

const shortName: string = uniqueNamesGenerator(customConfig); // big-donkey


export default async function handler(
    req: NextApiRequest,
    res: NextApiResponse
) {
    if (req.method !== 'PUT') {
        res.status(405).send({ message: 'Wrong type of request was made, please try a different one!'})
        return
    }
    const json:json = req.body
    if (json.id !== undefined) return

    const checkIsInDB = await prisma.turtle.findUnique({ where: { id: json.id} })
    if (!checkIsInDB ) {
        if (json.type == 'turtle') {
            prisma.turtle.create({
                data:{
                    id: json.id,
                    name: shortName,
                    lastSeen: new Date(),
                    Action: json.Action || undefined,
                    Active: true,
                }
            })
        }else if (json.type == 'master') {
            prisma.master.create({
                data:{
                    id: json.id,
                    name: shortName,
                    lastSeen: new Date(),
                    Action: json.Action || undefined,
                    Active: true,
                }
            })
        }
        res.status(200).send({ message: 'Status updated successfully!'})
        return
    }

    if (json.type == 'turtle') {
        prisma.turtle.update({
            where: {id: json.id},
            data: {
                lastSeen: new Date(),
                Action: json.Action || undefined,
                Active: true,
            }
        })
    }else if (json.type == 'master') {
        prisma.master.update({
            where: {id: json.id},
            data: {
                lastSeen: new Date(),
                Action: json.Action || undefined,
                Active: true,
            }
        })
    }
}