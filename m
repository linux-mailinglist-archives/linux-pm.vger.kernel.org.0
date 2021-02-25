Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1107C324897
	for <lists+linux-pm@lfdr.de>; Thu, 25 Feb 2021 02:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBYBjE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 20:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhBYBjC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 20:39:02 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D698C061574;
        Wed, 24 Feb 2021 17:38:21 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t26so2743539pgv.3;
        Wed, 24 Feb 2021 17:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tnYBYbRsT961WK2ev0Rbh+EcQBNdVkmVWWLFnK3URxk=;
        b=UUwVQcG4PTWGWXKYkzvoRHtHEUq0WNbBEpyvDvWP3fMNY01a2NsbFmLLITwL5TF7jV
         VBDsPH/01Hhxj7FAkkf8UWJ7o9xIyD2Ncqe1sFBYm2Y/hu4tMnKBiCSPAOm44yfZvNx+
         t9U1Q8a6sarq5WjfAOcAFjShzn3h+iGyfq38jnH0BeQLj2iV+EHKDIcOQJbMPkcPm7/r
         1iChX8jE1RE5/SDkYKPczDcZtklFKgGOOfBCtMW5cgOAKq4CQz4BpKYO5lvXcFLS8rXe
         MCd3KXHMT9TFZeeVgrRB7VtWUTofY7W5RZ7MkxupCCQIG+dowMcsYtI8aKf8INkAK8dx
         xTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tnYBYbRsT961WK2ev0Rbh+EcQBNdVkmVWWLFnK3URxk=;
        b=XIK7Bzpq+t8wNCcEJyXhoEzg0xHL9zWWdrTpP3/ZF2t7g/YDeKOGdlQegEBOnN3Jwv
         ogZsmL5fi6zalMZMUXXJgxHfzf8Fq+EnOItKUPacJ6RMuA82R6iwRJ6DAPt5Nd939VRA
         aGNc5RPssNbQqFU7gjzhqDVIXRO2Rb3DoaF1XshHH7ZKPFHKZ+u5qcb1F8dRapYzpKR4
         F+hud/4+OeEyW0AVproQ/7TFntRghajjJ7FB4lGq+xjDZos0uIs2aA1RP3Foy5Hv08Eu
         8CgHGGYfIRNh8I/So2fKAoWFbzeZDJtLo1FW5YL6FC9zNRu8X66lqcMXDP4WMu2S5WOy
         hicQ==
X-Gm-Message-State: AOAM53211YlLe/zLgVnq5Qgtj/yV/jZ6UG4dI8QAHaTBfbrBmxtu4qW/
        bC8V47TY69G32M0R2j+h+jA=
X-Google-Smtp-Source: ABdhPJwaBaQqGlpkRe/Jl4qJ15wo0xrC9OZFfV3xikodpbQmGUYyqucqYzDvY+I+iND9VbTEqyabyg==
X-Received: by 2002:a05:6a00:1502:b029:1d2:72e7:a9db with SMTP id q2-20020a056a001502b02901d272e7a9dbmr838221pfu.42.1614217101047;
        Wed, 24 Feb 2021 17:38:21 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id u129sm3944828pfu.219.2021.02.24.17.38.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Feb 2021 17:38:20 -0800 (PST)
Date:   Thu, 25 Feb 2021 09:38:20 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
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
Message-ID: <20210225093820.000071dd.zbestahu@gmail.com>
In-Reply-To: <CAJZ5v0jfSuWF2LX5c475P0hM0QED6SsWe_BdcogcPM2_8qpztA@mail.gmail.com>
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
        <20210224102435.00006325.zbestahu@gmail.com>
        <CAJZ5v0jfSuWF2LX5c475P0hM0QED6SsWe_BdcogcPM2_8qpztA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Feb 2021 13:46:11 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Feb 24, 2021 at 3:24 AM Yue Hu <zbestahu@gmail.com> wrote:
> >
> > On Mon, 22 Feb 2021 15:30:34 +0100
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >  
> > > On Mon, Feb 22, 2021 at 2:57 PM Yue Hu <zbestahu@163.com> wrote:  
> > > >
> > > > On Mon, 22 Feb 2021 11:00:14 +0530
> > > > Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >  
> > > > > On 19-02-21, 19:45, Yue Hu wrote:  
> > > > > > We will set next_f to next_freq(previous freq) if next_f is
> > > > > > reduced for busy CPU. Then the next sugov_update_next_freq() will check
> > > > > > if next_freq matches next_f if need_freq_update is not set.
> > > > > > Obviously, we will do nothing for the case. And The related check to
> > > > > > fast_switch_enabled and raw_spin_{lock,unlock} operations are
> > > > > > unnecessary.  
> > > > >
> > > > > Right, but we will still need sugov_update_next_freq() to have the
> > > > > same implementation regardless and so I am not sure if we should add  
> > > >
> > > > Yes, sugov_update_next_freq() should be keeping current logic for corner case.
> > > >  
> > > > > this change:
> > > > >
> > > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > > index 41e498b0008a..7289e1adab73 100644
> > > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > > @@ -362,6 +362,9 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
> > > > >          * recently, as the reduction is likely to be premature then.
> > > > >          */
> > > > >         if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > > > > +               if (!sg_policy->need_freq_update)  
> > > >
> > > > The initial purpose about code of `next_f = sg_policy->next_freq` here (for special CPU busy
> > > > case) should be skipping the freq update.
> > > >
> > > > Since commit 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits change"),
> > > > we add the check to busy CPU for not skipping the update, we need to update the freq using
> > > > computed one because limits change.
> > > >
> > > > After commit 23a881852f3e ("cpufreq: schedutil: Don't skip freq update if need_freq_update
> > > > is set"), we removed the need_freq_update check(no issue of commit 600f5badb78c anymore?)
> > > > and introduce to always do an update in sugov_update_next_freq() if need_freq_update is set
> > > > even though current freq == sg_policy->next_freq because of corner case issue. But that is
> > > > conflict with original purpose of the freq skip code (next_f = sg_policy->next_freq) of
> > > > busy CPU.  
> > >
> > > That's because we realized that it was not always a good idea to skip
> > > the update even if next_f == sg_policy->next_freq.
> > >
> > > That's why CPUFREQ_NEED_UPDATE_LIMITS has been introduced and the
> > > current flow is a result of subsequent code rearrangements.  
> >
> > ok, care about unnecessary(should be) behaviors(fast_switch_enabled and raw_spin_{lock,unlock})
> > if need_freq_update is unset?
> >
> > If we care, i will send another patch (which is different from above change for busy CPU).  
> 
> Please send a patch and we'll see (this is how things go).

Already sent it("Call sugov_update_next_freq() before check to fast_switch_enabled"). Please review.

Thank you.

