Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD745C29E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 14:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351325AbhKXNar (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 08:30:47 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:37481 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350767AbhKXN2g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 08:28:36 -0500
Received: by mail-oi1-f172.google.com with SMTP id bj13so5319286oib.4
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 05:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZ7qfefsclB7CxTXIvwdiZVWAMNePt0cllRE7I51zkg=;
        b=HvR/A/5RIF81DNWY4ZZV91/xXfiH16pUOO95jPP4qNr4DzSkFZEzDrg7g30LHTmSPr
         PizF8SXE4uspI+hrxk/QVUrKb9BWoN/tLItn+UjN0DZ7jPJCnDL6PKA7oSppgwkIYsCh
         92/GLYdKaw/AtceZizQD+Akx5KXA4iIqw4mmBv5oKeKAtvGafT/haITw9kpiFohsTOmx
         TFAgfHw72U7BVbQ9Pyx0SUBcaqwolipwQ7Uvvz9sTojj72mNheUtOYDdmihmpzwCzhjl
         XoSitESwnC6cI+Wcdx+25Hxv3rAapqlopnlCNIylUp5NLFWJpM3ACpCeQ0UXXjj0Pzi4
         xBxg==
X-Gm-Message-State: AOAM531jDqZAHEiLTeO4GoC0A6KI31Q+wavvZINg5nNfz/XxReJpWxXf
        TQQJNAvPaH8m7i9GwK5xA4ztMNK/8e3XKRWCSU8=
X-Google-Smtp-Source: ABdhPJzaJ04wmXyRH7UkZYBkCjgCBTmtJIDHXS15SBI/Prucjjy/bjUezTeZ52BX1Tc0lreY3MOu+PXvIeG7xf76cPA=
X-Received: by 2002:a05:6808:14c3:: with SMTP id f3mr5988211oiw.51.1637760326777;
 Wed, 24 Nov 2021 05:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20211027082237.26759-1-rui.zhang@intel.com>
In-Reply-To: <20211027082237.26759-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 14:25:15 +0100
Message-ID: <CAJZ5v0gAdQBaXNM-QrobW+FB2Ug7U-xOycvf2BQYeWz_3ZbFgA@mail.gmail.com>
Subject: Re: [PATCH 1/3] intel_idle: cleanup code for handling with cpuidle framework
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 27, 2021 at 10:07 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Introduce two helper functions and move all the code that deals with
> the cpuidle framework into them.

So what exactly is the benefit?

The role of intel_idle_cpuidle_devices_uninit() was to contain the
loop over CPUs and now it is combined with the driver unregistration
which looks confusing to me, because this function is only called in
one place in the error patch of intel_idle_init().

The existing code flow is easier to follow for me TBH and it is fewer
lines of code.

> No functional change in this patch.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/idle/intel_idle.c | 67 ++++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index e6c543b5ee1d..ae9d8c43e6a5 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1677,14 +1677,46 @@ static int intel_idle_cpu_online(unsigned int cpu)
>  }
>
>  /**
> - * intel_idle_cpuidle_devices_uninit - Unregister all cpuidle devices.
> + * intel_idle_cpuidle_unregister - unregister from cpuidle framework
>   */
> -static void __init intel_idle_cpuidle_devices_uninit(void)
> +static void __init intel_idle_cpuidle_unregister(struct cpuidle_driver *drv)
>  {
>         int i;
>
>         for_each_online_cpu(i)
>                 cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
> +       cpuidle_unregister_driver(drv);
> +       free_percpu(intel_idle_cpuidle_devices);
> +}
> +
> +/**
> + * intel_idle_cpuidle_register - register to cpuidle framework
> + */
> +static int __init intel_idle_cpuidle_register(struct cpuidle_driver *drv)
> +{
> +       int retval;
> +
> +       intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> +       if (!intel_idle_cpuidle_devices)
> +               return -ENOMEM;
> +
> +       retval = cpuidle_register_driver(drv);
> +       if (retval) {
> +               struct cpuidle_driver *drv = cpuidle_get_driver();
> +
> +               printk(KERN_DEBUG pr_fmt("intel_idle yielding to %s\n"),
> +                       drv ? drv->name : "none");
> +               free_percpu(intel_idle_cpuidle_devices);
> +               return retval;
> +       }
> +
> +       retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
> +                               intel_idle_cpu_online, NULL);
> +       if (retval < 0) {
> +               intel_idle_cpuidle_unregister(drv);
> +               return retval;
> +       }
> +       return 0;
>  }
>
>  static int __init intel_idle_init(void)
> @@ -1740,37 +1772,14 @@ static int __init intel_idle_init(void)
>         pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
>                  boot_cpu_data.x86_model);
>
> -       intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> -       if (!intel_idle_cpuidle_devices)
> -               return -ENOMEM;
> -
>         intel_idle_cpuidle_driver_init(&intel_idle_driver);
>
> -       retval = cpuidle_register_driver(&intel_idle_driver);
> -       if (retval) {
> -               struct cpuidle_driver *drv = cpuidle_get_driver();
> -               printk(KERN_DEBUG pr_fmt("intel_idle yielding to %s\n"),
> -                      drv ? drv->name : "none");
> -               goto init_driver_fail;
> -       }
> -
> -       retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
> -                                  intel_idle_cpu_online, NULL);
> -       if (retval < 0)
> -               goto hp_setup_fail;
> -
> -       pr_debug("Local APIC timer is reliable in %s\n",
> -                boot_cpu_has(X86_FEATURE_ARAT) ? "all C-states" : "C1");
> +       retval = intel_idle_cpuidle_register(&intel_idle_driver);
> +       if (!retval)
> +               pr_debug("Local APIC timer is reliable in %s\n",
> +                       boot_cpu_has(X86_FEATURE_ARAT) ? "all C-states" : "C1");
>
> -       return 0;
> -
> -hp_setup_fail:
> -       intel_idle_cpuidle_devices_uninit();
> -       cpuidle_unregister_driver(&intel_idle_driver);
> -init_driver_fail:
> -       free_percpu(intel_idle_cpuidle_devices);
>         return retval;
> -
>  }
>  device_initcall(intel_idle_init);
>
> --
> 2.17.1
>
