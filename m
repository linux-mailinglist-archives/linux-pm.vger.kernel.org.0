Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1EA2CD985
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 15:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389314AbgLCOo7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 09:44:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34797 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389190AbgLCOo6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 09:44:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id s18so2408764oih.1;
        Thu, 03 Dec 2020 06:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UbGjEkaZE0D9a7AyFWG5aWHAuEZDZ69DNAnE5cwlxJ4=;
        b=MMm9XfqVXbQOewTedN9LEuYBBbfmB6pdZ6nl21i6o+b4g4erQFbr2WpuAGWOnQ+NYH
         ijL+JlWMEfxPRTx3ceBhcJsGEQg24N+zd2wiGf27qURagM+v6dmt7r6KY04BE+tMAHcU
         0Pe8U+vjNEa51Oq0JKM8iFHUvIUA7IsJJU99dQebylteiizvCHob1QGRvP5iwPeUfXw5
         RpKfc/A3tsfMWdcGXx9VDB/0CFdQGF7fD011W0ES2yrc483zD/uiu8epZx0yiFpgWEM6
         NJHC5c52UWnHb2KI/HXsKGDS3wJwQilrMOLfm3TBormjBz7FANChJqJo+VcQrEZ7S+1k
         VTfg==
X-Gm-Message-State: AOAM530u1dLZ6WKIiozKgWXXbUGBZCCDsJi+S8qSKV7Lg0ECNzk34pA8
        rmP4fK6QIyew4OA1F7vrumgL7ysg8KpP0z4c5GA=
X-Google-Smtp-Source: ABdhPJxCB1f9GdvXE8F8LsYWDp/UuWVx87acnLfAlUxHfs6nA2EctCvgQWDEs0+k6q/Szn3sqGyXicrvLFdOiWSe4+Y=
X-Received: by 2002:aca:cf4a:: with SMTP id f71mr2085846oig.157.1607006657415;
 Thu, 03 Dec 2020 06:44:17 -0800 (PST)
MIME-Version: 1.0
References: <1817571.2o5Kk4Ohv2@kreacher> <2174134.tL5yAn4CWt@kreacher> <20201203124141.GP3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201203124141.GP3021@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Dec 2020 15:44:04 +0100
Message-ID: <CAJZ5v0hhsRmije05gg+Hp2maivoF7i1n33LxYWEnSxhsWV1u=A@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] cpufreq: Add special-purpose fast-switching
 callback for drivers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 3, 2020 at 1:42 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 30, 2020 at 07:37:01PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > First off, some cpufreq drivers (eg. intel_pstate) can pass hints
> > beyond the current target frequency to the hardware and there are no
>
> Everything CPPC, which is quite a bit these days.

Right, but that is still "some". :-) I can add it to the list of
examples, though.

> > +     /*
> > +      * ->fast_switch() replacement for drivers that use an internal
> > +      * representation of performance levels and can pass hints other than
> > +      * the target performance level to the hardware.
> > +      */
> > +     void            (*adjust_perf)(unsigned int cpu, bool busy,
> > +                                    unsigned long min_perf,
> > +                                    unsigned long target_perf,
> > +                                    unsigned long capacity);
> >
>
> I'm not sure @busy makes sense, that's more a hack because @util had a
> dip and should remain inside schedutil.

So I did it this way, because schedutil would need to store the old
value of target_perf for this and intel_pstate already does that.

But if a new util_hook is used in this case, the existing space in
sg_policy may be used for that.

> > @@ -454,6 +455,25 @@ static void sugov_update_single(struct u
> >       util = sugov_get_util(sg_cpu);
> >       max = sg_cpu->max;
> >       util = sugov_iowait_apply(sg_cpu, time, util, max);
> > +
> > +     /*
> > +      * This code runs under rq->lock for the target CPU, so it won't run
> > +      * concurrently on two different CPUs for the same target and it is not
> > +      * necessary to acquire the lock in the fast switch case.
> > +      */
> > +     if (sg_policy->direct_fast_switch) {
> > +             /*
> > +              * In this case, any optimizations that can be done are up to
> > +              * the driver.
> > +              */
> > +             cpufreq_driver_adjust_perf(sg_cpu->cpu,
> > +                                        sugov_cpu_is_busy(sg_cpu),
> > +                                        map_util_perf(sg_cpu->bw_dl),
> > +                                        map_util_perf(util), max);
> > +             sg_policy->last_freq_update_time = time;
> > +             return;
> > +     }
>
> Instead of adding more branches, would it makes sense to simply set a
> whole different util_hook in this case?

Looks doable without too much code duplication.  Lemme try.
