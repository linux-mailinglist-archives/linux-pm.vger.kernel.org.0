Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19AC18B39A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 13:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgCSMjC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 08:39:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45559 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgCSMjB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 08:39:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id i9so2714690wrx.12
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L0AKlZw8UntYKVzMTqutbKsCxAsd3XJ1U3bdXFpkvmU=;
        b=SYnLxY1RxDnNL6LPhAb5OiacHZNT2W25Sm/fnqp8O6OPuLfpr5qgmmsKs+2hUIZP16
         yaJEu3WxA0JY+E/aldRNS1Ova80v8JuPVP/FmvxAa/8ObXcyWRzulSwme0kMazdnKQ6o
         CRaoHbmpRNVxAjcxiwmF6jDaHiz3pzQS9R2pvXqWWc6g/XYE9zQvMkR1F0muoUqqshUZ
         WRVkLsO1ZZpk7j+NDVcHByB17KG6QjItzvP7oE5lkDmWRc/luJwXGVUfzTEngDIC7kiY
         j05dGvCmZaRY0Aj5n7BKuWcisDZ2+Yr0GuNCb+7uxv1Rr8iKeXDl6zTjUTT8aNyXb0n0
         QSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L0AKlZw8UntYKVzMTqutbKsCxAsd3XJ1U3bdXFpkvmU=;
        b=PZO5NIXcGEuMR3up0vc8qi9numCjj5sM0xHz6ApRBDd8H93UgC3VBzits+IcImJ+t9
         cme3TMJJU5gtn8J+mvZnLDW2/vj/iY3CcGWsfFLTVqaM8suzHu8b9OBBqqp+xCPxfNaP
         mI5cMjGcMyKDBuOz60WNY+/UWgAclP0x8TQHzTIHYpLuE/g8GrALJgzffgVOv9rV9S43
         KVKt+A7ihIhNbfkeYisGkF1OikETBByTfSd0DSLPNDu0RA3MDZ+RYGS1oQ6D3SqrUBt9
         u+2sNoiqBZ7PFsb/2D6n3yxdmi2NxY3aURqY+pHQhVWa+Lkud6I2f7sESGAwW/6Y0RAw
         UwSQ==
X-Gm-Message-State: ANhLgQ2VcEIc+UoHuuYHfUJ6N7Aq02ZU67P5Fp2/wBB5vJ3yabPqMAOb
        TEyZI603BcPfN17TZdSwaxNwmYhmG+E=
X-Google-Smtp-Source: ADFU+vvmvVgelEhQ6HBacThuvfWp4yMcFF15tZEdZUahys7IUrzC4g692ZkSd48ByW68GoRzQpsFlA==
X-Received: by 2002:adf:b35e:: with SMTP id k30mr4012384wrd.362.1584621538277;
        Thu, 19 Mar 2020 05:38:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7? ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.googlemail.com with ESMTPSA id l13sm3260093wrm.57.2020.03.19.05.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 05:38:56 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 2/4] thermal: k3: Add support for bandgap
 sensors
To:     Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     amit.kucheria@verdurent.com, t-kristo@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com
References: <20200318083028.9984-1-j-keerthy@ti.com>
 <20200318083028.9984-3-j-keerthy@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ea3b34dc-42e3-0b10-4b89-faf2621a4ee2@linaro.org>
Date:   Thu, 19 Mar 2020 13:38:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318083028.9984-3-j-keerthy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/03/2020 09:30, Keerthy wrote:
> The bandgap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Currently reading temperatures and creating work to periodically
> read temperatures from the zones are supported.
> There are no active/passive cooling agent supported.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v4:
> 
>   * Fixed comments from Daniel to remove trend function.
>   * Mostly cleaned up all the unused variables.
>   * Driver from bool to tristate.
> 
>  drivers/thermal/Kconfig      |  11 ++
>  drivers/thermal/Makefile     |   1 +
>  drivers/thermal/k3_bandgap.c | 287 +++++++++++++++++++++++++++++++++++
>  3 files changed, 299 insertions(+)
>  create mode 100644 drivers/thermal/k3_bandgap.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5a05db5438d6..d848d9a3c4f1 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -251,6 +251,17 @@ config IMX_THERMAL
>  	  cpufreq is used as the cooling device to throttle CPUs when the
>  	  passive trip is crossed.
>  
> +config K3_THERMAL
> +	tristate "Texas Instruments K3 thermal support"
> +	depends on ARCH_K3 || COMPILE_TEST
> +	help
> +	  If you say yes here you get thermal support for the Texas Instruments
> +	  K3 SoC family. The current chip supported is:
> +	   - AM654
> +
> +	  This includes temperature reading functionality and also trend
> +	  computation.

trend is now removed :)

>  config MAX77620_THERMAL
>  	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
>  	depends on MFD_MAX77620
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 9fb88e26fb10..5ad6535139ae 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -28,6 +28,7 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
>  # devfreq cooling
>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>  
> +obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o
>  # platform thermal drivers
>  obj-y				+= broadcom/
>  obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
> diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
> new file mode 100644
> index 000000000000..d16e60335721
> --- /dev/null
> +++ b/drivers/thermal/k3_bandgap.c
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI Bandgap temperature sensor driver for K3 SoC Family
> + *
> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
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
> +#include <linux/workqueue.h>

Please check all the headers are needed, AFAICT workqueue.h and
spinlock.h are not.

> +#include <linux/thermal.h>
> +#include <linux/of.h>
> +
> +#define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
> +#define K3_VTM_DEVINFO_PWR0_CVD_CT_MASK	0xf
> +#define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
> +#define K3_VTM_TMPSENS0_CTRL_OFFSET	0x80
> +#define K3_VTM_REGS_PER_TS			0x10
> +#define K3_VTM_TS_STAT_DTEMP_MASK	0x3ff
> +#define K3_VTM_MAX_NUM_TS		8
> +#define K3_VTM_TMPSENS_CTRL_CBIASSEL	BIT(0)
> +#define K3_VTM_TMPSENS_CTRL_SOC		BIT(5)
> +#define K3_VTM_TMPSENS_CTRL_CLRZ		BIT(6)
> +#define K3_VTM_TMPSENS_CTRL_CLKON_REQ	BIT(7)
> +
> +#define K3_VTM_ADC_BEGIN_VAL		540
> +#define K3_VTM_ADC_END_VAL		944
> +
> +static const int k3_adc_to_temp[] = {
> +	-40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600, -38200,
> +	-37800, -37400, -37000, -36600, -36200, -35800, -35300, -34700, -34200,
> +	-33800, -33400, -33000, -32600, -32200, -31800, -31400, -31000, -30600,
> +	-30200, -29800, -29400, -29000, -28600, -28200, -27700, -27100, -26600,
> +	-26200, -25800, -25400, -25000, -24600, -24200, -23800, -23400, -23000,
> +	-22600, -22200, -21800, -21400, -21000, -20500, -19900, -19400, -19000,
> +	-18600, -18200, -17800, -17400, -17000, -16600, -16200, -15800, -15400,
> +	-15000, -14600, -14200, -13800, -13400, -13000, -12500, -11900, -11400,
> +	-11000, -10600, -10200, -9800, -9400, -9000, -8600, -8200, -7800, -7400,
> +	-7000, -6600, -6200, -5800, -5400, -5000, -4500, -3900, -3400, -3000,
> +	-2600, -2200, -1800, -1400, -1000, -600, -200, 200, 600, 1000, 1400,
> +	1800, 2200, 2600, 3000, 3400, 3900, 4500, 5000, 5400, 5800, 6200, 6600,
> +	7000, 7400, 7800, 8200, 8600, 9000, 9400, 9800, 10200, 10600, 11000,
> +	11400, 11800, 12200, 12700, 13300, 13800, 14200, 14600, 15000, 15400,
> +	15800, 16200, 16600, 17000, 17400, 17800, 18200, 18600, 19000, 19400,
> +	19800, 20200, 20600, 21000, 21400, 21900, 22500, 23000, 23400, 23800,
> +	24200, 24600, 25000, 25400, 25800, 26200, 26600, 27000, 27400, 27800,
> +	28200, 28600, 29000, 29400, 29800, 30200, 30600, 31000, 31400, 31900,
> +	32500, 33000, 33400, 33800, 34200, 34600, 35000, 35400, 35800, 36200,
> +	36600, 37000, 37400, 37800, 38200, 38600, 39000, 39400, 39800, 40200,
> +	40600, 41000, 41400, 41800, 42200, 42600, 43100, 43700, 44200, 44600,
> +	45000, 45400, 45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600,
> +	49000, 49400, 49800, 50200, 50600, 51000, 51400, 51800, 52200, 52600,
> +	53000, 53400, 53800, 54200, 54600, 55000, 55400, 55900, 56500, 57000,
> +	57400, 57800, 58200, 58600, 59000, 59400, 59800, 60200, 60600, 61000,
> +	61400, 61800, 62200, 62600, 63000, 63400, 63800, 64200, 64600, 65000,
> +	65400, 65800, 66200, 66600, 67000, 67400, 67800, 68200, 68600, 69000,
> +	69400, 69800, 70200, 70600, 71000, 71500, 72100, 72600, 73000, 73400,
> +	73800, 74200, 74600, 75000, 75400, 75800, 76200, 76600, 77000, 77400,
> +	77800, 78200, 78600, 79000, 79400, 79800, 80200, 80600, 81000, 81400,
> +	81800, 82200, 82600, 83000, 83400, 83800, 84200, 84600, 85000, 85400,
> +	85800, 86200, 86600, 87000, 87400, 87800, 88200, 88600, 89000, 89400,
> +	89800, 90200, 90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400,
> +	93800, 94200, 94600, 95000, 95400, 95800, 96200, 96600, 97000, 97500,
> +	98100, 98600, 99000, 99400, 99800, 100200, 100600, 101000, 101400,
> +	101800, 102200, 102600, 103000, 103400, 103800, 104200, 104600, 105000,
> +	105400, 105800, 106200, 106600, 107000, 107400, 107800, 108200, 108600,
> +	109000, 109400, 109800, 110200, 110600, 111000, 111400, 111800, 112200,
> +	112600, 113000, 113400, 113800, 114200, 114600, 115000, 115400, 115800,
> +	116200, 116600, 117000, 117400, 117800, 118200, 118600, 119000, 119400,
> +	119800, 120200, 120600, 121000, 121400, 121800, 122200, 122600, 123000,
> +	123400, 123800, 124200, 124600, 124900, 125000,
> +};

Can be this array replaced by an initialization array with a formula?

Why do we have most of the time a step of 400 then suddenly 500 and 400
again? eg. 30600, 31000, 31400, 31900, 32500, 33000, 33400

> +struct k3_thermal_data;

forward declaration not needed.

> +struct k3_bandgap {
> +	void __iomem *base;
> +	const struct k3_bandgap_data *conf;
> +};
> +
> +/* common data structures */
> +struct k3_thermal_data {
> +	struct thermal_zone_device *ti_thermal;
> +	struct k3_bandgap *bgp;
> +	struct work_struct thermal_wq;
> +	int sensor_id;
> +	u32 ctrl_offset;
> +	u32 stat_offset;
> +	int prev_temp;

prev_temp is assigned but not used.

> +};
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
> +static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
> +			    int *temp)
> +{
> +	struct k3_bandgap *bgp;
> +	unsigned int dtemp, s0, s1, s2;
> +
> +	bgp = devdata->bgp;
> +
> +	/*
> +	 * Errata is applicable for am654 pg 1.0 silicon. There
> +	 * is a variation of the order for 8-10 degree centigrade.
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
> +	if (dtemp < K3_VTM_ADC_BEGIN_VAL || dtemp > K3_VTM_ADC_END_VAL)
> +		return -EINVAL;
> +
> +	*temp = k3_adc_to_temp[dtemp - K3_VTM_ADC_BEGIN_VAL];

To be sure there is not a subtle memory corruption, I would recommend to
check the consistency between K3_VTM_ADC_END_VAL - K3_VTM_ADC_BEGIN_VAL
and the array size at init time.

For example:

if (ARRAY_SIZE(k3_adc_to_temp) !=
	(K3_VTM_ADC_END_VAL - K3_VTM_ADC_BEGIN_VAL))

> +	return 0;
> +}
> +
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
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
> +	.get_temp = k3_thermal_get_temp,
> +};
> +
> +static void k3_thermal_work(struct work_struct *work)
> +{
> +	struct k3_thermal_data *data = container_of(work,
> +					struct k3_thermal_data, thermal_wq);
> +
> +	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
> +
> +	dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
> +		data->ti_thermal->type);
> +}
> +
> +static const struct of_device_id of_k3_bandgap_match[];
> +
> +static int k3_bandgap_probe(struct platform_device *pdev)
> +{
> +	int ret = 0, cnt, val, id, reg_cnt = 0;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct k3_bandgap *bgp;
> +	struct k3_thermal_data *data;
> +
> +	bgp = devm_kzalloc(&pdev->dev, sizeof(*bgp), GFP_KERNEL);
> +	if (!bgp)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	bgp->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(bgp->base))
> +		return PTR_ERR(bgp->base);
> +
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
> +
> +	data = devm_kcalloc(dev, cnt, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	/* Register the thermal sensors */
> +	for (id = 0; id < cnt; id++) {
> +		data[id].sensor_id = id;
> +		data[id].bgp = bgp;
> +		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET +
> +					id * K3_VTM_REGS_PER_TS;
> +		data[id].stat_offset = data[id].ctrl_offset + 0x8;
> +		INIT_WORK(&data[id].thermal_wq, k3_thermal_work);

		What is supposed to do ?

> +		val = readl(data[id].bgp->base + data[id].ctrl_offset);
> +		val |= (K3_VTM_TMPSENS_CTRL_SOC |
> +			K3_VTM_TMPSENS_CTRL_CLRZ |
> +			K3_VTM_TMPSENS_CTRL_CLKON_REQ);
> +		val &= ~K3_VTM_TMPSENS_CTRL_CBIASSEL;
> +		writel(val, data[id].bgp->base + data[id].ctrl_offset);
> +
> +		data[id].ti_thermal =
> +		devm_thermal_zone_of_sensor_register(dev, id,
> +						     &data[id],
> +						     &k3_of_thermal_ops);
> +		if (IS_ERR(data[id].ti_thermal)) {
> +			dev_err(dev, "thermal zone device is NULL\n");
> +			ret = PTR_ERR(data[id].ti_thermal);
> +			goto err_alloc;
> +		}
> +
> +		reg_cnt++;
> +
> +		/* Initialize Previous temp */
> +		k3_thermal_get_temp(&data[id], &data[id].prev_temp);
> +	}
> +
> +	platform_set_drvdata(pdev, bgp);
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
> +static int k3_bandgap_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_k3_bandgap_match[] = {
> +	{
> +		.compatible = "ti,am654-vtm",
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, of_k3_bandgap_match);
> +
> +static struct platform_driver k3_bandgap_sensor_driver = {
> +	.probe = k3_bandgap_probe,
> +	.remove = k3_bandgap_remove,
> +	.driver = {
> +		.name = "k3-soc-thermal",
> +		.of_match_table	= of_k3_bandgap_match,
> +	},
> +};
> +
> +module_platform_driver(k3_bandgap_sensor_driver);
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

