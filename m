Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C53286820
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 19:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404340AbfHHRcf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 13:32:35 -0400
Received: from foss.arm.com ([217.140.110.172]:36710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404276AbfHHRcf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 13:32:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D55A015A2;
        Thu,  8 Aug 2019 10:32:34 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D17483F575;
        Thu,  8 Aug 2019 10:32:33 -0700 (PDT)
Date:   Thu, 8 Aug 2019 18:32:32 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, agross@kernel.org
Subject: Re: [PATCH 1/2] cpufreq: drivers: Enable frequency invariance in
 qcom-cpufreq-hw
Message-ID: <20190808173230.53ddupihjlr6uvne@queper01-lin>
References: <20190808131857.21082-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808131857.21082-1-douglas.raillard@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Douglas,

On Thursday 08 Aug 2019 at 14:18:57 (+0100), Douglas RAILLARD wrote:
> Add calls to arch_set_freq_scale() in qcom-cpufreq-hw driver to enable
> frequency invariance.

Is there a patch 2/2 ?

> 
> Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 4b0b50403901..3bd3b8b268d9 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -34,9 +34,12 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>  					unsigned int index)
>  {
>  	void __iomem *perf_state_reg = policy->driver_data;
> +	unsigned long freq = policy->freq_table[index].frequency;
>  
>  	writel_relaxed(index, perf_state_reg);
>  
> +	arch_set_freq_scale(policy->related_cpus, freq,
> +			    policy->cpuinfo.max_freq);
>  	return 0;
>  }
>  
> @@ -63,6 +66,7 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>  {
>  	void __iomem *perf_state_reg = policy->driver_data;
>  	int index;
> +	unsigned long freq;
>  
>  	index = policy->cached_resolved_idx;
>  	if (index < 0)
> @@ -70,7 +74,11 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>  
>  	writel_relaxed(index, perf_state_reg);
>  
> -	return policy->freq_table[index].frequency;
> +	freq = policy->freq_table[index].frequency;
> +	arch_set_freq_scale(policy->related_cpus, freq,
> +			    policy->cpuinfo.max_freq);
> +
> +	return freq;
>  }
>  
>  static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
> -- 
> 2.22.0

Reviewed-by: Quentin Perret <quentin.perret@arm.com>

Thanks,
Quentin
