import React from 'react';

import { StyleSheet } from 'react-native';
import { TabBarIcon } from '@/components/navigation/TabBarIcon';
import { useMaterialYouTheme } from '@/constants/Theme';
import { MaterialTopTabs } from '../../components/navigation/MaterialTopTabs';
import { SafeAreaProvider, useSafeAreaInsets } from 'react-native-safe-area-context';

export default function TabLayout() {
  const colorScheme = useMaterialYouTheme();
  const insets = useSafeAreaInsets();

  return (
    <SafeAreaProvider
      style={{        // Paddings to handle safe area
        paddingTop: insets.top,
        paddingBottom: insets.bottom,
        paddingLeft: insets.left,
        paddingRight: insets.right,
        backgroundColor: colorScheme.background
      }}
    >
      <MaterialTopTabs
        screenOptions={{
          tabBarActiveTintColor: colorScheme.text,
          tabBarStyle: [styles.tabBar, {borderColor: colorScheme.text, backgroundColor: colorScheme.background}],
          tabBarIndicatorStyle: [styles.indicator, {backgroundColor: colorScheme.primary}],
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
            tabBarLabel: ({ color }) => (<TabBarIcon name={'format-list-bulleted'} color={color} />),
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
    marginLeft: '20%',
    width: '10%',
    borderTopRightRadius: 10,
    borderTopLeftRadius: 10,
  },
});