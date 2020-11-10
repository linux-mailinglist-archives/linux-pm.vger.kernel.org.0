Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DAD2AD675
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 13:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgKJMhz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 07:37:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45515 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgKJMhz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 07:37:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id k3so12295103otp.12;
        Tue, 10 Nov 2020 04:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QoYrFCQ5CJmMIrhqt0RqrgCHrRtTqo29voVvZk6QCs=;
        b=daGhkMEHv3NpuX9LnL8b+3uJjL9JoasETr8TPLFAr0V27VkI1xrvhYp+Ct5zWCdLJ5
         v2zYgLGAMIrTzafESluNuDaxW4UI50+dXmJMFloIzdmiNyIyJWMhZuphAM0BBpTo7r1n
         K3X8BJvsBII5TG8QZYG/LssjynUID14bxYzU/R4YvVZf78A9t3IN6kWvA/NBru6mAsHE
         lNPbtQjdy/xIIyz1//m8ug8p0CA3yiPT78L7vZjydvnRX/kUcuId/RkLKJevCSgVvBKJ
         GmiCX8WkAsTupw5FtMGLlvfyIfXW2bGLV5g4tdzY6Ax7b5ch85OfuLaPS54HUx7Be9V8
         jNhg==
X-Gm-Message-State: AOAM530FQrD+NGy6zaCeBMkmx3Sm00dearWWedybvU3XJuWJdOnw7z8r
        Vxd+3MD7DGjtAYBR/UW1RBhbanZf5jvDdb81c9A=
X-Google-Smtp-Source: ABdhPJwcBw5dhEQbMo9t/KwNeyLrMoFkMypeKrr8wx2UrkC+jTX1H0p5zafUJa0NAd+djaH6w8QafJePmbDblSeMcbs=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr14526200ota.260.1605011874761;
 Tue, 10 Nov 2020 04:37:54 -0800 (PST)
MIME-Version: 1.0
References: <13269660.K2JYd4sGFX@kreacher> <2826323.52ZM0ncLkd@kreacher> <20201110024723.a5ouawbgj5ftyfe4@vireshk-i7>
In-Reply-To: <20201110024723.a5ouawbgj5ftyfe4@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 13:37:41 +0100
Message-ID: <CAJZ5v0i10hF-41OH7AUzgWwyWSgV_PObN=t1bGSS930dENw5uw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cpufreq: Add strict_target to struct cpufreq_policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 10, 2020 at 3:47 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 09-11-20, 17:53, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add a new field to be set when the CPUFREQ_GOV_FLAG_STRICT_TARGET
> > flag is set for the current governor to struct cpufreq_policy, so
> > that the drivers needing to check CPUFREQ_GOV_FLAG_STRICT_TARGET do
> > not have to access the governor object during every frequency
> > transition.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq.c |    2 ++
> >  include/linux/cpufreq.h   |    6 ++++++
> >  2 files changed, 8 insertions(+)
> >
> > Index: linux-pm/drivers/cpufreq/cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> > +++ linux-pm/drivers/cpufreq/cpufreq.c
> > @@ -2280,6 +2280,8 @@ static int cpufreq_init_governor(struct
> >               }
> >       }
> >
> > +     policy->strict_target = !!(policy->governor->flags & CPUFREQ_GOV_FLAG_STRICT_TARGET);
> > +
> >       return 0;
> >  }
> >
> > Index: linux-pm/include/linux/cpufreq.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/cpufreq.h
> > +++ linux-pm/include/linux/cpufreq.h
> > @@ -109,6 +109,12 @@ struct cpufreq_policy {
> >       bool                    fast_switch_enabled;
> >
> >       /*
> > +      * Set if the CPUFREQ_GOV_FLAG_STRICT_TARGET flag is set for the
> > +      * current governor.
> > +      */
> > +     bool                    strict_target;
> > +
> > +     /*
> >        * Preferred average time interval between consecutive invocations of
> >        * the driver to set the frequency for this policy.  To be set by the
> >        * scaling driver (0, which is the default, means no preference).
>
> I was kind of hoping to avoid adding a field here when I proposed updating the
> gov structure. I do understand the performance related penalty of accessing the
> gov structure for fast switch case though and so wonder if we really need this,
> then should we avoid changing the gov structure at all ? I mean there is only
> one user of that field now, do we really need a flag for it ? We can just do the
> string comparison here with powersave and performance to set strict_target.
>
> Whatever you feel is better though.

The cost of having the flag is zero and it allows things to be
documented a bit better IMV.

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!
