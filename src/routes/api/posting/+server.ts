import { getPool } from "$lib/server/db/config";
import { json } from "@sveltejs/kit";
import { writeFileSync } from "fs";

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
