Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A82AD4D4
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 12:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgKJLYR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 06:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJLYR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 06:24:17 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4F1C0613CF
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 03:24:16 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id z1so6315839plo.12
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 03:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HO5lCYasya6BtO7Xrcl+eZJ/pZ5/4UoJjPNF3XjKirk=;
        b=m9HT50bTwMn5meA26x9DDKEmumqgNrZdK+rG4MpmF5VSZWMwHNgPJFulBUgkjlxEwO
         YrnmQXolwPX/FyC4nwb8YaL9Pdahhmf2014y2SlEgW5evfdnhbFPZTwPcDbvCdDTg+/R
         ORBSUJWd216SBL3Emb5xa7Bt/0aYEtkghxKm7DRztHA5uEOg+7tJ0qFFGCaTyuvmr+vV
         38qmQmuaMlZ1c4IziuP+/D+7IPfHZhaPg6QrLDO9T7TlxtPSO7K3YQB2BaK1bmNMBKIc
         NKBO0fZWv7Mz4kF8HtT91D/BzUo7+onA4oueyKVnvGdU7R/z2xzwieXXRwtolFHqdt56
         dADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HO5lCYasya6BtO7Xrcl+eZJ/pZ5/4UoJjPNF3XjKirk=;
        b=teASowFZ0ZO/7QhY2gTXRFbQP6hUdxKgEf004lIu9oN2qhhB6NqQCnxFvMqNJLY003
         s2qSBrfQh/CfmyU1NRpzT05pd2wohs6SQrmOIJS99rSvb0gW+NqsS2aIulzAze+05t/u
         MIFPvdQMdXnVh0eGEaft0ay1jJStSSMwxCid3hhpbGvxvKpFXQUmXLyVkp56tFLnA+C9
         tnBxGkus4tozE4gTm5t1V7dB5Z2s01hqa05Ulv7UZuqhhMIaPuMRWKzAVF/ZNaJmEde7
         ga6Uo9y8pzcXjApyaj1584nYVCmtdZA+9GWjHRND4l2ZASKK/1ai58Vw1JU5XjhlpD/b
         Bxpg==
X-Gm-Message-State: AOAM531UNTl1U4cxNcLcKMLUB0WlvuYzBgmVozjQZUNrHtNFI31RgErc
        3ictrwXdCjlzxUCFFIbYL2w7SQ==
X-Google-Smtp-Source: ABdhPJxusfnlL16D3/1OrIUvIjVVhEnAMa1l/9bgXS7Ehwawf48Pxgw66eU/x55cq/trQaW4Z4uQPA==
X-Received: by 2002:a17:902:a503:b029:d6:d9d:f901 with SMTP id s3-20020a170902a503b02900d60d9df901mr12379307plq.54.1605007456382;
        Tue, 10 Nov 2020 03:24:16 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id m3sm14499363pfd.217.2020.11.10.03.24.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 03:24:15 -0800 (PST)
Date:   Tue, 10 Nov 2020 16:54:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: scmi: Fix OPP addition failure with a dummy
 clock provider
Message-ID: <20201110112414.abrqtf4v76sth54m@vireshk-i7>
References: <20201110111040.280231-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110111040.280231-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-11-20, 11:10, Sudeep Holla wrote:
> Commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
> -EPROBE_DEFER") handles -EPROBE_DEFER for the clock/interconnects within
> _allocate_opp_table() which is called from dev_pm_opp_add and it
> now propagates the error back to the caller.
> 
> SCMI performance domain re-used clock bindings to keep it simple. However
> with the above mentioned change, if clock property is present in a device
> node, opps fails to get added with below errors until clk_get succeeds.
> 
>  cpu0: failed to add opp 450000000Hz
>  cpu0: failed to add opps to the device
>  ....(errors on cpu1-cpu4)
>  cpu5: failed to add opp 450000000Hz
>  cpu5: failed to add opps to the device
> 
> So, in order to fix the issue, we need to register dummy clock provider.
> With the dummy clock provider, clk_get returns NULL(no errors!), then opp
> core proceeds to add OPPs for the CPUs.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index e855e8612a67..78318508a6d6 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -8,6 +8,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/clk-provider.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> @@ -228,12 +229,17 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
>  static int scmi_cpufreq_probe(struct scmi_device *sdev)
>  {
>  	int ret;
> +	struct device *dev = &sdev->dev;
>  
>  	handle = sdev->handle;
>  
>  	if (!handle || !handle->perf_ops)
>  		return -ENODEV;
>  
> +	/* dummy clock provider as needed by OPP if clocks property is used */
> +	if (of_find_property(dev->of_node, "#clock-cells", NULL))
> +		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
> +
>  	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
>  	if (ret) {
>  		dev_err(&sdev->dev, "%s: registering cpufreq failed, err: %d\n",

For 5.10-rc.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
