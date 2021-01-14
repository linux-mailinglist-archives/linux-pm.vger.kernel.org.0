Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC62F5A2D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 06:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbhANFIh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 00:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbhANFIf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 00:08:35 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58079C061794
        for <linux-pm@vger.kernel.org>; Wed, 13 Jan 2021 21:07:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id j1so2328010pld.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Jan 2021 21:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ONs0rOwaXcE9DAa1rvPDB5tWp0t7wRodEsEfYtaFX4U=;
        b=rrbmMj05jKUSTp5pzhvdzZS9v9r7j/VNRbHFWCmkQzMRLD+1D6PnJqXzpwcQryCQ22
         5Ny97DeLbh83qPxO+6b5cM85pXBaplEYALjV8jDelrBFdPU+Ixr1u8HfkHd3N4/QVFVx
         NFJrFs8H4kCbmZVLmIfr5jkM42YshAKrJpVgi5lecYaMeVwoI2FZMUzYwC2QG7tDCx7c
         6WKXQLAGkD6eILucG7glvzDUUUkK9+ny/mg3nwDZGiTFpzHZmhIni4C6JObflybkQEcO
         3li4pdPMY/85tUZOey0S+V9tvmTJbpe5tGPJtJNfHYiPrGkv2/+fTucgHTg8TVwvJgFg
         0nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ONs0rOwaXcE9DAa1rvPDB5tWp0t7wRodEsEfYtaFX4U=;
        b=Yp6klWff+774248bIP3Fu95abO/zf1AS7HAqtAVC4QJhaXdFapoN1LRhTgnPf38SoY
         oR+Fq74tCVBl+oRL8UfYJ0I3glckkHa11Th7E09jWEJqaK+LWv2CLD+t3b3XwiHkGYFa
         bBuB2piZTG9VaJ4Ck1Pcf9AdDYu6t5/nUAr4/1IoK4dX222oD2b+73qwF8KcU+cDlPC6
         GY4CXDb/UFrdee/h0FXgW/Ggehr2m2X5ZluzEwo6hGMH091zsT2DFYymIMkxNtiFvDDL
         C1ypIuvV/zthOnbBqckOWef32rNlT0Bchmiy56gq9m+PUhpEdzcMUgbWzOe98NtVbfIa
         YeQQ==
X-Gm-Message-State: AOAM532Yklp8R1H01drsFrlvaBkCMOFhb14pJNsxNl/i35x4pUJbkKMo
        3Z6pjgMlPkFqVmEGPhu6ocJd8Q==
X-Google-Smtp-Source: ABdhPJzLCnG5kngXPNwign+9JLvSGPd6/XohzI50727mX+yBsG5y0q/E9Xn2Zf9/CSHXHUq6pv7WwA==
X-Received: by 2002:a17:903:2292:b029:de:45c0:7005 with SMTP id b18-20020a1709032292b02900de45c07005mr3164216plh.75.1610600875667;
        Wed, 13 Jan 2021 21:07:55 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id t4sm4008627pfe.212.2021.01.13.21.07.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2021 21:07:54 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:37:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com
Subject: Re: [PATCH v6 2/4] scmi-cpufreq: Move CPU initialisation to probe
Message-ID: <20210114050753.u3b5z6kgbup7xbuh@vireshk-i7>
References: <20210111154524.20196-1-nicola.mazzucato@arm.com>
 <20210111154524.20196-3-nicola.mazzucato@arm.com>
 <20210112111717.5ds446w2kroxzvhr@vireshk-i7>
 <d167e564-0f6a-4176-283b-8f92d224f537@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d167e564-0f6a-4176-283b-8f92d224f537@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-01-21, 11:55, Nicola Mazzucato wrote:
> On 1/12/21 11:17 AM, Viresh Kumar wrote:
> > This could have been done with a per-cpu variable instead.
> 
> sure, I can do a DEFINE_PER_CPU() for it if it makes it better.

If we don't go with the linked list approach, then yes.
 
> >> +	for_each_possible_cpu(cpu) {
> >> +		if (!zalloc_cpumask_var(&cpudata_table[cpu].scmi_shared_cpus,
> >> +					GFP_KERNEL))
> >> +			goto out;
> >> +	}
> > 
> > You are making a copy of the struct for each CPU and so for a 16 CPUs
> > sharing their clock lines, you will have 16 copies of the exact same
> > stuff.
> > 
> > An optimal approach would be to have a linked-list of this structure
> > and that will only have 1 node per cpufreq policy.
> 
> It is allocating space for the cpumask for each of the cpu. No data is copied yet.

Yes, I was talking about the whole design here.

> I understand the optimisation, but I don't see a linkage to cpufreq policy to be
> a good idea. This cpudata is for internal storage of scmi and opp-shared info
> and it is not tied to cpufreq policy.

Well, it is going to be the same information for all CPUs of a policy, isn't it
?

> We have moved all the cpu bits to probe
> and at this stage we have no knowledge of cpufreq polices.

Yes, but you are reading that information from scmi or DT (empty opp tables) and
so you know what the cpumasks are going to be set to. The linked list is the
right solution in my opinion, it is much more optimal.

> >> +static int scmi_init_device(const struct scmi_handle *handle, int cpu)
> >> +{
> >> +	struct device *cpu_dev;
> >> +	int ret, nr_opp;
> >> +	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
> >> +	bool power_scale_mw;
> >> +	cpumask_var_t scmi_cpus;
> >> +
> >> +	if (!zalloc_cpumask_var(&scmi_cpus, GFP_KERNEL))
> >> +		return -ENOMEM;
> >> +
> >> +	cpumask_set_cpu(cpu, scmi_cpus);
> >> +
> >> +	cpu_dev = get_cpu_device(cpu);
> >> +
> >> +	ret = scmi_get_sharing_cpus(cpu_dev, scmi_cpus);
> > 
> > Where do you expect the sharing information to come from in this case
> > ? DT ?
> 
> Coming from SCMI perf. The source of info has not changed.
> 
> > 
> >> +	if (ret) {
> >> +		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
> >> +		goto free_cpumask;
> >> +	}
> >> +
> >> +	/*
> >> +	 * We get here for each CPU. Add OPPs only on those CPUs for which we
> >> +	 * haven't already done so, or set their OPPs as shared.
> >> +	 */
> >> +	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
> >> +	if (nr_opp <= 0) {
> >> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
> >> +		if (ret) {
> >> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
> >> +			goto free_cpumask;
> >> +		}
> >> +
> >> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, scmi_cpus);
> >> +		if (ret) {
> >> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
> >> +				__func__, ret);
> >> +			goto free_cpumask;
> >> +		}
> >> +
> >> +		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
> > 
> > Shouldn't you do this just after adding the OPPs ?
> 
> This was suggested earlier. It was moved closer to em_registration to where the
> nr_opp is used. One way or the other as I don't have a strong preference for its
> place.

It is better to move it above as this will shorten the error path.

-- 
viresh
