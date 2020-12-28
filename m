Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25B32E6A49
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 20:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgL1TMY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Dec 2020 14:12:24 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43163 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbgL1TMY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 14:12:24 -0500
Received: by mail-ot1-f54.google.com with SMTP id q25so9962506otn.10;
        Mon, 28 Dec 2020 11:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yNS9VDnMZt1OUk/fHIk5IWu5GUbThm0w80OSLDbqMw=;
        b=BNICooBxpNPugkzAogtvVR2ofxW4cdwX0n6LCbzVuWBGn11+GXGq0D504cmGKeQkeG
         hNhvdnNHkoAKtSn3/guBV9agzNl+0gnlgtra5rNlR+o40+Aid1V3M044f542/cjjS2Z5
         PKgPPkUEvL8Brb73l1fC88rji5hHTd87cTUBVEfi7+hYwE8aXyvpj0tNSKo45wSfaKin
         K5baow0DrQRXu9hHdkFtX1YQ+qOxStpYRoehAayYGVUeW6ndQVvdbKxggBC0tmHq5Ue4
         WhvD6JIuGLMJZ8d6uBbvkMiBK8vYXZf1NVNaH7yZUG57HusIMOkmB/6d+c7gHmQHjA6Z
         Vdiw==
X-Gm-Message-State: AOAM531tnQCXnC2H2zs8WAljURu1wCktBM2OcdK9Q1yPVbqp0S9Tyy59
        WswMWsDW75prwGtoBljJSmAgKlFD4Eavy7Xj5UQ=
X-Google-Smtp-Source: ABdhPJxwIrd1rhcQc6ht2pYJf3peA55h5LqmGcCitDSv/OOu7OoZOKduerElw2YJQH4sssDIeufiDSsk+kZwWXGjVa0=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr34726783otk.206.1609182703142;
 Mon, 28 Dec 2020 11:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20360841.iInq7taT2Z@kreacher> <3827230.0GnL3RTcl1@kreacher>
 <1608307905.26567.46.camel@suse.com> <CAJZ5v0jfgFRqXisWQUH0J-Xfvh_jjWw8mC_AKyd-tAgRNamj9Q@mail.gmail.com>
 <1608728803.14392.59.camel@suse.com>
In-Reply-To: <1608728803.14392.59.camel@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Dec 2020 20:11:32 +0100
Message-ID: <CAJZ5v0hjXiKoF6xSb8vkKiUgxV6m15r3KKwMOiFyouKJdXGtnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] cpufreq: Allow drivers to receive more information
 from the governor
To:     Giovanni Gherdovich <ggherdovich@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 23, 2020 at 2:08 PM Giovanni Gherdovich
<ggherdovich@suse.com> wrote:
>
> On Mon, 2020-12-21 at 17:11 +0100, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Fri, Dec 18, 2020 at 5:22 PM Giovanni Gherdovich wrote:
> > >
> > > Gitsource: this test show the most compelling case against the
> > >     sugov-HWP.desired series: on the Cascade Lake sugov-HWP.desired is 10%
> > >     faster than sugov-HWP.min (it was expected to be slower!) and 35% less
> > >     efficient (we expected more performance-per-watt, not less).
> >
> > This is a bit counter-intuitive, so it is good to try to understand
> > what's going on instead of drawing conclusions right away from pure
> > numbers.
> >
> > My interpretation of the available data is that gitsource benefits
> > from the "race-to-idle" effect in terms of energy-efficiency which
> > also causes it to suffer in terms of performance.  Namely, completing
> > the given piece of work faster causes some CPU idle time to become
> > available and that effectively reduces power, but it also increases
> > the response time (by the idle state exit latency) which causes
> > performance to drop. Whether or not this effect can be present depends
> > on what CPU idle states are available etc. and it may be a pure
> > coincidence.
> >
> > [snip]
>
> Right, race-to-idle might explain the increased efficiency of HWP.MIN.
> As you note, increased exit latencies from idle can also explain the overall
> performance difference.
>
> > There is a whole broad category of workloads involving periodic tasks
> > that do the same amount of work in every period regardless of the
> > frequency they run at (as long as the frequency is sufficient to avoid
> > "overrunning" the period) and they almost never benefit from
> > "race-to-idle".There is zero benefit from running them too fast and
> > the energy-efficiency goes down the sink when that happens.
> >
> > Now the problem is that with sugov-HWP.min the users who care about
> > these workloads don't even have an option to use the task utilization
> > history recorded by the scheduler to bias the frequency towards the
> > "sufficient" level, because sugov-HWP.min only sets a lower bound on
> > the frequency selection to improve the situation, so the choice
> > between it and sugov-HWP.desired boils down to whether or not to give
> > that option to them and my clear preference is for that option to
> > exist.  Sorry about that.  [Note that it really is an option, though,
> > because "pure" HWP is still the default for HWP-enabled systems.]
>
> Sure, the periodic workloads benefit from this patch, Doug's test shows that.
>
> I guess I'm still confused by the difference between setting HWP.DESIRED and
> disabling HWP completely. The Intel manual says that a non-zero HWP.DESIRED
> "effectively disabl[es] HW autonomous selection", but then continues with "The
> Desired_Performance input is non-constraining in terms of Performance and
> Energy optimizations, which are independently controlled". The first
> statement sounds like HWP is out of the picture (no more autonomous
> frequency selections) but the latter part implies there are other
> optimizations still available. I'm not sure how to reason about that.

For example, if HWP_REQ.DESIRED is set below the point of maximum
energy-efficiency that is known to the processor, it is allowed to go
for the max energy-efficiency instead of following the hint.
Likewise, if the hint is above the P-state corresponding to the max
performance in the given conditions (i.e. increasing the frequency is
not likely to result in better performance due to some limitations
known to the processor), the processor is allowed to set that P-state
instead of following the hint.

Generally speaking, the processor may not follow the hint if better
results can be achieved by putting the given CPU into a P-state
different from the requested one.

> > It may be possible to restore some "race-to-idle" benefits by tweaking
> > HWP_REQ.EPP in the future, but that needs to be investigated.
> >
> > BTW, what EPP value was there on the system where you saw better
> > performance under sugov-HWP.desired?  If it was greater than zero, it
> > would be useful to decrease EPP (by adjusting the
> > energy_performance_preference attributes in sysfs for all CPUs) and
> > see what happens to the performance difference then.
>
> For sugov-HWP.desired the EPP was 0x80 (the default value).

So it would be worth testing with EPP=0x20 (or even lower).

Lowering the EPP should cause the processor to ramp up turbo
frequencies faster and it may also allow higher turbo frequencies to
be used.
