Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4056D15A717
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgBLKy5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:54:57 -0500
Received: from foss.arm.com ([217.140.110.172]:59136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgBLKy5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 05:54:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 201F530E;
        Wed, 12 Feb 2020 02:54:56 -0800 (PST)
Received: from localhost (unknown [10.1.198.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B52ED3F68F;
        Wed, 12 Feb 2020 02:54:55 -0800 (PST)
Date:   Wed, 12 Feb 2020 10:54:54 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        sudeep.holla@arm.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net, peterz@infradead.org, mingo@redhat.com,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 7/7] clocksource/drivers/arm_arch_timer: validate
 arch_timer_rate
Message-ID: <20200212105439.GA3755@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-8-ionela.voinescu@arm.com>
 <89339501-5ee4-e871-3076-c8b02c6fbf6e@arm.com>
 <a24aa6c86e7a565b6269f48d4026bca2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24aa6c86e7a565b6269f48d4026bca2@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

On Wednesday 12 Feb 2020 at 10:12:32 (+0000), Marc Zyngier wrote:
> On 2020-02-12 10:01, Lukasz Luba wrote:
> > Hi Ionela, Valentin
> > 
> > On 2/11/20 6:45 PM, Ionela Voinescu wrote:
> > > From: Valentin Schneider <valentin.schneider@arm.com>
> > > 
> > > Using an arch timer with a frequency of less than 1MHz can result in
> > > an
> > > incorrect functionality of the system which assumes a reasonable rate.
> > > 
> > > One example is the use of activity monitors for frequency invariance
> > > which uses the rate of the arch timer as the known rate of the
> > > constant
> > > cycle counter in computing its ratio compared to the maximum frequency
> > > of a CPU. For arch timer frequencies less than 1MHz this ratio could
> > > end up being 0 which is an invalid value for its use.
> > > 
> > > Therefore, warn if the arch timer rate is below 1MHz which contravenes
> > > the recommended architecture interval of 1 to 50MHz.
> > > 
> > > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > ---
> > >   drivers/clocksource/arm_arch_timer.c | 18 +++++++++++++++---
> > >   1 file changed, 15 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/clocksource/arm_arch_timer.c
> > > b/drivers/clocksource/arm_arch_timer.c
> > > index 9a5464c625b4..4faa930eabf8 100644
> > > --- a/drivers/clocksource/arm_arch_timer.c
> > > +++ b/drivers/clocksource/arm_arch_timer.c
> > > @@ -885,6 +885,17 @@ static int arch_timer_starting_cpu(unsigned int
> > > cpu)
> > >   	return 0;
> > >   }
> > >   +static int validate_timer_rate(void)
> > > +{
> > > +	if (!arch_timer_rate)
> > > +		return -EINVAL;
> > > +
> > > +	/* Arch timer frequency < 1MHz can cause trouble */
> > > +	WARN_ON(arch_timer_rate < 1000000);
> > 
> > I don't see a big value of having a patch just to add one extra warning,
> > in a situation which we handle in our code with in 6/7 with:
> > 
> > +	if (!ratio) {
> > +		pr_err("System timer frequency too low.\n");
> > +		return -EINVAL;
> > +	}
> > 
> > Furthermore, the value '100000' here is because of our code and
> > calculation in there, so it does not belong to arch timer. Someone
> > might ask why it's not 200000 or a define in our header...
> > Or questions asking why do you warn when that arch timer and cpu is not
> > AMU capable...
> 
> Because, as the commit message outlines it, such a frequency is terribly
> out of spec?
> 

Probably it could have been better emphasised in the commit message but,
yes, [1] specifies a typical range of 1-50Mhz. Therefore, taken
independently the role of this patch is to warn about an out of spec arch
timer rate. 
The link to AMU is here just as an example of a scenario where an out of
spec rate can affect functionality, but there is no dependency between
the threshold chosen here and AMU. AMU functionality only assumes the rate
recommended in the spec.

[1] https://static.docs.arm.com/ddi0487/ea/DDI0487E_a_armv8_arm.pdf

> > 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   /*
> > >    * For historical reasons, when probing with DT we use whichever
> > > (non-zero)
> > >    * rate was probed first, and don't verify that others match. If
> > > the first node
> > > @@ -900,7 +911,7 @@ static void arch_timer_of_configure_rate(u32
> > > rate, struct device_node *np)
> > >   		arch_timer_rate = rate;
> > >     	/* Check the timer frequency. */
> > > -	if (arch_timer_rate == 0)
> > > +	if (validate_timer_rate())
> > >   		pr_warn("frequency not available\n");
> > >   }
> > >   @@ -1594,9 +1605,10 @@ static int __init
> > > arch_timer_acpi_init(struct acpi_table_header *table)
> > >   	 * CNTFRQ value. This *must* be correct.
> > >   	 */
> > >   	arch_timer_rate = arch_timer_get_cntfrq();
> > > -	if (!arch_timer_rate) {
> > > +	ret = validate_timer_rate();
> > > +	if (ret) {
> > >   		pr_err(FW_BUG "frequency not available.\n");
> > > -		return -EINVAL;
> > > +		return ret;
> > >   	}
> > >     	arch_timer_uses_ppi = arch_timer_select_ppi();
> > > 
> > 
> > Lastly, this is arch timer.
> > To increase chances of getting merge soon, I would recommend to drop
> > the patch from this series.
> 
> And? It seems to address a potential issue where the time frequency
> is out of spec, and makes sure we don't end up with additional problems
> in the AMU code.
> 
> On its own, it is perfectly sensible and could be merged as part of this
> series with my
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
>         M.

Thanks, Marc! I'll keep this patch here then with some changes in the commit
message for more clarity and the change in author.

Thank you all,
Ionela.

> -- 
> Jazz is not dead. It just smells funny...
