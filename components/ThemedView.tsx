import { View, type ViewProps } from 'react-native';

import { useMaterialYouTheme } from '@/constants/Theme';

export type ThemedViewProps = ViewProps & {
  lightColor?: string;
  darkColor?: string;
};

export function ThemedView({ style, ...otherProps }: ThemedViewProps) {
  const backgroundColor = useMaterialYouTheme().background

  return <View style={[{ backgroundColor }, style]} {...otherProps} />;
}
