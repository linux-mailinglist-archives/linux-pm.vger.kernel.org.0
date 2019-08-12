Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595C48AB50
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 01:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHLXk5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 19:40:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34305 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHLXk5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 19:40:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so165771312otk.1;
        Mon, 12 Aug 2019 16:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pPEYAuAye+0GqC7OnP9046qaqHZYqZpPqW1iRwks6UA=;
        b=Az/KAHeXWMTK6hZoEHd2o4MQYecAB/NgvnMRDnUZzVhXDkbMTvsthJSrrVcLyIVGuQ
         LVzU0ExEzwQNwWcILcnqpux7LRq7Pd1qSkB6eC+g6fwszr9wFB4ErXIhaGXDPYoCO0rv
         pMTcAXFbhCOg1XGFgjerQ+dc+mqA0hzjGc7BXUkfO6eMyx/1piKi9i9vK/U/kw6GE4gD
         773IvbSspzM4MSxA3WRpuHbv+AfIXIq4oeBOCH7MdYMlswP0aaiDugAkwcyxCvWhnBRv
         n0HaEonKGwLDsQznMyf3w0/GPE5m7PEZs6cCaPGYJy8lmgi5gsjsZxHu8AgF0+1x6gfL
         fVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pPEYAuAye+0GqC7OnP9046qaqHZYqZpPqW1iRwks6UA=;
        b=EzxdQT+CmPrQk3ASznEEDJ8x+DFR7I9tRFv3Ty+R3wzwIbpUZSjXtrsbB5PlN9rpAN
         6mCmw0CODWoMIqci/nbLSeEZtluZs2WTdg2mQ4vqC9iIfWd//HVl1UOG/vRpL0SlwRJP
         2Gn27FoKHISD5yvQCNIXQ4dwqsKExZfsJ9c7iZUYs0bqJggQ9z9a5natFYtKsDoyYzr9
         7dnjNym8Dh6D1I0aC53M/G4ELmNLSZtg8MAQ9cOq+s6IdaIPJZkpSwtbwmzKo1UKLTbI
         OSGeSxQWUILAzYHoWLR7r7TmtO0q+7qUPxLf9bMy6bSNQ/hFALnCPblPGFSsMviqfRcR
         +GwQ==
X-Gm-Message-State: APjAAAVYVEA2WqvQtRgwZZDXRpwdVnWHvv+0f+hsS/vtUlvW1Li/FxUc
        70I0kVwhvz1RiAIXuihgUepBl+qq9Q9moeWUA0k=
X-Google-Smtp-Source: APXvYqwdCwEVUV+9iATbwHthiTuqT8FRW51Zis4SYydD2va0Jx7WyHS0BxXBm3kCBot3qcQDULuG0pks3KT0NGUUszE=
X-Received: by 2002:a6b:fd13:: with SMTP id c19mr12236684ioi.168.1565653256193;
 Mon, 12 Aug 2019 16:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190810052829.6032-1-tiny.windzz@gmail.com> <20190810052829.6032-3-tiny.windzz@gmail.com>
 <20190812085604.ozhl35wwm3ehlvqn@flea>
In-Reply-To: <20190812085604.ozhl35wwm3ehlvqn@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 13 Aug 2019 07:40:44 +0800
Message-ID: <CAEExFWswLiFknVpBEKF9c5yoFvvA4np-ivWYkQLcteYoM8qjfg@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] dt-bindings: thermal: add binding document for
 h6 thermal controller
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 12, 2019 at 4:56 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sat, Aug 10, 2019 at 05:28:13AM +0000, Yangtao Li wrote:
> > This patch adds binding document for allwinner h6 thermal controller.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  .../bindings/thermal/sun8i-thermal.yaml       | 79 +++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> > new file mode 100644
> > index 000000000000..e0973199ba3c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
>
> We've used so far for the schemas the first compatible to introduce
> that controller as the filename, we should be consistent here. In that
> case that would be allwinner,sun8i-a23-ths.yaml
>
> > @@ -0,0 +1,79 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/sun8i-thermal.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner SUN8I Thermal Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Yangtao Li <tiny.windzz@gmail.com>
> > +
> > +description: |-
> > +  This describes the device tree binding for the Allwinner thermal
> > +  controller which measures the on-SoC temperatures.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - allwinner,sun50i-h6-ths
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: bus
> > +
> > +  "#thermal-sensor-cells":
> > +    const: 1
> > +
> > +  nvmem-cells:
>
> You need a maxItems here too
>
> > +    description: ths calibrate data
>
> What about something like this:
>
> Calibration data for the thermal sensor
>
> > +
> > +  nvmem-cell-names:
> > +    const: calib
>
> I'm not sure we need a abbreviation here, calibration would be more
> explicit
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reset
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - "#thermal-sensor-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ths: ths@5070400 {
> > +        compatible = "allwinner,sun50i-h6-ths";
> > +        reg = <0x05070400 0x100>;
> > +        clocks = <&ccu CLK_BUS_THS>;
> > +        clock-names = "bus";
> > +        resets = <&ccu RST_BUS_THS>;
> > +        interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>
> Those examples won't compile.

Emmm, I have some questions about this.
I added this information and it can be compiled.

Yours,
Yangtao

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
