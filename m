Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA5C1E15
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 11:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfI3Jf5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 05:35:57 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39976 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfI3Jf5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 05:35:57 -0400
Received: by mail-ua1-f65.google.com with SMTP id i13so3926990uaq.7
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 02:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzD2qGvL3VizkE9nQvu95DK0V9ar1WcYyRCEdbmgd/s=;
        b=ENKDUxj2S/PL76NTuZ0LtDt8Xp1Qggith5LsiWQ1vVZE86Qa0ly016ttBl1QI6INFA
         BIGRhlxIJzDpY38IboaFgI4jFzR0GGBsoPYCWeEyoCNOvhOb4OZ1VsFSEN+dsHt/LcE0
         QFanGtNHxC8kL9yMg0gmoLHkIz6c2u4tUG4MyElYibFOJw2SlT+Z2lf7RknOjUZXAvaS
         gCFO/YGYKX29t/zhpJATFktFYBI5MDaPbL1eN6PHRS9wNUmLzIOYopZiy/gAfqQ6E54D
         lQT1KLjBXc7GtGAkYyUCcFHVDZCAUlF3v4WinAc9LgL0e+DwE1i4A+7hLPWE3HJLvdJn
         gV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzD2qGvL3VizkE9nQvu95DK0V9ar1WcYyRCEdbmgd/s=;
        b=irdRcD29iQH4EqEFhcgWnJm+685HZXUfE7AbPtjyvYwWYXOBlf6bFxp70DFynSUqBS
         H/J1QEMwj+vbiwhI/RybUq7RFEkmfuJbDP6cKEbjjXNFYlCRYRKCSwNB/0GrmQB0R6vN
         XvWwsoYfNTK5SSm4CPOKF/dQusBnpC8p0T8Pe3qcm+gJj8ntiHPRB5Y+bve8Ozrx9iUH
         4XORjQYWyh63TNaHAD37A9RdDOqXhVwVqfD4f7P9xpq9/Y8T4LubNKkhA843YBLAhSIP
         80U6esbCpYGZY/rsLlEXuuNnA3AIOY6eSmKH7Ivl8oFFVsINE6zVsEMqC3/lqOHAww2N
         8Eww==
X-Gm-Message-State: APjAAAWaTIgcNh9TscDBGTTDbl9pFkZKdLGTRpMZyuyy94rzNwl0WEBf
        jVfEHevy9K/z+rQJ5WCiDXnXzqmy/XAajkhGAnryJQ==
X-Google-Smtp-Source: APXvYqwOPzgEcdOwEVKUjzTC90Fkp81Mt7170e3s+ZrPHeKlCkhi0dtBcyVb9k3LPsI52iJjSoPVhKu5BeDpUuzi5Dg=
X-Received: by 2002:ab0:ed:: with SMTP id 100mr4570681uaj.48.1569836156110;
 Mon, 30 Sep 2019 02:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190927184352.28759-1-glaroque@baylibre.com> <20190927184352.28759-2-glaroque@baylibre.com>
In-Reply-To: <20190927184352.28759-2-glaroque@baylibre.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 30 Sep 2019 15:05:44 +0530
Message-ID: <CAHLCerMDyuLW-XJ6XxnDq5Th42g_970e_Scqtuxo0r0=pbSWdA@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] dt-bindings: thermal: Add DT bindings
 documentation for Amlogic Thermal
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-amlogic@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Sep 28, 2019 at 12:14 AM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> Adding the devicetree binding documentation for the Amlogic temperature
> sensor found in the Amlogic Meson G12A and G12B SoCs.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  .../bindings/thermal/amlogic,thermal.yaml     | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> new file mode 100644
> index 000000000000..f761681e4c0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/amlogic,thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Thermal
> +
> +maintainers:
> +  - Guillaume La Roque <glaroque@baylibre.com>
> +
> +description: Binding for Amlogic Thermal
> +
> +properties:
> +  compatible:
> +      items:
> +        - enum:
> +            - amlogic,g12a-cpu-thermal
> +            - amlogic,g12a-ddr-thermal
> +        - const: amlogic,g12a-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  amlogic,ao-secure:
> +    description: phandle to the ao-secure syscon
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - amlogic,ao-secure
> +
> +examples:
> +  - |
> +        cpu_temp: temperature-sensor@ff634800 {
> +                compatible = "amlogic,g12a-cpu-thermal",
> +                             "amlogic,g12a-thermal";
> +                reg = <0xff634800 0x50>;
> +                interrupts = <0x0 0x24 0x0>;
> +                clocks = <&clk 164>;
> +                #thermal-sensor-cells = <0>;
> +                amlogic,ao-secure = <&sec_AO>;
> +        };
> +...
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
