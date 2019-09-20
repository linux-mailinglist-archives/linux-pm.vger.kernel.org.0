Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE189B9921
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 23:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392783AbfITVnK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 17:43:10 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45459 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392617AbfITVnJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2019 17:43:09 -0400
Received: by mail-vs1-f66.google.com with SMTP id d204so5647387vsc.12
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsLE449MYN0lijunGmoaJH+J0lh52Nq00qDntzefXoo=;
        b=Y41UWNhXfoaLvFvHT2mK5PnQUDu2rsLdZVpGTzNyuAkQMu8tbTrR/zLCcF2rY4aTZ6
         lfszb21KlSm+f2/ZQ2WXSn4tmBCbqbPo5kf1qEnnT9gmxwoD6WodV6ekHlj96UWiacrp
         QpugkSZICRkCQLCUiQ8BP6ekjlj0AwYL0agn5KeiOA9Sf0/VH0SEHoZb/21l1Eqt5pub
         cJ43PMl4W4FFT+vJAJoO17u9IuNKgx6aK1PZW8jBhWEtXMnzyW2Q68TfpS4BW2BmGFrz
         BJWz3H0Z7zaAtUvsUf7dwPr3Qvjyxlvt+OYmKzb7Qb1aCzpyDMrW66M2LKk4wZAOWMQ4
         3Aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsLE449MYN0lijunGmoaJH+J0lh52Nq00qDntzefXoo=;
        b=APz0PC+KcnBGS6okiBRVTb1AaHV+KQRvA04ziQjLGq2zHPzfsmG0r/AEL8oLzON2Nz
         P3xj5FcnQI7LFgIBXQDyvk4mPbBpTCbbyfNpk2VSM41bH0VzkePF1hlKpyU4cFlkGYQa
         CN7CcFF/yjQ9youcZe7QgkvtBQS+pgJxCvVWPi5v0qEqcB6WnKB4lKvg1xBsv8dx5Oma
         aBCAxr6tt5WpylcCaNkJ6fc52aOEkrKtVZQJ/ujb3lUTtgYxOG99xg/SYuyGsJG0UBAT
         ONUjP8UG0RZ15IHLVEITO47H+FCDau9Tr3WS+agWl/FHijsUnKQMa9tdfsQKClnNjm8+
         +Dng==
X-Gm-Message-State: APjAAAVHAZTrh79Wv2Yp9rP02sJ9D9mMuNIDxp6VZ4lCIiV/GXx5N2sl
        QSdo8BmM2w3yTbDQWqekXDgWFdadz3YqdwPUnt92yQ==
X-Google-Smtp-Source: APXvYqxqwvjtfbTFvURwOAkGiT1FsWywrL0zaIpbPwm+wwJzPOW+clQhLp9/KxIWk3c8VeHdjYcFDVe6vOxn0tYw7GQ=
X-Received: by 2002:a67:6044:: with SMTP id u65mr3810616vsb.95.1569015788245;
 Fri, 20 Sep 2019 14:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568185732.git.amit.kucheria@linaro.org>
 <933f033298cbd7726a6c0b4b3b6cc7adc81784ba.1568185732.git.amit.kucheria@linaro.org>
 <20190917190619.GA9311@bogus>
In-Reply-To: <20190917190619.GA9311@bogus>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 20 Sep 2019 14:42:57 -0700
Message-ID: <CAHLCerMc=+Xyf-KkJ4gn0Cfs8yuTTLetKEuSiKCwK4kAWo7ocw@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] dt-bindings: thermal: tsens: Convert over to a
 yaml schema
To:     Rob Herring <robh@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 17, 2019 at 12:06 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 11, 2019 at 12:46:24PM +0530, Amit Kucheria wrote:
> > Document interrupt support in the tsens driver by converting over to a
> > YAML schema.
> >
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  .../bindings/thermal/qcom-tsens.txt           |  55 ------
> >  .../bindings/thermal/qcom-tsens.yaml          | 174 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  3 files changed, 175 insertions(+), 55 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> >  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>
>
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > new file mode 100644
> > index 000000000000..6784766fe58f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > @@ -0,0 +1,174 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +# Copyright 2019 Linaro Ltd.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: QCOM SoC Temperature Sensor (TSENS)
> > +
> > +maintainers:
> > +  - Amit Kucheria <amit.kucheria@linaro.org>
> > +
> > +description: |
> > +  QCOM SoCs have TSENS IP to allow temperature measurement. There are currently
> > +  three distinct major versions of the IP that is supported by a single driver.
> > +  The IP versions are named v0.1, v1 and v2 in the driver, where v0.1 captures
> > +  everything before v1 when there was no versioning information.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: v0.1 of TSENS
> > +        items:
> > +          - enum:
> > +              - qcom,msm8916-tsens
> > +              - qcom,msm8974-tsens
> > +          - const: qcom,tsens-v0_1
> > +
> > +      - description: v1 of TSENS
> > +        items:
> > +          - enum:
> > +              - qcom,qcs404-tsens
> > +          - const: qcom,tsens-v1
> > +
> > +      - description: v2 of TSENS
> > +        items:
> > +          - enum:
> > +              - qcom,msm8996-tsens
> > +              - qcom,msm8998-tsens
> > +              - qcom,sdm845-tsens
> > +          - const: qcom,tsens-v2
> > +
> > +  reg:
> > +    maxItems: 2
> > +    items:
> > +      - description: TM registers
> > +      - description: SROT registers
> > +
> > +  nvmem-cells:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description:
> > +      Reference to an nvmem node for the calibration data
> > +
> > +  nvmem-cells-names:
>
> This is going to require 2 items, so you need an explicit minItems and
> maxItems.

Will fix.

> > +    items:
> > +      - enum:
> > +        - caldata
> > +        - calsel
> > +
> > +  "#qcom,sensors":
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - minimum: 1
> > +      - maximum: 16
> > +    description:
> > +      Number of sensors enabled on this platform
> > +
> > +  "#thermal-sensor-cells":
> > +    const: 1
> > +    description:
> > +      Number of cells required to uniquely identify the thermal sensors. Since
> > +      we have multiple sensors this is set to 1
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,msm8916-tsens
> > +              - qcom,msm8974-tsens
> > +              - qcom,qcs404-tsens
> > +              - qcom,tsens-v0_1
> > +              - qcom,tsens-v1
> > +    then:
> > +      properties:
> > +        interrupts:
>
> > +          minItems: 1
> > +          maxItems: 1
>
> These can be implicit.

Will remove all of these.

> > +          items:
> > +            - description: Combined interrupt if upper or lower threshold crossed
> > +        interrupt-names:
> > +          minItems: 1
> > +          maxItems: 1
>
> ditto.
>
> > +          items:
> > +            - const: uplow
> > +
> > +    else:
> > +      properties:
> > +        interrupts:
> > +          minItems: 2
> > +          maxItems: 2
>
> ditto.
>
> > +          items:
> > +            - description: Combined interrupt if upper or lower threshold crossed
> > +            - description: Interrupt if critical threshold crossed
> > +        interrupt-names:
> > +          minItems: 2
> > +          maxItems: 2
>
> ditto.
>
> > +          items:
> > +            - const: uplow
> > +            - const: critical
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#qcom,sensors"
> > +  - interrupts
> > +  - interrupt-names
> > +  - "#thermal-sensor-cells"
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    // Example 1 (legacy: for pre v1 IP):
> > +    tsens1: thermal-sensor@900000 {
> > +           compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
> > +           reg = <0x4a9000 0x1000>, /* TM */
> > +                 <0x4a8000 0x1000>; /* SROT */
> > +
> > +           nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
> > +           nvmem-cell-names = "caldata", "calsel";
> > +
> > +           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> > +           interrupt-names = "uplow";
> > +
> > +           #qcom,sensors = <5>;
> > +           #thermal-sensor-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    // Example 2 (for any platform containing v1 of the TSENS IP):
> > +    tsens2: thermal-sensor@4a9000 {
> > +          compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
> > +          reg = <0x004a9000 0x1000>, /* TM */
> > +                <0x004a8000 0x1000>; /* SROT */
> > +
> > +          nvmem-cells = <&tsens_caldata>;
> > +          nvmem-cell-names = "calib";
> > +
> > +          interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
> > +          interrupt-names = "uplow";
> > +
> > +          #qcom,sensors = <10>;
> > +          #thermal-sensor-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    // Example 3 (for any platform containing v2 of the TSENS IP):
> > +    tsens3: thermal-sensor@c263000 {
> > +           compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> > +           reg = <0xc263000 0x1ff>,
> > +                 <0xc222000 0x1ff>;
> > +
> > +           interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> > +                        <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> > +           interrupt-names = "uplow", "critical";
> > +
> > +           #qcom,sensors = <13>;
> > +           #thermal-sensor-cells = <1>;
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e7a47b5210fd..ff757a4a060c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13360,6 +13360,7 @@ L:    linux-pm@vger.kernel.org
> >  L:   linux-arm-msm@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/thermal/qcom/
> > +F:   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> >
> >  QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
> >  M:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
> > --
> > 2.17.1
> >
