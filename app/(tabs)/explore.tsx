import { StyleSheet, View } from 'react-native';
import { ThemedView } from '@/components/ThemedView';
import { MaterialCommunityIcons, MaterialIcons } from '@expo/vector-icons';
import { CompoundIcon, Shape } from '@/components/CompoundIcon';

export default function TabTwoScreen() {
  return (
    <ThemedView
      style={{
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
      }}>
      <CompoundIcon icon={<MaterialCommunityIcons name='gas-station' />} secondaryIcon={<MaterialIcons name='euro' />} size={72} shape={Shape.Circle} />
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  headerImage: {
    color: '#808080',
    bottom: -90,
    left: -35,
    position: 'absolute',
  },
  titleContainer: {
    flexDirection: 'row',
    gap: 8,
  },
});