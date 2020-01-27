Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA15C14A8C8
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 18:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgA0RQb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 12:16:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33001 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0RQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 12:16:31 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so6773156lfl.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2020 09:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bYkFYyzlADrxfOOfruFV0DySun5/W9XTnyRwJfjfl8=;
        b=Hb4Rm2T3zMuJm3b53/HOriq6QnhhM4oHwG+MhubxkYBndXSiHaxpqD3mo+IRm4trT4
         XYk6UAypgr0YsWLDyS8qLN3aeh1fA7epeD4WgbVujBms7TsmryWy0IWNPw+oxid0iN+j
         dgd6t/LaIkL0XTTn2/cRx4u44jdloPponwQ9YZmbK2m6kki8JEXjvmZTzRK/e4LJx390
         pIC7U/t8iALoRiWYIVQjc/1feajrW0rwUNwdOdvRZilTBOq9MaRa8nseMZjyYzCMJ0A+
         Vv6bxq/W6kpxrZl+rAMq795OWBTvewcWUq/nkd+uq6H4AQ5zLjIsVOH+L3napUC36SQ5
         rVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bYkFYyzlADrxfOOfruFV0DySun5/W9XTnyRwJfjfl8=;
        b=mx4Cu9q0YxZFQMjbRiXtAoc9yIJzsVi4QP5lqmYiGNboc2h/YDH9F34HcDU2I4B+JD
         Q61hKWdlIwwSgczNBEzz3ulGeLjIZSraV/tDlgvFmLcdizCJjUt56EkTHRKQV1H7oAFT
         BIFsmSHOBcqjflVjAWw4NW/AKU/1u/OrVn1bF2ZoBTEzjTYmvc5IUfpc7mOV3z7dWkbX
         Gr9MnpEbzrD3jYPE6m4fm6XBJSihGUK/oDwBbF6e5KvggUDa/V68hmUGlp76F+6gPUyX
         v9ujUIiFJImN8d3e40KjdinEEMfNNteWEReaROp05jQIyON6xtxCOoHTHOVignoyVT2c
         l0+A==
X-Gm-Message-State: APjAAAUZpG4BzLGvgqJdRHvduCWCTLHfCkUy0mb38QpysDztqxoHxLq/
        a2zRUQ6qQnFbLxC4yWWz0u7x5XO7W9607bLeDY8IXg==
X-Google-Smtp-Source: APXvYqwSM9E4ObJW0+KiBcC3xZJ7rr4nNUeeJHxI+9QUmq6ihZlCdhupuSZY8zan8cLAf3ZeGlJpgjnryNYn/qaObY8=
X-Received: by 2002:a19:5504:: with SMTP id n4mr8124769lfe.25.1580145388644;
 Mon, 27 Jan 2020 09:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
In-Reply-To: <20200122173538.1142069-1-douglas.raillard@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 Jan 2020 18:16:17 +0100
Message-ID: <CAKfTPtC9A6KVwYsQWgXXk-12GeJhkJfEm3Lk=LjcoOJvvoZ1uA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 22 Jan 2020 at 18:36, Douglas RAILLARD <douglas.raillard@arm.com> wrote:
>
> Make schedutil cpufreq governor energy-aware.
>
> - patch 1 introduces a function to retrieve a frequency given a base
>   frequency and an energy cost margin.
> - patch 2 links Energy Model perf_domain to sugov_policy.
> - patch 3 updates get_next_freq() to make use of the Energy Model.
> - patch 4 adds sugov_cpu_ramp_boost() function.
> - patch 5 updates sugov_update_(single|shared)() to make use of
>   sugov_cpu_ramp_boost().
> - patch 6 introduces a tracepoint in get_next_freq() for
>   testing/debugging. Since it's not a trace event, it's not exposed to
>   userspace in a directly usable way, allowing for painless future
>   updates/removal.
>
> The benefits of using the EM in schedutil are twofold:
>
> 1) Selecting the highest possible frequency for a given cost. Some
>    platforms can have lower frequencies that are less efficient than
>    higher ones, in which case they should be skipped for most purposes.

This make sense. Why using a lower frequency when a higher one is more
power efficient

>    They can still be useful to give more freedom to thermal throttling
>    mechanisms, but not under normal circumstances.
>    note: the EM framework will warn about such OPPs "hertz/watts ratio
>    non-monotonically decreasing"
>
> 2) Driving the frequency selection with power in mind, in addition to
>    maximizing the utilization of the non-idle CPUs in the system.
>
> Point 1) is implemented in "PM: Introduce em_pd_get_higher_freq()" and
> enabled in schedutil by
> "sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()".
>
> Point 2) is enabled in
> "sched/cpufreq: Boost schedutil frequency ramp up". It allows using
> higher frequencies when it is known that the true utilization of
> currently running tasks is exceeding their previous stable point.
> The benefits are:
>
> * Boosting the frequency when the behavior of a runnable task changes,
>   leading to an increase in utilization. That shortens the frequency
>   ramp up duration, which in turns allows the utilization signal to
>   reach stable values quicker.  Since the allowed frequency boost is
>   bounded in energy, it will behave consistently across platforms,
>   regardless of the OPP cost range.

Could you explain this a bit more ?

>
> * The boost is only transient, and should not impact a lot the energy
>   consumed of workloads with very stable utilization signals.
>
> This has been lightly tested with a rtapp task ramping from 10% to 75%
> utilisation on a big core.

Which kind of UC are you targeting ?

Do you have some benchmark showing the benefit and how you can bound
the increase of energy ?

The benefit of point2 is less obvious for me. We already have uclamp
which helps to overwrite the "utilization" that is seen by schedutil
to boost or cap the frequency when some tasks are running. I'm curious
to see what would be the benefit of this on top.

>
> v1 -> v2:
>
>   * Split the new sugov_cpu_ramp_boost() from the existing
>     sugov_cpu_is_busy() as they seem to seek a different goal.
>
>   * Implement sugov_cpu_ramp_boost() based on CFS util_avg and
>     util_est_enqueued signals, rather than using idle calls count.
>     This makes the ramp boost much more accurate in finding boost
>     opportunities, and give a "continuous" output rather than a boolean.
>
>   * Add EM_COST_MARGIN_SCALE=1024 to represent the
>     margin values of em_pd_get_higher_freq().
>
> v2 -> v3:
>
>   * Check util_avg >= sg_cpu->util_avg in sugov_cpu_ramp_boost_update()
>     to avoid boosting when the utilization is decreasing.
>
>   * Add a tracepoint for testing.
>
> v3 -> v4:
>
>   * em_pd_get_higher_freq() now interprets the margin as absolute,
>     rather than relative to the cost of the base frequency.
>
>   * Modify misleading comment in em_pd_get_higher_freq() since min_freq
>     can actually be higher than the max available frequency in normal
>     operations.
>
> Douglas RAILLARD (6):
>   PM: Introduce em_pd_get_higher_freq()
>   sched/cpufreq: Attach perf domain to sugov policy
>   sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()
>   sched/cpufreq: Introduce sugov_cpu_ramp_boost
>   sched/cpufreq: Boost schedutil frequency ramp up
>   sched/cpufreq: Add schedutil_em_tp tracepoint
>
>  include/linux/energy_model.h     |  56 ++++++++++++++
>  include/trace/events/power.h     |   9 +++
>  kernel/sched/cpufreq_schedutil.c | 124 +++++++++++++++++++++++++++++--
>  3 files changed, 182 insertions(+), 7 deletions(-)
>
> --
> 2.24.1
>
