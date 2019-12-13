Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DA911E6E2
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 16:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfLMPmA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Dec 2019 10:42:00 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41298 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfLMPl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2019 10:41:59 -0500
Received: by mail-il1-f193.google.com with SMTP id z90so2411214ilc.8;
        Fri, 13 Dec 2019 07:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHFriWwVf2bpxF8jwq7dYnH8TViQ3A2S0W8/bFkGrXk=;
        b=uy1iVBwF5qVEjnordVcIXzD6+GC42UB/aLnp1utugxlHKBypM+B2oVMmWYF9Fwhyck
         fzcQ/3dWMofY1YSJluLV0zdkMwBIs6YM27G1ksMcOmD4iNEgx73faeivK1equeR2rLay
         Jx1LboWVnDiCAOlZMzAlqOL7QcRqtEgr0LmVhQkcfXwpizeHvtmxh1x3TCYLRBPQeGsf
         CnWXzBO5soVgh93FPTDopuxNIC1euJ2ScGt6v4RQ3qBIldjr/A06HIEWH8TlMYwwUiLW
         WQV3j1KcU0HNCVHyjeTdtFpFD1wfg39bby/vYuZ3OcvJMiS+xAhr2VUpOzYJs6mAhLao
         PuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHFriWwVf2bpxF8jwq7dYnH8TViQ3A2S0W8/bFkGrXk=;
        b=Z6YE78oOkD8GJ/00wVFxXHhpb9tRUDoGhW6ebC2hylOppMFP7J300WcAJlW5WNpYWc
         rJi50YjjUOLYCDoPaS+COrLkIGGoEjRuMm3ztYTKHyI6rZPy7hqVdLUeU2SUmhMVEWhk
         sbgujeYqHUR2qww1FffpdVUkl1mxiAh1fsDoDO7o9YTCOcCo86NoXZuEx+uO2ge+NTn6
         InRMaZZg1P/DFrfnS09ERoh5zyJXoUCmg90jkeXA368xuFsg0CPHz8+i93LTS5PCNhQY
         1TpW7yTRvBDglfIgqKXCBbNVkm7KgFY2WnvjMUWIAgEXmCTq56uOC0KcQVRO9nEcwpET
         rFcA==
X-Gm-Message-State: APjAAAVbE/P0Ze8Zk01j4EWdc8L2/0P/165nd8hQcRzp9hBYnsFKRlhh
        WoXNIvqP0bCfimFcBwmd1/Yb2pRla6j184RP0oM=
X-Google-Smtp-Source: APXvYqzYQQrOqzq0lGlikGdKHOscdMMUlYZqW+h4DlZuPmBdDG28bYhGZKbxxSS7VizcvE2SXU3vAnQLc/C5vPctLEU=
X-Received: by 2002:a92:d38e:: with SMTP id o14mr14108231ilo.238.1576251718323;
 Fri, 13 Dec 2019 07:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20191213074533.27048-1-maxime@cerno.tech>
In-Reply-To: <20191213074533.27048-1-maxime@cerno.tech>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 13 Dec 2019 23:41:46 +0800
Message-ID: <CAEExFWunpXqKDyxqhHGJhtcQ7pwEYkWL0wvwUp==_jrd9wACbQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interconnect: Convert Allwinner MBUS
 controller to a schema
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        georgi.djakov@linaro.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 13, 2019 at 3:45 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> The older Allwinner SoCs have an MBUS controller that is used by Linux,
> with a matching Device Tree binding.
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   | 65 +++++++++++++++++++
>  .../bindings/arm/sunxi/sunxi-mbus.txt         | 37 -----------
>  2 files changed, 65 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> new file mode 100644
> index 000000000000..9370e64992dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/sunxi/allwinner,sun4i-a10-mbus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner Memory Bus (MBUS) controller
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +description: |
> +  The MBUS controller drives the MBUS that other devices in the SoC
> +  will use to perform DMA. It also has a register interface that
> +  allows to monitor and control the bandwidth and priorities for
> +  masters on that bus.
> +
> +  Each device having to perform their DMA through the MBUS must have
> +  the interconnects and interconnect-names properties set to the MBUS
> +  controller and with "dma-mem" as the interconnect name.
> +
> +properties:
> +  "#interconnect-cells":
> +    const: 1
> +    description:
> +      The content of the cell is the MBUS ID.
> +
> +  compatible:
> +    enum:
> +      - allwinner,sun5i-a13-mbus
> +      - allwinner,sun8i-h3-mbus

Is there a driver in mainline  for it?

Thx,
Yangtao

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  dma-ranges:
> +    description:
> +      See section 2.3.9 of the DeviceTree Specification.
> +
> +required:
> +  - "#interconnect-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - dma-ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sun5i-ccu.h>
> +
> +    mbus: dram-controller@1c01000 {
> +        compatible = "allwinner,sun5i-a13-mbus";
> +        reg = <0x01c01000 0x1000>;
> +        clocks = <&ccu CLK_MBUS>;
> +        dma-ranges = <0x00000000 0x40000000 0x20000000>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt b/Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt
> deleted file mode 100644
> index 2005bb486705..000000000000
> --- a/Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -Allwinner Memory Bus (MBUS) controller
> -
> -The MBUS controller drives the MBUS that other devices in the SoC will
> -use to perform DMA. It also has a register interface that allows to
> -monitor and control the bandwidth and priorities for masters on that
> -bus.
> -
> -Required properties:
> - - compatible: Must be one of:
> -       - allwinner,sun5i-a13-mbus
> -       - allwinner,sun8i-h3-mbus
> - - reg: Offset and length of the register set for the controller
> - - clocks: phandle to the clock driving the controller
> - - dma-ranges: See section 2.3.9 of the DeviceTree Specification
> - - #interconnect-cells: Must be one, with the argument being the MBUS
> -   port ID
> -
> -Each device having to perform their DMA through the MBUS must have the
> -interconnects and interconnect-names properties set to the MBUS
> -controller and with "dma-mem" as the interconnect name.
> -
> -Example:
> -
> -mbus: dram-controller@1c01000 {
> -       compatible = "allwinner,sun5i-a13-mbus";
> -       reg = <0x01c01000 0x1000>;
> -       clocks = <&ccu CLK_MBUS>;
> -       dma-ranges = <0x00000000 0x40000000 0x20000000>;
> -       #interconnect-cells = <1>;
> -};
> -
> -fe0: display-frontend@1e00000 {
> -       compatible = "allwinner,sun5i-a13-display-frontend";
> -       ...
> -       interconnects = <&mbus 19>;
> -       interconnect-names = "dma-mem";
> -};
> --
> 2.23.0
>
