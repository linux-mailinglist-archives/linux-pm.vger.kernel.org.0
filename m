Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97293B041B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 14:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFVMUl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 08:20:41 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:35331 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhFVMUg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 08:20:36 -0400
Received: by mail-ot1-f48.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so21005961oti.2;
        Tue, 22 Jun 2021 05:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyGLESs05JBNBouImqwDAtnN7LMuKKuMfeXqPSqQHIY=;
        b=BnMXavBt2ehHoAFPl/ptmiiFpSush1l7jF3BT0drbzGSW9XWwZ5J2hlhae+EpoisKx
         kC4RcwIh3mnzgv8TBa8Nto7E93XIvcV24nWhcrBiSGV7yRZZrMjBqkWd5jBGeAcV5MTl
         hHQTU194cMlbGaGQkeu/wr7wSxOepSLVe8uHSEk0VksbMAsA7tvInPc4GxpcdYNFx5yD
         sEDnVe7yQVaR++WPJ/mhytomnFYb1g9UCYIQo9aD5lG3WOB2hvgZRDWzf3X27ZXnnc6y
         7l1/76eqWEjUDJvLGn5pt/HtMFHm20QAlc/ys9u/+8XRVAAKRws8NKX1JZnK+W7Prg9X
         faKQ==
X-Gm-Message-State: AOAM533f78lnNRCBXekLTlHK+mhFlSukhSaFCoDvpZvSzuagzBD0wT3B
        bLH22pt3YMEY6sVqn52pXJ9XkibwInfklE2fFqQ=
X-Google-Smtp-Source: ABdhPJy4Kb98MnI+cyD4CBoQNQ3pHx0Jd7TPk3EjUxTjcYyXFQczMuJtpDTuGVtK/1DF9HlOz1QE6wAGrW5OP/gfuK0=
X-Received: by 2002:a9d:67cb:: with SMTP id c11mr2861432otn.321.1624364300661;
 Tue, 22 Jun 2021 05:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <11788436.O9o76ZdvQC@kreacher> <20210622062052.jo2by44djlyjpn5w@vireshk-i7>
In-Reply-To: <20210622062052.jo2by44djlyjpn5w@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 14:18:08 +0200
Message-ID: <CAJZ5v0jn0W2yG-Ty0NruC-o-V-t9fEjJ=DkzKT1YgZcD3yuJnA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Make cpufreq_online() call driver->offline() on errors
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 8:20 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 21-06-21, 19:26, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In the CPU removal path the ->offline() callback provided by the
> > driver is always invoked before ->exit(),
>
> Note that exit() doesn't get called if offline() is present in the CPU
> removal path. We call exit() _only_ when the cpufreq driver gets
> unregistered.

True, but that doesn't contradict what I said.

> > but in the cpufreq_online()
> > error path it is not, so ->exit() is somehow expected to know the
> > context in which it has been called and act accordingly.
>
> I agree, it isn't very clear.
>
> > That is less than straightforward, so make cpufreq_online() invoke
> > the driver's ->offline() callback before ->exit() too.
> >
> > This only potentially affects intel_pstate at this point.
> >
> > Fixes: 91a12e91dc39 ("cpufreq: Allow light-weight tear down and bring up of CPUs")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > Index: linux-pm/drivers/cpufreq/cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> > +++ linux-pm/drivers/cpufreq/cpufreq.c
> > @@ -1516,6 +1516,9 @@ out_destroy_policy:
> >       up_write(&policy->rwsem);
> >
> >  out_exit_policy:
> > +     if (cpufreq_driver->offline)
> > +             cpufreq_driver->offline(policy);
> > +
> >       if (cpufreq_driver->exit)
> >               cpufreq_driver->exit(policy);
>
> If we want to go down this path, then we better do more and make it
> very explicit that ->offline() follows a previous invocation of
> ->online().
>
> Otherwise, with above we will end up calling ->offline() for two separate
> states, ->online() failed (i.e. two calls to offline() one after the other
> here) and other generic failures after ->init() passed.

Good point.

> So, better make it clear that online/offline are paired like
> init/exit.
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1d1b563cea4b..0ce48dcb2e8a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1347,14 +1347,11 @@ static int cpufreq_online(unsigned int cpu)
>         }
>
>         if (!new_policy && cpufreq_driver->online) {
> -               ret = cpufreq_driver->online(policy);
> -               if (ret) {
> -                       pr_debug("%s: %d: initialization failed\n", __func__,
> -                                __LINE__);
> -                       goto out_exit_policy;
> -               }
> -
> -               /* Recover policy->cpus using related_cpus */
> +               /*
> +                * We did light-weight tear down earlier, don't need to do heavy
> +                * initialization here. Just recover policy->cpus using
> +                * related_cpus.
> +                */
>                 cpumask_copy(policy->cpus, policy->related_cpus);
>         } else {
>                 cpumask_copy(policy->cpus, cpumask_of(cpu));
> @@ -1378,6 +1375,13 @@ static int cpufreq_online(unsigned int cpu)
>                 cpumask_copy(policy->related_cpus, policy->cpus);
>         }
>
> +       ret = cpufreq_driver->online(policy);

But I wouldn't make this change, because that would require reworking
->init() in the driver too.

Let's continue assuming that ->init() will do ->online() if successful
and so ->offline() is needed after a successful ->init() as well as
after a successful ->online().

> +       if (ret) {
> +               pr_debug("%s: %d: %d: ->online() failed\n", __func__, __LINE__,
> +                        ret);
> +               goto out_exit_policy;
> +       }
> +
>         down_write(&policy->rwsem);
>         /*
>          * affected cpus must always be the one, which are online. We aren't
> @@ -1518,6 +1522,9 @@ static int cpufreq_online(unsigned int cpu)
>
>         up_write(&policy->rwsem);
>

So I think that a new label is needed here to avoid running
->offline() after a failing ->online().

Let me update the patch accordingly.

> +       if (cpufreq_driver->offline)
> +               cpufreq_driver->offline(policy);
> +
>  out_exit_policy:
>         if (cpufreq_driver->exit)
>                 cpufreq_driver->exit(policy);
