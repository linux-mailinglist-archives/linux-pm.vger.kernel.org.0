Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 882D49A12E
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbfHVUcg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 16:32:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37175 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732239AbfHVUcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 16:32:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id y9so4367078pfl.4
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=RFOgqYhHHIGejl0HbA/fjeJeGoxmrXDRE4DYi+A8/8A=;
        b=P8zhTm0fAS/ixy3THy5IgTC1YE0omjEaozvX6NmYF+jcO/QbTtPNRK068nu0PjEiEU
         iakeI+gBMgvX2OdeVIGHQ1Q8HP00ZY2TvKxgNiyGlAV1KuG+5O1m38UgORhecfFgc4iy
         ZIYs0T1Oor0FdBp3veYWBtReBFXLwwW7V4quCDn8KcusoMdfI1A9UElYqGYu/ToKoY4q
         fdFOn1KZ6ZcXwZgtkAsug1FgtEiqRA+49xihnA/oe6dvJWZ9aLM5gEFywpzn0KpZnneG
         4vze4FKJmKU3cDcboBiny19OLeGab5oeDzMUBP2W7x8oqEmNA1y87mcEPDXYlghJBMIB
         xKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RFOgqYhHHIGejl0HbA/fjeJeGoxmrXDRE4DYi+A8/8A=;
        b=Zd+kTDTbIW/zK3z90ZUd3qUKLf/7gcQAN2HTNeMtsK4r+YGzyJ9vnUEOVd2e1OC5Fo
         nTsLvhLT+KXUiKifXnIKI9fxiF3Lib1mB+3Vc408GMHYqWK4Hlzq/oTzvZdj1Z8yOl9B
         y7aGktQK+4NxKtK4ru5CRugjlcfut0UsCc6eblHsdWOp7kW8DsWgVOxjFJRncXtQ+ZV+
         OmwC0MNjuTgrXgbUyUVjHsfng4TsVt9ju7dxyrFLxRqOwfd1toKHUTqxA9Apq4Hw2xFG
         WdY0cgxO5W6VAlmiqjiE9ccbuTWo06vD/gQcfEyWT1+i87ncwy9fSNKuzMeoFvVMoSA4
         INng==
X-Gm-Message-State: APjAAAXwZDPOIjix4LQZrqf0pdu1BRES9jlVyS+BYR0WigO18qOIPD8a
        vMA1Y9FKgZ4B9M/ZrBGi7R1QiA==
X-Google-Smtp-Source: APXvYqwMi2757VWPTYax3PWZoVJt/zaEQVx1DtRihbn2pb3v3lX6DDbVTNaw7kPSjD7ANOcN4v17NA==
X-Received: by 2002:a17:90a:cc0c:: with SMTP id b12mr1529730pju.138.1566505955081;
        Thu, 22 Aug 2019 13:32:35 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:89d4:68d1:fc04:721])
        by smtp.gmail.com with ESMTPSA id c13sm275532pfi.17.2019.08.22.13.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 13:32:34 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] soc: amlogic: Add support for Everything-Else power domains controller
In-Reply-To: <b6cfb770-76eb-00b1-e088-1a73b7978f33@baylibre.com>
References: <20190821114121.10430-1-narmstrong@baylibre.com> <20190821114121.10430-3-narmstrong@baylibre.com> <7hzhk25ct3.fsf@baylibre.com> <b6cfb770-76eb-00b1-e088-1a73b7978f33@baylibre.com>
Date:   Thu, 22 Aug 2019 13:32:33 -0700
Message-ID: <7hzhk12b6m.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 22/08/2019 01:16, Kevin Hilman wrote:
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>> 
>>> Add support for the General Purpose Amlogic Everything-Else Power controller,
>>> with the first support for G12A and SM1 SoCs dedicated to the VPU, PCIe,
>>> USB, NNA, GE2D and Ethernet Power Domains.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> 
>> Nice!  Thanks for generalizing this.
>> 
>> A few comments/concerns below, but this is mostly ready.

[...]

>>> +#define VPU_PD(__name, __resets, __clks, __top_pd, __mem, __get_power)	\
>>> +	{								\
>>> +		.name = __name,						\
>>> +		.reset_names_count = ARRAY_SIZE(__resets),		\
>>> +		.reset_names = __resets,				\
>>> +		.clk_names_count = ARRAY_SIZE(__clks),			\
>>> +		.clk_names = __clks,					\
>>> +		.top_pd = __top_pd,					\
>>> +		.mem_pd_count = ARRAY_SIZE(__mem),			\
>>> +		.mem_pd = __mem,					\
>>> +		.get_power = __get_power,				\
>>> +	}
>>> +
>>> +#define TOP_PD(__name, __top_pd, __mem)					\
>>> +	{								\
>>> +		.name = __name,						\
>>> +		.top_pd = __top_pd,					\
>>> +		.mem_pd_count = ARRAY_SIZE(__mem),			\
>>> +		.mem_pd = __mem,					\
>>> +	}
>> 
>> Why can't the TOP_PD domains also have a __get_power().  Shouldn't we
>> just be able to check the sleep_reg/sleep_mask like in the VPU case?
>
> It can, I can add it later, do we need it for this version ?

Yes please.  Seems a pretty simple addition, let's have it from the
beginning.

>> Also, for readability, I think the arguments to VPU_PD and TOP_PD to
>> have the same order, at least for the common ones.  IOW, __name,
>> __top_pd, __mem should be first.
>
> Sure, will fix

and you can add __get_power to the common list too.

[...]

>>> +static int meson_ee_clk_disable(struct meson_ee_pwrc_domain *pwrc_domain)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i)
>>> +		clk_disable(pwrc_domain->clks[i]);
>>> +
>>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i)
>>> +		clk_unprepare(pwrc_domain->clks[i]);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int meson_ee_clk_enable(struct meson_ee_pwrc_domain *pwrc_domain)
>>> +{
>>> +	int i, ret;
>>> +
>>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i) {
>>> +		ret = clk_prepare(pwrc_domain->clks[i]);
>>> +		if (ret)
>>> +			goto fail_prepare;
>>> +	}
>>> +
>>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i) {
>>> +		ret = clk_enable(pwrc_domain->clks[i]);
>>> +		if (ret)
>>> +			goto fail_enable;
>>> +	}
>>> +
>>> +	return 0;
>>> +fail_enable:
>>> +	while (--i)
>>> +		clk_disable(pwrc_domain->clks[i]);
>>> +
>>> +	/* Unprepare all clocks */
>>> +	i = pwrc_domain->num_clks;
>>> +
>>> +fail_prepare:
>>> +	while (--i)
>>> +		clk_unprepare(pwrc_domain->clks[i]);
>>> +
>>> +	return ret;
>>> +}
>> 
>> Both the clk enable and disable functions above are just open-coding of
>> the clk_bulk equivalents.  Please use clk_bulk_*, then you don't need
>> these helpers.  (c.f. the RFT patch I did to convert the old driver to
>> clk_bulk[1])
>
> Yes, but clk_bulk takes _all_ the clocks from the node, you canot specify
> a list of names, maybe it's overengineered but I wanted to specify the
> exact resets and clocks for each power domain, clk_bulk doesn't provide this.

I've been going on the assumption that there's no reason to list clocks
in the pwrc DT node that you don't want managed by the driver.  This
also seems to match the exisiting driver, and this new one.

What is the case where you would list clocks in the DT node for the
power-domain, but not want to manage them in the driver?

If there's no good reason to do that, then clk_bulk greatly simplifies
this code.

>>> +static int meson_ee_pwrc_off(struct generic_pm_domain *domain)
>>> +{
>>> +	struct meson_ee_pwrc_domain *pwrc_domain =
>>> +		container_of(domain, struct meson_ee_pwrc_domain, base);
>>> +	int i;
>>> +
>>> +	if (pwrc_domain->desc.top_pd)
>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>>> +				   pwrc_domain->desc.top_pd->sleep_reg,
>>> +				   pwrc_domain->desc.top_pd->sleep_mask,
>>> +				   pwrc_domain->desc.top_pd->sleep_mask);
>>> +	udelay(20);
>>> +
>>> +	for (i = 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
>>> +				   pwrc_domain->desc.mem_pd[i].reg,
>>> +				   pwrc_domain->desc.mem_pd[i].mask,
>>> +				   pwrc_domain->desc.mem_pd[i].mask);
>>> +
>>> +	udelay(20);
>>> +
>>> +	if (pwrc_domain->desc.top_pd)
>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>>> +				   pwrc_domain->desc.top_pd->iso_reg,
>>> +				   pwrc_domain->desc.top_pd->iso_mask,
>>> +				   pwrc_domain->desc.top_pd->iso_mask);
>>> +
>>> +	if (pwrc_domain->num_clks) {
>>> +		msleep(20);
>>> +		meson_ee_clk_disable(pwrc_domain);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int meson_ee_pwrc_on(struct generic_pm_domain *domain)
>>> +{
>>> +	struct meson_ee_pwrc_domain *pwrc_domain =
>>> +		container_of(domain, struct meson_ee_pwrc_domain, base);
>>> +	int i, ret;
>>> +
>>> +	if (pwrc_domain->desc.top_pd)
>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>>> +				   pwrc_domain->desc.top_pd->sleep_reg,
>>> +				   pwrc_domain->desc.top_pd->sleep_mask, 0);
>>> +	udelay(20);
>>> +
>>> +	for (i = 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
>>> +				   pwrc_domain->desc.mem_pd[i].reg,
>>> +				   pwrc_domain->desc.mem_pd[i].mask, 0);
>>> +
>>> +	udelay(20);
>>> +
>>> +	ret = meson_ee_reset_assert(pwrc_domain);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (pwrc_domain->desc.top_pd)
>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>>> +				   pwrc_domain->desc.top_pd->iso_reg,
>>> +				   pwrc_domain->desc.top_pd->iso_mask, 0);
>>> +
>>> +	ret = meson_ee_reset_deassert(pwrc_domain);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return meson_ee_clk_enable(pwrc_domain);
>>> +}
>>> +
>>> +static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
>>> +				     struct meson_ee_pwrc *sm1_pwrc,
>>> +				     struct meson_ee_pwrc_domain *dom)
>>> +{
>>> +	dom->pwrc = sm1_pwrc;
>>> +	dom->num_rstc = dom->desc.reset_names_count;
>>> +	dom->num_clks = dom->desc.clk_names_count;
>>> +
>>> +	if (dom->num_rstc) {
>>> +		int rst;
>>> +
>>> +		dom->rstc = devm_kcalloc(&pdev->dev, dom->num_rstc,
>>> +				sizeof(struct reset_control *),	GFP_KERNEL);
>>> +		if (!dom->rstc)
>>> +			return -ENOMEM;
>>> +
>>> +		for (rst = 0 ; rst < dom->num_rstc ; ++rst) {
>>> +			dom->rstc[rst] = devm_reset_control_get_exclusive(
>>> +					&pdev->dev,
>>> +					dom->desc.reset_names[rst]);
>>> +			if (IS_ERR(dom->rstc[rst]))
>>> +				return PTR_ERR(dom->rstc[rst]);
>>> +		}
>> 
>> Why not simplify and use the helpers that get multiple reset lines (like
>> devm_reset_control_array_get() used in meson-gx-pwrc-vpu.c)?
>
> Same comment as clk_bulk, we cannot be sure we select the right reset lines.

Again, what is the case for listing resets in the power-domain node that
you don't want to be managed by the driver?

>> You could also use reset_control_get_count() and compare to the expected
>> number (dom->num_rstc).
>
> This seems oversimplified

Similar to above, if you're always going to manage all the reset lines
in the DT node, then simple is good.

If there are reasons to list reset lines in the DT node that will not be
managed by the driver, I'm defintiely curious why.

If not, using the reset API helpers is much more readable and
maintainble IMO.

>> 
>>> +	}
>>> +
>>> +	if (dom->num_clks) {
>>> +		int clk;
>>> +
>>> +		dom->clks = devm_kcalloc(&pdev->dev, dom->num_clks,
>>> +				sizeof(struct clk *), GFP_KERNEL);
>>> +		if (!dom->clks)
>>> +			return -ENOMEM;
>>> +
>>> +		for (clk = 0 ; clk < dom->num_clks ; ++clk) {
>>> +			dom->clks[clk] = devm_clk_get(&pdev->dev,
>>> +					dom->desc.clk_names[clk]);
>>> +			if (IS_ERR(dom->clks[clk]))
>>> +				return PTR_ERR(dom->clks[clk]);
>>> +		}
>>> +	}
>> 
>> Please use clk_bulk API, and then just double-check that the number of
>> clocks found matches the expected number.
>
> Same, I'll either take all the clks and resets for the vpu power domain,
> or keep this code to make sure we get the right clocks and resets.

Similar to above.  IMO, we should be sure to put the "right clocks and
resets" into the DT, and then simplify the code.

>> 
>>> +	dom->base.name = dom->desc.name;
>>> +	dom->base.power_on = meson_ee_pwrc_on;
>>> +	dom->base.power_off = meson_ee_pwrc_off;
>>> +
>>> +	if (dom->desc.get_power) {
>>> +		bool powered_off = dom->desc.get_power(dom);
>> 
>> nit: insert blank line here
>> 
>> More importantly, we defintely will have problem here in the
>> !powered_off case.  TL;DR; the driver's state does not match the actual
>> hardware state.
>> 
>> When powered_off = false, you're telling the genpd core that this domain
>> is already turned on.  However, you haven't called _pwrc_on() yet for
>> the domain, which means internal state of the driver for this domain
>> (e.g. clock enables, resets, etc.) is not in sync with the HW.  On
>> SEI610 this case is happending for the VPU, which seems to be enabled by
>> u-boot, so this driver detects it as already on, which is fine.  But...
>> 
>> Remember that the ->power_off() function will be called during suspend,
>> and will lead to the clk unprepare/disable calls.  However, for domains
>> that are detected as on (!powered_off), clk prepare/enable will never
>> have been called, so that when suspend happens, you'll get "already
>> unprepared" errors from the clock core
>> 
>> IOW, I think you need something like this here:
>> 
>> 		if (!powered_off)
>> 			meson_ee_pwrc_on(&dom->base);
>> 
>> so that the internal state of clock fwk etc. matches the detected state
>> of the HW.  The problem with that simple fix, at least for the VPU is
>> that it might cause us to lose any existing display or framebuffer
>> console that's on-going.  Probably needs some testing.
>
> Yes, I forgot to take the _shutdown() function from gx_pwrc_vpu driver :
>
> 349 static void meson_gx_pwrc_vpu_shutdown(struct platform_device *pdev)
> 350 {
> 351         struct meson_gx_pwrc_vpu *vpu_pd = platform_get_drvdata(pdev);
> 352         bool powered_off;
> 353
> 354         powered_off = meson_gx_pwrc_vpu_get_power(vpu_pd);
> 355         if (!powered_off)
> 356                 vpu_pd->genpd.power_off(&vpu_pd->genpd);
> 357 }

OK, yeah, I hadn't noticed that in the original driver.  I tested
something simliar with suspend/resume on SEI610 and it gets rid of the
"already unprepared" splats from the clock core.

>> 
>> Anyways, to see what I mean, try suspend/resume (you can test this
>> series on my integ branch with "rtcwake -d rtc0 -m mem -s4") and you'll
>> see error splats from the clock core during suspend.
>> 
>> 
>> 
>>> +		pm_genpd_init(&dom->base, &pm_domain_always_on_gov,
>>> +			      powered_off);
>> 
>>> +	} else
>>> +		pm_genpd_init(&dom->base, NULL, true);
>> 
>> nit: the else clause should also have {} to match the if
>> (c.f. CodingStyle)
>
> OK
>
>> 
>> Why do you force the always-on governor in the case where ->get_power()
>> exists, but not the other?
>> 
>> If you force that, then for any devices connected to these domains that
>> use runtime PM, they will never turn off the domain when it's idle.
>> IOW, these domains will only ever be turned off on system-wide
>> suspend/resume.
>> 
>> IMO, unless there's a good reason not to, you should pass NULL for the
>> governor.
>
> It's for legacy when VPU is initialized from vendor U-Boot, look at commit :
> 339cd0ea082287ea8e2b7e7159a5a33665a2cbe3 "soc: amlogic: meson-gx-pwrc-vpu: fix power-off when powered by bootloader"
>
>     In the case the VPU power domain has been powered on by the bootloader
>     and no driver are attached to this power domain, the genpd will power it
>     off after a certain amount of time, but the clocks hasn't been enabled
>     by the kernel itself and the power-off will trigger some faults.
>     This patch enable the clocks to have a coherent state for an eventual
>     poweroff and switches to the pm_domain_always_on_gov governor.

The key phrase there being "and no driver is attached".  Now that we
have a driver, it claims this domain so I don't think it will be
powered off:

# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary 
domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
ETH                             on              
    /devices/platform/soc/ff3f0000.ethernet             unsupported
AUDIO                           off-0           
GE2D                            off-0           
PCI                             off-0           
USB                             on              
    /devices/platform/soc/ffe09000.usb                  active
NNA                             off-0           
VPU                             on              
    /devices/platform/soc/ff900000.vpu                  unsupported

In my tests with a framebuffer console (over HDMI), I don't see the
display being powered off.

> I could set always-on governor only if the domain was already enabled,
> what do you think ?

I don't think that's necessary now that we have a driver.  We really
want to be able to power-down this domain when the display is not in
use, and if you use always_on, that will never happen.

> And seems I'm also missing the "This patch enable the clocks".

I'm not sure what patch you're referring to.

Kevin
