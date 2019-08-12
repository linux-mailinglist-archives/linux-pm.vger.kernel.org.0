Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C26B8A787
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 21:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfHLTwL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 15:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbfHLTwL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Aug 2019 15:52:11 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AFC020842;
        Mon, 12 Aug 2019 19:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565639530;
        bh=9uCqcZ7pE/p3iqj1BkvfAc1CGK2aQmF1BjqLAbmYehU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fI7mxdeUfP7enoyrkJfamrxaSYCetiUpXD/K6TL5jtbawK9oqvwBGKea29PJwcXdy
         mCMN+twO+4ip1BHBbmFpBxxGPT3dPJ83XltPbqS5WeAgvOqxY5KX35eOcay26pLFFQ
         CG0fKil0uRkV+tb9VnHR7Nme9fIZ6SoHAFLA3RQQ=
Received: by mail-qk1-f179.google.com with SMTP id s145so77915599qke.7;
        Mon, 12 Aug 2019 12:52:10 -0700 (PDT)
X-Gm-Message-State: APjAAAV0pKALe3x8/2A5XbB9p89PnYERBcfjgHj13fepSuv3XiSK++5U
        XNa+odIjx6Kum0ezveXXt6vfrljqyI4/sVL+6Q==
X-Google-Smtp-Source: APXvYqwwLQrQl/3qr9l9hCi32QT/QmiDSaWwPfSaBPzEWwjlgQK/Oh9Wo1UWaCQ3HzMu9T4YG8bY9Q3DTx5u+6Olp/Q=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr30534758qke.393.1565639529456;
 Mon, 12 Aug 2019 12:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565633880.git.leonard.crestez@nxp.com> <4cbddd75652c63aab19866c93faa0b784b56d53f.1565633880.git.leonard.crestez@nxp.com>
In-Reply-To: <4cbddd75652c63aab19866c93faa0b784b56d53f.1565633880.git.leonard.crestez@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Aug 2019 13:51:57 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5zp1nW=sNtU_+wdUO9KJ4ABWjdX=R9DHjBsgygTxV6g@mail.gmail.com>
Message-ID: <CAL_Jsq+5zp1nW=sNtU_+wdUO9KJ4ABWjdX=R9DHjBsgygTxV6g@mail.gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: devfreq: Add bindings for imx ddr controller
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 12, 2019 at 12:50 PM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> Add devicetree bindings for the i.MX DDR Controller on imx8m series
> chips. It supports dynamic frequency switching between multiple data
> rates and this is exposed to Linux via the devfreq subsystem.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  .../devicetree/bindings/devfreq/imx-ddrc.yaml | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
>
> diff --git a/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml b/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
> new file mode 100644
> index 000000000000..fa20280a682f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/imx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX DDR Controller
> +
> +maintainers:
> +  - Leonard Crestez <leonard.crestez@nxp.com>
> +
> +properties:
> +  compatible:
> +    contains:

Don't use 'contains'.

> +      enum:
> +       - fsl,imx8m-ddrc
> +
> +  reg:
> +    maxItems: 1
> +    description: DDR Controller registers

Don't really need a description for a standard property with a single item.

> +
> +  clocks:
> +    minItems: 5

Just maxItems is sufficient unless there's a variable number of items.

> +    maxItems: 5
> +
> +  clock-names:
> +    items:
> +      - const: dram_core
> +      - const: dram_pll
> +      - const: dram_alt_root
> +      - const: dram_alt
> +      - const: dram_apb
> +
> +required:
> +  - reg
> +  - compatible
> +  - clocks
> +  - clock-names

You should add an 'additionalProperties: false' here.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +    ddrc: dram-controller@3d400000 {
> +        compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
> +        reg = <0x3d400000 0x400000>;
> +        clock-names = "dram_core", "dram_pll", "dram_alt_root", "dram_alt", "dram_apb";
> +        clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
> +                 <&clk IMX8MM_DRAM_PLL>,
> +                 <&clk IMX8MM_CLK_DRAM_ALT_ROOT>,
> +                 <&clk IMX8MM_CLK_DRAM_ALT>,
> +                 <&clk IMX8MM_CLK_DRAM_APB>;
> +        operating-points-v2 = <&ddrc_opp_table>;

Not documented. You can assume a common property has a type definition
already (this one doesn't yet), so just this is enough:

operating-points-v2: true
