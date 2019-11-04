Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B761CEF0C8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfKDWtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:49:52 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34658 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfKDWtv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:49:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id l202so15740855oig.1;
        Mon, 04 Nov 2019 14:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1s5GDpJ2vznfw9Ye+nOltlxe2jd1EibRhiWFAsltDOo=;
        b=CpTHPChDyaaYf7UeeRdtZ+cKNOkkPMl96SxF0Q9CYCSfi6QfqFBpHkzaj0AphzYvS9
         gJ5PFhtIpgJyvkDpn6apCOxGugjJqhpt6lj/68Jvgqxu0V2PsTTn0YaJQsNqpXHmJK3X
         OKT/HFsf8FY9OXSTWhkn7BKZ9uED2YZb8838MFoewKC+XXeR1JjUTdqHHRxoazK7SnNz
         FfOEXuPFx2adZ48kHye/lj3BmxM+YfIqC1hyJG6/Ele2xoI516vdVlZF3XTxk0EvSyEv
         ZWIxOnES52Vn8ONth8laCHLlghMtISs7y5sHldwGU9wE0uqs5k5YuNGgW+2yGoqjETun
         oqtw==
X-Gm-Message-State: APjAAAWQsnnBaq0jpIeVK5GzRs7oKya080Upx7mvjxGLjCmgaznJFLqh
        dfIBYSc8GJa9YIodavW+iQ==
X-Google-Smtp-Source: APXvYqwG00PUvlv7RmfQfRiqNp9ITUkLiJAd1yqfHFQBbyuGVd95+23AWlzongxB/8/UtaXQTn3VGA==
X-Received: by 2002:aca:da06:: with SMTP id r6mr1204237oig.82.1572907788770;
        Mon, 04 Nov 2019 14:49:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k24sm5033064oic.29.2019.11.04.14.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:49:47 -0800 (PST)
Date:   Mon, 4 Nov 2019 16:49:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v5 01/10] dt-bindings: devfreq: Add bindings for
 generic imx buses
Message-ID: <20191104224946.GB17515@bogus>
References: <cover.1572562150.git.leonard.crestez@nxp.com>
 <0e4118456f8eb67e1ba8a7c23127fc3def58547b.1572562150.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e4118456f8eb67e1ba8a7c23127fc3def58547b.1572562150.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 01, 2019 at 12:52:00AM +0200, Leonard Crestez wrote:
> Add initial dt bindings for the interconnects inside i.MX chips.
> Multiple external IPs are involved but SOC integration means the
> software controllable interfaces are very similar.
> 
> Single node also acts as interconnect provider if #interconnect-cells is
> present.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  .../devicetree/bindings/devfreq/imx.yaml      | 83 +++++++++++++++++++

bindings/interconnect/

>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/imx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/imx.yaml b/Documentation/devicetree/bindings/devfreq/imx.yaml
> new file mode 100644
> index 000000000000..bfc825407764
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/imx.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/imx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic i.MX bus frequency device

i.MX8 specific?

> +
> +maintainers:
> +  - Leonard Crestez <leonard.crestez@nxp.com>
> +
> +description: |
> +  The i.MX SoC family has multiple buses for which clock frequency (and
> +  sometimes voltage) can be adjusted.
> +
> +  Some of those buses expose register areas mentioned in the memory maps as GPV
> +  ("Global Programmers View") but not all. Access to this area might be denied
> +  for normal (non-secure) world.
> +
> +  The buses are based on externally licensed IPs such as ARM NIC-301 and
> +  Arteris FlexNOC but DT bindings are specific to the integration of these bus
> +  interconnect IPs into imx SOCs.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - fsl,imx8mn-nic
> +          - fsl,imx8mm-nic
> +          - fsl,imx8mq-nic
> +        - const: fsl,imx8m-nic
> +      - items:
> +        - enum:
> +          - fsl,imx8mn-noc
> +          - fsl,imx8mm-noc
> +          - fsl,imx8mq-noc
> +        - const: fsl,imx8m-noc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  operating-points-v2: true
> +
> +  devfreq:
> +    description: |
> +      Phandle to another devfreq device to match OPPs with by using the
> +      passive governor.
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +  '#interconnect-cells':
> +    description: |
> +      If specified then also act as an interconnect provider. Should only be
> +      set once per soc on main noc.
> +    const: 1
> +
> +  interconnect-node-id:

Looks like common property, but it's not...

Generally, we don't do indexes or instance ids. So it needs a better 
explanation or drop this. The driver side looks like an odd marriage 
between interconnect and devfreq drivers that needs better integration, 
but I'm not all that familar with either.

> +    description: |
> +      i.MX chips have multiple scalable buses based on the same IP, this is
> +      used to distinguish between. Uses same identifier namespace as consumer

It's not names, so number space? Just guessing because there's no type 
nor example.

> +      "interconnects" property, for example one of the values in
> +      "include/dt-bindings/interconnect/imx8mm.h"
> +
> +    const: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +    noc: noc@32700000 {
> +            compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
> +            reg = <0x32700000 0x100000>;
> +            clocks = <&clk IMX8MM_CLK_NOC>;
> +            operating-points-v2 = <&noc_opp_table>;
> +    };
> -- 
> 2.17.1
> 
