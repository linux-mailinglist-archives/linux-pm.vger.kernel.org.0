Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F71321A6A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 15:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhBVOdw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 09:33:52 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45604 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhBVObc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 09:31:32 -0500
Received: by mail-ot1-f50.google.com with SMTP id l16so3115785oti.12;
        Mon, 22 Feb 2021 06:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLCazOgCqLhMhGLjagf/Fn5ANchaVeFWA3OGXEWxjbw=;
        b=BVvuJjnAPGScG4locryb9JkYRx+hvBq5tIpFZWvvdXXz17ZhfveHAMlcfAKovZQWWE
         p4ioM1T7j3+5yn3e5yETdjuU9/2yFNE1q2rhx5NaYHf2N8iPlVd7tk0Gl+VtcEuDSAAG
         vRuPO2zbMxCY/68kBM4XKO9sEwDLiaOpFl/7S8NFRPbevN/WaQenVLEu7ybQc3N3KmWL
         pEdN1URexsi0NtCw6QdAU0duWSswa/HLQGdafFJBTX5tiTGnPql4qIcH0W+IIH31QfE/
         ZFDOOpxtxZoJaEA1wWO7M81lB9uxelyK+lxebXDzzTEurnwOLSByUB2XTTuw1Fb9g1m5
         KCrg==
X-Gm-Message-State: AOAM532QhvEaRnOgUU0GXtyeiot9g/zdPRDEjjYIFyO7K0aitETjyKd9
        gsp9c2KiIPCCRy5ZeBqY+WqVPdRGp4q1KbabiVI=
X-Google-Smtp-Source: ABdhPJyp5T0fvLilSZjXj0s8pz28nKjqaqGdEot5SDNgXw9VAkBQJ1X2Sk/QIsFXIFgc5CsOHmxm0VZ0/ZDZ7MmhSoc=
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr16715657otc.260.1614004250012;
 Mon, 22 Feb 2021 06:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20210218082514.1437-1-zbestahu@gmail.com> <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
 <20210219113804.00004a7e.zbestahu@gmail.com> <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
 <20210219144140.00004de9.zbestahu@gmail.com> <20210219074249.2hcwcnakihor343h@vireshk-i7>
 <20210219162026.00002e2b.zbestahu@gmail.com> <20210219093551.bykqhjk6xvs4kszi@vireshk-i7>
 <20210219194509.00005884.zbestahu@gmail.com> <20210222053014.s45odi3qsfio2ahp@vireshk-i7>
 <20210222170420.000019a3.zbestahu@163.com>
In-Reply-To: <20210222170420.000019a3.zbestahu@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Feb 2021 15:30:34 +0100
Message-ID: <CAJZ5v0jouxkj5uKrkNSBZUxXkSNjGY5NAo3zAqSaO9rJBGcqCQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to busy
 CPU if need_freq_update is set
To:     Yue Hu <zbestahu@163.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Yue Hu <zbestahu@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 22, 2021 at 2:57 PM Yue Hu <zbestahu@163.com> wrote:
>
> On Mon, 22 Feb 2021 11:00:14 +0530
> Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> > On 19-02-21, 19:45, Yue Hu wrote:
> > > We will set next_f to next_freq(previous freq) if next_f is
> > > reduced for busy CPU. Then the next sugov_update_next_freq() will check
> > > if next_freq matches next_f if need_freq_update is not set.
> > > Obviously, we will do nothing for the case. And The related check to
> > > fast_switch_enabled and raw_spin_{lock,unlock} operations are
> > > unnecessary.
> >
> > Right, but we will still need sugov_update_next_freq() to have the
> > same implementation regardless and so I am not sure if we should add
>
> Yes, sugov_update_next_freq() should be keeping current logic for corner case.
>
> > this change:
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 41e498b0008a..7289e1adab73 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -362,6 +362,9 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
> >          * recently, as the reduction is likely to be premature then.
> >          */
> >         if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > +               if (!sg_policy->need_freq_update)
>
> The initial purpose about code of `next_f = sg_policy->next_freq` here (for special CPU busy
> case) should be skipping the freq update.
>
> Since commit 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits change"),
> we add the check to busy CPU for not skipping the update, we need to update the freq using
> computed one because limits change.
>
> After commit 23a881852f3e ("cpufreq: schedutil: Don't skip freq update if need_freq_update
> is set"), we removed the need_freq_update check(no issue of commit 600f5badb78c anymore?)
> and introduce to always do an update in sugov_update_next_freq() if need_freq_update is set
> even though current freq == sg_policy->next_freq because of corner case issue. But that is
> conflict with original purpose of the freq skip code (next_f = sg_policy->next_freq) of
> busy CPU.

That's because we realized that it was not always a good idea to skip
the update even if next_f == sg_policy->next_freq.

That's why CPUFREQ_NEED_UPDATE_LIMITS has been introduced and the
current flow is a result of subsequent code rearrangements.
