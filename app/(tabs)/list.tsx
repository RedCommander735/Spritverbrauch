import { FlatList, StyleSheet, View, Text } from 'react-native';
import { ThemedView } from '@/components/ThemedView';
import { MaterialCommunityIcons, MaterialIcons } from '@expo/vector-icons';
import { CompoundIcon, Shape } from '@/components/CompoundIcon';
import { useMaterialYouTheme } from '@/constants/Theme';
import { ThemedText } from '@/components/ThemedText';

const renderSeparator = () => {
  const dividerColor = useMaterialYouTheme().card

  return <View
    style={{
      backgroundColor: dividerColor,
      height: 1,
    }}
  />
};

export default function TabTwoScreen() {

  const textColor = useMaterialYouTheme().text
  const secondary = useMaterialYouTheme().secondaryText

  return (
    <ThemedView
      style={{
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
      }}>
      <FlatList
        style={{
          alignSelf: 'stretch'
        }}
        data={[
          { key: 'Devin' },
          { key: 'Dan' },
          { key: 'Dominic' },
          { key: 'Jackson' },
          { key: 'James' },
          { key: 'Joel' },
          { key: 'John' },
          { key: 'Jillian' },
          { key: 'Jimmy' },
          { key: 'Julie' },
        ]}
        renderItem={({ item, index }) => <View style={{
          display: 'flex',
          flexDirection: 'column',
          alignSelf: 'stretch',
          alignItems: 'center'
        }}>
          <ThemedText style={[{alignSelf: 'stretch', marginLeft: 10, fontSize: 12}, {color: secondary}]}>
            01.01.2025
          </ThemedText>
          <View style={{
            display: 'flex',
            flexDirection: 'row',
            justifyContent: 'space-evenly',
            alignSelf: 'stretch',
            marginBottom: 18
          }}>
            <ThemedText style={styles.text}>
              €  9.13 l/km
            </ThemedText>
            {/* todo replace leading € with icon */}
            <ThemedText style={styles.text}>
              €  73.26 €
            </ThemedText>
          </View>
  
        </View>
        }
        ItemSeparatorComponent={renderSeparator}
      />
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  text: {
    fontSize: 18,
  }
});