Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2907B209DAA
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404222AbgFYLoq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 07:44:46 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45812 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgFYLoq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 07:44:46 -0400
Received: by mail-oi1-f193.google.com with SMTP id j11so2001879oiw.12;
        Thu, 25 Jun 2020 04:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhbzaom2oYWTb3uPp4imDnoJSzGngQDDOGjO9gwcXTY=;
        b=KdGriYENCu2PWCj/vlDJxSxgZ+X40NgAssliij3lwEoiOQNKfL956akQfAtCK+RRCn
         Mce0W3w4FTVUuweo6ao7s7jOu2ASoEsmVkTEKkuh7R5fJLGejZbgfacXNvPKjdtw28EQ
         xC9uB+Di+tVtvuw0+LD8PpH4B2gKZJobxBr2mqFMOJUARGvuKDdUWCywxz6FJjK4NPUo
         ts7+TMUnzj6Ss1UvImRQk2Rxsd3Rd+awpETgV0l7LLr1iQdt263E9ff0IPBV4zqm5V0w
         iPkn4FLkkX6tAMi0CCwV8w3dAhL8MCmLrMwSjgg/fAWjUwcL/aZgADrxKk5SUZA559s7
         V9QQ==
X-Gm-Message-State: AOAM530ZJ6a9ioffP/h60BXBF/G8hctI+Fu7cOXx1jnCwhPe4edhPbfk
        S7xG2907gZ+FxOMVqFnXdpEE3wOvg8JK3BKiY14=
X-Google-Smtp-Source: ABdhPJxcGZrXWWyZIuQWJhk3RrxSQPVylSRGu51cIIXGopaqDSitWSeU603zryF35zthebkIoYQ1rZCgrLiOq60oduA=
X-Received: by 2002:a54:4585:: with SMTP id z5mr1861850oib.110.1593085485302;
 Thu, 25 Jun 2020 04:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200623142138.209513-1-qperret@google.com> <20200623142138.209513-3-qperret@google.com>
 <20200625113602.z2xrwebd2gngbww3@vireshk-i7>
In-Reply-To: <20200625113602.z2xrwebd2gngbww3@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jun 2020 13:44:34 +0200
Message-ID: <CAJZ5v0g=+2OFKVk2ZnmK-33knUwqcaOOQ+q9ZWnmeoBD9KOX9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Quentin Perret <qperret@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Todd Kjos <tkjos@google.com>, adharmap@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 25, 2020 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> After your last email (reply to my patch), I noticed a change which
> isn't required. :)
>
> On 23-06-20, 15:21, Quentin Perret wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0128de3603df..4b1a5c0173cf 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -50,6 +50,9 @@ static LIST_HEAD(cpufreq_governor_list);
> >  #define for_each_governor(__governor)                                \
> >       list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
> >
> > +static char cpufreq_param_governor[CPUFREQ_NAME_LEN];
> > +static struct cpufreq_governor *default_governor;
> > +
> >  /**
> >   * The "cpufreq driver" - the arch- or hardware-dependent low
> >   * level driver of CPUFreq support, and its spinlock. This lock
> > @@ -1055,7 +1058,6 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
> >
> >  static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >  {
> > -     struct cpufreq_governor *def_gov = cpufreq_default_governor();
> >       struct cpufreq_governor *gov = NULL;
> >       unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
> >
> > @@ -1065,8 +1067,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >               if (gov) {
> >                       pr_debug("Restoring governor %s for cpu %d\n",
> >                                policy->governor->name, policy->cpu);
> > -             } else if (def_gov) {
> > -                     gov = def_gov;
> > +             } else if (default_governor) {
> > +                     gov = default_governor;
> >               } else {
> >                       return -ENODATA;
> >               }
>
>
> > @@ -1074,8 +1076,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >               /* Use the default policy if there is no last_policy. */
> >               if (policy->last_policy) {
> >                       pol = policy->last_policy;
> > -             } else if (def_gov) {
> > -                     pol = cpufreq_parse_policy(def_gov->name);
> > +             } else if (default_governor) {
> > +                     pol = cpufreq_parse_policy(default_governor->name);
>
> This change is not right IMO. This part handles the set-policy case,
> where there are no governors. Right now this code, for some reasons
> unknown to me, forcefully uses the default governor set to indicate
> the policy, which is not a great idea in my opinion TBH. This doesn't
> and shouldn't care about governor modules and should only be looking
> at strings instead of governor pointer.

Sounds right.

> Rafael, I even think we should remove this code completely and just
> rely on what the driver has sent to us. Using the selected governor
> for set policy drivers is very confusing and also we shouldn't be
> forced to compiling any governor for the set-policy case.

Well, AFAICS the idea was to use the default governor as a kind of
default policy proxy, but I agree that strings should be sufficient
for that.

I'll have a look at what to do with that code.
