Return-Path: <linux-pm+bounces-18078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C59E9D898C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1521B2DE34
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9161B0F11;
	Mon, 25 Nov 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFBlL9+c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A516419;
	Mon, 25 Nov 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545582; cv=none; b=qJV6VmjgczCCf+8J4OUKTv60tfMycWelv6If7SUc8B5piMnsgMURwpHrBaP/xDKkAGBYdlSbMBAcBHJUCNOSW30vDmis+W2KYWG61BpUscnebPCfTrmEq3Co0SqS0zX8WcLa7ShDWz95SsDMYvf1RMhFur3wrpSNBrMnVFUhUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545582; c=relaxed/simple;
	bh=OxRZWUUSfbFkcntmgQi1+KlkIK8zh8tts5v0ZSzKSqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPjkdWHt/ZjDjScDu/W/lvFqOv8H9EHNEG2XmKV27Tm8Ug4+34yGmujg5zcvb0hJQqKWB7I5fq0u0IMKRru7gx1SVDIYfZwkUXWVVQVDkwTEeK71hjkrD4+GJa6BagMbTMAF+NA5ltWABmhn8RJkzXioHbzhG22gJBgt0z0dgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFBlL9+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05908C4CED3;
	Mon, 25 Nov 2024 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732545582;
	bh=OxRZWUUSfbFkcntmgQi1+KlkIK8zh8tts5v0ZSzKSqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uFBlL9+cORSeazYF0mS/NvTEZccPiun4rt1yqvttQxBgxSChxB80FKbAW2HZOB+FH
	 kJ1BbYgK+xKlRq/FUla9Sds+jT0ngj/Oaf3IU0aj3iM8kIpt5vkwRvTCO0DKxNSiv8
	 oAAh9HyNTpn2S033sgIIbvo6sA5C63l0SmtCmQK9bdPXWg38OH3RhD/a1XppSMC1t9
	 Yh8b5c4EU8t//VDg6Ee4wrxCElMY82nCYbrMI4Vxo1NV3dsUUY/nHXuWXuOIAHn106
	 Z1/m7GmujJfJoMuLs1YWqH3HeJDGwJJyOjnaND0NMJ3owl4uFEMv6/blRp0yrGjHxN
	 /OxQLKuSQLQMA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2967af48248so2395569fac.2;
        Mon, 25 Nov 2024 06:39:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKWLY2xN3LyagPkDB86jPeHYpxocJSt/CXOQiQSz7LPeTRx7/4I+SYAt0jMroyYZ7WffSj57ztzieO3B4=@vger.kernel.org, AJvYcCWAv2H4BXIWvV4X9HppsMsx2ViYefyJyEopYOOkK3/9nkUpbEajhrqlMDGAqy16IaDNKb/m7doy1QA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8g0uKiKWBdi9zNd4RRt00v9nMhmsgf+TLMJcOPbMSvnwshX1
	1NMgynRvpTC2fT/LBcIjQRqKDpZyvEk2Yi9rhxH6j7wBWrCr3Mvmw1dv8DVAV3MSTVHRlm9FfvW
	d4Xvf9r5gTuguPO+1v1anJhqlW5k=
X-Google-Smtp-Source: AGHT+IHVR7/rtOmrO214PTCq0UIh0oSdPfq7FSxmS/Kf5dPnQDZiahM7A36Pz6MWfI58TYvNZKqHbFdsvgTXxWrYJ+k=
X-Received: by 2002:a05:6870:4192:b0:296:e00e:22e9 with SMTP id
 586e51a60fabf-29720e5f19amr9637534fac.36.1732545581219; Mon, 25 Nov 2024
 06:39:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com> <20241125132029.7241-5-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241125132029.7241-5-patryk.wlazlyn@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 15:39:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iBCKmp-Hs25chq_-z7-VB_+MqTPVmowACJkTz7KOUtEg@mail.gmail.com>
Message-ID: <CAJZ5v0iBCKmp-Hs25chq_-z7-VB_+MqTPVmowACJkTz7KOUtEg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/8] x86/smp: Allow calling mwait_play_dead with
 arbitrary hint
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:21=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> The MWAIT instruction needs different hints on different CPUs to reach
> the most specific idle states. The current hint calculation* in
> mwait_play_dead() code works in practice on current hardware, but it
> fails on a recent one, Intel's Sierra Forest and possibly some future one=
s.
> Those newer CPUs' power efficiency suffers when the CPU is put offline.
>
>  * The current calculation is the for loop inspecting edx in
>    mwait_play_dead()
>
> The current implementation for looking up the mwait hint for the deepest
> cstate, in mwait_play_dead() code works by inspecting CPUID leaf 0x5 and
> calculates the mwait hint based on the number of reported substates.
> This approach depends on the hints associated with them to be continuous
> in the range [0, NUM_SUBSTATES-1]. This continuity is not documented and
> is not met on the recent Intel platforms.
>
> For example, Intel's Sierra Forest report two cstates with two substates
> each in cpuid leaf 5:
>
>   Name*   target cstate    target subcstate (mwait hint)
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   C1      0x00             0x00
>   C1E     0x00             0x01
>
>   --      0x10             ----
>
>   C6S     0x20             0x22
>   C6P     0x20             0x23
>
>   --      0x30             ----
>
>   /* No more (sub)states all the way down to the end. */
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    * Names of the cstates are not included in the CPUID leaf 0x5, they ar=
e
>      taken from the product specific documentation.
>
> Notice that hints 0x20 and 0x21 are skipped entirely for the target
> cstate 0x20 (C6), being a cause of the problem for the current cpuid
> leaf 0x5 algorithm.
>
> Allow cpuidle code to provide mwait play dead loop with known, mwait
> hint for the deepest idle state on a given platform, skipping the cpuid
> based calculation.
>
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

I'm going to risk saying that the changelog doesn't match the code
changes in the patch any more.

The code changes are actually relatively straightforward: The bottom
half of mwait_play_dead() is split off, so it can be called from
multiple places.

The other places from which to call it are cpuidle drivers
implementing :enter_dead() callbacks that may want to use MWAIT as the
idle state entry method.  The ACPI processor_idle driver and
intel_idle will be updated by subsequent patches to do so.

The reason for it is mostly consistency: If the cpuidle driver uses a
specific idle state for things like suspend-to-idle, it is better to
let it decide what idle state to use for "play_dead" because it may
know better.

Another reason is what mwait_play_dead() does to determine the MWAIT
argument (referred to as a "hint"), but IMO it belongs in a changelog
of a later patch because this one doesn't actually do anything about
it.  In fact, it is not expected to change the behavior of the code.

> ---
>  arch/x86/include/asm/smp.h |  3 ++
>  arch/x86/kernel/smpboot.c  | 86 ++++++++++++++++++++------------------
>  2 files changed, 49 insertions(+), 40 deletions(-)
>
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index ca073f40698f..d12fab4a83c5 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
>  int wbinvd_on_all_cpus(void);
>
>  void smp_kick_mwait_play_dead(void);
> +void mwait_play_dead_with_hint(unsigned long hint);
>
>  void native_smp_send_reschedule(int cpu);
>  void native_send_call_func_ipi(const struct cpumask *mask);
> @@ -164,6 +165,8 @@ static inline struct cpumask *cpu_llc_shared_mask(int=
 cpu)
>  {
>         return (struct cpumask *)cpumask_of(0);
>  }
> +
> +static inline void mwait_play_dead_with_hint(unsigned long eax_hint) { }
>  #endif /* CONFIG_SMP */
>
>  #ifdef CONFIG_DEBUG_NMI_SELFTEST
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index b5a8f0891135..d0464c7a0af5 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1272,13 +1272,57 @@ void play_dead_common(void)
>         local_irq_disable();
>  }
>
> +void __noreturn mwait_play_dead_with_hint(unsigned long eax_hint)
> +{
> +       struct mwait_cpu_dead *md =3D this_cpu_ptr(&mwait_cpu_dead);
> +
> +       /* Set up state for the kexec() hack below */
> +       md->status =3D CPUDEAD_MWAIT_WAIT;
> +       md->control =3D CPUDEAD_MWAIT_WAIT;
> +
> +       wbinvd();
> +
> +       while (1) {
> +               /*
> +                * The CLFLUSH is a workaround for erratum AAI65 for
> +                * the Xeon 7400 series.  It's not clear it is actually
> +                * needed, but it should be harmless in either case.
> +                * The WBINVD is insufficient due to the spurious-wakeup
> +                * case where we return around the loop.
> +                */
> +               mb();
> +               clflush(md);
> +               mb();
> +               __monitor(md, 0, 0);
> +               mb();
> +               __mwait(eax_hint, 0);
> +
> +               if (READ_ONCE(md->control) =3D=3D CPUDEAD_MWAIT_KEXEC_HLT=
) {
> +                       /*
> +                        * Kexec is about to happen. Don't go back into m=
wait() as
> +                        * the kexec kernel might overwrite text and data=
 including
> +                        * page tables and stack. So mwait() would resume=
 when the
> +                        * monitor cache line is written to and then the =
CPU goes
> +                        * south due to overwritten text, page tables and=
 stack.
> +                        *
> +                        * Note: This does _NOT_ protect against a stray =
MCE, NMI,
> +                        * SMI. They will resume execution at the instruc=
tion
> +                        * following the HLT instruction and run into the=
 problem
> +                        * which this is trying to prevent.
> +                        */
> +                       WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
> +                       while(1)
> +                               native_halt();
> +               }
> +       }
> +}
> +
>  /*
>   * We need to flush the caches before going to sleep, lest we have
>   * dirty data in our caches when we come back up.
>   */
>  static inline void mwait_play_dead(void)
>  {
> -       struct mwait_cpu_dead *md =3D this_cpu_ptr(&mwait_cpu_dead);
>         unsigned int eax, ebx, ecx, edx;
>         unsigned int highest_cstate =3D 0;
>         unsigned int highest_subcstate =3D 0;
> @@ -1316,45 +1360,7 @@ static inline void mwait_play_dead(void)
>                         (highest_subcstate - 1);
>         }
>
> -       /* Set up state for the kexec() hack below */
> -       md->status =3D CPUDEAD_MWAIT_WAIT;
> -       md->control =3D CPUDEAD_MWAIT_WAIT;
> -
> -       wbinvd();
> -
> -       while (1) {
> -               /*
> -                * The CLFLUSH is a workaround for erratum AAI65 for
> -                * the Xeon 7400 series.  It's not clear it is actually
> -                * needed, but it should be harmless in either case.
> -                * The WBINVD is insufficient due to the spurious-wakeup
> -                * case where we return around the loop.
> -                */
> -               mb();
> -               clflush(md);
> -               mb();
> -               __monitor(md, 0, 0);
> -               mb();
> -               __mwait(eax, 0);
> -
> -               if (READ_ONCE(md->control) =3D=3D CPUDEAD_MWAIT_KEXEC_HLT=
) {
> -                       /*
> -                        * Kexec is about to happen. Don't go back into m=
wait() as
> -                        * the kexec kernel might overwrite text and data=
 including
> -                        * page tables and stack. So mwait() would resume=
 when the
> -                        * monitor cache line is written to and then the =
CPU goes
> -                        * south due to overwritten text, page tables and=
 stack.
> -                        *
> -                        * Note: This does _NOT_ protect against a stray =
MCE, NMI,
> -                        * SMI. They will resume execution at the instruc=
tion
> -                        * following the HLT instruction and run into the=
 problem
> -                        * which this is trying to prevent.
> -                        */
> -                       WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
> -                       while(1)
> -                               native_halt();
> -               }
> -       }
> +       mwait_play_dead_with_hint(eax);
>  }
>
>  /*
> --
> 2.47.0
>
>

