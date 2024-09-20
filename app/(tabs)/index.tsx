import { StyleSheet, Platform, View, Text } from 'react-native';

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

      <OverviewItem icon={<CompoundIcon icon={<MaterialCommunityIcons name='gas-station' />} secondaryIcon={<MaterialIcons name='route' />} size={36} shape={Shape.Square} />} value={8.746} unit={'L/km'} lastDecimalUp={false} decimals={2}/>
      <OverviewItem icon={<MaterialIcons name='euro' size={36} color={useMaterialYouTheme().text}/>} value={72.566} unit={'€'} lastDecimalUp={true} decimals={3}/>
      <OverviewItem icon={<MaterialIcons name='route' size={36} color={useMaterialYouTheme().text}/>} value={470.674} unit={'km'} lastDecimalUp={false} decimals={2}/>
      <OverviewItem icon={<CompoundIcon icon={<MaterialCommunityIcons name='gas-station' />} secondaryIcon={<MaterialIcons name='euro' />} size={36} shape={Shape.Circle} />} value={1.774} unit={'€/L'} lastDecimalUp={true} decimals={3}/>
      <OverviewItem icon={<CompoundIcon icon={<MaterialIcons name='route' />} secondaryIcon={<MaterialIcons name='euro' />} size={36} shape={Shape.Circle} />} value={0.154} unit={'€/km'} lastDecimalUp={true} decimals={3}/>
      
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  titleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 80
  },
  title: {
    lineHeight: 40
  },
});
