Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F782073B9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbgFXMvT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 08:51:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42833 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbgFXMvS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 08:51:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id t6so1758499otk.9;
        Wed, 24 Jun 2020 05:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/bkPQJyEuJLLZDCNPTwD8zOfuXTt/HbpVEXhGvvUkU=;
        b=AI94apMJFjRHFuRxILGcYWcD/kU95W6XXd2KMuZ56rAQHH7lYg5c1easXanf/m/r76
         z45CTt6gtMPVFy35cFUBmJQj8bn/gq150S5KxyXhe7KBMm86AkdkWVXRarZdxK0VOVLo
         l+yka3SSE/uEzlgwpS7NLgWQ1CqUrz5wl538GOMlQ/OMSOJDsTzGpUiO9GUxplW1+4Zh
         MtX+MXDMEfM0VV1+V8+6/Wc0QLk/7LBx7rf2XhtVwj+UMvJegB8tlid7eLWDO7WDsGRm
         rLt3KblNMIQ4EdSXlgh3crnmoA+tlFCC9FArFCBn3A3YsacJT9KPk2fUCPzhOvNOTx8l
         12bw==
X-Gm-Message-State: AOAM533bz9me+GccRnfVXO83Xf/ZjgWRu611+S/nF/w4GgbV+Rht1CU4
        KzOSR5GV4PLZEbBxT36Q7aqZP4PAQ4ny2PQno0Y=
X-Google-Smtp-Source: ABdhPJyJaj4dGUTvhHBRNMjHUnZdGheAZvOfYIAiAj6lGBGPOY3/8KAhD1pS066Sr/l31WOleOmCuvjLIX/i+LSdSPM=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr21740160otn.118.1593003077552;
 Wed, 24 Jun 2020 05:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200623142138.209513-1-qperret@google.com> <20200623142138.209513-3-qperret@google.com>
 <20200624055023.xofefhohf7wifme5@vireshk-i7>
In-Reply-To: <20200624055023.xofefhohf7wifme5@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Jun 2020 14:51:04 +0200
Message-ID: <CAJZ5v0ja_rM7i=psW1HRyzEpW=8QwP2u9p+ihN3FS8_53bbxTQ@mail.gmail.com>
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

On Wed, Jun 24, 2020 at 7:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-06-20, 15:21, Quentin Perret wrote:
> > Currently, the only way to specify the default CPUfreq governor is via
> > Kconfig options, which suits users who can build the kernel themselves
> > perfectly.
> >
> > However, for those who use a distro-like kernel (such as Android, with
> > the Generic Kernel Image project), the only way to use a different
> > default is to boot to userspace, and to then switch using the sysfs
> > interface. Being able to specify the default governor on the command
> > line, like is the case for cpuidle, would enable those users to specify
> > their governor of choice earlier on, and to simplify slighlty the
> > userspace boot procedure.
> >
> > To support this use-case, add a kernel command line parameter enabling
> > to specify a default governor for CPUfreq, which takes precedence over
> > the builtin default.
> >
> > This implementation has one notable limitation: the default governor
> > must be registered before the driver. This is solved for builtin
> > governors and drivers using appropriate *_initcall() functions. And in
> > the modular case, this must be reflected as a constraint on the module
> > loading order.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  5 ++++
> >  Documentation/admin-guide/pm/cpufreq.rst      |  6 ++---
> >  drivers/cpufreq/cpufreq.c                     | 23 +++++++++++++++----
> >  3 files changed, 26 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index fb95fad81c79..5fd3c9f187eb 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -703,6 +703,11 @@
> >       cpufreq.off=1   [CPU_FREQ]
> >                       disable the cpufreq sub-system
> >
> > +     cpufreq.default_governor=
> > +                     [CPU_FREQ] Name of the default cpufreq governor to use.
> > +                     This governor must be registered in the kernel before
> > +                     the cpufreq driver probes.
> > +
> >       cpu_init_udelay=N
> >                       [X86] Delay for N microsec between assert and de-assert
> >                       of APIC INIT to start processors.  This delay occurs
> > diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> > index 0c74a7784964..368e612145d2 100644
> > --- a/Documentation/admin-guide/pm/cpufreq.rst
> > +++ b/Documentation/admin-guide/pm/cpufreq.rst
> > @@ -147,9 +147,9 @@ CPUs in it.
> >
> >  The next major initialization step for a new policy object is to attach a
> >  scaling governor to it (to begin with, that is the default scaling governor
> > -determined by the kernel configuration, but it may be changed later
> > -via ``sysfs``).  First, a pointer to the new policy object is passed to the
> > -governor's ``->init()`` callback which is expected to initialize all of the
> > +determined by the kernel command line or configuration, but it may be changed
> > +later via ``sysfs``).  First, a pointer to the new policy object is passed to
> > +the governor's ``->init()`` callback which is expected to initialize all of the
> >  data structures necessary to handle the given policy and, possibly, to add
> >  a governor ``sysfs`` interface to it.  Next, the governor is started by
> >  invoking its ``->start()`` callback.
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
> > @@ -1074,8 +1076,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >               /* Use the default policy if there is no last_policy. */
> >               if (policy->last_policy) {
> >                       pol = policy->last_policy;
> > -             } else if (def_gov) {
> > -                     pol = cpufreq_parse_policy(def_gov->name);
> > +             } else if (default_governor) {
> > +                     pol = cpufreq_parse_policy(default_governor->name);
> >                       /*
> >                        * In case the default governor is neiter "performance"
> >                        * nor "powersave", fall back to the initial policy
> > @@ -2320,6 +2322,9 @@ int cpufreq_register_governor(struct cpufreq_governor *governor)
> >               list_add(&governor->governor_list, &cpufreq_governor_list);
> >       }
> >
> > +     if (!strncasecmp(cpufreq_param_governor, governor->name, CPUFREQ_NAME_LEN))
> > +             default_governor = governor;
> > +
> >       mutex_unlock(&cpufreq_governor_mutex);
> >       return err;
> >  }
> > @@ -2348,6 +2353,8 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
> >
> >       mutex_lock(&cpufreq_governor_mutex);
> >       list_del(&governor->governor_list);
> > +     if (governor == default_governor)
> > +             default_governor = cpufreq_default_governor();
> >       mutex_unlock(&cpufreq_governor_mutex);
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
> > @@ -2789,7 +2796,13 @@ static int __init cpufreq_core_init(void)
> >       cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
> >       BUG_ON(!cpufreq_global_kobject);
> >
> > +     mutex_lock(&cpufreq_governor_mutex);
> > +     if (!default_governor)
> > +             default_governor = cpufreq_default_governor();
> > +     mutex_unlock(&cpufreq_governor_mutex);
>
> I don't think locking is required here at core-initcall level.

It isn't necessary AFAICS, but it may as well be regarded as
annotation (kind of instead of having a comment explaining why it need
not be used).
