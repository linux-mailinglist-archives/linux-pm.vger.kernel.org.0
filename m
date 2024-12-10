Return-Path: <linux-pm+bounces-18943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCC59EBA56
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 20:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D751888E4B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F071D90CD;
	Tue, 10 Dec 2024 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw6vOseD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC34153BF6;
	Tue, 10 Dec 2024 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860317; cv=none; b=bGGrJr8DqClIfPwp7C25azshXWcA00OtkGRy5F91LneiYA8S5VWJDJljNxxcnrRWiVB94yR89lB7XWMdbq8vtCgYR0bZ0d2vXCK7352B1rSqTL2dUiNLJ+n7InkFSUbCptaorw+rhSSnW/dD3WVa1U0kFm6yKpOC8yIDvqkHnac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860317; c=relaxed/simple;
	bh=uVNtA4UP4gYY1Fh3dyi6MlUBu6yIgXwwrtxJO7qjI4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8aPOdsKNU0GswnSiiGIH2StrE0g158uKUbuaxVVmCplLC6vFV9iEpFZuzGxzaaoskXClFhXdHdBAkGbWIJm0fOsBKHzcCTBZqumgbtmFcySQ5FJTJ1zHFiq83RJF0JS5hSDyZVRWV8CYbmYsssZSLBiMVw1jqy0bDsZ22ZQLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw6vOseD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B981AC4CEE2;
	Tue, 10 Dec 2024 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733860316;
	bh=uVNtA4UP4gYY1Fh3dyi6MlUBu6yIgXwwrtxJO7qjI4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gw6vOseDnS37P97gPVAjqc6HRdGsQbM11TCHXvR2E2anV7EixzqCnD7+/48Z3uxq2
	 J6EbTk5m7iiO+pFcx60dBhMyhWdNZpc3BS93bhIQX0cVJbSDHRm1AiBTTnbzY9zM7c
	 YOolB49NEol5yFL/iUlxewPaU0imzt9oCBQb9qT+sKkow19WgGASJfXkhKYyG4MIyS
	 GNMp02ZFItp7ui1GM1US0aBfAhH5HAOjF0/22Fq3aQyIctOtvlhSG1AJckvZ1XvnGi
	 32AanCCnsVnoMiSU3VTXJnOLmbfsKYZnOXzanKP1fUa91KMdD5/uZw/ez9WcgRK2SD
	 Q8DhsUTQ8ZiUw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29e65257182so2949846fac.2;
        Tue, 10 Dec 2024 11:51:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgu7gKTgEcHURRfrS945fGikXgjNzLn0O7puV/4QAhI/v7GmABJQYig59KHFsJCL47mSC8NsUMo/g=@vger.kernel.org, AJvYcCV4jzEen/MS0fMrvI6qU+utBiFnlchFR37yhn6z/m3lk1k7FLeWD8QIy5TzvOVD8i/tj5khxiMajVR/3RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHyArzP4vtEJssx0ZlNe82qD7y1QWGqY//Dtcv0zStEQcSW9Kq
	NZmSyrOSYz4SDbv7s+K6XH/KKQMPKvfZXos/VMROz91taMwc4byH9//8C3G+0pyuY1HtsLkmPn2
	wcVqdcWdDi1I0U12IlYLEV+zgg7Y=
X-Google-Smtp-Source: AGHT+IGze+/0YQKfiA5MqyQLVSRFptaYBpPZOn3z2i8CbXO2eUmQACXiqL02u2AFaRGvh67C/NC+/bmlbcaeaWei+6k=
X-Received: by 2002:a05:6870:1588:b0:287:471:41eb with SMTP id
 586e51a60fabf-2a012bb4c4cmr265506fac.6.1733860315572; Tue, 10 Dec 2024
 11:51:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com> <20241129182232.14987-2-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241129182232.14987-2-patryk.wlazlyn@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 20:51:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jhK51+pkf=Amr=qXWzK3e1xC_tdt0iqQXxVfeE4pcFJQ@mail.gmail.com>
Message-ID: <CAJZ5v0jhK51+pkf=Amr=qXWzK3e1xC_tdt0iqQXxVfeE4pcFJQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] x86/smp: Allow calling mwait_play_dead with an
 arbitrary hint
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, peterz@infradead.org, dave.hansen@linux.intel.com, 
	gautham.shenoy@amd.com, tglx@linutronix.de, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First, I would change the subject to something like "x86/smp: Add hint
parameter to mwait_play_dead()"

On Fri, Nov 29, 2024 at 7:22=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> Introduce a helper function to allow offlined CPUs to enter FFh idle
> states with a specific MWAIT hint. The new helper will be used in
> subsequent patches by the acpi_idle and intel_idle drivers.

And the above would become

"Change mwait_play_dead() into a helper function allowing CPUs going
offline to enter idle states via MWAIT with a specific hint passed to
it as an argument.

Add mwait_play_dead_cpuid_hint() as a wrapper around mwait_play_dead()
implementing the existing behavior of the code.

Subsequently, the new helper will also be used by the acpi_idle and
intel_idle drivers in idle-state-specific :enter_dead() callbacks."

> No functional change intended.
>
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> ---
>  arch/x86/include/asm/smp.h |  3 ++
>  arch/x86/kernel/smpboot.c  | 90 ++++++++++++++++++++------------------
>  2 files changed, 51 insertions(+), 42 deletions(-)
>
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index ca073f40698f..dfd09a1e09bf 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
>  int wbinvd_on_all_cpus(void);
>
>  void smp_kick_mwait_play_dead(void);
> +void mwait_play_dead(unsigned int hint);
>
>  void native_smp_send_reschedule(int cpu);
>  void native_send_call_func_ipi(const struct cpumask *mask);
> @@ -164,6 +165,8 @@ static inline struct cpumask *cpu_llc_shared_mask(int=
 cpu)
>  {
>         return (struct cpumask *)cpumask_of(0);
>  }
> +
> +static inline void mwait_play_dead(unsigned int eax_hint) { }
>  #endif /* CONFIG_SMP */
>
>  #ifdef CONFIG_DEBUG_NMI_SELFTEST
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index b5a8f0891135..8a3545c2cae9 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1272,13 +1272,57 @@ void play_dead_common(void)
>         local_irq_disable();
>  }
>
> +void __noreturn mwait_play_dead(unsigned int eax_hint)
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
> -static inline void mwait_play_dead(void)
> +static inline void mwait_play_dead_cpuid_hint(void)
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
> +       mwait_play_dead(eax);
>  }
>
>  /*
> @@ -1407,7 +1413,7 @@ void native_play_dead(void)
>         play_dead_common();
>         tboot_shutdown(TB_SHUTDOWN_WFS);
>
> -       mwait_play_dead();
> +       mwait_play_dead_cpuid_hint();
>         if (cpuidle_play_dead())
>                 hlt_play_dead();
>  }
> --

And honestly I'm wondering why adding a parameter to mwait_play_dead()
is better than introducing mwait_play_dead_with_hint(), in analogy
with the existing mwait_idle_with_hints()?

The latter option would allow you to avoid introducing a function that
is deleted in the same patch series (in patch 4).

