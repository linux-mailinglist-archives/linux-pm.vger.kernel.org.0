Return-Path: <linux-pm+bounces-17210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F209C1F5A
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 15:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288951C22BBA
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920031F131F;
	Fri,  8 Nov 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK4G7ioP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634CA1EBA00;
	Fri,  8 Nov 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076503; cv=none; b=DlgGk3zqJSrYQ94Y8NMC3mbTD+S3PWf4C4XaRud0Hiu9/iXh23+1hItqEs4SEelBGCUiv19p1REjQzGuDYxLVrf74uj0pdZuB8PE8cx/WVdsOVhDzRwW8aaSRDzWhfBulP6qQfOWsyfZaAGJyw+s1nfl2ZKW4XJKlRW88CtQR4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076503; c=relaxed/simple;
	bh=pUEhCn+4P7Xg02QPD1FD2qtHE5A3e7Wh3P7mZhnsn5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/RqsKlRp1L8rW+cI2SxHLmkFpj45r+OI6Tf5+zWZALQTfrWkN52vbYmObAV3FPg42LoFJogQPtZ4uNkWOv9z2/M9BiqQe6IEY34n0p6k9l8oOBYYrssOo3ANQxYBJfswPS/0pRePccX5RcEg/REr/0G4bu1U2lcNpFl5xy9D2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK4G7ioP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB087C4CECF;
	Fri,  8 Nov 2024 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731076503;
	bh=pUEhCn+4P7Xg02QPD1FD2qtHE5A3e7Wh3P7mZhnsn5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GK4G7ioPCVir+o84R7aPK4eUHbINSaDtd9PAvoN3RTPPDsQlSXY5gwSzLXN4RzvBX
	 i1DipKivNx9hbHEENtiyh0ZxKIXhGWTyua4Ki3yJz/SIQHW2+Q0+MXW0gqjjvF/Qpf
	 hiuzTc+D+LlkNAeTzESQ+OA2CE4Ok3uPtaS8pRMiK0NUKc3XFsz6YJoBUHbvtbw8ZD
	 OyD+w2aLVUl1IRrQRXWBLRs5v/Eoj/FC2LG8eKtR5wbofn4lUU/w+DGvbsP3DI6Faa
	 dP2uP5fKOTsmmVbL3yZB3fXuNesqpv2iqSHZTw22sqcx/V2Jb1gXdQZjX+DamYYY0c
	 SdbXNACq+vskg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-28896d9d9deso1127562fac.2;
        Fri, 08 Nov 2024 06:35:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMiRR01hu5SjpauRPkvO5ULfquGBGcytXvTZuvXXidT/i5XAhjo9qBm+NTO+AUEdE+4mEHxQYn@vger.kernel.org, AJvYcCWNtMUACJp0FHaowTy3KS/VvgLqLrLpuzq8xYQHRpUWWxOn1HfNMdtW98eam7eeHyOF2WsHss6LgzxT1x8=@vger.kernel.org, AJvYcCXKS487FG7h8xl7rKkfEJMesKC16niEolVtUrMS+CDeqxxBQV4h+gOXHYffuw6t7US6KlEPiGZpjrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCG+Ea9j/AmTFyigfPS885qzWqAltj7zybHZgq17ejUVfMjvNd
	RbigArypiiTld8IaKpMyJfm89V7tULLJyf5feU1dDuVoHctHQdrKFY0yPCADTq5O9W2WPXoBq8F
	DM67QdLKtwDON6UClWcoNHvvg+Ic=
X-Google-Smtp-Source: AGHT+IHfFfKeeVdnnVUY5JIR0kOdoMx12kU5yui8JN93qq2UcB8njWMZVUdNWOx0Stjg7aytAbQ9HUMJXuI1YPofVz4=
X-Received: by 2002:a05:6870:e38c:b0:277:f5d8:b77b with SMTP id
 586e51a60fabf-295602a56e3mr3402140fac.32.1731076502221; Fri, 08 Nov 2024
 06:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108135206.435793-1-lenb@kernel.org> <20241108135206.435793-3-lenb@kernel.org>
In-Reply-To: <20241108135206.435793-3-lenb@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 Nov 2024 15:34:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ixYR-tsSfcotc=ezwpcX3a79bC_hDQPFLGF1zjk4yLOg@mail.gmail.com>
Message-ID: <CAJZ5v0ixYR-tsSfcotc=ezwpcX3a79bC_hDQPFLGF1zjk4yLOg@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
To: Len Brown <lenb@kernel.org>
Cc: peterz@infradead.org, x86@kernel.org, rafael@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 2:52=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> From: Len Brown <len.brown@intel.com>
>
> Under some conditions, MONITOR wakeups on Lunar Lake processors
> can be lost, resulting in significant user-visible delays.
>
> Add LunarLake to X86_BUG_MONITOR so that wake_up_idle_cpu()
> always sends an IPI, avoiding this potential delay.
>
> Also update the X86_BUG_MONITOR workaround to handle
> the new smp_kick_mwait_play_dead() path.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219364
>
> Cc: stable@vger.kernel.org # 6.11
> Signed-off-by: Len Brown <len.brown@intel.com>

Overall

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/cpu/intel.c | 3 ++-
>  arch/x86/kernel/smpboot.c   | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index e7656cbef68d..aa63f5f780a0 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -586,7 +586,8 @@ static void init_intel(struct cpuinfo_x86 *c)
>              c->x86_vfm =3D=3D INTEL_WESTMERE_EX))
>                 set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
>
> -       if (boot_cpu_has(X86_FEATURE_MWAIT) && c->x86_vfm =3D=3D INTEL_AT=
OM_GOLDMONT)
> +       if (boot_cpu_has(X86_FEATURE_MWAIT) &&
> +                       (c->x86_vfm =3D=3D INTEL_ATOM_GOLDMONT || c->x86_=
vfm =3D=3D INTEL_LUNARLAKE_M))
>                 set_cpu_bug(c, X86_BUG_MONITOR);
>
>  #ifdef CONFIG_X86_64
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 766f092dab80..910cb2d72c13 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1377,6 +1377,9 @@ void smp_kick_mwait_play_dead(void)
>                 for (i =3D 0; READ_ONCE(md->status) !=3D newstate && i < =
1000; i++) {
>                         /* Bring it out of mwait */
>                         WRITE_ONCE(md->control, newstate);
> +                       /* If MONITOR unreliable, send IPI */
> +                       if (boot_cpu_has_bug(X86_BUG_MONITOR))
> +                               __apic_send_IPI(cpu, RESCHEDULE_VECTOR);

The  __apic_send_IPI() call could be wrapped into something like
__native_smp_send_reschedule() to underline the analogy between this
and what happens in native_smp_send_reschedule().

It is still fine as is though IMV.

>                         udelay(5);
>                 }
>
> --

