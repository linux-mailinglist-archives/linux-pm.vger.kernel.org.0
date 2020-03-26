Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDF019408D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 14:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZNzh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 09:55:37 -0400
Received: from mout01.posteo.de ([185.67.36.65]:51159 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbgCZNzh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 09:55:37 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 35D06160065
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 14:55:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1585230934; bh=x4jYAka8aP1YBwXjiPv/wSh1i4s7WuNfZrX9rKaquus=;
        h=Subject:To:Cc:From:Autocrypt:Date:From;
        b=AbZ/DUJ+Iv0L+PCRC/xeSKj3Z6aD3uvlpRO+PJnihvRIWEqPkd9aBxlZ/YqjptG1H
         FX888uu17aUZdMH8uMyaXJaIGF8tHf78pPUV0BGAhmeDIM8gg+72vWVI3Z8hOtFiCS
         a8Ki1YmWdxCdhyI/xttD/PYtS9MJ5+qzoVex0C0lgveLm0eFXGj+aULosuLJRUJxYD
         kxD1ILPtQ1MD/j7tVJ21N+WWFpJMK+N8oz8bslIrCdGC53sFXBGifENvByQNUlN/NR
         3B12fznr6NqkHfahtTYmLk4ss7Uip2m0Yh4knevVX0qMOBI8UvLCLTcruvCzV01qRy
         LB3GbYldQMHjg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 48p62921xjz6tm9;
        Thu, 26 Mar 2020 14:55:28 +0100 (CET)
Subject: Re: [PATCH 0/8] interconnect: Add imx support via devfreq
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
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
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1585188174.git.leonard.crestez@nxp.com>
From:   Martin Kepplinger <martink@posteo.de>
Autocrypt: addr=martink@posteo.de; keydata=
 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
Message-ID: <1ae21355-df95-44e5-b8f6-14af7aa4fcc3@posteo.de>
Date:   Thu, 26 Mar 2020 14:55:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1585188174.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26.03.20 03:16, Leonard Crestez wrote:
> This series adds interconnect scaling support for imx8m series chips. It uses a
> per-SOC interconnect provider layered on top of multiple instances of devfreq
> for scalable nodes along the interconnect.
> 
> Existing qcom interconnect providers mostly translate bandwidth requests into
> firmware calls but equivalent firmware on imx8m is much thinner. Scaling
> support for individual nodes is implemented as distinct devfreq drivers
> instead.
> 
> The imx interconnect provider doesn't communicate with devfreq directly
> but rather computes "minimum frequencies" for nodes along the path and
> creates dev_pm_qos requests.
> 
> Since there is no single devicetree node that can represent the
> "interconnect" the main NOC is picked as the "interconnect provider" and
> will probe the interconnect platform device if #interconnect-cells is
> present. This avoids introducing "virtual" devices but it means that DT
> bindings of main NOC includes properties for both devfreq and
> interconnect.
> 
> Only the ddrc and main noc are scalable right now but more can be added.
> 
> Also available on a github branch (with various unrelated changes):
> 	https://github.com/cdleonard/linux/tree/next
> Testing currently requires NXP branch of atf+uboot
> 
> Martin: I believe you should be able to use this to control DRAM
> frequency from video by just adding interconnect consumer code to
> nwl-dsi. Sample code:
> 	https://github.com/cdleonard/linux/commit/43772762aa5045f1ce5623740f9a4baef988d083
> 	https://github.com/cdleonard/linux/commit/7b601e981b1f517b5d98b43bde292972ded13086
> 

Thanks for updating this series Leonard! A few questions for my
understanding before trying to test:

Isn't the ddrc_opp_table missing in these additions to the DT? That's
what I want to scale after all.

If I want to keep calling the "request", now icc_set_bw(), in nwl-dsi:
I'd add an "interconnects" property to the node, but what would be my
interconnect master? i.e.: interconnects = <&noc master? &noc
IMX8MQ_ICS_DRAM>; At least it's not obvious to me from
interconnect/imx/imx8mq.c

the interconnect framework seems to be powerful indeed, but I still need
to fully wrap my head around it.

thanks for the help so far,

                               martin


> Changes since RFCv6:
> * Replace scalable-nodes stuff with just a fsl,ddrc property. Future
> scalable nodes can be added as additional phandles on the NOC
> * Allow building interconnect drivers as modules
> * Handle icc_provider_del errors in imx_icc_unregister (like EBUSY).
> * Rename imx-devfreq to imx-bus, similar to exynos-bus
> * Explain why imx bus clock enabling is not required
> * All dependencies accepted (some time ago).
> Link: https://patchwork.kernel.org/cover/11244421/
> 
> Changes since RFCv5:
> * Replace scanning for interconnect-node-id with explicit
> scalable-nodes/scalable-node-ids property on NoC.
> * Now passes make `dtbs_check`
> * Remove struct imx_icc_provider
> * Switch to of_icc_xlate_onecell
> * Use of_find_device_by_node to fetch QoS target, this causes fewer probe
> deferrals, removes dependency on devfreq API and even allows reloading ddrc
> module at runtime
> * Add imx_icc_node_destroy helper
> * Remove 0/1 on DEFINE_BUS_SLAVE/MASTER which created spurious links
> Link: https://patchwork.kernel.org/cover/11222015/
> 
> Changes since RFCv4:
> * Drop icc proxy nonsense
> * Make devfreq driver for NOC probe the ICC driver if
> #interconnect-cells is present
> * Move NOC support to interconnect series and rename the node in DT
> * Add support for all chips at once, differences are not intereseting
> and there is more community interest for 8mq than 8mm.
> Link: https://patchwork.kernel.org/cover/11111865/
> 
> Changes since RFCv3:
> * Remove the virtual "icc" node and add devfreq nodes as proxy providers
> * Fix build on 32-bit arm (reported by kbuilt test robot)
> * Remove ARCH_MXC_ARM64 (never existed in upstream)
> * Remove _numlinks, calculate instead
> * Replace __BUSFREQ_H header guard
> * Improve commit message and comment spelling
> * Fix checkpatch issues
> Link to RFCv3: https://patchwork.kernel.org/cover/11078671/
> 
> Changes since RFCv2 and initial work by Alexandre Bailon:
> * Relying on devfreq and dev_pm_qos instead of CLK
> * No more "platform opp" stuff
> * No more special suspend handling: use suspend-opp on devfreq instead
> * Replace all mentions of "busfreq" with "interconnect"
> Link to v2: https://patchwork.kernel.org/cover/11021563/
> 
> Leonard Crestez (8):
>   dt-bindings: interconnect: Add bindings for imx8m noc
>   PM / devfreq: Add generic imx bus scaling driver
>   PM / devfreq: imx: Register interconnect device
>   interconnect: Add imx core driver
>   interconnect: imx: Add platform driver for imx8mm
>   interconnect: imx: Add platform driver for imx8mq
>   interconnect: imx: Add platform driver for imx8mn
>   arm64: dts: imx8m: Add NOC nodes
> 
>  .../bindings/interconnect/fsl,imx8m-noc.yaml  | 138 ++++++++
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  24 ++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  24 ++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  24 ++
>  drivers/devfreq/Kconfig                       |   9 +
>  drivers/devfreq/Makefile                      |   1 +
>  drivers/devfreq/imx-bus.c                     | 181 +++++++++++
>  drivers/interconnect/Kconfig                  |   1 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/imx/Kconfig              |  17 +
>  drivers/interconnect/imx/Makefile             |   9 +
>  drivers/interconnect/imx/imx.c                | 298 ++++++++++++++++++
>  drivers/interconnect/imx/imx.h                |  62 ++++
>  drivers/interconnect/imx/imx8mm.c             | 108 +++++++
>  drivers/interconnect/imx/imx8mn.c             |  97 ++++++
>  drivers/interconnect/imx/imx8mq.c             | 106 +++++++
>  include/dt-bindings/interconnect/imx8mm.h     |  49 +++
>  include/dt-bindings/interconnect/imx8mn.h     |  41 +++
>  include/dt-bindings/interconnect/imx8mq.h     |  48 +++
>  19 files changed, 1238 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
>  create mode 100644 drivers/devfreq/imx-bus.c
>  create mode 100644 drivers/interconnect/imx/Kconfig
>  create mode 100644 drivers/interconnect/imx/Makefile
>  create mode 100644 drivers/interconnect/imx/imx.c
>  create mode 100644 drivers/interconnect/imx/imx.h
>  create mode 100644 drivers/interconnect/imx/imx8mm.c
>  create mode 100644 drivers/interconnect/imx/imx8mn.c
>  create mode 100644 drivers/interconnect/imx/imx8mq.c
>  create mode 100644 include/dt-bindings/interconnect/imx8mm.h
>  create mode 100644 include/dt-bindings/interconnect/imx8mn.h
>  create mode 100644 include/dt-bindings/interconnect/imx8mq.h
> 
