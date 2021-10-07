Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A318B425737
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 17:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhJGP6G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 11:58:06 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42866 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhJGP6F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 11:58:05 -0400
Received: by mail-ot1-f42.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso7999073otu.9;
        Thu, 07 Oct 2021 08:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OXMrp5FyIuGqUJUx0BNhDntXX+kbhXmR7QX+EAQfvs=;
        b=iMp80WTm8tjGKXRtNwel0pHAV1FzR80oNeX8qWp41WYxaRd0YHC+MW5FIwRslr+zjM
         PwWQwST4E8dpD0yF5p3NQFaqtDviAEXKhRFHIZa5E+MeaKfsE8LMp2eEu3yCb2igXTkm
         IJ8P5liQrxhs1iEDN92Gb8ICGiLl0sxXasVzWNYM2LfXP0fTPH9KWDTQV8rl+nYqyUJH
         E9N3pwxe6DQyl4z1mbbhyxJsFEf6ZWi/g91pyQLW4HhO0kXJ/FCR1jUdMHJm3aesg6Ng
         fd1reKrVDeHq8Z02igkGVxijLpHwM0JqapqV5kc5W7iXS7mGGU50LmKuamg1Bj/M7M6P
         o9mQ==
X-Gm-Message-State: AOAM533wFxxnYV9Q5VnkrNvMepT0ihU4OBwoKo858wPelncn5KLidroh
        dhJcCubY4tUn9P06f7iQp/Cqrn5XYgvRv2HVspJTAH71eKE=
X-Google-Smtp-Source: ABdhPJzrk/NSEGD6vKwLAZi+PM1OCgh+TcfbBV2PcCsvcfkxO1KfQFfKQS5rA30W3LhPgSl0w2upTBNn8t0uuz25lbM=
X-Received: by 2002:a9d:3783:: with SMTP id x3mr4323292otb.16.1633622171438;
 Thu, 07 Oct 2021 08:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210906190454.114751-1-abailon@baylibre.com> <20210906190454.114751-2-abailon@baylibre.com>
In-Reply-To: <20210906190454.114751-2-abailon@baylibre.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Oct 2021 17:56:00 +0200
Message-ID: <CAJZ5v0j3c+YdpmBLQq6t3=7pTEy8AC_a0sMbZGSb=rZ7nJZXeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add bindings for the virtual thermal sensor
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Kevin Hilman <khilman@baylibre.com>,
        gpain@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 6, 2021 at 9:05 PM Alexandre Bailon <abailon@baylibre.com> wrote:
>
> This adds the device tree bidings for the virtual thermal sensor.

I'm not sure what "the virtual thermal sensor" is.

I'm guessing that you mean "DT bindings for the DT-based virtual
sensor driver introduced by a subsequent patch" or something like
this.

I also guess that the purpose is to allow the platform designer to
tell the kernel that some sensors need to be aggregated in order to
get useful information from them and how to aggregate them.  Otherwise
it would be hard to say why the aggregation needed to take place in
the kernel.

Moreover, the aggregation functions supported by this series are
somewhat simple and I'm not sure if they are really sufficient in
practice.

> The virtual sensor could be used to a temperature computed from
> many thermal sensors.
>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

Admittedly, I'm not a DT bindings expert, so if I say something
blatantly silly below, sorry about that.

> ---
>  .../thermal/virtual,thermal-sensor.yaml       | 67 +++++++++++++++++++
>  include/dt-bindings/thermal/virtual-sensor.h  | 15 +++++
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
>  create mode 100644 include/dt-bindings/thermal/virtual-sensor.h
>
> diff --git a/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
> new file mode 100644
> index 0000000000000..848b5912c79f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2021 BayLibre
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/thermal-sensor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Virtual thermal sensor binding
> +
> +description: |
> +  The virtual thermal sensor devices provide temperature sensing capabilities
> +  based on hardware thermal sensors. Basically, this could be used to get the
> +  maximum, minimum or average temperature of the hardware thermal sensors.
> +properties:
> +  "#thermal-sensor-cells":

It isn't clear to me why this is needed.  If the "thermal-sensors"
property is required anyway, I'm not sure why it's still necessary to
have another one to find out whether there is just one sensor or more
of them.

> +    description:
> +      Used to uniquely identify a thermal sensor instance within an IC. Will be
> +      0 on sensor nodes with only a single sensor and at least 1 on nodes
> +      containing several internal sensors.
> +    enum: [0, 1]
> +
> +  type:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Used to select the operations to perform on the sensors to get the virtual
> +      sensor temperature.
> +    enum:
> +      - VIRTUAL_SENSOR_MIN
> +      - VIRTUAL_SENSOR_MAX
> +      - VIRTUAL_SENSOR_AVG
> +
> +  thermal-sensors:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      The thermal sensor phandle and sensor specifier used to monitor this
> +      thermal zone.
> +
> +required:
> +  - "#thermal-sensor-cells"
> +  - type
> +  - thermal-sensors
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    #include <dt-bindings/thermal/thermal.h>
> +    #include <dt-bindings/thermal/virtual-sensor.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8192-clk.h>
> +
> +    lvts: lvts@1100b000 {
> +        compatible = "mediatek,mt6873-lvts";
> +        reg = <0x1100b000 0x1000>;
> +        clocks = <&infracfg CLK_INFRA_THERM>;
> +        clock-names = "lvts_clk";
> +        #thermal-sensor-cells = <0>;
> +        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> +    soc_max_sensor: soc_max_sensor {
> +      compatible = "virtual,thermal-sensor";

Where/how is the above defined?

> +      #thermal-sensor-cells = <1>;
> +      type = <VIRTUAL_SENSOR_MAX>;
> +      thermal-sensors = <&lvts 0>, <&lvts 1>;
> +    };
> +...
> diff --git a/include/dt-bindings/thermal/virtual-sensor.h b/include/dt-bindings/thermal/virtual-sensor.h
> new file mode 100644
> index 0000000000000..b3e4032f6f62b
> --- /dev/null
> +++ b/include/dt-bindings/thermal/virtual-sensor.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * This header provides constants for virtual thermal sensor bindings.
> + *
> + * Copyright (C) 2021 BayLibre
> + */
> +
> +#ifndef _DT_BINDINGS_THERMAL_VIRTUAL_SENSOR_H
> +#define _DT_BINDINGS_THERMAL_VIRTUAL_SENSOR_H
> +

It would be better to use an enum type here.

> +#define VIRTUAL_SENSOR_MIN 0
> +#define VIRTUAL_SENSOR_MAX 1
> +#define VIRTUAL_SENSOR_AVG 2

Also note that the _MIN and _MAX symbols may be confused as limits, so
it may be better to call them _MIN_VAL and _MAX_VAL, respectively.

> +
> +#endif /* _DT_BINDINGS_THERMAL_VIRTUAL_SENSOR_H */
> --
