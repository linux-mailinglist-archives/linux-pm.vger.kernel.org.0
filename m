Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8251EBED8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 17:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFBPPX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 11:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgFBPPX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2020 11:15:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C95C08C5C0;
        Tue,  2 Jun 2020 08:15:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so6402756lfb.3;
        Tue, 02 Jun 2020 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BcTnXTbCcX6TVC2V+ud9EG3G2NgSLu2+NdrhF7WjWME=;
        b=E79yeRNfB0Bt4TTPXHzh3w4uix3YWLNBB7378EflH/nkEWYrm3a0glI3jA06tnosx8
         KI6Ihl/wQ6uYLVkhZyP6Ysr1yTbL7u9IRuyrQohyAjVYXFYtkxmUJzFufdvmdGTZx+vU
         dlt1vpTKa/IzaiQZ/z9XiFYTXAQXxrk/+C7xXNEidLxvyWrfEsL30pq6KjMAYm9hUs2K
         /eVYFBWbC5/RgJp7/+T70LuRmwkm7zZjTO8WVHpHdouJ5sqHfse8uqfZM3YO+fY+yE2N
         8fQRZrhcrGuuW5qIXF5nGXVfJDtPVONK2biqviONGg9It+tLc10da/x2c1/68e8n3nEP
         SgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BcTnXTbCcX6TVC2V+ud9EG3G2NgSLu2+NdrhF7WjWME=;
        b=BbH8wYFZZ2FbdOsD8B4LPx/yCbbcDQys2gurmCe4ve3KpbXYyTPUJXbVxmWaX7V40l
         tOUJeCNXGcW26L5+woQ0SaTLcFLI7bptBqU2MrIamtcQpifSGSuWkrtP+0VmrcgdwWP3
         FQEaaiWEfZx7c2UWGnGBeX4YI7ZGT0s2h7DocAdryBUuRdoZ8xsE6ezKk+hHC01N5QjW
         e5nuatsbMYlJvl/Pn/11MjI9FAE6b7KjamqRpYHWxgFmwJxA+Hzqj3LAX7zYgm7GdOew
         wip0ZmphdUrxjJiW17lY+t9oLlx3gbO8BZZw43GmCtSLaDr/jPnGYLOhRVMXRYv2MA8J
         0DWw==
X-Gm-Message-State: AOAM531qfrb38mO1rtKGL0qEJji6NXGBIMI4EGy14iXSLfOVzjGM0GKa
        z8m47dG+VusScaV48cy+3jA=
X-Google-Smtp-Source: ABdhPJykuRlwiQ25VUHXAwzDtxkHzzVb1KXvZ2OM6BMW50j9EXBsEF2dfbZ9Lxn9Itj3P15Xt6KJEQ==
X-Received: by 2002:ac2:485a:: with SMTP id 26mr14075155lfy.57.1591110921343;
        Tue, 02 Jun 2020 08:15:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-173-94.dynamic.spd-mgts.ru. [109.252.173.94])
        by smtp.googlemail.com with ESMTPSA id p15sm600578ljn.53.2020.06.02.08.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 08:15:17 -0700 (PDT)
Subject: Re: [PATCH v2] soc: samsung: Add simple voltage coupler for
 Exynos5800
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <57cf3a15-5d9b-7636-4c69-60742e8cfae6@samsung.com>
 <CGME20200602130931eucas1p1cd784c8f692fa91dc566504543a927de@eucas1p1.samsung.com>
 <20200602130211.2727-1-m.szyprowski@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4a5874c1-6b4e-2da5-4dd1-dd5537fe6de7@gmail.com>
Date:   Tue, 2 Jun 2020 18:15:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200602130211.2727-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.06.2020 16:02, Marek Szyprowski пишет:
> Add a simple custom voltage regulator coupler for Exynos5800 SoCs, which
> require coupling between "vdd_arm" and "vdd_int" regulators. This coupler
> ensures that the voltage balancing for the coupled regulators is done
> only when clients for the each regulator apply their constraints, so the
> voltage values don't go beyond the bootloader-selected operation point
> during the boot process. This also ensures proper voltage balancing if
> any of the client driver is missing.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - removed dependency on the regulator names as pointed by krzk, now it
>   works with all coupled regulators. So far the coupling between the
>   regulators on Exynos5800 based boards is defined only between
>   "vdd_arm" and "vdd_int" supplies.
> ---
>  arch/arm/mach-exynos/Kconfig                  |  1 +
>  drivers/soc/samsung/Kconfig                   |  3 +
>  drivers/soc/samsung/Makefile                  |  1 +
>  .../soc/samsung/exynos-regulator-coupler.c    | 56 +++++++++++++++++++
>  4 files changed, 61 insertions(+)
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
> index 000000000000..370a0ce4de3a
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-regulator-coupler.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *	      http://www.samsung.com/
> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
> + *
> + * Simple Samsung Exynos SoC voltage coupler. Ensures that all
> + * clients set their constraints before balancing the voltages.
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

Hello Marek,

Does this mean that you're going to allow to violate the coupling
constraints while coupled regulator has no consumers?

I don't think that you may want to skip the coupled balancing ever.
Instead you may want to assume that the min-voltage constraint equals to
the current regulator's voltage while the coupled regulator has no
consumers.

Yours variant of the balancer doesn't prevent the voltage dropping on
regulator's enabling while coupled regulator doesn't have active
consumers. This is the problem which we previously had once OPP code was
changed to enable regulator.

Secondly, yours variant of the balancer also doesn't handle the case
where set_voltage() is invoked while one of the couples doesn't have
active consumers because voltage of this couple may drop more than
allowed on the voltage re-balancing.

I'd suggest to simply change the regulator_get_optimal_voltage() to
limit the desired_min_uV to the current voltage if coupled regulator has
no consumers.

I don't think that any of the today's upstream kernel coupled-regulator
users really need to support the case where a regulator couple is
allowed *not* to have active consumers, so for now it should be fine to
change the core code to accommodate the needs of the Exynos regulators
(IMO). We may get back to this later on once there will be a real need
support that case.

Please also note that I'm assuming that each of the coupled regulators
doesn't have more than one consumer at a time in yours case (correct?),
because yours solution won't work well in a case of multiple consumers.
There is no universal solution for this bootstrapping problem yet.

> +	return regulator_do_balance_voltage(rdev, state, skip_coupled);
> +}
> +
> +static int exynos_coupler_attach(struct regulator_coupler *coupler,
> +				 struct regulator_dev *rdev)
> +{
> +	return 0;
> +}
> +
> +static struct regulator_coupler exynos_coupler = {
> +	.attach_regulator = exynos_coupler_attach,
> +	.balance_voltage  = exynos_coupler_balance_voltage,
> +};
> +
> +static int __init exynos_coupler_init(void)
> +{
> +	if (!of_machine_is_compatible("samsung,exynos5800"))
> +		return 0;
> +
> +	return regulator_coupler_register(&exynos_coupler);
> +}
> +arch_initcall(exynos_coupler_init);
> 

