Return-Path: <linux-pm+bounces-19514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ABA9F7A93
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 12:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B65116B0AD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 11:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8534223C7F;
	Thu, 19 Dec 2024 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ags3sPBS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF4D22371F;
	Thu, 19 Dec 2024 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608647; cv=none; b=h47Gcr86lzbpdquURfXewf3s8x0hcuAuxvGBYzEM9OIi1teWKu+vgujavm2di7m4tRzzdtIwmUl8Gla78qjKkz4NH7ovz2bdMWLpZfVOvY6kAFYX7iaVTt8lVAUwyC4ZV0bdm0iZ2kYZqEbb3oJEZe2bhzixNjFTisKT5wnlfOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608647; c=relaxed/simple;
	bh=D33r+i2SxlJ4yCFdppg7FwBx+Q7YbM5EJkRtaRNDAtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmw0ecDJfM5Kz4gNMFB9GcFcXRP7Ujy33k73pfhlDfwrkgnu2mkiTCW3eF2fs6Nq0yEr/v3ILYER4e+eUk0teF7rD4jfpokycq8/w1AbRjOjoI+Gb0dTzPMF8L4CXoDUDLKEn46B0b9yOvqPaUh8LydGNJwsE9ei+T40YkBN8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ags3sPBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC75C4CED0;
	Thu, 19 Dec 2024 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608647;
	bh=D33r+i2SxlJ4yCFdppg7FwBx+Q7YbM5EJkRtaRNDAtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ags3sPBSpwh+h0Od254io0J+ZuZRVWdXLv9ndKH4Xd2xJeGbIfVYCrMuSEqPOl5nd
	 Zix0xRiYJt6rWoOq8q8cWRHivNrLEYTjev1xUlKGprZ1VtFFZmWht5xS4AAoU0Om+u
	 YzOdQQ1GT8uTucaAgX5bkHhNDTUX3b7w7Stvdrnhv0TwfAhfFO/IB6tdpZgwZ2Whhn
	 b9VfP4gh/wfdQYvh14NchaClFKVNLvE8zg+tjc5o61cAniLD4GJfLoMDvQixQAwT8y
	 J4Br/s5YNDQWVRRu9ibl0beq0pIx1okO/avpq0OVEz7wqRMicHjQND0vy64+r3NC42
	 f2BLgMv5FFTAA==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e16519031so379860a34.1;
        Thu, 19 Dec 2024 03:44:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7WY2d6jH1jC/jnx8QpXQZOAXiU7hH5vy4MfiSFdizpi84uBfldUJEHwFu431aW98q9KWXIIl8OSohH4o=@vger.kernel.org, AJvYcCXIb3iJO503uQQtDTMEQyjLUAA7RDXYOt0FXVDZZSNPczfe9mL1uYXajXPC0z7VLhv/RiEknmg/gPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5w1jLiBF1lxoGMtc9xoFDag+v048rKrA+ozb/XlcYhWxHTZr
	RnB7d4rL2zLEF60MXbk87kO3dE9v7xrQHaXAhu2o31Ieh60z3HUmh1hLzXwXFivKeOMC2oLybsH
	funELrWZIzpQQVmz8zxWhhN3NrwU=
X-Google-Smtp-Source: AGHT+IEldnZAiOkIQge2uEzeDIe0lviRGWCS02EZJh+xho0x9QAPl5MVK1YnRdV3loSuMZiFtyo55gWLlSiPzbgQ8p0=
X-Received: by 2002:a05:6830:3a19:b0:71d:eec3:5623 with SMTP id
 46e09a7af769-71fc5978601mr1288489a34.4.1734608646340; Thu, 19 Dec 2024
 03:44:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218214444.1904650-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20241218214444.1904650-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Dec 2024 12:43:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gAtJvRhn_uM6=r=q9CPxyoAsaczFYbgoJU0W_uqnbC2A@mail.gmail.com>
Message-ID: <CAJZ5v0gAtJvRhn_uM6=r=q9CPxyoAsaczFYbgoJU0W_uqnbC2A@mail.gmail.com>
Subject: Re: [PATCH linux-pm] thermal: intel: Fix compile issue when
 CONFIG_NET is not defined
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 10:45=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> If CONFIG_NET is not defined then THERMAL_NETLINK can't be selected.
> Hence add dependency on CONFIG_NET. Othewise it will generate compile
> errors while compiling thermal_netlink.c.
>
> Fixes: 4596cbea0ed2 ("thermal: intel: Remove explicit user_space governor=
 selection")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> This commit ID 4596cbea0ed2 is from linux-pm bleeding edge branch of
> linux-pm git.
>
>  drivers/thermal/intel/Kconfig                 | 1 +
>  drivers/thermal/intel/int340x_thermal/Kconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfi=
g
> index 9c0f66f9defc..e1973c0efe0c 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -22,6 +22,7 @@ config INTEL_TCC
>  config X86_PKG_TEMP_THERMAL
>         tristate "X86 package temperature thermal driver"
>         depends on X86_THERMAL_VECTOR
> +       depends on NET
>         select THERMAL_NETLINK
>         select INTEL_TCC
>         default m
> diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/ther=
mal/intel/int340x_thermal/Kconfig
> index d9a74424c29d..6a0203eaa7f2 100644
> --- a/drivers/thermal/intel/int340x_thermal/Kconfig
> +++ b/drivers/thermal/intel/int340x_thermal/Kconfig
> @@ -6,6 +6,7 @@
>  config INT340X_THERMAL
>         tristate "ACPI INT340X thermal drivers"
>         depends on X86_64 && ACPI && PCI
> +       depends on NET
>         select THERMAL_NETLINK
>         select ACPI_THERMAL_REL
>         select ACPI_FAN
> --

Applied, but I've just added the missing NET dependency to the
existing "depends on" lines.  Please check my bleeding-edge branch.

Thanks!

