Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1E2F8B2
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 10:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfE3IrM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 04:47:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41921 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfE3IrM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 04:47:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id l25so4852849otp.8;
        Thu, 30 May 2019 01:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wqwILg9bPvbTOZyUBEavR8/uT+INOe/JPe0pE90Xiw=;
        b=U4BIxpwcXbC2fET4TSrIgPEh+OKBvrPHyaHYVcQ2f3U3qY/O1meLm6Dyr31oJdbHgl
         P3X9pFQ2n3WSbqBYMksr7uqhKWKMJTGgCMRtOvLlRW6EToDFuxpEky6lH7Vz16sAyPCz
         DwemZClnWzuNPbR8iBw100VO4pjng4XSzoT9QNMZXdnYSnTMZUZQm2P31OhMykkISm0g
         3i0GtxtQYddWLSRNDmRjzPRBKlWwHEzvcOuq2RbZZ0oa3+3RN+gy24rEmJCviZ9LucT1
         eJmk03YK8f/fmtKLcGMMi782iDJ/sA4LqnqbM6AqWuqD5cdSOGq9JZpDHe1Cw4YXhYaH
         B74g==
X-Gm-Message-State: APjAAAVntLQ4+n+eQjWglFFBwZEQ5R9AP/G/+NbpUcHw6ZVMMiPi5Xwl
        JEA/TQ42Roq2LQ5cp60fMjpeNdpQc4sC6VykWgk=
X-Google-Smtp-Source: APXvYqy2a5FwNSGbZ4sELrERuEN8DCFLbok1lh4NCQ2pi6fUvSnROzG+vZxfFKpNJD7za6/wSUF8PWLlk5MkqyZIGp0=
X-Received: by 2002:a9d:6e88:: with SMTP id a8mr1610597otr.118.1559206030915;
 Thu, 30 May 2019 01:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 May 2019 10:46:59 +0200
Message-ID: <CAJZ5v0ja5sQ73zMvUtV+w79LC_d+g6UdomL36rV-EpVDxEzbhA@mail.gmail.com>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
To:     Jiri Kosina <jikos@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 30, 2019 at 12:09 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> From: Jiri Kosina <jkosina@suse.cz>
>
> As explained in
>
>         0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
>
> we always, no matter what, have to bring up x86 HT siblings during boot at
> least once in order to avoid first MCE bringing the system to its knees.
>
> That means that whenever 'nosmt' is supplied on the kernel command-line,
> all the HT siblings are as a result sitting in mwait or cpudile after
> going through the online-offline cycle at least once.
>
> This causes a serious issue though when a kernel, which saw 'nosmt' on its
> commandline, is going to perform resume from hibernation: if the resume
> from the hibernated image is successful, cr3 is flipped in order to point
> to the address space of the kernel that is being resumed, which in turn
> means that all the HT siblings are all of a sudden mwaiting on address
> which is no longer valid.
>
> That results in triple fault shortly after cr3 is switched, and machine
> reboots.
>
> Fix this by always waking up all the SMT siblings before initiating the
> 'restore from hibernation' process; this guarantees that all the HT
> siblings will be properly carried over to the resumed kernel waiting in
> resume_play_dead(), and acted upon accordingly afterwards, based on the
> target kernel configuration.
> Symmetricaly, the resumed kernel has to push the SMT siblings to mwait
> again in case it has SMT disabled; this means it has to online all
> the siblings when resuming (so that they come out of hlt) and offline
> them again to let them reach mwait.
>
> Cc: stable@vger.kernel.org # v4.19+
> Debugged-by: Thomas Gleixner <tglx@linutronix.de>
> Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

LGTM

And I would prefer this one to go in through the PM tree due to the
hibernate core changes,
so can I get an ACK from the x86 arch side here, please?

> ---
>
> v1 -> v2:
>         - restructure error handling as suggested by peterz
>         - add Rafael's ack
>
> v2 -> v3:
>         - added extra online/offline dance for nosmt case during
>           resume, as we want the siblings to be in mwait, not hlt
>         - dropped peterz's and Rafael's acks for now due to the above
>
> v3 -> v4:
>         - fix undefined return value from arch_resume_nosmt() in case
>           it's not overriden by arch
>
>  arch/x86/power/cpu.c       | 10 ++++++++++
>  arch/x86/power/hibernate.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/cpu.h        |  4 ++++
>  kernel/cpu.c               |  4 ++--
>  kernel/power/hibernate.c   |  9 +++++++++
>  5 files changed, 58 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index a7d966964c6f..513ce09e9950 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -299,7 +299,17 @@ int hibernate_resume_nonboot_cpu_disable(void)
>          * address in its instruction pointer may not be possible to resolve
>          * any more at that point (the page tables used by it previously may
>          * have been overwritten by hibernate image data).
> +        *
> +        * First, make sure that we wake up all the potentially disabled SMT
> +        * threads which have been initially brought up and then put into
> +        * mwait/cpuidle sleep.
> +        * Those will be put to proper (not interfering with hibernation
> +        * resume) sleep afterwards, and the resumed kernel will decide itself
> +        * what to do with them.
>          */
> +       ret = cpuhp_smt_enable();
> +       if (ret)
> +               return ret;
>         smp_ops.play_dead = resume_play_dead;
>         ret = disable_nonboot_cpus();
>         smp_ops.play_dead = play_dead;
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index 4845b8c7be7f..fc413717a45f 100644
> --- a/arch/x86/power/hibernate.c
> +++ b/arch/x86/power/hibernate.c
> @@ -11,6 +11,7 @@
>  #include <linux/suspend.h>
>  #include <linux/scatterlist.h>
>  #include <linux/kdebug.h>
> +#include <linux/cpu.h>
>
>  #include <crypto/hash.h>
>
> @@ -245,3 +246,35 @@ int relocate_restore_code(void)
>         __flush_tlb_all();
>         return 0;
>  }
> +
> +int arch_resume_nosmt(void)
> +{
> +       int ret = 0;
> +       /*
> +        * We reached this while coming out of hibernation. This means
> +        * that SMT siblings are sleeping in hlt, as mwait is not safe
> +        * against control transition during resume (see comment in
> +        * hibernate_resume_nonboot_cpu_disable()).
> +        *
> +        * If the resumed kernel has SMT disabled, we have to take all the
> +        * SMT siblings out of hlt, and offline them again so that they
> +        * end up in mwait proper.
> +        *
> +        * Called with hotplug disabled.
> +        */
> +       cpu_hotplug_enable();
> +       if (cpu_smt_control == CPU_SMT_DISABLED ||
> +                       cpu_smt_control == CPU_SMT_FORCE_DISABLED) {
> +               enum cpuhp_smt_control old = cpu_smt_control;
> +
> +               ret = cpuhp_smt_enable();
> +               if (ret)
> +                       goto out;
> +               ret = cpuhp_smt_disable(old);
> +               if (ret)
> +                       goto out;
> +       }
> +out:
> +       cpu_hotplug_disable();
> +       return ret;
> +}
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 3813fe45effd..fcb1386bb0d4 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -201,10 +201,14 @@ enum cpuhp_smt_control {
>  extern enum cpuhp_smt_control cpu_smt_control;
>  extern void cpu_smt_disable(bool force);
>  extern void cpu_smt_check_topology(void);
> +extern int cpuhp_smt_enable(void);
> +extern int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval);
>  #else
>  # define cpu_smt_control               (CPU_SMT_NOT_IMPLEMENTED)
>  static inline void cpu_smt_disable(bool force) { }
>  static inline void cpu_smt_check_topology(void) { }
> +static inline int cpuhp_smt_enable(void) { return 0; }
> +static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0; }
>  #endif
>
>  /*
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index f2ef10460698..077fde6fb953 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2061,7 +2061,7 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
>         kobject_uevent(&dev->kobj, KOBJ_ONLINE);
>  }
>
> -static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
> +int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  {
>         int cpu, ret = 0;
>
> @@ -2093,7 +2093,7 @@ static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>         return ret;
>  }
>
> -static int cpuhp_smt_enable(void)
> +int cpuhp_smt_enable(void)
>  {
>         int cpu, ret = 0;
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index c8c272df7154..b65635753e8e 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -257,6 +257,11 @@ void swsusp_show_speed(ktime_t start, ktime_t stop,
>                 (kps % 1000) / 10);
>  }
>
> +__weak int arch_resume_nosmt(void)
> +{
> +       return 0;
> +}
> +
>  /**
>   * create_image - Create a hibernation image.
>   * @platform_mode: Whether or not to use the platform driver.
> @@ -324,6 +329,10 @@ static int create_image(int platform_mode)
>   Enable_cpus:
>         suspend_enable_secondary_cpus();
>
> +       /* Allow architectures to do nosmt-specific post-resume dances */
> +       if (!in_suspend)
> +               error = arch_resume_nosmt();
> +
>   Platform_finish:
>         platform_finish(platform_mode);
>
>
> --
> Jiri Kosina
> SUSE Labs
>
