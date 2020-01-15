Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1432913BCC3
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 10:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgAOJta (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 04:49:30 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35278 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbgAOJta (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 04:49:30 -0500
Received: by mail-oi1-f193.google.com with SMTP id k4so14830271oik.2;
        Wed, 15 Jan 2020 01:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlblpk3Q7AFTy8Enno95ZSx0IUH147BofZyxZsTxPpQ=;
        b=TucKJXUCA3iBOurtQTxVBa/z8C9REkYA7BJC4bLHsU20pWHX8G0CPEON/zgGfgROz8
         jwyhbLr5j2JjwsgdL2GIT3EzLxo7Di8fOQrERkdEJ7U7/QiPIC90oZ50fmH92oivcX4w
         4nk8FEs52YgRW4roJaXdtPnaDSiUZuO+jsaSeqw5obwUuylTkiKm+kAy0NqZaqaEbJGp
         HyvO4SXZNtNmMLSezXxOt1GFZUvU8xOr9u0riNPtbG6A2o43vIEf5c94v4ZdcUQ/+rNA
         09NbTz5Mgy/U+8mMr6AAl1/vUPkueJt0UHwsbWG3+q7l+/SeT1Za/tB2usl63ImC6Iqf
         Y4Og==
X-Gm-Message-State: APjAAAVX1XL4PXVWExXRv2a3FQ2mHbtqRNbZ2YgU8z0/8nYn4u+xpCf+
        7f32MQtaREYqi5KzILq3sFk0XhhtpRHD3q7EPg8=
X-Google-Smtp-Source: APXvYqzvsE9JWkTyA/qGCPe6FC5SfX/eWtD++abCAXNNUKmVhLTpM4TrHUCIWNo6kY2HmIQTdm2QXbcLDAmQBj9bi24=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr21412346oig.103.1579081768509;
 Wed, 15 Jan 2020 01:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20200115063410.131692-1-hsinyi@chromium.org>
In-Reply-To: <20200115063410.131692-1-hsinyi@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jan 2020 10:49:17 +0100
Message-ID: <CAJZ5v0jng1hpPzYUcPj96G9c8aqNYCwDqLHyQEVC9tD=F1dObw@mail.gmail.com>
Subject: Re: [PATCH v5] reboot: support offline CPUs before reboot
To:     Hsin-Yi Wang <hsinyi@chromium.org>
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

On Wed, Jan 15, 2020 at 7:35 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Currently system reboots uses architecture specific codes (smp_send_stop)
> to offline non reboot CPUs. Most architecture's implementation is looping
> through all non reboot online CPUs and call ipi function to each of them. Some
> architecture like arm64, arm, and x86... would set offline masks to cpu without
> really offline them. This causes some race condition and kernel warning comes
> out sometimes when system reboots.
>
> This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would offline cpus in
> migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> checking online cpus would be an empty loop. If architecture don't enable this
> config, or some cpus somehow fails to offline, it would fallback to ipi
> function.
>
> Opt in this config for architectures that support CONFIG_HOTPLUG_CPU.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Change from v4:
> * fix a few nits: naming, comments, remove Kconfig text...
>
> Change from v3:
> * Opt in config for architectures that support CONFIG_HOTPLUG_CPU
> * Merge function offline_secondary_cpus() and freeze_secondary_cpus()
>   with an additional flag.

This does not seem to be a very good idea, since
freeze_secondary_cpus() does much more than you need for reboot.

For reboot, you basically only need to do something like this AFAICS:

cpu_maps_update_begin();

for_each_online_cpu(i) {
        if (i != cpu)
                _cpu_down(i, 1, CPUHP_OFFLINE);
}
cpu_hotplug_disabled++;

cpu_maps_update_done();

And you may put this into a function defined outside of CONFIG_PM_SLEEP.

>
> Change from v2:
> * Add another config instead of configed by CONFIG_HOTPLUG_CPU

So why exactly is this new Kconfig option needed?

Everybody supporting CPU hotplug seems to opt in anyway.

[cut]

>
> -int freeze_secondary_cpus(int primary)
> +int freeze_secondary_cpus(int primary, bool reboot)
>  {
>         int cpu, error = 0;
>
> @@ -1237,11 +1237,13 @@ int freeze_secondary_cpus(int primary)
>                 if (cpu == primary)
>                         continue;
>
> -               if (pm_wakeup_pending()) {
> +#ifdef CONFIG_PM_SLEEP
> +               if (!reboot && pm_wakeup_pending()) {
>                         pr_info("Wakeup pending. Abort CPU freeze\n");
>                         error = -EBUSY;
>                         break;
>                 }
> +#endif

Please avoid using #ifdefs in function bodies.  This makes the code
hard to maintain in the long term.

>
>                 trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
>                 error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
> @@ -1250,7 +1252,9 @@ int freeze_secondary_cpus(int primary)
>                         cpumask_set_cpu(cpu, frozen_cpus);
>                 else {
>                         pr_err("Error taking CPU%d down: %d\n", cpu, error);
> -                       break;
> +                       /* When rebooting, offline as many CPUs as possible. */
> +                       if (!reboot)
> +                               break;
>                 }
>         }
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index c4d472b7f1b4..12f643b66e57 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -7,6 +7,7 @@
>
>  #define pr_fmt(fmt)    "reboot: " fmt
>
> +#include <linux/cpu.h>
>  #include <linux/ctype.h>
>  #include <linux/export.h>
>  #include <linux/kexec.h>
> @@ -220,7 +221,9 @@ void migrate_to_reboot_cpu(void)
>         /* The boot cpu is always logical cpu 0 */
>         int cpu = reboot_cpu;
>
> +#if !IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
>         cpu_hotplug_disable();
> +#endif

You can write this as

if (!IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT))
        cpu_hotplug_disable();

That's what IS_ENABLED() is there for.

>
>         /* Make certain the cpu I'm about to reboot on is online */
>         if (!cpu_online(cpu))
> @@ -231,6 +234,11 @@ void migrate_to_reboot_cpu(void)
>
>         /* Make certain I only run on the appropriate processor */
>         set_cpus_allowed_ptr(current, cpumask_of(cpu));
> +
> +#if IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> +       /* Offline other cpus if possible */
> +       freeze_secondary_cpus(cpu, true);
> +#endif

The above comment applies here too.

>  }
>
>  /**
> --
