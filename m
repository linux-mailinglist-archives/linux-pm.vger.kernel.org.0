Return-Path: <linux-pm+bounces-30431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49210AFE145
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 09:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E90BC7A5C03
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 07:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B412226FA4B;
	Wed,  9 Jul 2025 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6FT649i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDAA26C38D;
	Wed,  9 Jul 2025 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046101; cv=none; b=aki9S39J2vN8Jl5jiG3z6UeE6sQLCKcM8WJyjgQCQ3eI8usUWW5tMICnzmBQ3z74H2s4Z1PVx5HPe/LAI+OuMDcojWzms7/uEkEF74YU2YZaoXDnSSfdemk1q1yKlZxU22SxRLqoB+tk6Z1SikyxYQOLULUL6MUEWbaEp4f4uYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046101; c=relaxed/simple;
	bh=d18pkVRGIBPPG4G9pX+IGPSZTDwYOv+ye5gJH+dBMLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuLZ9cNP+ExH7Ezr6dVQWAKqc1bx4lJUU4OAU3T4weWv07w575fCrLluD3GANFPXETnn8+J59vS1xwFVZerGSf4csLtCuSEdwIgwRqqZPUMLQhZO2BlorLkHys4S3zYJheiAUjSwqQ9dwtodfgtu4ukf1G8IaDLjwSFB78bPFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6FT649i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA80C4CEF5;
	Wed,  9 Jul 2025 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752046101;
	bh=d18pkVRGIBPPG4G9pX+IGPSZTDwYOv+ye5gJH+dBMLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o6FT649iWVpxfhufT3grYlFhD4tQs4y85Ani2qSqYWvyIkD+7Hu2aGf1OKhcMGwjt
	 4nBfIUY8iNBNot/k/I8axsaNl3ZNZzQP7gyv8A0ar3FI9a1zi9D9WoRg7RieGaIlcG
	 Khc0SyGoSMSzNFstyG+hvI3wOEf0GZeX9IZHaksbtBIZOpoxiFKOdEZh76RblL+6DV
	 iTnKFquYrweEKX4GDGwYXSXZ5ojFM6JSMYJGTR3zn32CefSzkIXuiR/h+UbeI1XhkM
	 WxIf3IZuUFHQXuwOIm1z0XsMnckLYDtHK4TxKsG1bfet0VKgQwO2dD6IPPHIkDXXXK
	 LotYEuka1f1xA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-613b02e8017so1639862eaf.2;
        Wed, 09 Jul 2025 00:28:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+hNcUpvacPX11J+ILcYpmgi9zfC6FPnBio1fBnq1Ih0mk96G7VY+Bpam8lxaF+VZVF+yQkbFxLew1ZXA=@vger.kernel.org, AJvYcCUDYfOezzJ3vDN7kf7NfOaC/Hhuw5jb/KzsAtR9gltCMtpgM3XhNsoZdlA7Xy8hOXPLzN8AfAMh48o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ILpnz2T3AzXWYbsrjLCjIdkmzEQ/NSJ+5+E6cyEaCsMpOGBi
	SyU8ZuKDInxPg75Km5acq80cdXtrVSNupU4Fn4CWUpP2/g1GWAY8X1t5seawxHeROhMmCndXFDB
	ox+WOTG4APmH2lDVUnJRFSbzYRHjaqaY=
X-Google-Smtp-Source: AGHT+IEVDujuiHSKbnG9L4mCMYodIqFWy1YBNRC1UP011pwNESpb1aHOQdevbto9bNZu+HnD6NOKMi2Qj8KFM65Eyeo=
X-Received: by 2002:a05:6820:4c85:b0:613:84b1:c4c1 with SMTP id
 006d021491bc7-613cce2fc08mr745363eaf.5.1752046100452; Wed, 09 Jul 2025
 00:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606231530.3032-1-joe.walter@codesensesolutions.com>
In-Reply-To: <20250606231530.3032-1-joe.walter@codesensesolutions.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 09:28:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h5cLB3X17dLx7-6X4XDkCW2gqRYa_NG-QeRGLv1k0MvA@mail.gmail.com>
X-Gm-Features: Ac12FXw-FgfRBsp4JpAARWPmMWfn5dRNJYMUZ7NYeyEWYE1j-0kV0tvflT_zsM4
Message-ID: <CAJZ5v0h5cLB3X17dLx7-6X4XDkCW2gqRYa_NG-QeRGLv1k0MvA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add DMI quirk for Dell Inspiron systems
To: joe.walter@codesensesolutions.com
Cc: srinivas.pandruvada@linux.intel.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 1:42=E2=80=AFAM Joe Walter
<joe.walter@codesensesolutions.com> wrote:
>
> Some Dell Inspiron systems experience frequency scaling issues with
> intel_pstate driver where the CPU gets locked at 900MHz after load.
>
> Add DMI quirk table to detect affected Dell Inspiron models and prevent
> intel_pstate from loading, allowing acpi-cpufreq to handle frequency
> scaling instead.
>
> Affected models:
> - Dell Inspiron 15 7000 Gaming
> - Dell Inspiron 7567
> - Dell Inspiron 7559
>
> Tested-by: Joe Walter <joe.walter@codesensesolutions.com>
> Signed-off-by: Joe Walter <joe.walter@codesensesolutions.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 65 ++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 1b1f62ccec92..3aeb04755afa 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -28,7 +28,6 @@
>  #include <linux/pm_qos.h>
>  #include <linux/bitfield.h>
>  #include <trace/events/power.h>
> -#include <linux/dmi.h>
>  #include <linux/units.h>
>
>  #include <asm/cpu.h>
> @@ -48,6 +47,7 @@
>  #ifdef CONFIG_ACPI
>  #include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
> +#include <linux/dmi.h>
>  #endif
>
>  #define FRAC_BITS 8
> @@ -299,25 +299,6 @@ struct pstate_funcs {
>
>  static struct pstate_funcs pstate_funcs __read_mostly;
>
> -/* DMI quirk table for systems that should prefer acpi-cpufreq over inte=
l_pstate */
> -static int intel_pstate_prefer_acpi_cpufreq(const struct dmi_system_id *=
id)
> -{
> -       pr_info("Preferring acpi-cpufreq for %s due to performance issues=
 with intel_pstate\n",
> -               id->ident);
> -       return 1;
> -}
> -
> -static const struct dmi_system_id intel_pstate_acpi_cpufreq_prefer[] =3D=
 {
> -       {
> -               .callback =3D intel_pstate_prefer_acpi_cpufreq,
> -               .ident =3D "Dell Inspiron 15 7000 Gaming",
> -               .matches =3D {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 15 7000 Gam=
ing"),
> -               },
> -       },
> -       { }
> -};

This isn't a patch against mainline intel_pstate because there are no
DMI checks in there.

