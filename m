Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F863B874C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 18:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhF3RBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 13:01:20 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:43715 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3RBU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 13:01:20 -0400
Received: by mail-oo1-f41.google.com with SMTP id b17-20020a4aba110000b029024c219a3d83so793712oop.10;
        Wed, 30 Jun 2021 09:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8E3SiP4jfFVx6xLQQNrRfMsJfLJy/U2zQlBC/YkWL00=;
        b=klTSpxYRpFIvQXGWrwwqw9M0gMiM24nSn8MDq5fjfjG8PDTYfOxBHsWVN/HxbA2Yah
         OuCk14z2oSUrv8HvJ00z3DyivzENx9u233y1aHRY8E/FCbWkhUGKsJXqzW53I3oF70c/
         3omxQIoCLExc17AY9SFintIPs0J+FjI8oBfPetNaBxI3nfQAJIoxBKWMCvD+yj1ZNBhH
         lstNhP/13Y8R4bilV/zNKamh3h9HvcdWjtj9Xx9hQpV3uslCn7LIqdc2G1OiqY5DGyTe
         zlbbTSmi9vNJ+K59hoXilCWA54tLDtZBaciqFDBdjB5BCHO8yDknoK3Hd3aZnufNDA5M
         V53A==
X-Gm-Message-State: AOAM5310P0da4B/qiHHT9T3cO1VEzngHRQQCm20SX9AgUthJLtJHOFv6
        OOZtvLMe1dDsgqXSqtlJQTLmMeAXdTwZMKht1OM=
X-Google-Smtp-Source: ABdhPJwtvr/uVzDMqIxSnt7ynjNGjlzLEkFCM0ypZRYLmwlRkcXeVplJye5Crd6T4H2zMDQJvp1vMAjv7pXTxgkqZ7w=
X-Received: by 2002:a4a:5285:: with SMTP id d127mr9064967oob.2.1625072330298;
 Wed, 30 Jun 2021 09:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624421816.git.viresh.kumar@linaro.org> <6144911f36d3d1f5faddf81d744bd39946843f6b.1624421816.git.viresh.kumar@linaro.org>
 <5741915.lOV4Wx5bFT@kreacher> <20210624015138.nzrrgiqyk3hblknv@vireshk-i7>
In-Reply-To: <20210624015138.nzrrgiqyk3hblknv@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 18:58:39 +0200
Message-ID: <CAJZ5v0ixck=1qzxrnAn5vgMcaA5NB4WtcK1RXj3+RvR2vV_VhA@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] cpufreq: intel_pstate: Migrate to ->offline()
 instead of ->stop_cpu()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 24, 2021 at 3:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-06-21, 17:13, Rafael J. Wysocki wrote:
> > As mentioned already in
> >
> > https://lore.kernel.org/linux-pm/CAJZ5v0g2tCZptcqh+c55YYiO7rDHmZivMLsmpq_7005zNPN1xg@mail.gmail.com/
>
> Sorry about failing to reply over that, I got confused somehow..
>
> > this isn't particularly clean, because intel_pstate_cpu_offline() is
> > also used in the passive mode where the above call is not needed.
>
> intel_pstate_clear_update_util_hook() returns early if the hook was never
> registered, and so calling it was safe, but yes not very clean.
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] cpufreq: intel_pstate: Combine ->stop_cpu() and ->offline()
> >
> > Combine the ->stop_cpu() and ->offline() callback routines for the
> > active mode of intel_pstate so as to avoid setting the ->stop_cpu
> > callback pointer which is going to be dropped from the framework.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > @@ -2577,11 +2577,13 @@ static int intel_pstate_cpu_online(struc
> >       return 0;
> >  }
> >
> > -static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
> > +static int intel_pstate_stop_cpu(struct cpufreq_policy *policy)
> >  {
> >       pr_debug("CPU %d stopping\n", policy->cpu);
> >
> >       intel_pstate_clear_update_util_hook(policy->cpu);
> > +
> > +     return intel_pstate_cpu_offline(policy);
> >  }
> >
> >  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> > @@ -2654,8 +2656,7 @@ static struct cpufreq_driver intel_pstat
> >       .resume         = intel_pstate_resume,
> >       .init           = intel_pstate_cpu_init,
> >       .exit           = intel_pstate_cpu_exit,
> > -     .stop_cpu       = intel_pstate_stop_cpu,
> > -     .offline        = intel_pstate_cpu_offline,
> > +     .offline        = intel_pstate_stop_cpu,
>
> I would suggest to rename intel_pstate_cpu_offline() as
> intel_cpufreq_cpu_offline() and intel_pstate_stop_cpu() as
> intel_pstate_cpu_offline(), so we remove the stop-cpu terminology completely.

I have followed the above suggestion and applied the modified patch
along with the rest of this series.

> Either way:
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

> >       .online         = intel_pstate_cpu_online,
> >       .update_limits  = intel_pstate_update_limits,
> >       .name           = "intel_pstate",
