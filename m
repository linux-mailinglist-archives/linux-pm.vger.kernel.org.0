Return-Path: <linux-pm+bounces-19456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547C19F6E63
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE7A188AA7E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F038720101B;
	Wed, 18 Dec 2024 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekc/pT/M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85941FC7EC;
	Wed, 18 Dec 2024 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550910; cv=none; b=KhFqnipqC77dcvAp/o9z0Cboy+8fFUXvI+6eXyEVeISNTVvODw4sRIt4LefBCmKBQ+MA3XkKeqThMb84dh1CIe/iU/CkxiHyNeav878O/Q5mwR9VtFz4KSLFjnh0NEYA230sxtkl0Ir/rVCLWChen/61c78hrj6ySejsRxCsaOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550910; c=relaxed/simple;
	bh=Ro+ROOBocewSHtDnBcUMFdGQ2lMLaknOu9cIOu5ghIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RthpSiLoKjChgj0EZ1zFva5tdScjSan1XqoVpy7hGvWl/VS03RLSvwq/W7u+nLmWFdDOVc0zO9bQExR4eOlbXhKt/6rjjXitsymThUCTl+S29knv0uHZwSjvAciXsXRFKahSYOH/GM7dz2BtXEI58xjpFRR+7c59pzaf5j09LbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekc/pT/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E5AC4CED7;
	Wed, 18 Dec 2024 19:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734550910;
	bh=Ro+ROOBocewSHtDnBcUMFdGQ2lMLaknOu9cIOu5ghIA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ekc/pT/MAVsW6ouWoFjG3LUU6bqaldLszxSpCZsCL1pEy/8dc8pvMETiA6p96MCjX
	 mn76Nepye4qH3ARIpSqqDqmHeu9bYnnETQkXNZ5wAGxskxf1v1qdUJL1Rte1210izc
	 FFNlNB6T81GEZN71H+3VikQtL7TL9lZLuDmED/X6XK2wpRHYTzG+DTn3ReWLiJPagS
	 f04Xr/E8o50fKWFtQD52JC9NB8hUYxgaiCuqpXStcyXmKnBggxQrPsWkYfPOP+tV86
	 rzw+r48/xBLlGyJLZSQ0HPfOlcbV9aDYjpW/JzdHsg40c11nTRrEYF4/O/gT/R9P68
	 Rzyl3IPbRob8g==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb7e725aa0so5991b6e.0;
        Wed, 18 Dec 2024 11:41:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDl7UNcEYizivw9eXsSdmb8qW6XcnOY6CG9wPqDGogWfchwXkQ12sDuARv6qq+ifryqh5L6WyhtZw30t8=@vger.kernel.org, AJvYcCWkfUsrmULQhUUZ49Q2Y81a4dhfHlDGf52rVg2pjpruyPoXW9xDVmDSBuEgw+YzL78gEntKEli9Tyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYs5voUoONcHuWOb+fRyaU7QbaQs4LjOoTfNRgrdIvb/eR5Cot
	zrlw50kUmmdnrJ9ZVKxo/Ix6ZpsCEIlPE2JFDXlCDQNjz7KE9UBcTFbYhaCGVyY1oW88j6UkAGo
	25y+PoPKcWdqDqfM0V0kQ3dUqMBQ=
X-Google-Smtp-Source: AGHT+IFgKVGXMs01Y4wnQFrGMRaTcrrX63UOCdp4G8rubHwRfTcv6USmQ/P9u1JoBPqZJk/+Row1f3LUVXkKNuapsrI=
X-Received: by 2002:a05:6808:22ac:b0:3eb:66d7:a33e with SMTP id
 5614622812f47-3eccbf2c337mr2468640b6e.5.1734550909468; Wed, 18 Dec 2024
 11:41:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216190821.1137162-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20241216190821.1137162-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 20:41:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g2uma1Z1+23aCEqtbeqM5PWbL5_Hk+u=jjpcQxab5ZBg@mail.gmail.com>
Message-ID: <CAJZ5v0g2uma1Z1+23aCEqtbeqM5PWbL5_Hk+u=jjpcQxab5ZBg@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: Remove explicit user_space governor selection
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 8:08=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Currently some user space programs like Linux thermald needs to register
> to get notifications from both thermal user space governor and also
> Thermal netlink. This is required as some messages like HFI (Hardware
> Feedback Notifications) requires Thermal netlink.
>
> This results in additional processing in kernel and user space to process
> both notifications. The cost of using user space governor using
> kobject_uevent is much higher as this is also used by other user space
> daemons like udev daemon.
>
> Do not select user_space thermal governor by default. If it is present
> user space programs can always use this governor by writing to
> "policy" attribute.
>
> Instead from the kernel select THERMAL_NETLINK. Trip temperature
> violation can be received by user space programs via thermal netlink
> events:
> THERMAL_GENL_EVENT_TZ_TRIP_UP
> THERMAL_GENL_EVENT_TZ_TRIP_DOWN
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/intel/Kconfig                                   | 2 +-
>  drivers/thermal/intel/int340x_thermal/Kconfig                   | 2 +-
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c         | 1 -
>  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 1 -
>  .../intel/int340x_thermal/processor_thermal_device_pci.c        | 1 -
>  5 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfi=
g
> index a31f2f32996a..9c0f66f9defc 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -22,7 +22,7 @@ config INTEL_TCC
>  config X86_PKG_TEMP_THERMAL
>         tristate "X86 package temperature thermal driver"
>         depends on X86_THERMAL_VECTOR
> -       select THERMAL_GOV_USER_SPACE
> +       select THERMAL_NETLINK
>         select INTEL_TCC
>         default m
>         help
> diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/ther=
mal/intel/int340x_thermal/Kconfig
> index e76b13e44d03..d9a74424c29d 100644
> --- a/drivers/thermal/intel/int340x_thermal/Kconfig
> +++ b/drivers/thermal/intel/int340x_thermal/Kconfig
> @@ -6,7 +6,7 @@
>  config INT340X_THERMAL
>         tristate "ACPI INT340X thermal drivers"
>         depends on X86_64 && ACPI && PCI
> -       select THERMAL_GOV_USER_SPACE
> +       select THERMAL_NETLINK
>         select ACPI_THERMAL_REL
>         select ACPI_FAN
>         select ACPI_THERMAL_LIB
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 8660ef2175be..cbfae5b9668c 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -521,7 +521,6 @@ static struct thermal_zone_device_ops int3400_thermal=
_ops =3D {
>  };
>
>  static struct thermal_zone_params int3400_thermal_params =3D {
> -       .governor_name =3D "user_space",
>         .no_hwmon =3D true,
>  };
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c=
 b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 31ed338eb83c..8dca6a6aceca 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -105,7 +105,6 @@ static int int340x_thermal_read_trips(struct acpi_dev=
ice *zone_adev,
>  }
>
>  static struct thermal_zone_params int340x_thermal_params =3D {
> -       .governor_name =3D "user_space",
>         .no_hwmon =3D true,
>  };
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index e8c0bb536862..b307889103d3 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -272,7 +272,6 @@ static const struct thermal_zone_device_ops tzone_ops=
 =3D {
>  };
>
>  static struct thermal_zone_params tzone_params =3D {
> -       .governor_name =3D "user_space",
>         .no_hwmon =3D true,
>  };
>
> --

Applied as 6.14 material, thanks!

