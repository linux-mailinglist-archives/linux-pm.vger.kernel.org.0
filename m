Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6432410CCC2
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 17:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfK1QYm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 11:24:42 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45559 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1QYm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 11:24:42 -0500
Received: by mail-oi1-f196.google.com with SMTP id 14so23688309oir.12;
        Thu, 28 Nov 2019 08:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3VqpjrZB5dVKBqJG+mBiDtnZ2Bu7fCXo2j8f/VRZBE=;
        b=pCfa8I1bGBJviToPnlI7I96+AvxXirWhqa1wUa20TPpvOfSet/Jbt0Lpoo+Nzqt4fE
         LSz+mJ7sp9C3DNk2hs5CjRxI4FKiTSXqK3sBqj7cIALppBwCdLCmePe6GKkIy3QTYzEW
         j8/WF9jIePBnNm9A5VK2yPfms5BHVw8K6ktYULdc3yBai4cXaxERnoUIQW/67pRftz+6
         Ks9X6RGtaA/GLOUc8FFploAP1oPdB5RucTmtRXbp074EwSC2k5fpNywfVlN79xQDPutd
         M0OjD4rctuwzHm+XTBODgvxhP7SoqKSRaXIY+5ShWrs96D+zE/kQ3fA+xPEeP76rZRV2
         FQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3VqpjrZB5dVKBqJG+mBiDtnZ2Bu7fCXo2j8f/VRZBE=;
        b=HaAMER7raYDjdqijVx3kSO06nXug+h85psJwilpguj2R2g0BmlhegGZ/TAQlKL2gsL
         rkx5f4W8UBrcr5IHzky7AiNrHhvuQnBwl3xFHUGr1hUzcy+n2KgmI+CvvOuZ0KmjE/n8
         QC+8bELHb5GEwGDAli+szzYZSgWG5IXcVmxb7gaGPHNxlyldJyd7Xz7MmznjfPfh2iGO
         XXr+vrRtNA9zE8Oty77q1g+gAq0ttWGeKnR6d2ipPxq+i1ctPoxT34FJ7SJYMHfWgHvG
         n4858OSsojkDbEqzRSkRTXMav6yF1OS0+yNPcvwsIM+HxB8U3ljC9Hz1I11zrZWBKwCw
         wiDw==
X-Gm-Message-State: APjAAAVv84HkpNLuw13pCQQRalTueebCS6j7Hry3aFm/5T5mTRjPl7IE
        yaqBlZdT1i8huIWOSVknGFSS+WMygbgczfiLFXr8GbdN1ro=
X-Google-Smtp-Source: APXvYqzz7ps6eXoUhwDQKMUk7cAIqzYXyKKS19x5F5J/c1WL4oGQ5D0Zg836VRhZZOC0G9Xb+Fho4S0eFMAeGSAZ8J4=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr6637720oih.98.1574958280574;
 Thu, 28 Nov 2019 08:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20191127052935.1719897-1-anarsoul@gmail.com> <20191127052935.1719897-3-anarsoul@gmail.com>
 <20191127174434.wousbqosmm5vxcsu@gilmour.lan> <CA+E=qVe22T1uhUo6iq9a82Y9bC014CZSkAtSJJNX4qsn6dJL9w@mail.gmail.com>
 <20191128074325.q47rpzhufwog6mbb@gilmour.lan> <CAEExFWs7A4TcB-QcatfR3w1hUX88dC-Sxd=epQppwB7p2CC6SA@mail.gmail.com>
 <CAEExFWu4MPxA+Vs1BNzCqeR5EkbVT2SjMf6hRBK6nZ2doJmduA@mail.gmail.com>
In-Reply-To: <CAEExFWu4MPxA+Vs1BNzCqeR5EkbVT2SjMf6hRBK6nZ2doJmduA@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 28 Nov 2019 08:24:14 -0800
Message-ID: <CA+E=qVcp9MqFPoU9DCypAw7kK+obeDnES4QSeq7mSUc+rRLutw@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 28, 2019 at 6:45 AM Frank Lee <tiny.windzz@gmail.com> wrote:

Hey Yangtao,

I've already addressed all the comments and fixed patchset is sitting
in https://github.com/anarsoul/linux-2.6/tree/ths-5.4

I'll rebase and submit new version after merge window is closed (in ~1.5 weeks?)

Regards,
Vasily

> diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> new file mode 100644
> index 000000000000..1be32f09fcc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sun8i-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner SUN8I Thermal Controller Device Tree Bindings
> +
> +maintainers:
> +  - Yangtao Li <tiny.windzz@gmail.com>
> +
> +description: |-
> +  This describes the device tree binding for the Allwinner thermal
> +  controller which measures the on-SoC temperatures.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun8i-a83t-ths
> +      - allwinner,sun8i-h3-ths
> +      - allwinner,sun8i-r40-ths
> +      - allwinner,sun50i-a64-ths
> +      - allwinner,sun50i-h5-ths
> +      - allwinner,sun50i-h6-ths
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: ths bus clock
> +      - description: ths mod clock
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: bus
> +      - const: mod
> +
> +  "#thermal-sensor-cells":
> +    enum: [ 0, 1 ]
> +
> +  nvmem-cells:
> +    description: ths calibrate data
> +
> +  nvmem-cell-names:
> +    const: calibration
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#thermal-sensor-cells"
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - allwinner,sun8i-h3-ths
> +              - allwinner,sun8i-r40-ths
> +              - allwinner,sun50i-a64-ths
> +              - allwinner,sun50i-h5-ths
> +              - allwinner,sun50i-h6-ths
> +
> +    then:
> +      properties:
> +        resets:
> +          minItems: 1
> +          maxItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun50i-h6-ths
> +
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 1
> +
> +        clock-names:
> +          minItems: 1
> +          maxItems: 1
> +
> +    else:
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - allwinner,sun8i-h3-ths
> +                - allwinner,sun8i-r40-ths
> +                - allwinner,sun50i-a64-ths
> +                - allwinner,sun50i-h5-ths
> +
> +      then:
> +        properties:
> +          clocks:
> +            minItems: 2
> +            maxItems: 2
> +
> +          clock-names:
> +            minItems: 2
> +            maxItems: 2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun8i-h3-ths
> +
> +    then:
> +      properties:
> +        "#thermal-sensor-cells":
> +          const: 0
> +
> +    else:
> +      properties:
> +        "#thermal-sensor-cells":
> +          const: 1
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ths: ths@5070400 {
> +        compatible = "allwinner,sun50i-h6-ths";
> +        reg = <0x05070400 0x100>;
> +        clocks = <&ccu 89>;
> +        clock-names = "bus";
> +        resets = <&ccu 36>;
> +        interrupts = <0 15 4>;
> +        nvmem-cells = <&tsen_calib>;
> +        nvmem-cell-names = "calibration";
> +        #thermal-sensor-cells = <1>;
> +    };
> +
> +    sid: sid@3006000 {
> +        compatible = "allwinner,sun50i-h6-sid";
> +        reg = <0x03006000 0x400>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        tsen_calib: calib@14 {
> +                reg = <0x14 6>;
> +        };
> +    };
> +...
>
> On Thu, Nov 28, 2019 at 10:35 PM Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > Hi,
> >
> > How about this?
> >
> > Best regards,
> > Yangtao
