Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF85523A7E2
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 15:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgHCNrM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 09:47:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38118 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgHCNrL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 09:47:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id u63so21515204oie.5;
        Mon, 03 Aug 2020 06:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8dgWfdFWbvh9ZWZ1ZNBTHX4VAGf175AsYQyWP17dNI=;
        b=RaSbfZuS52aO3YmqbAr3ZVDPgLhOeWHaJ+jj31gcLJE5P/JL5j+J/fDhbJtFpq+kil
         QmLU+f2mFk/zKJoRRlaXaDPaqpmPuGEM1E1Jp6xjXrzKwSdaLcHKxQgGjFyCjGLlPzKn
         fQmhDf7pZlbEo22R/CyTeqgc+AR0ewx/gvAouFb1SBsE6ajx7jjhTgyyiuQvvPU8z8S/
         Qbt82EPkarhouJBklY4uniK5VzCCpIQqSev3zWegmKmMHVo0hBmRjEIrlE3e5E9Pkmdp
         YLWe+N5ykTdT17/b6963lqAolfvrWoVuUX9XRc1D2TLqnJJibT0owIpUhbKL4noV4fIN
         xKuw==
X-Gm-Message-State: AOAM530cQBS2uTzw82PoVB7TQMmsi9iLb8RkAJS1vlcMrafgU2utQZFH
        rN06kQwyAzx+FyArtaIF2hW1Z4poWf9udFys+L4=
X-Google-Smtp-Source: ABdhPJyFUfBACH5XqP9tKDNYxFYYtA4RyrEcaKDspg6cpYPauGtzed7reeFZ0UlKtdcbE1mt7I5J5PAh4P2D1tNyOV4=
X-Received: by 2002:a54:4f14:: with SMTP id e20mr10487303oiy.103.1596462430736;
 Mon, 03 Aug 2020 06:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-2-ionela.voinescu@arm.com> <CAJZ5v0i5Xrk6oTt81aeXDi1F8gnEspJo9e6nGf10nSvBz-Dbkw@mail.gmail.com>
 <20200730034128.k4fmblfuwjcmqdze@vireshk-mac-ubuntu> <20200803132617.GA9512@arm.com>
In-Reply-To: <20200803132617.GA9512@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Aug 2020 15:46:59 +0200
Message-ID: <CAJZ5v0gOJXtpF4iy2v+Jbv9y9QZsAtEREMQwWv0u7Zks0Fvp1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] cpufreq: move invariance setter calls in cpufreq core
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 3, 2020 at 3:26 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi guys,
>
> On Thursday 30 Jul 2020 at 09:11:28 (+0530), Viresh Kumar wrote:
> > On 27-07-20, 15:48, Rafael J. Wysocki wrote:
> > > On Wed, Jul 22, 2020 at 11:38 AM Ionela Voinescu
> > > <ionela.voinescu@arm.com> wrote:
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 036f4cc42ede..bac4101546db 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -2058,9 +2058,16 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> > > >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > > >                                         unsigned int target_freq)
> > > >  {
> > > > +       unsigned int freq;
> > > > +
> > > >         target_freq = clamp_val(target_freq, policy->min, policy->max);
> > > > +       freq = cpufreq_driver->fast_switch(policy, target_freq);
> > > > +
> > > > +       if (freq)
> > > > +               arch_set_freq_scale(policy->related_cpus, freq,
> > > > +                                   policy->cpuinfo.max_freq);
> > >
> > > Why can't arch_set_freq_scale() handle freq == 0?
> >
>
> Sorry, I seem to have missed this question the first time around.
>
> arch_set_freq_scale() could handle freq == 0, but given that freq == 0
> is signaling an error here, I do believe this check is well placed, to
> prevent a useless call to arch_set_freq_scale(). Also [1]:

So let me rephrase:

Doesn't this check add overhead in the empty arch_set_freq_scale() case?
