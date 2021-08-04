Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE3B3E05C9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhHDQWY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 12:22:24 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:42537 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhHDQWX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 12:22:23 -0400
Received: by mail-oi1-f181.google.com with SMTP id x15so3442855oic.9
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 09:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMbvxbG6oItl3iX85gnma2mVT4moY/ShzczGz3Jn4tw=;
        b=Qf9HsMMbLVqwiyQiPqgBfNhoDCZLd0DirtwV6MY0OTqvuNs1m8J1Vg1SzvcRl4Zayv
         rBwapgsiJwGdxHFXvHOnnXhPH/vvBzrJ4MFdarMwy0+XIbZhIUwSV6IuqX+X4hpGiKTd
         izFwVLJKjAapHZaLfoDwExnHtUWD2wB/bNd+5JOCo/3Xu7ZdVwBRaXbrnCGWaV3pWWmu
         iKBONVqyfiF9wW8TgcHnl3Duhht5fqnD7r3Dd0A4l1MU4FnaiIdMPqoV+QVCvgxInPMa
         ncz64xtiSnhgGaLpBucetocXhAnrm50gR4AItG5s4F22HWHFggjvfrFpelq9X751dq9H
         x5BA==
X-Gm-Message-State: AOAM5317bOrDDRH3BMMgN3Au5p7l96NjTQc6W+/CGHpvaQn/1yGi39rT
        JHASzZQrFZyycJDFj1EwA9ZaJvOktl5HJAib+BY=
X-Google-Smtp-Source: ABdhPJyiLLIQkw1Y90u8i/7a8AKtwDmANSGusTbGTKZ/zUmnZXjQ0HiAUGsI61fEMa59zW9+prs2b3GoWOiLY5vBI84=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr212405oib.71.1628094129379;
 Wed, 04 Aug 2021 09:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
In-Reply-To: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 18:21:58 +0200
Message-ID: <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 8, 2021 at 12:09 PM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> Hi all,
>
> Here's the new patch-set version that brings support for skipping
> inefficiencies found by the Energy Model. This version doesn't bring
> changes for all the drivers that could benefit from this work at the
> moment. I'll do that in the next version or in a separated patch-set.
> Also, it's been discussed that enabling RELATION_E should be a driver
> flag. This sadly needs to be read in functions that do not have access to
> cpufreq_driver. Hence, I created a new policy flag instead.
>
> A bit of context:
>
> We (Power team in Arm) are working with an experimental kernel for the
> Google's Pixel4 to evaluate and improve the current mainline performance
> and energy consumption on a real life device with Android.
>
> The SD855 SoC found in this phone has several OPPs that are inefficient.
> I.e. despite a lower frequency, they have a greater cost. (That cost being
> fmax * OPP power / OPP freq). This issue is twofold. First of course,
> running a specific workload at an inefficient OPP is counterproductive
> since it wastes wasting energy. But also, inefficient OPPs make a
> performance domain less appealing for task placement than it really is.
>
> We evaluated the change presented here by running 30 iterations of Android
> PCMark "Work 2.0 Performance". While we did not see any statistically
> significant performance impact, this change allowed to drastically improve
> the idle time residency.
>
>
>                            |   Running   |  WFI [1]  |    Idle   |
>    ------------------------+-------------+-----------+-----------+
>    Little cluster (4 CPUs) |    -0.35%   |   +0.35%  |   +0.79%  |
>    ------------------------+-------------+-----------+-----------+
>    Medium cluster (3 CPUs) |    -6.3%    |    -18%   |    +12%   |
>    ------------------------+-------------+-----------+-----------+
>    Big cluster    (1 CPU)  |    -6.4%    |    -6.5%  |    +2.8%  |
>    ------------------------+-------------+-----------+-----------+
>
> On the SD855, the inefficient OPPs are found on the little cluster. By
> removing them from the Energy Model, we make the most efficient CPUs more
> appealing for task placement, helping to reduce the running time for the
> medium and big CPUs. Increasing idle time is crucial for this platform due
> to the substantial energy cost differences among the clusters. Also,
> despite not appearing in the statistics (the idle driver used here doesn't
> report it), we can speculate that we also improve the cluster idle time.
>
> [1] WFI: Wait for interrupt.
>
> Changelog since v3:
>   - New freq-table relation CPUFREQ_RELATION_E.
>   - New CPUFreq driver flag CPUFREQ_READ_ENERGY_MODEL.
>   - EM flag to skip or not inefficiencies (driven by CPUFreq).
>   - Fix infinite loop in set_freq_table_efficiencies().
>
> Changelog since v2:
>   - Add separated support for inefficiencies into CPUFreq.
>   - Collect Reviewed-by for the first patch.
>
> Changelog since v1:
>   - Remove the Look-up table as the numbers weren't strong enough to
>     justify the implementation.
>   - Split the patch.
>
> Vincent Donnefort (9):
>   PM / EM: Fix inefficient states detection
>   PM / EM: Mark inefficient states
>   PM / EM: Extend em_perf_domain with a flag field
>   PM / EM: Allow skipping inefficient states
>   cpufreq: Add an interface to mark inefficient frequencies
>   cpufreq: Add a new freq-table relation CPUFREQ_RELATION_E
>   cpufreq: CPUFREQ_RELATION_E in schedutil ondemand and conservative
>   cpufreq: Add driver flag CPUFREQ_READ_ENERGY_MODEL
>   cpufreq: dt: Add CPUFREQ_READ_ENERGY_MODEL

The cpufreq changes are mostly fine by me now, but I would like to
hear from Viresh regarding this.

>
>  drivers/cpufreq/cpufreq-dt.c           |  2 +-
>  drivers/cpufreq/cpufreq.c              | 67 ++++++++++++++++++++++++++++++++-
>  drivers/cpufreq/cpufreq_conservative.c |  2 +-
>  drivers/cpufreq/cpufreq_ondemand.c     |  4 +-
>  drivers/cpufreq/freq_table.c           | 57 +++++++++++++++++++++++++++-
>  include/linux/cpufreq.h                | 50 +++++++++++++++++++++++--
>  include/linux/energy_model.h           | 68 +++++++++++++++++++++++++++++-----
>  kernel/power/energy_model.c            | 46 ++++++++++++++---------
>  kernel/sched/cpufreq_schedutil.c       |  2 +-
>  9 files changed, 260 insertions(+), 38 deletions(-)
>
> --
