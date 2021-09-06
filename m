Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C82C401ED2
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 18:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhIFQ7o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 12:59:44 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38712 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhIFQ7n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 12:59:43 -0400
Received: by mail-oi1-f175.google.com with SMTP id bd1so7506745oib.5;
        Mon, 06 Sep 2021 09:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgKlb4iJmcJ2cYW3VxrDWPKBagpMWhsBEhypY5ySsxg=;
        b=QHtpRnk4VEmhAAnDkeEhZAiq9E2P9Trnjo6vfQNSZJLmlvshg0xsA83ZVAJYZ42aY/
         Sa8Qe5kjZKxN6bL76tvEhWUCAo4q1Pbr2FankhOM/zIPxhNnvtl9cUzRjGCSRNozUkqs
         MHo4V2KbKCoxoZ1F26v3x8DxEqyoSLhBzlOntm4kErA6qkNoED7a6M2fmXrHJLju92DO
         6ZwrwxQZ5I588a74A3tzwRDnau0O+ms+UhtrKIeI1zk178Idy2hNZvtRh3d94LM9ryMl
         au72mPdKQOxuw3nkqo9hSSbvnmzwTNL0kaA9+fPUStzNMDyzIaHO1z8tmFeYBQUlkJ2O
         G17g==
X-Gm-Message-State: AOAM532jEIS002syvSgSKTcRahJGXMqvypGCH7tR7SjnaQBveE3jDrnE
        Op3MCYIKNJat6xA0x0E3JKQ02AM1oNTt0v7TVjQ=
X-Google-Smtp-Source: ABdhPJxFC8GgM61+wHgpy/oZ+wpeXPwk15NIALG30krQAUJ3nBb7Gy55pjbgLwCnQc/PJ0z0fOZqYXMowdFGIlRRxKA=
X-Received: by 2002:a05:6808:10ce:: with SMTP id s14mr36534ois.157.1630947518534;
 Mon, 06 Sep 2021 09:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210904053703.581297-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0hQp8Hxf__tL22s0oOcTym5mx9tND34ijufTDE3_NSW6A@mail.gmail.com>
 <926ac4b9-1bb5-e96e-ded3-6461f7a215b7@kernel.dk> <b1d5b6daacef349eb6fcc23ce7264e4786d1d9f4.camel@linux.intel.com>
In-Reply-To: <b1d5b6daacef349eb6fcc23ce7264e4786d1d9f4.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Sep 2021 18:58:27 +0200
Message-ID: <CAJZ5v0jaXnw0zjpnsb81Hauy4-ApuULfQaaLG10qqL67H-YTNA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix for HWP interrupt before
 driver is ready
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 6, 2021 at 6:55 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2021-09-06 at 10:43 -0600, Jens Axboe wrote:
> > On 9/6/21 10:17 AM, Rafael J. Wysocki wrote:
> > > On Sat, Sep 4, 2021 at 7:37 AM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > >
> > > > In Lenovo X1 gen9 laptop, HWP interrupts arrive before driver is
> > > > ready
> > > > to handle on that CPU. Basically didn't even allocated memory for
> > > > per
> > > > cpu data structure and not even started interrupt enable process
> > > > on that
> > > > CPU. So interrupt handler observes a NULL pointer to schedule
> > > > work.
> > > >
> > > > This interrupt was probably for SMM, but since it is redirected
> > > > to
> > > > OS by OSC call, OS receives it, but not ready to handle. That
> > > > redirection
> > > > of interrupt to OS was also done to solve one SMM crash on Yoga
> > > > 260 for
> > > > HWP interrupt a while back.
> > > >
> > > > To solve this the HWP interrupt handler should ignore such
> > > > request if the
> > > > driver is not ready. This will require some flag to wait till the
> > > > driver
> > > > setup a workqueue to handle on a CPU. We can't simply assume
> > > > cpudata to
> > > > be NULL and avoid processing as it may not be NULL but data
> > > > structure is
> > > > not in consistent state.
> > > >
> > > > So created a cpumask which sets the CPU on which interrupt was
> > > > setup. If
> > > > not setup, simply clear the interrupt status and return. Since
> > > > the
> > > > similar issue can happen during S3 resume, clear the bit during
> > > > offline.
> > > >
> > > > Since interrupt timing may be before HWP is enabled, use safe MSR
> > > > read
> > > > writes as before the change for HWP interrupt.
> > > >
> > > > Fixes: d0e936adbd22 ("cpufreq: intel_pstate: Process HWP
> > > > Guaranteed change notification")
> > > > Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
> > > > Signed-off-by: Srinivas Pandruvada <
> > > > srinivas.pandruvada@linux.intel.com>
> > > > ---
> > > >  drivers/cpufreq/intel_pstate.c | 23 ++++++++++++++++++++++-
> > > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > b/drivers/cpufreq/intel_pstate.c
> > > > index b4ffe6c8a0d0..5ac86bfa1080 100644
> > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > @@ -298,6 +298,8 @@ static bool hwp_boost __read_mostly;
> > > >
> > > >  static struct cpufreq_driver *intel_pstate_driver __read_mostly;
> > > >
> > > > +static cpumask_t hwp_intr_enable_mask;
> > > > +
> > > >  #ifdef CONFIG_ACPI
> > > >  static bool acpi_ppc;
> > > >  #endif
> > > > @@ -1067,11 +1069,15 @@ static void intel_pstate_hwp_set(unsigned
> > > > int cpu)
> > > >         wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
> > > >  }
> > > >
> > > > +static void intel_pstate_disable_hwp_interrupt(struct cpudata
> > > > *cpudata);
> > > > +
> > > >  static void intel_pstate_hwp_offline(struct cpudata *cpu)
> > > >  {
> > > >         u64 value = READ_ONCE(cpu->hwp_req_cached);
> > > >         int min_perf;
> > > >
> > > > +       intel_pstate_disable_hwp_interrupt(cpu);
> > > > +
> > > >         if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
> > > >                 /*
> > > >                  * In case the EPP has been set to "performance"
> > > > by the
> > > > @@ -1645,20 +1651,35 @@ void notify_hwp_interrupt(void)
> > > >         if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> > > >                 return;
> > > >
> > > > -       rdmsrl(MSR_HWP_STATUS, value);
> > > > +       rdmsrl_safe(MSR_HWP_STATUS, &value);
> > > >         if (!(value & 0x01))
> > > >                 return;
> > > >
> > > > +       if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask)) {
> > > > +               wrmsrl_safe(MSR_HWP_STATUS, 0);
> > > > +               return;
> > > > +       }
> > >
> > > Without additional locking, there is a race between this and
> > > intel_pstate_disable_hwp_interrupt().
> > >
> > > 1. notify_hwp_interrupt() checks hwp_intr_enable_mask() and the
> > > target
> > > CPU is in there, so it will go for scheduling the delayed work.
> > > 2. intel_pstate_disable_hwp_interrupt() runs between the check and
> > > the
> > > cpudata load below.
> > > 3. hwp_notify_work is scheduled on the CPU that isn't there in the
> > > mask any more.
> >
> > I noticed that too, not clear to me how much of an issue that is in
> > practice. But there's definitely a race there.
> Glad to see how this is possible from code running in ISR context.

intel_pstate_disable_hwp_interrupt() may very well run on a different
CPU in parallel with the interrupt handler running on this CPU.  Or is
this not possible for some reason?
