Return-Path: <linux-pm+bounces-19458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE4A9F6E6C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F49718946A0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA01FC7C5;
	Wed, 18 Dec 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpcWhIoX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4341FC7C3;
	Wed, 18 Dec 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734551091; cv=none; b=JHSH3j0hSsiXKpAM54vwdwwXGBtanvhmbmyJvOko94otRiZElI4GPLR1Ni5i7zGF9ODF5ZWagkUuQPqyKdfmbZf+NdwVSfzeKuzYBittFkV4bWkn9GoA4exFpo747qJ/pdsgqkB+CE46/2mZXpQYE16EuHwsYpWdrjXHPbbQUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734551091; c=relaxed/simple;
	bh=vi4ar35TgfEneww7RUwzSu+1uQkybomXbx26hmtPwDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSX5e3yqxhb0DbRfZ6qUuw+JDX52S6eP3vqMR+0GFQ2yCAph3+b37Mg9Pdv/xC6zMGkMlPQyv0/c2NzNF9mQTqj8BXpju09j9E8Ck4QWr7iaMX1jSAzeEiuHKNhxcpMJNr4vcvg8XI40V9WqacpeLG8x1ELKBQPNMFMalbFPbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpcWhIoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D40C4CECD;
	Wed, 18 Dec 2024 19:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734551090;
	bh=vi4ar35TgfEneww7RUwzSu+1uQkybomXbx26hmtPwDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GpcWhIoXi/cRBK9Zc9hgIFYM6YN18MjIzgJ+SafnBz0Ci9700lqja8yM3zE58B5VC
	 Ih/oMmKcvmKoTn/0NIdyNM+GiMxZs75k7znxdh75JMZ0pUOoVcbk3mIJaz1j1G/Lb+
	 r7MUito2cIJSaeZ1xHtfmlL3Bw8d0bWcMxl+JzyYYaH9uV15JeU5N5tHBvl0iE5NFw
	 mRM4AswwkcbAZa8VaR17gQUH3FYkKia3gdTXQAwTzJVvvhS4lnorGPSJGgDF5ItBgf
	 26ISnhkc5YB/RYrPQPRONAxy2GBdIZn0GNXn7+Hon+t8qaP5gMo/UDOI6hixKP4WEM
	 z29xEZpuyLD/g==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ebbec36900so5437b6e.1;
        Wed, 18 Dec 2024 11:44:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU68Z2gZQhl1anVyq/GoY/jj2PVUlLB1XY2xSsgAeYovN6qG+lQ9Bg+QaKvhLxjrIT5OB0zRKdtYFA=@vger.kernel.org, AJvYcCVz9try0EzOdWGNUZgevURarxjOAsOrH8mRUxNJAr2mvMrKdSxAzzgj6WOaMwsHpO1RRZ3DBQ4Tph6t1Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2qr58bIwq+cSAaU2IZpbp2Wit0Kk7Gg5JbSuIuJpgvpk9vXBJ
	QbI21j7vTltqqO6FxURfNa4MUsPVURiFKEHLd2wqmVb5P4JFNEUMzK/As7Uz5iUKn2xlMrx/uim
	U0DqOxO2GlydChnVsl9JkgLpQEos=
X-Google-Smtp-Source: AGHT+IHCuz8fzBITUXkHlifuK90fMN6AaPpcI/xr54Uxnrv6os3sgSGAscYhWGlCyp8RM2q4lvsFbWVMbczRL6iOqcQ=
X-Received: by 2002:a05:6808:118c:b0:3e7:edd9:8eb1 with SMTP id
 5614622812f47-3eccbf2e2bemr2896528b6e.1.1734551089989; Wed, 18 Dec 2024
 11:44:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216211810.1207028-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20241216211810.1207028-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 20:44:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g1A5Ov-zMfGpuSUZ3Kf3QG5PuC0pmbMAADBKJ4eifVvg@mail.gmail.com>
Message-ID: <CAJZ5v0g1A5Ov-zMfGpuSUZ3Kf3QG5PuC0pmbMAADBKJ4eifVvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: intel: int340x: Panther Lake DLVR support
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 10:18=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Panther Lake follows same register set as Lunar Lake for DLVR. Enable
> feature flag to support DLVR.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index 707bd1b23823..fb3820e72c11 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -495,7 +495,8 @@ static const struct pci_device_id proc_thermal_pci_id=
s[] =3D {
>           PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR | PROC_TH=
ERMAL_FEATURE_WT_HINT) },
>         { PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
>           PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_TH=
ERMAL_FEATURE_WT_REQ) },
> -       { PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL) =
},
> +       { PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
> +         PROC_THERMAL_FEATURE_DLVR) },
>         { },
>  };
>
> --

Applied along with the [2/2] as 6.14 material, thanks!

