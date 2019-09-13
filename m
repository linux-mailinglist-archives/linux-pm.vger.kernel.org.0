Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C657B1BA8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2019 12:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbfIMKlz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Sep 2019 06:41:55 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46141 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387549AbfIMKlz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2019 06:41:55 -0400
Received: by mail-vk1-f194.google.com with SMTP id s28so4030519vkm.13
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2019 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VzFtOukORn6BTxSSinbhVvnit+eXevFHlnBe06UcHUA=;
        b=f3NLr6fbzNYDtDc9NetNG83qATddX3ST7qNfOKiC7D5A26Lz2W6t+TDvpUxWeoYtT3
         M4aApAZGloRKGHMgH5L8irTiEYBLKD3B/TRtWOrBOlsAjjACHoc4sHORYAgqvS0mL4E7
         t30zdO7NhhgWVnNDKr0/2Bh3D/lnBW2Kv3e4DwIMIDa17R97vTDrnH1O2Okzk0a4Kq+o
         kQ7BLoiH1T9lNsHm2mbS7J+LamF28uuFHwj5hA7c0oM0csUOHIolCIFZAva9Njfv3iIH
         Dtn3ozGFbppAKM4KDwUz8SJW1Z+2yZo2q6DQ2w3yD6hcXQSIQMiQ8gv7iN/j0A0ewzRo
         yIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VzFtOukORn6BTxSSinbhVvnit+eXevFHlnBe06UcHUA=;
        b=Kdc4n28pxDfuUo/VjBK4viDoRNVtlbRNiTTowoYqYeibKceWHACGAMeKZ/KvsLCtWC
         w34DqHIMmVrLf/diJyqb9GEcIGLTpLpFzms30QTWRBNA/TUk1ALHl9u0N6tDUYjRtZOP
         GqEAgQbAgmsnM1+4VZkcmu7MgJMn7I4rSu6+y4b9D9tcMLEAqn5lwrcnAZno8MmcJv7o
         9WX+69M4QnCDZiN+hw5GJJvZ7dyExA4gzDsL47kfDJ1jbqIGxba0bgQWnufeRe2EUPpe
         b3LAv5JtITEqvP+hGxpu5vr956RXpxBjibLvX0mwQk8WcLiCSKJl9E3Emsn0XBpHMxxi
         TWkw==
X-Gm-Message-State: APjAAAXHNAwbHZORe9O8Wx2atbufOpIkZVJohBnKIwifmrvrLstvrnEm
        4lhRF/NQNsl82MoVscDp30xBIVverjGOp+fGPEE7fQ==
X-Google-Smtp-Source: APXvYqxu3cBj6Axf6oFZHBU9kgVq97krzKOT0Ts3wNrOj22Hb1h0mDeMG74eyOdiEpKHd1mAbLgszYVEJZSRRFRkBo8=
X-Received: by 2002:a1f:410f:: with SMTP id o15mr19922615vka.82.1568371312972;
 Fri, 13 Sep 2019 03:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190821222421.30242-1-glaroque@baylibre.com> <20190821222421.30242-2-glaroque@baylibre.com>
In-Reply-To: <20190821222421.30242-2-glaroque@baylibre.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 13 Sep 2019 16:11:41 +0530
Message-ID: <CAHLCerONjCa4Az7+d_0Qn8X36oOxXEMps++5MnBRdH5QE+aS=g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: thermal: Add DT bindings
 documentation for Amlogic Thermal
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 22, 2019 at 3:54 AM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> Adding the devicetree binding documentation for the Amlogic temperature
> sensor found in the Amlogic Meson G12 SoCs.
> the G12A  and G12B SoCs are supported.

Merge the two sentences into a single one?

> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
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
