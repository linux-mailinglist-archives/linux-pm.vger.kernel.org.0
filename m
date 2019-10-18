Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60178DC84F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389654AbfJRPVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 11:21:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37193 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732165AbfJRPVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 11:21:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so6639574lje.4
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2019 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLLmFOSm8HttUwzcA55yirZl/vYaKzUHayfsFn/aSKw=;
        b=ENDlG38cJuub/7j/v0Rk3VPnVnnPDhPE1t/OdMIQBWilYVRbNguMx/WSjX1uY2RfI8
         vD4ES6JgbzxSTPk8KQNPRgDo7LFw4Yg4W2plBYQJrQAM3Ju76KUvpBfLJlScuqhoHJ9U
         cvsEpqnDWXakoF+30bCaS/6BzwGKGe0HNDJmA1/refOgDMxevJ6uFmLW+QK8dTiyLaCz
         M64lky6fzJho9x5cV4tKntKJ2qXppel0FgLaSS7WioUq42gYFQrC+TnoUc1Xw9uzRV3A
         EjbR3+ts5ypcUuBFxFd91FxTj72yHcY5TzVxE14dw5tuGgYTyyZnm2mDScbUsxL5VR/A
         vrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLLmFOSm8HttUwzcA55yirZl/vYaKzUHayfsFn/aSKw=;
        b=UCPnEOG7WyQevtV8+en9lVPZ7/YXYbcU3W4DQ3/hUt6/bU7uT05Gi0mNXhT9svJS93
         70PtOIXRZZJu1RIS+ZgnNsXeYfm72so3IGEAW+MWrX2mm5xS9+n51SPywEcp42mv+yba
         Ds0TokT9hxL4wcIbL0YLoAZOI3YNKz1UI37Z+c2YJqrEr1LBK0xA905uoYpi5C5etBng
         JzHKxzMO0+9KTsKsQR8er/CvFEQL+ALqUpVpDzNBoAX1jVG21qTYcXJ3LYSOgKHuv7yJ
         zwYeHiAH9+u6BHChET26c400l+T+vucOFJSbEqxRyjyLqqYz9dCYu9IN29A0PNEsWjpR
         +tOg==
X-Gm-Message-State: APjAAAXUwCDmJOtT75ljC5tz2YsZUMp7am4fs3Y3b9EYutNLxIE5Kl9Y
        Ny13ZWa/bREswIMCGNvP78lHq4uVHFDWROWvViPg7Q==
X-Google-Smtp-Source: APXvYqz4Wv3AkrCfOh8oziWK3sALJRx+kVJ83dMavDz796ZdwqqTDdu/P/JvbNY53ztyQ6M3c1B+qT9VQinwMDCoWt0=
X-Received: by 2002:a2e:978e:: with SMTP id y14mr6233454lji.206.1571412067347;
 Fri, 18 Oct 2019 08:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net> <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
 <20191017095015.GI2311@hirez.programming.kicks-ass.net> <7edb1b73-54e7-5729-db5d-6b3b1b616064@arm.com>
 <20191017190708.GF22902@worktop.programming.kicks-ass.net>
 <0b807cb3-6a88-1138-dc66-9a32d9bba7ea@arm.com> <20191018120719.GH2328@hirez.programming.kicks-ass.net>
 <32d07c51-847d-9d51-480c-c8836f1aedc7@arm.com>
In-Reply-To: <32d07c51-847d-9d51-480c-c8836f1aedc7@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 18 Oct 2019 17:20:55 +0200
Message-ID: <CAKfTPtCECmWy9rTE1rgKd6uXcQCixZ3G7OLAM=Q=T5EM2414ZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        dh.han@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 18 Oct 2019 at 16:44, Douglas Raillard <douglas.raillard@arm.com> wrote:
>
>
>
> On 10/18/19 1:07 PM, Peter Zijlstra wrote:
> > On Fri, Oct 18, 2019 at 12:46:25PM +0100, Douglas Raillard wrote:
> >
> >>> What I don't see is how that that difference makes sense as input to:
> >>>
> >>>     cost(x) : (1 + x) * cost_j
> >>
> >> The actual input is:
> >> x = (EM_COST_MARGIN_SCALE/SCHED_CAPACITY_SCALE) * (util - util_est)
> >>
> >> Since EM_COST_MARGIN_SCALE == SCHED_CAPACITY_SCALE == 1024, this factor of 1
> >> is not directly reflected in the code but is important for units
> >> consistency.
> >
> > But completely irrelevant for the actual math and conceptual
> > understanding.
>
>  > how that that difference makes sense as input to
> I was unsure if you referred to the units being inconsistent or the
> actual way of computing values being strange, so I provided some
> justification for both.
>
> > Just because computers suck at real numbers, and floats
> > are expensive, doesn't mean we have to burden ourselves with fixed point
> > when writing equations.
> >
> > Also, as a physicist I'm prone to normalizing everything to 1, because
> > that's lazy.
> >
> >>> I suppose that limits the additional OPP to twice the previously
> >>> selected cost / efficiency (see the confusion from that other email).
> >>> But given that efficency drops (or costs rise) for higher OPPs that
> >>> still doesn't really make sense..
> >
> >> Yes, this current limit to +100% freq boosting is somehow arbitrary and
> >> could probably benefit from being tunable in some way (Kconfig option
> >> maybe). When (margin > 0), we end up selecting an OPP that has a higher cost
> >> than the one strictly required, which is expected. The goal is to speed
> >> things up at the expense of more power consumed to achieve the same work,
> >> hence at a lower efficiency (== higher cost).
> >
> > No, no Kconfig knobs.
> >
> >> That's the main reason why this boosting apply a margin on the cost of the
> >> selected OPP rather than just inflating the util. This allows controlling
> >> directly how much more power (battery life) we are going to spend to achieve
> >> some work that we know could be achieved with less power.
> >
> > But you're not; the margin is relative to the OPP, it is not absolute.
>
> Considering a CPU with 1024 max capacity (since we are not talking about
> migrations here, we can ignore CPU invariance):
>
> work = normalized number of iterations of a given busy loop
> # Thanks to freq invariance
> work = util (between 0 and 1)
> util = f/f_max
>
> # f(work) is the min freq that is admissible for "work", which we will
> # abbreviate as "f"
> f(work) = work * f_max
>
> # from struct em_cap_state doc in energy_model.h
> cost(f) = power(f) * f_max / f
> cost(f) = power(f) / util
> cost(f) = power(f) / work
> power(f) = cost(f) * work
>
> boosted_cost(f) = cost(f) + x
> boosted_power(f) = boosted_cost(f) * work
> boosted_power(f) = (cost(f) + x) * work
>
> # Let's normalize cost() so we can forget about f and deal only with work.
> cost'(work) = cost(f)/cost(f_max)
> x' = x/cost(f_max)
> boosted_power'(work) = (cost'(work) + x') * work
> boosted_power'(work) = cost'(work) * work + x' * work
> boosted_power'(work) = power'(work) + x' * work
> boosted_power'(work) = power'(work) + A(work)
>
> # Over a duration T, spend an extra B unit of energy
> B(work) = A(work) * T
> lost_battery_percent(work) = 100 * B(work)/total_battery_energy
> lost_battery_percent(work) = 100 * T * x' * work /total_battery_energy
> lost_battery_percent(work) =
>   (100 * T / cost(f_max) / total_battery_energy) * x * work
>
> This means that the effect of boosting on battery life is proportional
> to "x" unless I made a mistake somewhere.

Because the boost is relative to cost(f) and cost is not linear to the
frequency, I don't think that it's is a linear relation.

>
> >
> > Or rather, the only actual limit is in relation to the max OPP. So you
> > have very little actual control over how much more energy you're
> > spending.
> >
> >>> So while I agree that 2) is a reasonable signal to work from, everything
> >>> that comes after is still much confusing me.
> >
> >> "When applying these boosting rules on the runqueue util signals ...":
> >> Assuming the set of enqueued tasks stays the same between 2 observations
> >> from schedutil, if we see the rq util_avg increase above its
> >> util_est.enqueued, that means that at least one task had its util_avg go
> >> above util_est.enqueued. We might miss some boosting opportunities if some
> >> (util - util_est) compensates:
> >> TASK_1(util - util_est) = - TASK_2(util - util_est)
> >> but working on the aggregated value is much easier in schedutil, to avoid
> >> crawling the list of entities.
> >
> > That still does not explain why 'util - util_est', when >0, makes for a
> > sensible input into an OPP relative function > I agree that 'util - util_est', when >0, indicates utilization is
> > increasing (for the aperiodic blah blah blah). But after that I'm still
> > confused.
>
> For the same reason PELT makes a sensible input for OPP selection.
> Currently, OPP selection is based on max(util_avg, util_est.enqueued)
> (from cpu_util_cfs in sched.h), so as soon as we have
> (util - util_est > 0), the OPP will be selected according to util_avg.
> In a way, using util_avg there is already some kind of boosting.
>
> Since the boosting is essentially (util - constant), it grows the same
> way as util. If we think of (util - util_est) as being some estimation
> of how wrong we were in the estimation of the task "true" utilization of
> the CPU, then it makes sense to feed that to the boost. The wronger we
> were, the more we want to boost, because the more time passes, the more
> the scheduler realizes it actually does not know what the task needs. In
> doubt, provide a higher freq than usual until we get to know this task
> better. When that happens (at the next period), boosting is disabled and
> we revert to the usual behavior (aka margin=0).
>
> Hope we are converging to some wording that makes sense.
