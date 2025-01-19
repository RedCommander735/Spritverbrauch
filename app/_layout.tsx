import { ThemeProvider } from '@/constants/Theme';
import { useFonts } from 'expo-font';
import { Stack } from 'expo-router';
import * as SplashScreen from 'expo-splash-screen';
import { SQLiteDatabase, SQLiteProvider } from 'expo-sqlite';
import { useEffect } from 'react';
import 'react-native-reanimated';

// Prevent the splash screen from auto-hiding before asset loading is complete.
// SplashScreen.preventAutoHideAsync();

export default function RootLayout() {
  // const [loaded] = useFonts({
  //   SpaceMono: require('../assets/fonts/SpaceMono-Regular.ttf'),
  // });

  // useEffect(() => {
  //   if (loaded) {
  //     SplashScreen.hideAsync();
  //   }
  // }, [loaded]);

  // if (!loaded) {
  //   return null;
  // }

  return (
    <ThemeProvider>
      <SQLiteProvider databaseName="sprit.sqlite" onInit={migrateDbIfNeeded}>
        <Stack>
          <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
          <Stack.Screen name="+not-found" />
        </Stack>
      </SQLiteProvider>
    </ThemeProvider>
  );
}


async function migrateDbIfNeeded(db: SQLiteDatabase) {
  const DATABASE_VERSION = 2;

  let { user_version: currentDbVersion } = await db.getFirstAsync<{ user_version: number }>(
    'PRAGMA user_version'
  );

  console.log(currentDbVersion)

  if (currentDbVersion >= DATABASE_VERSION) {
    return;
  }

  if (currentDbVersion === 0) {

    await db.execAsync('CREATE TABLE IF NOT EXISTS usage(id INTEGER PRIMARY KEY AUTOINCREMENT, date INTEGER, distance DOUBLE, price DOUBLE, liters DOUBLE, price_liter DOUBLE, liters_kilometer DOUBLE, is_meta_entry BOOLEAN, meta_value TEXT);');
    currentDbVersion = 1;
  }

  if (currentDbVersion === 1) {
    await db.execAsync('INSERT INTO USAGE (date, distance, price, liters, price_liter, liters_kilometer, is_meta_entry, meta_value) VALUES (1, 1, 1, 1, 1, 1, true, "test");');
    currentDbVersion = 2;
  }
  // if (currentDbVersion === 2) {
  //   Add more migrations
  // }
  await db.execAsync(`PRAGMA user_version = ${DATABASE_VERSION};`);
}