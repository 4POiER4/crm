export const STAGES=['Новая заявка','В работе','Подбор тура','Предложение отправлено','Согласование','Бронирование','Успешно завершена'];
export const BOOKING_STATUSES=['Черновик','Запрошено','Подтверждено','Отменено','Поездка завершена'];
export const SOURCES=['Сайт','Рекомендация','Телефон','Социальные сети','Повторное обращение'];
export const CURRENCIES=['BYN','USD','EUR'];
export const ROLES=['Менеджер','Руководитель','Администратор'];
export type RecordItem={id:string;kind:string;owner:string;parent?:string;client?:string;version:number;created:string;data:any};
export const money=(n:number,c='BYN')=>new Intl.NumberFormat('ru-BY',{style:'currency',currency:c,maximumFractionDigits:0}).format(n||0);
export const day=(d:string)=>d?new Date(d.length===10?d+'T12:00:00':d).toLocaleDateString('ru-RU',{day:'numeric',month:'short'}):'—';
export const today=()=>new Date().toLocaleDateString('sv-SE',{timeZone:'Europe/Moscow'});
export const round=(n:number)=>Math.round((n+Number.EPSILON)*100)/100;
export function finance(b:any){const p=b.payments||[];const incoming=p.reduce((s:number,x:any)=>s+(x.type==='Поступление'?x.bookingAmount:x.type==='Возврат клиенту'?-x.bookingAmount:0),0);const supplier=p.reduce((s:number,x:any)=>s+(x.type==='Оплата поставщику'?x.bookingAmount:x.type==='Возврат от поставщика'?-x.bookingAmount:0),0);return{paid:round(incoming),supplierPaid:round(supplier),balance:b.status==='Отменено'?0:round(b.price-incoming),supplierBalance:b.status==='Отменено'?0:round(b.supplierCost-supplier),sales:b.status==='Отменено'?0:b.price*b.rate,planned:b.status==='Отменено'?0:(b.price-b.supplierCost)*b.rate,cashFlow:round(p.reduce((s:number,x:any)=>s+(['Поступление','Возврат от поставщика'].includes(x.type)?1:-1)*x.amount*x.rate,0)),actual:b.status==='Поездка завершена'?round(p.reduce((s:number,x:any)=>s+(['Поступление','Возврат от поставщика'].includes(x.type)?1:-1)*x.amount*x.rate,0)-Math.max(0,b.supplierCost-supplier)*b.rate):0}}

