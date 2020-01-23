Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C08C146D23
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 16:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgAWPnT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 10:43:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46546 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgAWPnT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 10:43:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id 13so3250827oij.13;
        Thu, 23 Jan 2020 07:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvg7wSBuSfnR+jPryCZqogmG0U1OOdgKNdgdT9M+CAQ=;
        b=lyWkAB5M+lsG763lNA/3NM/KSFbKu0um0ESVtRBeilYaV0ybr2O+JzwuzCwsQ55HKL
         tDzRUFuFCY5OJ4gHN0hiVpnknpWgKjpkGfYQEM7O4VtoNggNMDtWR697MA6mVHXiVI00
         EgY9ke4n03QPLrs7IgSoSjxxW1Zj9JYfxFIZDODxpFM0jQPI115grrYroi08ktOXU3GK
         CbLiCSPCxQ+OG4fl22dg7SOqpy2+KNrF8QfWnV1nooHChigqnEX4UbzRvilJdvNpc7Kg
         UPFdOzghVMvbLv4zhGrKaVOMfZ4bk9pf4ioC7CGlumu2Jq4gx4UvljZgtMHxhON/dFqe
         e5gg==
X-Gm-Message-State: APjAAAVdVSqIPfFOVrasKvOUtStK/SZ6bFcq5pWnDkDiDLewCuIMj1En
        CWNqhg0XUlCbiHhqDLOqOr92XFPFJO+7PsjDJZw=
X-Google-Smtp-Source: APXvYqxCsrAW1z//6Pb/k1EDcWu7Q4HQzQvh5jIFIL3idRGPe6BEtYDcgbdULAUMwc/yPusaeuzyWoPhbY5Whd8XrR8=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr11231161oiy.110.1579794198623;
 Thu, 23 Jan 2020 07:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
In-Reply-To: <20200122173538.1142069-1-douglas.raillard@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jan 2020 16:43:07 +0100
Message-ID: <CAJZ5v0hL9AbpgivRGtCtqQo4XRYdt=SDjD=_FAVZmKAi=+VvzA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        qperret@google.com, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 22, 2020 at 6:36 PM Douglas RAILLARD
<douglas.raillard@arm.com> wrote:
>
> Make schedutil cpufreq governor energy-aware.

I have to say that your terminology is confusing to me, like what
exactly does "energy-aware" mean in the first place?

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

I guess you mean using the EM directly in schedutil (note that it is
used indirectly already, because of EAS), but that needs to be clearly
stated.

> 1) Selecting the highest possible frequency for a given cost. Some
>    platforms can have lower frequencies that are less efficient than
>    higher ones, in which case they should be skipped for most purposes.
>    They can still be useful to give more freedom to thermal throttling
>    mechanisms, but not under normal circumstances.
>    note: the EM framework will warn about such OPPs "hertz/watts ratio
>    non-monotonically decreasing"

While all of that is fair enough for platforms using the EM, do you
realize that the EM is not available on the majority of architectures
(including some fairly significant ones) and so adding overhead
related to it for all of them is quite less than welcome?

> 2) Driving the frequency selection with power in mind, in addition to
>    maximizing the utilization of the non-idle CPUs in the system.

Care to explain this?  I'm totally unsure what you mean here.

> Point 1) is implemented in "PM: Introduce em_pd_get_higher_freq()" and
> enabled in schedutil by
> "sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()".
>
> Point 2) is enabled in
> "sched/cpufreq: Boost schedutil frequency ramp up". It allows using
> higher frequencies when it is known that the true utilization of
> currently running tasks is exceeding their previous stable point.

Please explain "true utilization" and "stable point".

> The benefits are:
>
> * Boosting the frequency when the behavior of a runnable task changes,
>   leading to an increase in utilization. That shortens the frequency
>   ramp up duration, which in turns allows the utilization signal to
>   reach stable values quicker.  Since the allowed frequency boost is
>   bounded in energy, it will behave consistently across platforms,
>   regardless of the OPP cost range.

Sounds good.

Can you please describe the algorithm applied to achieve that?

> * The boost is only transient, and should not impact a lot the energy
>   consumed of workloads with very stable utilization signals.
