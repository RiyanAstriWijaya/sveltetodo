<script lang="ts">
  import { PUBLIC_API_URL as API_URL } from '$env/static/public';
  import { onMount } from "svelte";


let editing = false;
let limit = '5';
let page = 1;
let search = '';

let posts : any[]=[];
let totalPage = 0;
  async function loadBlog(){
  const respon = await fetch(`${API_URL}/api/posting?page=${page}&limit=${limit}&search=${search}`);
  const data = await respon.json();
  posts = data.posts;
  totalPage = data.totalPage;
}
function reloadData(){
  page = 1;
  loadBlog();
}
function nextPage(){
  page += 1;
  loadBlog()
}
function prevPage(){
  page -= 1;
  loadBlog()
}

onMount(()=>{
  loadBlog()
})
let idPost = 0;
function editPosting(i?: number) {
  editing = true;
  if (i != undefined){
  judul = posts[i].judul;
  kategori = posts[i].kategori.toString();
  deskripsi = posts[i].deskripsi;
  gambar = posts[i].gambar;
  idPost = posts[i].id
}
}

function cancelEdit() {
  editing = false;
  judul = '';
  kategori = '';
  deskripsi = '1';
  gambar = null;
  idPost = 0;
}

let judul = '';
let kategori = '1';
let deskripsi = '';
let gambar: string | null | File = null;
function updateGambar(event: any) {
  gambar = event.target.files[0];
}

async function savePost() {
  if (judul == '' || deskripsi == '' || gambar == null) {
    alert('Semua field harus diisi');
    return;
  }

  const formData = new FormData();
  formData.append('judul', judul);
  formData.append('kategori', kategori);
  formData.append('deskripsi', deskripsi);
  formData.append('gambar', gambar);

  let url = `${API_URL}/api/posting`;
  if(idPost > 0){
    url += `/${idPost}`
  }

  await fetch(url, {
    method: idPost > 0 ? 'PUT' : 'POST',
    body: formData
  });

  
  cancelEdit();
  loadBlog()
}
async function hapusPosting(id:number) {
  if(confirm('apakah anda yakin')){
    await fetch(`${API_URL}/api/posting/${id}`, {
      method: "DELETE"
    });
  loadBlog()
}
}
</script>

<div class="container mx-auto">
  {#if !editing}
  <!-- Table Section -->
  <div class="max-w-[85rem] px-4 pt-10 sm:px-6 lg:px-8 lg:py-14 mx-auto">
    <!-- Card -->
    <div class="bg-white border border-gray-200 rounded-xl shadow-sm overflow-hidden">
      <!-- Header -->
      <div class="px-6 py-4 grid gap-3 md:flex md:justify-between md:items-center border-b border-gray-200">
        <!-- Input -->
        <div class="sm:col-span-1">
          <label for="hs-as-table-product-review-search" class="sr-only">Cari</label>
          <div class="relative">
            <input type="text" bind:value={search} on:keyup={()=>loadBlog()} id="hs-as-table-product-review-search" name="hs-as-table-product-review-search" class="py-2 px-3 ps-11 block w-full border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none" placeholder="Search">
            <div class="absolute inset-y-0 start-0 flex items-center pointer-events-none ps-4">
              <svg class="flex-shrink-0 size-4 text-gray-400" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>
            </div>
          </div>
        </div>
        <button type="button" on:click={() => editPosting()} class="tombol-biru">
          Tambah Kiriman
        </button>
        <!-- End Input -->
      </div>
      <!-- End Header -->

      <!-- Table -->
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
          <tr>
            <th scope="col" class="px-6 py-3 text-start">
              <div class="flex items-center gap-x-2">
                <span class="text-xs font-semibold uppercase tracking-wide text-gray-800">
                  Kiriman
                </span>
              </div>
            </th>
            <th scope="col" class="px-6 py-3 text-start">
              <div class="flex items-center gap-x-2">
                <span class="text-xs font-semibold uppercase tracking-wide text-gray-800">
                  Kategori
                </span>
              </div>
            </th>
            <th scope="col" class="px-6 py-3 text-start">
              <div class="flex items-center gap-x-2">
                <span class="text-xs font-semibold uppercase tracking-wide text-gray-800">
                  Tanggal
                </span>
              </div>
            </th>

            <th scope="col" class="px-6 py-3 text-start"></th>
          </tr>
        </thead>

        <tbody class="divide-y divide-gray-200">
          {#each posts as post,i }                      
          <tr class="bg-white hover:bg-gray-50">
            <td class="size-px align-top w-[75%]">
              <div class="block p-6">
                <div class="flex items-start gap-x-4">
                  <img class="flex-shrink-0 w-[38px] rounded-lg" src={`${API_URL}/${post.gambar}`} alt="gambar">
                  <div>
                    <span class="block text-lg font-medium text-gray-800"> {post.judul}</span>
                    <hr>
                    <p class="mt-2 text-sm">{post.deskripsi}</p>
                  </div>
                </div>
              </div>
            </td>
            <td class="size-px whitespace-nowrap align-top">
              <span class="block p-6">
                <span class="text-sm text-gray-600">{post.namaKategori}</span>
              </span>
            </td>
            <td class="size-px whitespace-nowrap align-top">
              <span class="block p-6">
                <span class="text-sm text-gray-600">{new Date(post.created_at).toLocaleDateString('id',{weekday:'long', year:'numeric', month:'short', day:'numeric'})}</span>
              </span>
            </td>
            <td class="size-px whitespace-nowrap align-top">
              <div class="flex p-6 justify-end">
                <button on:click={() => editPosting(i)} class="block px-2 text-blue-700">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="size-5"><path d="M21.174 6.812a1 1 0 0 0-3.986-3.987L3.842 16.174a2 2 0 0 0-.5.83l-1.321 4.352a.5.5 0 0 0 .623.622l4.353-1.32a2 2 0 0 0 .83-.497z"/><path d="m15 5 4 4"/></svg>
                </button>
                <button on:click={() => hapusPosting(post.id)} class="block px-2 text-red-700">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="size-5"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
                </button>
              </div>
            </td>
          </tr>
          {/each}
        </tbody>
      </table>
      <!-- End Table -->

      <!-- Footer -->
      <div class="px-6 py-4 grid gap-3 md:flex md:justify-between md:items-center border-t border-gray-200">
        <div class="max-w-sm space-y-3">
          <select bind:value={limit} on:change={()=> reloadData()} class="py-2 px-3 pe-9 block border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500">
            <option value="3">3</option>
            <option value="5">5</option>
            <option value="10">10</option>      
          </select>
        </div>

        <div>
          <div class="inline-flex gap-x-2">
            <button on:click={()=>prevPage()} disabled={page == 1} type="button" class="py-2 px-3 inline-flex items-center gap-x-2 text-sm font-medium rounded-lg border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none">
              <svg class="flex-shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m15 18-6-6 6-6"/></svg>
              Prev
            </button>

            <button disabled={page == totalPage || totalPage == 0} on:click={()=>nextPage()} type="button" class="py-2 px-3 inline-flex items-center gap-x-2 text-sm font-medium rounded-lg border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none">
              Next
              <svg class="flex-shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m9 18 6-6-6-6"/></svg>
            </button>
          </div>
        </div>
      </div>
      <!-- End Footer -->
    </div>
    <!-- End Card -->
  </div>
  <!-- End Table Section -->

  {:else}

  <!-- Form Section -->
  <div class="max-w-[85rem] px-4 pt-10 sm:px-6 lg:px-8 lg:py-14 mx-auto">
    <!-- Card -->
    <div class="bg-white border border-gray-200 rounded-xl shadow-sm overflow-hidden">
      <!-- Header -->
      <div class="px-6 py-4 border-b border-gray-200">
        <h2 class="text-lg font-semibold text-gray-800">Tambah / Edit Kiriman</h2>
      </div>
      <!-- End Header -->

      <!-- Form -->
      <form class="my-4">
        <div class="grid grid-cols-6 px-6 py-2">
          <div class="col-span-1 mt-2">
            <label for="judul" class="text-gray-800 text-sm font-semibold">Judul Kiriman</label>
          </div>
          <div class="col-span-5">
            <input bind:value={judul} type="text" id="judul" name="judul" class="py-4 px-3 block w-full border border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none" placeholder="Judul Kiriman">
          </div>
        </div>

        <div class="grid grid-cols-6 px-6 py-2">
          <div class="col-span-1 mt-2">
            <label for="kategori" class="text-gray-800 text-sm font-semibold">Kategori Kiriman</label>
          </div>
          <div class="col-span-2">
            <select bind:value={kategori} id="kategori" name="kategori" class="py-4 px-3 block w-full border border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500">
              <option value="1">Programming</option>
              <option value="2">Design</option>
              <option value="3">Business</option>
              <option value="4">Marketing</option>
              <option value="5">Photography</option>
            </select>
          </div>
        </div>
        
        <div class="grid grid-cols-6 px-6 py-2">
          <div class="col-span-1 mt-2">
            <label for="deskripsi" class="text-gray-800 text-sm font-semibold">Deskripsi Kiriman</label>
          </div>
          <div class="col-span-5">
            <textarea bind:value={deskripsi} id="deskripsi" name="deskripsi" class="py-4 px-3 block w-full border border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none" rows="15" placeholder="Deskripsi Kiriman"></textarea>
          </div>
        </div>

        <div class="grid grid-cols-6 px-6 py-2">
          <div class="col-span-1 mt-2">
            <label for="gambar" class="text-gray-800 text-sm font-semibold">Gambar Kiriman</label>
          </div>
          <div class="col-span-2">
            <input bind:value={gambar} on:change={updateGambar} type="file" name="file-input" id="file-input" accept=".jpg,.jpeg,.png" class="block w-full border border-gray-200 shadow-sm rounded-lg text-sm focus:z-10 focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-900 dark:border-neutral-700 dark:text-neutral-400 file:bg-gray-50 file:border-0 file:me-4 file:py-3 file:px-4 ">
          </div>
        </div>
      </form>

      <!-- Footer -->
      <div class="px-6 py-4 grid gap-3 md:flex md:justify-end md:items-center border-t border-gray-200">
        <div>
          <div class="inline-flex gap-x-2">
            <button on:click={() => cancelEdit()} type="button" class="py-3 px-4 inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-gray-500 text-gray-500 hover:border-gray-800 hover:text-gray-800 disabled:opacity-50 disabled:pointer-events-none">
              Batalkan
            </button>

            <button on:click={() => savePost()} type="button" class="py-3 px-4 inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50 disabled:pointer-events-none">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="size-5"><path d="M15.2 3a2 2 0 0 1 1.4.6l3.8 3.8a2 2 0 0 1 .6 1.4V19a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2z"/><path d="M17 21v-7a1 1 0 0 0-1-1H8a1 1 0 0 0-1 1v7"/><path d="M7 3v4a1 1 0 0 0 1 1h7"/></svg> Simpan
            </button>
          </div>
        </div>
      </div>
      <!-- End Footer -->
    </div>
  </div>    
{/if}
</div>