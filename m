Return-Path: <linux-pm+bounces-25480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57703A8A4CA
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 19:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD741901EBF
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B0B29B79D;
	Tue, 15 Apr 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9Wo8wfB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186817A2F8;
	Tue, 15 Apr 2025 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736398; cv=none; b=bqHGSOF108qOpZr5gb2nTwssxkMxG+2kGzfP6S2zUYEKucX4+mVrlkJN1bsADL70G72WSo0Es4UvrjNHCU2D918q+ToDojYwPRGqQvqar/7sBQQPZPSx4Rdv05Oh5CT2CyjsK//3Ubint/Wf63Tc+UZCnbW9VioEgiPdXAJNZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736398; c=relaxed/simple;
	bh=hekA5sSay81odGS8KN3L8RNR60gbS176RT1c1dPcp7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCopJU3Q3BdADJ0At3uwVCwqtrZoicTDFfKxJVWbf5fuZa/4ehuJ1czrvP38pjQ4e3nvsg+X7Y60q/XVEs9Wj3iOZ4zx5aXT1NuDqMd7uGWmXQpdSrGVhaR7Wzjli9wbyVfWmN/dDZsRQ68bBbDZZKKphrl9Eu0Zz2AciOgRrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9Wo8wfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B8FC4CEEB;
	Tue, 15 Apr 2025 16:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744736397;
	bh=hekA5sSay81odGS8KN3L8RNR60gbS176RT1c1dPcp7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s9Wo8wfBYJ0DcFr+hwgeEXeHlXshfgmcWQfz9BWyOlNThqLwT84S1/2RdoSKxkUaR
	 21VBH2jp+zZbsEZSA1LOSf+vhaoZN2YyMNVbGehKvQ63qc284ZEdwOFP6q5wT4LF7i
	 reSVl9A/h8XChJL91jtbJlyQZCiBVzENVTBuhhq+Vvcx9yexmLdm7wIT8/OOBmQcot
	 9JHCBGVx3oYSwhpfOdxu4kK3lzPKAiJwzu4TJb6B8PZ6dlvw8WDPqNQgq993X7XxpI
	 4HUGG181rux6DiLCvK8uDXdY7010RK5fRZzY5ou5+RQcoppLNm2VtzFdm+fVv7TAX6
	 WdMU3hdgko98g==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2d09d495c6cso1643084fac.3;
        Tue, 15 Apr 2025 09:59:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIiN38DoWKJWwvemjbBk0gZLhJQrFgPhQuM7FPVjUU+2+zYF9kj9iVopsYE6lnN6qXRP5m/SOrOUe5FAI=@vger.kernel.org, AJvYcCWJEZfK4aloMXAFufPbDCqNtsk/apDB2ZE6AsE9WlB4aXNJOX9XieZ5c7LiRes0Jwkbf1pTQ05RZ4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6SQPt0kxf3Uc82q0wByZDigMVHVo36qNTs5fsvPaeIY0BIadb
	qM0i7LDEdvCau6/nQ23NSAzPxzac/CroEhK6SUDLzaWpfvwmYCwcLK2UijOeervF3VRtxrUO4T8
	tM6hkmG5wgi3Z079qfqLET5xnZvU=
X-Google-Smtp-Source: AGHT+IE17orsWraUADshZs7Bkgwwk4B/+7ACOA+1ofXY2D3rl9/81je0pV9HLaeNN/L12cjY+uI7SQSxualbqcI6waI=
X-Received: by 2002:a05:6870:889a:b0:2c1:b58c:bef with SMTP id
 586e51a60fabf-2d0d5f68495mr10448320fac.38.1744736396846; Tue, 15 Apr 2025
 09:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411115438.594114-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250411115438.594114-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 18:59:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iOZ+D9uR-Sd=shJXLsQ_myOhf8pJeB=E_rK7g_u6SyRA@mail.gmail.com>
X-Gm-Features: ATxdqUFLV9P9YBzJA4t01WKTlAMR_-WdzZ78kRP1Rqhsw6btj4P2ltMFqF3jGA0
Message-ID: <CAJZ5v0iOZ+D9uR-Sd=shJXLsQ_myOhf8pJeB=E_rK7g_u6SyRA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Fix Panther Lake DLVR support
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 1:54=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Panther lake uses same register offsets as Lunar Lake. But the
> registers are still pointing to the default table.
>
> Move the selection of register offsets table from the actual attribute
> read/write callbacks to the proc_thermal_rfim_add(). This way it is clean
> and in future such issues can be avoided.
>
> Fixes: e50eeababa94 ("thermal: intel: int340x: Panther Lake DLVR support"=
)
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../int340x_thermal/processor_thermal_rfim.c  | 33 ++++++++++---------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim=
.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> index dad63f2d5f90..3a028b78d9af 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> @@ -166,15 +166,18 @@ static const struct mmio_reg adl_dvfs_mmio_regs[] =
=3D {
>         { 0, 0x5A40, 1, 0x1, 0}, /* rfi_disable */
>  };
>
> +static const struct mapping_table *dlvr_mapping;
> +static const struct mmio_reg *dlvr_mmio_regs_table;
> +
>  #define RFIM_SHOW(suffix, table)\
>  static ssize_t suffix##_show(struct device *dev,\
>                               struct device_attribute *attr,\
>                               char *buf)\
>  {\
> -       const struct mapping_table *mapping =3D NULL;\
> +       const struct mmio_reg *mmio_regs =3D dlvr_mmio_regs_table;\
> +       const struct mapping_table *mapping =3D dlvr_mapping;\
>         struct proc_thermal_device *proc_priv;\
>         struct pci_dev *pdev =3D to_pci_dev(dev);\
> -       const struct mmio_reg *mmio_regs;\
>         const char **match_strs;\
>         int ret, err;\
>         u32 reg_val;\
> @@ -186,12 +189,6 @@ static ssize_t suffix##_show(struct device *dev,\
>                 mmio_regs =3D adl_dvfs_mmio_regs;\
>         } else if (table =3D=3D 2) { \
>                 match_strs =3D (const char **)dlvr_strings;\
> -               if (pdev->device =3D=3D PCI_DEVICE_ID_INTEL_LNLM_THERMAL)=
 {\
> -                       mmio_regs =3D lnl_dlvr_mmio_regs;\
> -                       mapping =3D lnl_dlvr_mapping;\
> -               } else {\
> -                       mmio_regs =3D dlvr_mmio_regs;\
> -               } \
>         } else {\
>                 match_strs =3D (const char **)fivr_strings;\
>                 mmio_regs =3D tgl_fivr_mmio_regs;\
> @@ -214,12 +211,12 @@ static ssize_t suffix##_store(struct device *dev,\
>                                struct device_attribute *attr,\
>                                const char *buf, size_t count)\
>  {\
> -       const struct mapping_table *mapping =3D NULL;\
> +       const struct mmio_reg *mmio_regs =3D dlvr_mmio_regs_table;\
> +       const struct mapping_table *mapping =3D dlvr_mapping;\
>         struct proc_thermal_device *proc_priv;\
>         struct pci_dev *pdev =3D to_pci_dev(dev);\
>         unsigned int input;\
>         const char **match_strs;\
> -       const struct mmio_reg *mmio_regs;\
>         int ret, err;\
>         u32 reg_val;\
>         u32 mask;\
> @@ -230,12 +227,6 @@ static ssize_t suffix##_store(struct device *dev,\
>                 mmio_regs =3D adl_dvfs_mmio_regs;\
>         } else if (table =3D=3D 2) { \
>                 match_strs =3D (const char **)dlvr_strings;\
> -               if (pdev->device =3D=3D PCI_DEVICE_ID_INTEL_LNLM_THERMAL)=
 {\
> -                       mmio_regs =3D lnl_dlvr_mmio_regs;\
> -                       mapping =3D lnl_dlvr_mapping;\
> -               } else {\
> -                       mmio_regs =3D dlvr_mmio_regs;\
> -               } \
>         } else {\
>                 match_strs =3D (const char **)fivr_strings;\
>                 mmio_regs =3D tgl_fivr_mmio_regs;\
> @@ -448,6 +439,16 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, stru=
ct proc_thermal_device *proc
>         }
>
>         if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR) {
> +               switch (pdev->device) {
> +               case PCI_DEVICE_ID_INTEL_LNLM_THERMAL:
> +               case PCI_DEVICE_ID_INTEL_PTL_THERMAL:
> +                       dlvr_mmio_regs_table =3D lnl_dlvr_mmio_regs;
> +                       dlvr_mapping =3D lnl_dlvr_mapping;
> +                       break;
> +               default:
> +                       dlvr_mmio_regs_table =3D dlvr_mmio_regs;
> +                       break;
> +               }
>                 ret =3D sysfs_create_group(&pdev->dev.kobj, &dlvr_attribu=
te_group);
>                 if (ret)
>                         return ret;
> --

Applied as 6.15-rc support, thanks!

