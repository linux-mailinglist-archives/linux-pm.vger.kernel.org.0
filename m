Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A8326220C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 23:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgIHVr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 17:47:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44324 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgIHVr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 17:47:27 -0400
Received: by mail-io1-f65.google.com with SMTP id g128so956886iof.11;
        Tue, 08 Sep 2020 14:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sTYXaiUD/OWZiYcJk0O2vC8QjC9OKmIZkmz3CFH6qNM=;
        b=LcxvS798SuRJRSf7YxSkTHFCmPY/kyyC0841c8ZiyC6NgA2I2s1ROPV2Y8sIQMI6Pa
         CVAd6HLRt7gZc6wscSmNgxFRWedfPaAAZi+i32/K/YX0AXJnhwiueYaAd52FfttxLDey
         GQS45DvnYCWbzOCMjmHbjeZFsz49llRbQzVYtaCVQL3dhDxpoEkxmCOeKqJIJ7f0v6wn
         8Top7yp48MIqVk4arE4Mor746xFTBfbYU+T/rsaUMp+YCaqOErVbOgwrVBC3AfADWWNi
         /IcjVdiyhsf/7IGgKR6f1a6VThfa1HNXcghS/xiVgk+x6ZO1NPQzEg8/MtgA3hr7ghpS
         1SHw==
X-Gm-Message-State: AOAM531MYxiA5pQYohVS3KaAZPyNIN8juEUPkMGsuz7wAMGUATBHBF2S
        zNtGKvzFDH4YQluxBMA3iw==
X-Google-Smtp-Source: ABdhPJwkL725r8DUIlZ52rk1ZuFhOUh1JOhBkkQ9uBQhUgQj2uBgO266AI/nRvcb1Orl6kr1njD/Lw==
X-Received: by 2002:a6b:244:: with SMTP id 65mr835231ioc.7.1599601646180;
        Tue, 08 Sep 2020 14:47:26 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y10sm282425ioy.25.2020.09.08.14.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 14:47:25 -0700 (PDT)
Received: (nullmailer pid 985029 invoked by uid 1000);
        Tue, 08 Sep 2020 21:47:24 -0000
Date:   Tue, 8 Sep 2020 15:47:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: Add Actions Semi ATC260x PMIC
 binding
Message-ID: <20200908214724.GA959481@bogus>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
 <863c9c1e44cfbe6184bf0bd4893ff456af0e7bb8.1598043782.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <863c9c1e44cfbe6184bf0bd4893ff456af0e7bb8.1598043782.git.cristian.ciocaltea@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Aug 22, 2020 at 01:19:47AM +0300, Cristian Ciocaltea wrote:
> Add devicetree binding for Actions Semi ATC260x PMICs.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  .../bindings/mfd/actions,atc260x.yaml         | 221 ++++++++++++++++++
>  1 file changed, 221 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> new file mode 100644
> index 000000000000..4a55bbe1306e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> @@ -0,0 +1,221 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/actions,atc260x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi ATC260x Power Management IC bindings
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> +
> +description: |
> +  ATC260x series PMICs integrates Audio Codec, Power Management, RTC, IR
> +  and GPIO controller blocks. Currently only the PM related functionalities
> +  (i.e. regulators and system power-off/reboot) for the ATC2603C and ATC2609A
> +  chip variants are supported.
> +  ATC2603C includes 3 programmable DC-DC converters and 9 LDO regulators.
> +  ATC2609A includes 5 programmable DC-DC converters and 10 LDO regulators.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - actions,atc2603c
> +      - actions,atc2609a
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  pwrc:
> +    type: object
> +    description: |
> +      The power controller integrated in ATC260x provides system power-off
> +      and reboot operations.

No need for this node as there are no properties, just instantiate 
what's needed in the MFD driver.

> +
> +    properties:
> +      compatible:
> +        enum:
> +          - actions,atc2603c-pwrc
> +          - actions,atc2609a-pwrc
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +  onkey:
> +    type: object
> +    description: |
> +      Use the ONKEY built into ATC260x PMICs as an input device reporting
> +      power button status. ONKEY can be used to wakeup from low power
> +      modes and force a reset on long press.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - actions,atc2603c-onkey
> +          - actions,atc2609a-onkey
> +
> +      actions,reset-time-sec:
> +        description: |
> +          Duration in seconds which the key should be kept pressed for device
> +          to reset automatically. The hardware default is 8. Use 0 to disable
> +          this functionality.
> +        enum: [0, 6, 8, 10, 12]

We already have 'power-off-time-sec' in input.yaml. How about adding 
'reset-time-sec' there.

This could really just be a property in the parent node.

> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +  regulators:
> +    type: object
> +    description: |
> +      List of child nodes specifying the regulators, depending on chip variant:
> +      * ATC2603C: dcdc[1-3], ldo[1-3,5-8,11], switchldo1
> +      * ATC2609A: dcdc[0-4], ldo[0-9]
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - actions,atc2603c-regulator
> +          - actions,atc2609a-regulator
> +
> +      switchldo1:
> +        type: object
> +        $ref: ../regulator/regulator.yaml
> +
> +        properties:
> +          regulator-name: true
> +          regulator-boot-on: true
> +          regulator-always-on: true
> +          regulator-min-microvolt: true
> +          regulator-max-microvolt: true
> +          regulator-allow-bypass: true
> +          regulator-active-discharge: true
> +
> +        additionalProperties: false
> +
> +    patternProperties:
> +      "^(dcdc[0-4]|ldo[0-9]|ldo11|switchldo1)-supply$":
> +        description: ATC260x voltage regulators supplies
> +
> +      "^(dcdc[0-4]|ldo[0-9]|ldo11)$":
> +        type: object
> +        $ref: ../regulator/regulator.yaml
> +
> +        properties:
> +          regulator-name: true
> +          regulator-boot-on: true
> +          regulator-always-on: true
> +          regulator-min-microvolt: true
> +          regulator-max-microvolt: true
> +          regulator-allow-bypass: true
> +
> +        additionalProperties: false
> +
> +    allOf:
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: actions,atc2603c-regulator
> +        then:
> +          patternProperties:
> +            "^(dcdc[0,4]|ldo[0,4,9])(-supply)?$": false
> +
> +            "^(ldo|dcdc)":
> +              properties:
> +                regulator-allow-bypass: false
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: actions,atc2609a-regulator
> +        then:
> +          patternProperties:
> +            "^(ldo11|switchldo1)(-supply)?$": false
> +
> +            "^(dcdc|ldo[3-9])":
> +              properties:
> +                regulator-allow-bypass: false
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@65 {
> +        compatible = "actions,atc2603c";
> +        reg = <0x65>;
> +        interrupt-parent = <&sirq>;
> +        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        pwrc {
> +          compatible = "actions,atc2603c-pwrc";
> +        };
> +
> +        onkey {
> +          compatible = "actions,atc2603c-onkey";
> +          actions,reset-time-sec = <6>;
> +        };
> +
> +        regulators {
> +          compatible = "actions,atc2603c-regulator";
> +
> +          dcdc1-supply = <&reg_5v0>;
> +          dcdc3-supply = <&reg_5v0>;
> +          ldo5-supply = <&reg_5v0>;
> +          switchldo1-supply = <&vcc>;
> +
> +          vdd_cpu: dcdc1 {
> +            regulator-name = "VDD_CPU";
> +            regulator-min-microvolt = <700000>;
> +            regulator-max-microvolt = <1400000>;
> +            regulator-always-on;
> +          };
> +
> +          vcc: dcdc3 {
> +            regulator-name = "VCC";
> +            regulator-min-microvolt = <2600000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-always-on;
> +          };
> +
> +          vcc_3v1: ldo5 {
> +            regulator-name = "VCC_3V1";
> +            regulator-min-microvolt = <2600000>;
> +            regulator-max-microvolt = <3300000>;
> +          };
> +
> +          sd_vcc: switchldo1 {
> +            regulator-name = "SD_VCC";
> +            regulator-min-microvolt = <3000000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-always-on;
> +            regulator-boot-on;
> +          };
> +        };
> +      };
> +    };
> +
> +...
> -- 
> 2.28.0
> 
