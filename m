Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8069D2AB832
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 13:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgKIM1f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 07:27:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46368 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgKIM1f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 07:27:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id g19so8684852otp.13;
        Mon, 09 Nov 2020 04:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJxFbDvRRCnc/4vPtEw0yIcsdM8RBDOf2GintUurPj8=;
        b=UAVux4ciTPd1SeKAyalTNxhhg3RRkRU0XA0/T2k6Ghfbcv8i0kCkCp1o4jwHGcgmpX
         t/aIhGG5IkwH6RK7NZZa5JccDZyffFGg8fvtTEAMUGIEf+0Heuh2AIMXVu9lXDwB0UAT
         BhuOzkRAo3FgVQG6SiUsTc/2LKy92yb1LyyYekJuCbzljTR/E1ynOr2zsqy84vMQAITU
         PhaTJ4YK6cKqICMJmBDkau5R6Divwaj7rknH4XPb6/OTO/4Ihk5S/rrHO32upQrH3/48
         HS/CD+XPKILISSKW8hYWXPLnMuE8q1TO0OVS5TzQABviaXQvYarwaVSiUU4nwgXbz0vG
         arXg==
X-Gm-Message-State: AOAM533TUCar/ol9kbw/8f7cZmvnyMh17mLLQlV1TWGYDQmyZv2HQjG7
        5Ym/fJsnqyuCV7e8tQqGix4OdaqtU1uo+i88XOQ=
X-Google-Smtp-Source: ABdhPJwE/fbnK2oev/xyYEbPnm7sDAdEc49nsBi9NXsE2ViWsBZmwaotGaEh4n6A1fzAL2ZLV/WKc6d3H97dwWnlKls=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr10658144ota.260.1604924854832;
 Mon, 09 Nov 2020 04:27:34 -0800 (PST)
MIME-Version: 1.0
References: <7417968.Ghue05m4RV@kreacher> <2233690.N3OVLkotou@kreacher>
 <20201106100712.u336gbtblaxr2cit@vireshk-i7> <CAJZ5v0gT07K-oPa0=f8+Fq6tevqZJ8iWYjtf9YDNUJw1GJEBBA@mail.gmail.com>
 <20201109043912.7zvfhi42yhr7goy4@vireshk-i7>
In-Reply-To: <20201109043912.7zvfhi42yhr7goy4@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Nov 2020 13:27:18 +0100
Message-ID: <CAJZ5v0jEbKEj5OTwrr9y3HXmoSETvicu5FMyzbSY2hDaEOK2QQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: Introduce target min and max frequency hints
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 9, 2020 at 5:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 06-11-20, 18:02, Rafael J. Wysocki wrote:
> > On Fri, Nov 6, 2020 at 11:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 05-11-20, 19:23, Rafael J. Wysocki wrote:
> > > > Index: linux-pm/include/linux/cpufreq.h
> > > > ===================================================================
> > > > --- linux-pm.orig/include/linux/cpufreq.h
> > > > +++ linux-pm/include/linux/cpufreq.h
> > > > @@ -63,6 +63,8 @@ struct cpufreq_policy {
> > > >
> > > >       unsigned int            min;    /* in kHz */
> > > >       unsigned int            max;    /* in kHz */
> > > > +     unsigned int            target_min; /* in kHz */
> > > > +     unsigned int            target_max; /* in kHz */
> > > >       unsigned int            cur;    /* in kHz, only needed if cpufreq
> > > >                                        * governors are used */
> > > >       unsigned int            suspend_freq; /* freq to set during suspend */
> > >
> > > Rafael, honestly speaking I didn't like this patch very much.
> >
> > So what's the concern, specifically?
> >
> > > We need to fix a very specific problem with the intel-pstate driver when it is
> > > used with powersave/performance governor to make sure the hard limits
> > > are enforced. And this is something which no one else may face as
> > > well.
> >
> > Well, I predict that the CPPC driver will face this problem too at one point.
> >
> > As well as any other driver which doesn't select OPPs directly for
> > that matter, at least to some extent (note that intel_pstate in the
> > "passive" mode without HWP has it too, but since there is no way to
> > enforce the target max in that case, it is not relevant).
> >
> > > What about doing something like this instead in the intel_pstate
> > > driver only to get this fixed ?
> > >
> > >         if (!strcmp(policy->governor->name, "powersave") ||
> > >             !strcmp(policy->governor->name, "performance"))
> > >                 hard-limit-to-be-enforced;
> > >
> > > This would be a much simpler and contained approach IMHO.
> >
> > I obviously prefer to do it the way I did in this series, because it
> > is more general and it is based on the governor telling the driver
> > what is needed instead of the driver trying to figure out what the
> > governor is and guessing what may be needed because of that.
> >
> > But if you have a very specific technical concern regarding my
> > approach, I can do it the other way too.
>
> I was concerned about adding those fields in the policy structure, but
> I get that you want to do it in a more generic way.
>
> What about adding a field name "fixed" (or something else) in the
> governor's structure which tells us that the frequency is fixed and
> must be honored by the driver.

That would work for powersave/performance and it would suffice for the
time being, so let me try to implement that.

Still, there is a more general problem related to that which is how to
prevent the perf control in the hardware from going beyond certain
limits, possibly narrower than the policy min and max.

For example, the kernel may need to reserve some capacity for deadline
tasks or similar, or when there is a min utilization clamp in place,
and it would be good to have a way to let the HW know that it should
not reduce the available capacity below a certain boundary, even
though that may appear to be the right thing to do to it. [This is
kind of addressed by intel_pstate by setting the HWP floor to the
target frequency requested by the governor, but that is suboptimal,
because it generally causes too much capacity to be reserved which
costs energy.]

Analogously, the kernel may not want the HW to increase capacity too
much when it knows that doing so would not increase the amount of work
done or when the work being done is not urgent (like when there is a
max utilization clamp in place),  [This last issue is particularly
visible in some GPU-related workloads where the processor sees
conditions for ramping up a "one-core turbo" frequency very high, but
this is a mistake, because it doesn't cause work to be done any
faster, since the task doing the work is in fact periodic and it does
the same amount of work in every period regardless of how fast the CPU
doing it runs.]

So while the powersave/performance case can be addressed in a simpler
way, the need for a more general approach is still there.
