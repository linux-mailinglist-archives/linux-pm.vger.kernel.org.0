Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2002A9A5A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 18:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgKFRC6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 12:02:58 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:33559 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgKFRC5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 12:02:57 -0500
Received: by mail-oo1-f67.google.com with SMTP id u5so499277oot.0;
        Fri, 06 Nov 2020 09:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rk7T64LoL7N2SeWrLIWOJBC0gy4oWD2nnIdv4KYgYXw=;
        b=YMILLRrLtqdYIStpxB3EDxgEr/cBxPExUa4od9eJP1mVE+7VHbPvu43z5I6EzV5iKi
         UccEMA7rB3B42oyOdvPVAYiAYga9CI4xwJFXDyOUFlZA/TXQ/x9Uij9toWQ+YaLLZUwz
         6Aj6dsdVid0YBrzTT8q9HzMsC18AoZLU1cEXJjx39PmubrQi8qMWP40eX3ZOzU3/DKBf
         i1RXk32/S0bTa57bN1F+iQi733LRS/exZLNQO2m+TzmSmUX8hKkK7//fHwov4mZEoRzS
         GB9QvAEKJqRjl+lrdW5mWaSjv850ODqRJOCq/u85OkfrOfjRND+yNgxJu/12uVAZfIca
         tAkQ==
X-Gm-Message-State: AOAM530CTCXWVgiGeuI24czdiTyZuSB4Vy6JXqxZ37mALRQuOvw7GT7g
        DbY+jt0/fn/qLklkxl6kfwk9WJmDqaTpw7JVkRw=
X-Google-Smtp-Source: ABdhPJw9guvs1ATyoICfMDk+D2jRXImbBOPCrTGgy/a9Nuv0PHva1gqeJXIU7vYb67LYFW9M4QT/D5ORPTF4DyPHOv4=
X-Received: by 2002:a4a:d815:: with SMTP id f21mr1918338oov.44.1604682176990;
 Fri, 06 Nov 2020 09:02:56 -0800 (PST)
MIME-Version: 1.0
References: <7417968.Ghue05m4RV@kreacher> <2233690.N3OVLkotou@kreacher> <20201106100712.u336gbtblaxr2cit@vireshk-i7>
In-Reply-To: <20201106100712.u336gbtblaxr2cit@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Nov 2020 18:02:45 +0100
Message-ID: <CAJZ5v0gT07K-oPa0=f8+Fq6tevqZJ8iWYjtf9YDNUJw1GJEBBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: Introduce target min and max frequency hints
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 6, 2020 at 11:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-11-20, 19:23, Rafael J. Wysocki wrote:
> > Index: linux-pm/include/linux/cpufreq.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/cpufreq.h
> > +++ linux-pm/include/linux/cpufreq.h
> > @@ -63,6 +63,8 @@ struct cpufreq_policy {
> >
> >       unsigned int            min;    /* in kHz */
> >       unsigned int            max;    /* in kHz */
> > +     unsigned int            target_min; /* in kHz */
> > +     unsigned int            target_max; /* in kHz */
> >       unsigned int            cur;    /* in kHz, only needed if cpufreq
> >                                        * governors are used */
> >       unsigned int            suspend_freq; /* freq to set during suspend */
>
> Rafael, honestly speaking I didn't like this patch very much.

So what's the concern, specifically?

> We need to fix a very specific problem with the intel-pstate driver when it is
> used with powersave/performance governor to make sure the hard limits
> are enforced. And this is something which no one else may face as
> well.

Well, I predict that the CPPC driver will face this problem too at one point.

As well as any other driver which doesn't select OPPs directly for
that matter, at least to some extent (note that intel_pstate in the
"passive" mode without HWP has it too, but since there is no way to
enforce the target max in that case, it is not relevant).

> What about doing something like this instead in the intel_pstate
> driver only to get this fixed ?
>
>         if (!strcmp(policy->governor->name, "powersave") ||
>             !strcmp(policy->governor->name, "performance"))
>                 hard-limit-to-be-enforced;
>
> This would be a much simpler and contained approach IMHO.

I obviously prefer to do it the way I did in this series, because it
is more general and it is based on the governor telling the driver
what is needed instead of the driver trying to figure out what the
governor is and guessing what may be needed because of that.

But if you have a very specific technical concern regarding my
approach, I can do it the other way too.

Cheers!
