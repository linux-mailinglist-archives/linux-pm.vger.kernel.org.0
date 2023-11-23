Return-Path: <linux-pm+bounces-145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C71B7F6417
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 17:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7281C20DB0
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF42E82C;
	Thu, 23 Nov 2023 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXZebPif"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A57CD6F
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:39:22 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cdd4724f5dso1344837b3.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700757561; x=1701362361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vmZ3aqnoELfdExOz8/MScqsfbmRjioy6ag3nh3RptdY=;
        b=vXZebPifyPa8pqxSqESn8TsBTZPAcFmf6WUqYe2wO9VVaMQ2CsIivCIKUXs6YM26R6
         69zGvZpuQMmBdNxOxYotaUZl2zF4wl8R/dB4hN7kJolDgE9szxb1TWB1jJt9OXsMR4w8
         RYpMmXJoWftk9TMRykwyias0UwgzgjuxIBsqCE/Trl3NtiAd980Nm42RHZv0CONa/Hvd
         PBYkkTRSgGemDc3Cv/E0x3TaABSb89GY/CrvTDC9SdOiHDhE8Mist5aBtaC+SvHNy8Mk
         X/dCG2C32JrBtLpurAO0bVVMlT91bCDLhkn4Mn4xQsbxHhAQO7dlipnTKD1ojjZkvLKd
         k5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757561; x=1701362361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmZ3aqnoELfdExOz8/MScqsfbmRjioy6ag3nh3RptdY=;
        b=iaMg54fl2frppbEZlNEfwhovTLUAAmFYY6DbTBpXrhJoxvKW07Po9rGA/8EIC9yecx
         48o0P1g6kdQzdOnzrjNcdRbkCGxg3KzTpbBWEPutM9izkSnwEHOn6qdXH5JQOiJurJwP
         rSPmx0Uj2TqG2JYTja8htoq5LQE7gd4YEWcvga2zKQaq/OdBZzr2bCaiumNGvx48ZAsM
         GGav4D0+rTIVATndggUWVzM7g6WFcGGT4yTKoOf/fwMCDc9OpNSdX/W06gJSyzEBYcms
         DZxvb9BYDtnrGUcFDVj1g5V36BUHIGkhsBcRKJRgPQK8TofhxzI9GUJV0iJ37TihgO9V
         A3zA==
X-Gm-Message-State: AOJu0YzYZovWV01yr1FG/ticQfZJFCof+yF9hyhYrSHa0ReDboi3jRoM
	TiqMLV05yMIGtzGrdUp6H0NA9dqaE5jlVIhEwjp+Rw==
X-Google-Smtp-Source: AGHT+IHLaygOujHcsxhwgqH1+xmXQVS/pjSshn9lVlyMOsfC5nX192kXZc1WA+9ykaTVfYOBJs+kU82VM83yeX5ldTo=
X-Received: by 2002:a81:93c5:0:b0:5ca:4a9:adc0 with SMTP id
 k188-20020a8193c5000000b005ca04a9adc0mr6427788ywg.37.1700757561370; Thu, 23
 Nov 2023 08:39:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123120847.2825444-1-sudeep.holla@arm.com> <20231123120847.2825444-2-sudeep.holla@arm.com>
In-Reply-To: <20231123120847.2825444-2-sudeep.holla@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Nov 2023 17:38:45 +0100
Message-ID: <CAPDyKFqx8OYmHa1k_EdS0eCcaDkEhKSJFEFCqHm29JgQ92AefA@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: arm_scpi: Move power-domain driver to the
 pmdomain dir
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 13:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> To simplify with maintenance let's move the Arm SCPI power-domain driver
> to the new pmdomain directory. Note this is different from and precedes
> the new Arm SCMI protocol.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/firmware/Kconfig                            |  9 ---------
>  drivers/firmware/Makefile                           |  1 -
>  drivers/pmdomain/arm/Kconfig                        | 12 ++++++++++++
>  drivers/pmdomain/arm/Makefile                       |  1 +
>  drivers/{firmware => pmdomain/arm}/scpi_pm_domain.c |  0
>  5 files changed, 13 insertions(+), 10 deletions(-)
>  rename drivers/{firmware => pmdomain/arm}/scpi_pm_domain.c (100%)
>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 4a98a859d44d..afeb050ae1b4 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -28,15 +28,6 @@ config ARM_SCPI_PROTOCOL
>           This protocol library provides interface for all the client drivers
>           making use of the features offered by the SCP.
>
> -config ARM_SCPI_POWER_DOMAIN
> -       tristate "SCPI power domain driver"
> -       depends on ARM_SCPI_PROTOCOL || (COMPILE_TEST && OF)
> -       default y
> -       select PM_GENERIC_DOMAINS if PM
> -       help
> -         This enables support for the SCPI power domains which can be
> -         enabled or disabled via the SCP firmware
> -
>  config ARM_SDE_INTERFACE
>         bool "ARM Software Delegated Exception Interface (SDEI)"
>         depends on ARM64
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 5f9dab82e1a0..944833702ebd 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -3,7 +3,6 @@
>  # Makefile for the linux kernel.
>  #
>  obj-$(CONFIG_ARM_SCPI_PROTOCOL)        += arm_scpi.o
> -obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
>  obj-$(CONFIG_ARM_SDE_INTERFACE)        += arm_sdei.o
>  obj-$(CONFIG_DMI)              += dmi_scan.o
>  obj-$(CONFIG_DMI_SYSFS)                += dmi-sysfs.o
> diff --git a/drivers/pmdomain/arm/Kconfig b/drivers/pmdomain/arm/Kconfig
> index acbe4331aaf7..efa139c34e08 100644
> --- a/drivers/pmdomain/arm/Kconfig
> +++ b/drivers/pmdomain/arm/Kconfig
> @@ -23,3 +23,15 @@ config ARM_SCMI_POWER_DOMAIN
>           This driver can also be built as a module. If so, the module
>           will be called scmi_pm_domain. Note this may needed early in boot
>           before rootfs may be available.
> +
> +config ARM_SCPI_POWER_DOMAIN
> +       tristate "SCPI power domain driver"
> +       depends on ARM_SCPI_PROTOCOL || (COMPILE_TEST && OF)
> +       default y
> +       select PM_GENERIC_DOMAINS if PM
> +       help
> +         This enables support for the SCPI power domains which can be
> +         enabled or disabled via the SCP firmware
> +
> +         This driver can also be built as a module. If so, the module will be
> +         called scpi_pm_domain.
> diff --git a/drivers/pmdomain/arm/Makefile b/drivers/pmdomain/arm/Makefile
> index cfcb1f6cdd90..502fe4d0a83e 100644
> --- a/drivers/pmdomain/arm/Makefile
> +++ b/drivers/pmdomain/arm/Makefile
> @@ -2,3 +2,4 @@
>
>  obj-$(CONFIG_ARM_SCMI_PERF_DOMAIN) += scmi_perf_domain.o
>  obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
> +obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
> diff --git a/drivers/firmware/scpi_pm_domain.c b/drivers/pmdomain/arm/scpi_pm_domain.c
> similarity index 100%
> rename from drivers/firmware/scpi_pm_domain.c
> rename to drivers/pmdomain/arm/scpi_pm_domain.c
> --
> 2.42.0
>

