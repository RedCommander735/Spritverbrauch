import React from 'react';

import { AnimatableNumericValue, StyleSheet } from 'react-native';
import { TabBarIcon } from '@/components/navigation/TabBarIcon';
import { Colors } from '@/constants/Colors';
import { useColorScheme } from '@/hooks/useColorScheme';
import { MaterialTopTabs } from '../../components/navigation/MaterialTopTabs';
import { SafeAreaProvider, useSafeAreaInsets } from 'react-native-safe-area-context';
import { useThemeColor } from '@/hooks/useThemeColor';

export default function TabLayout() {
  const colorScheme = useColorScheme();
  const insets = useSafeAreaInsets();
  const textColor = useThemeColor({}, 'text')

  return (
    <SafeAreaProvider
      style={{        // Paddings to handle safe area
        paddingTop: insets.top,
        paddingBottom: insets.bottom,
        paddingLeft: insets.left,
        paddingRight: insets.right,
      }}
    >
      <MaterialTopTabs
        screenOptions={{
          tabBarActiveTintColor: Colors[colorScheme ?? 'light'].tint,
          tabBarStyle: [styles.tabBar, {borderColor: textColor}],
          tabBarIndicatorStyle: styles.indicator,
        }}
        >
        <MaterialTopTabs.Screen
          name="index"
          options={{
            tabBarShowLabel: true,
            tabBarShowIcon: false,
            tabBarLabel: ({ color, focused }) => (<TabBarIcon name={focused ? 'home' : 'home-outline'} color={color} />),
          }}
        />
        <MaterialTopTabs.Screen
          name="explore"
          options={{
            tabBarShowLabel: true,
            tabBarShowIcon: false,
            tabBarLabel: ({ color, focused }) => (<TabBarIcon name={'format-list-bulleted'} color={color} />),
          }}
        />
      </MaterialTopTabs>
    </SafeAreaProvider>
  );
}

const styles = StyleSheet.create({
  tabBar: {
    height: 60,
    display: 'flex',
    justifyContent: 'center',
    borderBottomWidth: 1,
  },
  indicator: {
    height: 3, 
    marginBottom: -1.2,
    marginLeft: '20%',
    width: '10%',
    borderTopRightRadius: 10,
    borderTopLeftRadius: 10,
  },
});