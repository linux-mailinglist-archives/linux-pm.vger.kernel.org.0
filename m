Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C454F534
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 12:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381802AbiFQKT4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 06:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380514AbiFQKTy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 06:19:54 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB666AF4;
        Fri, 17 Jun 2022 03:19:54 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r3so2674245ilt.8;
        Fri, 17 Jun 2022 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AkSari7bAxs5W9Thyg7DZj8au2shA+BuW6if8TWNztg=;
        b=gmG7D5TYbIJ1rbU9KhrqGNKFkbSfmIvY3YE56PlVOk23zyp+MNWWv+wfrOtO2gxRET
         isS0fGy2XpjDNOzyx4VHdOV1gGddPxgTnSJi2XsWIMwF2Hz3S2/Xc99IWxjWEaWzsAX1
         WsNVb4OnB6jZl7x+yXUQRdckbNXiETO4yUbxGUO0aA4t+dxjZ9nLuF6vgVY9DGZXUk9D
         n9cEdeb9vRqsek0klg/2l5hJvxxMj/Tyi60Nyn/3M2lpOlVGSC7aZfTxRIZM1XVL/rsn
         36DnLnDGYLPORH9GMIPeAkHds0FauGzFfalTmdwtMEguv9rTKwbTv4IQvYr7svsDHo3q
         ZwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AkSari7bAxs5W9Thyg7DZj8au2shA+BuW6if8TWNztg=;
        b=C21JPL8Hs7gNz4yslxW7acjzbonuCgOpQ7uExU7aK8042IdfCNyYfRO0btMOLrPVvq
         R/Ix3TrV6gMD67bwlY+gp/X6RFTUh9kr2MFYelwWv9rJKqxDoyeQSupVm/yRwNzoj26E
         COOCC3OXl5ymnJoz3PkDD80hlO3gxLcg7XHbWTEr1RRZN3qs/a34m7tD+WibMGb6W+1x
         zvNSuZVzFl0dd8ZceS2kmb9tHo3BxyYx1YV4zWQyKFBlo9rcqMurB8ElBhEh9puWLSWY
         yTZt2ZF9M+XDrYTOAlQFAe+5qZPV5LI/vg+tgR5FsGJHAnfH8VJz7SmgmBCQt/MxxOn8
         dhqw==
X-Gm-Message-State: AJIora9vckn2DdVmah4BolgNtlTy42yxHOE65qOt5Av9hJ32NTqxVJiz
        zq0a4m/LTuBT45IjKZZLb3PFonvw8jvROSaD9fo=
X-Google-Smtp-Source: AGRyM1vBig2TkzvQyr0K0aw7hKaPczT4z9o+rJHZFkgWvf1gI+BxeOefKWTGj0V9A5c6CuCCBvpmQwdXw0KzMt5didk=
X-Received: by 2002:a05:6e02:198c:b0:2d8:e8bd:d8ff with SMTP id
 g12-20020a056e02198c00b002d8e8bdd8ffmr470214ilf.66.1655461193630; Fri, 17 Jun
 2022 03:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220613111146.25221-1-peterwu.pub@gmail.com> <20220613111146.25221-3-peterwu.pub@gmail.com>
 <dd9b9be2-7bdf-6cb6-b8ad-d7c0a0d5b98a@linaro.org>
In-Reply-To: <dd9b9be2-7bdf-6cb6-b8ad-d7c0a0d5b98a@linaro.org>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Fri, 17 Jun 2022 18:19:42 +0800
Message-ID: <CABtFH5+5Y5Tq3vO6Sg3kf98CWm9Aijv7qkdBcpm2SB0JZ1gCiA@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] dt-bindings: power: supply: Add Mediatek MT6370 Charger
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiaEn Wu <chiaen_wu@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

Thanks for your helpful comments! I have so some questions want to ask
you below.

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B46=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=BA=94 =E6=B8=85=E6=99=A85:05=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 13/06/2022 04:11, ChiaEn Wu wrote:
> > From: ChiaEn Wu <chiaen_wu@richtek.com>
> >
> > Add Mediatek MT6370 Charger binding documentation.
> >
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > ---
> >  .../power/supply/mediatek,mt6370-charger.yaml | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/medi=
atek,mt6370-charger.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/mediatek,mt=
6370-charger.yaml b/Documentation/devicetree/bindings/power/supply/mediatek=
,mt6370-charger.yaml
> > new file mode 100644
> > index 000000000000..b63553ebb15b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-ch=
arger.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/supply/mediatek,mt6370-charge=
r.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mediatek MT6370 Battery Charger
> > +
> > +maintainers:
> > +  - ChiaEn Wu <chiaen_wu@richtek.com>
> > +
> > +description: |
> > +  This module is part of the MT6370 MFD device.
> > +  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6370-charger
> > +
> > +  interrupts:
> > +    description: |
> > +      Specify what irqs are needed to be handled by MT6370 Charger dri=
ver. IRQ
> > +      "MT6370_IRQ_CHG_MIVR", "MT6370_IRQ_ATTACH" and "MT6370_IRQ_OVPCT=
RL_UVP_D"
> > +      are required.
> > +    items:
> > +      - description: BC1.2 done irq
> > +      - description: usb plug in irq
> > +      - description: mivr irq
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: attach_i
> > +      - const: uvp_d_evt
> > +      - const: mivr
> > +
> > +  io-channels:
> > +    description: |
> > +      Use ADC channel to read vbus, ibus, ibat, etc., info. Ibus ADC c=
hannel
> > +      is required.
>
> Add io-channel-names and describe each item - what type of ADC it is
> expected to be.
>

I'm afraid I might not be understanding what you mean.
I will try to add some text in "description" and "io-channel-names", like b=
elow
----------------------------------
io-channels:
  description: |
    Use ADC channel to read VBUS, IBUS, IBAT, etc., info. Ibus ADC channel
    is required. It can be seen in
include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
  minItems: 1
  maxItems: 9

io-channel-names:
  items:
    - const: vbusdiv5
    - const: vbusdiv2
    - ...
----------------------------------
Did these modifications meet your expectations?

> > +    minItems: 1
> > +    maxItems: 9
> > +
> > +  usb-otg-vbus-regulator:
> > +    type: object
> > +    description: OTG boost regulator.
> > +    $ref: /schemas/regulator/regulator.yaml#
>
> unevaluatedProperties: false

I will add this in the next patch.

>
> > +
> > +    properties:
> > +      enable-gpio:
>
> "gpios", so:
> enable-gpios

If this otg regulator only uses one GPIO Pin, do I still need to
change to "gpios"?
If so, I will refine it along with the regulator "enable-gpio" in MFD
dt-binding.

>
> > +        maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - interrupt-names
> > +  - io-channels
> > +
> > +additionalProperties: false
> > +
> > +...
>
>
> Best regards,
> Krzysztof

Best regards,
ChiaEn Wu
