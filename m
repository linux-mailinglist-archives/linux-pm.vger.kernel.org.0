Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9DB2DD902
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 20:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLQTDA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 14:03:00 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42623 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQTDA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2020 14:03:00 -0500
Received: by mail-oi1-f179.google.com with SMTP id l200so15001oig.9;
        Thu, 17 Dec 2020 11:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sA9YAi7PjNg63O3S+VOiYgelRrbRgBxhKzHGavIAgAk=;
        b=ZtZ63/Q05UT//SyNuDC4y5L8glbxhAgsdkxtyUQbH4G2vzDvtuCyj+lzcZAWykOAx3
         gqKZ+yOjqTfXEdJhpJGz6WrG2mlo5j0Hfd44LdxVLgVvArnPX+EraAmlmIuEi/BXX7bA
         aDhPYix9F8l1xKzTIqfqq7Yay8vvTDJEvX1TgGpTk83MsGe9TSJK0jMjLVFCn/XtlETv
         Qen3J0XHMUMIXOFcEh8lViW32IgLtmAhpCV81o9fXQGogKvbUYeQdpgsANCACyepsXSi
         bPlpzE39U9mGC2cQU09wrIoCPr4PUUSBQKnEtTPsWQ+vjOTCdVrL+outDgV90ZMruYFU
         ZW4w==
X-Gm-Message-State: AOAM533K7p6aDf0vLGbwX/xhSKJubYI6kSvRx1lVHefrb5yI9q03jOE9
        iKk7sKUSNxPa5sOTgZeSkpLOyJaDpf8+fuHbzppwL6gahcY=
X-Google-Smtp-Source: ABdhPJy8UWhllOcXkC4Geb8YJ6hqDCqezBhDagAY+CY941W+C1SGkRip1Rdrlzcp4+GTO0DebtAXdhTS7dPAtxwCp64=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr404611oib.69.1608231739225;
 Thu, 17 Dec 2020 11:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20201217104215.2544837-1-srinivas.pandruvada@linux.intel.com>
 <d581bfe77c2fc4ff266bb155cf610f176c786e2e.camel@linux.intel.com>
 <93d4eebb5121ad0497af555c55a6ad74b8a06e64.camel@linux.intel.com>
 <8153207.dYVdvtsJbe@kreacher> <6ef769aa04ee8e765863fd4af083eb85cdcb4827.camel@linux.intel.com>
 <CAJZ5v0gfAZrW4jmEEb+h2UpYVoVMLd2P4f_P_R-_+uRytSJ6Pg@mail.gmail.com>
 <16328b6c4531e676f829601e72dee4a5c2f802a7.camel@linux.intel.com> <CAJZ5v0iTw8pUugyVPeX5ZxxqHRcZ=igABPNrgYorB97nWAEVrQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iTw8pUugyVPeX5ZxxqHRcZ=igABPNrgYorB97nWAEVrQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Dec 2020 20:02:07 +0100
Message-ID: <CAJZ5v0gBwVm4p-haqfKFL25RGXPteeem0ake2UoaT9pm=17BoA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use the latest guaranteed freq
 during verify
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 17, 2020 at 6:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 17, 2020 at 6:09 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > On Thu, 2020-12-17 at 16:24 +0100, Rafael J. Wysocki wrote:
> > > On Thu, Dec 17, 2020 at 4:21 PM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:

[cut]

> > > > > Well, would something like the patch below work?
> > > > >
> > > > > ---
> > > > >  drivers/cpufreq/intel_pstate.c |   16 +++++++++++++---
> > > > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > > >
> > > > > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > > > > =================================================================
> > > > > ==
> > > > > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > > > > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > > > > @@ -2207,9 +2207,9 @@ static void intel_pstate_update_perf_lim
> > > > >                                             unsigned int
> > > > > policy_min,
> > > > >                                             unsigned int
> > > > > policy_max)
> > > > >  {
> > > > > -       int max_freq = intel_pstate_get_max_freq(cpu);
> > > > >         int32_t max_policy_perf, min_policy_perf;
> > > > >         int max_state, turbo_max;
> > > > > +       int max_freq;
> > > > >
> > > > >         /*
> > > > >          * HWP needs some special consideration, because on BDX
> > > > > the
> > > > > @@ -2223,6 +2223,7 @@ static void intel_pstate_update_perf_lim
> > > > >                         cpu->pstate.max_pstate : cpu-
> > > > > > pstate.turbo_pstate;
> > > > >                 turbo_max = cpu->pstate.turbo_pstate;
> > > > >         }
> > > > > +       max_freq = max_state * cpu->pstate.scaling;
> > > > >
> > > > >         max_policy_perf = max_state * policy_max / max_freq;
> > > > >         if (policy_max == policy_min) {
> > > > > @@ -2325,9 +2326,18 @@ static void intel_pstate_adjust_policy_m
> > > > >  static void intel_pstate_verify_cpu_policy(struct cpudata *cpu,
> > > > >                                            struct
> > > > > cpufreq_policy_data
> > > > > *policy)
> > > > >  {
> > > > > +       int max_freq;
> > > > > +
> > > > >         update_turbo_state();
> > > > > -       cpufreq_verify_within_limits(policy, policy-
> > > > > > cpuinfo.min_freq,
> > > > > -
> > > > > intel_pstate_get_max_freq(cpu));
> > > > > +       if (hwp_active) {
> > > > > +               int max_state, turbo_max;
> > > > > +
> > > > > +               intel_pstate_get_hwp_max(cpu->cpu, &turbo_max,
> > > > > &max_state);
> > > > > +               max_freq = max_state * cpu->pstate.scaling;
> > > > > +       } else {
> > > > > +               max_freq = intel_pstate_get_max_freq(cpu);
> > > > > +       }
> > > > > +       cpufreq_verify_within_limits(policy, policy-
> > > > > > cpuinfo.min_freq, max_freq);
> > > > >
> > > > >         intel_pstate_adjust_policy_max(cpu, policy);
> > > > >  }
> > > > >
> > > > Should work.
> > > >  I will test this patch and let you know once I get the system.
> > >
> > > Please do, thank you!
> >
> > This works. Please check if you can submit a change for this.
>
> I can do that, but I'm going to borrow some changelog pieces from the
> $subject patch.
>
> Will submit shortly.

Well, this only fixes the setting of the policy max limit AFAICS, but
pstate.max_pstate is used in computations in some places, so it looks
like it needs to be updated every time HWP_CAP is read, or do I
confuse things?

And if pstate.max_pstate needs to be updated then, shouldn't
pstate.turbo_pstate be updated then too (because it may change too as
a result of ISS updates)?
