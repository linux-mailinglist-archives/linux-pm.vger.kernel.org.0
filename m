Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49515292A94
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 17:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgJSPkC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 11:40:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43953 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgJSPkC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 11:40:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id k68so6422415otk.10;
        Mon, 19 Oct 2020 08:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQXDksdWJB9OPOkEy4qlnDk19u+YPFVgLo+Sa2g/Kho=;
        b=OQjvnSQZbqZoff/o1/9S3Cxm+FCAs+VPOmMFjejuvAYsrEDyEb4s92f1AVXjPwbkNl
         OZDMpWyuePDLSKsiU9+j2fyNS7alwFVcfHX3Kt3j0FPdbEy4eFjJgAQvDPhZCdNLdGn/
         W7LDX4SP52tbDGKOgi6kiyMUb+ripD61w+WnxyNtfaBt4Mho8fHu4cCQLPZoKZWPUSWK
         xrbbgCZV7G6EfeOd8FWjJ7QK88s+r9SyFCIilh5iF7Z1x/Diw4A5EJH1bN+NRTTYVIDl
         9SJuo7pif39chQTnYcwFM8mhAcZ1ZC5edVChiY+Kwj+CLUfOyVH8RwvAHmFXvOClwJTL
         x13Q==
X-Gm-Message-State: AOAM5302Gle0wvmYfEK+IXJ000ceAcsSkwuPwX9ZLHO6/n1cioWYs9B3
        cyjZ+hFrf8IIcqJYeqQfhYkWCmuCo4Lm0zA7ths=
X-Google-Smtp-Source: ABdhPJxV2jiT94je+9YQXAAdxh67yLt2Jd6HQXV8DuJOBcna4yNKkadtyZwauQAoMC/xI6EG+zjmgpvrHH3dhX2Ku+k=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr447185ote.206.1603122001657;
 Mon, 19 Oct 2020 08:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAGXk5yoNxZBD9gX-8RvtsqAwB4rO=hFQKBewFhOGoMO171aJVA@mail.gmail.com>
 <20201016181722.884812-1-wvw@google.com>
In-Reply-To: <20201016181722.884812-1-wvw@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Oct 2020 17:39:50 +0200
Message-ID: <CAJZ5v0jaftAQv9-=5YucNnm__Z7NWRWmN2mCO07i0ZhV9K5EsQ@mail.gmail.com>
Subject: Re: [PATCH] sched: cpufreq_schedutil: restore cached freq when next_f
 is not changed
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 8:17 PM Wei Wang <wvw@google.com> wrote:
>
> We have the raw cached freq to reduce the chance in calling cpufreq
> driver where it could be costly in some arch/SoC.
>
> Currently, the raw cached freq will be reset when next_f is changed for
> correctness. This patch changes it to maintain the cached value instead
> of dropping it to honor the purpose of the cached value.
>
> This is adapted from https://android-review.googlesource.com/1352810/
>
> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 5ae7b4e6e8d6..e254745a82cb 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -441,6 +441,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>         unsigned long util, max;
>         unsigned int next_f;
>         bool busy;
> +       unsigned int cached_freq = sg_policy->cached_raw_freq;
>
>         sugov_iowait_boost(sg_cpu, time, flags);
>         sg_cpu->last_update = time;
> @@ -464,8 +465,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>         if (busy && next_f < sg_policy->next_freq) {
>                 next_f = sg_policy->next_freq;
>
> -               /* Reset cached freq as next_freq has changed */
> -               sg_policy->cached_raw_freq = 0;
> +               /* Restore cached freq as next_freq has changed */
> +               sg_policy->cached_raw_freq = cached_freq;
>         }
>
>         /*
> --

Applied as 5.10-rc material with edited subject and rewritten changelog.

Thanks!
