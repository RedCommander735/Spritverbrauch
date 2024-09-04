/**
 * Below are the colors that are used in the app. The colors are defined in the light and dark mode.
 * There are many other ways to style your app. For example, [Nativewind](https://www.nativewind.dev/), [Tamagui](https://tamagui.dev/), [unistyles](https://reactnativeunistyles.vercel.app), etc.
 */

const tintColorLight = '#0a7ea4';
const tintColorDark = '#fff';

export const Colors = {
  light: {
    text: '#11181C',
    background: '#fff',
    tint: tintColorLight,
    icon: '#687076',
    tabIconDefault: '#687076',
    tabIconSelected: tintColorLight,
  },
  dark: {
    text: '#ECEDEE',
    background: '#151718',
    tint: tintColorDark,
    icon: '#9BA1A6',
    tabIconDefault: '#9BA1A6',
    tabIconSelected: tintColorDark,
  },
};


// // theme.ts

// import MaterialYou from 'react-native-material-you-colors';
// import type { MaterialYouPalette } from 'react-native-material-you-colors';

// function generateTheme(palette: MaterialYouPalette) {
//   const light = {
//     isDark: false,
//     primary: palette.system_accent1[7], // shade 500
//     text: palette.system_accent1[9], // shade 700
//     textColored: palette.system_accent1[2], // shade 50
//     background: palette.system_neutral1[1], // shade 10
//     card: palette.system_accent2[2], // shade 50
//     icon: palette.system_accent1[10], // shade 800
//   };
//   const dark: typeof light = {
//     isDark: true,
//     primary: palette.system_accent1[4], // shade 200
//     text: palette.system_accent1[3], // shade 100
//     textColored: palette.system_accent1[9], // shade 700
//     background: palette.system_neutral1[11], // shade 900
//     card: palette.system_accent2[10], // shade 800
//     icon: palette.system_accent1[3], // shade 100
//   };
//   return { light, dark };
// }

// export const { ThemeProvider, useMaterialYouTheme } = MaterialYou.createThemeContext(generateTheme);