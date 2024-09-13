import { useMaterialYouTheme } from "@/constants/Theme";
import { MaterialCommunityIcons, MaterialIcons } from "@expo/vector-icons";
import MaskedView from "@react-native-masked-view/masked-view";
import React from "react";
import { ReactElement } from "react";
import { View } from "react-native";
import Svg, { Path, SvgProps } from "react-native-svg";
import { Colors } from "react-native/Libraries/NewAppScreen";

export enum Shape {
    Square,
    Circle
}

export type AcceptableIconProps = typeof MaterialIcons.defaultProps | typeof MaterialCommunityIcons.defaultProps

export type CompoundIconProps = {
    icon: ReactElement<AcceptableIconProps>;
    secondaryIcon: ReactElement<AcceptableIconProps>;
    size: number;
    shape: Shape
};


export function CompoundIcon({
    icon,
    secondaryIcon,
    size,
    shape = Shape.Square,
}: CompoundIconProps) {
    return (
        <View style={{
            position: 'relative',
            height: size,
            width: size
        }}>
            <MaskedView
                maskElement={
                    (shape == Shape.Square)
                        ? <SquareMask fill={Colors.transparent} width={size} height={size} />
                        : <CircleMask fill={Colors.transparent} width={size} height={size} />
                }
                style={{
                    position: 'absolute'
                }}
            >
                {React.cloneElement(icon, { size: size, color: useMaterialYouTheme().text })}
            </MaskedView>

            {React.cloneElement(secondaryIcon, { size: size / 2, color: useMaterialYouTheme().text, style: { position: 'absolute', top: size / 2, left: size / 2 } })}
        </View>
    );
};


function SquareMask(props: SvgProps) {
    return (
        <Svg viewBox='0 0 12 12' {...props}>
            <Path d='m 0,0 v 12.7 h 5.3832158 c 0.3878,0 0.7021742,-0.314374 0.7021742,-0.702174 V 7.3199592 C 6.08539,6.6381255 6.6381255,6.08539 7.3199592,6.08539 H 11.997826 C 12.385626,6.08539 12.7,5.7710158 12.7,5.3832158 V 0 Z' />
        </Svg>
    );
}
function CircleMask(props: SvgProps) {
    return (
        <Svg viewBox='0 0 12 12' {...props}>
            <Path d='M 0 0 L 0 12.7 L 9.3927083 12.7 C 7.5661414 12.699999 6.085416 11.219276 6.0854167 9.3927083 C 6.0854167 7.566142 7.566142 6.0854168 9.3927083 6.0854167 C 11.219276 6.0854159 12.699999 7.5661414 12.7 9.3927083 L 12.7 0 L 0 0 z ' />
        </Svg>
    );
}
