Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F603FD3B0
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 08:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242270AbhIAGLu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 02:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242085AbhIAGLt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 02:11:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5F2C061575
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 23:10:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso844017pjb.3
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 23:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T2s6fTWRjJME7M57wIdDOR9lIU30XX+lPF7tqBUNlAA=;
        b=pfr7Hz/SBkvLlbVtO82Qcn4fXrEVjzqQI7mux3upCgMYcbhcpPG2dQj04WuKBPTKsu
         TINRQkVJ41dLo/O/zNycG10YiXm7bWbChGJVV5cfW/JHNkMVq5mtnSB8TksvCWhjlCEd
         B6cduycBl8OVFsNOKlbOzCGcRT+0eogqdx0CeorScgIgTvLlrzKG6nlEy7XyvGUM83wO
         xhtI0ZExTh57hi4hmBa8Nj65k0c/+O74wkLqKx4kucku5jlW2CpG8uOxRffWNsiHU6XK
         VOptubWZdcwI4iQw4ZjfTxhzUrdh+9AQiNAQdpEPG4Z/sEiDgCITfBWTC0svTsOMNYHv
         7TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T2s6fTWRjJME7M57wIdDOR9lIU30XX+lPF7tqBUNlAA=;
        b=O98mhEUyY7KdNr1MCO5o9se5zJLlI8NKB6i7Tx0z+MHWm6fDhlNVa1W1e2b/pU/iaB
         xLPsOy6HAyY7vXvwtECTDxAulxKuTl40g/gULx3cVhIFY5138cJ23qF2qg0EP1OQZd1k
         zihL3+8j/gU+IhpubSsHxAabLvUAUQE34JOiBEoF7ZAMtwykFcuMV/z1OFI007LI9O0l
         ldmbQ7HrGsh+2V5ZWqx5eC+3yz/uGb7S4qrn5NyJezjCqMG5bFmdm9wkm56Avs34sj0e
         dTpmmnzy9uMzHRA7t3LApPzxyeJjhWcZ7GftnlIKn0wLiJjR9KpHNiluxa3xjxcOh6tv
         mvjQ==
X-Gm-Message-State: AOAM532XiWBYl4v5gkTtpi+H04U+1gu/EXJs35qxKIfYjHVHn7bzhy8A
        SJz9SMyKhHZm8xX38a+dm4YpHw==
X-Google-Smtp-Source: ABdhPJzYr4Az1i8yTvOF7mYtPhZLh+axmeWTIOheUlXsl+wRNp12kcSJcMw4ywV0tG0kFxyFsbaN5w==
X-Received: by 2002:a17:90a:1b67:: with SMTP id q94mr2586257pjq.99.1630476652757;
        Tue, 31 Aug 2021 23:10:52 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id gm5sm4849823pjb.32.2021.08.31.23.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 23:10:52 -0700 (PDT)
Date:   Wed, 1 Sep 2021 11:40:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 5/8] soc/tegra: pmc: Implement
 dev_get_performance_state() callback
Message-ID: <20210901061050.4x3t4cc434zdwx3a@vireshk-i7>
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831135450.26070-6-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-08-21, 16:54, Dmitry Osipenko wrote:
> +static int
> +tegra_pmc_pd_dev_get_performance_state(struct generic_pm_domain *genpd,
> +				       struct device *dev)
> +{
> +	struct opp_table *hw_opp_table, *clk_opp_table;
> +	struct dev_pm_opp *opp;
> +	u32 hw_version;
> +	int ret;
> +
> +	/*
> +	 * The EMC devices are a special case because we have a protection
> +	 * from non-EMC drivers getting clock handle before EMC driver is
> +	 * fully initialized.  The goal of the protection is to prevent
> +	 * devfreq driver from getting failures if it will try to change
> +	 * EMC clock rate until clock is fully initialized.  The EMC drivers
> +	 * will initialize the performance state by themselves.
> +	 *
> +	 * Display controller also is a special case because only controller
> +	 * driver could get the clock rate based on configuration of internal
> +	 * divider.
> +	 *
> +	 * Clock driver uses its own state syncing.
> +	 */
> +	if (of_device_compatible_match(dev->of_node, tegra_pd_no_perf_compats))
> +		return 0;
> +
> +	if (of_machine_is_compatible("nvidia,tegra20"))
> +		hw_version = BIT(tegra_sku_info.soc_process_id);
> +	else
> +		hw_version = BIT(tegra_sku_info.soc_speedo_id);
> +
> +	hw_opp_table = dev_pm_opp_set_supported_hw(dev, &hw_version, 1);
> +	if (IS_ERR(hw_opp_table)) {
> +		dev_err(dev, "failed to set OPP supported HW: %pe\n",
> +			hw_opp_table);
> +		return PTR_ERR(hw_opp_table);
> +	}
> +
> +	/*
> +	 * Older device-trees don't have OPPs, meanwhile drivers use
> +	 * dev_pm_opp_set_rate() and it requires OPP table to be set
> +	 * up using dev_pm_opp_set_clkname().
> +	 *
> +	 * The devm_tegra_core_dev_init_opp_table() is a common helper
> +	 * that sets up OPP table for Tegra drivers and it sets the clk
> +	 * for compatibility with older device-tress.  GR3D driver uses that
> +	 * helper, it also uses devm_pm_opp_attach_genpd() to manually attach
> +	 * power domains, which now holds the reference to OPP table that
> +	 * already has clk set up implicitly by OPP core for a newly created
> +	 * table using dev_pm_opp_of_add_table() invoked below.
> +	 *
> +	 * Hence we need to explicitly set/put the clk, otherwise
> +	 * further dev_pm_opp_set_clkname() will fail with -EBUSY.
> +	 */
> +	clk_opp_table = dev_pm_opp_set_clkname(dev, NULL);
> +	if (IS_ERR(clk_opp_table)) {
> +		dev_err(dev, "failed to set OPP clk: %pe\n", clk_opp_table);
> +		ret = PTR_ERR(clk_opp_table);
> +		goto put_hw;
> +	}
> +
> +	ret = dev_pm_opp_of_add_table(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to add OPP table: %d\n", ret);
> +		goto put_clk;
> +	}
> +
> +	opp = dev_pm_opp_get_current(dev);
> +	if (IS_ERR(opp)) {
> +		dev_err(dev, "failed to get current OPP: %pe\n", opp);
> +		ret = PTR_ERR(opp);
> +	} else {
> +		ret = dev_pm_opp_get_required_pstate(opp, 0);
> +		dev_pm_opp_put(opp);
> +	}
> +
> +	dev_pm_opp_of_remove_table(dev);
> +put_clk:
> +	dev_pm_opp_put_clkname(clk_opp_table);
> +put_hw:
> +	dev_pm_opp_put_supported_hw(hw_opp_table);

So you create the OPP table and just after that you remove it ? Just
to get the current OPP and pstate ? This doesn't look okay.

Moreover, this routine must be implemented with the expectation that
the genpd core can call it anytime it wants, not just at the
beginning. And so if the table is already setup by someone else then,
then this all will just fail.

I did have a look at the comment you added above regarding
devm_tegra_core_dev_init_opp_table(), but I am not sure of the series
of events right now. For me, the OPP table should just be added once
and for ever. You shouldn't remove and add it again. That is bound to
break somewhere later.

Can you give the sequence in which the whole thing works out with
respect to the OPP core? who calls
devm_tegra_core_dev_init_opp_table() and when, and when exactly will
this routine get called, etc ?

-- 
viresh
