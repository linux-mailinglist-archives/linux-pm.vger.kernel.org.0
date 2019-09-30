Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C076C1E0F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 11:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfI3JfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 05:35:11 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36932 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfI3JfL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 05:35:11 -0400
Received: by mail-vs1-f67.google.com with SMTP id p13so6294667vsr.4
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QV4x5NHTum/jLzU4cx5C+ZxMnkOgGxMeO6LpanKwV8Q=;
        b=LZFWjyQ1EhPcpe/hpsLIH/Tabk0U7kboQRvjElnQaSeO8fb6R0xdxk4JfgVcnbizBW
         96mxggGf0N0DiJ+UuxdB3g3NqOo301Z4YsMUOubGYkHzAmTE7elNh8gQ9zCmBRO6jMSt
         AKb9ZSZsSWjA2n9JPaorjb42bN4lxFzjiDS6ZdT15+paoV43KMuXz7RkOmmJukcdVkQE
         tKinjhMracv9Bb4eAZyrJ++gq/kdIqCEX2/z3DtOoK4JBogFf700W7TyS8x8H8s6xUbF
         uX74t+Lz741V5GFZPFumLzUJJAziOq050GnQfid4NiEgY21kp4fkolg9LF92zfrhoLWX
         9cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QV4x5NHTum/jLzU4cx5C+ZxMnkOgGxMeO6LpanKwV8Q=;
        b=AT+4qi70GCmD6Gkvznp+Z3TrjgIcX8IZmbhA8RqjYu5h9Il9vLqOVH2r/5zqnzAMLp
         re82ABLMCkhSt4H91gY+qgSOnJ89cBveKSHeqb9YxP1ZBa4tiqwRwnXkAjBfWgA3TUqx
         4ROZ5agIw3/tARkuVd7TqGgm6yFGN/NTx3g/QMbcMlqgNaTwLHy0tkJutpP9MxzFLMyH
         tOpv/HCvWYlLJLC1wtzqpPgT/Hga0Yz4ltjU1vxNB6Qxj7GPS5lgip+ZgB5YzNBH1GmO
         a0Xr7G3eC9sc+PcUg2XEuULILzaWChWOQD8NT3eiuM5NMPIJzMz44gq9Ybl4YVjUkkJm
         HnZg==
X-Gm-Message-State: APjAAAVx4SXt8HzAs9ZR9v/V8ajyCTqYy9xWbwRm7fR5BGu6xmbtknVb
        +EnIJ5edm6QoShaDXJjQi/CRQFll75q3SOKKwVd2iw==
X-Google-Smtp-Source: APXvYqwMBz5wNpuqunAhTIOtFioIDFII4P4C9O10Q9J5ID9h0IFfwcQ92Xm+Zo1lLTaPpokB531dd4mzAf8FzHenGEU=
X-Received: by 2002:a67:f058:: with SMTP id q24mr9102100vsm.27.1569836109918;
 Mon, 30 Sep 2019 02:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190927184352.28759-1-glaroque@baylibre.com> <20190927184352.28759-2-glaroque@baylibre.com>
In-Reply-To: <20190927184352.28759-2-glaroque@baylibre.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 30 Sep 2019 15:04:59 +0530
Message-ID: <CAHLCerPxrGMm98nDC529pYkzEaiDk0p6VTdVzyHx8=U8_PYe_A@mail.gmail.com>
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
