Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D8333C576
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 19:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhCOSWR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 14:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhCOSVs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Mar 2021 14:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 878ED64F4C;
        Mon, 15 Mar 2021 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615832507;
        bh=afoa9GqZg2qqHylfjPMfhqp2/JmOVLX1GiaEqBxH+DM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aOjgCgPyePMGaMuQQI6WR/A02j6B7YlrIp4zZ3Z1By1mQEWgMzNRz4AgreOONuy/+
         blnwZPlvetKkD+2HkKadVjMIZ0aMxJj4SeLObJIZ7fpXyCDAYR6jeHIZ16AWWK9Mcv
         fU6Jplj6A/fwzmKsWaPzCnghPFP1cxZ9j6U7YiemIGM6F0dW8CVAkEEOJ74s2LYbRx
         78NEk3TI/0Nu9RmRxdXNGQFoVA7H/UOYXHykAjfGLLe8VaC0fntO0kJS7jkWFEKY3M
         YDHaYKW6275Jslc49Jb62DnwTTj/z0bfO8P24qQuLDSMIM5QzULLoYw1vqAR7s9LJu
         q0onSoBY1n/wg==
Received: by mail-ed1-f50.google.com with SMTP id z1so18490372edb.8;
        Mon, 15 Mar 2021 11:21:47 -0700 (PDT)
X-Gm-Message-State: AOAM532nLhReI9GdOZYrEPC1WDuKmcDAysPZqTwU9G/EzdF2FPw69VQv
        epQMIdhe6UOwTzuy27cEjSynf5TPN+RrKvXfRA==
X-Google-Smtp-Source: ABdhPJwXvaxf3Xd1WXC/uPyRinIjZ+scVfiqaCoSD1eCqTQBavGoOpWdvdB43Rk0TBOVIYIWudB8auhe+rWL0Mj14RU=
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr31140438edb.373.1615832506118;
 Mon, 15 Mar 2021 11:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com> <20210312154357.1561730-5-sebastian.reichel@collabora.com>
In-Reply-To: <20210312154357.1561730-5-sebastian.reichel@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 15 Mar 2021 12:21:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKFJPSMyMbcrpnL1WgttHSP+3Q+U8bJ_m5hm=O0gEPe4g@mail.gmail.com>
Message-ID: <CAL_JsqKFJPSMyMbcrpnL1WgttHSP+3Q+U8bJ_m5hm=O0gEPe4g@mail.gmail.com>
Subject: Re: [PATCH 04/38] dt-bindings: power: supply: bq25890: Convert to DT
 schema format
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 8:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Convert the binding to DT schema format.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/bq25890.txt         |  60 ---------
>  .../bindings/power/supply/bq25890.yaml        | 125 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/bq25890.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq25890.yaml
>
> diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
> deleted file mode 100644
> index 805040c6fff9..000000000000
> --- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -Binding for TI bq25890 Li-Ion Charger
> -
> -This driver will support the bq25892, the bq25896 and the bq25890. There are
> -other ICs in the same family but those have not been tested.
> -
> -Required properties:
> -- compatible: Should contain one of the following:
> -    * "ti,bq25890"
> -    * "ti,bq25892"
> -    * "ti,bq25895"
> -    * "ti,bq25896"
> -- reg: integer, i2c address of the device.
> -- interrupts: interrupt line;
> -- ti,battery-regulation-voltage: integer, maximum charging voltage (in uV);
> -- ti,charge-current: integer, maximum charging current (in uA);
> -- ti,termination-current: integer, charge will be terminated when current in
> -    constant-voltage phase drops below this value (in uA);
> -- ti,precharge-current: integer, maximum charge current during precharge
> -    phase (in uA);
> -- ti,minimum-sys-voltage: integer, when battery is charging and it is below
> -    minimum system voltage, the system will be regulated above
> -    minimum-sys-voltage setting (in uV);
> -- ti,boost-voltage: integer, VBUS voltage level in boost mode (in uV);
> -- ti,boost-max-current: integer, maximum allowed current draw in boost mode
> -    (in uA).
> -
> -Optional properties:
> -- ti,boost-low-freq: boolean, if present boost mode frequency will be 500kHz,
> -    otherwise 1.5MHz;
> -- ti,use-ilim-pin: boolean, if present the ILIM resistor will be used and the
> -    input current will be the lower between the resistor setting and the IINLIM
> -    register setting;
> -- ti,thermal-regulation-threshold: integer, temperature above which the charge
> -    current is lowered, to avoid overheating (in degrees Celsius). If omitted,
> -    the default setting will be used (120 degrees);
> -- ti,ibatcomp-micro-ohms: integer, value of a resistor in series with
> -    the battery;
> -- ti,ibatcomp-clamp-microvolt: integer, maximum charging voltage adjustment due
> -    to expected voltage drop on in-series resistor;
> -
> -Example:
> -
> -bq25890 {
> -       compatible = "ti,bq25890";
> -       reg = <0x6a>;
> -
> -       interrupt-parent = <&gpio1>;
> -       interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> -
> -       ti,battery-regulation-voltage = <4200000>;
> -       ti,charge-current = <1000000>;
> -       ti,termination-current = <50000>;
> -       ti,precharge-current = <128000>;
> -       ti,minimum-sys-voltage = <3600000>;
> -       ti,boost-voltage = <5000000>;
> -       ti,boost-max-current = <1000000>;
> -
> -       ti,use-ilim-pin;
> -       ti,thermal-regulation-threshold = <120>;
> -};
> diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.yaml b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
> new file mode 100644
> index 000000000000..de6e03ec120c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 Sebastian Reichel
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/bq25890.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Binding for bq25890, bq25892, bq25895 and bq25896 Li-Ion Charger
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,bq25890
> +      - ti,bq25892
> +      - ti,bq25895
> +      - ti,bq25896
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,battery-regulation-voltage:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: maximum charging voltage (in uV)
> +
> +  ti,charge-current:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: maximum charging current (in uA)
> +
> +  ti,termination-current:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      charge will be terminated when current in constant-voltage phase
> +      drops below this value (in uA)
> +
> +  ti,precharge-current:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: maximum charge current during precharge phase (in uA)
> +
> +  ti,minimum-sys-voltage:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      when battery is charging and it is below minimum system voltage,
> +      the system will be regulated above minimum-sys-voltage setting (in uV)
> +
> +  ti,boost-voltage:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: VBUS voltage level in boost mode (in uV)
> +
> +  ti,boost-max-current:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: maximum allowed current draw in boost mode (in uA)
> +
> +  ti,boost-low-freq:
> +    description: boost mode frequency will be 500kHz, otherwise 1.5MHz
> +    type: boolean
> +
> +  ti,use-ilim-pin:
> +    description: |
> +      ILIM resistor will be used and the input current will be the lower
> +      between the resistor setting and the IINLIM register setting
> +    type: boolean
> +
> +  ti,thermal-regulation-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      temperature above which the charge current is lowered, to avoid overheating
> +      (in degrees Celsius). If omitted, the default setting will be used (120 degrees)
> +
> +  ti,ibatcomp-micro-ohms:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: value of a resistor in series with the battery (in Micro Ohms)
> +
> +  ti,ibatcomp-clamp-microvolt:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: max. charging voltage adjustment due to expected voltage drop on in-series resistor

You don't need a type $ref on properties with a standard unit suffix.
Though it looks like there's some non-standard ones (-microvolts) in
the series.

Rob
