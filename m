Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02731A3620
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgDIOmE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 10:42:04 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37383 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgDIOmD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2020 10:42:03 -0400
Received: by mail-vs1-f66.google.com with SMTP id o3so7039067vsd.4
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2020 07:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4mXwOzfoQFfmTyPdF7FI/nvZYzgTEkhsp/jnf7l374=;
        b=BmZ6GULsIOlPMSeR4QFP6UMU8xiIGx++xbVXvG4Ec14xhXm9xO54PsRz2mxTHRE/zS
         hpnnjFBGw3DoPCT4XJ7XPcvn+ZgD5Dgv4qo5ptYViWYP2VA8mdbkSTJBY4YTL2N3HfKg
         NvMMJbwI124CbsUc49NgD5VNIjOLwitQnU4+iWusAWlVIN9V1lY+wZb1fxfzhVJg7Svf
         tLTlb0SMJOEU8ESAlUSC4HYXZv0ZCbmYiIxUY8zyGJ4F3r8I0gnyw7/uXQt0DyZIpP3Q
         oiGGkLLnrmCU41aWoN54rM9dBwhyKbJ7TaN+gyUI1YiyHTQd891cnjftlUVYLlc6ZDy5
         DTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4mXwOzfoQFfmTyPdF7FI/nvZYzgTEkhsp/jnf7l374=;
        b=dryeFjX8cTavA03lT3tG9ed4zRkvLcnENJ6W7yrUAGR9KPAnc5oU/YV4l5o2hYQiYp
         TlH9Xwmz97ZBVtea3u3z5t4hUfYtMnOH993jbIEwlLI7aYN9MdeUcRtU9oUvKChdGEHT
         vrxZOjz4rOgqkQKHPDRNcOUiRQ0a/CXbUuIMlt2gq5VS6gG4xwGJgfPYoLaEYriGtywn
         8JZ0bjmrnvAUuipo8C06uqZx5lXsUUE/1hSl4LffyEQOgXf1KK/rnq6HzRAE3zCzw076
         ENP5ZTV6P8RyCsfTntZ4P0UgTsrq9fZFHDQdHBZnreGKbS1+qUf4Shz8z1sJg34JQzhi
         2BTg==
X-Gm-Message-State: AGi0Pub1ptCa2uCzLVHtzS/02xRdmlunkCn11749AgXX+KTfmpctDFJI
        2H5QkDm/M3ll5Z5wo3Hzk/eL0w75WGHMh8uI4tNVSQ==
X-Google-Smtp-Source: APiQypIMwqo54G8PDp6x6bzZoYY0l/NI3qEPSUYHGLPzdzXdkZbfrZHq59Uacbj6+5+FPXnMW5l6fHqSuoOtciP+E30=
X-Received: by 2002:a67:4242:: with SMTP id p63mr243113vsa.159.1586443321181;
 Thu, 09 Apr 2020 07:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <1586407908-27139-1-git-send-email-Anson.Huang@nxp.com>
 <CAHLCerPi36z4z4DLmP9czEp8aw8yQq7EHAtHdCFLO2ZVYBZsRA@mail.gmail.com> <DB3PR0402MB3916F4F4BD5B0DC083E76183F5C10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916F4F4BD5B0DC083E76183F5C10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 9 Apr 2020 20:11:50 +0530
Message-ID: <CAHLCerOrto=3xXpU1Aimf0Zh197K-tQHuOou-VXg+W+Nf_eTWQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: Convert i.MX to json-schema
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 9, 2020 at 8:04 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Amit
>
> > Subject: Re: [PATCH] dt-bindings: thermal: Convert i.MX to json-schema
> >
> > Hi Anson,
> >
> > On Thu, Apr 9, 2020 at 10:29 AM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > >
> > > Convert the i.MX thermal binding to DT schema format using json-schema
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  .../devicetree/bindings/thermal/imx-thermal.txt    | 61 --------------
> > >  .../devicetree/bindings/thermal/imx-thermal.yaml   | 97
> > ++++++++++++++++++++++
> > >  2 files changed, 97 insertions(+), 61 deletions(-)  delete mode
> > > 100644 Documentation/devicetree/bindings/thermal/imx-thermal.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> > > b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> > > deleted file mode 100644
> > > index 823e417..0000000
> > > --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> > > +++ /dev/null
> > > @@ -1,61 +0,0 @@
> > > -* Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
> > > -
> > > -Required properties:
> > > -- compatible : must be one of following:
> > > -  - "fsl,imx6q-tempmon" for i.MX6Q,
> > > -  - "fsl,imx6sx-tempmon" for i.MX6SX,
> > > -  - "fsl,imx7d-tempmon" for i.MX7S/D.
> > > -- interrupts : the interrupt output of the controller:
> > > -  i.MX6Q has one IRQ which will be triggered when temperature is
> > > higher than high threshold,
> > > -  i.MX6SX and i.MX7S/D have two more IRQs than i.MX6Q, one is IRQ_LOW
> > > and the other is IRQ_PANIC,
> > > -  when temperature is below than low threshold, IRQ_LOW will be
> > > triggered, when temperature
> > > -  is higher than panic threshold, system will auto reboot by SRC module.
> > > -- fsl,tempmon : phandle pointer to system controller that contains
> > > TEMPMON
> > > -  control registers, e.g. ANATOP on imx6q.
> > > -- nvmem-cells: A phandle to the calibration cells provided by ocotp.
> > > -- nvmem-cell-names: Should be "calib", "temp_grade".
> > > -
> > > -Deprecated properties:
> > > -- fsl,tempmon-data : phandle pointer to fuse controller that contains
> > > TEMPMON
> > > -  calibration data, e.g. OCOTP on imx6q.  The details about
> > > calibration data
> > > -  can be found in SoC Reference Manual.
> > > -
> > > -Direct access to OCOTP via fsl,tempmon-data is incorrect on some
> > > newer chips -because it does not handle OCOTP clock requirements.
> > > -
> > > -Optional properties:
> > > -- clocks : thermal sensor's clock source.
> > > -
> > > -Example:
> > > -ocotp: ocotp@21bc000 {
> > > -       #address-cells = <1>;
> > > -       #size-cells = <1>;
> > > -       compatible = "fsl,imx6sx-ocotp", "syscon";
> > > -       reg = <0x021bc000 0x4000>;
> > > -       clocks = <&clks IMX6SX_CLK_OCOTP>;
> > > -
> > > -       tempmon_calib: calib@38 {
> > > -               reg = <0x38 4>;
> > > -       };
> > > -
> > > -       tempmon_temp_grade: temp-grade@20 {
> > > -               reg = <0x20 4>;
> > > -       };
> > > -};
> > > -
> > > -tempmon: tempmon {
> > > -       compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
> > > -       interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> > > -       fsl,tempmon = <&anatop>;
> > > -       nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
> > > -       nvmem-cell-names = "calib", "temp_grade";
> > > -       clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
> > > -};
> > > -
> > > -Legacy method (Deprecated):
> > > -tempmon {
> > > -       compatible = "fsl,imx6q-tempmon";
> > > -       fsl,tempmon = <&anatop>;
> > > -       fsl,tempmon-data = <&ocotp>;
> > > -       clocks = <&clks 172>;
> > > -};
> > > diff --git
> > > a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> > > b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> > > new file mode 100644
> > > index 0000000..ad12622
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> > > @@ -0,0 +1,97 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id:
> > > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
> > >
> > +cetree.org%2Fschemas%2Fthermal%2Fimx-thermal.yaml%23&amp;data=02%
> > 7C01
> > >
> > +%7Canson.huang%40nxp.com%7C408494436dca450abb5d08d7dc8cc727%7
> > C686ea1d
> > >
> > +3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637220369539115517&amp;s
> > data=e3R5
> > > +q1YhIRLSOVdLYJWVlbOdqdjxYHNJMcXz%2Bxb1kjc%3D&amp;reserved=0
> > > +$schema:
> > > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
> > >
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=02%7C01%7Cans
> > on.hua
> > >
> > +ng%40nxp.com%7C408494436dca450abb5d08d7dc8cc727%7C686ea1d3bc
> > 2b4c6fa92
> > >
> > +cd99c5c301635%7C0%7C1%7C637220369539125508&amp;sdata=VjZ%2FPJ
> > BVQc9jpc
> > > +H3Hvvc2fYy70B%2Fmun0mxdvSHHktEU%3D&amp;reserved=0
> > > +
> > > +title: NXP i.MX Thermal Binding
> > > +
> > > +maintainers:
> > > +  - Anson Huang <Anson.Huang@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,imx6q-tempmon
> > > +              - fsl,imx6sx-tempmon
> > > +              - fsl,imx7d-tempmon
> > > +
> >
> > > +  interrupts:
> > > +    description: |
> > > +      The interrupt output of the controller, the IRQ will be triggered
> > > +      when temperature is higher than high threshold.
> > > +    maxItems: 1
> > > +
> >
> > imx6sx and imx7d have 3 interrupts each. So you need an if clause to change
> > the interrupt number based on what compatible is provided. See
> > qcom-tsens.yaml for an example.
>
> I noticed this, yes, i.MX6SX/7D has 3 interrupts, but the driver actually ONLY uses
> the high irq, low and panic irq are NOT used. So for such scenario, binding doc should
> still mention all of them?

No, just describe what the driver implements. If the driver doesn't
implement that other two interrupts, leave it out.

I was only comparing it to the old binding where those 3 interrupts
are mentioned.

Regards,
Amit

> >
> > > +  nvmem-cells:
> > > +    description: |
> > > +      Phandle to the calibration cells provided by ocotp for calibration
> > > +      data and temperature grade.
> > > +    maxItems: 2
> > > +
> > > +  nvmem-cell-names:
> > > +    maxItems: 2
> > > +    items:
> > > +      - const: calib
> > > +      - const: temp_grade
> > > +
> > > +  fsl,tempmon:
> > > +    description: |
> > > +      Phandle pointer to system controller that contains TEMPMON
> > control
> > > +      registers, e.g. ANATOP on imx6q.
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> >
> > Nit: move $ref line above description. IMO it makes the binding easier to read.
>
> OK.
>
> >
> > > +
> > > +  fsl,tempmon-data:
> > > +    description: |
> > > +      Deprecated property, phandle pointer to fuse controller that
> > contains
> > > +      TEMPMON calibration data, e.g. OCOTP on imx6q. The details about
> > > +      calibration data can be found in SoC Reference Manual.
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> >
> > Nit: move $ref line above description. IMO it makes the binding easier to read.
>
> OK.
>
> >
> > > +
> > > +  clocks:
> > > +    description: |
> > > +      Thermal sensor's clock source.
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - interrupts
> > > +  - fsl,tempmon
> > > +  - clocks
> >
> > Clocks was an optional property before, are you sure?
>
> I misunderstand the 'optional', the clock is always necessary, ONLY for those SoCs have
> no thermal clock available, then it is unnecessary. Now I see, I will make it as optional.
>
> I will add example for #thermal-sensor-cells property you mentioned in the other mail.
>
> Thanks,
> Anson
>
> >
> > > +  - nvmem-cells
> > > +  - nvmem-cell-names
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/imx6sx-clock.h>
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +    ocotp: ocotp@21bc000 {
> > > +         #address-cells = <1>;
> > > +         #size-cells = <1>;
> > > +         compatible = "fsl,imx6sx-ocotp", "syscon";
> > > +         reg = <0x021bc000 0x4000>;
> > > +         clocks = <&clks IMX6SX_CLK_OCOTP>;
> > > +
> > > +         tempmon_calib: calib@38 {
> > > +             reg = <0x38 4>;
> > > +         };
> > > +
> > > +         tempmon_temp_grade: temp-grade@20 {
> > > +             reg = <0x20 4>;
> > > +         };
> > > +    };
> > > +
> > > +    tempmon: tempmon {
> > > +         compatible = "fsl,imx6sx-tempmon";
> > > +         interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> > > +         fsl,tempmon = <&anatop>;
> > > +         nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
> > > +         nvmem-cell-names = "calib", "temp_grade";
> > > +         clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
> > > +    };
> > > +
> > > +...
> > > --
> > > 2.7.4
> > >
