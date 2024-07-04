<script lang="ts">
  import { onMount } from "svelte";
  import { PUBLIC_API_URL as API_URL } from '$env/static/public';

  let posts : any[]=[];
  let totalPage = 0;

  async function loadData(){
    const respon = await fetch(`${API_URL}/api/posting?page=1&limit=4`);
    const data = await respon.json();
    posts = data.posts;
    totalPage = data.totalPage;
  }
  onMount(()=> {
  loadData();
  })
</script>

<div class="container mx-auto">

  <!-- Card Blog -->
  <div class="max-w-[85rem] px-4 py-10 sm:px-6 lg:px-8 lg:py-14 mx-auto">
    <!-- Grid -->
    <div class="grid lg:grid-cols-2 lg:gap-y-16 gap-10">
      {#each posts as post }
        
      <!-- Card -->
      <a class="group rounded-xl overflow-hidden" href={`/posting/${post.id}`}>
        <div class="sm:flex">
          <div class="flex-shrink-0 relative rounded-xl overflow-hidden w-full sm:w-56 h-44">
            <img class="group-hover:scale-105 transition-transform duration-500 ease-in-out size-full absolute top-0 start-0 object-cover rounded-xl" src={`${API_URL}/${post.gambar}`} alt={post.judul}>
          </div>

          <div class="grow mt-4 sm:mt-0 sm:ms-6 px-4 sm:px-0">
            <h3 class="text-xl font-semibold text-gray-800 group-hover:text-gray-600">
              {post.judul}              
            </h3>
            <p class="mt-3 text-gray-600">
              {post.deskripsi.slice(0,100)}
            </p>
            <p class="mt-4 inline-flex items-center gap-x-1 text-blue-600 decoration-2 hover:underline font-medium">
              Read more
              <svg class="flex-shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m9 18 6-6-6-6"/></svg>
            </p>
          </div>
        </div>
      </a>
      {/each}
      <!-- End Card -->

    </div>
    <!-- End Grid -->
  </div>
  <!-- End Card Blog -->

  <!-- Pagination -->
  <nav class="flex items-center gap-x-1">
    <button type="button" class="min-h-[38px] min-w-[38px] py-2 px-2.5 inline-flex justify-center items-center gap-x-2 text-sm rounded-lg border border-transparent text-gray-800 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 disabled:opacity-50 disabled:pointer-events-none">
      <svg class="flex-shrink-0 size-3.5" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="m15 18-6-6 6-6"></path>
      </svg>
      <span aria-hidden="true" class="sr-only">Sebelumnya</span>
    </button>
    <div class="flex items-center gap-x-1">
      <button type="button" class="min-h-[38px] min-w-[38px] flex justify-center items-center border border-gray-200 text-gray-800 py-2 px-3 text-sm rounded-lg focus:outline-none focus:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none" aria-current="page">1</button>
      <button type="button" class="min-h-[38px] min-w-[38px] flex justify-center items-center border border-transparent text-gray-800 hover:bg-gray-100 py-2 px-3 text-sm rounded-lg focus:outline-none focus:bg-gray-100 disabled:opacity-50 disabled:pointer-events-none">2</button>
      <button type="button" class="min-h-[38px] min-w-[38px] flex justify-center items-center border border-transparent text-gray-800 hover:bg-gray-100 py-2 px-3 text-sm rounded-lg focus:outline-none focus:bg-gray-100 disabled:opacity-50 disabled:pointer-events-none">3</button>
    </div>
    <button type="button" class="min-h-[38px] min-w-[38px] py-2 px-2.5 inline-flex justify-center items-center gap-x-2 text-sm rounded-lg border border-transparent text-gray-800 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 disabled:opacity-50 disabled:pointer-events-none">
      <span aria-hidden="true" class="sr-only">Berikutnya</span>
      <svg class="flex-shrink-0 size-3.5" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="m9 18 6-6-6-6"></path>
      </svg>
    </button>
  </nav>
  <!-- End Pagination -->

</div>