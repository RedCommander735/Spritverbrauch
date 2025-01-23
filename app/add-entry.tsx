import { FlatList, StyleSheet, View, Text, Button } from 'react-native';
import { ThemedView } from '@/components/ThemedView';
import { useMaterialYouTheme } from '@/constants/Theme';
import { ThemedText } from '@/components/ThemedText';
import { useSQLiteContext } from 'expo-sqlite';
import { useState, useEffect } from 'react';
import { TextInput } from 'react-native';
import { useNavigation } from 'expo-router';

interface ListViewRow {
  id: number;
  is_meta_entry: boolean;
  meta_value?: string;
}

export default function AddEntryScreen() {

  const navigation = useNavigation();
  const theme = useMaterialYouTheme();

  useEffect(() => {
    navigation.setOptions({ headerStyle: { backgroundColor: theme.background }, headerTintColor: theme.text, headerTitleAlign: 'center', headerTitle: 'Eintrag hinzufügen', animation: 'slide_from_right'});
  }, [navigation]);

  const db = useSQLiteContext();
  const [value, setValue] = useState<string>('');

  const addMetaRow = async () => {
    await db.runAsync('INSERT INTO usage (date, distance, price, liters, price_liter, liters_kilometer, is_meta_entry, meta_value) VALUES (1, 1, 1, 1, 1, 1, true, ?);', [value]);

    setValue('')
  }

  const getMetaRows = async () => {
    const result = await db.getAllAsync<ListViewRow>(
      'SELECT id, is_meta_entry, meta_value FROM usage'
    );
    console.log(result)
  }

  

  return (
    <ThemedView
      style={{
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
      }}>
      <TextInput value={value} placeholder='meta' onChangeText={setValue} style={{color: 'white'}}/>
      <Button title='addMeta' onPress={addMetaRow}/>
      <Button title='getMeta' onPress={getMetaRows}/>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  text: {
    fontSize: 18,
  }
});