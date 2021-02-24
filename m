Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E0323C11
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhBXMrG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 07:47:06 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40025 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhBXMrD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 07:47:03 -0500
Received: by mail-ot1-f48.google.com with SMTP id b8so1983479oti.7;
        Wed, 24 Feb 2021 04:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6jB0IWEXg2hyE52rBNDsQmAI4TXSzoyWftlUHEZ3npU=;
        b=sT+lh+Leju4gBXc6zaymHskmfw+c5bFqoI7nlDxz8V8lK8UGlHagZP+46m9IYY8U4K
         YL1qQNYOX9fRNzJyEFOZMVqrxQ3oou1EIQnJccavsGdsyi2IgAtPTA40Wir4ZPfGgJ/+
         30VB7CwrKSisyvMsQ/8027zz8cfZr4dr4iyRCEhuFQU3RtN3NY4aL2Ro7H0WUH9rb0kM
         Uo9uDdNw3N44xf+XPd2rv6fIQp603sJQn0/efE2nch3C2nTiw88eYmjKnBQqK/TQcc9u
         mrjUQfmKVyXaL/8WAseaumZao+tEfbEgcQa4yhDLB4prjI3Kl6oHAl+H0eA0TUdfpzRC
         T81A==
X-Gm-Message-State: AOAM533V3HOacZEH6KNBTbB8BweVm1wfyxpkfWV2eshkLyZfcTXY4wXE
        gh54S6tCWdEirjjcTfKjm9HEqNpUIOg0h1Z8PPQ=
X-Google-Smtp-Source: ABdhPJx0enaS2hTi5q7KlOAmTRY3RKlyy8XwiRNO/88tppv++ojpnGyqvRlYpyDHETK4Q6aP/s7YQcDXxs5EEbMpvTs=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr3606524otr.260.1614170782934;
 Wed, 24 Feb 2021 04:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20210218082514.1437-1-zbestahu@gmail.com> <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
 <20210219113804.00004a7e.zbestahu@gmail.com> <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
 <20210219144140.00004de9.zbestahu@gmail.com> <20210219074249.2hcwcnakihor343h@vireshk-i7>
 <20210219162026.00002e2b.zbestahu@gmail.com> <20210219093551.bykqhjk6xvs4kszi@vireshk-i7>
 <20210219194509.00005884.zbestahu@gmail.com> <20210222053014.s45odi3qsfio2ahp@vireshk-i7>
 <20210222170420.000019a3.zbestahu@163.com> <CAJZ5v0jouxkj5uKrkNSBZUxXkSNjGY5NAo3zAqSaO9rJBGcqCQ@mail.gmail.com>
 <20210224102435.00006325.zbestahu@gmail.com>
In-Reply-To: <20210224102435.00006325.zbestahu@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Feb 2021 13:46:11 +0100
Message-ID: <CAJZ5v0jfSuWF2LX5c475P0hM0QED6SsWe_BdcogcPM2_8qpztA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to busy
 CPU if need_freq_update is set
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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

On Wed, Feb 24, 2021 at 3:24 AM Yue Hu <zbestahu@gmail.com> wrote:
>
> On Mon, 22 Feb 2021 15:30:34 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Mon, Feb 22, 2021 at 2:57 PM Yue Hu <zbestahu@163.com> wrote:
> > >
> > > On Mon, 22 Feb 2021 11:00:14 +0530
> > > Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > > On 19-02-21, 19:45, Yue Hu wrote:
> > > > > We will set next_f to next_freq(previous freq) if next_f is
> > > > > reduced for busy CPU. Then the next sugov_update_next_freq() will check
> > > > > if next_freq matches next_f if need_freq_update is not set.
> > > > > Obviously, we will do nothing for the case. And The related check to
> > > > > fast_switch_enabled and raw_spin_{lock,unlock} operations are
> > > > > unnecessary.
> > > >
> > > > Right, but we will still need sugov_update_next_freq() to have the
> > > > same implementation regardless and so I am not sure if we should add
> > >
> > > Yes, sugov_update_next_freq() should be keeping current logic for corner case.
> > >
> > > > this change:
> > > >
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > index 41e498b0008a..7289e1adab73 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -362,6 +362,9 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
> > > >          * recently, as the reduction is likely to be premature then.
> > > >          */
> > > >         if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > > > +               if (!sg_policy->need_freq_update)
> > >
> > > The initial purpose about code of `next_f = sg_policy->next_freq` here (for special CPU busy
> > > case) should be skipping the freq update.
> > >
> > > Since commit 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits change"),
> > > we add the check to busy CPU for not skipping the update, we need to update the freq using
> > > computed one because limits change.
> > >
> > > After commit 23a881852f3e ("cpufreq: schedutil: Don't skip freq update if need_freq_update
> > > is set"), we removed the need_freq_update check(no issue of commit 600f5badb78c anymore?)
> > > and introduce to always do an update in sugov_update_next_freq() if need_freq_update is set
> > > even though current freq == sg_policy->next_freq because of corner case issue. But that is
> > > conflict with original purpose of the freq skip code (next_f = sg_policy->next_freq) of
> > > busy CPU.
> >
> > That's because we realized that it was not always a good idea to skip
> > the update even if next_f == sg_policy->next_freq.
> >
> > That's why CPUFREQ_NEED_UPDATE_LIMITS has been introduced and the
> > current flow is a result of subsequent code rearrangements.
>
> ok, care about unnecessary(should be) behaviors(fast_switch_enabled and raw_spin_{lock,unlock})
> if need_freq_update is unset?
>
> If we care, i will send another patch (which is different from above change for busy CPU).

Please send a patch and we'll see (this is how things go).
