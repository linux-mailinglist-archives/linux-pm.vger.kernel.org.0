Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D2D3235A8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 03:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhBXCZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Feb 2021 21:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBXCZY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2021 21:25:24 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E969C061574;
        Tue, 23 Feb 2021 18:24:44 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t5so2548914pjd.0;
        Tue, 23 Feb 2021 18:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08RD3+WJ7vaIpqiTbUAC13EVoDnZvgUrPz+Z+c2bvKU=;
        b=KSd+XRwbn3ViVFD5SdSb1Wla5o/NQHTU8r8jAyb5cL9P9Iyl2wZygaD2QscdKcBZRB
         fRn5BoeX+cYQ/uhBsq0Eyri+g0dx6I6moIKUdXkhSKXeX8tgaGM/Ud8gEZh56lB4FpkL
         U/8XgmDmRf8sJhP2K8eG90LO8x8jMa7UA2fgMIlSedpu4ZzR3KojyDBvN49URUMxh3Fi
         /WQJQizmxGUtT8vTtpipVcN1x3uyMy7RUX8Kt1BgZgu8veVkw+dgCkpXCi5ip7fx3s3f
         dCp69zUYW1S+G/In7bSMd9TXclk+oRvoiMJNuJ/5N3KR5qTuXFHTWffj+lSE5ps8YebX
         MZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08RD3+WJ7vaIpqiTbUAC13EVoDnZvgUrPz+Z+c2bvKU=;
        b=S2FVfnKmj9VzFY+Vh1uz+DDVlbI3twbRZzNFgoHUeubsxMqggYbrV+3kB//wtwGUqI
         WFIClSl5MF/ihBAD5icHpNVvYzTjjDzrcFclpPGyKD5jSkjI9eD+c2/yeNxSHrvQhUO5
         BoB/yliA3m6swp9IyGHkL+RXRxnSI+5l9RDfXJVSKR6uLOIKj/nya1WnpI1eHAJWkFZ7
         EHZ4QwLxGpr7fYwC1BpT/q8nz2lPRdPR4g448feCA+Jv0qJ56LeoPcuv+CGkYIydEeFb
         Wf8SZBwrFJE1KNJF7pT9D47nOC/R/tsBajnSeCKY3KFT+zQIROynCl6C3v6Foh+MgT86
         Fnpg==
X-Gm-Message-State: AOAM531eQNN/7AyEJrwDWPfdhqTVUM6k6miw7CEYZg5QH9GVhv3EjdnF
        cjstN13grITqV7/aL54wMxlyuFR4uWJbSA==
X-Google-Smtp-Source: ABdhPJyMoqWHyK5oKzGtASlTm7EXG9wUz7gtGJnjeSVXQQgeRdI9zuHzUEDIl0RChx0Em5B9JgG+RA==
X-Received: by 2002:a17:90a:3d0d:: with SMTP id h13mr1894283pjc.224.1614133484273;
        Tue, 23 Feb 2021 18:24:44 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id 67sm516404pfb.43.2021.02.23.18.24.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Feb 2021 18:24:44 -0800 (PST)
Date:   Wed, 24 Feb 2021 10:24:35 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to
 busy CPU if need_freq_update is set
Message-ID: <20210224102435.00006325.zbestahu@gmail.com>
In-Reply-To: <CAJZ5v0jouxkj5uKrkNSBZUxXkSNjGY5NAo3zAqSaO9rJBGcqCQ@mail.gmail.com>
References: <20210218082514.1437-1-zbestahu@gmail.com>
        <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
        <20210219113804.00004a7e.zbestahu@gmail.com>
        <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
        <20210219144140.00004de9.zbestahu@gmail.com>
        <20210219074249.2hcwcnakihor343h@vireshk-i7>
        <20210219162026.00002e2b.zbestahu@gmail.com>
        <20210219093551.bykqhjk6xvs4kszi@vireshk-i7>
        <20210219194509.00005884.zbestahu@gmail.com>
        <20210222053014.s45odi3qsfio2ahp@vireshk-i7>
        <20210222170420.000019a3.zbestahu@163.com>
        <CAJZ5v0jouxkj5uKrkNSBZUxXkSNjGY5NAo3zAqSaO9rJBGcqCQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 22 Feb 2021 15:30:34 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Feb 22, 2021 at 2:57 PM Yue Hu <zbestahu@163.com> wrote:
> >
> > On Mon, 22 Feb 2021 11:00:14 +0530
> > Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >  
> > > On 19-02-21, 19:45, Yue Hu wrote:  
> > > > We will set next_f to next_freq(previous freq) if next_f is
> > > > reduced for busy CPU. Then the next sugov_update_next_freq() will check
> > > > if next_freq matches next_f if need_freq_update is not set.
> > > > Obviously, we will do nothing for the case. And The related check to
> > > > fast_switch_enabled and raw_spin_{lock,unlock} operations are
> > > > unnecessary.  
> > >
> > > Right, but we will still need sugov_update_next_freq() to have the
> > > same implementation regardless and so I am not sure if we should add  
> >
> > Yes, sugov_update_next_freq() should be keeping current logic for corner case.
> >  
> > > this change:
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 41e498b0008a..7289e1adab73 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -362,6 +362,9 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
> > >          * recently, as the reduction is likely to be premature then.
> > >          */
> > >         if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > > +               if (!sg_policy->need_freq_update)  
> >
> > The initial purpose about code of `next_f = sg_policy->next_freq` here (for special CPU busy
> > case) should be skipping the freq update.
> >
> > Since commit 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits change"),
> > we add the check to busy CPU for not skipping the update, we need to update the freq using
> > computed one because limits change.
> >
> > After commit 23a881852f3e ("cpufreq: schedutil: Don't skip freq update if need_freq_update
> > is set"), we removed the need_freq_update check(no issue of commit 600f5badb78c anymore?)
> > and introduce to always do an update in sugov_update_next_freq() if need_freq_update is set
> > even though current freq == sg_policy->next_freq because of corner case issue. But that is
> > conflict with original purpose of the freq skip code (next_f = sg_policy->next_freq) of
> > busy CPU.  
> 
> That's because we realized that it was not always a good idea to skip
> the update even if next_f == sg_policy->next_freq.
> 
> That's why CPUFREQ_NEED_UPDATE_LIMITS has been introduced and the
> current flow is a result of subsequent code rearrangements.

ok, care about unnecessary(should be) behaviors(fast_switch_enabled and raw_spin_{lock,unlock})
if need_freq_update is unset? 

If we care, i will send another patch (which is different from above change for busy CPU).

Thank you.



