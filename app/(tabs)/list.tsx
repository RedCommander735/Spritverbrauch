import { FlatList, StyleSheet, View, Text } from 'react-native';
import { ThemedView } from '@/components/ThemedView';
import { useMaterialYouTheme } from '@/constants/Theme';
import { ThemedText } from '@/components/ThemedText';
import { useSQLiteContext } from 'expo-sqlite';
import { useState, useEffect } from 'react';

interface DBRow {
  id: number;
  date?: number;
  distance?: number;
  price?: number;
  liters?: number;
  price_liter?: number;
  liters_kilometer?: number;
  is_meta_entry: boolean;
  meta_value?: string 
}

interface ListViewRow {
  id: number;
  date?: number;
  price?: number;
  is_meta_entry: boolean;
  meta_value?: string;
}

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
  const secondary = useMaterialYouTheme().secondaryText

  const db = useSQLiteContext();
  const [rows, setRows] = useState<ListViewRow[]>([]);

  useEffect(() => {
    async function loadRows() {
      const result = await db.getAllAsync<ListViewRow>(
        'SELECT id, date, price, is_meta_entry, meta_value FROM usage'
      );
      console.log(result.length)
      setRows(result);
    }
    loadRows();
  }, []);

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
        data={rows}
        renderItem={({ item, index }) => <View style={{
          display: 'flex',
          flexDirection: 'row',
          alignSelf: 'stretch',
          alignItems: 'center'
        }}>
          <ThemedText style={[{alignSelf: 'stretch', marginLeft: 10, fontSize: 12}, {color: secondary}]}>
            {index}
          </ThemedText>
          <View style={{
            display: 'flex',
            flexDirection: 'row',
            justifyContent: 'center',
            alignSelf: 'stretch',
            marginVertical: 18
          }}>
            <ThemedText style={[styles.text, {paddingLeft: '10%'}]}>
              {item.id}
            </ThemedText>
            <View style={{width: '8%'}}></View>
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