Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B85BA62C0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 09:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfICHiT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 03:38:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37150 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfICHiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 03:38:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id 97so12927860otr.4;
        Tue, 03 Sep 2019 00:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgv3fsLJjWKGCW1RMUO1yCDwdzVKySq0r17nwYHD1vA=;
        b=rY5c9Sx37mIZR6PvND82hQmO6dg6ZN8ill58oTmcOKrAgdnbligMxO9xq9pQ9+hwYJ
         Z4hZ0mYbQ/5mjnx4pnlN4wN/shBK0BkfmvZ8TgPz9mlaBFL6dXtrZ4qG6dUg7Pxbj206
         9+aEx3rs55PO1q4774b3dUAvqYAeg2pzOxIC4MT8lI6sOuzGOMDV+m/IRYd4Ks2tlpst
         Fa3xOxoWQvzhurCM9Y/GtKbY5IkdSWVCBdV2VPoYQOl5acpI0nIRU0g1ioZAvTvUXXsf
         QGuY4Hc5LCqEvcSRYSX4LkjyTvqOr+KzlNUmzMSz365+4OgWXRjA5wPMqHuxmfcGgfFW
         8WdA==
X-Gm-Message-State: APjAAAXP24ouc8IqYBtYF7dNwQcBNfwcNOZ9DGyjs30EQf2aR4vULpef
        rRvbMpBcNV9TrH1RiIjnBHlCNR5+MlsAMrlDGAA=
X-Google-Smtp-Source: APXvYqyLmPlbZsLeasmpOnpHIOq+ZaDFB04U1ooeecfuh9UgG0F0fak68Z+IwTrB5rAVPp7mnl6V/VqAfXokogVBl0Y=
X-Received: by 2002:a05:6830:154:: with SMTP id j20mr27989435otp.266.1567496297709;
 Tue, 03 Sep 2019 00:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190902104031.9296-1-joao.m.martins@oracle.com>
 <CAJZ5v0g1rjRsaC1R2xvtn4WtCaWtedFQk+oNUgB5sPAc6cU8rA@mail.gmail.com> <20190902221701.GA31730@amt.cnet>
In-Reply-To: <20190902221701.GA31730@amt.cnet>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Sep 2019 09:38:06 +0200
Message-ID: <CAJZ5v0jCV6RpxxC2_H2epSov51DinywiTn29F-XqO7tN+GG5EQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle-haltpoll: vcpu hotplug support
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm-devel <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 3, 2019 at 12:18 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Mon, Sep 02, 2019 at 10:34:07PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Sep 2, 2019 at 12:43 PM Joao Martins <joao.m.martins@oracle.com> wrote:
> > >
> > > When cpus != maxcpus cpuidle-haltpoll will fail to register all vcpus
> > > past the online ones and thus fail to register the idle driver.
> > > This is because cpuidle_add_sysfs() will return with -ENODEV as a
> > > consequence from get_cpu_device() return no device for a non-existing
> > > CPU.
> > >
> > > Instead switch to cpuidle_register_driver() and manually register each
> > > of the present cpus through cpuhp_setup_state() callbacks and future
> > > ones that get onlined or offlined. This mimmics similar logic that
> > > intel_idle does.
> > >
> > > Fixes: fa86ee90eb11 ("add cpuidle-haltpoll driver")
> > > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > > Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > ---
> > > v3:
> > > * register the teardown callback for correct handling of hotunplug
> > > and error cases. In case cpuhp_setup_state calls fails (e.g. in one of
> > > the cpus that it invoked the callback) it will then call the teardown of
> > > the previously enabled devices; so no need to handle that manually in
> > > haltpoll_uninit().
> > > * use the cpuhp_setup_state() returned dyn allocated state when it
> > > succeeds. And use that state in haltpoll_unint() to call
> > > cpuhp_remove_state() instead of looping online cpus manually. This
> > > is because cpuhp_remove_state() invokes the teardown/offline callback.
> > > * fix subsystem name to 'cpuidle' instead of 'idle' in cpuhp_setup_state()
> >
> > Marcelo, is the R-by still applicable?
> >
> > Paolo, any comments?
> >
> > >
> > > v2:
> > > * move cpus_read_unlock() after unregistering all cpuidle_devices;
> > > (Marcello Tosatti)
> > > * redundant usage of cpuidle_unregister() when only
> > > cpuidle_unregister_driver() suffices; (Marcelo Tosatti)
> > > * cpuhp_setup_state() returns a state (> 0) for CPUHP_AP_ONLINE_DYN
> > > ---
> > >  arch/x86/include/asm/cpuidle_haltpoll.h |  4 +-
> > >  arch/x86/kernel/kvm.c                   | 18 +++----
> > >  drivers/cpuidle/cpuidle-haltpoll.c      | 68 +++++++++++++++++++++++--
> > >  include/linux/cpuidle_haltpoll.h        |  4 +-
> > >  4 files changed, 73 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/cpuidle_haltpoll.h b/arch/x86/include/asm/cpuidle_haltpoll.h
> > > index ff8607d81526..c8b39c6716ff 100644
> > > --- a/arch/x86/include/asm/cpuidle_haltpoll.h
> > > +++ b/arch/x86/include/asm/cpuidle_haltpoll.h
> > > @@ -2,7 +2,7 @@
> > >  #ifndef _ARCH_HALTPOLL_H
> > >  #define _ARCH_HALTPOLL_H
> > >
> > > -void arch_haltpoll_enable(void);
> > > -void arch_haltpoll_disable(void);
> > > +void arch_haltpoll_enable(unsigned int cpu);
> > > +void arch_haltpoll_disable(unsigned int cpu);
> > >
> > >  #endif
> > > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > > index 8d150e3732d9..a9b6c4e2446d 100644
> > > --- a/arch/x86/kernel/kvm.c
> > > +++ b/arch/x86/kernel/kvm.c
> > > @@ -880,32 +880,26 @@ static void kvm_enable_host_haltpoll(void *i)
> > >         wrmsrl(MSR_KVM_POLL_CONTROL, 1);
> > >  }
> > >
> > > -void arch_haltpoll_enable(void)
> > > +void arch_haltpoll_enable(unsigned int cpu)
> > >  {
> > >         if (!kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL)) {
> > > -               printk(KERN_ERR "kvm: host does not support poll control\n");
> > > -               printk(KERN_ERR "kvm: host upgrade recommended\n");
> > > +               pr_err_once("kvm: host does not support poll control\n");
> > > +               pr_err_once("kvm: host upgrade recommended\n");
> > >                 return;
> > >         }
> > >
> > > -       preempt_disable();
> > >         /* Enable guest halt poll disables host halt poll */
> > > -       kvm_disable_host_haltpoll(NULL);
> > > -       smp_call_function(kvm_disable_host_haltpoll, NULL, 1);
> > > -       preempt_enable();
> > > +       smp_call_function_single(cpu, kvm_disable_host_haltpoll, NULL, 1);
> > >  }
> > >  EXPORT_SYMBOL_GPL(arch_haltpoll_enable);
> > >
> > > -void arch_haltpoll_disable(void)
> > > +void arch_haltpoll_disable(unsigned int cpu)
> > >  {
> > >         if (!kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL))
> > >                 return;
> > >
> > > -       preempt_disable();
> > >         /* Enable guest halt poll disables host halt poll */
> > > -       kvm_enable_host_haltpoll(NULL);
> > > -       smp_call_function(kvm_enable_host_haltpoll, NULL, 1);
> > > -       preempt_enable();
> > > +       smp_call_function_single(cpu, kvm_enable_host_haltpoll, NULL, 1);
> > >  }
> > >  EXPORT_SYMBOL_GPL(arch_haltpoll_disable);
> > >  #endif
> > > diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
> > > index 9ac093dcbb01..56d8ab814466 100644
> > > --- a/drivers/cpuidle/cpuidle-haltpoll.c
> > > +++ b/drivers/cpuidle/cpuidle-haltpoll.c
> > > @@ -11,12 +11,16 @@
> > >   */
> > >
> > >  #include <linux/init.h>
> > > +#include <linux/cpu.h>
> > >  #include <linux/cpuidle.h>
> > >  #include <linux/module.h>
> > >  #include <linux/sched/idle.h>
> > >  #include <linux/kvm_para.h>
> > >  #include <linux/cpuidle_haltpoll.h>
> > >
> > > +static struct cpuidle_device __percpu *haltpoll_cpuidle_devices;
> > > +static enum cpuhp_state haltpoll_hp_state;
> > > +
> > >  static int default_enter_idle(struct cpuidle_device *dev,
> > >                               struct cpuidle_driver *drv, int index)
> > >  {
> > > @@ -46,6 +50,46 @@ static struct cpuidle_driver haltpoll_driver = {
> > >         .state_count = 2,
> > >  };
> > >
> > > +static int haltpoll_cpu_online(unsigned int cpu)
> > > +{
> > > +       struct cpuidle_device *dev;
> > > +
> > > +       dev = per_cpu_ptr(haltpoll_cpuidle_devices, cpu);
> > > +       if (!dev->registered) {
> > > +               dev->cpu = cpu;
> > > +               if (cpuidle_register_device(dev)) {
> > > +                       pr_notice("cpuidle_register_device %d failed!\n", cpu);
> > > +                       return -EIO;
> > > +               }
> > > +               arch_haltpoll_enable(cpu);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int haltpoll_cpu_offline(unsigned int cpu)
> > > +{
> > > +       struct cpuidle_device *dev;
> > > +
> > > +       dev = per_cpu_ptr(haltpoll_cpuidle_devices, cpu);
> > > +       if (dev->registered) {
> > > +               arch_haltpoll_disable(cpu);
> > > +               cpuidle_unregister_device(dev);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void haltpoll_uninit(void)
> > > +{
> > > +       if (haltpoll_hp_state)
> > > +               cpuhp_remove_state(haltpoll_hp_state);
> > > +       cpuidle_unregister_driver(&haltpoll_driver);
> > > +
> > > +       free_percpu(haltpoll_cpuidle_devices);
> > > +       haltpoll_cpuidle_devices = NULL;
> > > +}
> > > +
> > >  static int __init haltpoll_init(void)
> > >  {
> > >         int ret;
> > > @@ -56,17 +100,31 @@ static int __init haltpoll_init(void)
> > >         if (!kvm_para_available())
> > >                 return 0;
> > >
> > > -       ret = cpuidle_register(&haltpoll_driver, NULL);
> > > -       if (ret == 0)
> > > -               arch_haltpoll_enable();
> > > +       ret = cpuidle_register_driver(drv);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       haltpoll_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> > > +       if (haltpoll_cpuidle_devices == NULL) {
> > > +               cpuidle_unregister_driver(drv);
> > > +               return -ENOMEM;
> > > +       }
> > > +
> > > +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "cpuidle/haltpoll:online",
> > > +                               haltpoll_cpu_online, haltpoll_cpu_offline);
> > > +       if (ret < 0) {
> > > +               haltpoll_uninit();
> > > +       } else {
> > > +               haltpoll_hp_state = ret;
> > > +               ret = 0;
> > > +       }
> > >
> > >         return ret;
> > >  }
> > >
> > >  static void __exit haltpoll_exit(void)
> > >  {
> > > -       arch_haltpoll_disable();
> > > -       cpuidle_unregister(&haltpoll_driver);
> > > +       haltpoll_uninit();
> > >  }
> > >
> > >  module_init(haltpoll_init);
> > > diff --git a/include/linux/cpuidle_haltpoll.h b/include/linux/cpuidle_haltpoll.h
> > > index fe5954c2409e..d50c1e0411a2 100644
> > > --- a/include/linux/cpuidle_haltpoll.h
> > > +++ b/include/linux/cpuidle_haltpoll.h
> > > @@ -5,11 +5,11 @@
> > >  #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
> > >  #include <asm/cpuidle_haltpoll.h>
> > >  #else
> > > -static inline void arch_haltpoll_enable(void)
> > > +static inline void arch_haltpoll_enable(unsigned int cpu)
> > >  {
> > >  }
> > >
> > > -static inline void arch_haltpoll_disable(void)
> > > +static inline void arch_haltpoll_disable(unsigned int cpu)
> > >  {
> > >  }
> > >  #endif
> > > --
> > > 2.17.1
> > >
>
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>

OK, queued for v5.4, thanks!
