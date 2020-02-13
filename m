Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D509615BED7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 13:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgBMM7V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 07:59:21 -0500
Received: from foss.arm.com ([217.140.110.172]:46336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMM7V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 07:59:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B69091FB;
        Thu, 13 Feb 2020 04:59:20 -0800 (PST)
Received: from localhost (unknown [10.1.198.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 580063F6CF;
        Thu, 13 Feb 2020 04:59:20 -0800 (PST)
Date:   Thu, 13 Feb 2020 12:59:18 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, rjw@rjwysocki.net, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/7] cpufreq: add function to get the hardware max
 frequency
Message-ID: <20200213125918.GA2397@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-6-ionela.voinescu@arm.com>
 <b63a4a47-99e5-9c71-73be-740aedde4714@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b63a4a47-99e5-9c71-73be-740aedde4714@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 13 Feb 2020 at 11:59:56 (+0000), Valentin Schneider wrote:
> On 2/11/20 6:45 PM, Ionela Voinescu wrote:
> > +/**
> > + * cpufreq_get_hw_max_freq - get the max hardware frequency of the CPU
> > + * @cpu: CPU number
> > + *
> > + * The default return value is the max_freq field of cpuinfo.
> > + */
> > +__weak unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
> > +{
> > +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > +	unsigned int ret_freq = 0;
> > +
> > +	if (policy) {
> > +		ret_freq = policy->cpuinfo.max_freq;
> > +		cpufreq_cpu_put(policy);
> 
> What about intel_pstate / turbo stuff? IIRC one of Giovanni's issues was that
> turbo freq is not always reported as the max freq. Dunno if we can do
> anything about it; at the very least maybe document the caveat?
>

Okay, I can add details in the description in regards to potential
reasons to overwrite this function. But basically this is one of the
reasons for making this a weak function. The best information we can
generically get for maximum hardware frequency is cpuinfo.max_freq.
But if platforms have the possibility to obtain this differently from
either hardware or firmware they can overwrite this.

Thanks,
Ionela.

> > +	}
> > +
> > +	return ret_freq;
> > +}
> > +EXPORT_SYMBOL(cpufreq_get_hw_max_freq);
> > +
> >  static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
> >  {
> >  	if (unlikely(policy_is_inactive(policy)))
> 
