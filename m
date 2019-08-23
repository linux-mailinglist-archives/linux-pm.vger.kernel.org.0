Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7DD9AA3B
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 10:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfHWIWe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 04:22:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37082 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbfHWIWd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 04:22:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id d16so8234106wme.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bhRJQFxKgCrystY+FKV2ZC8m0utC6YYureEm5o06EMY=;
        b=OjK0mImdEPsbyh/uBEX/B7KpZY2TDxHfNMCsSj1UBHE451uGE2L4eLPSOqtMnN8SJd
         p6Va2eYgpf8+FeyTUAM8W003QcPl3AL26B2NuaTsI8oXTeoxZxjGWbGYN2NSg1IF+Eto
         cQT7l2coq54RvPQmMVV2b2Odno1lK+vr+NrtfhLtIcDAV8Smh0l8is+wPUscLf90tSTW
         VqleRjEkDXkTdQgzvyw+jNrLy8CkyWjScFEVkqAGwplLe9uOV3Z6FOejPZgWtXHPYJyj
         de+GOTdyF1GAYjp1NduLTrDfn8LMwbHv1IGBdsX3b3iwuNH8la8gisd4hGL+aO2tl96Y
         W5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bhRJQFxKgCrystY+FKV2ZC8m0utC6YYureEm5o06EMY=;
        b=J0CexYSBN/aO7vAPDRNLCQLPowQFeLd+RwKLHzYPar8tknltZhNqmlH4pPezHgniPS
         MOlxiG46ZsxzhsX3k+eVINf+E11YnJ5risVB9vtVujG9IfCpU//P1Xpap2swhDAGK51b
         pWb+8osTR06tAhIAh56xEimuGniJeuWhUfbXu61Sqt9xfTdvCR1pSCjPsY7Mzbx4J9+k
         9Si8+1tPC81zR8+L1QuxmPaCQVXY3I2zQQiFP3KaEyHlX6WIdDXEpSBHlgyQCA2diIPr
         uRnRTcm2c/6WPEmQug5lCf5F2bkWZuM8rNfDTrcw8aYWhnjTujKBt1YWXt1/QivhrdTq
         4ZJA==
X-Gm-Message-State: APjAAAWkFAWmxOBFloZSzewzNGFS3L47BwUlAVqrfXesiol1B5oXVbI3
        htE2L6aNz5gQWdFqDyqAgPLqKw2pFIPAAw==
X-Google-Smtp-Source: APXvYqyKd7fF4lQEsgUnVIHgbioDT+eozPNzUMr/KSz5fLD5khYbJI1jyXPaqVqJ6gdWw2HpLCh0yw==
X-Received: by 2002:a1c:7a14:: with SMTP id v20mr3848051wmc.75.1566548549286;
        Fri, 23 Aug 2019 01:22:29 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m7sm2813172wmi.18.2019.08.23.01.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 01:22:28 -0700 (PDT)
Subject: Re: [PATCH 2/5] soc: amlogic: Add support for Everything-Else power
 domains controller
To:     Kevin Hilman <khilman@baylibre.com>, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190821114121.10430-1-narmstrong@baylibre.com>
 <20190821114121.10430-3-narmstrong@baylibre.com>
 <7hzhk25ct3.fsf@baylibre.com>
 <b6cfb770-76eb-00b1-e088-1a73b7978f33@baylibre.com>
 <7hzhk12b6m.fsf@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <0ac1cf30-1796-a549-e195-0f94c4a85993@baylibre.com>
Date:   Fri, 23 Aug 2019 10:22:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7hzhk12b6m.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/08/2019 22:32, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> On 22/08/2019 01:16, Kevin Hilman wrote:
>>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>>
>>>> Add support for the General Purpose Amlogic Everything-Else Power controller,
>>>> with the first support for G12A and SM1 SoCs dedicated to the VPU, PCIe,
>>>> USB, NNA, GE2D and Ethernet Power Domains.
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>
>>> Nice!  Thanks for generalizing this.
>>>
>>> A few comments/concerns below, but this is mostly ready.
> 
> [...]
> 
>>>> +#define VPU_PD(__name, __resets, __clks, __top_pd, __mem, __get_power)	\
>>>> +	{								\
>>>> +		.name = __name,						\
>>>> +		.reset_names_count = ARRAY_SIZE(__resets),		\
>>>> +		.reset_names = __resets,				\
>>>> +		.clk_names_count = ARRAY_SIZE(__clks),			\
>>>> +		.clk_names = __clks,					\
>>>> +		.top_pd = __top_pd,					\
>>>> +		.mem_pd_count = ARRAY_SIZE(__mem),			\
>>>> +		.mem_pd = __mem,					\
>>>> +		.get_power = __get_power,				\
>>>> +	}
>>>> +
>>>> +#define TOP_PD(__name, __top_pd, __mem)					\
>>>> +	{								\
>>>> +		.name = __name,						\
>>>> +		.top_pd = __top_pd,					\
>>>> +		.mem_pd_count = ARRAY_SIZE(__mem),			\
>>>> +		.mem_pd = __mem,					\
>>>> +	}
>>>
>>> Why can't the TOP_PD domains also have a __get_power().  Shouldn't we
>>> just be able to check the sleep_reg/sleep_mask like in the VPU case?
>>
>> It can, I can add it later, do we need it for this version ?
> 
> Yes please.  Seems a pretty simple addition, let's have it from the
> beginning.
> 
>>> Also, for readability, I think the arguments to VPU_PD and TOP_PD to
>>> have the same order, at least for the common ones.  IOW, __name,
>>> __top_pd, __mem should be first.
>>
>> Sure, will fix
> 
> and you can add __get_power to the common list too.
> 
> [...]
> 
>>>> +static int meson_ee_clk_disable(struct meson_ee_pwrc_domain *pwrc_domain)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i)
>>>> +		clk_disable(pwrc_domain->clks[i]);
>>>> +
>>>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i)
>>>> +		clk_unprepare(pwrc_domain->clks[i]);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int meson_ee_clk_enable(struct meson_ee_pwrc_domain *pwrc_domain)
>>>> +{
>>>> +	int i, ret;
>>>> +
>>>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i) {
>>>> +		ret = clk_prepare(pwrc_domain->clks[i]);
>>>> +		if (ret)
>>>> +			goto fail_prepare;
>>>> +	}
>>>> +
>>>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i) {
>>>> +		ret = clk_enable(pwrc_domain->clks[i]);
>>>> +		if (ret)
>>>> +			goto fail_enable;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +fail_enable:
>>>> +	while (--i)
>>>> +		clk_disable(pwrc_domain->clks[i]);
>>>> +
>>>> +	/* Unprepare all clocks */
>>>> +	i = pwrc_domain->num_clks;
>>>> +
>>>> +fail_prepare:
>>>> +	while (--i)
>>>> +		clk_unprepare(pwrc_domain->clks[i]);
>>>> +
>>>> +	return ret;
>>>> +}
>>>
>>> Both the clk enable and disable functions above are just open-coding of
>>> the clk_bulk equivalents.  Please use clk_bulk_*, then you don't need
>>> these helpers.  (c.f. the RFT patch I did to convert the old driver to
>>> clk_bulk[1])
>>
>> Yes, but clk_bulk takes _all_ the clocks from the node, you canot specify
>> a list of names, maybe it's overengineered but I wanted to specify the
>> exact resets and clocks for each power domain, clk_bulk doesn't provide this.
> 
> I've been going on the assumption that there's no reason to list clocks
> in the pwrc DT node that you don't want managed by the driver.  This
> also seems to match the exisiting driver, and this new one.
> 
> What is the case where you would list clocks in the DT node for the
> power-domain, but not want to manage them in the driver?
> 
> If there's no good reason to do that, then clk_bulk greatly simplifies
> this code.

I guess I could put back the code if we need to split clocks and resets across
power domains in the future.

> 
>>>> +static int meson_ee_pwrc_off(struct generic_pm_domain *domain)
>>>> +{
>>>> +	struct meson_ee_pwrc_domain *pwrc_domain =
>>>> +		container_of(domain, struct meson_ee_pwrc_domain, base);
>>>> +	int i;
>>>> +
>>>> +	if (pwrc_domain->desc.top_pd)
>>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>>>> +				   pwrc_domain->desc.top_pd->sleep_reg,
>>>> +				   pwrc_domain->desc.top_pd->sleep_mask,
>>>> +				   pwrc_domain->desc.top_pd->sleep_mask);
>>>> +	udelay(20);
>>>> +
>>>> +	for (i = 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
>>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
>>>> +				   pwrc_domain->desc.mem_pd[i].reg,
>>>> +				   pwrc_domain->desc.mem_pd[i].mask,
>>>> +				   pwrc_domain->desc.mem_pd[i].mask);
>>>> +
>>>> +	udelay(20);
>>>> +
>>>> +	if (pwrc_domain->desc.top_pd)
>>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>>>> +				   pwrc_domain->desc.top_pd->iso_reg,
>>>> +				   pwrc_domain->desc.top_pd->iso_mask,
>>>> +				   pwrc_domain->desc.top_pd->iso_mask);
>>>> +
>>>> +	if (pwrc_domain->num_clks) {
>>>> +		msleep(20);
>>>> +		meson_ee_clk_disable(pwrc_domain);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int meson_ee_pwrc_on(struct generic_pm_domain *domain)
>>>> +{
>>>> +	struct meson_ee_pwrc_domain *pwrc_domain =
>>>> +		container_of(domain, struct meson_ee_pwrc_domain, base);
>>>> +	int i, ret;
>>>> +
>>>> +	if (pwrc_domain->desc.top_pd)
>>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>>>> +				   pwrc_domain->desc.top_pd->sleep_reg,
>>>> +				   pwrc_domain->desc.top_pd->sleep_mask, 0);
>>>> +	udelay(20);
>>>> +
>>>> +	for (i = 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
>>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
>>>> +				   pwrc_domain->desc.mem_pd[i].reg,
>>>> +				   pwrc_domain->desc.mem_pd[i].mask, 0);
>>>> +
>>>> +	udelay(20);
>>>> +
>>>> +	ret = meson_ee_reset_assert(pwrc_domain);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (pwrc_domain->desc.top_pd)
>>>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>>>> +				   pwrc_domain->desc.top_pd->iso_reg,
>>>> +				   pwrc_domain->desc.top_pd->iso_mask, 0);
>>>> +
>>>> +	ret = meson_ee_reset_deassert(pwrc_domain);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	return meson_ee_clk_enable(pwrc_domain);
>>>> +}
>>>> +
>>>> +static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
>>>> +				     struct meson_ee_pwrc *sm1_pwrc,
>>>> +				     struct meson_ee_pwrc_domain *dom)
>>>> +{
>>>> +	dom->pwrc = sm1_pwrc;
>>>> +	dom->num_rstc = dom->desc.reset_names_count;
>>>> +	dom->num_clks = dom->desc.clk_names_count;
>>>> +
>>>> +	if (dom->num_rstc) {
>>>> +		int rst;
>>>> +
>>>> +		dom->rstc = devm_kcalloc(&pdev->dev, dom->num_rstc,
>>>> +				sizeof(struct reset_control *),	GFP_KERNEL);
>>>> +		if (!dom->rstc)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		for (rst = 0 ; rst < dom->num_rstc ; ++rst) {
>>>> +			dom->rstc[rst] = devm_reset_control_get_exclusive(
>>>> +					&pdev->dev,
>>>> +					dom->desc.reset_names[rst]);
>>>> +			if (IS_ERR(dom->rstc[rst]))
>>>> +				return PTR_ERR(dom->rstc[rst]);
>>>> +		}
>>>
>>> Why not simplify and use the helpers that get multiple reset lines (like
>>> devm_reset_control_array_get() used in meson-gx-pwrc-vpu.c)?
>>
>> Same comment as clk_bulk, we cannot be sure we select the right reset lines.
> 
> Again, what is the case for listing resets in the power-domain node that
> you don't want to be managed by the driver?
> 
>>> You could also use reset_control_get_count() and compare to the expected
>>> number (dom->num_rstc).
>>
>> This seems oversimplified
> 
> Similar to above, if you're always going to manage all the reset lines
> in the DT node, then simple is good.
> 
> If there are reasons to list reset lines in the DT node that will not be
> managed by the driver, I'm defintiely curious why.
> 
> If not, using the reset API helpers is much more readable and
> maintainble IMO.

Will simply add the resets and clocks numbers and check the number at probe.

> 
>>>
>>>> +	}
>>>> +
>>>> +	if (dom->num_clks) {
>>>> +		int clk;
>>>> +
>>>> +		dom->clks = devm_kcalloc(&pdev->dev, dom->num_clks,
>>>> +				sizeof(struct clk *), GFP_KERNEL);
>>>> +		if (!dom->clks)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		for (clk = 0 ; clk < dom->num_clks ; ++clk) {
>>>> +			dom->clks[clk] = devm_clk_get(&pdev->dev,
>>>> +					dom->desc.clk_names[clk]);
>>>> +			if (IS_ERR(dom->clks[clk]))
>>>> +				return PTR_ERR(dom->clks[clk]);
>>>> +		}
>>>> +	}
>>>
>>> Please use clk_bulk API, and then just double-check that the number of
>>> clocks found matches the expected number.
>>
>> Same, I'll either take all the clks and resets for the vpu power domain,
>> or keep this code to make sure we get the right clocks and resets.
> 
> Similar to above.  IMO, we should be sure to put the "right clocks and
> resets" into the DT, and then simplify the code.
> 
>>>
>>>> +	dom->base.name = dom->desc.name;
>>>> +	dom->base.power_on = meson_ee_pwrc_on;
>>>> +	dom->base.power_off = meson_ee_pwrc_off;
>>>> +
>>>> +	if (dom->desc.get_power) {
>>>> +		bool powered_off = dom->desc.get_power(dom);
>>>
>>> nit: insert blank line here
>>>
>>> More importantly, we defintely will have problem here in the
>>> !powered_off case.  TL;DR; the driver's state does not match the actual
>>> hardware state.
>>>
>>> When powered_off = false, you're telling the genpd core that this domain
>>> is already turned on.  However, you haven't called _pwrc_on() yet for
>>> the domain, which means internal state of the driver for this domain
>>> (e.g. clock enables, resets, etc.) is not in sync with the HW.  On
>>> SEI610 this case is happending for the VPU, which seems to be enabled by
>>> u-boot, so this driver detects it as already on, which is fine.  But...
>>>
>>> Remember that the ->power_off() function will be called during suspend,
>>> and will lead to the clk unprepare/disable calls.  However, for domains
>>> that are detected as on (!powered_off), clk prepare/enable will never
>>> have been called, so that when suspend happens, you'll get "already
>>> unprepared" errors from the clock core
>>>
>>> IOW, I think you need something like this here:
>>>
>>> 		if (!powered_off)
>>> 			meson_ee_pwrc_on(&dom->base);
>>>
>>> so that the internal state of clock fwk etc. matches the detected state
>>> of the HW.  The problem with that simple fix, at least for the VPU is
>>> that it might cause us to lose any existing display or framebuffer
>>> console that's on-going.  Probably needs some testing.
>>
>> Yes, I forgot to take the _shutdown() function from gx_pwrc_vpu driver :
>>
>> 349 static void meson_gx_pwrc_vpu_shutdown(struct platform_device *pdev)
>> 350 {
>> 351         struct meson_gx_pwrc_vpu *vpu_pd = platform_get_drvdata(pdev);
>> 352         bool powered_off;
>> 353
>> 354         powered_off = meson_gx_pwrc_vpu_get_power(vpu_pd);
>> 355         if (!powered_off)
>> 356                 vpu_pd->genpd.power_off(&vpu_pd->genpd);
>> 357 }
> 
> OK, yeah, I hadn't noticed that in the original driver.  I tested
> something simliar with suspend/resume on SEI610 and it gets rid of the
> "already unprepared" splats from the clock core.
> 
>>>
>>> Anyways, to see what I mean, try suspend/resume (you can test this
>>> series on my integ branch with "rtcwake -d rtc0 -m mem -s4") and you'll
>>> see error splats from the clock core during suspend.
>>>
>>>
>>>
>>>> +		pm_genpd_init(&dom->base, &pm_domain_always_on_gov,
>>>> +			      powered_off);
>>>
>>>> +	} else
>>>> +		pm_genpd_init(&dom->base, NULL, true);
>>>
>>> nit: the else clause should also have {} to match the if
>>> (c.f. CodingStyle)
>>
>> OK
>>
>>>
>>> Why do you force the always-on governor in the case where ->get_power()
>>> exists, but not the other?
>>>
>>> If you force that, then for any devices connected to these domains that
>>> use runtime PM, they will never turn off the domain when it's idle.
>>> IOW, these domains will only ever be turned off on system-wide
>>> suspend/resume.
>>>
>>> IMO, unless there's a good reason not to, you should pass NULL for the
>>> governor.
>>
>> It's for legacy when VPU is initialized from vendor U-Boot, look at commit :
>> 339cd0ea082287ea8e2b7e7159a5a33665a2cbe3 "soc: amlogic: meson-gx-pwrc-vpu: fix power-off when powered by bootloader"
>>
>>     In the case the VPU power domain has been powered on by the bootloader
>>     and no driver are attached to this power domain, the genpd will power it
>>     off after a certain amount of time, but the clocks hasn't been enabled
>>     by the kernel itself and the power-off will trigger some faults.
>>     This patch enable the clocks to have a coherent state for an eventual
>>     poweroff and switches to the pm_domain_always_on_gov governor.
> 
> The key phrase there being "and no driver is attached".  Now that we
> have a driver, it claims this domain so I don't think it will be
> powered off:
> 
> # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary 
> domain                          status          slaves
>     /device                                             runtime status
> ----------------------------------------------------------------------
> ETH                             on              
>     /devices/platform/soc/ff3f0000.ethernet             unsupported
> AUDIO                           off-0           
> GE2D                            off-0           
> PCI                             off-0           
> USB                             on              
>     /devices/platform/soc/ffe09000.usb                  active
> NNA                             off-0           
> VPU                             on              
>     /devices/platform/soc/ff900000.vpu                  unsupported
> 
> In my tests with a framebuffer console (over HDMI), I don't see the
> display being powered off.

It's in the case where the driver is a module loaded by the post-initramfs
system after the genpd timeout, or if the display driver is disabled.

In the later I had some system failures when vendor u-boot enabled the
display and genpd disabled the power domain later on.

> 
>> I could set always-on governor only if the domain was already enabled,
>> what do you think ?
> 
> I don't think that's necessary now that we have a driver.  We really
> want to be able to power-down this domain when the display is not in
> use, and if you use always_on, that will never happen.
> 
>> And seems I'm also missing the "This patch enable the clocks".
> 
> I'm not sure what patch you're referring to.

It's also added in 339cd0ea082287ea8e2b7e7159a5a33665a2cbe3 "soc: amlogic: meson-gx-pwrc-vpu: fix power-off when powered by bootloader"

I would like to keep the same behavior as meson-gx-pwrc-vpu, since it works fine
and we debugged all the issues we got.

Neil


> 
> Kevin
> 

