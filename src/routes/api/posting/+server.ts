import { getPool } from "$lib/server/db/config";
import { json } from "@sveltejs/kit";
import { writeFileSync } from "fs";

export async function GET({ url }) {
  const db = getPool();

  const data = {
    posts: [],
    totalPage: 0,
  };
  const page = Number(url.searchParams.get("page")) || 1;
  const limit = Number(url.searchParams.get("limit")) || 5;
  //total page
  const totalData = await db.query(`SELECT COUNT(*) as total FROM post`);
  data.totalPage = Math.ceil(totalData[0].total / limit);
  //data post
  const start = (page - 1) * limit;
  const posts = await db.query("SELECT * FROM post ORDER BY created_at DESC LIMIT ?, ?", [start, limit]);
  data.posts = posts;

  return json(data);
}

export async function POST({ request }) {
  const db = getPool();

  const data = await request.formData();
  const judul = data.get("judul");
  const kategori = data.get("kategori");
  const deskripsi = data.get("deskripsi");
  const gambar = data.get("gambar");

  let fileName = "";
  if (gambar) {
    // handle file, first get file extension
    const fileExt = (gambar as File).name.split(".").pop();
    // generate random file name
    fileName = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15) + "." + fileExt;
    // write file
    writeFileSync(`./static/img/${fileName}`, Buffer.from(await (gambar as File).arrayBuffer()));
    // change file path to /img/blog/main/fileName
    fileName = `/img/${fileName}`;
  }
  try {
    await db.query(`INSERT INTO post VALUES (NULL, ?, ?, ?, ?, NOW(), NOW())`, [kategori, judul, deskripsi, fileName]);
  } catch (error) {
    console.log(error);
  }

  return json({ status: "success" });
}
