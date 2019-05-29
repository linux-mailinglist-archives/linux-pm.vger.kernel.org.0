Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5DB2D74F
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 10:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfE2IHK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 04:07:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39030 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfE2IHK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 04:07:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id r7so1136458otn.6;
        Wed, 29 May 2019 01:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yy0bNJQFbJVnqRK14UZwcJgtjydcVuENrHNgGXOjxVU=;
        b=h3ACObFHGzl33KgF49CHSRFqZXuHpCmxzH1zpEimy53aE4QST4sSVqA0BLp06u27J/
         wkD7+8IGqOkMlBlktWZ30yE/tFFKiKhKxk9VMQBRg2UEucC2MIfxdKSo+jua2bMQdLm4
         jCQAoSYnTrY1IQkw1nuaJ9Q8vCMDKYrhUozOYh0Me2HP6r7/q+up4RonISGteKTD36K7
         OXQ2YjihExSU5YALLOP2pAa3QGRf7o623yg7BS6/QbyutxsFnkEVq7HWnwzacQJCScg9
         677dHlQuHF7yXOGsEws01Wzoh+WZ5HoCky3DGL6iVC11fM07hKTCZBJiUCfEv30ordrS
         3ThQ==
X-Gm-Message-State: APjAAAVHZoHdKdIeCkKvLtB0HQyZw5SZWGheMpEJXXIhNDql3hhs9ly4
        yTqrugGs3hTJVdjKeng4GlZQe0j6myQVyjlSg4MKdg==
X-Google-Smtp-Source: APXvYqxcufdDhH+ZaS5I6ADG9FWcI34ncwUCnVHXLBjEmakZrufmDYQ9toaeib3Ryqj5ER4NGEJ4iZN3xnhyR6yzylI=
X-Received: by 2002:a05:6830:1694:: with SMTP id k20mr50371613otr.262.1559117229494;
 Wed, 29 May 2019 01:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 May 2019 10:06:57 +0200
Message-ID: <CAJZ5v0h995q0rLj_32Xshd5TRTT9A9rFjYn3C1jfQ=koB1PAnw@mail.gmail.com>
Subject: Re: [PATCH] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 28, 2019 at 11:31 PM Jiri Kosina <jikos@kernel.org> wrote:
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
>
> Cc: stable@vger.kernel.org # v4.19+
> Debugged-by: Thomas Gleixner <tglx@linutronix.de>
> Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

I can take this or, in case it is better to route it through x86:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/power/cpu.c | 11 +++++++++++
>  include/linux/cpu.h  |  2 ++
>  kernel/cpu.c         |  2 +-
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index a7d966964c6f..bde8ce1f6c6c 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -299,9 +299,20 @@ int hibernate_resume_nonboot_cpu_disable(void)
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
>         smp_ops.play_dead = resume_play_dead;
> +       ret = cpuhp_smt_enable();
> +       if (ret)
> +               goto out;
>         ret = disable_nonboot_cpus();
> +out:
>         smp_ops.play_dead = play_dead;
>         return ret;
>  }
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 3813fe45effd..b5523552a607 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -201,10 +201,12 @@ enum cpuhp_smt_control {
>  extern enum cpuhp_smt_control cpu_smt_control;
>  extern void cpu_smt_disable(bool force);
>  extern void cpu_smt_check_topology(void);
> +extern int cpuhp_smt_enable(void);
>  #else
>  # define cpu_smt_control               (CPU_SMT_NOT_IMPLEMENTED)
>  static inline void cpu_smt_disable(bool force) { }
>  static inline void cpu_smt_check_topology(void) { }
> +static inline int cpuhp_smt_enable(void) { return 0; }
>  #endif
>
>  /*
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index f2ef10460698..3ff5ce0e4132 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2093,7 +2093,7 @@ static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>         return ret;
>  }
>
> -static int cpuhp_smt_enable(void)
> +int cpuhp_smt_enable(void)
>  {
>         int cpu, ret = 0;
>
>
> --
> Jiri Kosina
> SUSE Labs
