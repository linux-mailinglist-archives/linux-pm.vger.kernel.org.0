Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC62D47B8
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 18:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgLIRSn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 12:18:43 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35357 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbgLIRSn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 12:18:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id s2so2514264oij.2;
        Wed, 09 Dec 2020 09:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SoQj+QbF0ONNi1OIKLfA3VzTncbES0l8Ii5LI408HQ8=;
        b=I+OqeO+RBIxXXu5EhyA+teu6wKnDTpmn2DWaTiguNlGGLRi8XVx+DOMDrSophB9C8I
         w52M41uDn7eCAR+bgZmfMHTabgDtZrcZCk15+09jywif8xsUEqrHiiqANs+Yd/4qcM9s
         do56mTUtBbAtHk2J/gWFo7enz9NeXMjy8Revkyaw/o+8nsV5xMUE+luDZb3jVISrdEu8
         W9oJEHznrIpeZkm8ttEYxSxhjtic2GW0fVrK2pHeLFKhsaJJ2xlw4vjK1g478la0Vqg3
         Ql1IEsrEYVRE8y3AZimt5uFvzePcjA2tDLprzwVU78D9wEWxFI27+At+iVVoCYr5ttfe
         rIKg==
X-Gm-Message-State: AOAM533HON0EkvTaB1SCWNfYwu+y7AUsePg0piEdykEaMKljAsHiAVGV
        qcewUB8kSkbDFrFVPSRzer7sCywXS/KuJgki5nw=
X-Google-Smtp-Source: ABdhPJyp0O7GqQJ3Ip38zyNmK56FEBQ2JjKPPK+jNvBlZenNQYtaxXl29+H+JEOVRtR4csC4lJC1DkY+0zO20jHYQ1A=
X-Received: by 2002:aca:5197:: with SMTP id f145mr2532130oib.71.1607534282442;
 Wed, 09 Dec 2020 09:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20360841.iInq7taT2Z@kreacher> <2344038.BgO4qI7qUv@kreacher> <20201208083344.s67kalyxuui3ia4q@vireshk-i7>
In-Reply-To: <20201208083344.s67kalyxuui3ia4q@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Dec 2020 18:17:51 +0100
Message-ID: <CAJZ5v0gT1fOOFc_JtidRz4W6osAER+96p8o2X7TS_wUPk2+sVQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] cpufreq: schedutil: Add util to struct sg_cpu
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 8, 2020 at 9:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 07-12-20, 17:28, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of passing util and max between functions while computing the
> > utilization and capacity, store the former in struct sg_cpu (along
> > with the latter and bw_dl).
> >
> > This will allow the current utilization value to be compared with the
> > one obtained previously (which is requisite for some code changes to
> > follow this one), but also it makes the code look slightly more
> > consistent and clean.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c |   42 ++++++++++++++++++---------------------
> >  1 file changed, 20 insertions(+), 22 deletions(-)
> >
> > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > @@ -53,6 +53,7 @@ struct sugov_cpu {
> >       unsigned int            iowait_boost;
> >       u64                     last_update;
> >
> > +     unsigned long           util;
> >       unsigned long           bw_dl;
> >       unsigned long           max;
> >
> > @@ -276,16 +277,15 @@ unsigned long schedutil_cpu_util(int cpu
> >       return min(max, util);
> >  }
> >
> > -static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> > +static void sugov_get_util(struct sugov_cpu *sg_cpu)
>
> Maybe name it sugov_update_util() ?

That might be somewhat confusing due to the existing meaning of "update_util".

> Otherwise,
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!
