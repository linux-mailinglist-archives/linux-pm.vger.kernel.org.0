Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0553E210C52
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 15:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgGANdh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 09:33:37 -0400
Received: from foss.arm.com ([217.140.110.172]:41304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730408AbgGANdd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 09:33:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67C6430E;
        Wed,  1 Jul 2020 06:33:32 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 088733F73C;
        Wed,  1 Jul 2020 06:33:31 -0700 (PDT)
Date:   Wed, 1 Jul 2020 14:33:30 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, sudeep.holla@arm.com,
        will@kernel.org, linux@armlinux.org.uk, valentin.schneider@arm.com,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] cpufreq: allow drivers to flag custom support for
 freq invariance
Message-ID: <20200701133330.GA32736@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-2-ionela.voinescu@arm.com>
 <20200701094417.ffuvduz6pqknjcks@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701094417.ffuvduz6pqknjcks@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Thank you for taking a look over these so quickly.

On Wednesday 01 Jul 2020 at 16:16:17 (+0530), Viresh Kumar wrote:
> On 01-07-20, 10:07, Ionela Voinescu wrote:
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 3494f6763597..42668588f9f8 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -293,7 +293,7 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
> >  
> >  struct cpufreq_driver {
> >  	char		name[CPUFREQ_NAME_LEN];
> > -	u8		flags;
> > +	u16		flags;
> 
> Lets make it u32.
> 
> >  	void		*driver_data;
> >  
> >  	/* needed by all drivers */
> > @@ -417,6 +417,14 @@ struct cpufreq_driver {
> >   */
> >  #define CPUFREQ_IS_COOLING_DEV			BIT(7)
> >  
> > +/*
> > + * Set by drivers which implement the necessary calls to the scheduler's
> > + * frequency invariance engine. The use of this flag will result in the
> > + * default arch_set_freq_scale calls being skipped in favour of custom
> > + * driver calls.
> > + */
> > +#define CPUFREQ_CUSTOM_SET_FREQ_SCALE		BIT(8)
> 
> I will rather suggest CPUFREQ_SKIP_SET_FREQ_SCALE as the name and
> functionality. We need to give drivers a choice if they do not want
> the core to do it on their behalf, because they are doing it on their
> own or they don't want to do it.
> 

In this case we would not be able to tell if cpufreq (driver or core)
can provide the frequency scale factor, so we would not be able to tell
if the system is really frequency invariant; CPUFREQ_SKIP_SET_FREQ_SCALE
would be set if either:
 - the driver calls arch_set_freq_scale() on its own
 - the driver does not want arch_set_freq_scale() to be called.

So at the core level we would not be able to distinguish between the
two, and return whether cpufreq-based invariance is supported.

I don't really see a reason why a driver would not want to set the
frequency scale factor, if it has the proper mechanisms to do so
(therefore excluding the exceptions mentioned in 2/8). I think the
cpufreq core or drivers should produce the information (set the scale
factor) and it should be up to the users to decide whether to use it or
not. But being invariant should always be the default.

Therefore, there are a few reasons I went for
CPUFREQ_CUSTOM_SET_FREQ_SCALE instead:
 - It tells us if the driver has custom mechanisms to set the scale
   factor to filter the setting in cpufreq core and to inform the
   core on whether the system is frequency invariant.
 - It does have a user in the vexpress-spc driver.
 - Currently there aren't drivers that could but choose not to set
   the frequency scale factor, and it my opinion this should not be
   the case.

Thanks,
Ionela.

> -- 
> viresh
