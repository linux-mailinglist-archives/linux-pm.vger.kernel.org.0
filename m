Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17EFEEF6D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbfKDWV3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:21:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33232 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388256AbfKDWV3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:21:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id m193so15678327oig.0;
        Mon, 04 Nov 2019 14:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=payHkh7CHBV8rLqS9vWrDjrgBgsMsbVwFLh/kgRZ9q0=;
        b=lnR+X52kApukcG0RwTsGdMoIrhVE50rHL4MLhvghUJ/+Jw7G51Nt46DuNkvwG72qdN
         YyAF0abmRzGed5SCYUkuNQHbLqjFFblJCjTCqqlhDWEUukxr60ifZ74+tDCizGaWeZ6M
         E/H3vcsNwP+J5osBgsQViUMoX2ZE0qUsPK0wPQLJyA/b8bBtzrmUI/OBWO+HqwbiDLl8
         mlGvqGMI3JjCdN3iZXdfi8CIY4n3XvlrtLQTYELmI6WApahHmHOKPMBY7FHJZS00ViBO
         npjdRTcDFbarS5nbOi7vGp65hTOhK0rIEoStIirpQxYXgOf+RbeRWfAQp3IT7JKmojWh
         zYWA==
X-Gm-Message-State: APjAAAX/VnpHIPYHGgt4N6dA3cqkrQ4dhF/FlVtgid2DPla2S9HsQyre
        80a8d39fQPF+TDHMAT5TNA==
X-Google-Smtp-Source: APXvYqyG8gIUZ/z2lODppAZ1KjEbQKMvtcQ5xgWeI1/s36z27uzB90b7Q8IkrNuYd2lGq+4xgw7rxw==
X-Received: by 2002:aca:5691:: with SMTP id k139mr1169176oib.54.1572906087984;
        Mon, 04 Nov 2019 14:21:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d6sm3494169oth.45.2019.11.04.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:21:27 -0800 (PST)
Date:   Mon, 4 Nov 2019 16:21:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/6] dt-bindings: devfreq: Add bindings for imx ddr
 controller
Message-ID: <20191104222126.GB5218@bogus>
References: <cover.1572558427.git.leonard.crestez@nxp.com>
 <b9a87c69eb603622303add4f0c02dd4c1262462a.1572558427.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a87c69eb603622303add4f0c02dd4c1262462a.1572558427.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 31, 2019 at 11:50:24PM +0200, Leonard Crestez wrote:
> Add devicetree bindings for the i.MX DDR Controller on imx8m series
> chips. It supports dynamic frequency switching between multiple data
> rates and this is exposed to Linux via the devfreq subsystem.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  .../devicetree/bindings/devfreq/imx-ddrc.yaml | 60 +++++++++++++++++++

.../bindings/memory-controllers/

>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml b/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
> new file mode 100644
> index 000000000000..31db204e6845
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0

For new bindings:

# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/imx-devfreq.yaml#

Run 'make dt_binding_check'. This will fail as the filename doesn't 
match.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX DDR Controller

Perhaps i.MX8x as it's not all i.MX chips. And the filename too?

> +
> +maintainers:
> +  - Leonard Crestez <leonard.crestez@nxp.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - fsl,imx8mn-ddrc
> +        - fsl,imx8mm-ddrc
> +        - fsl,imx8mq-ddrc
> +      - const: fsl,imx8m-ddrc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: dram_core
> +      - const: dram_pll
> +      - const: dram_alt
> +      - const: dram_apb

Drop 'dram_'

> +
> +  operating-points-v2: true
> +
> +  devfreq-events:
> +    description: Phandle of PMU node
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +required:
> +  - reg
> +  - compatible
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +    ddrc: dram-controller@3d400000 {
> +        compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
> +        reg = <0x3d400000 0x400000>;
> +        clock-names = "dram_core", "dram_pll", "dram_alt", "dram_apb";
> +        clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
> +                 <&clk IMX8MM_DRAM_PLL>,
> +                 <&clk IMX8MM_CLK_DRAM_ALT>,
> +                 <&clk IMX8MM_CLK_DRAM_APB>;
> +        operating-points-v2 = <&ddrc_opp_table>;
> +    };
> -- 
> 2.17.1
> 
