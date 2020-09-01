Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD025A04D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 22:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgIAU6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 16:58:00 -0400
Received: from foss.arm.com ([217.140.110.172]:50462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbgIAU6A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 16:58:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D011063;
        Tue,  1 Sep 2020 13:57:59 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E72AA3F66F;
        Tue,  1 Sep 2020 13:57:58 -0700 (PDT)
Date:   Tue, 1 Sep 2020 21:57:57 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] arch_topology: validate input frequencies to
 arch_set_freq_scale()
Message-ID: <20200901205757.GA31302@arm.com>
References: <20200828173303.11939-1-ionela.voinescu@arm.com>
 <20200828173303.11939-2-ionela.voinescu@arm.com>
 <20200831111308.h5j652dnpgys2doe@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831111308.h5j652dnpgys2doe@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Monday 31 Aug 2020 at 16:43:08 (+0530), Viresh Kumar wrote:
> On 28-08-20, 18:32, Ionela Voinescu wrote:
> > The current frequency passed to arch_set_freq_scale() could end up
> > being 0, signaling an error in setting a new frequency. Also, if the
> > maximum frequency in 0, this will result in a division by 0 error.
> > 
> > Therefore, validate these input values before using them for the
> > setting of the frequency scale factor.
> > 
> > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > ---
> >  drivers/base/arch_topology.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 75f72d684294..5708eb724790 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -33,6 +33,11 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> >  	unsigned long scale;
> >  	int i;
> >  
> > +	if (unlikely(!cur_freq || !max_freq)) {
> > +		WARN_ON_ONCE(1);
> > +		return;
> > +	}
> 
> This can be written as:
> 
>         if (WARN_ON_ONCE(!cur_freq || !max_freq))
>                 return;

Yes, that's better.

I've pushed v5 with this and your Acked-by.

Thanks for all your reviews,
Ionela.

> 
> With that.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> > +
> >  	/*
> >  	 * If the use of counters for FIE is enabled, just return as we don't
> >  	 * want to update the scale factor with information from CPUFREQ.
> > -- 
> > 2.17.1
> 
> -- 
> viresh
