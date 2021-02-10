Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01AC31613D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 09:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBJIj6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 03:39:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhBJIi7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 03:38:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B92664E53;
        Wed, 10 Feb 2021 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612946298;
        bh=ZuwM2mDuJ6k+gw3eFocM3ER40zA3AqWajT5QIt4bIHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HkzWW9Hi/TVxB3hFSnCjRgBa0aqoScJFim3+0QJGipLHLwy72dMKQu+Xv4wI8x+KF
         /XAKXc74q6PORPBV5L1i6H+cHfxcBv9MrPzXQ6246NcdViWwI5byFXFFO1EGshjvdv
         u7KwcW6FLCcIvBXjfi7gdZzDk0YBjWGbulRRPWkvHeB+eMy9DP2BreNgkBcgJY1gsG
         4+/cfZ84mIaOvK7dEpwPc/TNmNR9Uy0FRU0H35mr4+6KICRPpJ8SNH/zI6CYP/LkTa
         3717sJSO2GjBhU+N5lQBThr233tNFxXNPLgXURkeUxO+a38EtGbY6avd2K0SeRDheV
         BcqN+84rG6IpQ==
Received: by mail-ed1-f50.google.com with SMTP id q2so1854684eds.11;
        Wed, 10 Feb 2021 00:38:18 -0800 (PST)
X-Gm-Message-State: AOAM533yvNLwo57xoFviLutIEz52krxayUXAxXzzFIZRgvS4m5VUwvY1
        vAFN0l2ktaMpnkp5x4Z6PM1Qz2TSWSUGr3F/L8I=
X-Google-Smtp-Source: ABdhPJzyp7Nqf2eUGKayKL3NGLdyz5Vm6yYdapcLoP/6d6EtfX9OUepULQfQKFuge4Lytm4yW/xmHWZrad8EtxNGzXo=
X-Received: by 2002:a05:6402:1d82:: with SMTP id dk2mr2073308edb.132.1612946296758;
 Wed, 10 Feb 2021 00:38:16 -0800 (PST)
MIME-Version: 1.0
References: <20210202021747.717-1-r-rivera-matos@ti.com> <20210202021747.717-2-r-rivera-matos@ti.com>
In-Reply-To: <20210202021747.717-2-r-rivera-matos@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Feb 2021 09:38:04 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfNVWpS+90mUmQoE+Hz4AQh3wa0od1NkYBXPJ1jbUQ1XQ@mail.gmail.com>
Message-ID: <CAJKOXPfNVWpS+90mUmQoE+Hz4AQh3wa0od1NkYBXPJ1jbUQ1XQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: power: Add the bq25790 dt bindings
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dmurphy@ti.com, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2 Feb 2021 at 03:20, Ricardo Rivera-Matos <r-rivera-matos@ti.com> w=
rote:
>
> From: Dan Murphy <dmurphy@ti.com>
>
> Add the bindings for the bq25790.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Order of tags is entirely wrong. Did Rob review it before Dan write
it?  Your Sob should be after Dan's (unless you wrote it at first?).\

> ---
>  .../bindings/power/supply/bq25790.yaml        | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2579=
0.yaml
>
> diff --git a/Documentation/devicetree/bindings/power/supply/bq25790.yaml =
b/Documentation/devicetree/bindings/power/supply/bq25790.yaml
> new file mode 100644
> index 000000000000..6d9178ce5a2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq25790.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/bq25790.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI BQ25790 Switch Mode Buck-Boost Charger
> +
> +maintainers:
> +  - Dan Murphy <dmurphy@ti.com>
> +
> +description: |
> +  BQ25790 is a highly integrated switch-mode buck-boost charger for 1-4 =
cell
> +  Li-ion batteries and Li-polymer batteries. The device charges a batter=
y from a
> +  wide range of input sources including legacy USB adapters to high volt=
age USB
> +  PD adapters and traditional barrel adapters.
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,bq25790
> +      - ti,bq25792
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,watchdog-timeout-ms:
> +    default: 0
> +    description: |
> +      Watchdog timer in milli seconds. 0 (default) disables the watchdog=
.
> +    minimum: 0
> +    maximum: 160000

Why do you need minimum/maximum if you enumerate the values?

> +    enum: [ 0, 500, 1000, 2000, 20000, 40000, 80000, 160000]
> +
> +  input-voltage-limit-microvolt:
> +    description: |
> +      Minimum input voltage limit in micro volts with a 100000 micro vol=
t step.
> +    minimum: 3600000
> +    maximum: 22000000
> +
> +  input-current-limit-microamp:
> +    description: |
> +      Maximum input current limit in micro amps with a 100000 micro amp =
step.
> +    minimum: 100000
> +    maximum: 3300000
> +
> +  monitored-battery:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the battery node being monitored
> +
> +  interrupts:
> +    maxItems: 1
> +    description: |
> +      Interrupt sends an active low, 256 =CE=BCs pulse to host to report=
 the charger
> +      device status and faults.
> +
> +required:
> +  - compatible
> +  - reg
> +  - monitored-battery
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    bat: battery {
> +      compatible =3D "simple-battery";
> +      constant-charge-current-max-microamp =3D <2000000>;
> +      constant-charge-voltage-max-microvolt =3D <4200000>;
> +      precharge-current-microamp =3D <160000>;
> +      charge-term-current-microamp =3D <160000>;
> +    };
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>

Includes go to the beginning of example (and to beginning of DTS).

Best regards,
Krzysztof
