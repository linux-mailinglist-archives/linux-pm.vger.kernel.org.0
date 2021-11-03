Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23E444414
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 15:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhKCPBl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 11:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhKCPBk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Nov 2021 11:01:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04207C061714
        for <linux-pm@vger.kernel.org>; Wed,  3 Nov 2021 07:59:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b12so4042083wrh.4
        for <linux-pm@vger.kernel.org>; Wed, 03 Nov 2021 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z341AuUcls1B+L6HF5Zlv2ysRhkCMV+GR40de1E9pMg=;
        b=iCFOxXksP+MymhPptVS8q1VzIadmuVoA39Anwc9jHe/fIZfdJPdYccI7Fwvl0gWb9k
         x6BRB//iMv0GJmHxX/hP3bsuBKdFXoj1hjDF9y9rXQJ++PzZawfFbycPNs0q2bAdKyTZ
         TWjotSyTnZRggJqyNLjijaRON3fLHeIhqtp2e54+B4jxxkbeQPfAd9SbVuUsLEyRn54E
         BRzpecOy2YqaOdaEimCmMuggWLte1qKTlP0SqSN43QipZ/HC8n+XAv9CDfKAz4WBgb0l
         J0CtPO4hDXaxkzvLdHeypf4tKAJNGsV+SjLhamIz5dqzrkL95LTo5KXkA2P5UUIUDCtV
         5zOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z341AuUcls1B+L6HF5Zlv2ysRhkCMV+GR40de1E9pMg=;
        b=pZcXT66amiKcJB1QmqvwK/4FCSLTXZ6MBIn2kBbzd2WQzbn+2iic41PItj6asXTSnD
         jzhV8kCwBAFL8RKhNHbf6+XAWkj7iUx52LrvHIw7heOqPxhhiBjp08TY9K2Soqflgeli
         9FyBbMC37qpz734mnnDV6A2gS8BZw/olnULf/siw9R8nAHly2TErsUkmAgskTzz2Ai2h
         iZb01T+U9SPBdHTmEmHuHiqPocHttD5vqKDbcWG1PVYE6ABe+Ty05NSp6t/JLlLp/M98
         6YI8dtwjG6/vQZbmKlb3vSzvgX/tZIns94Jjc/IRtbZ15L5xSnh8MDeus/7UOfmLT/kF
         xUHw==
X-Gm-Message-State: AOAM5333BPur2UHZwDUPajw28xEMTksaHWak1qq2vSxkDOd6H51Lfuns
        XPw5UL08tWO+kDx2H8fW/7Gh0w==
X-Google-Smtp-Source: ABdhPJy3hqgxy+bnKoMiJ9dhH3YLFxmV0k2UeGutEwEeFcxog04FawmUCruohBdUg11VgdDIVaMgkA==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr53424139wrw.434.1635951542095;
        Wed, 03 Nov 2021 07:59:02 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:aaa0:cb1f:c758:aafc? ([2a01:e34:ed2f:f020:aaa0:cb1f:c758:aafc])
        by smtp.googlemail.com with ESMTPSA id r10sm2207739wrl.92.2021.11.03.07.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 07:59:01 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: k3_j72xx_bandgap: Add the bandgap driver
 support
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, kristo@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211103091924.32742-1-j-keerthy@ti.com>
 <20211103091924.32742-5-j-keerthy@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0ba6de7a-2cf0-a5c3-3029-4a684681065a@linaro.org>
Date:   Wed, 3 Nov 2021 15:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211103091924.32742-5-j-keerthy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/11/2021 10:19, Keerthy wrote:
> Add VTM thermal support. In the Voltage Thermal Management
> Module(VTM), K3 J72XX supplies a voltage reference and a temperature
> sensor feature that are gathered in the band gap voltage and
> temperature sensor (VBGAPTS) module. The band gap provides current and
> voltage reference for its internal circuits and other analog IP
> blocks. The analog-to-digital converter (ADC) produces an output value
> that is proportional to the silicon temperature.
> 
> Currently reading temperatures only is supported.  There are no
> active/passive cooling agent supported.
> 
> J721e SoCs have errata i2128: https://www.ti.com/lit/pdf/sprz455
> 
> The VTM Temperature Monitors (TEMPSENSORs) are trimmed during production,
> with the resulting values stored in software-readable registers. Software
> should use these  register values when translating the Temperature
> Monitor output codes to temperature values.
> 
> It has an involved workaround. Software needs to read the error codes for
> -40C, 30C, 125C from the efuse for each device & derive a new look up table
> for adc to temperature conversion. Involved calculating slopes & constants
> using 3 different straight line equations with adc refernce codes as the
> y-axis & error codes in the x-axis.
> 
> -40C to 30C
> 30C to 125C
> 125C to 150C
> 
> With the above 2 line equations we derive the full look-up table to
> workaround the errata i2128 for j721e SoC.
> 
> Tested temperature reading on J721e SoC & J7200 SoC.

I made a bunch of comments, but this driver needs some reworking to be
simplified.

The driver is very similar to the k3_bandgap.c and we found exactly the
same table+3values-avg approach. After simplifying this driver, it
should merge easily with k3_bandgap.c.

> [daniel.lezcano@linaro.org: Generate look-up tables run-time]
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v4:
> 
>   * Fixed warnings with w=1 during compilation.
> 
> Changes in v3:
> 
>   * Removed static look up tables & added functions to dynamically generate them.
>     Thanks Daniel! Saved 12KB of static data & almost 200 lines of driver code.
> 
> 
>  drivers/thermal/Makefile           |   2 +-
>  drivers/thermal/k3_j72xx_bandgap.c | 634 +++++++++++++++++++++++++++++
>  2 files changed, 635 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/thermal/k3_j72xx_bandgap.c
> 
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 82fc3e616e54..6dcaf2028ddc 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -28,7 +28,7 @@ thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
>  # devfreq cooling
>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>  
> -obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o
> +obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o k3_j72xx_bandgap.o
>  # platform thermal drivers
>  obj-y				+= broadcom/
>  obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
> new file mode 100644
> index 000000000000..3d3786f5058d
> --- /dev/null
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -0,0 +1,634 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI Bandgap temperature sensor driver for J72XX SoC Family
> + *
> + * Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +#include <linux/spinlock.h>
> +#include <linux/of_platform.h>
> +#include <linux/io.h>
> +#include <linux/thermal.h>
> +#include <linux/of.h>
> +#include <linux/delay.h>
> +#include <linux/math.h>
> +#include <linux/slab.h>
> +
> +#define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
> +#define K3_VTM_DEVINFO_PWR0_CVD_CT_MASK		0xf
> +#define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
> +#define K3_VTM_TMPSENS0_CTRL_OFFSET		0x300
> +#define K3_VTM_MISC_CTRL_OFFSET			0xc
> +#define K3_VTM_TMPSENS_STAT_OFFSET		0x8
> +#define K3_VTM_ANYMAXT_OUTRG_ALERT_EN		0x1
> +#define K3_VTM_MISC_CTRL2_OFFSET		0x10
> +#define K3_VTM_REGS_PER_TS			0x10
> +#define K3_VTM_TS_STAT_DTEMP_MASK		0x3ff
> +#define K3_VTM_MAX_NUM_TS			8
> +#define K3_VTM_TMPSENS_CTRL_CBIASSEL		BIT(0)
> +#define K3_VTM_TMPSENS_CTRL_SOC			BIT(5)
> +#define K3_VTM_TMPSENS_CTRL_CLRZ		BIT(6)
> +#define K3_VTM_TMPSENS_CTRL_CLKON_REQ		BIT(7)
> +#define K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN	BIT(11)
> +
> +#define K3_VTM_CORRECTION_TEMP_CNT		3
> +
> +#define K3_VTM_ADC_BEGIN_VAL			6
> +#define K3_VTM_ADC_END_VAL			944
> +
> +#define MINUS40CREF				5
> +#define PLUS30CREF				253
> +#define PLUS125CREF				730
> +#define PLUS150CREF				940
> +
> +#define MAX_TEMP				123000
> +#define COOL_DOWN_TEMP				105000
> +
> +//#define DEBUG_VTM

I suggest to remove DEBUG_VTM and replace the dev_info by dev_dbg in the
print lookup table. There are also messages to reduce the verbosity
level to debug (commented inline).

> +
> +static int *ref_table;
> +static int *derived_table;

These tables could be passed around via function parameters and their
life cycle is just during the probe. No need to declare them globally.

> +
> +s64 golden_factors[] = {
> +	-490019999999999936,
> +	3251200000000000,
> +	-1705800000000,
> +	603730000,
> +	-92627,
> +};
> +
> +s64 pvt_wa_factors[] = {
> +	-415230000000000000,
> +	3126600000000000,
> +	-1157800000000,
> +};
> +
> +static s64 int_power(unsigned long long base, unsigned int exp)
> +{
> +	s64 result = 1;
> +
> +	while (exp) {
> +		if (exp & 1)
> +			result *= base;
> +		exp >>= 1;
> +		base *= base;
> +	}
> +
> +	return result;
> +}

This function is already implemented.

include/linux/math.h:u64 int_pow(u64 base, unsigned int exp);

> +static int compute_value(int index, s64 *factors, int nr_factors, int reduction)
> +{
> +	s64 value = 0;
> +	int i;
> +
> +	for (i = 0; i < nr_factors; i++)
> +		value += factors[i] * int_power(index, i);
> +
> +	return (int)(value / int_power(10, reduction));
> +}
> +
> +static void init_table(bool wa, int *mytable)

s/mytable/table/

Instead of passing a boolean, let the caller pass the right parameters,
that makes the code nicer.

static void init_table(int *table, int size, s64 *factors, int nr_factors)
{
	int i;

	for (i = 0; i < size; i++)
		table[i] = polynomial(factors, nr_factors,
					FACTORS_REDUCTION);
}

> +{
> +	s64 *factors;
> +	const int size = 1024;
> +	int factors_size;
> +	int i;
> +
> +	if (wa) {
> +		factors_size = 3;
> +		factors = pvt_wa_factors;
> +	} else {
> +		factors_size = 5;
> +		factors = golden_factors;
> +	}
> +
> +	for (i = 0; i < size; i++)
> +		mytable[i] = compute_value(i, factors, factors_size, 13);
> +}
> +
> +static void fill_table(int err1, int err2, int ref1, int ref2, int idx1,
> +		       int idx2)

I suggest to create a self explanatory structure and pass a couple of
them as parameter with the derived and ref tables.

Given what does this function, it would make sense rename it to
something more explicit along with a short explanation of why this is
needed.

> +{
> +	int m, c, num, den, i, err;
> +
> +	/**

'/**' is for kernel documentation, should be replaced by /*

> +	 * Calculate the slope with adc values read from the register
> +	 * as the y-axis param and err in adc value as x-axis param
> +	 */
> +	if (err1 != err2) {
> +		num = ref2 - ref1;
> +		den = err2 - err1;
> +		m = num / den;

	if den > num then 'm' is zero and err = (i - c) / m will crash
	if ref1 and ref2 are equal, 'm' will be zero also

> +		c = ref2 - m * err2;
> +		for (i = idx1; i <= idx2; i++) {
> +			err = (i - c) / m;
> +			if (((i + err1) < 0) || ((i + err1) > 1023))
> +				continue;
> +			derived_table[i] = ref_table[i + err];
> +		}
> +	} else { /* Constant error take care of divide by zero */
> +		for (i = idx1; i < idx2; i++) {

		Why the first loop has i<=idx2 and this one is i<idx2 ?

> +			if (((i + err1) < 0) || ((i + err1) > 1023))
> +				continue;
> +			derived_table[i] = ref_table[i + err1];
> +		}

Can be this loop put outside of the if the else ?

> +	}
> +}
> +
> +static int prep_lookup_table(int minus40cerr, int plus30cerr, int plus125cerr,
> +			     int plus150cerr)
> +{
> +	int inc, i;
> +
> +	/* Fill up the lookup table region -40C to +30C */
> +	fill_table(minus40cerr, plus30cerr, MINUS40CREF, PLUS30CREF, 0,
> +		   PLUS30CREF);
> +	/* Fill up the lookup table region +30C to +125C */
> +	fill_table(plus30cerr, plus125cerr, PLUS30CREF, PLUS125CREF, PLUS30CREF,
> +		   PLUS125CREF);
> +	/* Fill up the lookup table region +125C to +150C */
> +	fill_table(plus125cerr, plus150cerr, PLUS125CREF, PLUS150CREF, PLUS125CREF,
> +		   PLUS150CREF);
> +
> +	/* Get to the first valid temperature */
> +	i = 0;
> +	while (!derived_table[i])
> +		i++;

	zero is not a valid temperature ?

> +
> +	/*
> +	 * Get to the last zero index and back fill the temperature for
> +	 * sake of continuity
> +	 */
> +	if (i) {
> +		/* 300 milli celsius steps */
> +		while (i--)
> +			derived_table[i] = derived_table[i + 1] - 300;
> +		/* case 0 */
> +		derived_table[i] = derived_table[i + 1] - 300;
> +	}
> +
> +	/*
> +	 * Fill the last trailing 0s which are unfilled with increments of
> +	 * 100 milli celsius till 1023 code
> +	 */
> +	i = 1023;

Please, give the table and const table size in parameters.

> +	while (!derived_table[i])
> +		i--;
> +
> +	i++;
> +	inc = 1;
> +	while (i < 1024) {
> +		derived_table[i] = derived_table[i - 1] + inc * 100;
> +		i++;
> +	}

Can you explain why the above is done ?

> +	return 0;
> +}
> +
> +struct k3_thermal_data;
not necessary

Below, "not necessary" == the field is assigned but then never used,
"not used" == the field is never used at all.

> +struct k3_j72xx_bandgap {
> +	struct device *dev;

	not necessary

> +	void __iomem *base;
> +	void __iomem *cfg2_base;
> +	void __iomem *fuse_base;
> +	const struct k3_j72xx_bandgap_data	*conf;
> +	spinlock_t lock; /* shields this struct */

	not used

> +	int ts_cnt;

	not used

> +	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];

	not used
> +};
> +
> +/* common data structures */
> +struct k3_thermal_data {
> +	struct thermal_zone_device *ti_thermal;

	not necessary

> +	struct thermal_cooling_device *cool_dev;

	not used

> +	struct k3_j72xx_bandgap *bgp;
> +	enum thermal_device_mode mode;

	not used

> +	int sensor_id;

	not used

> +	u32 ctrl_offset;
> +	u32 stat_offset;
> +	int prev_temp;

	not necessary

> +	int ct_offsets[K3_VTM_CORRECTION_TEMP_CNT];
> +	int ct_bm[K3_VTM_CORRECTION_TEMP_CNT];

	Both are only local to the function using it

> +	int ref_adc_val[3];

	not used

> +	int act_adc_val[3];

	not used

> +	int slope[2];

	not used

> +	int coeff[2];

	not used

> +};
> +
> +static int two_cmp(int tmp, int mask)
> +{
> +	tmp = ~(tmp);
> +	tmp &= mask;
> +	tmp += 1;
> +
> +	/* Return negative value */
> +	return (0 - tmp);
> +}

Can you explain ?

> +
> +static unsigned int vtm_get_best_value(unsigned int s0, unsigned int s1,
> +				       unsigned int s2)
> +{
> +	int d01 = abs(s0 - s1);
> +	int d02 = abs(s0 - s2);
> +	int d12 = abs(s1 - s2);
> +
> +	if (d01 <= d02 && d01 <= d12)
> +		return (s0 + s1) / 2;
> +
> +	if (d02 <= d01 && d02 <= d12)
> +		return (s0 + s2) / 2;
> +
> +	return (s1 + s2) / 2;
> +}
> +
> +static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
> +				   int *temp)
> +{
> +	struct k3_j72xx_bandgap *bgp;
> +	unsigned int dtemp, s0, s1, s2;
> +
> +	bgp = devdata->bgp;
> +	/*
> +	 * Errata is applicable for am654 pg 1.0 silicon/J7ES. There
> +	 * is a variation of the order for certain degree centigrade on AM654.
> +	 * Work around that by getting the average of two closest
> +	 * readings out of three readings everytime we want to
> +	 * report temperatures.
> +	 *
> +	 * Errata workaround.
> +	 */
> +	s0 = readl(bgp->base + devdata->stat_offset) &
> +		K3_VTM_TS_STAT_DTEMP_MASK;
> +	s1 = readl(bgp->base + devdata->stat_offset) &
> +		K3_VTM_TS_STAT_DTEMP_MASK;
> +	s2 = readl(bgp->base + devdata->stat_offset) &
> +		K3_VTM_TS_STAT_DTEMP_MASK;
> +	dtemp = vtm_get_best_value(s0, s1, s2);
> +
> +	if (dtemp < 0 || dtemp > 1023)
> +		return -EINVAL;
> +
> +	*temp = derived_table[dtemp];
> +
> +	return 0;
> +}
> +
> +/* Get temperature callback function for thermal zone */
> +static int k3_thermal_get_temp(void *devdata, int *temp)
> +{
> +	struct k3_thermal_data *data = devdata;
> +	int ret = 0;
> +
> +	ret = k3_bgp_read_temp(data, temp);
> +	if (ret)
> +		return ret;
> +
> +	data->prev_temp = *temp;

	where is it used ?

> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
> +	.get_temp = k3_thermal_get_temp,
> +};
> +
> +static int k3_j72xx_bandgap_temp_to_adc_code(int temp)
> +{
> +	int low = 0, high = 1023, mid;
> +
> +	if (temp > 160000 || temp < -50000)
> +		return -EINVAL;

How the caller does the difference between a negative temperature and
this error ?

> +	/* Binary search to find the adc code */
> +	while (low < (high - 1)) {
> +		mid = (low + high) / 2;
> +		if (temp <= derived_table[mid])
> +			high = mid;
> +		else
> +			low = mid;
> +	}
> +
> +	return mid;
> +}
> +
> +static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
> +			     struct k3_j72xx_bandgap *bgp)
> +{
> +	int i, tmp, pow;
> +
> +	/* Populate efuse reg offsets & Bit masks for -40C, 30C, 125C */
> +	switch (id) {
> +	case 0:
> +		data->ct_offsets[0] = 0x0;
> +		data->ct_offsets[1] = 0x8;
> +		data->ct_offsets[2] = 0x4;
> +		data->ct_bm[0] = 0x3f;
> +		data->ct_bm[1] = 0x1fe000;
> +		data->ct_bm[2] = 0x1ff;
> +		break;
> +
> +	case 1:
> +		data->ct_offsets[0] = 0x0;
> +		data->ct_offsets[1] = 0x8;
> +		data->ct_offsets[2] = 0x4;
> +		data->ct_bm[0] = 0xfc0;
> +		data->ct_bm[1] = 0x1fe00000;
> +		data->ct_bm[2] = 0x3fe00;
> +		break;
> +
> +	case 2:
> +		data->ct_offsets[0] = 0x0;
> +		data->ct_offsets[1] = -1;
> +		data->ct_offsets[2] = 0x4;
> +		data->ct_bm[0] = 0x3f000;
> +		data->ct_bm[1] = 0x7f800000;
> +		data->ct_bm[2] = 0x7fc0000;
> +		break;
> +
> +	case 3:
> +		data->ct_offsets[0] = 0x0;
> +		data->ct_offsets[1] = 0xC;
> +		data->ct_offsets[2] = -1; /* Spread across 2 registers */
> +		data->ct_bm[0] = 0xfc0000;
> +		data->ct_bm[1] = 0x1fe0;
> +		data->ct_bm[2] = 0x1f800000;
> +		break;
> +
> +	case 4:
> +		data->ct_offsets[0] = 0x0;
> +		data->ct_offsets[1] = 0xc;
> +		data->ct_offsets[2] = 0x8;
> +		data->ct_bm[0] = 0x3f000000;
> +		data->ct_bm[1] = 0x1fe000;
> +		data->ct_bm[2] = 0x1ff0;
> +		break;
> +	}
> +
> +	for (i = 0; i < 3; i++) {
> +		/* Extract the offset value using bit-mask */
> +		if (data->ct_offsets[i] == -1 && i == 1) {
> +			/* 25C offset Case of Sensor 2 split between 2 regs */
> +			tmp = (readl(bgp->fuse_base + 0x8) & 0xE0000000) >> (29);
> +			tmp |= ((readl(bgp->fuse_base + 0xC) & 0x1F) << 3);
> +			pow = tmp & 0x80;
> +		} else if (data->ct_offsets[i] == -1 && i == 2) {
> +			/* 125C Case of Sensor 3 split between 2 regs */
> +			tmp = (readl(bgp->fuse_base + 0x4) & 0xF8000000) >> (27);
> +			tmp |= ((readl(bgp->fuse_base + 0x8) & 0xF) << 5);
> +			pow = tmp & 0x100;
> +		} else {
> +			tmp = readl(bgp->fuse_base + data->ct_offsets[i]);
> +			tmp &= data->ct_bm[i];
> +			tmp = tmp >> __ffs(data->ct_bm[i]);
> +
> +			/* Obtain the sign bit pow*/
> +			pow = data->ct_bm[i] >> __ffs(data->ct_bm[i]);
> +			pow += 1;
> +			pow /= 2;
> +		}
> +
> +		/* Check for negative value */
> +		if (tmp & pow) {
> +			/* 2's complement value */
> +			tmp = two_cmp(tmp, data->ct_bm[i] >> __ffs(data->ct_bm[i]));
> +		}
> +		err[i] = tmp;

Can you explain what is doing the code above ?

> +	}
> +}
> +
> +#ifdef DEBUG_VTM

Remove

> +static void print_look_up_table(struct device *dev)
> +{
> +	int i;
> +
> +	dev_info(dev, "The contents of derived array\n");
	
	dev_dbg

> +	dev_info(dev, "Code   Temperaturei\n");

	dev_dbg

> +	for (i = 0; i <= 1023; i++)
> +		dev_info(dev, "%d       %d\n", i, derived_table[i]);

	dev_dbg

> +}
> +#endif
> +
> +static const struct of_device_id of_k3_j72xx_bandgap_match[];
> +
> +struct k3_j72xx_bandgap_j72xx_data {

Fix name please

> +	unsigned int	workaround;

	s/workaround/has_errata_<num>/

> +};
> +
> +static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
> +{
> +	int ret = 0, cnt, val, id, reg_cnt = 0, j, table_size = 1024;
> +	int err[3], high_max, low_max;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct k3_j72xx_bandgap *bgp;
> +	struct k3_thermal_data *data;
> +	int workaround_needed = 0;
> +	const struct of_device_id *of_id;
> +	const struct k3_j72xx_bandgap_j72xx_data *driver_data;
> +
> +	bgp = devm_kzalloc(&pdev->dev, sizeof(*bgp), GFP_KERNEL);
> +	if (!bgp)
> +		return -ENOMEM;
> +
> +	bgp->dev = dev;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	bgp->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(bgp->base))
> +		return PTR_ERR(bgp->base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	bgp->cfg2_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(bgp->cfg2_base))
> +		return PTR_ERR(bgp->cfg2_base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	bgp->fuse_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(bgp->fuse_base))
> +		return PTR_ERR(bgp->fuse_base);
> +
> +	of_id = of_match_device(of_k3_j72xx_bandgap_match, &pdev->dev);
> +	if (of_id) {
> +		driver_data = of_id->data;
> +		workaround_needed = driver_data->workaround;
> +	}

of_device_get_match_data(dev) ?

> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		pm_runtime_disable(dev);
> +		return ret;
> +	}
> +
> +	/* Get the sensor count in the VTM */
> +	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
> +	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
> +	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
> +	bgp->ts_cnt = cnt;
> +
> +	data = devm_kcalloc(bgp->dev, cnt, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	ref_table = devm_kzalloc(bgp->dev, sizeof(*ref_table) * table_size,
> +				 GFP_KERNEL);
> +	if (!ref_table) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	derived_table = devm_kzalloc(bgp->dev, sizeof(*derived_table) * table_size,
> +				     GFP_KERNEL);
> +	if (!derived_table) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	/* Workaround not needed if bit30/bit31 is set even for J721e */
> +	if (workaround_needed && (readl(bgp->fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
> +		workaround_needed = false;

Does it mean the same hardware may have or not the errata? Is there a
way to distinguish them from the compatible string ?

> +
> +	if (!workaround_needed) {
> +		dev_info(bgp->dev, "work around NOT needed!!\n");
> +		init_table(false, ref_table);
> +	} else {
> +		dev_info(bgp->dev, "work around needed!!\n");
> +		init_table(true, ref_table);
> +	}

	dev_dbg(bgp->dev, "Work around %sneeded\n",
		workaround_needed ? "not " : "");

> +
> +	/* Register the thermal sensors */
> +	for (id = 0; id < cnt; id++) {
> +		data[id].sensor_id = id;
> +		data[id].bgp = bgp;
> +		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
> +		data[id].stat_offset = data[id].ctrl_offset +
> +					K3_VTM_TMPSENS_STAT_OFFSET;
> +
> +		if (!workaround_needed)
> +			goto prepare_lookup;

		if (workaround_needed) {

> +		/* ref adc values for -40C, 30C & 125C respectively */
> +		data[id].ref_adc_val[0] = MINUS40CREF;
> +		data[id].ref_adc_val[1] = PLUS30CREF;
> +		data[id].ref_adc_val[2] = PLUS125CREF;
> +		get_efuse_values(id, &data[id], err, bgp);

		}
> +
> +prepare_lookup:
> +		if (id == 0 && workaround_needed) {
> +			prep_lookup_table(err[0], err[1], err[2], 0);
> +		} else if (id == 0 && !workaround_needed) {
> +			for (j = 0; j < table_size; j++)
> +				derived_table[j] = ref_table[j];

		memcpy ?

> +		}
> +
> +		val = readl(data[id].bgp->cfg2_base + data[id].ctrl_offset);
> +		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
> +			K3_VTM_TMPSENS_CTRL_SOC |
> +			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
> +		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
> +
> +		bgp->ts_data[id] = &data[id];
> +		data[id].ti_thermal =
> +		devm_thermal_zone_of_sensor_register(bgp->dev, id,
> +						     &data[id],
> +						     &k3_of_thermal_ops);
> +		if (IS_ERR(data[id].ti_thermal)) {
> +			dev_err(bgp->dev, "thermal zone device is NULL\n");
> +			ret = PTR_ERR(data[id].ti_thermal);
> +			goto err_alloc;
> +		}
> +
> +		reg_cnt++;

		not used
> +
> +		/* Initialize Previous temp */
> +		k3_thermal_get_temp(&data[id], &data[id].prev_temp);

		why ? where is used prev_temp ?
> +	}
> +
> +	/*
> +	 * Program TSHUT thresholds
> +	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
> +	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
> +	 *         This is already taken care as per of init
> +	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
> +	 */
> +	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
> +	low_max = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);

I guess high_max is the hardware shutdown temperature, right ?

But what is low_max ?

> +	writel((low_max << 16) | high_max, data[0].bgp->cfg2_base +
> +	       K3_VTM_MISC_CTRL2_OFFSET);
> +	mdelay(100);
> +	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
> +	       K3_VTM_MISC_CTRL_OFFSET);
> +
> +	platform_set_drvdata(pdev, bgp);
> +
> +#ifdef DEBUG_VTM

Remove ifdef

> +	print_look_up_table(dev);
> +#endif
> +	/*
> +	 * Now that the derived_table has the appropriate look up values
> +	 * Free up the ref_table
> +	 */
> +	kfree(ref_table);
> +
> +	return 0;
> +
> +err_alloc:
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static int k3_j72xx_bandgap_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +const struct k3_j72xx_bandgap_j72xx_data k3_j72xx_bandgap_j721e_data = {
> +	.workaround = 1,
> +};
> +
> +const struct k3_j72xx_bandgap_j72xx_data k3_j72xx_bandgap_j7200_data = {
> +	.workaround = 0,
> +};
> +
> +static const struct of_device_id of_k3_j72xx_bandgap_match[] = {
> +	{
> +		.compatible = "ti,j721e-vtm",
> +		.data = (void *)&k3_j72xx_bandgap_j721e_data,
> +	},
> +	{
> +		.compatible = "ti,j7200-vtm",
> +		.data = (void *)&k3_j72xx_bandgap_j7200_data,
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, of_k3_j72xx_bandgap_match);
> +
> +static struct platform_driver k3_j72xx_bandgap_sensor_driver = {
> +	.probe = k3_j72xx_bandgap_probe,
> +	.remove = k3_j72xx_bandgap_remove,
> +	.driver = {
> +		.name = "k3-j72xx-soc-thermal",
> +		.of_match_table	= of_k3_j72xx_bandgap_match,
> +	},
> +};
> +
> +module_platform_driver(k3_j72xx_bandgap_sensor_driver);
> +
> +MODULE_DESCRIPTION("K3 bandgap temperature sensor driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
