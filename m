Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2371815BE26
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 13:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgBMMAD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 07:00:03 -0500
Received: from foss.arm.com ([217.140.110.172]:45610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgBMMAD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 07:00:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB8D61FB;
        Thu, 13 Feb 2020 04:00:02 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1AA03F6CF;
        Thu, 13 Feb 2020 04:00:00 -0800 (PST)
Subject: Re: [PATCH v3 5/7] cpufreq: add function to get the hardware max
 frequency
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com, lukasz.luba@arm.com,
        rjw@rjwysocki.net
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-6-ionela.voinescu@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <b63a4a47-99e5-9c71-73be-740aedde4714@arm.com>
Date:   Thu, 13 Feb 2020 11:59:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211184542.29585-6-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/11/20 6:45 PM, Ionela Voinescu wrote:
> +/**
> + * cpufreq_get_hw_max_freq - get the max hardware frequency of the CPU
> + * @cpu: CPU number
> + *
> + * The default return value is the max_freq field of cpuinfo.
> + */
> +__weak unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	unsigned int ret_freq = 0;
> +
> +	if (policy) {
> +		ret_freq = policy->cpuinfo.max_freq;
> +		cpufreq_cpu_put(policy);

What about intel_pstate / turbo stuff? IIRC one of Giovanni's issues was that
turbo freq is not always reported as the max freq. Dunno if we can do
anything about it; at the very least maybe document the caveat?

> +	}
> +
> +	return ret_freq;
> +}
> +EXPORT_SYMBOL(cpufreq_get_hw_max_freq);
> +
>  static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
>  {
>  	if (unlikely(policy_is_inactive(policy)))

