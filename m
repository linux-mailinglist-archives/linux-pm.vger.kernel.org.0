Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C805313BE92
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 12:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgAOLeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 06:34:44 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38191 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbgAOLeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 06:34:44 -0500
Received: by mail-io1-f67.google.com with SMTP id i7so8991128ioo.5
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 03:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojzhgAl+4gWNfYdEFpF+cmgwNJMJnLz3oDiOxYEPZfU=;
        b=igQq5nQgETtO9SXsQX/d5w5ZM34lFaR3K5RVxqxu3f9tWbirZ2mzK54lGbQJI48oQj
         i4iLoqi1aZcOabbmLdmKo+bFHslqju/hHn6DH2cEGn88wm9PSyop5PPZq3VzIK9UCmXv
         ohc0iecvvkOuKoQinunIfEKUP0mD4kNes9hB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojzhgAl+4gWNfYdEFpF+cmgwNJMJnLz3oDiOxYEPZfU=;
        b=UfbBoCKkzaOGDPHm4f7I+hMjpryzeQm1kTJNQA97H27w+86RfbTMR7uMp8zPE2yUN1
         /1nqCjn4qQNJmfopwS8KiJUKTT1Zadkb1iOZ6knjoEWEyhtyBRhelWUom4PwfU8anUqX
         SMmfUtq4Cek/C4VqvnYQndtTBvjZ1dJAjRy3+oGWToGPw5cfWX5b+HN8AKrGdpwM5DcL
         clrvJSxW79sEjpE3PWlioQdBQDzJu4n7QzKPS4dhgX7thx70U44dHuFTZKsoJqFdhrTN
         Zn+QEfjQFe6fqlf2kxN50t2MWdhjJgg2XdI7SkiNwOA0OFawcJTJ0z0hdR3qOQNxvbw1
         TJBg==
X-Gm-Message-State: APjAAAXqJipKoy8UAxTNZbRehSi6gUyPUwpMibabreaQrZgHhUsUyVWI
        fNl8JMhW8ViAIX+EwUkQII4Pzqvi5jNaIuLd4lA+vA==
X-Google-Smtp-Source: APXvYqyXQxo2sXMh7CF1na9rm0gQdmLHTI1jI0nmSKq3jJK/VE/cud+yxidf/6iaxqDP9aqob4Xw39/4q2FI506v3zw=
X-Received: by 2002:a6b:3b49:: with SMTP id i70mr21933237ioa.106.1579088083140;
 Wed, 15 Jan 2020 03:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20200115063410.131692-1-hsinyi@chromium.org> <CAJZ5v0jng1hpPzYUcPj96G9c8aqNYCwDqLHyQEVC9tD=F1dObw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jng1hpPzYUcPj96G9c8aqNYCwDqLHyQEVC9tD=F1dObw@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 15 Jan 2020 19:34:17 +0800
Message-ID: <CAJMQK-jES7NOAga3w+pQUuoFW+dm0Uw3--SQ7S0BAARFCrT6qQ@mail.gmail.com>
Subject: Re: [PATCH v5] reboot: support offline CPUs before reboot
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 15, 2020 at 5:49 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 15, 2020 at 7:35 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Currently system reboots uses architecture specific codes (smp_send_stop)
> > to offline non reboot CPUs. Most architecture's implementation is looping
> > through all non reboot online CPUs and call ipi function to each of them. Some
> > architecture like arm64, arm, and x86... would set offline masks to cpu without
> > really offline them. This causes some race condition and kernel warning comes
> > out sometimes when system reboots.
> >
> > This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would offline cpus in
> > migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> > checking online cpus would be an empty loop. If architecture don't enable this
> > config, or some cpus somehow fails to offline, it would fallback to ipi
> > function.
> >
> > Opt in this config for architectures that support CONFIG_HOTPLUG_CPU.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > Change from v4:
> > * fix a few nits: naming, comments, remove Kconfig text...
> >
> > Change from v3:
> > * Opt in config for architectures that support CONFIG_HOTPLUG_CPU
> > * Merge function offline_secondary_cpus() and freeze_secondary_cpus()
> >   with an additional flag.
>
> This does not seem to be a very good idea, since
> freeze_secondary_cpus() does much more than you need for reboot.
>
> For reboot, you basically only need to do something like this AFAICS:
>
> cpu_maps_update_begin();
>
> for_each_online_cpu(i) {
>         if (i != cpu)
>                 _cpu_down(i, 1, CPUHP_OFFLINE);
> }
> cpu_hotplug_disabled++;
>
> cpu_maps_update_done();
>
> And you may put this into a function defined outside of CONFIG_PM_SLEEP.
>
v2's implementation is similar to this. The conclusion in v2[1] is
that since these 2 functions are similar, we should merge them. I'm
fine both ways but slightly prefer v2's. Maybe wait for others to
comment?

[1] https://lore.kernel.org/lkml/87muarpcwm.fsf@vitty.brq.redhat.com/
> >
> > Change from v2:
> > * Add another config instead of configed by CONFIG_HOTPLUG_CPU
>
> So why exactly is this new Kconfig option needed?
>
> Everybody supporting CPU hotplug seems to opt in anyway.
>
Currently we opt-in for all arch that supports HOTPLUG_CPU, but if
some arch decides that this would make reboot slow (or maybe other
reasons), they can choose to opt-out.
I have only tested on arm64 and x86 for now.
> [cut]
>
> >
> > -int freeze_secondary_cpus(int primary)
> > +int freeze_secondary_cpus(int primary, bool reboot)
> >  {
> >         int cpu, error = 0;
> >
> > @@ -1237,11 +1237,13 @@ int freeze_secondary_cpus(int primary)
> >                 if (cpu == primary)
> >                         continue;
> >
> > -               if (pm_wakeup_pending()) {
> > +#ifdef CONFIG_PM_SLEEP
> > +               if (!reboot && pm_wakeup_pending()) {
> >                         pr_info("Wakeup pending. Abort CPU freeze\n");
> >                         error = -EBUSY;
> >                         break;
> >                 }
> > +#endif
>
> Please avoid using #ifdefs in function bodies.  This makes the code
> hard to maintain in the long term.
>
> >
> >                 trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
> >                 error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
> > @@ -1250,7 +1252,9 @@ int freeze_secondary_cpus(int primary)
> >                         cpumask_set_cpu(cpu, frozen_cpus);
> >                 else {
> >                         pr_err("Error taking CPU%d down: %d\n", cpu, error);
> > -                       break;
> > +                       /* When rebooting, offline as many CPUs as possible. */
> > +                       if (!reboot)
> > +                               break;
> >                 }
> >         }
> >
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index c4d472b7f1b4..12f643b66e57 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -7,6 +7,7 @@
> >
> >  #define pr_fmt(fmt)    "reboot: " fmt
> >
> > +#include <linux/cpu.h>
> >  #include <linux/ctype.h>
> >  #include <linux/export.h>
> >  #include <linux/kexec.h>
> > @@ -220,7 +221,9 @@ void migrate_to_reboot_cpu(void)
> >         /* The boot cpu is always logical cpu 0 */
> >         int cpu = reboot_cpu;
> >
> > +#if !IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> >         cpu_hotplug_disable();
> > +#endif
>
> You can write this as
>
> if (!IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT))
>         cpu_hotplug_disable();
>
> That's what IS_ENABLED() is there for.
>
> >
> >         /* Make certain the cpu I'm about to reboot on is online */
> >         if (!cpu_online(cpu))
> > @@ -231,6 +234,11 @@ void migrate_to_reboot_cpu(void)
> >
> >         /* Make certain I only run on the appropriate processor */
> >         set_cpus_allowed_ptr(current, cpumask_of(cpu));
> > +
> > +#if IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> > +       /* Offline other cpus if possible */
> > +       freeze_secondary_cpus(cpu, true);
> > +#endif
>
> The above comment applies here too.
>
> >  }
> >
> >  /**
> > --
