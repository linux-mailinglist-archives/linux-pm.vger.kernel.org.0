Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4F81E856C
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 19:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgE2RnV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 13:43:21 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40661 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2RnU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 13:43:20 -0400
Received: by mail-ej1-f68.google.com with SMTP id d7so2873335eja.7;
        Fri, 29 May 2020 10:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DGdAJwSRoy97UkF9GUASzP4mclDuzVGuVm8dza65mL0=;
        b=RAX7ynDu+XkLRnvKIo5ucLQeExw8wPKzDYNl97EYkEtIMxzbbX+MzmqvbD6dO2b7Np
         7uzeJUbEmMesI/cO6plUZnbp3izshtLyDsVEGUU9+omnPsNaMPFUYHSN1cR0/S084vgx
         PEsqNzHIU31LtpAHhvCf/NnT9+wGzDQkeHRqjY7ZhAxVNCT/v17mkb0DC5ecMeF7xx36
         SRYk17hcRPFQHdjkTkLOKS3A+i2IY/kiHhw02GIcw6DlnghrhvovZAps9cyse1tF778R
         8w0b8FM5Q+Q5bYaeidq5/8idT1fj29ggebY/vACsNjpygGI8sfD03PPbYG/ASRQ+dVxx
         vntQ==
X-Gm-Message-State: AOAM532+lcjlrmN4x6PmHKBjGaqfSTxfQY22sfvxtZ8/9LYLvL2CY1eO
        9VFIvMUS03RuRaIjh2NnaXE=
X-Google-Smtp-Source: ABdhPJwAz/hHPcOg45ajcxiaPekh/DxsPSzG81NjEdM9fiBtISODvcpodzPSoCYvLaLGwSoDNelQpg==
X-Received: by 2002:a17:906:d216:: with SMTP id w22mr8317518ejz.420.1590774197560;
        Fri, 29 May 2020 10:43:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.118])
        by smtp.googlemail.com with ESMTPSA id g22sm6589331edj.63.2020.05.29.10.43.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 10:43:16 -0700 (PDT)
Date:   Fri, 29 May 2020 19:43:14 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/2] soc: samsung: Add simple voltage coupler for
 Exynos5800
Message-ID: <20200529174314.GB20540@kozik-lap>
References: <20200529124940.10675-1-m.szyprowski@samsung.com>
 <CGME20200529124952eucas1p2565c598c3c0164b5dec6ed83e19148b8@eucas1p2.samsung.com>
 <20200529124940.10675-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529124940.10675-3-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 29, 2020 at 02:49:40PM +0200, Marek Szyprowski wrote:
> Add custom voltage regulator coupler for Exynos5800 SoCs, which require
> coupling between "vdd_arm" and "vdd_int" regulators. This coupler ensures
> that coupled regulators voltage balancing is done only when clients for
> each regulator (cpufreq for "vdd_arm" and devfreq for "vdd_int") apply
> their constraints, so the voltage values don't go beyond the
> bootloader-selected operation point during the boot process. This also
> ensures proper voltage balancing if any of those drivers is missing.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig                  |  1 +
>  drivers/soc/samsung/Kconfig                   |  3 +
>  drivers/soc/samsung/Makefile                  |  1 +
>  .../soc/samsung/exynos-regulator-coupler.c    | 59 +++++++++++++++++++
>  4 files changed, 64 insertions(+)
>  create mode 100644 drivers/soc/samsung/exynos-regulator-coupler.c
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 76838255b5fa..f185cd3d4c62 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -118,6 +118,7 @@ config SOC_EXYNOS5800
>  	bool "Samsung EXYNOS5800"
>  	default y
>  	depends on SOC_EXYNOS5420
> +	select EXYNOS_REGULATOR_COUPLER
>  
>  config EXYNOS_MCPM
>  	bool
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index c7a2003687c7..264185664594 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -37,4 +37,7 @@ config EXYNOS_PM_DOMAINS
>  	bool "Exynos PM domains" if COMPILE_TEST
>  	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
>  
> +config EXYNOS_REGULATOR_COUPLER
> +	bool "Exynos SoC Regulator Coupler" if COMPILE_TEST
> +	depends on ARCH_EXYNOS || COMPILE_TEST
>  endif
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index edd1d6ea064d..ecc3a32f6406 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
>  obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
>  					exynos5250-pmu.o exynos5420-pmu.o
>  obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
> +obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
> diff --git a/drivers/soc/samsung/exynos-regulator-coupler.c b/drivers/soc/samsung/exynos-regulator-coupler.c
> new file mode 100644
> index 000000000000..54445918bd75
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-regulator-coupler.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *	      http://www.samsung.com/
> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
> + *
> + * Samsung Exynos SoC voltage coupler
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/regulator/coupler.h>
> +#include <linux/regulator/driver.h>
> +
> +static int exynos_coupler_balance_voltage(struct regulator_coupler *coupler,
> +					  struct regulator_dev *rdev,
> +					  suspend_state_t state)
> +{
> +	struct coupling_desc *c_desc = &rdev->coupling_desc;
> +	int ret, cons_uV = 0, cons_max_uV = INT_MAX;
> +	bool skip_coupled = false;
> +
> +	/* get coupled regulator constraints */
> +	ret = regulator_check_consumers(c_desc->coupled_rdevs[1], &cons_uV,
> +					&cons_max_uV, state);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* skip adjusting coupled regulator if it has no constraints set yet */
> +	if (cons_uV == 0)
> +		skip_coupled = true;
> +
> +	return regulator_do_balance_voltage(rdev, state, skip_coupled);
> +}
> +
> +static int exynos_coupler_attach(struct regulator_coupler *coupler,
> +				 struct regulator_dev *rdev)
> +{
> +	if (strcmp(rdev_get_name(rdev), "vdd_arm") == 0 ||
> +	    strcmp(rdev_get_name(rdev), "vdd_int") == 0)

Thanks for the patch!

You hard-coded specific names of regulators existing
only in DTS. They do not come from any driver nor bindings, therefore
they could change making driver unusable. Someone could add a new DTS
with different names and expect this to work as well.

You need bindings for this. Something like:
Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
But better in YAML, if possible.

Best regards,
Krzysztof
