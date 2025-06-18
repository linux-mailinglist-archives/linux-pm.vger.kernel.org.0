Return-Path: <linux-pm+bounces-29009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17BADF6B9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 21:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499D74A0569
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 19:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDD320551C;
	Wed, 18 Jun 2025 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3kn5786"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8E20296A;
	Wed, 18 Jun 2025 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274315; cv=none; b=dJNGoQ2RtZVZ+OuA7uQabGIEavCzXkO7oFMeTIgCED1ym5vd2ILodOAvAi0vbTl9a4Lr+7h+u3S6fKZvJ1H3ofJhwlXsS8PLRXzSmz7i/lH/RnE3VSgdaEvoLptNmIBBpMwSNnOiI7gTKhC7yaf/nKnNUzaEphrUq+o10macv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274315; c=relaxed/simple;
	bh=nFx9/6dr/83VmBFA9G8iztSrXjlpzNPkzU2OuSNGLwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfEBHLidh4IZ9xirxpECo7bE8GTlT8iMEnmyLJu7gQ9YrGFXs1jTC/KOxS7BXb4/TtQioK0pkuTKQeaimq2XEBXNin7Wv/HFpU5tDxIElUosObWxeWXLYsAAxTsdMBOG/ZUjE757LI2N66X4mWZQfZs5aUY8xEww/qEuTRUBQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3kn5786; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8BCC4CEEF;
	Wed, 18 Jun 2025 19:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750274314;
	bh=nFx9/6dr/83VmBFA9G8iztSrXjlpzNPkzU2OuSNGLwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e3kn57865hp92olHBCU1c0IhbGdlYC8h1DQ9fll3u5dgmsD4+8uDDA8YD3xzBl835
	 gfKoEtdAvKTaD7Z+2aVlw9RvN4UEoJnNhCQOLq325TjPTyINLKUC75RbmnMF6vhFwp
	 EKaHCFyky+80txwiHKDx511HMtYMmp6eQHXGw4umM4IvWgYUjJ0dtU7lu1ICZ85Rr9
	 tSCLL0Rif/3Gh2DhcYDnaz1/MNpmxZoc7leKx4xSo4ldGS17Ein+bXcg5FdgJD8xWw
	 pD5XL35sz3GYur4GObPQvLHI6iB0LulDBr8ZuM5X/x9mZfjhyUXdo4c+Pp6tmRQ+ym
	 u5lcUO/I4Icdw==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40a4de1753fso741360b6e.1;
        Wed, 18 Jun 2025 12:18:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCKFhVsO0Hxxf2h8hZxtS+1FXuZUmGXRHgJaBMqndVq62pppcKec0IKgXd7XCglVaIQVppwv2h5Ks=@vger.kernel.org, AJvYcCXGLlMgn24noatcdIFQPGFP0XGtgdS+Q+c4bwJtPLMjb+26rz41D8B5s2qxB6x2QMkAHjaww8rqeJ2xqt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RicgUhT5o3W4CIo8rn8/vMyUE0bEQgjNxkr3C2qrKpmqE6WH
	FDTFDB807l0xvNRP7dOy1cKm9ebQ9vs9KL5NxmvJ0/jIV2dc1EIiyeYIEo9YKai040W6xFohAij
	V1gcl6ldZgbyhkaZxAc+JozL4V6SySCw=
X-Google-Smtp-Source: AGHT+IGOHirgz5FYM4pEXQ8eM8WERUHOiU82hpKPnuxSNMqf/zOikTnahVJBQLSY6YqfkmS/jgxo18Yd0XHF7B03LTY=
X-Received: by 2002:a05:6808:4482:b0:406:70bb:f25 with SMTP id
 5614622812f47-40ab510fc12mr621466b6e.4.1750274313935; Wed, 18 Jun 2025
 12:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617231940.3314546-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250617231940.3314546-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Jun 2025 21:18:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gEz7q5BgJ+=LNmHGBG6Egacd3aXs-Uf25E5MXSJyU0HA@mail.gmail.com>
X-Gm-Features: AX0GCFuOsYeuZdnXqu_JMMSi9SRI3xP_KUK3DWpEm4ke98BtcpkGTi96IrtWzVg
Message-ID: <CAJZ5v0gEz7q5BgJ+=LNmHGBG6Egacd3aXs-Uf25E5MXSJyU0HA@mail.gmail.com>
Subject: Re: [PATCH] thermal: int340x: processor_thermal: Add Wildcat Lake PCI ID
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, daniel.lezcano@linaro.org, rafael@kernel.org, 
	lukasz.luba@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 1:19=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add Wildcat Lake PCI ID for processor thermal device.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../thermal/intel/int340x_thermal/processor_thermal_device.h  | 1 +
>  .../intel/int340x_thermal/processor_thermal_device_pci.c      | 4 ++++
>  .../thermal/intel/int340x_thermal/processor_thermal_rfim.c    | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index 9a6ca43b6fa2..49398794124a 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -31,6 +31,7 @@
>  #define PCI_DEVICE_ID_INTEL_SKL_THERMAL        0x1903
>  #define PCI_DEVICE_ID_INTEL_TGL_THERMAL        0x9A03
>  #define PCI_DEVICE_ID_INTEL_PTL_THERMAL        0xB01D
> +#define PCI_DEVICE_ID_INTEL_WCL_THERMAL        0xFD1D
>
>  struct power_config {
>         u32     index;
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index 00160936070a..d4d7e8e147d2 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -499,6 +499,10 @@ static const struct pci_device_id proc_thermal_pci_i=
ds[] =3D {
>           PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
>           PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT=
 |
>           PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC) },
> +       { PCI_DEVICE_DATA(INTEL, WCL_THERMAL, PROC_THERMAL_FEATURE_MSI_SU=
PPORT |
> +         PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
> +         PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_HINT |
> +         PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC) },
>         { },
>  };
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim=
.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> index 3a028b78d9af..1f3d22b659db 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> @@ -442,6 +442,7 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struc=
t proc_thermal_device *proc
>                 switch (pdev->device) {
>                 case PCI_DEVICE_ID_INTEL_LNLM_THERMAL:
>                 case PCI_DEVICE_ID_INTEL_PTL_THERMAL:
> +               case PCI_DEVICE_ID_INTEL_WCL_THERMAL:
>                         dlvr_mmio_regs_table =3D lnl_dlvr_mmio_regs;
>                         dlvr_mapping =3D lnl_dlvr_mapping;
>                         break;
> --

Applied as 6.17 material, thanks!

