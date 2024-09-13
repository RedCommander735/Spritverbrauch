import { StyleSheet, Platform } from 'react-native';

import { ThemedText } from '@/components/ThemedText';
import { ThemedView } from '@/components/ThemedView';
import { MaterialCommunityIcons, MaterialIcons } from '@expo/vector-icons';
import { useMaterialYouTheme } from '@/constants/Theme';
import { CompoundIcon, Shape } from '@/components/CompoundIcon';
import { OverviewItem } from '@/components/Overview/OverviewItem';

export default function HomeScreen() {
  return (
    <ThemedView
      style={{
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        
      }}>
      <ThemedView style={styles.titleContainer}>
        <ThemedText type="title" style={styles.title}>Übersicht</ThemedText>
      </ThemedView>

      <OverviewItem icon={<CompoundIcon icon={<MaterialCommunityIcons name='gas-station' />} secondaryIcon={<MaterialIcons name='route' />} size={36} shape={Shape.Square} />} value={8.746} unit={'L/km'} lastDecimalUp={true} decimals={3}/>
      
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
