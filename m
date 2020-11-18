Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2592E2B755B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 05:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgKREVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 23:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKREVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 23:21:24 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F52C0613D4
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 20:21:24 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id gi3so394081pjb.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 20:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k+NY9c+px1FIBEsWz6q06ZNYk3nsdUunnWrMe/Tvt0s=;
        b=x05XYSCnX2pfVclqovwJGSApW0q+PJFqxYdSWinuurJK7+sFE1YFXh93IjbhpScjSf
         rqMv+GlvwtGjksPFV0MS/8/gxYiW8EHujQgZuT7V0I7D6hZpfVvUxNI+mKaR3PkoYrRE
         +wXAqhQre99DNnxOduMfN8vZtzPxssSXMGdu2X1+iC9JkDAM8/u3ylOoQS4vgrJgTLTs
         dfJFLMWfIaChr/S+x3aWAex34L/z3rCw9RcPnJ3xLs6fLRrpdRKVyzUYg7HBXn9TWLR5
         ZmAfdhLIHbh2/0lBPCTQ0OjhgS8ejBEBlbw6o3tp3S0CW5lkFKM6I4dVssBvTCivBTY/
         +BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k+NY9c+px1FIBEsWz6q06ZNYk3nsdUunnWrMe/Tvt0s=;
        b=E2vVppsph8SJjjcPwwHmJKqqJs3buKHWQk5jI8Z46caSochznz9+1YaxH5Qf1I6JO9
         lRWjlrLT2TeHAYf0JjW6dQ1b4tMjsS28yqSywxHLWxmlQFsSSh0SH3YcRvcAM7Z0KsE1
         RxH2IZPTDO+wXmv+w5LgJZog/ot4S9pkLky9x6P/3NtJw5mVDmU3JaYxWSOmcPkDFj0K
         0/Z+nMShUbKE8kYEryirBuDIzEBNxprWnoGTetih7PcRW82axslqUm1TrFpWGC26RUJG
         M8BcOnyTtJdM7uA5rkU+cyv0UNgahxb2wMUY/g3Pl4s1L8PIntpcZUgRgEdBiRQSigla
         UvZQ==
X-Gm-Message-State: AOAM531tXeSzi3nIZyNfAmSKlm6gELhH0eocghl48JfsFzO3XMrZyavZ
        NUsibkdbd8fVDomkYxIGCKC4zw==
X-Google-Smtp-Source: ABdhPJwRaC+IQmmfuP8LCNaoTxzQFqRk93NVR4NjAXGOdw1Bsnc0hOD1mmfyGITGB5st8GooiDcIIw==
X-Received: by 2002:a17:902:8506:b029:d9:6dd:45ea with SMTP id bj6-20020a1709028506b02900d906dd45eamr2824765plb.72.1605673283767;
        Tue, 17 Nov 2020 20:21:23 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id j11sm7489631pfe.26.2020.11.17.20.21.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 20:21:22 -0800 (PST)
Date:   Wed, 18 Nov 2020 09:51:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 07/17] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
Message-ID: <20201118042117.q6nkwm7exakgfvu3@vireshk-i7>
References: <20201115212922.4390-1-digetx@gmail.com>
 <20201115212922.4390-8-digetx@gmail.com>
 <20201117100705.i62qr4gosvu76o22@vireshk-i7>
 <956315a9-e806-3b18-6792-f01057a6c511@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <956315a9-e806-3b18-6792-f01057a6c511@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-11-20, 17:17, Dmitry Osipenko wrote:
> 17.11.2020 13:07, Viresh Kumar пишет:
> > On 16-11-20, 00:29, Dmitry Osipenko wrote:
> >> This patch moves ACTMON driver away from generating OPP table by itself,
> >> transitioning it to use the table which comes from device-tree. This
> >> change breaks compatibility with older device-trees in order to bring
> >> support for the interconnect framework to the driver. This is a mandatory
> >> change which needs to be done in order to implement interconnect-based
> >> memory DVFS. Users of legacy device-trees will get a message telling that
> >> theirs DT needs to be upgraded. Now ACTMON issues memory bandwidth request
> >> using dev_pm_opp_set_bw(), instead of driving EMC clock rate directly.
> >>
> >> Tested-by: Peter Geis <pgwipeout@gmail.com>
> >> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> >> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/devfreq/tegra30-devfreq.c | 86 ++++++++++++++++---------------
> >>  1 file changed, 44 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> >> index 38cc0d014738..ed6d4469c8c7 100644
> >> --- a/drivers/devfreq/tegra30-devfreq.c
> >> +++ b/drivers/devfreq/tegra30-devfreq.c
> >> @@ -19,6 +19,8 @@
> >>  #include <linux/reset.h>
> >>  #include <linux/workqueue.h>
> >>  
> >> +#include <soc/tegra/fuse.h>
> >> +
> >>  #include "governor.h"
> >>  
> >>  #define ACTMON_GLB_STATUS					0x0
> >> @@ -155,6 +157,7 @@ struct tegra_devfreq_device {
> >>  
> >>  struct tegra_devfreq {
> >>  	struct devfreq		*devfreq;
> >> +	struct opp_table	*opp_table;
> >>  
> >>  	struct reset_control	*reset;
> >>  	struct clk		*clock;
> >> @@ -612,34 +615,19 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
> >>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> >>  				u32 flags)
> >>  {
> >> -	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
> >> -	struct devfreq *devfreq = tegra->devfreq;
> >>  	struct dev_pm_opp *opp;
> >> -	unsigned long rate;
> >> -	int err;
> >> +	int ret;
> >>  
> >>  	opp = devfreq_recommended_opp(dev, freq, flags);
> >>  	if (IS_ERR(opp)) {
> >>  		dev_err(dev, "Failed to find opp for %lu Hz\n", *freq);
> >>  		return PTR_ERR(opp);
> >>  	}
> >> -	rate = dev_pm_opp_get_freq(opp);
> >> -	dev_pm_opp_put(opp);
> >> -
> >> -	err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
> >> -	if (err)
> >> -		return err;
> >> -
> >> -	err = clk_set_rate(tegra->emc_clock, 0);
> >> -	if (err)
> >> -		goto restore_min_rate;
> >>  
> >> -	return 0;
> >> -
> >> -restore_min_rate:
> >> -	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
> >> +	ret = dev_pm_opp_set_bw(dev, opp);
> >> +	dev_pm_opp_put(opp);
> >>  
> >> -	return err;
> >> +	return ret;
> >>  }
> >>  
> >>  static int tegra_devfreq_get_dev_status(struct device *dev,
> >> @@ -655,7 +643,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
> >>  	stat->private_data = tegra;
> >>  
> >>  	/* The below are to be used by the other governors */
> >> -	stat->current_frequency = cur_freq;
> >> +	stat->current_frequency = cur_freq * KHZ;
> >>  
> >>  	actmon_dev = &tegra->devices[MCALL];
> >>  
> >> @@ -705,7 +693,12 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
> >>  		target_freq = max(target_freq, dev->target_freq);
> >>  	}
> >>  
> >> -	*freq = target_freq;
> >> +	/*
> >> +	 * tegra-devfreq driver operates with KHz units, while OPP table
> >> +	 * entries use Hz units. Hence we need to convert the units for the
> >> +	 * devfreq core.
> >> +	 */
> >> +	*freq = target_freq * KHZ;
> >>  
> >>  	return 0;
> >>  }
> >> @@ -774,6 +767,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
> >>  
> >>  static int tegra_devfreq_probe(struct platform_device *pdev)
> >>  {
> >> +	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
> >>  	struct tegra_devfreq_device *dev;
> >>  	struct tegra_devfreq *tegra;
> >>  	struct devfreq *devfreq;
> >> @@ -781,6 +775,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
> >>  	long rate;
> >>  	int err;
> >>  
> >> +	/* legacy device-trees don't have OPP table and must be updated */
> >> +	if (!device_property_present(&pdev->dev, "operating-points-v2")) {
> >> +		dev_err(&pdev->dev,
> >> +			"OPP table not found, please update your device tree\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> > 
> > You forgot to remove this ?
> 
> Yes, good catch. I'm planning to replace this code with a common helper
> sometime soon, so if there won't be another reasons to make a new
> revision, then I'd prefer to keep it as-is for now.

You should just replace this patch only with a version of V9.1 and you
aren't really required to resend the whole series. And you should fix
it before it gets merged. This isn't a formatting issue which we just
let through. I trust you when you say that you will fix it, but this
must be fixed now.

-- 
viresh
