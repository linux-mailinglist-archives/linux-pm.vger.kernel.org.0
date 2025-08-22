Return-Path: <linux-pm+bounces-32907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7D5B31843
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 14:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399DE7B9710
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC5E2FDC5D;
	Fri, 22 Aug 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxN0SL1L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A412FD1AB;
	Fri, 22 Aug 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866886; cv=none; b=f1vQ4fe0o3/+LkaM9hK5cXJ5OhnVQSXPXEx3lA4RZGcIPCYyBtqGcVXtMubh/soOplnXjYV4gDMHl8jTeplkxluyrAEk3b+/Lm56mXl5v6slPX1d6BEs+1vrm25S9O98UjIMOtCx5IdXTTP1/xQcbc3O5rc3T/dYpXiwkyS8XmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866886; c=relaxed/simple;
	bh=hc4ri7kU2CKv+ZcImuYeQVDWRbAN+Ih9j69bi7IN0jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If8gCw5lzRzWJEGAR1/Xfj+ykr0ake1vwQzOvMfxuU8LMU+If47yjqR6RNrKN3bkiajyUyINe4xbRORgTp4bKVZxlUTNZFgGFAf0alv92bpxmGfre28a8Y5yG80KL8KsmosQWcBMlq9QLzD8I/61f+31D+HVrLaUIG3A8nrKwr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxN0SL1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB2FC4CEED;
	Fri, 22 Aug 2025 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755866885;
	bh=hc4ri7kU2CKv+ZcImuYeQVDWRbAN+Ih9j69bi7IN0jM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XxN0SL1LdevWLyBtwKCyTufAECl6GAVvRz6b9o5c6u2G9NhZN/vSaVJbpXL+G9Hvg
	 Xw8KO2iPUpFROcPwntFVy/zqDMkKiYV0HF/WtCZ9fLjusK+hhciXHf16x/7yamaD6L
	 fSJWzm0MFfuzvoKSzSw4MJ75ce6AkBKjjafDlv9e2zg7FSBsW3VK2OXRsy3+9kGwkq
	 GbdwQmzUjc/NbvLXnbwuUvTADAH3+nJF8wM58MT8mjX0wdIRv1Pz/Ea1mX70RDcnDM
	 Nxg5D8NtPPS2ysc1ZnwbuDw4Y+3QpMczLyTY6dOSj9Uo+1tRSmHG76ZIaqwJrV8Veb
	 FY4suZnIvTGQA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61da7b78978so962576eaf.1;
        Fri, 22 Aug 2025 05:48:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOiLZaAkSY+tDHF2vNVi0LC2n93Ibhwe4zwrJgVTX+7UjJWksZNTJmOEsSGJVQDORRatqzP/Bxp2Y=@vger.kernel.org, AJvYcCWLNNZPOffuqVaPYcgaKpOgvITHxTqXpPy0Zb/PQPCYpSv6zOp9TM3yq5pmHjUNeU3OgP+lmDRaXsxorWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKzPPY1ocNzRhHui9f2rAqFiT81vxHt6OjlvBx826EN7xAupjC
	iWoCna68jYGokBgEAS8z9h8Ke3o4lNOTyFztznu3O+m9UQgTjIJAVZ7Y5FyGdq0rbhX4b9uDvdY
	JtqZhzKVZ90A9S0wgty1kpB70kxlaQvE=
X-Google-Smtp-Source: AGHT+IHFAj1KUNWPkJHQ+ZMh0kc3OERpn8uuyqjDuVuhP3z7sDrMFZ8O6t8fQl82C0yk4lAdmswjLXNdixX6oskB14M=
X-Received: by 2002:a05:6820:16aa:b0:61b:7e35:bb41 with SMTP id
 006d021491bc7-61db9be3d64mr1226617eaf.6.1755866885041; Fri, 22 Aug 2025
 05:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com> <20250813185530.635096-3-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250813185530.635096-3-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Aug 2025 14:47:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jb=cM4ACYr3R++sM-N_Lgz7Pjtk4fuvTOpWmmdirGZ9g@mail.gmail.com>
X-Gm-Features: Ac12FXxYdzgr_siRauFsritWKnuv2ewbwZHJPiTWBg7g10HY-2dDm0PJJ9xLOkU
Message-ID: <CAJZ5v0jb=cM4ACYr3R++sM-N_Lgz7Pjtk4fuvTOpWmmdirGZ9g@mail.gmail.com>
Subject: Re: [PATCH 2/5] thermal: intel: int340x: Enable power slider interface
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please add "for Panther Lake" to the subject.

On Wed, Aug 13, 2025 at 8:55=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Enable power slider interface for Panther Lake.

And I would say "Set the PROC_THERMAL_FEATURE_SOC_POWER_SLIDER feature
flag in proc_thermal_pci_ids[] for Panther Lake" here.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index d4d7e8e147d2..e2471768d355 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -498,7 +498,8 @@ static const struct pci_device_id proc_thermal_pci_id=
s[] =3D {
>         { PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
>           PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
>           PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT=
 |
> -         PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC) },
> +         PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC |
> +         PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
>         { PCI_DEVICE_DATA(INTEL, WCL_THERMAL, PROC_THERMAL_FEATURE_MSI_SU=
PPORT |
>           PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
>           PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_HINT |
> --
> 2.43.0
>

