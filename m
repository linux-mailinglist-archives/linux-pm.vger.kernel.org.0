Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9198A778
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 21:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfHLTrF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 15:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfHLTrE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Aug 2019 15:47:04 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D63208C2;
        Mon, 12 Aug 2019 19:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565639223;
        bh=gbsmrMPddSxxadzx4LbWD73OWFywYXXRX4TrDQhuD34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qeaq8oDKtFymRNc+PylRKzYspbegh+5NF8+13536zkBIQX00uF/TGUGv7ERys+Wgx
         OZaZEocFaDzwcR3N/3q6nhsrkdHhWU6CoYRQC1D7ws8QhEd6H0ONmK9pnLGfMsQMD3
         u48aCx7G7GSfaaZ1DCbDuxjMk2OzzQg4t2Jd5HrM=
Received: by mail-qt1-f182.google.com with SMTP id j15so10474972qtl.13;
        Mon, 12 Aug 2019 12:47:03 -0700 (PDT)
X-Gm-Message-State: APjAAAXgKjB62XuiVJxqxG4/o2fPjHjH/QftiX73sQnlPCDy7VW7B7OS
        yN7ZbbuM06WQ5mbAVk7LnebpB1aHScSVVFruYg==
X-Google-Smtp-Source: APXvYqx9uWEvSTWXRvuMQbtv/sqVk/coICqllSDh3WmkM5dZr4ZJb/kPYXz6IcU9nLuN6tc97SrlM/c6aW08otez3Hc=
X-Received: by 2002:ad4:4050:: with SMTP id r16mr6580061qvp.200.1565639222506;
 Mon, 12 Aug 2019 12:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565633880.git.leonard.crestez@nxp.com> <97b0bff95ddb85b06ef3d2f8079faa36562a956d.1565633880.git.leonard.crestez@nxp.com>
In-Reply-To: <97b0bff95ddb85b06ef3d2f8079faa36562a956d.1565633880.git.leonard.crestez@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Aug 2019 13:46:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJWpQN2oTm8Q2_Gzd0GJ+YZoc9j-zh-U1s4eGhMxDEmEA@mail.gmail.com>
Message-ID: <CAL_JsqJWpQN2oTm8Q2_Gzd0GJ+YZoc9j-zh-U1s4eGhMxDEmEA@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: devfreq: Add bindings for generic imx buses
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

On Mon, Aug 12, 2019 at 12:49 PM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> Add initial dt bindings for the interconnects inside i.MX chips.
> Multiple external IPs are involved but SOC integration means the
> software controllable interfaces are very similar.
>
> This is initially only for imx8mm but add an "fsl,imx8m-nic" fallback
> similar to exynos-bus.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  .../devicetree/bindings/devfreq/imx.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/imx.yaml
>
> diff --git a/Documentation/devicetree/bindings/devfreq/imx.yaml b/Documentation/devicetree/bindings/devfreq/imx.yaml
> new file mode 100644
> index 000000000000..0e2ee3a5205e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/imx.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/imx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic i.MX bus frequency device
> +
> +maintainers:
> +  - Leonard Crestez <leonard.crestez@nxp.com>
> +
> +description: |
> +  The i.MX SoC family has multiple buses for which clock frequency (and sometimes
> +  voltage) can be adjusted.
> +
> +  Some of those buses expose register areas mentioned in the memory maps as GPV
> +  ("Global Programmers View") but not all. Access to this area might be denied for
> +  normal world.
> +
> +  The buses are based on externally licensed IPs such as ARM NIC-301 and Arteris
> +  FlexNOC but DT bindings are specific to the integration of these bus
> +  interconnect IPs into imx SOCs.

No need to use the interconnect binding?

> +
> +properties:
> +  compatible:
> +    contains:
> +      enum:
> +       - fsl,imx8m-noc
> +       - fsl,imx8m-nic

This means any combination of these 2 strings is valid. I suspect you
want a given node to have only one of them, so drop 'contains'

> +
> +  reg:
> +    maxItems: 1
> +    description: GPV area
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks

reg?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +    noc: noc@32700000 {
> +            compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";

Doesn't match the schema. (Well, it does with 'contains', but
fsl,imx8mm-noc is not documented.)

> +            reg = <0x32700000 0x100000>;
> +            clocks = <&clk IMX8MM_CLK_NOC>;
> +            operating-points-v2 = <&noc_opp_table>;

Not documented.

> +    };
> --
> 2.17.1
>
