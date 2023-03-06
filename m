Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE366AC0C8
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 14:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCFNZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Mar 2023 08:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFNZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2023 08:25:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D42CFDB
        for <linux-pm@vger.kernel.org>; Mon,  6 Mar 2023 05:25:38 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pZAqD-0005hR-Ik; Mon, 06 Mar 2023 14:25:25 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pZAq6-0001sj-EI; Mon, 06 Mar 2023 14:25:18 +0100
Date:   Mon, 6 Mar 2023 14:25:18 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Lin Huang <hl@rock-chips.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v3 00/19] Add perf support to the rockchip-dfi driver
Message-ID: <20230306132518.GO23347@pengutronix.de>
References: <20230216103624.591901-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216103624.591901-1-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Cc Lin Huang <hl@rock-chips.com> (original author of the rk3399_dmc driver)

Hi,

I'd like to know how we can proceed with these patches. It would be
great if someone could have a look at them. If this a bandwidth
problem please say so and I'll stay calm for another round ;)

Sascha

On Thu, Feb 16, 2023 at 11:36:05AM +0100, Sascha Hauer wrote:
> This is the third round of patches for adding perf support to the
> rockchip-dfi driver. The binding changes seem to be sorted out now,
> would be great to get some feedback to the driver changes as well.
> 
> Sascha
> 
> Changes since v2:
> - Fix broken reference to binding
> - Add Reviewed-by from Rob
> 
> Changes since v1:
> - Fix example to actually match the binding and fix the warnings resulted thereof
> - Make addition of rockchip,rk3568-dfi an extra patch
> 
> Sascha Hauer (19):
>   PM / devfreq: rockchip-dfi: Embed desc into private data struct
>   PM / devfreq: rockchip-dfi: use consistent name for private data
>     struct
>   PM / devfreq: rockchip-dfi: Make pmu regmap mandatory
>   PM / devfreq: rockchip-dfi: Add SoC specific init function
>   PM / devfreq: rockchip-dfi: dfi store raw values in counter struct
>   PM / devfreq: rockchip-dfi: Use free running counter
>   PM / devfreq: rockchip-dfi: introduce channel mask
>   PM / devfreq: rk3399_dmc,dfi: generalize DDRTYPE defines
>   PM / devfreq: rockchip-dfi: Clean up DDR type register defines
>   PM / devfreq: rockchip-dfi: Add RK3568 support
>   PM / devfreq: rockchip-dfi: Handle LPDDR2 correctly
>   PM / devfreq: rockchip-dfi: Handle LPDDR4X
>   PM / devfreq: rockchip-dfi: Pass private data struct to internal
>     functions
>   PM / devfreq: rockchip-dfi: Prepare for multiple users
>   PM / devfreq: rockchip-dfi: Add perf support
>   arm64: dts: rockchip: rk3399: Enable DFI
>   arm64: dts: rockchip: rk356x: Add DFI
>   dt-bindings: devfreq: event: convert Rockchip DFI binding to yaml
>   dt-bindings: devfreq: event: rockchip,dfi: Add rk3568 support
> 
>  .../bindings/devfreq/event/rockchip,dfi.yaml  |  72 ++
>  .../bindings/devfreq/event/rockchip-dfi.txt   |  18 -
>  .../rockchip,rk3399-dmc.yaml                  |   2 +-
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      |   1 -
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   7 +
>  drivers/devfreq/event/rockchip-dfi.c          | 659 +++++++++++++++---
>  drivers/devfreq/rk3399_dmc.c                  |  10 +-
>  include/soc/rockchip/rk3399_grf.h             |   9 +-
>  include/soc/rockchip/rk3568_grf.h             |  13 +
>  include/soc/rockchip/rockchip_grf.h           |  16 +
>  10 files changed, 674 insertions(+), 133 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
>  create mode 100644 include/soc/rockchip/rk3568_grf.h
>  create mode 100644 include/soc/rockchip/rockchip_grf.h
> 
> -- 
> 2.30.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
