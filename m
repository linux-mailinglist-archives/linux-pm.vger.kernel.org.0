Return-Path: <linux-pm+bounces-39551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0FCCBD9D7
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 12:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA0E7300BEF6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 11:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FF2331236;
	Mon, 15 Dec 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh5BER6m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF18731AAAD
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799395; cv=none; b=ruQe72wIocT/fN1qgkzGSIgdHoMd/7rjIzxfi4+yhKRi0kKsMHVUQ6jIAOIVOMyVjlshVTFuvlwNPdbM9DZl4ObwPS2UCqtt+rcYFt/bO/cuaD7J7v5sMnScXAXuYd8lYGtGhr25jbp3Obn8L2lHk842l4RyditPhFztt6rxi/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799395; c=relaxed/simple;
	bh=5UBdRbgT9LGoF60llEjJFQmwkihjwIcLjozkzy9qz5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1zqw9pvdp59L36Rtp3zWOCaEdI+FGg1NMCGZtjz1CLvLmb3cbuUrdxmTbK5MozLdPUwU1pdfYyWzBetBgLa6F7kvmzErKzzCPTlyOcawOTe6dKY5UaerqYBQgfi7LIqIcdMJDLGZ+6EF0Wz/ZoDuGu+72ho6/nA/ZvmlY1Fle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bh5BER6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BECDC19423
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765799395;
	bh=5UBdRbgT9LGoF60llEjJFQmwkihjwIcLjozkzy9qz5M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bh5BER6mkITEXC2caqCr93h8ZspeH2BzKjbkcrQsCxBtuqeZt7MoyW+pUBVrjxO5m
	 DQJSZJggbWOJCI1YsrVUainExq4sh+i9BTL+Clg6Cdc2/i2LmGi+t4kRbsfYY0jbBK
	 4Y5xvV5j27MHfrstnY49+OMQYdb4myTlLTlNOrdGwyauLowovMn+73FbG/NB9H5pbC
	 qgBCZmKEYG5us8QmOCu1ejCnXA52ZUTDo1BQB/sY851h/mPbOSrL0xIeQel4Ipjvui
	 VNsTenzAnoF8lMTTsj6qlPjGCk/d17H8Dm03lJJQyMN29O9MDSdfydAnTzOeJtIsq7
	 5oM+x8WrpA3qg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3e84d56c4b8so2400472fac.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 03:49:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVN4x7JCQEox7iaKq5XJqGbXtOXT6rUFlCNx3Jvxevd4g7CQYqq7/AyZzX+XYwD/3mwEKxTXVvqlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbuVc6kHMVReQ9oWsAD51mZgbzt4ncQkNTif30uJLlUjzngmFX
	XTAjGMaeha0n2S9GXCxdd9CZSh8oJuWL3LlTCFisHa98b73oIZ1c1dG91052BBpIjiZSQTx1JMu
	Yn2mjKk39M5J299ECH4hrC69fASAq2T8=
X-Google-Smtp-Source: AGHT+IFZLHhilVjr/fUfhKL8apNfmYZ6lJz2k55qtkQCobGeQQtMRLhciQTE98rg528mtC9daonq7wo21p7bG+86Zdo=
X-Received: by 2002:a05:6820:8186:b0:659:9a49:9050 with SMTP id
 006d021491bc7-65b45186d80mr4909738eaf.27.1765799394849; Mon, 15 Dec 2025
 03:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205230007.2218533-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20251205230007.2218533-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Dec 2025 12:49:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hxOeDhxq5UgY5-RuaCj8bUOT6xHYPwGKGSVVFCktbxfw@mail.gmail.com>
X-Gm-Features: AQt7F2r3keIv-ubw7247O-dDW4UfoNTVIIluG6Kr91hQfROcDRGK4qW7r0cKpNg
Message-ID: <CAJZ5v0hxOeDhxq5UgY5-RuaCj8bUOT6xHYPwGKGSVVFCktbxfw@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Enable power slider interface
 for Wildcat Lake
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 12:00=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Set the PROC_THERMAL_FEATURE_SOC_POWER_SLIDER feature flag in
> proc_thermal_pci_ids[] for Wildcat Lake to enable power slider interface.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index 0d4dcc66e097..c693d934103a 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -503,7 +503,8 @@ static const struct pci_device_id proc_thermal_pci_id=
s[] =3D {
>         { PCI_DEVICE_DATA(INTEL, WCL_THERMAL, PROC_THERMAL_FEATURE_MSI_SU=
PPORT |
>           PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
>           PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_HINT |
> -         PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC) },
> +         PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC |
> +         PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
>         { PCI_DEVICE_DATA(INTEL, NVL_H_THERMAL, PROC_THERMAL_FEATURE_RAPL=
 |
>           PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
>           PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT=
 |
> --

Applied, thanks!

