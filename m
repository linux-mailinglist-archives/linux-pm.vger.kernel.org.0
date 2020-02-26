Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3348416FBDC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 11:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBZKSu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 05:18:50 -0500
Received: from foss.arm.com ([217.140.110.172]:33286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbgBZKSu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Feb 2020 05:18:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AEA21FB;
        Wed, 26 Feb 2020 02:18:49 -0800 (PST)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B1DC3F9E6;
        Wed, 26 Feb 2020 02:18:49 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:18:47 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, rjw@rjwysocki.net, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/7] arm64: use activity monitors for frequency
 invariance
Message-ID: <20200226101847.GA19513@arm.com>
References: <20200224141142.25445-1-ionela.voinescu@arm.com>
 <20200224141142.25445-7-ionela.voinescu@arm.com>
 <jhjmu97ygk9.fsf@arm.com>
 <18604cef-1e26-96a6-38b3-ab03b1b53b48@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18604cef-1e26-96a6-38b3-ab03b1b53b48@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Valentin, Lukasz,

On Tuesday 25 Feb 2020 at 09:59:20 (+0000), Lukasz Luba wrote:
[..]
> On 2/24/20 6:40 PM, Valentin Schneider wrote:
> > 
> > Ionela Voinescu writes:
> > > +static inline int
> > 
> > That should be bool, seeing what it returns.
> > 

Will do!

[..]
> > > 
> > > +#ifndef arch_cpu_freq_counters
> > > +static __always_inline
> > > +bool arch_cpu_freq_counters(struct cpumask *cpus)
> > > +{
> > > +	return false;
> > > +}
> > > +#endif
> > > 
> > 
> > Apologies for commenting on this only now, I had missed it in my earlier
> > round of review.
> > 
> > I would've liked to keep this contained within arm64 stuff until we agreed
> > on a more generic counter-driven FIE interface, but seems like we can't evade
> > it due to the arch_topology situation.
> > 
> > Would it make sense to relocate this stub to arch_topology.h instead, at
> > least for the time being? That way the only non-arm64 changes are condensed
> > in arch_topology (even if it doesn't change much in terms of header files,
> > since topology.h imports arch_topology.h)
> 
> Or make it as a 'weak' and place it just above the arch_set_freq_scale()
> in arch_topology.c, not touching headers?

Yes, you guys are right, this works better nicely confined to
arch_topology.c/h. As Lukasz suggested, I'll make
arch_cpu_freq_counters (while here, it probably works better renamed to
arch_freq_counters_available) a weak function in arch_topology.c with
its strong definition in arm64/kernel/topology.c.

The diff is large(ish) so I'll push v5 directly with this change.

Thank you both for the review,
Ionela.
