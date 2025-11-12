Return-Path: <linux-pm+bounces-37878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05463C5467F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 21:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB913A8978
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6662C0294;
	Wed, 12 Nov 2025 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzx/yHAo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45483285045
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978568; cv=none; b=W5guc6skatrG23jOkRRY6XydI8i8Udij6vA9TQg9DhwOeNDSH8LCPLQp4LffKyeJJsAcoSR71lN22OrnpILJ0Q6mjz80tFSbPfVvPMIns/e4jMF8B+rNmgIy+BkTBnpzs8M4vF5lj3SW+yh363oXUdH+2EykUbOJHGPKyamkMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978568; c=relaxed/simple;
	bh=IrgGiKdz/eRc1ywD+lUpcTT31wcHFzyrOIqkgiwBhks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9EyKZu12FAoNnSIixtXLKv6zDSBz3qSw57d/KWDYHpNkRp224ZLNLnjsJdLWZEakg3leqBywqRnL/fJZLTkZDeK9qmM7EoAtbFUlHAHrIOOEafhtnDopXJaCAvgE9N3YIezrFk8NJA9FUezIKIRBnFQ0vI1a0as7FHCo12OHrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzx/yHAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98EBC16AAE
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762978567;
	bh=IrgGiKdz/eRc1ywD+lUpcTT31wcHFzyrOIqkgiwBhks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dzx/yHAoBqangSFSmOu0fJSfBxCG5g3P1XUqb7goUXjb2rbhN4axCwKBdWfJ1EBrq
	 QYB1S7gUMoejiC5/2A9ouDZnSvt/6D41YdaxpfETdqAEVrFNRbI95YIvFNZyKk/BUo
	 j6C83BkmPkYKIp7Mtnnc1uJyE7kp7L8Sqnv2vhfC2Qe1eg5mm7iovE7zSp01ucGuYt
	 NS/IrhOTFA8NvfTP2iSC82kP3wMwKufFeOIPeW/qrS6JC20FqI2qUJulHBsGUlsA9x
	 pDy0/Z1W1LliRf7aM+HnHSOg4BQ94xv+uWqsQAwBpQkRUc5oz5ob++cIL4d3sx1wIZ
	 oYWk3rdtjkjpg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-44ffed84cccso7947b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 12:16:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5VKL7klJvxepyM7qsKpHXjR9mURkDCnncjsnOBDfvz6jHcmJbX9Qkei1+iCfa4iwalfFq9LHj4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQGW29cN6Zn7izd1SURq6FvLUpFxdFjyd5wB/A7ANPPDM9tDD
	7eJR0Vrgosmk3aBGxYpDQCbgYR6OJZWF/WvkSNWVqhE8/BuYHBfD3l70b4GpZiCQfTTOAbflJeG
	RLFqHImIjSl14TvfUIUAjATWkups6HNc=
X-Google-Smtp-Source: AGHT+IEFvUFRVaGaBOk5c72HA5TmrlZAybE40O8EhMjKEkGxPxshy1e934sF+DX5SVkP5RnAJXWMnI0uIXuARsfLBdo=
X-Received: by 2002:a05:6808:30a2:b0:43f:3c7a:954e with SMTP id
 5614622812f47-4507444791amr1916425b6e.8.1762978566983; Wed, 12 Nov 2025
 12:16:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111004552.137984-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20251111004552.137984-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 21:15:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hcziWByZ1vgT5GLqXTAh5fS3eSCpTY0PQaaDbZUoAOMw@mail.gmail.com>
X-Gm-Features: AWmQ_bnoRsW7hAeO_d7hFAflUhEX6bVR-17T4aUVi57iBnBk3oQgF-T11aW7PVI
Message-ID: <CAJZ5v0hcziWByZ1vgT5GLqXTAh5fS3eSCpTY0PQaaDbZUoAOMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: int340x: processor_thermal: Add Nova Lake
 processor thermal device
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 1:45=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add PCI IDs for Nova Lake processor thermal device.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../intel/int340x_thermal/processor_thermal_device.h   |  2 ++
>  .../int340x_thermal/processor_thermal_device_pci.c     | 10 ++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index 30760475102f..b79937a386ec 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -27,6 +27,8 @@
>  #define PCI_DEVICE_ID_INTEL_JSL_THERMAL        0x4E03
>  #define PCI_DEVICE_ID_INTEL_LNLM_THERMAL       0x641D
>  #define PCI_DEVICE_ID_INTEL_MTLP_THERMAL       0x7D03
> +#define PCI_DEVICE_ID_INTEL_NVL_H_THERMAL      0xD703
> +#define PCI_DEVICE_ID_INTEL_NVL_S_THERMAL      0xAD03
>  #define PCI_DEVICE_ID_INTEL_RPL_THERMAL        0xA71D
>  #define PCI_DEVICE_ID_INTEL_SKL_THERMAL        0x1903
>  #define PCI_DEVICE_ID_INTEL_TGL_THERMAL        0x9A03
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index e2471768d355..0d4dcc66e097 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -504,6 +504,16 @@ static const struct pci_device_id proc_thermal_pci_i=
ds[] =3D {
>           PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
>           PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_HINT |
>           PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC) },
> +       { PCI_DEVICE_DATA(INTEL, NVL_H_THERMAL, PROC_THERMAL_FEATURE_RAPL=
 |
> +         PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
> +         PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT=
 |
> +         PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC |
> +         PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
> +       { PCI_DEVICE_DATA(INTEL, NVL_S_THERMAL, PROC_THERMAL_FEATURE_RAPL=
 |
> +         PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
> +         PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT=
 |
> +         PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC |
> +         PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
>         { },
>  };
>
> --

Applied along with the rest of the series as 6.19 material, thanks!

