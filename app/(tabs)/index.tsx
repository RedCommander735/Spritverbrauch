import { StyleSheet, Platform } from 'react-native';

import { ThemedText } from '@/components/ThemedText';
import { ThemedView } from '@/components/ThemedView';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import { useMaterialYouTheme } from '@/constants/Theme';

export default function HomeScreen() {
  return (
    <ThemedView
      style={{
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center'
      }}>
      <ThemedView style={styles.titleContainer}>
        <ThemedText type="title" style={styles.title}>Übersicht</ThemedText>
      </ThemedView>

      <ThemedView style={{
        gap: 8,
        marginBottom: 8,
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'space-between',
        width: '100%',
        paddingHorizontal: '26%',
        alignItems: 'center'
      }}>
        <MaterialCommunityIcons size={36} name='home' color={useMaterialYouTheme().text} />
        <ThemedText type="subtitle">8.74 L/km</ThemedText>
      </ThemedView>
      
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  titleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 50
  },
  title: {
    lineHeight: 40
  },
});
