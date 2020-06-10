Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6FA1F4E88
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 09:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgFJHIS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 03:08:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38533 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFJHIR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 03:08:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id f185so759030wmf.3;
        Wed, 10 Jun 2020 00:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pIboXiBNWiMULL8eXRx9gTkIJIwYM1rDqzDNKi/WCMI=;
        b=pxMH+GjQ3Svlgg1CSg4JwXyCv7/TJ476KQ9b7ZLkSl7SmTEOXcMZ6qZEzBr9CxO0XA
         Np78ZViDglusb/39EFc9AGY9EpJnGCi6FrYjZRYpUBJWCBhIN3UuA1045fBAoXLv2e12
         HFQK6TGkOrpGetAHMY9Z2/kQJSJRpSo4HfsIs/IW9vFFC3RkYlwO9n22hl9QLT4m01Iy
         wCuU55M6gWWOX3f7RpiQddOrk1NllZBdYROEFYqBFOE2wF+CJylKKGQbEDCnxBPlR8P8
         eOa6sX7k6V0Vug5k/0ZrgdKHtA79O+cg7Cd6K1T2Be1wjzsjceHX7GZH+F4NGBexnuir
         xfOg==
X-Gm-Message-State: AOAM530en6/opRPi/kYdTH+uVKFQsNbLPkudiwnjvZzta7BsyqY9Gkru
        2Le9vWq5KiVb4I7eDJdKYq0dygvc
X-Google-Smtp-Source: ABdhPJwrMnGJri6WkunRR2KgGl3xcAmRCy2ERHsXiNkk8V0805xNmt7Q7fep/tChWBgyvtvF4QPj3g==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr1674338wmc.124.1591772894737;
        Wed, 10 Jun 2020 00:08:14 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id z2sm6491879wrs.87.2020.06.10.00.08.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 00:08:13 -0700 (PDT)
Date:   Wed, 10 Jun 2020 09:08:11 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v3] soc: samsung: Add simple voltage coupler for
 Exynos5800
Message-ID: <20200610070811.GB3716@kozik-lap>
References: <CGME20200609104230eucas1p2efc14b59c4ccdcb839b54a62fbd8a31c@eucas1p2.samsung.com>
 <20200609104221.21243-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200609104221.21243-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 09, 2020 at 12:42:21PM +0200, Marek Szyprowski wrote:
> Add a simple custom voltage regulator coupler for Exynos5800 SoCs, which
> require coupling between "vdd_arm" and "vdd_int" regulators. This coupler
> ensures that the voltage values don't go below the bootloader-selected
> operation point during the boot process until a the clients sets their
> constraints. It is achieved by assuming minimal voltage value equal to
> the current value if no constraints are set. This also ensures proper
> voltage balancing if any of the client driver is missing.
> 
> The balancing code comes from regulator core.c with the 

You cut the sentence.

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
> + * The main difference is that it keeps current regulator voltage
> + * if consumers didn't apply their contraints yet.
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

Add a sanity check at beginning that you have enough of bits for this...
or use bitmap.

Best regards,
Krzysztof

