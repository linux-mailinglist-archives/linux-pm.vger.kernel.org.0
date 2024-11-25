Return-Path: <linux-pm+bounces-18061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CFF9D86AB
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59998287C1B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9101AB50C;
	Mon, 25 Nov 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVMS1BIM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333918872F;
	Mon, 25 Nov 2024 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542111; cv=none; b=oC1LyFPhrBiY+3tAN+qcRKmkE8YoQNBckq5NujZqSUnITtoeYJ0GFKO3DJLlqo5zo3XhlFcr3k96mezPKorzR+M1+1RzZBkasa3Dxxw5ECJQMc2gHGJTgbl9ti4Z1YXEgNfVLMBE8YQESgiAVu2XdfmxKrWWj/E50YMDsOW6AzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542111; c=relaxed/simple;
	bh=L/Yt9qpyUYCvb0IMywip9wrijTFltgadVAr7iXLpz/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rg/oyWCbVD4dkO1H0E8tAwH76bdajDq5cFKDbi7eVv3CIBr21eN5GJhb7JQIwU8voe1xebAbKEJDD3/bJKMARa5IlMo0chfsz96HUW+dfggHwAnGplpV3kiZB11PIWG+0YnV0jj1iD0NHDf4HykBE0d0UDScWMoOj6KZDzZU9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVMS1BIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C200AC4CED3;
	Mon, 25 Nov 2024 13:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732542110;
	bh=L/Yt9qpyUYCvb0IMywip9wrijTFltgadVAr7iXLpz/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hVMS1BIMq1tzki/VreQrWMspZcravSEN7ZlTougVdWUREEQ0H2LEm1/1IuyJcqrxz
	 /ss5WkKGrF1NAwioOBXtKGCXA86jh56HsFnqcxVVqfULDp/HllGR0W7MG1KMuPsQbs
	 rDJ1WCq206b7jmSMNpb+C7aLqn4Ujlo0DUSRAFx4uejq7g647wMAMapLL0mBOSb0qK
	 LDLcdaUAKBp9Q41Q6SbhokjWBM7oBChKv/C+1gxYnPJV/3gO2x/BdAhAqKrEuakiYI
	 MMVNktemmmCwU+yesMJ2nvBmfRS+5mliPX6/7f/LL7b+GhwJyzckx6ZXQtvHwCP9nC
	 AUMOxm5XfVTrw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2973b53ec02so1249228fac.1;
        Mon, 25 Nov 2024 05:41:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrzj+PPcM4JLIMny+0Q4vjCEEzoymMF/Hpx5eIy8CyHxEdykOOwgVLJnmcXO8FqMQEupe+498O9yRyzN4=@vger.kernel.org, AJvYcCXKJWDIPLh5uivgNLcLIS+9OjZEmH5MGWxLiFEC2+VvjhehiLyEkyiQ+OyafhW8BcEd40vQSM6Vzzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5J276enSfapxsVkL5B51C0Pc1g8k3qpyRArHYWBpghluGQrf
	2ZO+n5KNNUbrBMHdB6juAtuFqrmwmCAchjx2NxD2mNqjMe1PxIvLF7CAqKS0MImwFCKcMuPBFss
	stvz/Jw9tVk85e5LMVRztVhwmy8E=
X-Google-Smtp-Source: AGHT+IHD/e87Ap2edrph4Qxa0s2hD0ZHiCrBZo3g13AEtLNFggvIu8CBqrF8fCVVpcN5wVQ+J6cHC1nhdMf+2r6cUvQ=
X-Received: by 2002:a05:6871:3a0d:b0:296:56d5:26c with SMTP id
 586e51a60fabf-29720c41d0dmr9104059fac.24.1732542109999; Mon, 25 Nov 2024
 05:41:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com> <20241125132029.7241-8-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241125132029.7241-8-patryk.wlazlyn@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 14:41:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gCHzptE5kW6ScpRB-ytvi_5uCS9Mghy6Vv4680VMEbTQ@mail.gmail.com>
Message-ID: <CAJZ5v0gCHzptE5kW6ScpRB-ytvi_5uCS9Mghy6Vv4680VMEbTQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 7/8] acpi_idle: Add FFH cstate handling
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
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

The changes below look good to me, but the patch needs a changelog
which should explain why it is needed or useful.

In this particular case, you want to change the code ordering in
native_play_dead() so that it calls cpuidle_play_dead() first and only
fall back to anything else if that fails.

In particular, this needs to work when intel_idle is not in use and
the entry method for at least one idle state in the _CST return
package for at least one CPU is ACPI_CSTATE_FFH, so this case needs to
be added to acpi_idle_play_dead().

You may also make a note in the changelog that had there been a
non-Intel x86 platform with a _CST returning idle states where CPU is
ACPI_CSTATE_FFH had been the entry method, it wouldn't have been
handled correctly today (but this is academic because of the lack of
such platforms).

Also, this can be the first patch in your series if [1-3/7] are dropped.

> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/acpi/cstate.c      | 9 +++++++++
>  drivers/acpi/processor_idle.c      | 2 ++
>  include/acpi/processor.h           | 5 +++++
>  4 files changed, 17 insertions(+)
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index ea33439a5d00..1da5e08de257 100644
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
ates for offlined CPUs */
>
>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
>  #define X86_FEATURE_FSGSBASE           ( 9*32+ 0) /* "fsgsbase" RDFSBASE=
, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.=
c
> index f3ffd0a3a012..c80a3e6dba5f 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -204,6 +204,15 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu=
,
>  }
>  EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
>
> +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> +{
> +       unsigned int cpu =3D smp_processor_id();
> +       struct cstate_entry *percpu_entry;
> +
> +       percpu_entry =3D per_cpu_ptr(cpu_cstate_entry, cpu);
> +       mwait_play_dead_with_hint(percpu_entry->states[cx->index].eax);
> +}
> +
>  void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx =
*cx)
>  {
>         unsigned int cpu =3D smp_processor_id();
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 698897b29de2..586cc7d1d8aa 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -590,6 +590,8 @@ static void acpi_idle_play_dead(struct cpuidle_device=
 *dev, int index)
>                         raw_safe_halt();
>                 else if (cx->entry_method =3D=3D ACPI_CSTATE_SYSTEMIO) {
>                         io_idle(cx->address);
> +               } else if (cx->entry_method =3D=3D ACPI_CSTATE_FFH) {
> +                       acpi_processor_ffh_play_dead(cx);
>                 } else
>                         return;
>         }
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index a17e97e634a6..63a37e72b721 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -280,6 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>                                     struct acpi_processor_cx *cx,
>                                     struct acpi_power_register *reg);
>  void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
> +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
>  #else
>  static inline void acpi_processor_power_init_bm_check(struct
>                                                       acpi_processor_flag=
s
> @@ -300,6 +301,10 @@ static inline void acpi_processor_ffh_cstate_enter(s=
truct acpi_processor_cx
>  {
>         return;
>  }
> +static inline void acpi_processor_ffh_play_dead(struct acpi_processor_cx=
 *cx)
> +{
> +       return;
> +}
>  #endif
>
>  static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,
> --
> 2.47.0
>
>

