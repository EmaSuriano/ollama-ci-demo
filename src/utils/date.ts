export const isSameDay = (d1: Date, d2: Date): boolean => {
  return (
    d1.getFullYear() === d2.getFullYear() &&
    d1.getMonth() === d2.getMonth() &&
    d1.getDate() === d2.getDate()
  );
};

export const formatDate = (date: Date): string => {
  return new Intl.DateTimeFormat("en-US", {
    weekday: "long",
    month: "long",
    day: "numeric",
    year: "numeric",
  }).format(date);
};

export function getNextDay(date: Date): Date {
  const nextDay = new Date(date);
  nextDay.setDate(date.getDate() + 1);
  return nextDay;
}

export function getPreviousDay(date: Date): Date {
  const previousDay = new Date(date);
  previousDay.setDate(date.getDate() - 1);
  return previousDay;
}

export function getDateId(date: Date): string {
  return date.toISOString().split("T")[0];
}
