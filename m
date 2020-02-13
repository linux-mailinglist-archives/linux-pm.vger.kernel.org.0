Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95115BBF9
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 10:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgBMJrH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 04:47:07 -0500
Received: from foss.arm.com ([217.140.110.172]:44026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbgBMJrG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 04:47:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0132A1FB;
        Thu, 13 Feb 2020 01:47:05 -0800 (PST)
Received: from localhost (unknown [10.1.198.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 959CF3F6CF;
        Thu, 13 Feb 2020 01:47:05 -0800 (PST)
Date:   Thu, 13 Feb 2020 09:47:04 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        valentin.schneider@arm.com, rjw@rjwysocki.net,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/7] arm64: use activity monitors for frequency
 invariance
Message-ID: <20200213094704.GA30335@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-7-ionela.voinescu@arm.com>
 <a63fd15f-f02d-6afe-6e1f-817b9eb452d1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63fd15f-f02d-6afe-6e1f-817b9eb452d1@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

[..]
> > +
> > +/* Obtain max frequency (in KHz) as reported by hardware */
> > +__weak unsigned int cpu_get_max_freq(unsigned int cpu)
> > +{
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_CPU_FREQ
> > +/* Replace max frequency getter with cpufreq based function */
> > +#define cpu_get_max_freq cpufreq_get_hw_max_freq
> > +#endif
> 
> Can we just use cpufreq_get_hw_max_freq()?
> We have cpufreq_get_hw_max_freq returning 0 in such case, so it should
> be OK.
> 

The reasoning for the implementation is the following:
 - For CONFIG_CPU_FREQ we use cpufreq_get_hw_max_freq (weak default or
   strong alternative)
 - For !CONFIG_CPU_FREQ cpufreq_get_hw_max_freq returns 0 - it signals
   that cpufreq cannot return the hardware max frequency. In this case
   cpu_get_max_freq is used (weak default or strong alternative
   implementation).

> Is there a possibility that some platform which has !CONFIG_CPU_FREQ
> would define its own cpu_get_max_freq() overwriting the weak function
> above?
> Based on the code which checks 'if (unlikely(!max_freq_hz))' it should,
> otherwise 'valid_cpus' is not set.
> 
> I would assume that we won't see such platform, interested
> in AMU freq invariance without CONFIG_CPU_FREQ.
> 
> We already have a lot of these defines or __weak functions, which is
> hard to follow.

There is no dependency between CONFIG_CPU_FREQ and frequency invariance.
Therefore, I did not see a reason to potentially bypass the use of AMU
for frequency invariance for !CONFIG_CPU_FREQ.

But I agree it makes the code harder to read so I can remove
cpu_get_max_freq and keep cpufreq_get_hw_max_freq only until there is a
provable need for this. 

Thank you for the review,
Ionela.
