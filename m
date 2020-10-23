Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9459A296E1B
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463356AbgJWL77 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 07:59:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33714 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369960AbgJWL77 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 07:59:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id t15so1071012otk.0;
        Fri, 23 Oct 2020 04:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVsEq+wRbGQg5Ha262jtQgKJ2V9xu+fwLoD8r3aBHAg=;
        b=X9BdsVdCspr4xaYTx6E3dGaxWFHAZZH6HQw+c4QR9azkCuyURku2iyguwgEXpz9um4
         W4/W52ZI6YEnE3/I8Ix+L+ItgES6tT1L5o32WyPmD6nZOtTAwy40bu/XhAs7rbf5PdUw
         ryAyPqEZIYs5/I+h23dfVff4ThnJIKI4bH/h4mfM8TuEIPmVMR1xprvL0o554CtV+i0r
         ybdYHH2DBHYTzjPnbYxZz0yHTx0as5xaf6jMZ81TLgbdvJizaSNLxptHuhApZyP2Zh5g
         rMQZRoxaeMhPP2NKfDk7bLpcQoqc9msvm+ebGj0PX9eacyG3xJ1z6KKAhUTiERK0MQ+d
         OiRg==
X-Gm-Message-State: AOAM533HiiUwpxLa+VGOZrPrpCa32mbR08Rl6L6YvTuIuWyiZ3ZTb2Pr
        AjgWKGQ5Hr+MLL3X3z9rWGryM0I9jwlDgEQ8gQk=
X-Google-Smtp-Source: ABdhPJyT5r2GaLzXcgx6D+Y+xfPH3602a59tadmtl2LzoO/Xu/5IGCPU+shg1Mg9Nm/Z3xXuiWIEx1h39/tU0iFa9EU=
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr1320247otq.321.1603454397748;
 Fri, 23 Oct 2020 04:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher> <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <8312288.dAKoTdFk2S@kreacher> <20201023061703.jjpmoeq7wzwqtsid@vireshk-i7>
In-Reply-To: <20201023061703.jjpmoeq7wzwqtsid@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Oct 2020 13:59:45 +0200
Message-ID: <CAJZ5v0gt42=KRbKzRp7H6RrRdpxY-T_X_L9JjcMB+9VrvKAdvw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Avoid configuring old governors as default with intel_pstate
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 23, 2020 at 8:17 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 22-10-20, 18:23, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] cpufreq: Avoid configuring old governors as default with intel_pstate
> >
> > Commit 33aa46f252c7 ("cpufreq: intel_pstate: Use passive mode by
> > default without HWP") was meant to cause intel_pstate without HWP
> > to be used in the passive mode with the schedutil governor on top of
> > it by default, but it missed the case in which either "ondemand" or
> > "conservative" was selected as the default governor in the existing
> > kernel config, in which case the previous old governor configuration
> > would be used, causing the default legacy governor to be used on top
> > of intel_pstate instead of schedutil.
> >
> > Address this by preventing "ondemand" and "conservative" from being
> > configured as the default cpufreq governor in the case when schedutil
> > is the default choice for the default governor setting.
> >
> > [Note that the default cpufreq governor can still be set via the
> >  kernel command line if need be and that choice is not limited,
> >  so if anyone really wants to use one of the legacy governors by
> >  default, it can be achieved this way.]
> >
> > Fixes: 33aa46f252c7 ("cpufreq: intel_pstate: Use passive mode by default without HWP")
> > Cc: 5.8+ <stable@vger.kernel.org> # 5.8+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/Kconfig |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> > Index: linux-pm/drivers/cpufreq/Kconfig
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/Kconfig
> > +++ linux-pm/drivers/cpufreq/Kconfig
> > @@ -71,6 +71,7 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
> >
> >  config CPU_FREQ_DEFAULT_GOV_ONDEMAND
> >       bool "ondemand"
> > +     depends on !SMP || !X86_INTEL_PSTATE
> >       select CPU_FREQ_GOV_ONDEMAND
> >       select CPU_FREQ_GOV_PERFORMANCE
> >       help
> > @@ -83,6 +84,7 @@ config CPU_FREQ_DEFAULT_GOV_ONDEMAND
> >
> >  config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
> >       bool "conservative"
> > +     depends on !SMP || !X86_INTEL_PSTATE
>
> While reading this first it felt like a SMP platforms related problem
> (which I was surprised about), and then I understood what you are
> doing.
>
> I wonder if rewriting it this way makes it more readable with same
> result eventually.
>
>         depends on !(X86_INTEL_PSTATE && SMP)

Agreed, will update.

Thanks!
