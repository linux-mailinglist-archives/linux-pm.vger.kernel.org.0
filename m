Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5C35E349
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 17:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhDMP6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Apr 2021 11:58:04 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38499 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhDMP6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Apr 2021 11:58:03 -0400
Received: by mail-oi1-f172.google.com with SMTP id b3so2688692oie.5;
        Tue, 13 Apr 2021 08:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIJe20VTeFe1SEBun0d9AiKkuFKt+lQDqkctqPJBMxY=;
        b=VtrcU57/yqXcvyKiqfDhBvrmSo2hTCkX26/NEV9mlaDULYd1vhE2QWjQOgETld/x2G
         CPxnDB4iZrqCumN+rwLGuu3E4bOf2JLEwuDNAY1jp+R2ZqDwYmafHGn1RUuR7V54qZJ+
         GfKAegv4HDLIf8ylCYfWYV/O8K2Xgr7sS8K7eOFmvCUz4u/bmSfbpLlswZEa8YYr+7/d
         KWQvIY1e6qLMUMD3+vShRlJC0KQY2czfIm462nBVZTQo4Vwezjtyb/tlZ/poH0x9Qt7R
         qZz5R/Sv3QnU0lrKO45toctFNP2mT/y0KvrzxOQawVqlNcMlbyMinHEUYMl7WBc8xlkH
         AEtw==
X-Gm-Message-State: AOAM530JxjUasxjVRXxrHvofvdAAh8U6+qydq+mcEGUAgTUxtWa5SfH4
        e2l8RiwYipxUsPlsZh1fzw==
X-Google-Smtp-Source: ABdhPJzFExrHKorbQ5sPN561qctv1ZcQN+3qwRvAWKD/KttnNM37pHn3uISmxdJJShYsZxbQZE1Drw==
X-Received: by 2002:aca:3cd6:: with SMTP id j205mr498075oia.28.1618329463354;
        Tue, 13 Apr 2021 08:57:43 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n2sm826774otr.46.2021.04.13.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:57:41 -0700 (PDT)
Received: (nullmailer pid 1745426 invoked by uid 1000);
        Tue, 13 Apr 2021 15:57:40 -0000
Date:   Tue, 13 Apr 2021 10:57:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 6/6] dt-bindings: power: mfd: ab8500: Convert to DT
 schema format
Message-ID: <20210413155740.GA1717022@robh.at.kernel.org>
References: <20210412230320.382885-1-sebastian.reichel@collabora.com>
 <20210412230320.382885-7-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412230320.382885-7-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 13, 2021 at 01:03:20AM +0200, Sebastian Reichel wrote:
> Convert the binding to DT schema format.
> 
> I slightly modified the binding by renaming the gpio node from
> ab8500-gpio to ab8500-gpiocontroller, since the -gpio suffix
> is used for gpio consumers.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/mfd/ab8500.txt        | 280 -------
>  .../bindings/mfd/stericsson,ab8500.yaml       | 696 ++++++++++++++++++
>  .../bindings/pinctrl/ste,abx500.txt           | 318 --------
>  .../supply/stericsson,ab8500-battery.txt      |  34 -
>  4 files changed, 696 insertions(+), 632 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/ab8500.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/ste,abx500.txt
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt


> diff --git a/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml b/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
> new file mode 100644
> index 000000000000..80d33f21d72f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
> @@ -0,0 +1,696 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mfd/stericsson,ab8500.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: AB8500 Multi-Functional Device
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +  - Lee Jones <lee.jones@linaro.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - stericsson,ab8500
> +      - stericsson,ab8505
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    description: First cell is IRQ number, second cell is flags
> +    const: 2
> +
> +  clock-controller:
> +    type: object
> +    properties:
> +      compatible:
> +        const: stericsson,ab8500-clk
> +
> +      "#clock-cells":
> +        const: 1
> +
> +    required:
> +      - compatible
> +      - "#clock-cells"
> +
> +    additionalProperties: false
> +
> +  ab8500-rtc:
> +    type: object
> +    properties:
> +      compatible:
> +        const: stericsson,ab8500-rtc
> +
> +      interrupts:
> +        maxItems: 2
> +
> +      interrupt-names:
> +        items:
> +          - const: 60S
> +          - const: ALARM
> +
> +    required:
> +      - compatible
> +      - interrupts
> +      - interrupt-names
> +
> +    additionalProperties: false
> +
> +  ab8500-gpadc:
> +    type: object
> +    properties:
> +      compatible:
> +        const: stericsson,ab8500-gpadc
> +
> +      interrupts:
> +        minItems: 1
> +        maxItems: 2
> +
> +      interrupt-names:
> +        minItems: 1
> +        maxItems: 2
> +        items:
> +          anyOf:
> +            - const: HW_CONV_END
> +            - const: SW_CONV_END
> +
> +      vddadc-supply:
> +        description: analog supply
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      "#io-channel-cells":
> +        const: 1
> +
> +    required:
> +      - compatible
> +
> +    patternProperties:
> +      "^channel@[0-9a-f]+$":
> +        type: object
> +        properties:
> +          reg:
> +            maxItems: 1

maximum: 0x1f ?

> +
> +        required:
> +          - reg
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
> +  ab8500_temp:
> +    type: object
> +    properties:
> +      compatible:
> +        const: stericsson,abx500-temp
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      interrupt-names:
> +        items:
> +          - const: ABX500_TEMP_WARM
> +
> +      io-channels:
> +        maxItems: 2
> +
> +      io-channel-names:
> +        items:
> +          - const: aux1
> +          - const: aux2
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +  ab8500_btemp:
> +    type: object
> +    $ref: ../power/supply/stericsson,ab8500-btemp.yaml
> +
> +  ab8500_charger:
> +    type: object
> +    $ref: ../power/supply/stericsson,ab8500-charger.yaml
> +
> +  ab8500_fg:
> +    type: object
> +    $ref: ../power/supply/stericsson,ab8500-fg.yaml
> +
> +  ab8500_chargalg:
> +    type: object
> +    $ref: ../power/supply/stericsson,ab8500-chargalg.yaml
> +
> +  ab8500_battery:
> +    type: object
> +    properties:
> +      stericsson,battery-type:
> +        description: battery chemistry
> +        enum:
> +          - UNKNOWN
> +          - NiMH
> +          - LION
> +          - LIPO
> +          - LiFe
> +          - NiCd
> +          - LiMn
> +
> +      thermistor-on-batctrl:
> +        type: boolean
> +        description:
> +          if set 'batctrl' is used for thermal measurement, otherwise 'btemp'
> +          is used for thermal measurement.
> +
> +    additionalProperties: false
> +
> +  ab8500_usb:
> +    type: object
> +    properties:
> +      compatible:
> +        const: stericsson,ab8500-usb
> +
> +      interrupts:
> +        maxItems: 7
> +
> +      interrupt-names:
> +        items:
> +          - const: ID_WAKEUP_R
> +          - const: ID_WAKEUP_F
> +          - const: VBUS_DET_F
> +          - const: VBUS_DET_R
> +          - const: USB_LINK_STATUS
> +          - const: USB_ADP_PROBE_PLUG
> +          - const: USB_ADP_PROBE_UNPLUG
> +
> +      vddulpivio18-supply:
> +        description: 1.8V VIO
> +
> +      v-ape-supply:
> +        description: V-APE
> +
> +      musb_1v8-supply:
> +        description: MUSB 1.8V
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        items:
> +          - const: sysclk
> +
> +    additionalProperties: false
> +
> +  ab8500-ponkey:
> +    type: object
> +    properties:
> +      compatible:
> +        const: stericsson,ab8500-poweron-key
> +
> +      interrupts:
> +        maxItems: 2
> +
> +      interrupt-names:
> +        items:
> +          - const: ONKEY_DBF
> +          - const: ONKEY_DBR
> +
> +    additionalProperties: false
> +
> +  ab8500-sysctrl:
> +    type: object
> +    properties:
> +      compatible:
> +        const: stericsson,ab8500-sysctrl
> +
> +    additionalProperties: false
> +
> +  ab8500-debugfs:
> +    type: object
> +    properties:
> +      compatible:
> +        const: stericsson,ab8500-debug
> +
> +    additionalProperties: false
> +
> +  ab8500-codec:
> +    type: object
> +    properties:
> +      compatible:
> +        const: stericsson,ab8500-codec
> +
> +      V-AUD-supply:
> +        description: V-AUD supply
> +
> +      V-AMIC1-supply:
> +        description: V-AMIC1 supply
> +
> +      V-AMIC2-supply:
> +        description: V-AMIC2 supply
> +
> +      V-DMIC-supply:
> +        description: V-DMIC supply
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        items:
> +          - const: audioclk
> +
> +      stericsson,earpeice-cmv:
> +        description: earpiece voltage in mV
> +        enum: [950, 1100, 1270, 1580]
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +    additionalProperties: false
> +
> +  ab8500-ext-regulators:
> +    type: object
> +    properties:
> +      compatible:
> +        const: stericsson,ab8500-ext-regulator
> +
> +    patternProperties:
> +      "^ab8500_ext[1-3]$":
> +        $ref: /schemas/regulator/regulator.yaml
> +
> +    additionalProperties: false
> +
> +patternProperties:
> +  "^ab8500-pwm(-[1-3])?$":
> +    type: object
> +    properties:
> +      compatible:
> +        const: stericsson,ab8500-pwm
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        items:
> +          - const: intclk
> +
> +    additionalProperties: false
> +  "^ab850[05]-gpiocontroller$":
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - stericsson,ab8500-gpio
> +          - stericsson,ab8505-gpio
> +          - stericsson,ab8540-gpio
> +          - stericsson,ab9540-gpio
> +
> +      gpio-controller: true
> +
> +      "#gpio-cells":
> +        const: 2
> +
> +    required:
> +      - compatible
> +      - gpio-controller
> +      - "#gpio-cells"
> +
> +    patternProperties:
> +      "^.*$":
> +        $ref: "/schemas/pinctrl/pincfg-node.yaml"

This is going to match on all properties. Ideally, we'd have some 
pattern to match on, but you can do this instead:

additionalProperties:
  type: object
  $ref: "/schemas/pinctrl/pincfg-node.yaml"


> +
> +    additionalProperties: false
> +
> +  "^ab850[05]-regulators$":
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - stericsson,ab8500-regulator
> +          - stericsson,ab8505-regulator
> +
> +      vin-supply:
> +        description: input supply
> +
> +    patternProperties:
> +      "^ab8500_ldo_adc$|^ab8500_ldo_aux[1-8]$|^ab8500_ldo_intcore$|^ab8500_ldo_tvout$|^ab8500_ldo_audio$|^ab8500_ldo_anamic[12]$|^ab8500_ldo_dmic$|^ab8500_ldo_ana$":

Can't you factor out 'ab8500_ldo_'?

> +        $ref: /schemas/regulator/regulator.yaml
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/mfd/dbx500-prcmu.h>
> +    #include <dt-bindings/clock/ste-ab8500.h>
> +    ab8500 {
> +        compatible = "stericsson,ab8500";
> +        interrupt-parent = <&intc>;
> +        interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +
> +        ab8500_clock: clock-controller {
> +            compatible = "stericsson,ab8500-clk";
> +            #clock-cells = <1>;
> +        };
> +
> +        ab8500_gpio: ab8500-gpiocontroller {
> +            compatible = "stericsson,ab8500-gpio";
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +        };
> +
> +        ab8500-rtc {
> +            compatible = "stericsson,ab8500-rtc";
> +            interrupts = <17 IRQ_TYPE_LEVEL_HIGH>,
> +                         <18 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "60S", "ALARM";
> +        };
> +
> +        gpadc: ab8500-gpadc {
> +            compatible = "stericsson,ab8500-gpadc";
> +            interrupts = <32 IRQ_TYPE_LEVEL_HIGH>,
> +                         <39 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "HW_CONV_END", "SW_CONV_END";
> +            vddadc-supply = <&ab8500_ldo_tvout_reg>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #io-channel-cells = <1>;
> +
> +            /* GPADC channels */
> +            bat_ctrl: channel@1 {
> +                reg = <0x01>;
> +            };
> +            btemp_ball: channel@2 {
> +                reg = <0x02>;
> +            };
> +            main_charger_v: channel@3 {
> +                reg = <0x03>;
> +            };
> +            acc_detect1: channel@4 {
> +                reg = <0x04>;
> +            };
> +            acc_detect2: channel@5 {
> +                reg = <0x05>;
> +            };
> +            adc_aux1: channel@6 {
> +                reg = <0x06>;
> +            };
> +            adc_aux2: channel@7 {
> +                reg = <0x07>;
> +            };
> +            main_batt_v: channel@8 {
> +                reg = <0x08>;
> +            };
> +            vbus_v: channel@9 {
> +                reg = <0x09>;
> +            };
> +            main_charger_c: channel@a {
> +                reg = <0x0a>;
> +            };
> +            usb_charger_c: channel@b {
> +                reg = <0x0b>;
> +            };
> +            bk_bat_v: channel@c {
> +                reg = <0x0c>;
> +            };
> +            die_temp: channel@d {
> +                reg = <0x0d>;
> +            };
> +            usb_id: channel@e {
> +                reg = <0x0e>;
> +            };
> +            xtal_temp: channel@12 {
> +                reg = <0x12>;
> +            };
> +            vbat_true_meas: channel@13 {
> +                reg = <0x13>;
> +            };
> +            bat_ctrl_and_ibat: channel@1c {
> +                reg = <0x1c>;
> +            };
> +            vbat_meas_and_ibat: channel@1d {
> +                reg = <0x1d>;
> +            };
> +            vbat_true_meas_and_ibat: channel@1e {
> +                reg = <0x1e>;
> +            };
> +            bat_temp_and_ibat: channel@1f {
> +                reg = <0x1f>;
> +            };
> +        };
> +
> +        ab8500_temp {
> +            compatible = "stericsson,abx500-temp";
> +            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "ABX500_TEMP_WARM";
> +            io-channels = <&gpadc 0x06>,
> +                          <&gpadc 0x07>;
> +            io-channel-names = "aux1", "aux2";
> +        };
> +
> +        ab8500_battery: ab8500_battery {
> +            stericsson,battery-type = "LIPO";
> +            thermistor-on-batctrl;
> +        };
> +
> +        ab8500_fg {
> +            compatible = "stericsson,ab8500-fg";
> +            interrupts = <24 IRQ_TYPE_LEVEL_HIGH>,
> +                         <8 IRQ_TYPE_LEVEL_HIGH>,
> +                         <28 IRQ_TYPE_LEVEL_HIGH>,
> +                         <27 IRQ_TYPE_LEVEL_HIGH>,
> +                         <26 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "NCONV_ACCU",
> +                              "BATT_OVV",
> +                              "LOW_BAT_F",
> +                              "CC_INT_CALIB",
> +                              "CCEOC";
> +            battery = <&ab8500_battery>;
> +            io-channels = <&gpadc 0x08>;
> +            io-channel-names = "main_bat_v";
> +        };
> +
> +        ab8500_btemp {
> +            compatible = "stericsson,ab8500-btemp";
> +            interrupts = <20 IRQ_TYPE_LEVEL_HIGH>,
> +                         <80 IRQ_TYPE_LEVEL_HIGH>,
> +                         <83 IRQ_TYPE_LEVEL_HIGH>,
> +                         <81 IRQ_TYPE_LEVEL_HIGH>,
> +                         <82 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "BAT_CTRL_INDB",
> +                              "BTEMP_LOW",
> +                              "BTEMP_HIGH",
> +                              "BTEMP_LOW_MEDIUM",
> +                              "BTEMP_MEDIUM_HIGH";
> +            battery = <&ab8500_battery>;
> +            io-channels = <&gpadc 0x02>,
> +                          <&gpadc 0x01>;
> +            io-channel-names = "btemp_ball",
> +                            "bat_ctrl";
> +        };
> +
> +        ab8500_charger {
> +            compatible = "stericsson,ab8500-charger";
> +            interrupts = <10 IRQ_TYPE_LEVEL_HIGH>,
> +                         <11 IRQ_TYPE_LEVEL_HIGH>,
> +                         <0 IRQ_TYPE_LEVEL_HIGH>,
> +                         <107 IRQ_TYPE_LEVEL_HIGH>,
> +                         <106 IRQ_TYPE_LEVEL_HIGH>,
> +                         <14 IRQ_TYPE_LEVEL_HIGH>,
> +                         <15 IRQ_TYPE_LEVEL_HIGH>,
> +                         <79 IRQ_TYPE_LEVEL_HIGH>,
> +                         <105 IRQ_TYPE_LEVEL_HIGH>,
> +                         <104 IRQ_TYPE_LEVEL_HIGH>,
> +                         <89 IRQ_TYPE_LEVEL_HIGH>,
> +                         <22 IRQ_TYPE_LEVEL_HIGH>,
> +                         <21 IRQ_TYPE_LEVEL_HIGH>,
> +                         <16 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "MAIN_CH_UNPLUG_DET",
> +                              "MAIN_CHARGE_PLUG_DET",
> +                              "MAIN_EXT_CH_NOT_OK",
> +                              "MAIN_CH_TH_PROT_R",
> +                              "MAIN_CH_TH_PROT_F",
> +                              "VBUS_DET_F",
> +                              "VBUS_DET_R",
> +                              "USB_LINK_STATUS",
> +                              "USB_CH_TH_PROT_R",
> +                              "USB_CH_TH_PROT_F",
> +                              "USB_CHARGER_NOT_OKR",
> +                              "VBUS_OVV",
> +                              "CH_WD_EXP",
> +                              "VBUS_CH_DROP_END";
> +            battery = <&ab8500_battery>;
> +            vddadc-supply = <&ab8500_ldo_tvout_reg>;
> +            io-channels = <&gpadc 0x03>,
> +                          <&gpadc 0x0a>,
> +                          <&gpadc 0x09>,
> +                          <&gpadc 0x0b>;
> +            io-channel-names = "main_charger_v",
> +                            "main_charger_c",
> +                            "vbus_v",
> +                            "usb_charger_c";
> +        };
> +
> +        ab8500_chargalg {
> +            compatible = "stericsson,ab8500-chargalg";
> +            battery = <&ab8500_battery>;
> +        };
> +
> +        ab8500_usb {
> +            compatible = "stericsson,ab8500-usb";
> +            interrupts = <90 IRQ_TYPE_LEVEL_HIGH>,
> +                         <96 IRQ_TYPE_LEVEL_HIGH>,
> +                         <14 IRQ_TYPE_LEVEL_HIGH>,
> +                         <15 IRQ_TYPE_LEVEL_HIGH>,
> +                         <79 IRQ_TYPE_LEVEL_HIGH>,
> +                         <74 IRQ_TYPE_LEVEL_HIGH>,
> +                         <75 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "ID_WAKEUP_R",
> +                              "ID_WAKEUP_F",
> +                              "VBUS_DET_F",
> +                              "VBUS_DET_R",
> +                              "USB_LINK_STATUS",
> +                              "USB_ADP_PROBE_PLUG",
> +                              "USB_ADP_PROBE_UNPLUG";
> +            vddulpivio18-supply = <&ab8500_ldo_intcore_reg>;
> +            v-ape-supply = <&db8500_vape_reg>;
> +            musb_1v8-supply = <&db8500_vsmps2_reg>;
> +            clocks = <&prcmu_clk PRCMU_SYSCLK>;
> +            clock-names = "sysclk";
> +        };
> +
> +        ab8500-ponkey {
> +            compatible = "stericsson,ab8500-poweron-key";
> +            interrupts = <6 IRQ_TYPE_LEVEL_HIGH>,
> +                         <7 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "ONKEY_DBF", "ONKEY_DBR";
> +        };
> +
> +        ab8500-sysctrl {
> +            compatible = "stericsson,ab8500-sysctrl";
> +        };
> +
> +        ab8500-pwm-1 {
> +            compatible = "stericsson,ab8500-pwm";
> +            clocks = <&ab8500_clock AB8500_SYSCLK_INT>;
> +            clock-names = "intclk";
> +        };
> +
> +        ab8500-pwm-2 {
> +            compatible = "stericsson,ab8500-pwm";
> +            clocks = <&ab8500_clock AB8500_SYSCLK_INT>;
> +            clock-names = "intclk";
> +        };
> +
> +        ab8500-pwm-3 {
> +            compatible = "stericsson,ab8500-pwm";
> +            clocks = <&ab8500_clock AB8500_SYSCLK_INT>;
> +            clock-names = "intclk";
> +        };
> +
> +        ab8500-debugfs {
> +            compatible = "stericsson,ab8500-debug";
> +        };
> +
> +        codec: ab8500-codec {
> +            compatible = "stericsson,ab8500-codec";
> +
> +            V-AUD-supply = <&ab8500_ldo_audio_reg>;
> +            V-AMIC1-supply = <&ab8500_ldo_anamic1_reg>;
> +            V-AMIC2-supply = <&ab8500_ldo_anamic2_reg>;
> +            V-DMIC-supply = <&ab8500_ldo_dmic_reg>;
> +
> +            clocks = <&ab8500_clock AB8500_SYSCLK_AUDIO>;
> +            clock-names = "audioclk";
> +
> +            stericsson,earpeice-cmv = <950>; /* Units in mV. */
> +        };
> +
> +        ext_regulators: ab8500-ext-regulators {
> +            compatible = "stericsson,ab8500-ext-regulator";
> +
> +            ab8500_ext1_reg: ab8500_ext1 {
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <1800000>;
> +                regulator-boot-on;
> +                regulator-always-on;
> +            };
> +
> +            ab8500_ext2_reg: ab8500_ext2 {
> +                regulator-min-microvolt = <1360000>;
> +                regulator-max-microvolt = <1360000>;
> +                regulator-boot-on;
> +                regulator-always-on;
> +            };
> +
> +            ab8500_ext3_reg: ab8500_ext3 {
> +                regulator-min-microvolt = <3400000>;
> +                regulator-max-microvolt = <3400000>;
> +                regulator-boot-on;
> +            };
> +        };
> +
> +        ab8500-regulators {
> +            compatible = "stericsson,ab8500-regulator";
> +            vin-supply = <&ab8500_ext3_reg>;
> +
> +            // supplies to the display/camera
> +            ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
> +                regulator-min-microvolt = <2500000>;
> +                regulator-max-microvolt = <2900000>;
> +                regulator-boot-on;
> +                /* BUG: If turned off MMC will be affected. */
> +                regulator-always-on;
> +            };
> +
> +            // supplies to the on-board eMMC
> +            ab8500_ldo_aux2_reg: ab8500_ldo_aux2 {
> +                regulator-min-microvolt = <1100000>;
> +                regulator-max-microvolt = <3300000>;
> +            };
> +
> +            // supply for VAUX3; SDcard slots
> +            ab8500_ldo_aux3_reg: ab8500_ldo_aux3 {
> +                regulator-min-microvolt = <1100000>;
> +                regulator-max-microvolt = <3300000>;
> +            };
> +
> +            // supply for v-intcore12; VINTCORE12 LDO
> +            ab8500_ldo_intcore_reg: ab8500_ldo_intcore {
> +            };
> +
> +            // supply for tvout; gpadc; TVOUT LDO
> +            ab8500_ldo_tvout_reg: ab8500_ldo_tvout {
> +            };
> +
> +            // supply for ab8500-vaudio; VAUDIO LDO
> +            ab8500_ldo_audio_reg: ab8500_ldo_audio {
> +            };
> +
> +            // supply for v-anamic1 VAMIC1 LDO
> +            ab8500_ldo_anamic1_reg: ab8500_ldo_anamic1 {
> +            };
> +
> +            // supply for v-amic2; VAMIC2 LDO; reuse constants for AMIC1
> +            ab8500_ldo_anamic2_reg: ab8500_ldo_anamic2 {
> +            };
> +
> +            // supply for v-dmic; VDMIC LDO
> +            ab8500_ldo_dmic_reg: ab8500_ldo_dmic {
> +            };
> +
> +            // supply for U8500 CSI/DSI; VANA LDO
> +            ab8500_ldo_ana_reg: ab8500_ldo_ana {
> +            };
> +        };
> +    };
