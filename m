Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14732F2DBC
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 12:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbhALLSB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 06:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbhALLSA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 06:18:00 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A29C061786
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 03:17:20 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id z21so1233823pgj.4
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 03:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7OWv2YkaYqhwmXvx21JA1emGZWXTkIaczduzwJgcCL8=;
        b=yz3ZcF+pqLzbiaAsUOgc8E/dlkS+5jrT61jjy348VyQ/TdBQQsk+kOkhyAD9+8n7jw
         PfRf0xMK5hrUiobQHJcCGnHI3gS5GEkvwjdqgFY64LN3wEex1siz104DStUWC0J6VQ7M
         bIBNcrgRVdrjLLuoPJrOhXSs6m+tLQJ7XLQQPv9fgsp4VC5Q7z7EOjAKOCD0sbyrcvdk
         kVR7odrMrz1QbcryOoEFK/wWc/4BdmzWKDrFx2DGy0irpHwMs1L8mkR0UKdK0AJJcXGO
         dVLHnCnTiD/PRlkv1tkaHngEEhxBMufd0GVcXNFomqFIgbMAhD2WK62oeQxo6NQtrH2f
         3IJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7OWv2YkaYqhwmXvx21JA1emGZWXTkIaczduzwJgcCL8=;
        b=maqpkK0LbROQYuM10WMCf74S4MjE+D4StWGbkq5Fa3oKimLzGAtVQrOZCUJJnsVZMR
         KlzVmnGOGjyOUxPPeOowK2T6oFDhIvTEtytRcqynkwV0vJI8GdhqN8qf6012JlVvjyim
         pm4CjhR+phQWBgS9wSei0wrHOWpo+Wk4fJTm0/JVRCakaTIBbDANLu6V1oqhW1n8t/sM
         xp1IlcOmP5KNKDATl1IyzIQTHsWxRd4CUpRKyCEtjPXrdaThgmDpU+2av3+JuTowBO2K
         qffCqSb9NixqTTV60XTBsZVPPh60gViW4II55FMI+6wXczED8K1CPIcck9KBFJRVChnZ
         aTVw==
X-Gm-Message-State: AOAM531cAF/9SLDOl4IeD8mtNepiV1oBO8fCA/TihS5CnnXj3fikNv0d
        LTv9JEnFfG1kCTwW01kolHiAag==
X-Google-Smtp-Source: ABdhPJyqQ+KEQ/SFEcJbtDdZSkJgGwI8qTsVhV202UlIvyP5md9yUQspTOpH2XtnP5f7DOklNjs6MQ==
X-Received: by 2002:a63:4e44:: with SMTP id o4mr4338735pgl.46.1610450239790;
        Tue, 12 Jan 2021 03:17:19 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id gl21sm2807173pjb.0.2021.01.12.03.17.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 03:17:19 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:47:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com
Subject: Re: [PATCH v6 2/4] scmi-cpufreq: Move CPU initialisation to probe
Message-ID: <20210112111717.5ds446w2kroxzvhr@vireshk-i7>
References: <20210111154524.20196-1-nicola.mazzucato@arm.com>
 <20210111154524.20196-3-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111154524.20196-3-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-01-21, 15:45, Nicola Mazzucato wrote:
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> +static int scmi_init_cpudata(void)
> +{
> +	int cpu;
> +	unsigned int ncpus = num_possible_cpus();
> +
> +	cpudata_table = kzalloc(sizeof(*cpudata_table) * ncpus, GFP_KERNEL);
> +	if (!cpudata_table)
> +		return -ENOMEM;

This could have been done with a per-cpu variable instead.

> +	for_each_possible_cpu(cpu) {
> +		if (!zalloc_cpumask_var(&cpudata_table[cpu].scmi_shared_cpus,
> +					GFP_KERNEL))
> +			goto out;
> +	}

You are making a copy of the struct for each CPU and so for a 16 CPUs
sharing their clock lines, you will have 16 copies of the exact same
stuff.

An optimal approach would be to have a linked-list of this structure
and that will only have 1 node per cpufreq policy.

> +	return 0;
> +
> +out:
> +	kfree(cpudata_table);
> +	return -ENOMEM;
> +}
> +
> +static int scmi_init_device(const struct scmi_handle *handle, int cpu)
> +{
> +	struct device *cpu_dev;
> +	int ret, nr_opp;
> +	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
> +	bool power_scale_mw;
> +	cpumask_var_t scmi_cpus;
> +
> +	if (!zalloc_cpumask_var(&scmi_cpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	cpumask_set_cpu(cpu, scmi_cpus);
> +
> +	cpu_dev = get_cpu_device(cpu);
> +
> +	ret = scmi_get_sharing_cpus(cpu_dev, scmi_cpus);

Where do you expect the sharing information to come from in this case
? DT ?

> +	if (ret) {
> +		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
> +		goto free_cpumask;
> +	}
> +
> +	/*
> +	 * We get here for each CPU. Add OPPs only on those CPUs for which we
> +	 * haven't already done so, or set their OPPs as shared.
> +	 */
> +	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (nr_opp <= 0) {
> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
> +		if (ret) {
> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
> +			goto free_cpumask;
> +		}
> +
> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, scmi_cpus);
> +		if (ret) {
> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
> +				__func__, ret);
> +			goto free_cpumask;
> +		}
> +
> +		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);

Shouldn't you do this just after adding the OPPs ?

> +		if (nr_opp <= 0) {
> +			dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
> +				__func__, ret);
> +
> +			ret = -ENODEV;
> +			goto free_cpumask;
> +		}
> +
> +		power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
> +		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, scmi_cpus,
> +					    power_scale_mw);
> +	}
> +
> +	ret = dev_pm_opp_init_cpufreq_table(cpu_dev,
> +					    &cpudata_table[cpu].freq_table);
> +	if (ret) {
> +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> +		goto free_cpumask;
> +	}
> +
> +	cpumask_copy(cpudata_table[cpu].scmi_shared_cpus, scmi_cpus);
> +
> +free_cpumask:
> +	free_cpumask_var(scmi_cpus);
> +	return ret;
> +}
> +
>  static int scmi_cpufreq_probe(struct scmi_device *sdev)
>  {
>  	int ret;
>  	struct device *dev = &sdev->dev;
> +	int cpu;
> +	struct device *cpu_dev;

Please keep the list of local variable in decreasing order of their
length, many people including me prefer it that way.

>  
>  	handle = sdev->handle;
>  
> @@ -247,6 +305,24 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>  		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
>  #endif
>  
> +	ret = scmi_init_cpudata();
> +	if (ret) {
> +		pr_err("%s: init cpu data failed\n", __func__);
> +		return ret;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_dev = get_cpu_device(cpu);
> +
> +		ret = scmi_init_device(handle, cpu);
> +		if (ret) {
> +			dev_err(cpu_dev, "%s: init device failed\n",
> +				__func__);
> +
> +			return ret;

You missed undoing scmi_init_cpudata().

> +		}
> +	}
> +
>  	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
>  	if (ret) {
>  		dev_err(dev, "%s: registering cpufreq failed, err: %d\n",
> @@ -258,6 +334,20 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>  
>  static void scmi_cpufreq_remove(struct scmi_device *sdev)
>  {
> +	int cpu;
> +	struct device *cpu_dev;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_dev = get_cpu_device(cpu);
> +
> +		dev_pm_opp_free_cpufreq_table(cpu_dev,
> +					      &cpudata_table[cpu].freq_table);
> +
> +		free_cpumask_var(cpudata_table[cpu].scmi_shared_cpus);
> +	}
> +
> +	kfree(cpudata_table);
> +
>  	cpufreq_unregister_driver(&scmi_cpufreq_driver);
>  }
>  
> -- 
> 2.27.0

-- 
viresh
