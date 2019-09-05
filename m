Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBEDAA5D6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 16:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbfIEO1k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 10:27:40 -0400
Received: from muru.com ([72.249.23.125]:59764 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389046AbfIEO1j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Sep 2019 10:27:39 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 00B01810D;
        Thu,  5 Sep 2019 14:28:07 +0000 (UTC)
Date:   Thu, 5 Sep 2019 07:27:34 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [RFC v2 3/3] ARM: dts: omap3: bulk convert compatible to be
 explicitly ti,omap3430 or ti,omap36xx
Message-ID: <20190905142734.GV52127@atomide.com>
References: <cover.1567587220.git.hns@goldelico.com>
 <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

* H. Nikolaus Schaller <hns@goldelico.com> [190904 08:54]:
> According to omap.txt bindings documentation, matching the ti-cpufreq driver needs
> to specify explicitly if a board uses an omap3430 or omap36xx chip.
> 
> This needs to add ti,omap3430 to most omap34xx boards and replace ti,omap3630
> by ti,omap36xx for some omap36xx boards (most others already have done it right).
> 
> We also clean up some instances of missing ti,am3517 so that we can rely on
> seeing either one of:
> 
> ti,am3517
> ti,omap34xx
> ti,omap36xx
> 
> in addition to ti,omap3.

Please set up things to use ti,omap3630 in addition to ti,omap36xx
for compatible to avoid churning the same files later.

> diff --git a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
> --- a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
> +++ b/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
> @@ -9,5 +9,5 @@
>  
>  / {
>  	model = "LogicPD Zoom DM3730 SOM-LV Development Kit";
> -	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3630", "ti,omap3";
> +	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap36xx", "ti,omap3";
>  };

So just make this:

compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3630", "ti,omap36xx", "ti,omap3";

And so on. It's fine to use ti,omap3630 for 37xx too as they're the same.

> diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
> index 9a5fde2d9bce..9947574bd0f8 100644
> --- a/arch/arm/boot/dts/omap3-ldp.dts
> +++ b/arch/arm/boot/dts/omap3-ldp.dts
> @@ -10,7 +10,7 @@
>  
>  / {
>  	model = "TI OMAP3430 LDP (Zoom1 Labrador)";
> -	compatible = "ti,omap3-ldp", "ti,omap3";
> +	compatible = "ti,omap3-ldp", "ti,omap34xx, "ti,omap3";

This fails to compile, it's missing a '"' for ti,omap34xx. And here too,
please update to use:

compatible = "ti,omap3-ldp", "ti,omap3430", "ti,omap34xx", "ti,omap3";

And again it's fine to add "ti,omap3430" for 3530 variants.

Regards,

Tony
