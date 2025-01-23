import React, { useEffect, useState } from 'react';

import { StyleSheet, View } from 'react-native';
import { TabBarIcon } from '@/components/navigation/TabBarIcon';
import { useMaterialYouTheme } from '@/constants/Theme';
import { MaterialTopTabs } from '../../components/navigation/MaterialTopTabs';
import { SafeAreaProvider, useSafeAreaInsets } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { FAB } from 'react-native-paper';
import { navigate } from 'expo-router/build/global-state/routing';
import { router } from 'expo-router';

export default function TabLayout() {
  const colorScheme = useMaterialYouTheme();
  const insets = useSafeAreaInsets();

  return (
    <>
    <StatusBar style={useMaterialYouTheme().isDark ? "light" : "dark"}/>
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
            tabBarStyle: [styles.tabBar, { borderColor: colorScheme.text, backgroundColor: colorScheme.background }],
            tabBarIndicatorStyle: [styles.indicator, { backgroundColor: colorScheme.primary }],
          }} id={undefined}>
        <MaterialTopTabs.Screen
          name="index"
          options={{
            tabBarShowLabel: true,
            tabBarShowIcon: false,
            tabBarLabel: ({ color }) => (<TabBarIcon name={'home'} color={color} />),
          }}
        />
        <MaterialTopTabs.Screen
          name="list"
          options={{
            tabBarShowLabel: true,
            tabBarShowIcon: false,
            tabBarLabel: ({ color }) => (<TabBarIcon name={'format-list-bulleted'} color={color} />),
          }}
        />
        <MaterialTopTabs.Screen
          name="debug"
          options={{
            tabBarShowLabel: true,
            tabBarShowIcon: false,
            tabBarLabel: ({ color }) => (<TabBarIcon name={'script'} color={color} />),
          }}
        />
      </MaterialTopTabs>
    </SafeAreaProvider>
    <FAB
      icon="plus"
      style={[styles.fab, {backgroundColor: colorScheme.primary}]}
      color={colorScheme.background}
      onPress={() => router.push('../add-entry', { relativeToDirectory: true })}
    />
    </>
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
  fab: {
    position: 'absolute',
    margin: 24,
    right: 0,
    bottom: 0,
  },
});