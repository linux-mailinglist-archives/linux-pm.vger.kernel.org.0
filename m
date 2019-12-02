Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E10F10EAEA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 14:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfLBNfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 08:35:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfLBNfK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Dec 2019 08:35:10 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD5020833;
        Mon,  2 Dec 2019 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575293710;
        bh=wxSZfFo7SznwT1ayrLRxDPV9OD+qKtgr4xwwiWvEVkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQc5qo85Bdrd3bB/Si1OSU1+SyQi7l8HIZFBAv7bnUXLMsReDrt+nCn6TCsfVTmiX
         cK37EoODq3M8t22DmDv6IY6cmmxfz/toFy2QQBS+8tAu+P81ExkQvXeex9s+EDIlLT
         dG9fJJ+vEX5YMXQ+GKJ7+WJXVZDJL82or/uqURtc=
Date:   Mon, 2 Dec 2019 21:34:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 4/6] PM / devfreq: Add dynamic scaling for imx ddr
 controller
Message-ID: <20191202133449.GA21897@dragon>
References: <cover.1572558427.git.leonard.crestez@nxp.com>
 <5fcf829265ecde1af32cb1369528c97361c76992.1572558427.git.leonard.crestez@nxp.com>
 <20191202053847.GC9767@dragon>
 <VI1PR04MB70234400D6CF248C18321FDBEE430@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB70234400D6CF248C18321FDBEE430@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 02, 2019 at 09:12:12AM +0000, Leonard Crestez wrote:
> >> +
> >> +	/* change the ddr freqency */
> >> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, target_freq, online_cpus,
> >> +			0, 0, 0, 0, 0, &res);
> >> +
> >> +	local_irq_enable();
> >> +}
> >> +
> >> +struct clk *clk_get_parent_by_index(struct clk *clk, int index)
> >> +{
> >> +	struct clk_hw *hw;
> >> +
> >> +	hw = clk_hw_get_parent_by_index(__clk_get_hw(clk), index);
> > 
> > Okay, this is why you need clk-provider.h.  But this
> > clk_get_parent_by_index() function looks completely generic, and should
> > be proposed to clock core?
> 
> There are very few driver users of clk_hw_get_parent_by_index:
> 
> $ git grep -wl clk_hw_get_parent_by_index |grep -v drivers/clk
> arch/mips/alchemy/common/clock.c
> drivers/cpufreq/qoriq-cpufreq.c
> drivers/devfreq/imx8m-ddrc.c
> drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> drivers/media/platform/atmel/atmel-isc-base.c
> drivers/rtc/rtc-ac100.c
> include/linux/clk-provider.h
> 
> Even clk_get_parent has few users and it contains this strange comment:
> 
> /* TODO: Create a per-user clk and change callers to call clk_put */
> 
> That proposed change effectively creates a new API? I didn't want to add 
> a new clk core API with unclear semantics.

Since the merged version has 'static' added for clk_get_parent_by_index(),
I'm fine with it being a local function.  It's Stephen's call whether
we should have it at clock core level.

Shawn
