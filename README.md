# Ishaqzada Online Delivery — نوی وړیا سیستم

دا پروژه د پخواني سیستم د بڼې او کاري ترتیب پر اساس جوړه شوې، خو Supabase نه کاروي.

## څه پکې شته
- شاګرد نوی ثبت + شخصي عکس
- د اډمین تایید/رد، رول بدلول، PIN بدلول
- موبایل + ۴ عددي PIN ننوتل
- شاګرد: نوی جنس، عکس، مشتری، ولایت، تعداد، ادرس، بیه
- تر لېږلو مخکې اصلاح او حذف
- د لېږلو مسؤل: کندهار = «تسلیم شو»، نور ولایتونه = «ولېږل شو»
- ورځنی حساب او راپور (له سهار ۶ تر بل سهار ۶)
- PWA / Add to Home Screen
- Cloudflare D1 database + R2 photos + Worker API

## GitHub ته پورته کول
ټول فایلونه همداسې repository ته upload/push کړئ.

## Cloudflare کې یو ځل Setup
1. Cloudflare account جوړ/خلاص کړئ.
2. Workers & Pages → D1 → Create database:
   `ishaqzada-delivery-db`
3. د D1 database ID د `wrangler.jsonc` د `PASTE_D1_DATABASE_ID_HERE` پر ځای ولیکئ.
4. R2 → Create bucket:
   `ishaqzada-delivery-photos`
5. په کمپیوټر کې:
   `npm install`
6. Database tables جوړ کړئ:
   `npx wrangler d1 execute ishaqzada-delivery-db --remote --file=./schema.sql`
7. امنیتي secret جوړ کړئ:
   `npx wrangler secret put PIN_PEPPER`
   یو اوږد تصادفي متن ورکړئ.
8. `wrangler.jsonc` کې د لومړي اډمین نمبر او PIN بدل کړئ. د لومړي deploy وروسته PIN د اپ له Admin برخې بدلولی شئ.
9. Deploy:
   `npm run deploy`

## GitHub اتومات Deploy
Cloudflare Dashboard → Workers & Pages → Create/Import repository، خپل GitHub repo وصل کړئ.
Build command: `npm run deploy`
د Cloudflare Git integration/Workers Builds لارښوونې تعقیب کړئ.

## مهم
GitHub Pages یوازې static فایلونه چلوي؛ د دې سیستم Login/Database/Photos لپاره Cloudflare Worker + D1 + R2 هم لازم دي.
Free tier محدودیتونه لري. که حد واوړي، Cloudflare د پیسو پر ځای عملیات تر reset پورې محدودولی شي؛ پروژه په خپله $25 میاشتنی فیس نه لري.

## امنیت
- PIN په database کې plain text نه ساتل کېږي.
- Session cookie HttpOnly/Secure ده.
- عکسونه R2 کې private دي او یوازې login شوي کاروونکي یې د API له لارې ویني.
- `PIN_PEPPER` باید GitHub ته مه پورته کوئ.
