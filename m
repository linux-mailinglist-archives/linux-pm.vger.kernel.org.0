Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28BD211029
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 18:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbgGAQFp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 12:05:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44603 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGAQFp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 12:05:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id 5so19806163oty.11;
        Wed, 01 Jul 2020 09:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+roH6OrPDt51jxgNFtZVZqDRGVI2e47jOLKRXACWd4=;
        b=fuQMihO5n1KpIYJM3DIXOJzcmsBMb1hlul6Bp0XYkGtgHwPcSEbdnHitqYU9ySEK/O
         lVBgd/amo+9WudVtKl6/I1LaWwjBj0FD0cz3C0aVflVzKzFPNTiAURRXyi0VMrE/efzs
         /c2uxY34JMmkPfpt9sj4gUvy8Izrd19NNSWsCTXCETqq1frWSFYS/q5al2IBrCMDqspE
         jPMuDQl/UeE04HgqClkF5By7Wznykvt3ot20xdtB79wAKX06Sa7i+ib08ULSJSEt/o0e
         iVxrZ/8gJ4IRkzuMzsMhbGLdhBr7wfSWyPkyt1S0ThxnPDKh54b0vhPqLtwgY/kXeusB
         2rvQ==
X-Gm-Message-State: AOAM533oxFJSI3/QVTiWsRjgNKnINv8YDgpC8S1jVYzr7NGXRrzYtYiR
        31fYAPrb8kwL8FLsPdd/Gpe+hAd2JQXQ73JeugM=
X-Google-Smtp-Source: ABdhPJyYf0xyk4yJrvQHshweA5XBw+0e1gT0CvHmu/ugG5A3FcFrvQl89CaBhvXtuHdnIvKxp4M4UMzFqFpnGRhOLNA=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr2092984ots.118.1593619544373;
 Wed, 01 Jul 2020 09:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-2-ionela.voinescu@arm.com> <20200701094417.ffuvduz6pqknjcks@vireshk-i7>
 <20200701133330.GA32736@arm.com>
In-Reply-To: <20200701133330.GA32736@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Jul 2020 18:05:33 +0200
Message-ID: <CAJZ5v0gT+xWwxcx3OZjXBnDLr9i4VOt2Vp3ScWBxbu+NiopkbA@mail.gmail.com>
Subject: Re: [PATCH 1/8] cpufreq: allow drivers to flag custom support for
 freq invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 1, 2020 at 3:33 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi,
>
> Thank you for taking a look over these so quickly.
>
> On Wednesday 01 Jul 2020 at 16:16:17 (+0530), Viresh Kumar wrote:
> > On 01-07-20, 10:07, Ionela Voinescu wrote:
> > > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > > index 3494f6763597..42668588f9f8 100644
> > > --- a/include/linux/cpufreq.h
> > > +++ b/include/linux/cpufreq.h
> > > @@ -293,7 +293,7 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
> > >
> > >  struct cpufreq_driver {
> > >     char            name[CPUFREQ_NAME_LEN];
> > > -   u8              flags;
> > > +   u16             flags;
> >
> > Lets make it u32.
> >
> > >     void            *driver_data;
> > >
> > >     /* needed by all drivers */
> > > @@ -417,6 +417,14 @@ struct cpufreq_driver {
> > >   */
> > >  #define CPUFREQ_IS_COOLING_DEV                     BIT(7)
> > >
> > > +/*
> > > + * Set by drivers which implement the necessary calls to the scheduler's
> > > + * frequency invariance engine. The use of this flag will result in the
> > > + * default arch_set_freq_scale calls being skipped in favour of custom
> > > + * driver calls.
> > > + */
> > > +#define CPUFREQ_CUSTOM_SET_FREQ_SCALE              BIT(8)
> >
> > I will rather suggest CPUFREQ_SKIP_SET_FREQ_SCALE as the name and
> > functionality. We need to give drivers a choice if they do not want
> > the core to do it on their behalf, because they are doing it on their
> > own or they don't want to do it.

Well, this would go backwards to me, as we seem to be designing an
opt-out flag for something that's not even implemented already.

I would go for an opt-in instead.  That would be much cleaner and less
prone to regressions IMO.

>
> In this case we would not be able to tell if cpufreq (driver or core)
> can provide the frequency scale factor, so we would not be able to tell
> if the system is really frequency invariant; CPUFREQ_SKIP_SET_FREQ_SCALE
> would be set if either:
>  - the driver calls arch_set_freq_scale() on its own
>  - the driver does not want arch_set_freq_scale() to be called.
>
> So at the core level we would not be able to distinguish between the
> two, and return whether cpufreq-based invariance is supported.
>
> I don't really see a reason why a driver would not want to set the
> frequency scale factor, if it has the proper mechanisms to do so
> (therefore excluding the exceptions mentioned in 2/8). I think the
> cpufreq core or drivers should produce the information (set the scale
> factor) and it should be up to the users to decide whether to use it or
> not. But being invariant should always be the default.

So instead of what is being introduced by this patch, there should be
an opt-in mechanism for drivers to tell the core to do the freq-scale
factor setting on behalf of the driver.

Then, the driver would be responsible to only opt-in for that if it
knows it for a fact that the sched tick doesn't set the freq-scale
factor.

> Therefore, there are a few reasons I went for
> CPUFREQ_CUSTOM_SET_FREQ_SCALE instead:
>  - It tells us if the driver has custom mechanisms to set the scale
>    factor to filter the setting in cpufreq core and to inform the
>    core on whether the system is frequency invariant.
>  - It does have a user in the vexpress-spc driver.
>  - Currently there aren't drivers that could but choose not to set
>    the frequency scale factor, and it my opinion this should not be
>    the case.

Well, that depends on what you mean by "could".

For example, it doesn't really make sense to set the freq-scale factor
in either the ACPI cpufreq driver or intel_pstate, because the
frequency (or P-state to be precise) requested by them may not be the
one the CPU ends up running at and even so it may change at any time
for various reasons (eg. in the turbo range).  However, the ACPI
cpufreq driver as well as intel_pstate in the passive mode both set
policy->cur, so that might be used for setting the freq-scale factor
in principle, but that freq-scale factor may not be very useful in
practice.

Thanks!
