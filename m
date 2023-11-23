Return-Path: <linux-pm+bounces-144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA39A7F6416
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 17:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3161C20D6A
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330A224A09;
	Thu, 23 Nov 2023 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKR2W0Me"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524ABD48
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:39:19 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5ac376d311aso10299307b3.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700757558; x=1701362358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwmOd2P9cKgLRyaHFpvpzzs6dIoaR+fzRLZv5g7gm0E=;
        b=aKR2W0MeadZzMW41L8j1LtoqewAwoS/xqqyrjZA4ZbVsttgLVP05rN0gmInzZ2Ns/2
         el9MmesZYUbacuN5DTCHEMLPh5L4MiLJvs1/o1guKkQNYz8yiKmGf1+VNCvPDgxaZEVE
         ePcYKO33kvocV5hUrxiwDAUEdGsAPpb0kK4VhhZlxZMMguxvvKO4/vga7eRSgoD5JvvC
         b8RhZCqHqFDuOAbuT7WhUdezHCSZprBnCDDG6QiIuwe1nCZYPPNXm1/VJZiyjnZY/NFQ
         EslkcHIj2N2qehpc58HvfLd8ni5aAirfFfr0bRiTFDMeXuZezLyrRThZ5g/BmwoDRzmB
         xoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757558; x=1701362358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwmOd2P9cKgLRyaHFpvpzzs6dIoaR+fzRLZv5g7gm0E=;
        b=D0ZhzDpEG6IV3aPY/eP9vygfi+0opiozZSHcoWjwL2APBXAJnbh7Ctu3iu5vbEMkDe
         NW0Ulwnls2odsvWJyf+VDglNCkGnk3uadOcWJVETyVIk4IXQxX7i919O1111sEYcLHuQ
         dl3IccMgemHe0rrdqkJ8PNF45p/3DbJyDecCh1MlgaI/RyAVDxM2w05s049fXnW2vqt1
         d0WKPTrC6+sxSUtiRmfUv4MtksBhpy9ZBznkBGy6vEYimu/948t5UPbMcAs3hIAJbya6
         pqWWYn7tgYkNA5BPuJgUURed8nqTu1GUh7WXE70mn6KbHUxIe9NKHh8UQswKHi/6J7OT
         cKXQ==
X-Gm-Message-State: AOJu0YwMmN7rziRXn+eoTUB0blrhX0Q9h4Z8GMkttrpkipL5/NnMvCWi
	wnalW19x2RZRRlsQv1oXB6myr7fLSDcTgMKKv36y3Q==
X-Google-Smtp-Source: AGHT+IGki08EgE5Dr9+Xz/FhyKnuYIwDH5+v66POoqy3r5r/ReRpAH/SUvQDmG1SbmfIsZzfmaOm5rSwO51F5oseY1U=
X-Received: by 2002:a0d:fb47:0:b0:5b3:b17d:190f with SMTP id
 l68-20020a0dfb47000000b005b3b17d190fmr6696840ywf.29.1700757558530; Thu, 23
 Nov 2023 08:39:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123120847.2825444-1-sudeep.holla@arm.com>
In-Reply-To: <20231123120847.2825444-1-sudeep.holla@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Nov 2023 17:38:42 +0100
Message-ID: <CAPDyKFr524AyxZkT+7+Hhnnc-tEVaVhKE2O7i_e4R1zys45Jag@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: arm_scmi: Move Kconfig options to the
 pmdomain subsystem
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 13:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The Kconfig options belongs closer to the corresponding implementations,
> hence let's move them from the firmware to the pmdomain subsystem.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/firmware/arm_scmi/Kconfig | 25 -------------------------
>  drivers/pmdomain/Kconfig          |  1 +
>  drivers/pmdomain/arm/Kconfig      | 25 +++++++++++++++++++++++++
>  3 files changed, 26 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/pmdomain/arm/Kconfig
>
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index 706d1264d038..aa5842be19b2 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -168,31 +168,6 @@ config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
>
>  endif #ARM_SCMI_PROTOCOL
>
> -config ARM_SCMI_POWER_DOMAIN
> -       tristate "SCMI power domain driver"
> -       depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> -       default y
> -       select PM_GENERIC_DOMAINS if PM
> -       help
> -         This enables support for the SCMI power domains which can be
> -         enabled or disabled via the SCP firmware
> -
> -         This driver can also be built as a module.  If so, the module
> -         will be called scmi_pm_domain. Note this may needed early in boot
> -         before rootfs may be available.
> -
> -config ARM_SCMI_PERF_DOMAIN
> -       tristate "SCMI performance domain driver"
> -       depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> -       default y
> -       select PM_GENERIC_DOMAINS if PM
> -       help
> -         This enables support for the SCMI performance domains which can be
> -         enabled or disabled via the SCP firmware.
> -
> -         This driver can also be built as a module. If so, the module will be
> -         called scmi_perf_domain.
> -
>  config ARM_SCMI_POWER_CONTROL
>         tristate "SCMI system power control driver"
>         depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index c98c5bf75a14..23c64851a5b0 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -4,6 +4,7 @@ menu "PM Domains"
>  source "drivers/pmdomain/actions/Kconfig"
>  source "drivers/pmdomain/amlogic/Kconfig"
>  source "drivers/pmdomain/apple/Kconfig"
> +source "drivers/pmdomain/arm/Kconfig"
>  source "drivers/pmdomain/bcm/Kconfig"
>  source "drivers/pmdomain/imx/Kconfig"
>  source "drivers/pmdomain/mediatek/Kconfig"
> diff --git a/drivers/pmdomain/arm/Kconfig b/drivers/pmdomain/arm/Kconfig
> new file mode 100644
> index 000000000000..acbe4331aaf7
> --- /dev/null
> +++ b/drivers/pmdomain/arm/Kconfig
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config ARM_SCMI_PERF_DOMAIN
> +       tristate "SCMI performance domain driver"
> +       depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> +       default y
> +       select PM_GENERIC_DOMAINS if PM
> +       help
> +         This enables support for the SCMI performance domains which can be
> +         enabled or disabled via the SCP firmware.
> +
> +         This driver can also be built as a module. If so, the module will be
> +         called scmi_perf_domain.
> +
> +config ARM_SCMI_POWER_DOMAIN
> +       tristate "SCMI power domain driver"
> +       depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> +       default y
> +       select PM_GENERIC_DOMAINS if PM
> +       help
> +         This enables support for the SCMI power domains which can be
> +         enabled or disabled via the SCP firmware
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called scmi_pm_domain. Note this may needed early in boot
> +         before rootfs may be available.
> --
> 2.42.0
>

