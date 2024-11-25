Return-Path: <linux-pm+bounces-18069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1DA9D8959
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F73B28410
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D771714AC;
	Mon, 25 Nov 2024 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwbp7L21"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D21376E0;
	Mon, 25 Nov 2024 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543264; cv=none; b=s5Opll1DEvWkYVTDBNlEoZHyIlarkrgsY64G3whX4SWSOtviM+duSjMR9wyc7H1Ju4tN2XKn3roGnQ/vMt6cPxyLT4eHAhqhxDvrKEPCPqQTVVlkJiKavbupR0UT2pxByhDOCRROfhpfIp7OJOU75CNm9fhNqPJIJF44PMEzN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543264; c=relaxed/simple;
	bh=aNwvFziG+OEXvjc0LvFXKapmtPJlGg2QFLp0RvY+CWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuHBw5gpvohyseKHTrxA42M78ck2/Ol60RYKgyxCP/xR26trnKY+Ocl/2kbhRFpTITA+RZ1+AA9g4PJSbEryWn6ErPXKsnfx/9qAbjhTafgNmP3Pp4J8Zc7Vael4jzqGjFwK2dH5hPnlpRaEl2XEYTmACBKPEzIBL6gOA8NEUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwbp7L21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E7EC4CED9;
	Mon, 25 Nov 2024 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543263;
	bh=aNwvFziG+OEXvjc0LvFXKapmtPJlGg2QFLp0RvY+CWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jwbp7L21e5lntyiJA1ZTHxZXqzqi3QekKY2xR4KBWAXtQFdm2mdGb25gsPj+uIyEB
	 MI9oHrW+gY6mVlM8yIbSNA8FKxPCWA92SEuotXek7XfBkN0o08LAaaONQpKpYRh5AF
	 mv+VC06uiOT47sfMBxvUGWBrNgGy1WNcPqjOr+qR8vTX/1nNJrridf2EPPOXu9ClXt
	 GALjQGNb3PWSsP4FrfplofMEPmmCsmOBnvCEdgBdJfq+Ei/OZmKbcHzHRd8h17x0DZ
	 nySOxFi/ZS0riSj86CdqcMebPJ8xx/S15+PAOnAnZDDuoqYwh0Hl3PYCCU/SNeM84K
	 kq7GdhFpYFF6w==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2964645d2b7so2660439fac.2;
        Mon, 25 Nov 2024 06:01:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDKcA57tEMO46vu204X/UoiWSGJyhCTh0RIk3Iey5wK81f1FB+dXIeK+QBn0pYtGfg1Eos0iXZG68=@vger.kernel.org, AJvYcCVktV3aCxWSchCktRrsppKxwJ4qPFJMUO6BTbN7XwKG4wsQChPhsaIeIH9wWcECnahpfM8AU5aCnhDL/fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeXB+QqMTKjh7XapDXn002YvA1CfGpO+22HHlUxGM6RGtEFhOK
	1nSalFxRsW1035SeoCV7NpGJPkIVZWiB7PHanlPLPFxb15w3QYhiErjBqrsjLlF0kKcY5UeRTVL
	YsEgxXhoUw61bYpHPdFMAPiJRDW8=
X-Google-Smtp-Source: AGHT+IEC0itJZ0kxw5zhXv/UjTyunaQmX25Rsgu9bK3/zTrVbO6wIKPP/UZKqCKVuYtF1uyzZ4+ilkW3XF5WbSXMWtA=
X-Received: by 2002:a05:6870:9618:b0:296:827c:9067 with SMTP id
 586e51a60fabf-29720dfa05amr11875762fac.27.1732543262688; Mon, 25 Nov 2024
 06:01:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-8-patryk.wlazlyn@linux.intel.com> <CAJZ5v0gCHzptE5kW6ScpRB-ytvi_5uCS9Mghy6Vv4680VMEbTQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gCHzptE5kW6ScpRB-ytvi_5uCS9Mghy6Vv4680VMEbTQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 15:00:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gtUp9MK=0-g2kqAKccJDV_P01PwmuhPEJwv82EzvVECA@mail.gmail.com>
Message-ID: <CAJZ5v0gtUp9MK=0-g2kqAKccJDV_P01PwmuhPEJwv82EzvVECA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 7/8] acpi_idle: Add FFH cstate handling
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:41=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Nov 25, 2024 at 2:21=E2=80=AFPM Patryk Wlazlyn
> <patryk.wlazlyn@linux.intel.com> wrote:
> >
> > Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
>
> The changes below look good to me, but the patch needs a changelog
> which should explain why it is needed or useful.
>
> In this particular case, you want to change the code ordering in
> native_play_dead() so that it calls cpuidle_play_dead() first and only
> fall back to anything else if that fails.
>
> In particular, this needs to work when intel_idle is not in use and
> the entry method for at least one idle state in the _CST return
> package for at least one CPU is ACPI_CSTATE_FFH, so this case needs to
> be added to acpi_idle_play_dead().
>
> You may also make a note in the changelog that had there been a
> non-Intel x86 platform with a _CST returning idle states where CPU is
> ACPI_CSTATE_FFH had been the entry method, it wouldn't have been
> handled correctly today (but this is academic because of the lack of
> such platforms).
>
> Also, this can be the first patch in your series if [1-3/7] are dropped.

Ah sorry, not quite.

You need to introduce mwait_play_dead_with_hint() first of course, so
it could be the second patch in your series and the intel_idle one
would be the third.

> > ---
> >  arch/x86/include/asm/cpufeatures.h | 1 +
> >  arch/x86/kernel/acpi/cstate.c      | 9 +++++++++
> >  drivers/acpi/processor_idle.c      | 2 ++
> >  include/acpi/processor.h           | 5 +++++
> >  4 files changed, 17 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/=
cpufeatures.h
> > index ea33439a5d00..1da5e08de257 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -236,6 +236,7 @@
> >  #define X86_FEATURE_PVUNLOCK           ( 8*32+20) /* PV unlock functio=
n */
> >  #define X86_FEATURE_VCPUPREEMPT                ( 8*32+21) /* PV vcpu_i=
s_preempted function */
> >  #define X86_FEATURE_TDX_GUEST          ( 8*32+22) /* "tdx_guest" Intel=
 Trust Domain Extensions Guest */
> > +#define X86_FEATURE_NO_MWAIT_OFFLINE    ( 8*32+23) /* Don't use MWAIT =
states for offlined CPUs */
> >
> >  /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 =
*/
> >  #define X86_FEATURE_FSGSBASE           ( 9*32+ 0) /* "fsgsbase" RDFSBA=
SE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
> > diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstat=
e.c
> > index f3ffd0a3a012..c80a3e6dba5f 100644
> > --- a/arch/x86/kernel/acpi/cstate.c
> > +++ b/arch/x86/kernel/acpi/cstate.c
> > @@ -204,6 +204,15 @@ int acpi_processor_ffh_cstate_probe(unsigned int c=
pu,
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
> >
> > +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> > +{
> > +       unsigned int cpu =3D smp_processor_id();
> > +       struct cstate_entry *percpu_entry;
> > +
> > +       percpu_entry =3D per_cpu_ptr(cpu_cstate_entry, cpu);
> > +       mwait_play_dead_with_hint(percpu_entry->states[cx->index].eax);
> > +}
> > +
> >  void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_c=
x *cx)
> >  {
> >         unsigned int cpu =3D smp_processor_id();
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idl=
e.c
> > index 698897b29de2..586cc7d1d8aa 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -590,6 +590,8 @@ static void acpi_idle_play_dead(struct cpuidle_devi=
ce *dev, int index)
> >                         raw_safe_halt();
> >                 else if (cx->entry_method =3D=3D ACPI_CSTATE_SYSTEMIO) =
{
> >                         io_idle(cx->address);
> > +               } else if (cx->entry_method =3D=3D ACPI_CSTATE_FFH) {
> > +                       acpi_processor_ffh_play_dead(cx);
> >                 } else
> >                         return;
> >         }
> > diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> > index a17e97e634a6..63a37e72b721 100644
> > --- a/include/acpi/processor.h
> > +++ b/include/acpi/processor.h
> > @@ -280,6 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cp=
u,
> >                                     struct acpi_processor_cx *cx,
> >                                     struct acpi_power_register *reg);
> >  void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate)=
;
> > +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
> >  #else
> >  static inline void acpi_processor_power_init_bm_check(struct
> >                                                       acpi_processor_fl=
ags
> > @@ -300,6 +301,10 @@ static inline void acpi_processor_ffh_cstate_enter=
(struct acpi_processor_cx
> >  {
> >         return;
> >  }
> > +static inline void acpi_processor_ffh_play_dead(struct acpi_processor_=
cx *cx)
> > +{
> > +       return;
> > +}
> >  #endif
> >
> >  static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,
> > --
> > 2.47.0
> >
> >

