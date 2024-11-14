Return-Path: <linux-pm+bounces-17576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED279C913C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 18:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33ED9282FF9
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE0B18C90E;
	Thu, 14 Nov 2024 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8MP4ab9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B33C6BA;
	Thu, 14 Nov 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607148; cv=none; b=bqHTO/DuSxasR9j3+089L5ZJwRsWuFi6oWq7rw7NPuJMMQFzCYSwxTkwResUxVWC4BOL6IQEYtbakbdqFTsbS9weC7E6R7Xrpx0sHYkzQvGD4X9VjbVlhGMs1rCnESj2eIcOaEe0A9oy+ISxdHQZwx7iVrBn5rjK31qfRbyXZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607148; c=relaxed/simple;
	bh=0oKb01rcEFD4/hbS46TLPAshByQABaPJvdd/yfjogRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S07zAd8iy9S7PJ5WaFMiPyAgoELgOL90qM8ohhq0JRoc04a1jJBil9Bq7QaMyLg83FoYX0jHSShH+6W4qDPNKDBcxhwCl5Agn/Erv4UX/VFTNVh4NvsVCqkBGkPu42ELk5V6kbHZw/AXIS9BsX2UANX3SLHhAY2iopNIpoz6siQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8MP4ab9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697D1C4CECD;
	Thu, 14 Nov 2024 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731607147;
	bh=0oKb01rcEFD4/hbS46TLPAshByQABaPJvdd/yfjogRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E8MP4ab9kuQx1AAxOgPBdLwfsRM7wYKnVSEzHAcS8TqmdXhT7XgQRzH7TiTlPR+2N
	 m4Laqga9qlrde8+Ko4UyO22BVtzY1feKpnAolPMLgzqtq6XwiUufZXX1dfyI4FdA74
	 McSZmX+iqP6ebP9QVRj6gIzNgB1Vx7C1vm3nsQbsHZHnLFuw8c4ST2mzdoCPxgklSt
	 yTqB0HYeGBrgF0LIOFgASLBwzpPOaCjQ+Ar11rVyFZnt38ohLzfV/vSWN3GQNzzYgu
	 1vHH1iZi10tnDqT3Dw1U/GRbov5rxfCI51i4Ki/oHtzU+Xi4FCHjFURViQC0uNTWl3
	 A/UlS+0NrvP9g==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e601b6a33aso567403b6e.0;
        Thu, 14 Nov 2024 09:59:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0FavIcNdCWwS02mtRIpBX8Ao3SOCMLPdfwWfMteQULgWvRHWOMG7ZJ+Hn2uMNIpAXh2LeL4ZWp8UKAaE=@vger.kernel.org, AJvYcCXlXNU+sKmm390O+k+KjKPUtgcx1op4SqwL2BBIOE2a1ZUuyKiGfDDZCbhxXY5BrHPkOuOfVmooA0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jrO7Hrmp74BMJlYGpYJ7Hbw3YHCqB/Zdc9aydbso9uTejYj9
	8/0OJePkFqoxcMX6cUI3hI/m+rJlOWKrylDyuouidLQT3NR0CUu/8YKJjsUK+MzzgLALeMOKaKT
	m1PL91QtI527hMuGiDcCZZ/M6fKo=
X-Google-Smtp-Source: AGHT+IHPR2Hb6ID8Or1tkWezYOubK6pjWltaHsSnVfa/RqbaR6uKLi0bevMBM5raG97gyrdRNbwS4cnfnvlasjWIg8I=
X-Received: by 2002:a05:6808:14cc:b0:3e6:6145:d0eb with SMTP id
 5614622812f47-3e7b0acb5cfmr9477997b6e.30.1731607146662; Thu, 14 Nov 2024
 09:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com> <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net> <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
 <20241113162222.GA24625@noisy.programming.kicks-ass.net> <ZzY1JJequFwJr/of@BLRRASHENOY1.amd.com>
In-Reply-To: <ZzY1JJequFwJr/of@BLRRASHENOY1.amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Nov 2024 18:58:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j-U4ocmzVvgqEa-+8=aOjEFd8cU_j_9PXGNuRkr=qBzw@mail.gmail.com>
Message-ID: <CAJZ5v0j-U4ocmzVvgqEa-+8=aOjEFd8cU_j_9PXGNuRkr=qBzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 6:36=E2=80=AFPM Gautham R. Shenoy
<gautham.shenoy@amd.com> wrote:
>
> On Wed, Nov 13, 2024 at 05:22:22PM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 13, 2024 at 05:11:38PM +0530, Gautham R. Shenoy wrote:
> >
> > > How about something like this (completely untested)
> > >
> > > ---------------------x8----------------------------------------------=
------
> > >
> > > diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cst=
ate.c
> > > index f3ffd0a3a012..bd611771fa6c 100644
> > > --- a/arch/x86/kernel/acpi/cstate.c
> > > +++ b/arch/x86/kernel/acpi/cstate.c
> > > @@ -215,6 +215,24 @@ void __cpuidle acpi_processor_ffh_cstate_enter(s=
truct acpi_processor_cx *cx)
> > >  }
> > >  EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
> > >
> > > +static int acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx=
)
> > > +{
> > > +       unsigned int cpu =3D smp_processor_id();
> > > +       struct cstate_entry *percpu_entry;
> > > +
> > > +       /*
> > > +        * This is ugly. But AMD processors don't prefer MWAIT based
> > > +        * C-states when processors are offlined.
> > > +        */
> > > +       if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||
> > > +           boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON)
> > > +               return -ENODEV;
> >
> > Are there AMD systems with FFh idle states at all?
>
> Yes. On AMD systems, the ACPI C1 state is an FFh idle state. An
> example from my server box.
>
>
> $ cpupower idle-info  | grep "FFH" -B1 -A3
> C1:
> Flags/Description: ACPI FFH MWAIT 0x0
> Latency: 1
> Usage: 6591
> Duration: 1482606
>
> >
> > Also, I don't think this works right, the loop in cpuidle_play_dead()
> > will terminate on this, and not try a shallower state which might have
> > IO/HLT on.
>
> Ah yes. You are right. I didn't observe that cpuidle_play_dead() calls
> "return idle_state.enter_state". I suppose the solution would be to
> not populate .enter_dead callback for FFH based C-States on AMD/Hygon
> Platforms.

No, no, the solution is to change cpuidle_play_dead() to do the right thing=
.

Please see

https://lore.kernel.org/linux-pm/4992010.31r3eYUQgx@rjwysocki.net/

that I've just posted.

> How about something like the following? I have tested this on AMD
> servers by disabling the IO based C2 state, and I could observe that
> the offlined CPUs entered HLT bypassing the MWAIT based C1. When IO
> based C2 state is enabled, offlined CPUs enter the C2 state as before.
> If Global C-States are disabled, then, offlined CPUs enter HLT.
>
> This is on top of Patrick's series.
>
> I have defined X86_FEATURE_NO_MWAIT_OFFLINE as suggested by Dave to
> prevent MWAIT based C-states being used for CPU Offline on AMD and
> Hygon.
>
> ---------------------x8--------------------------------------------------=
--
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> Date: Thu, 14 Nov 2024 14:48:17 +0530
> Subject: [PATCH] acpi_idle: Teach acpi_idle_play_dead about FFH states
>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  arch/x86/kernel/acpi/cstate.c      | 14 ++++++++++++++
>  arch/x86/kernel/smpboot.c          |  6 +++---
>  drivers/acpi/processor_idle.c      | 24 ++++++++++++++++++++++--
>  include/acpi/processor.h           |  6 ++++++
>  5 files changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 05e985ce9880..ceb002406d0c 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -236,6 +236,7 @@
>  #define X86_FEATURE_PVUNLOCK           ( 8*32+20) /* PV unlock function =
*/
>  #define X86_FEATURE_VCPUPREEMPT                ( 8*32+21) /* PV vcpu_is_=
preempted function */
>  #define X86_FEATURE_TDX_GUEST          ( 8*32+22) /* "tdx_guest" Intel T=
rust Domain Extensions Guest */
> +#define X86_FEATURE_NO_MWAIT_OFFLINE    ( 8*32+23) /* Don't use MWAIT st=
ates for offlined CPUs*/
>
>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
>  #define X86_FEATURE_FSGSBASE           ( 9*32+ 0) /* "fsgsbase" RDFSBASE=
, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.=
c
> index f3ffd0a3a012..a5255a603745 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -215,6 +215,16 @@ void __cpuidle acpi_processor_ffh_cstate_enter(struc=
t acpi_processor_cx *cx)
>  }
>  EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
>
> +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> +{
> +       unsigned int cpu =3D smp_processor_id();
> +       struct cstate_entry *percpu_entry;
> +
> +       percpu_entry =3D per_cpu_ptr(cpu_cstate_entry, cpu);
> +       mwait_play_dead_with_hint(percpu_entry->states[cx->index].eax);
> +}
> +EXPORT_SYMBOL_GPL(acpi_processor_ffh_play_dead);

Why does it need to be exported to modules?

> +
>  static int __init ffh_cstate_init(void)
>  {
>         struct cpuinfo_x86 *c =3D &boot_cpu_data;
> @@ -224,6 +234,10 @@ static int __init ffh_cstate_init(void)
>             c->x86_vendor !=3D X86_VENDOR_HYGON)
>                 return -1;
>
> +       if (c->x86_vendor =3D=3D X86_VENDOR_AMD ||
> +           c->x86_vendor =3D=3D X86_VENDOR_HYGON)
> +               set_cpu_cap(c, X86_FEATURE_NO_MWAIT_OFFLINE);
> +
>         cpu_cstate_entry =3D alloc_percpu(struct cstate_entry);
>         return 0;
>  }
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 106f26e976b8..b5939bf96be6 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1285,9 +1285,9 @@ static inline int mwait_play_dead(void)
>         unsigned int highest_subcstate =3D 0;
>         int i;
>
> -       if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||
> -           boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON)
> -               return 1;
> +       if (boot_cpu_has(X86_FEATURE_NO_MWAIT_OFFLINE))
> +               return -ENODEV;
> +
>         if (!this_cpu_has(X86_FEATURE_MWAIT))
>                 return 1;
>         if (!this_cpu_has(X86_FEATURE_CLFLUSH))
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 831fa4a12159..1e2259b4395b 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -590,6 +590,8 @@ static int acpi_idle_play_dead(struct cpuidle_device =
*dev, int index)
>                         raw_safe_halt();
>                 else if (cx->entry_method =3D=3D ACPI_CSTATE_SYSTEMIO) {
>                         io_idle(cx->address);
> +               } else if (cx->entry_method =3D=3D ACPI_CSTATE_FFH) {
> +                       acpi_processor_ffh_play_dead(cx);
>                 } else
>                         return -ENODEV;
>         }
> @@ -772,6 +774,25 @@ static int acpi_processor_setup_cpuidle_cx(struct ac=
pi_processor *pr,
>         return 0;
>  }
>
> +static inline bool valid_acpi_idle_type(struct acpi_processor_cx *cx)
> +{
> +       if (cx->type =3D=3D ACPI_STATE_C1 ||
> +           cx->type =3D=3D ACPI_STATE_C2 ||
> +           cx->type =3D=3D ACPI_STATE_C3)
> +               return true;
> +
> +       return false;

This could do

    return cx->type =3D=3D ACPI_STATE_C1 || cx->type =3D=3D ACPI_STATE_C2 |=
|
cx->type =3D=3D ACPI_STATE_C3;

but it may just not be necessary.

Please see

https://lore.kernel.org/linux-pm/2373563.ElGaqSPkdT@rjwysocki.net/

> +}
> +
> +static inline bool acpi_idle_can_play_dead(struct acpi_processor_cx *cx)
> +{
> +       if (cx->entry_method =3D=3D ACPI_CSTATE_FFH &&
> +           boot_cpu_has(X86_FEATURE_NO_MWAIT_OFFLINE))
> +               return false;
> +
> +       return true;
> +}
> +
>  static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>  {
>         int i, count;
> @@ -803,8 +824,7 @@ static int acpi_processor_setup_cstates(struct acpi_p=
rocessor *pr)
>                 state->enter =3D acpi_idle_enter;
>
>                 state->flags =3D 0;
> -               if (cx->type =3D=3D ACPI_STATE_C1 || cx->type =3D=3D ACPI=
_STATE_C2 ||
> -                   cx->type =3D=3D ACPI_STATE_C3) {
> +               if (valid_acpi_idle_type(cx) && acpi_idle_can_play_dead(c=
x)) {
>                         state->enter_dead =3D acpi_idle_play_dead;

The check below is separate from the "enter_dead" check, so it should
not depend on acpi_idle_can_play_dead(cx).

>                         if (cx->type !=3D ACPI_STATE_C3)
>                                 drv->safe_state_index =3D count;
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index e6f6074eadbf..349fe47a579e 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -280,6 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>                                     struct acpi_processor_cx *cx,
>                                     struct acpi_power_register *reg);
>  void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
> +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cstate);
>  #else
>  static inline void acpi_processor_power_init_bm_check(struct
>                                                       acpi_processor_flag=
s
> @@ -300,6 +301,11 @@ static inline void acpi_processor_ffh_cstate_enter(s=
truct acpi_processor_cx
>  {
>         return;
>  }
> +
> +static inline void acpi_processor_ffh_play_dead(struct acpi_processor_cx=
 *cstate)
> +{
> +       return;
> +}
>  #endif
>
>  static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,
>
>
> --
> Thanks and Regards
> gautham.
>

