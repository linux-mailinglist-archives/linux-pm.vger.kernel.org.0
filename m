Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9606D3FD413
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbhIAG6g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 02:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242018AbhIAG6f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 02:58:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380C2C061575;
        Tue, 31 Aug 2021 23:57:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id l10so4332951lfg.4;
        Tue, 31 Aug 2021 23:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k+w+OynxrHfvfwLuTstrgFT1O6b5XauALgOqQINm9Ak=;
        b=k4aTWRkosN+ae6Xj8lo/rXEW9hC41ZIZr2Is9yU2M6huZjdjCaF38TX8GcshAogMiS
         9s5vHIXdOT1WsJBVqWfFAYgZh/x6w2/XMPkZIXp56ut0Xh39yDbvmuRy/veAA3gEkXrE
         g4w5igl+9lUfkXfrjzF6cNXpXoYrgf52sXinOWB4B/omXV3mayiv+QB54JW/w9tyUfuO
         7Na79UtkZ94sDh9pF04o4sM4qtTYA+wCd74VpjlcpTW+wK23YTuuyWCo7oJ5fY3TwW73
         RdiHbQsDGkQ9W3hRkKvElTWueHdZS1JY0+GK33LE/gqmXqWMXB908QiJ/Q8IYBTPtGbY
         KErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k+w+OynxrHfvfwLuTstrgFT1O6b5XauALgOqQINm9Ak=;
        b=tv60N+GwBqCUy8jyQ+30WYsoKNO9qyf/TtSzSUVcutrE4/+UBN+Fs2P9D9Xx84WqHb
         PxnRQ7pfykGGltHvKf99fO68bQgB44oXIiOrUqNZFYqATLcvRAlL+PtP4A5F1knU4msU
         X2zQKcdyA+nTmMCSdqkRZYzxqKlbjaN1u0velLu+Z681RGynT7BFqojR/CdIrpAsnDNH
         B4xCSHlNv7QmT64bilFh1Ts/eyoSEWYRd2Ym3Oc/oCkkpGjucfo3WkoRAsqlfjnHbShc
         b/Vj3WTt8JjkO6v5Na2WMmb6Nm0x903V7OOuI/BGybQyHYsPyp2P4fbf5KDPC1lwd2p3
         isGA==
X-Gm-Message-State: AOAM533N9oY6O6wvr7vKFaImqH94zZblB6edgz2hqKgfWFpKV4fApUeI
        MbTy79/ggKfOqDXkaoq5hdtAznSQS48=
X-Google-Smtp-Source: ABdhPJxKpnOgRCbzqQeJPlFDY4FFNZgEKSJUonTp0bF9F6QsmL6UT82Ov24BxpNs778mqqbL3uKLBg==
X-Received: by 2002:a19:f015:: with SMTP id p21mr24276736lfc.32.1630479457330;
        Tue, 31 Aug 2021 23:57:37 -0700 (PDT)
Received: from [192.168.2.145] (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.googlemail.com with ESMTPSA id c7sm1943322lfk.3.2021.08.31.23.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 23:57:36 -0700 (PDT)
Subject: Re: [PATCH v10 5/8] soc/tegra: pmc: Implement
 dev_get_performance_state() callback
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-6-digetx@gmail.com>
 <20210901061050.4x3t4cc434zdwx3a@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7f4f5ab0-cf23-3e27-211e-4dcd8903f96f@gmail.com>
Date:   Wed, 1 Sep 2021 09:57:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901061050.4x3t4cc434zdwx3a@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.09.2021 09:10, Viresh Kumar пишет:
> On 31-08-21, 16:54, Dmitry Osipenko wrote:
>> +static int
>> +tegra_pmc_pd_dev_get_performance_state(struct generic_pm_domain *genpd,
>> +				       struct device *dev)
>> +{
>> +	struct opp_table *hw_opp_table, *clk_opp_table;
>> +	struct dev_pm_opp *opp;
>> +	u32 hw_version;
>> +	int ret;
>> +
>> +	/*
>> +	 * The EMC devices are a special case because we have a protection
>> +	 * from non-EMC drivers getting clock handle before EMC driver is
>> +	 * fully initialized.  The goal of the protection is to prevent
>> +	 * devfreq driver from getting failures if it will try to change
>> +	 * EMC clock rate until clock is fully initialized.  The EMC drivers
>> +	 * will initialize the performance state by themselves.
>> +	 *
>> +	 * Display controller also is a special case because only controller
>> +	 * driver could get the clock rate based on configuration of internal
>> +	 * divider.
>> +	 *
>> +	 * Clock driver uses its own state syncing.
>> +	 */
>> +	if (of_device_compatible_match(dev->of_node, tegra_pd_no_perf_compats))
>> +		return 0;
>> +
>> +	if (of_machine_is_compatible("nvidia,tegra20"))
>> +		hw_version = BIT(tegra_sku_info.soc_process_id);
>> +	else
>> +		hw_version = BIT(tegra_sku_info.soc_speedo_id);
>> +
>> +	hw_opp_table = dev_pm_opp_set_supported_hw(dev, &hw_version, 1);
>> +	if (IS_ERR(hw_opp_table)) {
>> +		dev_err(dev, "failed to set OPP supported HW: %pe\n",
>> +			hw_opp_table);
>> +		return PTR_ERR(hw_opp_table);
>> +	}
>> +
>> +	/*
>> +	 * Older device-trees don't have OPPs, meanwhile drivers use
>> +	 * dev_pm_opp_set_rate() and it requires OPP table to be set
>> +	 * up using dev_pm_opp_set_clkname().
>> +	 *
>> +	 * The devm_tegra_core_dev_init_opp_table() is a common helper
>> +	 * that sets up OPP table for Tegra drivers and it sets the clk
>> +	 * for compatibility with older device-tress.  GR3D driver uses that
>> +	 * helper, it also uses devm_pm_opp_attach_genpd() to manually attach
>> +	 * power domains, which now holds the reference to OPP table that
>> +	 * already has clk set up implicitly by OPP core for a newly created
>> +	 * table using dev_pm_opp_of_add_table() invoked below.
>> +	 *
>> +	 * Hence we need to explicitly set/put the clk, otherwise
>> +	 * further dev_pm_opp_set_clkname() will fail with -EBUSY.
>> +	 */
>> +	clk_opp_table = dev_pm_opp_set_clkname(dev, NULL);
>> +	if (IS_ERR(clk_opp_table)) {
>> +		dev_err(dev, "failed to set OPP clk: %pe\n", clk_opp_table);
>> +		ret = PTR_ERR(clk_opp_table);
>> +		goto put_hw;
>> +	}
>> +
>> +	ret = dev_pm_opp_of_add_table(dev);
>> +	if (ret) {
>> +		dev_err(dev, "failed to add OPP table: %d\n", ret);
>> +		goto put_clk;
>> +	}
>> +
>> +	opp = dev_pm_opp_get_current(dev);
>> +	if (IS_ERR(opp)) {
>> +		dev_err(dev, "failed to get current OPP: %pe\n", opp);
>> +		ret = PTR_ERR(opp);
>> +	} else {
>> +		ret = dev_pm_opp_get_required_pstate(opp, 0);
>> +		dev_pm_opp_put(opp);
>> +	}
>> +
>> +	dev_pm_opp_of_remove_table(dev);
>> +put_clk:
>> +	dev_pm_opp_put_clkname(clk_opp_table);
>> +put_hw:
>> +	dev_pm_opp_put_supported_hw(hw_opp_table);
> 
> So you create the OPP table and just after that you remove it ? Just
> to get the current OPP and pstate ? This doesn't look okay.
> 
> Moreover, this routine must be implemented with the expectation that
> the genpd core can call it anytime it wants, not just at the
> beginning. And so if the table is already setup by someone else then,
> then this all will just fail.

This is not doable using the current OPP API, it doesn't allow to re-use initialized OPP table. The current limitation is okay because genpd core doesn't call routine anytime.

> I did have a look at the comment you added above regarding
> devm_tegra_core_dev_init_opp_table(), but I am not sure of the series
> of events right now. For me, the OPP table should just be added once
> and for ever. You shouldn't remove and add it again. That is bound to
> break somewhere later.

I see that the comment about devm_tegra_core_dev_init_opp_table() is outdated now, will update it. There was a refcounting bug in v9 where I accidentally used devm_pm_opp_of_add_table instead of dev_, still it fails similarly, but in a different place now. 

> Can you give the sequence in which the whole thing works out with
> respect to the OPP core? who calls
> devm_tegra_core_dev_init_opp_table() and when, and when exactly will
> this routine get called, etc ?
> 

gr3d_probe(struct platform_device *pdev)
{
	gr3d_init_power(dev)
	{
		static const char * const opp_genpd_names[] = { "3d0", "3d1", NULL };

		devm_pm_opp_attach_genpd(dev, opp_genpd_names)
		{
			dev_pm_opp_attach_genpd(dev, names, virt_devs)
			{
				// takes and holds table reference
				opp_table = _add_opp_table(dev, false);

				while (*name) {
					// first attachment succeeds, 
					// second fails with "tegra-gr3d 54180000.gr3d: failed to set OPP clk: -EBUSY"
					dev_pm_domain_attach_by_name(dev, *name)
					{
						tegra_pmc_pd_dev_get_performance_state(dev)
						{
							dev_pm_opp_set_clkname(dev, NULL);
							dev_pm_opp_of_add_table(dev);
							opp = dev_pm_opp_get_current(dev);
							dev_pm_opp_of_remove_table(dev);
							dev_pm_opp_put_clkname(opp_table);
							...
						}
						// opp_table->clk = ERR_PTR(-EINVAL) after the first attachment
					}
				}
			}
		}
	}

	devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);

	return 0;
}


WARNING: CPU: 3 PID: 7 at drivers/opp/core.c:2151 dev_pm_opp_set_clkname+0x97/0xb8
Modules linked in:
CPU: 3 PID: 7 Comm: kworker/u8:0 Tainted: G        W         5.14.0-next-20210831-00177-g6850c69f8c92-dirty #9371
Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
[<c010cc91>] (unwind_backtrace) from [<c0108d35>] (show_stack+0x11/0x14)
[<c0108d35>] (show_stack) from [<c0a6e25d>] (dump_stack_lvl+0x2b/0x34)
[<c0a6e25d>] (dump_stack_lvl) from [<c011fc7f>] (__warn+0xbb/0x100)
[<c011fc7f>] (__warn) from [<c0a6b783>] (warn_slowpath_fmt+0x4b/0x80)
[<c0a6b783>] (warn_slowpath_fmt) from [<c0742613>] (dev_pm_opp_set_clkname+0x97/0xb8)
[<c0742613>] (dev_pm_opp_set_clkname) from [<c0509815>] (tegra_pmc_pd_dev_get_performance_state+0x85/0x120)
[<c0509815>] (tegra_pmc_pd_dev_get_performance_state) from [<c05cd3db>] (__genpd_dev_pm_attach+0xe7/0x218)
[<c05cd3db>] (__genpd_dev_pm_attach) from [<c05cd5d3>] (genpd_dev_pm_attach_by_id+0x8b/0xec)
[<c05cd5d3>] (genpd_dev_pm_attach_by_id) from [<c074287f>] (dev_pm_opp_attach_genpd+0x97/0x11c)
[<c074287f>] (dev_pm_opp_attach_genpd) from [<c0742913>] (devm_pm_opp_attach_genpd+0xf/0x6c)
[<c0742913>] (devm_pm_opp_attach_genpd) from [<c05ac7a5>] (gr3d_probe+0x245/0x348)
[<c05ac7a5>] (gr3d_probe) from [<c05bc003>] (platform_probe+0x43/0x84)
[<c05bc003>] (platform_probe) from [<c05ba569>] (really_probe.part.0+0x69/0x200)
[<c05ba569>] (really_probe.part.0) from [<c05ba773>] (__driver_probe_device+0x73/0xd4)
[<c05ba773>] (__driver_probe_device) from [<c05ba809>] (driver_probe_device+0x35/0xd0)
[<c05ba809>] (driver_probe_device) from [<c05bac11>] (__device_attach_driver+0x75/0x98)
[<c05bac11>] (__device_attach_driver) from [<c05b9005>] (bus_for_each_drv+0x51/0x7c)
[<c05b9005>] (bus_for_each_drv) from [<c05ba9f7>] (__device_attach+0x8b/0x104)
[<c05ba9f7>] (__device_attach) from [<c05b9b1b>] (bus_probe_device+0x5b/0x60)
[<c05b9b1b>] (bus_probe_device) from [<c05b7707>] (device_add+0x293/0x65c)
[<c05b7707>] (device_add) from [<c07798b7>] (of_platform_device_create_pdata+0x63/0x88)
[<c07798b7>] (of_platform_device_create_pdata) from [<c07799e5>] (of_platform_bus_create+0xfd/0x26c)
[<c07799e5>] (of_platform_bus_create) from [<c0779c2d>] (of_platform_populate+0x45/0x84)
[<c0779c2d>] (of_platform_populate) from [<c0779cc5>] (devm_of_platform_populate+0x41/0x6c)
[<c0779cc5>] (devm_of_platform_populate) from [<c054aa65>] (host1x_probe+0x1e9/0x2c8)
[<c054aa65>] (host1x_probe) from [<c05bc003>] (platform_probe+0x43/0x84)
[<c05bc003>] (platform_probe) from [<c05ba569>] (really_probe.part.0+0x69/0x200)
[<c05ba569>] (really_probe.part.0) from [<c05ba773>] (__driver_probe_device+0x73/0xd4)
[<c05ba773>] (__driver_probe_device) from [<c05ba809>] (driver_probe_device+0x35/0xd0)
[<c05ba809>] (driver_probe_device) from [<c05bac11>] (__device_attach_driver+0x75/0x98)
[<c05bac11>] (__device_attach_driver) from [<c05b9005>] (bus_for_each_drv+0x51/0x7c)
[<c05b9005>] (bus_for_each_drv) from [<c05ba9f7>] (__device_attach+0x8b/0x104)
[<c05ba9f7>] (__device_attach) from [<c05b9b1b>] (bus_probe_device+0x5b/0x60)
[<c05b9b1b>] (bus_probe_device) from [<c05b9dfb>] (deferred_probe_work_func+0x57/0x78)
[<c05b9dfb>] (deferred_probe_work_func) from [<c013701f>] (process_one_work+0x147/0x3f8)
[<c013701f>] (process_one_work) from [<c0137805>] (worker_thread+0x21d/0x3f4)
[<c0137805>] (worker_thread) from [<c013c1bb>] (kthread+0x123/0x140)
[<c013c1bb>] (kthread) from [<c0100135>] (ret_from_fork+0x11/0x1c)
Exception stack(0xc1567fb0 to 0xc1567ff8)
---[ end trace f68728a0d3053b54 ]---
tegra-gr3d 54180000.gr3d: failed to set OPP clk: -EBUSY
genpd genpd:1:54180000.gr3d: failed to get performance state of 54180000.gr3d for power-domain 3d1: -16
tegra-gr3d 54180000.gr3d: Couldn't attach to pm_domain: -16
