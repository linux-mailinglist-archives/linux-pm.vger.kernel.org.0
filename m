Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC04D3B1B78
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFWNrx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 09:47:53 -0400
Received: from foss.arm.com ([217.140.110.172]:35602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230206AbhFWNrx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Jun 2021 09:47:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7666ED1;
        Wed, 23 Jun 2021 06:45:35 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 482B93F718;
        Wed, 23 Jun 2021 06:45:35 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:45:33 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/4] cpufreq: cppc: Pass structure instance by
 reference
Message-ID: <20210623134533.GB12411@arm.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <b910f89cf11f6916319f9a2fb48d9146005318b1.1624266901.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b910f89cf11f6916319f9a2fb48d9146005318b1.1624266901.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 21 Jun 2021 at 14:49:35 (+0530), Viresh Kumar wrote:
> Don't pass structure instance by value, pass it by reference instead.
>

Might be best to justify the change a bit :)

For me this is a judgement call, and I don't really see the reasons for
changing it: we don't care if the structure is modified or not, as we're
not reusing the data after the call to cppc_get_rate_from_fbctrs().
More so, in this scenario we might not even want for the called function
to modify the counter values. Also there is no further call to a function
in cppc_get_rate_from_fbctrs(), that might require references to the
fb_ctrs.

So what is the reason behind this change?

Thanks,
Ionela.


> Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 35b8ae66d1fb..490175d65082 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -373,18 +373,18 @@ static inline u64 get_delta(u64 t1, u64 t0)
>  }
>  
>  static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
> -				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
> -				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +				     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> +				     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
>  {
>  	u64 delta_reference, delta_delivered;
>  	u64 reference_perf, delivered_perf;
>  
> -	reference_perf = fb_ctrs_t0.reference_perf;
> +	reference_perf = fb_ctrs_t0->reference_perf;
>  
> -	delta_reference = get_delta(fb_ctrs_t1.reference,
> -				    fb_ctrs_t0.reference);
> -	delta_delivered = get_delta(fb_ctrs_t1.delivered,
> -				    fb_ctrs_t0.delivered);
> +	delta_reference = get_delta(fb_ctrs_t1->reference,
> +				    fb_ctrs_t0->reference);
> +	delta_delivered = get_delta(fb_ctrs_t1->delivered,
> +				    fb_ctrs_t0->delivered);
>  
>  	/* Check to avoid divide-by zero */
>  	if (delta_reference || delta_delivered)
> @@ -415,7 +415,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  	if (ret)
>  		return ret;
>  
> -	return cppc_get_rate_from_fbctrs(cpu_data, fb_ctrs_t0, fb_ctrs_t1);
> +	return cppc_get_rate_from_fbctrs(cpu_data, &fb_ctrs_t0, &fb_ctrs_t1);
>  }
>  
>  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> -- 
> 2.31.1.272.g89b43f80a514
> 
