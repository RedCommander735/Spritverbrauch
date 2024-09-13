import React, { ReactElement } from "react";
import { View } from "react-native";
import { AcceptableIconProps, CompoundIconProps } from "../CompoundIcon";
import { ThemedText } from "../ThemedText";
import { getNumberFormatSettings } from "react-native-localize";

type OverviewItemProps = {
    icon: ReactElement<CompoundIconProps | AcceptableIconProps>;
    value: number;
    unit: string;
    decimals: number | undefined;
    lastDecimalUp: boolean;
};

export function OverviewItem({
    icon,
    value,
    unit,
    decimals = 2,
    lastDecimalUp = false,
}: OverviewItemProps) {

    const formatter = new Formatter(value, decimals)
    let text;
    let up;

    if (!lastDecimalUp) {
        text = formatter.toFixedLocale()
    } else {
        text = `${formatter.onlyInteger()}${formatter.getSeperator()}${formatter.exactDecimal().substring(0, decimals - 1)}`
        up = formatter.roundedDecimal().substring(decimals - 1, decimals)
    }
    return (
        <View style={{
            gap: 8,
            marginBottom: 8,
            display: 'flex',
            flexDirection: 'row',
            justifyContent: 'space-between',
            width: '100%',
            paddingHorizontal: '26%',
            alignItems: 'center'
            }}>
            {icon}
            <View style={{
            display: 'flex',
            flexDirection: 'row',
            }}>
                <ThemedText type="subtitle">{text}</ThemedText>
                <ThemedText type="subtitle" style={{
                    transform: 'scale(0.6)',
                    transformOrigin: '0, 0',
                    left: 2
                }}>{up}</ThemedText>
                <ThemedText type="subtitle"> {unit}</ThemedText>
            </View>
        </View>
    );
};


class Formatter {
    value: number;
    decimals: number;
    decimalSeparator: string;

    constructor(value:number, decimals: number, decimalSeparator?: string | undefined) {
        let numberFormatSettings = getNumberFormatSettings();

        if (!decimalSeparator) {
            decimalSeparator = numberFormatSettings.decimalSeparator
        }

        this.value = value
        this.decimals = decimals
        this.decimalSeparator = decimalSeparator
    }

    toFixedLocale() {
        const standardFixedString = this.value.toFixed(this.decimals);
      
        if (this.decimalSeparator === ",") {
          return standardFixedString.replace(".", ",");
        } else {
          return standardFixedString; // Locale matches JavaScript default
        }
    }

    onlyInteger() {
        return Math.floor(this.value).toString()
    }

    exactDecimal() {
        const standardFixedString = this.value.toFixed(this.decimals + 1);
        return standardFixedString.split('.')[1].substring(0, this.decimals)
    }

    roundedDecimal() {
        const standardFixedString = this.value.toFixed(this.decimals);
        return standardFixedString.split('.')[1]
    }

    getSeperator() {
        return this.decimalSeparator;
    }
}