Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCCB2632ED
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 18:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgIIQEO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 12:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730871AbgIIQDk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 12:03:40 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D063EC061756;
        Wed,  9 Sep 2020 09:03:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c10so3216770edk.6;
        Wed, 09 Sep 2020 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wFFzLDrI+LRiU6RjuLeqeQ9NmNXTj6WvqrdOw9KuB74=;
        b=dtgEidWQWGnPfTY+p6W+UM6e8pUns0tL63U5Lx+mzClihOlw3YnZltPvaa4J+S+hm5
         eppMOGnpvEqQobOmZwarAPE9FgbEtQNKvhwMj+Ap98TwK5Lu4ijDhfSdLGWnZjkXVcea
         dh//8CGUm/WD60tLCP4eLk5MjUb68NYLrsleQCpSBqXxewUW1G3XxKF9dapNBYoOznh4
         3p1FMVR+2t6kYiuJj9G8eHNIWiOklHQrJYJG5vobsCR99x/6CsDAjdI5ftwVL9ljdDQm
         GsuABHYMl4nwDtyJcfOig//q+syxOeYre7gl9sfha9lBWJBnQ5t8QcqHkyiaILpHedw/
         qG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wFFzLDrI+LRiU6RjuLeqeQ9NmNXTj6WvqrdOw9KuB74=;
        b=PjfHECZK/U8QzAXCaKjZMa66eFosDYPAwk3RJuvDnLxtkExvwi8XBBvtB351HcrYs1
         s3dd4a8nx20iNfI4Vu0X9RcFPWdxeDbIetd2Et9XfAsWY4OnnVBDUPUv3a/J66VzB+Cq
         RmDqlWrhdIFT/Lwd3bht4Ec7Qm40cgdJjCfCXXGIme1TDEsORE0XU5Rvxox1M37QpZKs
         tL0H9vCbawLP6foM1KyUO8Dv4W7zPHngU4yWmZhoAHMvyrodsVbbApka2iwyOU6hloGj
         HCg/CftXAHDoJd+s65hacZEO4rBbzlxQ+iHq0sV92URXLOSnPcqltTonSh+u703CuCu/
         QtOw==
X-Gm-Message-State: AOAM533GtFqj4lO+f0R5Xs2dJpKg7dtVZZuHhOE1YRR9ok5Yvs/Qle9G
        bT8QvCj2qZPfHlot0OSUcFJTwVJb0DA=
X-Google-Smtp-Source: ABdhPJx6EOlwx44g53DleVKdxsTSqVWdmunkZ/V2Qwx8KdcFBUMu3uaER3jCrG+1ovQ9sIE93uMImw==
X-Received: by 2002:a50:d98d:: with SMTP id w13mr5029328edj.37.1599667418391;
        Wed, 09 Sep 2020 09:03:38 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id n14sm3065473edb.52.2020.09.09.09.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:03:37 -0700 (PDT)
Date:   Wed, 9 Sep 2020 19:03:34 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <20200909160334.GA385382@BV030612LT>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
 <863c9c1e44cfbe6184bf0bd4893ff456af0e7bb8.1598043782.git.cristian.ciocaltea@gmail.com>
 <20200908214724.GA959481@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908214724.GA959481@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

Thanks for reviewing!

On Tue, Sep 08, 2020 at 03:47:24PM -0600, Rob Herring wrote:
> On Sat, Aug 22, 2020 at 01:19:47AM +0300, Cristian Ciocaltea wrote:
> > Add devicetree binding for Actions Semi ATC260x PMICs.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  .../bindings/mfd/actions,atc260x.yaml         | 221 ++++++++++++++++++
> >  1 file changed, 221 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> > new file mode 100644
> > index 000000000000..4a55bbe1306e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> > @@ -0,0 +1,221 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/actions,atc260x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Actions Semi ATC260x Power Management IC bindings
> > +
> > +maintainers:
> > +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > +
> > +description: |
> > +  ATC260x series PMICs integrates Audio Codec, Power Management, RTC, IR
> > +  and GPIO controller blocks. Currently only the PM related functionalities
> > +  (i.e. regulators and system power-off/reboot) for the ATC2603C and ATC2609A
> > +  chip variants are supported.
> > +  ATC2603C includes 3 programmable DC-DC converters and 9 LDO regulators.
> > +  ATC2609A includes 5 programmable DC-DC converters and 10 LDO regulators.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - actions,atc2603c
> > +      - actions,atc2609a
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  pwrc:
> > +    type: object
> > +    description: |
> > +      The power controller integrated in ATC260x provides system power-off
> > +      and reboot operations.
> 
> No need for this node as there are no properties, just instantiate 
> what's needed in the MFD driver.

My intention was to allow the user specify what functionality in the MFD
shall be enabled. For this particular case, if the 'pwrc' node is not
provided, the power-off/reboot functions will be disabled.

> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - actions,atc2603c-pwrc
> > +          - actions,atc2609a-pwrc
> > +
> > +    required:
> > +      - compatible
> > +
> > +    additionalProperties: false
> > +
> > +  onkey:
> > +    type: object
> > +    description: |
> > +      Use the ONKEY built into ATC260x PMICs as an input device reporting
> > +      power button status. ONKEY can be used to wakeup from low power
> > +      modes and force a reset on long press.
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - actions,atc2603c-onkey
> > +          - actions,atc2609a-onkey
> > +
> > +      actions,reset-time-sec:
> > +        description: |
> > +          Duration in seconds which the key should be kept pressed for device
> > +          to reset automatically. The hardware default is 8. Use 0 to disable
> > +          this functionality.
> > +        enum: [0, 6, 8, 10, 12]
> 
> We already have 'power-off-time-sec' in input.yaml. How about adding 
> 'reset-time-sec' there.

Thanks for the suggestion, I was actually looking for this before
choosing the custom property and just assumed this was not added for
a particular reason.

So I'm going to handle it. Would you like me to send a separate patch
(not part of this series)?

> This could really just be a property in the parent node.

This is similar with 'pwrc': if 'onkey' node is not present, the ONKEY
functionality will not be enabled.

Is there a better/recommended approach to manage this MFD feature
selection?

> > +
> > +    required:
> > +      - compatible
> > +
> > +    additionalProperties: false
> > +
> > +  regulators:
> > +    type: object
> > +    description: |
> > +      List of child nodes specifying the regulators, depending on chip variant:
> > +      * ATC2603C: dcdc[1-3], ldo[1-3,5-8,11], switchldo1
> > +      * ATC2609A: dcdc[0-4], ldo[0-9]
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - actions,atc2603c-regulator
> > +          - actions,atc2609a-regulator
> > +
> > +      switchldo1:
> > +        type: object
> > +        $ref: ../regulator/regulator.yaml
> > +
> > +        properties:
> > +          regulator-name: true
> > +          regulator-boot-on: true
> > +          regulator-always-on: true
> > +          regulator-min-microvolt: true
> > +          regulator-max-microvolt: true
> > +          regulator-allow-bypass: true
> > +          regulator-active-discharge: true
> > +
> > +        additionalProperties: false
> > +
> > +    patternProperties:
> > +      "^(dcdc[0-4]|ldo[0-9]|ldo11|switchldo1)-supply$":
> > +        description: ATC260x voltage regulators supplies
> > +
> > +      "^(dcdc[0-4]|ldo[0-9]|ldo11)$":
> > +        type: object
> > +        $ref: ../regulator/regulator.yaml
> > +
> > +        properties:
> > +          regulator-name: true
> > +          regulator-boot-on: true
> > +          regulator-always-on: true
> > +          regulator-min-microvolt: true
> > +          regulator-max-microvolt: true
> > +          regulator-allow-bypass: true
> > +
> > +        additionalProperties: false
> > +
> > +    allOf:
> > +      - if:
> > +          properties:
> > +            compatible:
> > +              contains:
> > +                const: actions,atc2603c-regulator
> > +        then:
> > +          patternProperties:
> > +            "^(dcdc[0,4]|ldo[0,4,9])(-supply)?$": false
> > +
> > +            "^(ldo|dcdc)":
> > +              properties:
> > +                regulator-allow-bypass: false
> > +      - if:
> > +          properties:
> > +            compatible:
> > +              contains:
> > +                const: actions,atc2609a-regulator
> > +        then:
> > +          patternProperties:
> > +            "^(ldo11|switchldo1)(-supply)?$": false
> > +
> > +            "^(dcdc|ldo[3-9])":
> > +              properties:
> > +                regulator-allow-bypass: false
> > +
> > +    required:
> > +      - compatible
> > +
> > +    additionalProperties: false
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    i2c0 {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      pmic@65 {
> > +        compatible = "actions,atc2603c";
> > +        reg = <0x65>;
> > +        interrupt-parent = <&sirq>;
> > +        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +        pwrc {
> > +          compatible = "actions,atc2603c-pwrc";
> > +        };
> > +
> > +        onkey {
> > +          compatible = "actions,atc2603c-onkey";
> > +          actions,reset-time-sec = <6>;
> > +        };
> > +
> > +        regulators {
> > +          compatible = "actions,atc2603c-regulator";
> > +
> > +          dcdc1-supply = <&reg_5v0>;
> > +          dcdc3-supply = <&reg_5v0>;
> > +          ldo5-supply = <&reg_5v0>;
> > +          switchldo1-supply = <&vcc>;
> > +
> > +          vdd_cpu: dcdc1 {
> > +            regulator-name = "VDD_CPU";
> > +            regulator-min-microvolt = <700000>;
> > +            regulator-max-microvolt = <1400000>;
> > +            regulator-always-on;
> > +          };
> > +
> > +          vcc: dcdc3 {
> > +            regulator-name = "VCC";
> > +            regulator-min-microvolt = <2600000>;
> > +            regulator-max-microvolt = <3300000>;
> > +            regulator-always-on;
> > +          };
> > +
> > +          vcc_3v1: ldo5 {
> > +            regulator-name = "VCC_3V1";
> > +            regulator-min-microvolt = <2600000>;
> > +            regulator-max-microvolt = <3300000>;
> > +          };
> > +
> > +          sd_vcc: switchldo1 {
> > +            regulator-name = "SD_VCC";
> > +            regulator-min-microvolt = <3000000>;
> > +            regulator-max-microvolt = <3300000>;
> > +            regulator-always-on;
> > +            regulator-boot-on;
> > +          };
> > +        };
> > +      };
> > +    };
> > +
> > +...
> > -- 
> > 2.28.0
> > 

Kind regards,
Cristi
