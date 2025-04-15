Return-Path: <linux-pm+bounces-25479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F91DA8A480
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 18:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC037A740D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF3D23D2A6;
	Tue, 15 Apr 2025 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSAQYNHv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2427C268C79;
	Tue, 15 Apr 2025 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735733; cv=none; b=O7PR9njQv4bozLGuqbb4t6Oz/NyJp9YKzKf7An+qinli0kaWrBq9hXmLTzL9WWvrZN9BP4BUDzysIopKTUQ4tZSJLtmLdp5kir5zWTIGsXuQOFpeZZAZvTvRZkIrhhldItOEiL93+YY2HxE/LLucj16mqN74jP9OLl6shQbdC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735733; c=relaxed/simple;
	bh=/9nhXGXJv852MhlHqoqJkQKSHzHQRAK0UJorlnT2/UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDvO+iwYW4GnggYp6mfG3RuOKciDCEYt0llhOconEyaqsqh7TeJUt7Dqt1iBIWRoNq2bujBJZHGStpXq2hI5saIeAhFufipqKotEtc2C3fn1wa0sVk3T/IPzL0YtgUM2f9XZrCKDF8TODgwyajZIp2tf2ayF5bCPpxFK7iBiJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSAQYNHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9125BC4CEE9;
	Tue, 15 Apr 2025 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744735732;
	bh=/9nhXGXJv852MhlHqoqJkQKSHzHQRAK0UJorlnT2/UQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RSAQYNHvP7Uv6HkmcX0hw3NFHt17BmFgYaRiBL9NhrkHrTBtPMG/vTfBYq91QQjp9
	 h0aUx6a4SeLKdqtTLmulQwQ5NBu37HostJhPEXsKb8G7hVVxHz0Z5Ln0j0taSxVMCA
	 E9gwbN1c4UnnK4TcZ2/QXTOTmc5CEfni4oE82z5mt39DWCc75esWErelLkDJMMnycn
	 xJr+8zCXTZPAavP4sJxuGhGnm8pDWuVsrffZZjbENcsoClZxaO93qywfhOj1s17zvc
	 XR8onmsKsmRKuVc0JY3XDGTA4MgTk8UomA/dMLMG38OdQxqXip9tc3ASxjbtIFZ8hp
	 6P7G442AQ121g==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72bb97260ceso1930027a34.1;
        Tue, 15 Apr 2025 09:48:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCn/0QaojzREIgXP6iIUzCDxyKdkk46CJ9PPEqphUMMCkXOopJafmyjPULo+6LU2wP6x8CPY3ErGI=@vger.kernel.org, AJvYcCWJfZLTHTsRhYTZ/m9p0ijaEy/bBGvYtmRNTFdw/DblE3vP64CJzpO8+gfHUki23p/HTlmtnMYPgG5Ni4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoYrJ31Pffs2eo+KQhlTzlLrxyZI9llShG/BEqOOz37roa61e
	cLYbmZKlUrDFP74bGneFrQfygxSywIWnPXGbXGGOSP+zfuSM0wGCuhYXtmZDtVDvhrhqRYXDwDM
	C+hxzQTvfQ8bx0uEE2e/ctMHZDyU=
X-Google-Smtp-Source: AGHT+IGk1BCAKcF9cN0xOrhNg7N8hoRLwkz1GOQB08ZZFetkBi4oYfuAshfIg6qnRd8gKUopNI1MeON0sds8BpxRYSk=
X-Received: by 2002:a05:6830:6615:b0:727:3f3e:53ba with SMTP id
 46e09a7af769-72e8653e630mr10438911a34.26.1744735731864; Tue, 15 Apr 2025
 09:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410172943.577913-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250410172943.577913-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 18:48:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_SNb+stFH4-Pv87Jrb-2J0F1MEzUKK0e44dFDWwRSJA@mail.gmail.com>
X-Gm-Features: ATxdqUFdVoOgICEg1hOf6ZnDcJ4bH3MCki9Vtfra9d4eR1qpHIg3lKelPoGzN1s
Message-ID: <CAJZ5v0i_SNb+stFH4-Pv87Jrb-2J0F1MEzUKK0e44dFDWwRSJA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Add missing DVFS support
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 7:29=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> DVFS (Dynamic Voltage Frequency Scaling) is still supported for DDR
> memories on Lunar Lake and Panther Lake.
>
> Add the missing flag PROC_THERMAL_FEATURE_DVFS.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 6.15-rc material, thanks!

> ---
>  .../intel/int340x_thermal/processor_thermal_device_pci.c   | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index a55aaa8cef42..2097aae39946 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -485,7 +485,7 @@ static const struct pci_device_id proc_thermal_pci_id=
s[] =3D {
>         { PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
>           PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_TH=
ERMAL_FEATURE_WT_REQ) },
>         { PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_MSI_S=
UPPORT |
> -         PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
> +         PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR | PROC_TH=
ERMAL_FEATURE_DVFS |
>           PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR=
) },
>         { PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL =
|
>           PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_TH=
ERMAL_FEATURE_DLVR |
> @@ -495,8 +495,9 @@ static const struct pci_device_id proc_thermal_pci_id=
s[] =3D {
>         { PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
>           PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_TH=
ERMAL_FEATURE_WT_REQ) },
>         { PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
> -         PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_MSI_SUPPORT |
> -         PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR=
) },
> +         PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
> +         PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT=
 |
> +         PROC_THERMAL_FEATURE_POWER_FLOOR) },
>         { },
>  };
>
> --
> 2.49.0
>

