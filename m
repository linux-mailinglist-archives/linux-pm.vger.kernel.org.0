Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B1E1F3D9B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 16:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgFIOHt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgFIOHs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 10:07:48 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E424C05BD1E;
        Tue,  9 Jun 2020 07:07:47 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x22so12588666lfd.4;
        Tue, 09 Jun 2020 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wxlUC47mBiAj2KazrQRk0ZOPTudYA0Zuw2dUBmXJP/M=;
        b=d2hgC+ptjckByl9lFqMKN7zMtiofOgxz+Q/1e+mD94QxBUXrcRJuxxLpP0VBmiC1or
         +uDYUvuvNrq5cT0Hoxhzfaw4YplDk3kGfhT9/OyogPZCrFWYkNAYMOZbdCGD2moHX0Nx
         BBxHFeTIoMu73vIGvLoe73VRujwvLzuz7x5w9R0n4+1Gt+lm7mxM2IdU/D9BLEuV/2TP
         MfdvKA6W4CPZjDRlS7DuViUEsjtaNWeEPHp/IwZ/jaJ6Vc71Ds/9fj5Kx7Rl2iOLj8h4
         WhzjI9296qk1xxynyBWmq+RqxF/TSazN3PdO4q4KLq7guQVLvL/7TTiLfJux32wazpic
         5mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wxlUC47mBiAj2KazrQRk0ZOPTudYA0Zuw2dUBmXJP/M=;
        b=McCZEih2Uf9MQ6I1KetVVddtXq6UIoVtMrpiU4vqWpmvsr03H1XJR3AxHfP5tMN7BS
         yc+IJ4Mgn1XOuTUe92FxT/XWmqNQfiKSEOf2JjqjocwlG7Cz/gaoNOXoSlEXMab+LCL5
         FnvqqD03kCzCPqQl9mGdF/hAbq6aRbLvHXXTRb1gFXStI+FguAecw1uxL48z6YDJEH+4
         /WQ2oTOysvuxxWGM2gWPH2L/XSZFkbs3TfKjaDHH7TURmuTiQGLAv9a0QDISXA4o5QuG
         Sc15EoRIARRy6zblhndJYlbC4770mrIPv50zYigoJnEzSvhcqYXmNneNeS9GPBwNZUFm
         3KDA==
X-Gm-Message-State: AOAM533xMIdMdk/+wDtBKdw7VTX60XPUpADkJXKagTIesnoE0Sz7sjyR
        Hn8TUAY2FLaAts6zbaovPMw=
X-Google-Smtp-Source: ABdhPJxY0/wPtyTxxKKV2kIBQt6lh/b2z8i0MpsPSuGj75pIEKAe7xDzg2Ey3heRmK9/oignDZvfIw==
X-Received: by 2002:ac2:4567:: with SMTP id k7mr15515623lfm.122.1591711665891;
        Tue, 09 Jun 2020 07:07:45 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id y17sm5078623lfa.77.2020.06.09.07.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 07:07:43 -0700 (PDT)
Subject: Re: [PATCH v3] soc: samsung: Add simple voltage coupler for
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
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
References: <CGME20200609104230eucas1p2efc14b59c4ccdcb839b54a62fbd8a31c@eucas1p2.samsung.com>
 <20200609104221.21243-1-m.szyprowski@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <682662fa-d848-f51b-fad7-cb56af9f1a1c@gmail.com>
Date:   Tue, 9 Jun 2020 17:07:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200609104221.21243-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.06.2020 13:42, Marek Szyprowski пишет:
> Add a simple custom voltage regulator coupler for Exynos5800 SoCs, which
> require coupling between "vdd_arm" and "vdd_int" regulators. This coupler
> ensures that the voltage values don't go below the bootloader-selected
> operation point during the boot process until a the clients sets their
> constraints. It is achieved by assuming minimal voltage value equal to
> the current value if no constraints are set. This also ensures proper
> voltage balancing if any of the client driver is missing.
> 
> The balancing code comes from regulator core.c with the 
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This patch is yet another attempt to fix the regulator coupling on
> Exynos5800/5422 SoCs. Here are links to the previous attempts and
> discussions:
> 
> https://lore.kernel.org/linux-samsung-soc/20191008101709.qVNy8eijBi0LynOteWFMnTg4GUwKG599n6OyYoX1Abs@z/
> https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/
> https://lore.kernel.org/linux-pm/cover.1589528491.git.viresh.kumar@linaro.org/
> https://lore.kernel.org/linux-pm/20200528131130.17984-1-m.szyprowski@samsung.com/
> https://lore.kernel.org/linux-samsung-soc/57cf3a15-5d9b-7636-4c69-60742e8cfae6@samsung.com/
> https://lore.kernel.org/lkml/20200605063724.9030-1-m.szyprowski@samsung.com/
> 
> The problem is with "vdd_int" regulator coupled with "vdd_arm" on Odroid
> XU3/XU4 boards family. "vdd_arm" is handled by CPUfreq. "vdd_int" is
> handled by devfreq. CPUfreq initialized quite early during boot and it
> starts changing OPPs and "vdd_arm" value. Sometimes CPU activity during
> boot goes down and some low-frequency OPPs are selected, what in turn
> causes lowering "vdd_arm". This happens before devfreq applies its
> requirements on "vdd_int". Regulator balancing code reduces "vdd_arm"
> voltage value, what in turn causes lowering "vdd_int" value to the lowest
> possible value. This is much below the operation point of the wcore bus,
> which still runs at the highest frequency.
> 
> The issue was hard to notice because in the most cases the board managed
> to boot properly, even when the regulator was set to lowest value allowed
> by the regulator constraints. However, it caused some random issues,
> which can be observed as "Unhandled prefetch abort" or low USB stability.
> 
> Handling this case in the generic code has been rejected, so the only way
> to ensure the desired behavior on Exynos5800-based SoCs is to make a
> custom regulator coupler driver. I've tried hard to extract some common
> code to simplify the exynos-regulator-coupler driver as much as possible,
> but the difference between it and the generic code is so deep that this
> approach failed, so indead I simply copied and modified the balancing
> code.
> 
> Best regards
> Marek Szyprowski
> ---
>  arch/arm/mach-exynos/Kconfig                  |   1 +
>  drivers/soc/samsung/Kconfig                   |   3 +
>  drivers/soc/samsung/Makefile                  |   1 +
>  .../soc/samsung/exynos-regulator-coupler.c    | 221 ++++++++++++++++++
>  4 files changed, 226 insertions(+)
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
> index 19c4d3f1437b..5d7819b52eed 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -43,4 +43,7 @@ config EXYNOS_PM_DOMAINS
>  	bool "Exynos PM domains" if COMPILE_TEST
>  	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
>  
> +config EXYNOS_REGULATOR_COUPLER
> +	bool "Exynos SoC Regulator Coupler" if COMPILE_TEST
> +	depends on ARCH_EXYNOS || COMPILE_TEST
>  endif
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 31db65cb7aa3..93285faec416 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
>  					exynos5250-pmu.o exynos5420-pmu.o
>  obj-$(CONFIG_EXYNOS_PMU_ARM64_DRIVERS)	+= exynos-pm.o exynos5433-pmu.o
>  obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
> +obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
> diff --git a/drivers/soc/samsung/exynos-regulator-coupler.c b/drivers/soc/samsung/exynos-regulator-coupler.c
> new file mode 100644
> index 000000000000..3cafc1738eb6
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-regulator-coupler.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *	      http://www.samsung.com/
> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
> + *
> + * Simplified generic volatage coupler from regulator core.c

typo voltage -------------^

> + * The main difference is that it keeps current regulator voltage
> + * if consumers didn't apply their contraints yet.

typo conStraints ------------------------^

> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/regulator/coupler.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +
> +static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
> +					 int *current_uV,
> +					 int *min_uV, int *max_uV,
> +					 suspend_state_t state)
> +{
> +	struct coupling_desc *c_desc = &rdev->coupling_desc;
> +	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
> +	struct regulation_constraints *constraints = rdev->constraints;
> +	int desired_min_uV = 0, desired_max_uV = INT_MAX;
> +	int max_current_uV = 0, min_current_uV = INT_MAX;
> +	int highest_min_uV = 0, target_uV, possible_uV;
> +	int i, ret, max_spread, n_coupled = c_desc->n_coupled;
> +	bool done;
> +
> +	*current_uV = -1;
> +
> +	/* Find highest min desired voltage */
> +	for (i = 0; i < n_coupled; i++) {
> +		int tmp_min = 0;
> +		int tmp_max = INT_MAX;
> +
> +		lockdep_assert_held_once(&c_rdevs[i]->mutex.base);
> +
> +		ret = regulator_check_consumers(c_rdevs[i],
> +						&tmp_min,
> +						&tmp_max, state);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (tmp_min == 0) {
> +			ret = regulator_get_voltage_rdev(c_rdevs[i]);
> +			if (ret < 0)
> +				return ret;
> +			tmp_min = ret;
> +		}
> +
> +		/* apply constraints */
> +		ret = regulator_check_voltage(c_rdevs[i], &tmp_min, &tmp_max);
> +		if (ret < 0)
> +			return ret;
> +
> +		highest_min_uV = max(highest_min_uV, tmp_min);
> +
> +		if (i == 0) {
> +			desired_min_uV = tmp_min;
> +			desired_max_uV = tmp_max;
> +		}
> +	}
> +
> +	max_spread = constraints->max_spread[0];
> +
> +	/*
> +	 * Let target_uV be equal to the desired one if possible.
> +	 * If not, set it to minimum voltage, allowed by other coupled
> +	 * regulators.
> +	 */
> +	target_uV = max(desired_min_uV, highest_min_uV - max_spread);
> +
> +	/*
> +	 * Find min and max voltages, which currently aren't violating
> +	 * max_spread.
> +	 */
> +	for (i = 1; i < n_coupled; i++) {
> +		int tmp_act;
> +
> +		tmp_act = regulator_get_voltage_rdev(c_rdevs[i]);
> +		if (tmp_act < 0)
> +			return tmp_act;
> +
> +		min_current_uV = min(tmp_act, min_current_uV);
> +		max_current_uV = max(tmp_act, max_current_uV);
> +	}
> +
> +	/*
> +	 * Correct target voltage, so as it currently isn't
> +	 * violating max_spread
> +	 */
> +	possible_uV = max(target_uV, max_current_uV - max_spread);
> +	possible_uV = min(possible_uV, min_current_uV + max_spread);
> +
> +	if (possible_uV > desired_max_uV)
> +		return -EINVAL;
> +
> +	done = (possible_uV == target_uV);
> +	desired_min_uV = possible_uV;
> +
> +	/* Set current_uV if wasn't done earlier in the code and if necessary */
> +	if (*current_uV == -1) {
> +		ret = regulator_get_voltage_rdev(rdev);
> +		if (ret < 0)
> +			return ret;
> +		*current_uV = ret;
> +	}
> +
> +	*min_uV = desired_min_uV;
> +	*max_uV = desired_max_uV;
> +
> +	return done;
> +}
> +
> +static int exynos_coupler_balance_voltage(struct regulator_coupler *coupler,
> +					  struct regulator_dev *rdev,
> +					  suspend_state_t state)
> +{
> +	struct regulator_dev **c_rdevs;
> +	struct regulator_dev *best_rdev;
> +	struct coupling_desc *c_desc = &rdev->coupling_desc;
> +	int i, ret, n_coupled, best_min_uV, best_max_uV, best_c_rdev;
> +	unsigned int delta, best_delta;
> +	unsigned long c_rdev_done = 0;
> +	bool best_c_rdev_done;
> +
> +	c_rdevs = c_desc->coupled_rdevs;
> +	n_coupled = c_desc->n_coupled;
> +
> +	/*
> +	 * Find the best possible voltage change on each loop. Leave the loop
> +	 * if there isn't any possible change.
> +	 */
> +	do {
> +		best_c_rdev_done = false;
> +		best_delta = 0;
> +		best_min_uV = 0;
> +		best_max_uV = 0;
> +		best_c_rdev = 0;
> +		best_rdev = NULL;
> +
> +		/*
> +		 * Find highest difference between optimal voltage
> +		 * and current voltage.
> +		 */
> +		for (i = 0; i < n_coupled; i++) {
> +			/*
> +			 * optimal_uV is the best voltage that can be set for
> +			 * i-th regulator at the moment without violating
> +			 * max_spread constraint in order to balance
> +			 * the coupled voltages.
> +			 */
> +			int optimal_uV = 0, optimal_max_uV = 0, current_uV = 0;
> +
> +			if (test_bit(i, &c_rdev_done))
> +				continue;
> +
> +			ret = regulator_get_optimal_voltage(c_rdevs[i],
> +							    &current_uV,
> +							    &optimal_uV,
> +							    &optimal_max_uV,
> +							    state);
> +			if (ret < 0)
> +				goto out;
> +
> +			delta = abs(optimal_uV - current_uV);
> +
> +			if (delta && best_delta <= delta) {
> +				best_c_rdev_done = ret;
> +				best_delta = delta;
> +				best_rdev = c_rdevs[i];
> +				best_min_uV = optimal_uV;
> +				best_max_uV = optimal_max_uV;
> +				best_c_rdev = i;
> +			}
> +		}
> +
> +		/* Nothing to change, return successfully */
> +		if (!best_rdev) {
> +			ret = 0;
> +			goto out;
> +		}
> +
> +		ret = regulator_set_voltage_rdev(best_rdev, best_min_uV,
> +						 best_max_uV, state);
> +
> +		if (ret < 0)
> +			goto out;
> +
> +		if (best_c_rdev_done)
> +			set_bit(best_c_rdev, &c_rdev_done);
> +
> +	} while (n_coupled > 1);
> +
> +out:
> +	return ret;
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

The code looks good to me.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
