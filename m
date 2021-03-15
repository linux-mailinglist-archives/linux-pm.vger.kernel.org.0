Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3191433C5BD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 19:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhCOSeB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 14:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhCOSdh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Mar 2021 14:33:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2D7B64F42;
        Mon, 15 Mar 2021 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615833217;
        bh=HVQWGqz8y8OqhhYyK2J1S+Va64nH3a8Cr9xCQdP2MqQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uAtWa8bOXn0C+MmuWGMXduycNNH402Y8ouR/4SD8TQmTPDv5iPINim3vk6cFbQqDb
         Yz0dxH/oLIadSqaHmMXjc67Uh4+DsqS5uVnpj40/NXbrMKJq0zX758GPEb2FALADXQ
         56MDIJpAILAP+bhCWL2l4L8hX/x6zq7Igg7W52b3oPCvt1NEkN/06klJ5UNFQxIyje
         ch0f0DkgHwXTiuyV13Zedrp/XS0rlg8vDTs6+sUPnq1nj90K2cZxtZ90x6VcOagaxP
         xuMyo5HPKT7Uknw1Q85xviKiJuCEADnB4bC6nkCJp4Rth/vst144aZwGI9A2wh3BXc
         Vf/H3SReK8uBw==
Received: by mail-ej1-f54.google.com with SMTP id jt13so68041394ejb.0;
        Mon, 15 Mar 2021 11:33:36 -0700 (PDT)
X-Gm-Message-State: AOAM532QJtI6jaszytuqaxnmPZQ1Ed0+dgKz/7Cu3+3OOEckGnwxuRGw
        9SluR1Q/XDsH/h5ViMYSl8+E2O7HPbSWNh3NWA==
X-Google-Smtp-Source: ABdhPJxI8/L+zDadqd2570zHOVYzPJl6UwW+Gh82WpewxDvgzPQMkPdZYN0C3TpR4gZ++HAnrYfx6sEr/K4R6Pbynbs=
X-Received: by 2002:a17:906:2312:: with SMTP id l18mr25811201eja.468.1615833215265;
 Mon, 15 Mar 2021 11:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com> <20210312154357.1561730-17-sebastian.reichel@collabora.com>
In-Reply-To: <20210312154357.1561730-17-sebastian.reichel@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 15 Mar 2021 12:33:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLn9Mo_hTuCEPapNz3cFHbC8NKHH0npYrnV+dC85pBAsQ@mail.gmail.com>
Message-ID: <CAL_JsqLn9Mo_hTuCEPapNz3cFHbC8NKHH0npYrnV+dC85pBAsQ@mail.gmail.com>
Subject: Re: [PATCH 16/38] dt-bindings: power: supply: tps65217: Convert to DT
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
>  .../power/supply/tps65217-charger.yaml        | 43 +++++++++++++++++++
>  .../power/supply/tps65217_charger.txt         | 17 --------
>  2 files changed, 43 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml b/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
> new file mode 100644
> index 000000000000..a33408c3a407
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/tps65217-charger.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TPS65217 Charger
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,tps65217-charger
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 2

We've lost info that was in the original binding. You could do
something like this:

items:
  - description: USB charger
    const: 0
  - description: AC charger
    const: 1

(Usually the interrupt values would be out of scope of the binding,
but I guess here it makes some sense.)

> +
> +  interrupt-names:
> +    items:
> +      - const: USB
> +      - const: AC
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - interrupt-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {
> +      charger {
> +        compatible = "ti,tps65217-charger";
> +        interrupts = <0>, <1>;
> +        interrupt-names = "USB", "AC";
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> deleted file mode 100644
> index a11072c5a866..000000000000
> --- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -TPS65217 Charger
> -
> -Required Properties:
> --compatible: "ti,tps65217-charger"
> --interrupts: TPS65217 interrupt numbers for the AC and USB charger input change.
> -             Should be <0> for the USB charger and <1> for the AC adapter.
> --interrupt-names: Should be "USB" and "AC"
> -
> -This node is a subnode of the tps65217 PMIC.
> -
> -Example:
> -
> -       tps65217-charger {
> -               compatible = "ti,tps65217-charger";
> -               interrupts = <0>, <1>;
> -               interrupt-names = "USB", "AC";
> -       };
> --
> 2.30.1
>
