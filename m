Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493A415F083
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 18:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbgBNP5r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 10:57:47 -0500
Received: from foss.arm.com ([217.140.110.172]:35872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388237AbgBNP5r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Feb 2020 10:57:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E40D328;
        Fri, 14 Feb 2020 07:57:46 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3AAF3F68E;
        Fri, 14 Feb 2020 07:57:45 -0800 (PST)
Date:   Fri, 14 Feb 2020 15:57:44 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com, rjw@rjwysocki.net,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 7/7] clocksource/drivers/arm_arch_timer: validate
 arch_timer_rate
Message-ID: <20200214155744.GA8784@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-8-ionela.voinescu@arm.com>
 <87mu9mgg41.fsf@nanos.tec.linutronix.de>
 <20200214154525.GA21875@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200214154525.GA21875@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 14 Feb 2020 at 15:45:25 (+0000), Ionela Voinescu wrote:
> Hi Thomas,
> 
> On Friday 14 Feb 2020 at 01:35:58 (+0100), Thomas Gleixner wrote:
> > Ionela Voinescu <ionela.voinescu@arm.com> writes:
> > 
> > > From: Valentin Schneider <valentin.schneider@arm.com>
> > >
> > > Using an arch timer with a frequency of less than 1MHz can result in an
> > > incorrect functionality of the system which assumes a reasonable rate.
> > >
> > > One example is the use of activity monitors for frequency invariance
> > > which uses the rate of the arch timer as the known rate of the constant
> > > cycle counter in computing its ratio compared to the maximum frequency
> > > of a CPU. For arch timer frequencies less than 1MHz this ratio could
> > > end up being 0 which is an invalid value for its use.
> > >
> > > Therefore, warn if the arch timer rate is below 1MHz which contravenes
> > > the recommended architecture interval of 1 to 50MHz.
> > >
> > > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > 
> > So this patch is from Valentin. Where is his Signed-off-by?
> > 
> 
> Yes, sorry about this. This was based on a diff that Valentin provided
> in v2. I'll change the author as agreed at:
> https://lore.kernel.org/lkml/20200212103249.GA19041@arm.com/
> 
> > >  
> > > +static int validate_timer_rate(void)
> > > +{
> > > +	if (!arch_timer_rate)
> > > +		return -EINVAL;
> > > +
> > > +	/* Arch timer frequency < 1MHz can cause trouble */
> > > +	WARN_ON(arch_timer_rate < 1000000);
> > 
> > This does not make sense to me. If the rate is out of bounds then why
> > warn an just continue instead of making it fail?
> > 
> 
> Because it's not a hard restriction, it's just atypical for the rate to
> be below 1Mhz. The spec only mentions a typical range of 1 to 50MHz and
> the warning is only here to flag a potentially problematic rate, below
> what is assumed typical in the spec.
> 
> In [1], where I'm actually relying on arch_timer_rate being higher than
> than 1/SCHED_CAPACITY_SCALE² of the maximum frequency, I am making it
> fail, as, for that scenario, it is a hard restriction.
> 
> 
> +	 * We use a factor of 2 * SCHED_CAPACITY_SHIFT -> SCHED_CAPACITY_SCALE²
> +	 * in order to ensure a good resolution for arch_max_freq_scale for
> +	 * very low arch timer frequencies (up to the KHz range which should be
> +	 * unlikely).
> +	 */
> +	ratio = (u64)arch_timer_get_rate() << (2 * SCHED_CAPACITY_SHIFT);
> +	ratio = div64_u64(ratio, max_freq_hz);
> +	if (!ratio) {
> +		pr_err("System timer frequency too low.\n");
> +		return -EINVAL;
> +	}
> +
> 
> [1] https://lore.kernel.org/lkml/89339501-5ee4-e871-3076-c8b02c6fbf6e@arm.com/

I've mistakenly referenced a bad link ^

It was supposed to be:

[1] https://lore.kernel.org/lkml/20200211184542.29585-7-ionela.voinescu@arm.com/

Thanks,
Ionela.
