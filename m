Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD822483E
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jul 2020 05:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGRDO3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 23:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbgGRDO3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Jul 2020 23:14:29 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241D222B48
        for <linux-pm@vger.kernel.org>; Sat, 18 Jul 2020 03:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595042068;
        bh=24uFYMthOrL4UuVjEYj+QUe8/pbaGdx4LvKJbHi2cuE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=scKMI63lvbDIy9cjSaqoguK1EzwVs3BvLGuSK5Jy2Lq0lWkODfq+enHnopNyafd6I
         Kk+ilRmii5gjRRbJ67I0S9WexzZmziseCgbQPy/OqcB7zHTKH8qJL0bFpaOsP1O+i2
         mMBQqTTHKGY0EynCQE8GD2Do9YZcnt5XLD1R1KpE=
Received: by mail-wr1-f50.google.com with SMTP id o11so13019098wrv.9
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 20:14:28 -0700 (PDT)
X-Gm-Message-State: AOAM532PkGQJrKO/NMrFdu5DD46nmjd60g5ygfd3iFF1DhD4EhDk+Pm+
        KDmYEoOQ88h7DVNOQnkCFi0El4qGmimWhnbBxwU7qA==
X-Google-Smtp-Source: ABdhPJzlyJ74IbiFnl0jVhJFyCtCdCHdRHgHKQfrNUYP5f3E6xPecIEfSGXZJZvvJpNR80yxwBagWOIwMh+7waXRPsU=
X-Received: by 2002:adf:f707:: with SMTP id r7mr12760446wrp.70.1595042066566;
 Fri, 17 Jul 2020 20:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200718021331.940659-1-joshdon@google.com>
In-Reply-To: <20200718021331.940659-1-joshdon@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 17 Jul 2020 20:14:14 -0700
X-Gmail-Original-Message-ID: <CALCETrXHEhwBS72_Fiv9LbPjsBGp_rMmU16oYMTZJFa=wTki8A@mail.gmail.com>
Message-ID: <CALCETrXHEhwBS72_Fiv9LbPjsBGp_rMmU16oYMTZJFa=wTki8A@mail.gmail.com>
Subject: Re: [RFC][PATCH] x86: optimization to avoid CAL+RES IPIs
To:     Josh Don <joshdon@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On Jul 17, 2020, at 7:13 PM, Josh Don <joshdon@google.com> wrote:
>
> =EF=BB=BFFrom: Venkatesh Pallipadi <venki@google.com>
>
> smp_call_function_single and smp_send_reschedule send unconditional IPI
> to target CPU. However, if the target CPU is in some form of poll based
> idle, we can do IPI-less wakeups.
>
> Doing this has certain advantages:
> * Lower overhead on Async "no wait" IPI send path.
> * Avoiding actual interrupts reduces system non-idle cycles.
>
> Note that this only helps when target CPU is idle. When it is busy we
> will still send an IPI as before.

PeterZ and I fixed a whole series of bugs a few years ago, and remote
wakeups *should* already do this. Did we miss something?  Did it
regress?  Even the call_function_single path ought to go through this:

void send_call_function_single_ipi(int cpu)
{
        struct rq *rq =3D cpu_rq(cpu);

        if (!set_nr_if_polling(rq->idle))
                arch_send_call_function_single_ipi(cpu);
        else
                trace_sched_wake_idle_without_ipi(cpu);
}


>
> *** RFC NOTE ***
> This patch breaks idle time accounting (and to a lesser degree, softirq
> accounting). This is because this patch violates the assumption that
> softirq can only be run either on the tail of a hard IRQ or inline on
> a non-idle thread via local_bh_enable(), since we can now process
> softirq inline within the idle loop. These ssues can be resolved in a
> later version of this patch.
>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
> arch/x86/include/asm/mwait.h       |  5 +-
> arch/x86/include/asm/processor.h   |  1 +
> arch/x86/include/asm/thread_info.h |  2 +
> arch/x86/kernel/apic/ipi.c         |  8 +++
> arch/x86/kernel/smpboot.c          |  4 ++
> drivers/cpuidle/poll_state.c       |  5 +-
> include/linux/ipiless_wake.h       | 93 ++++++++++++++++++++++++++++++
> kernel/sched/idle.c                | 10 +++-
> 8 files changed, 124 insertions(+), 4 deletions(-)
> create mode 100644 include/linux/ipiless_wake.h
>
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index e039a933aca3..aed393f38a39 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -2,6 +2,7 @@
> #ifndef _ASM_X86_MWAIT_H
> #define _ASM_X86_MWAIT_H
>
> +#include <linux/ipiless_wake.h>
> #include <linux/sched.h>
> #include <linux/sched/idle.h>
>
> @@ -109,6 +110,7 @@ static inline void __sti_mwait(unsigned long eax, uns=
igned long ecx)
> static inline void mwait_idle_with_hints(unsigned long eax, unsigned long=
 ecx)
> {
>    if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_te=
st()) {
> +        enter_ipiless_idle();
>        if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
>            mb();
>            clflush((void *)&current_thread_info()->flags);
> @@ -116,8 +118,9 @@ static inline void mwait_idle_with_hints(unsigned lon=
g eax, unsigned long ecx)
>        }
>
>        __monitor((void *)&current_thread_info()->flags, 0, 0);
> -        if (!need_resched())
> +        if (!is_ipiless_wakeup_pending())
>            __mwait(eax, ecx);
> +        exit_ipiless_idle();
>    }
>    current_clr_polling();
> }
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 03b7c4ca425a..045fc9bbd095 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -568,6 +568,7 @@ static inline void arch_thread_struct_whitelist(unsig=
ned long *offset,
>  * have to worry about atomic accesses.
>  */
> #define TS_COMPAT        0x0002    /* 32bit syscall active (64BIT)*/
> +#define TS_IPILESS_WAKEUP    0x0010    /* pending IPI-work on idle exit =
*/

What's this for?

> +#define _TIF_IN_IPILESS_IDLE    (1 << TIF_IN_IPILESS_IDLE)

We already have TIF_POLLING_NRFLAG.  Why do we need this?


> #include "local.h"
> @@ -67,11 +68,18 @@ void native_smp_send_reschedule(int cpu)
>        WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
>        return;
>    }
> +
> +    if (try_ipiless_wakeup(cpu))
> +        return;
> +

I think this shouldn=E2=80=99t be called if the target is idle unless we lo=
st
a race. What am I missing?

>    apic->send_IPI(cpu, RESCHEDULE_VECTOR);
> }
>
> void native_send_call_func_single_ipi(int cpu)
> {
> +    if (try_ipiless_wakeup(cpu))
> +        return;
> +
>    apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
> }

This function's caller already does this.

> +static inline void exit_ipiless_idle(void)
> +{
> +    if (!test_and_clear_thread_flag(TIF_IN_IPILESS_IDLE)) {

This has the unfortunate property that, if you try to wake the same
polling CPU twice in rapid succession, the second try will send an
IPI.  One might debate whether this is a real problem, but the
existing code does not have this issue.

I could poke at this more, but I'm wondering whether you might have
developed this against a rather old kernel and blindly forward-ported
it.

--Andy
