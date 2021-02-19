Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192A331FBD1
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 16:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBSPQ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 10:16:26 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:44635 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSPQY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 10:16:24 -0500
Received: by mail-oo1-f54.google.com with SMTP id n19so1325000ooj.11
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 07:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIpXvz7iO1eR8Fibsb0ECbi0y3OEdvmMmerA/7bWnWA=;
        b=Vttz/jpxYDLiLSxB698xsIMK0EyoodOLRsosGHifm9z+2N1Fe6cF0mHAW/XWYRAt86
         pJLihkBHWTPWpDp13pLpKbdASxQWB7saa2Cq9hT2da2iN1BmXo2mg2y/+1GywxxDs3h1
         uBMTC+d15k+rRvzBllk2kQg3I1Ylr1+u7pRyM1s7t9kFKfpmsYjHkDwSl09UafxkbmUZ
         gEmnkw83jAkpYVbmpb9VGk/H/REeeJ9kKSuVyzGAgySbnzQRnW0yM/o/sAgc5Xi282Mf
         H2k3iXFSzio6qHYVrsGuXmtlaDzZYV/mBnwuIAEeDNcwayzEGqrQH0K/CW3mh0JMj+ex
         2sKQ==
X-Gm-Message-State: AOAM5321fqMdoJM1Dt0DwN0bCtDsq7sYHEg/4wvcY1YRIJMVY4amXjwc
        l4EAr9gQuHAAjeI/TXRkI28JAOFRaT002A4aOQDjGYTu
X-Google-Smtp-Source: ABdhPJzlXZRRZvg3oazBRcUdiDGFSXTxDxBHFY3Bu1uYHBBiF8gXIOnJzgv6uZGa9VxeuVk1J3cTsptl6Ho2YE/5zYU=
X-Received: by 2002:a4a:3bcb:: with SMTP id s194mr7291533oos.1.1613747743011;
 Fri, 19 Feb 2021 07:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20210218093753.1700-1-zbestahu@gmail.com> <20210218093924.ye5i4vvwqqubkdqw@vireshk-i7>
In-Reply-To: <20210218093924.ye5i4vvwqqubkdqw@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Feb 2021 16:15:31 +0100
Message-ID: <CAJZ5v0jNtaRoUr4w3FWqavscmCoJ=2X+vKaFeQfcZ_j1kXwhaw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Remove comment to update_lock of
 struct sugov_policy
To:     Viresh Kumar <viresh.kumar@linaro.org>, Yue Hu <zbestahu@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 18, 2021 at 11:51 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Always mention version number and version history in a patch. Don't
> resend it now anyway.
>
> On 18-02-21, 17:37, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> >
> > Currently, update_lock is also used in sugov_update_single_freq(). The
> > comment is not helpful anymore.
> >
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index add8081..fd43d59 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -26,7 +26,7 @@ struct sugov_policy {
> >       struct sugov_tunables   *tunables;
> >       struct list_head        tunables_hook;
> >
> > -     raw_spinlock_t          update_lock;    /* For shared policies */
> > +     raw_spinlock_t          update_lock;
> >       u64                     last_freq_update_time;
> >       s64                     freq_update_delay_ns;
> >       unsigned int            next_freq;
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.12-rc material, thanks!
