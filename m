Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E25420E228
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 00:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbgF2VCy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 17:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbgF2TMt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:12:49 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6BAC02A55E;
        Mon, 29 Jun 2020 06:14:02 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n5so15462556otj.1;
        Mon, 29 Jun 2020 06:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zl39/ogoiavirjWw0RJ4az07WY9iTjH0DwkSRzvIbpU=;
        b=iV6/ld8RsP71JH/0pKRvmpzmiaJflW2tQuIVNHHnkwpqvY9q6FU3pG1SWZEkl+p0aF
         4OI5HWLZI2Y2vblza8zaLEBiqhPcvaBxyZ85Q2iFBbcwYqHNRAhbapxvZaOmDeXCRwXn
         S9roPv1fXBxPyFecE6RVj233o95BlbMkXQcg8IoMd+4/kfItU/9ERDAbbgtxFNK3TuUN
         yXHzeUR0wue86LivwQY+BxN/ZxTez20+QJ7S/I8fx/CzFUa7em4iCp5aYwjh0KlGJ38H
         Q0TI03xIuq2a57BGxTpd0oBvu9pNyqSuuhadapBY/PRfnELZi+FCBNSzBoMCsEtD3f3x
         T4CA==
X-Gm-Message-State: AOAM530dC1OYjxz7VdkeqSUb/XhYMUAisb0zZcNRNAjwnGlfFkgi3Ppw
        mXMx1dUHz+7PoQNnGk1d3euJePoBE8G12WXeOM0=
X-Google-Smtp-Source: ABdhPJzWedaVn91U287hY9yoH0WOIt/kqv2XIxbgQlaCJIJISmhHMf7cLkfEj9WuAXDiyquy7mPVbhFyGacWFrvsxBg=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr12871453otn.118.1593436441986;
 Mon, 29 Jun 2020 06:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593143118.git.viresh.kumar@linaro.org> <f366ed3dd3dd111e42173b366fe4dd5a0e4647fd.1593143118.git.viresh.kumar@linaro.org>
 <20200626082433.GA284605@google.com> <20200629021309.eleyysuh5f5g52qw@vireshk-i7>
In-Reply-To: <20200629021309.eleyysuh5f5g52qw@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Jun 2020 15:13:46 +0200
Message-ID: <CAJZ5v0j6vRpcJxJnSg_Ph02g_4H2LomPM6Ed9t4gaD7YeNE_pg@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] cpufreq: Fix locking issues with governors
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Todd Kjos <tkjos@google.com>, adharmap@codeaurora.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 29, 2020 at 4:13 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 26-06-20, 09:24, Quentin Perret wrote:
> > On Friday 26 Jun 2020 at 09:21:42 (+0530), Viresh Kumar wrote:
> > > The locking around governors handling isn't adequate currently. The list
> > > of governors should never be traversed without locking in place. Also we
> > > must make sure the governor isn't removed while it is still referenced
> > > by code.
> > >
> > > Reported-by: Quentin Perret <qperret@google.com>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 59 ++++++++++++++++++++++++---------------
> > >  1 file changed, 36 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 0128de3603df..e798a1193bdf 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -621,6 +621,24 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
> > >     return NULL;
> > >  }
> > >
> > > +static struct cpufreq_governor *get_governor(const char *str_governor)
> > > +{
> > > +   struct cpufreq_governor *t;
> > > +
> > > +   mutex_lock(&cpufreq_governor_mutex);
> > > +   t = find_governor(str_governor);
> > > +   if (!t)
> > > +           goto unlock;
> > > +
> > > +   if (!try_module_get(t->owner))
> > > +           t = NULL;
> > > +
> > > +unlock:
> > > +   mutex_unlock(&cpufreq_governor_mutex);
> > > +
> > > +   return t;
> > > +}
> > > +
> > >  static unsigned int cpufreq_parse_policy(char *str_governor)
> > >  {
> > >     if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN))
> > > @@ -640,28 +658,14 @@ static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
> > >  {
> > >     struct cpufreq_governor *t;
> > >
> > > -   mutex_lock(&cpufreq_governor_mutex);
> > > -
> > > -   t = find_governor(str_governor);
> > > -   if (!t) {
> > > -           int ret;
> > > -
> > > -           mutex_unlock(&cpufreq_governor_mutex);
> > > -
> > > -           ret = request_module("cpufreq_%s", str_governor);
> > > -           if (ret)
> > > -                   return NULL;
> > > -
> > > -           mutex_lock(&cpufreq_governor_mutex);
> > > +   t = get_governor(str_governor);
> > > +   if (t)
> > > +           return t;
> > >
> > > -           t = find_governor(str_governor);
> > > -   }
> > > -   if (t && !try_module_get(t->owner))
> > > -           t = NULL;
> > > -
> > > -   mutex_unlock(&cpufreq_governor_mutex);
> > > +   if (request_module("cpufreq_%s", str_governor))
> > > +           return NULL;
> > >
> > > -   return t;
> > > +   return get_governor(str_governor);
> > >  }
> > >
> > >  /**
> > > @@ -815,12 +819,14 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
> > >             goto out;
> > >     }
> > >
> > > +   mutex_lock(&cpufreq_governor_mutex);
> > >     for_each_governor(t) {
> > >             if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
> > >                 - (CPUFREQ_NAME_LEN + 2)))
> > > -                   goto out;
> > > +                   break;
> > >             i += scnprintf(&buf[i], CPUFREQ_NAME_PLEN, "%s ", t->name);
> > >     }
> > > +   mutex_unlock(&cpufreq_governor_mutex);
> > >  out:
> > >     i += sprintf(&buf[i], "\n");
> > >     return i;
> > > @@ -1058,11 +1064,14 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
> > >     struct cpufreq_governor *def_gov = cpufreq_default_governor();
> > >     struct cpufreq_governor *gov = NULL;
> > >     unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
> > > +   bool put_governor = false;
> > > +   int ret;
> > >
> > >     if (has_target()) {
> > >             /* Update policy governor to the one used before hotplug. */
> > > -           gov = find_governor(policy->last_governor);
> > > +           gov = get_governor(policy->last_governor);
> > >             if (gov) {
> > > +                   put_governor = true;
> > >                     pr_debug("Restoring governor %s for cpu %d\n",
> > >                              policy->governor->name, policy->cpu);
> > >             } else if (def_gov) {
> > > @@ -1089,7 +1098,11 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
> > >                     return -ENODATA;
> > >     }
> > >
> > > -   return cpufreq_set_policy(policy, gov, pol);
> > > +   ret = cpufreq_set_policy(policy, gov, pol);
> > > +   if (put_governor)
> > > +           module_put(gov->owner);
> >
> > Nit: I think you could safely do
> >
> >       if (gov)
> >               module_put(gov->owner);
> >
> > and get rid of 'put_governor', given that try_module_get() and
> > module_put() are nops if owner is NULL (which is guaranteed for
> > the result of cpufreq_default_governor() as it is builtin).
>
> I described why I chose to keep it that way in the other email, but I
> am all for dropping the variable. And so what about this ?

Works for me.

> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e798a1193bdf..d9e9ae7051bb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1064,18 +1064,17 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>         struct cpufreq_governor *def_gov = cpufreq_default_governor();
>         struct cpufreq_governor *gov = NULL;
>         unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
> -       bool put_governor = false;
>         int ret;
>
>         if (has_target()) {
>                 /* Update policy governor to the one used before hotplug. */
>                 gov = get_governor(policy->last_governor);
>                 if (gov) {
> -                       put_governor = true;
>                         pr_debug("Restoring governor %s for cpu %d\n",
>                                  policy->governor->name, policy->cpu);
>                 } else if (def_gov) {
>                         gov = def_gov;
> +                       module_get(gov->owner);
>                 } else {
>                         return -ENODATA;
>                 }
> @@ -1099,7 +1098,7 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>         }
>
>         ret = cpufreq_set_policy(policy, gov, pol);
> -       if (put_governor)
> +       if (gov)
>                 module_put(gov->owner);
>
>         return ret;
>
> --
> viresh
