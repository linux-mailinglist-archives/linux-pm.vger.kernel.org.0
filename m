Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380B218B3C5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 13:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgCSMw4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 08:52:56 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37594 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSMwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 08:52:55 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02JCqg3L057622;
        Thu, 19 Mar 2020 07:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584622362;
        bh=eAilZA11iLm+gtgKCQlqZ03zeJpEkI1sgXDufYTW4Z0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UULxQAyiPCilF0eBOjYEqm6IkbqmXwXh9x1uS6t2TrJ56EITFCIeTET1urEHUgM73
         lEKAVQbv/a8Sq+mxAtU6L1HCKarZEJRYC2hJAJHzda1z+ZM0FcYyV4jjPi5eaZbybO
         yxXx2HbFEpkWxO2iXuXqmrZsg3YIn+el15Y3LciE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02JCqgI2049419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Mar 2020 07:52:42 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 07:52:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 07:52:41 -0500
Received: from [10.24.69.174] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JCqchj043796;
        Thu, 19 Mar 2020 07:52:38 -0500
Subject: Re: [RESEND PATCH v4 2/4] thermal: k3: Add support for bandgap
 sensors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>
CC:     <amit.kucheria@verdurent.com>, <t-kristo@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
References: <20200318083028.9984-1-j-keerthy@ti.com>
 <20200318083028.9984-3-j-keerthy@ti.com>
 <ea3b34dc-42e3-0b10-4b89-faf2621a4ee2@linaro.org>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <03b837de-ff25-2308-8a56-15bc3377cd5f@ti.com>
Date:   Thu, 19 Mar 2020 18:22:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ea3b34dc-42e3-0b10-4b89-faf2621a4ee2@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 19/03/20 6:08 pm, Daniel Lezcano wrote:
> On 18/03/2020 09:30, Keerthy wrote:
>> The bandgap provides current and voltage reference for its internal
>> circuits and other analog IP blocks. The analog-to-digital
>> converter (ADC) produces an output value that is proportional
>> to the silicon temperature.
>>
>> Currently reading temperatures and creating work to periodically
>> read temperatures from the zones are supported.
>> There are no active/passive cooling agent supported.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Changes in v4:
>>
>>    * Fixed comments from Daniel to remove trend function.
>>    * Mostly cleaned up all the unused variables.
>>    * Driver from bool to tristate.
>>
>>   drivers/thermal/Kconfig      |  11 ++
>>   drivers/thermal/Makefile     |   1 +
>>   drivers/thermal/k3_bandgap.c | 287 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 299 insertions(+)
>>   create mode 100644 drivers/thermal/k3_bandgap.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 5a05db5438d6..d848d9a3c4f1 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -251,6 +251,17 @@ config IMX_THERMAL
>>   	  cpufreq is used as the cooling device to throttle CPUs when the
>>   	  passive trip is crossed.
>>   
>> +config K3_THERMAL
>> +	tristate "Texas Instruments K3 thermal support"
>> +	depends on ARCH_K3 || COMPILE_TEST
>> +	help
>> +	  If you say yes here you get thermal support for the Texas Instruments
>> +	  K3 SoC family. The current chip supported is:
>> +	   - AM654
>> +
>> +	  This includes temperature reading functionality and also trend
>> +	  computation.
> 
> trend is now removed :)

Oops missed this one here. I will remove.

> 
>>   config MAX77620_THERMAL
>>   	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
>>   	depends on MFD_MAX77620
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 9fb88e26fb10..5ad6535139ae 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -28,6 +28,7 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
>>   # devfreq cooling
>>   thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>>   
>> +obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o
>>   # platform thermal drivers
>>   obj-y				+= broadcom/
>>   obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
>> diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
>> new file mode 100644
>> index 000000000000..d16e60335721
>> --- /dev/null
>> +++ b/drivers/thermal/k3_bandgap.c
>> @@ -0,0 +1,287 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * TI Bandgap temperature sensor driver for K3 SoC Family
>> + *
>> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/err.h>
>> +#include <linux/types.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/io.h>
>> +#include <linux/workqueue.h>
> 
> Please check all the headers are needed, AFAICT workqueue.h and
> spinlock.h are not.

okay

> 
>> +#include <linux/thermal.h>
>> +#include <linux/of.h>
>> +
>> +#define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
>> +#define K3_VTM_DEVINFO_PWR0_CVD_CT_MASK	0xf
>> +#define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
>> +#define K3_VTM_TMPSENS0_CTRL_OFFSET	0x80
>> +#define K3_VTM_REGS_PER_TS			0x10
>> +#define K3_VTM_TS_STAT_DTEMP_MASK	0x3ff
>> +#define K3_VTM_MAX_NUM_TS		8
>> +#define K3_VTM_TMPSENS_CTRL_CBIASSEL	BIT(0)
>> +#define K3_VTM_TMPSENS_CTRL_SOC		BIT(5)
>> +#define K3_VTM_TMPSENS_CTRL_CLRZ		BIT(6)
>> +#define K3_VTM_TMPSENS_CTRL_CLKON_REQ	BIT(7)
>> +
>> +#define K3_VTM_ADC_BEGIN_VAL		540
>> +#define K3_VTM_ADC_END_VAL		944
>> +
>> +static const int k3_adc_to_temp[] = {
>> +	-40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600, -38200,
>> +	-37800, -37400, -37000, -36600, -36200, -35800, -35300, -34700, -34200,
>> +	-33800, -33400, -33000, -32600, -32200, -31800, -31400, -31000, -30600,
>> +	-30200, -29800, -29400, -29000, -28600, -28200, -27700, -27100, -26600,
>> +	-26200, -25800, -25400, -25000, -24600, -24200, -23800, -23400, -23000,
>> +	-22600, -22200, -21800, -21400, -21000, -20500, -19900, -19400, -19000,
>> +	-18600, -18200, -17800, -17400, -17000, -16600, -16200, -15800, -15400,
>> +	-15000, -14600, -14200, -13800, -13400, -13000, -12500, -11900, -11400,
>> +	-11000, -10600, -10200, -9800, -9400, -9000, -8600, -8200, -7800, -7400,
>> +	-7000, -6600, -6200, -5800, -5400, -5000, -4500, -3900, -3400, -3000,
>> +	-2600, -2200, -1800, -1400, -1000, -600, -200, 200, 600, 1000, 1400,
>> +	1800, 2200, 2600, 3000, 3400, 3900, 4500, 5000, 5400, 5800, 6200, 6600,
>> +	7000, 7400, 7800, 8200, 8600, 9000, 9400, 9800, 10200, 10600, 11000,
>> +	11400, 11800, 12200, 12700, 13300, 13800, 14200, 14600, 15000, 15400,
>> +	15800, 16200, 16600, 17000, 17400, 17800, 18200, 18600, 19000, 19400,
>> +	19800, 20200, 20600, 21000, 21400, 21900, 22500, 23000, 23400, 23800,
>> +	24200, 24600, 25000, 25400, 25800, 26200, 26600, 27000, 27400, 27800,
>> +	28200, 28600, 29000, 29400, 29800, 30200, 30600, 31000, 31400, 31900,
>> +	32500, 33000, 33400, 33800, 34200, 34600, 35000, 35400, 35800, 36200,
>> +	36600, 37000, 37400, 37800, 38200, 38600, 39000, 39400, 39800, 40200,
>> +	40600, 41000, 41400, 41800, 42200, 42600, 43100, 43700, 44200, 44600,
>> +	45000, 45400, 45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600,
>> +	49000, 49400, 49800, 50200, 50600, 51000, 51400, 51800, 52200, 52600,
>> +	53000, 53400, 53800, 54200, 54600, 55000, 55400, 55900, 56500, 57000,
>> +	57400, 57800, 58200, 58600, 59000, 59400, 59800, 60200, 60600, 61000,
>> +	61400, 61800, 62200, 62600, 63000, 63400, 63800, 64200, 64600, 65000,
>> +	65400, 65800, 66200, 66600, 67000, 67400, 67800, 68200, 68600, 69000,
>> +	69400, 69800, 70200, 70600, 71000, 71500, 72100, 72600, 73000, 73400,
>> +	73800, 74200, 74600, 75000, 75400, 75800, 76200, 76600, 77000, 77400,
>> +	77800, 78200, 78600, 79000, 79400, 79800, 80200, 80600, 81000, 81400,
>> +	81800, 82200, 82600, 83000, 83400, 83800, 84200, 84600, 85000, 85400,
>> +	85800, 86200, 86600, 87000, 87400, 87800, 88200, 88600, 89000, 89400,
>> +	89800, 90200, 90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400,
>> +	93800, 94200, 94600, 95000, 95400, 95800, 96200, 96600, 97000, 97500,
>> +	98100, 98600, 99000, 99400, 99800, 100200, 100600, 101000, 101400,
>> +	101800, 102200, 102600, 103000, 103400, 103800, 104200, 104600, 105000,
>> +	105400, 105800, 106200, 106600, 107000, 107400, 107800, 108200, 108600,
>> +	109000, 109400, 109800, 110200, 110600, 111000, 111400, 111800, 112200,
>> +	112600, 113000, 113400, 113800, 114200, 114600, 115000, 115400, 115800,
>> +	116200, 116600, 117000, 117400, 117800, 118200, 118600, 119000, 119400,
>> +	119800, 120200, 120600, 121000, 121400, 121800, 122200, 122600, 123000,
>> +	123400, 123800, 124200, 124600, 124900, 125000,
>> +};
> 
> Can be this array replaced by an initialization array with a formula?
> 
> Why do we have most of the time a step of 400 then suddenly 500 and 400
> again? eg. 30600, 31000, 31400, 31900, 32500, 33000, 33400

This has come from a polynomial equation which i do not want to 
calculate every time we read the temperature. Hence prefer Look up table.

> 
>> +struct k3_thermal_data;
> 
> forward declaration not needed.

okay

> 
>> +struct k3_bandgap {
>> +	void __iomem *base;
>> +	const struct k3_bandgap_data *conf;
>> +};
>> +
>> +/* common data structures */
>> +struct k3_thermal_data {
>> +	struct thermal_zone_device *ti_thermal;
>> +	struct k3_bandgap *bgp;
>> +	struct work_struct thermal_wq;
>> +	int sensor_id;
>> +	u32 ctrl_offset;
>> +	u32 stat_offset;
>> +	int prev_temp;
> 
> prev_temp is assigned but not used.

Yes this can be removed.

> 
>> +};
>> +
>> +static unsigned int vtm_get_best_value(unsigned int s0, unsigned int s1,
>> +				       unsigned int s2)
>> +{
>> +	int d01 = abs(s0 - s1);
>> +	int d02 = abs(s0 - s2);
>> +	int d12 = abs(s1 - s2);
>> +
>> +	if (d01 <= d02 && d01 <= d12)
>> +		return (s0 + s1) / 2;
>> +
>> +	if (d02 <= d01 && d02 <= d12)
>> +		return (s0 + s2) / 2;
>> +
>> +	return (s1 + s2) / 2;
>> +}
>> +
>> +static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
>> +			    int *temp)
>> +{
>> +	struct k3_bandgap *bgp;
>> +	unsigned int dtemp, s0, s1, s2;
>> +
>> +	bgp = devdata->bgp;
>> +
>> +	/*
>> +	 * Errata is applicable for am654 pg 1.0 silicon. There
>> +	 * is a variation of the order for 8-10 degree centigrade.
>> +	 * Work around that by getting the average of two closest
>> +	 * readings out of three readings everytime we want to
>> +	 * report temperatures.
>> +	 *
>> +	 * Errata workaround.
>> +	 */
>> +	s0 = readl(bgp->base + devdata->stat_offset) &
>> +		K3_VTM_TS_STAT_DTEMP_MASK;
>> +	s1 = readl(bgp->base + devdata->stat_offset) &
>> +		K3_VTM_TS_STAT_DTEMP_MASK;
>> +	s2 = readl(bgp->base + devdata->stat_offset) &
>> +		K3_VTM_TS_STAT_DTEMP_MASK;
>> +	dtemp = vtm_get_best_value(s0, s1, s2);
>> +
>> +	if (dtemp < K3_VTM_ADC_BEGIN_VAL || dtemp > K3_VTM_ADC_END_VAL)
>> +		return -EINVAL;
>> +
>> +	*temp = k3_adc_to_temp[dtemp - K3_VTM_ADC_BEGIN_VAL];
> 
> To be sure there is not a subtle memory corruption, I would recommend to
> check the consistency between K3_VTM_ADC_END_VAL - K3_VTM_ADC_BEGIN_VAL
> and the array size at init time.
> 
> For example:
> 
> if (ARRAY_SIZE(k3_adc_to_temp) !=
> 	(K3_VTM_ADC_END_VAL - K3_VTM_ADC_BEGIN_VAL))

okay

> 
>> +	return 0;
>> +}
>> +
>> +static int k3_thermal_get_temp(void *devdata, int *temp)
>> +{
>> +	struct k3_thermal_data *data = devdata;
>> +	int ret = 0;
>> +
>> +	ret = k3_bgp_read_temp(data, temp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	data->prev_temp = *temp;
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
>> +	.get_temp = k3_thermal_get_temp,
>> +};
>> +
>> +static void k3_thermal_work(struct work_struct *work)
>> +{
>> +	struct k3_thermal_data *data = container_of(work,
>> +					struct k3_thermal_data, thermal_wq);
>> +
>> +	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
>> +
>> +	dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
>> +		data->ti_thermal->type);
>> +}
>> +
>> +static const struct of_device_id of_k3_bandgap_match[];
>> +
>> +static int k3_bandgap_probe(struct platform_device *pdev)
>> +{
>> +	int ret = 0, cnt, val, id, reg_cnt = 0;
>> +	struct resource *res;
>> +	struct device *dev = &pdev->dev;
>> +	struct k3_bandgap *bgp;
>> +	struct k3_thermal_data *data;
>> +
>> +	bgp = devm_kzalloc(&pdev->dev, sizeof(*bgp), GFP_KERNEL);
>> +	if (!bgp)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	bgp->base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(bgp->base))
>> +		return PTR_ERR(bgp->base);
>> +
>> +	pm_runtime_enable(dev);
>> +	ret = pm_runtime_get_sync(dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(dev);
>> +		pm_runtime_disable(dev);
>> +		return ret;
>> +	}
>> +
>> +	/* Get the sensor count in the VTM */
>> +	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
>> +	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
>> +	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
>> +
>> +	data = devm_kcalloc(dev, cnt, sizeof(*data), GFP_KERNEL);
>> +	if (!data) {
>> +		ret = -ENOMEM;
>> +		goto err_alloc;
>> +	}
>> +
>> +	/* Register the thermal sensors */
>> +	for (id = 0; id < cnt; id++) {
>> +		data[id].sensor_id = id;
>> +		data[id].bgp = bgp;
>> +		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET +
>> +					id * K3_VTM_REGS_PER_TS;
>> +		data[id].stat_offset = data[id].ctrl_offset + 0x8;
>> +		INIT_WORK(&data[id].thermal_wq, k3_thermal_work);
> 
> 		What is supposed to do ?

Periodically poll temperature. I know there is no passive cooling agent
like cpufreq at the moment but i do have a critical trip do you 
recommend to remove that?

Thanks,
Keerthy

> 
>> +		val = readl(data[id].bgp->base + data[id].ctrl_offset);
>> +		val |= (K3_VTM_TMPSENS_CTRL_SOC |
>> +			K3_VTM_TMPSENS_CTRL_CLRZ |
>> +			K3_VTM_TMPSENS_CTRL_CLKON_REQ);
>> +		val &= ~K3_VTM_TMPSENS_CTRL_CBIASSEL;
>> +		writel(val, data[id].bgp->base + data[id].ctrl_offset);
>> +
>> +		data[id].ti_thermal =
>> +		devm_thermal_zone_of_sensor_register(dev, id,
>> +						     &data[id],
>> +						     &k3_of_thermal_ops);
>> +		if (IS_ERR(data[id].ti_thermal)) {
>> +			dev_err(dev, "thermal zone device is NULL\n");
>> +			ret = PTR_ERR(data[id].ti_thermal);
>> +			goto err_alloc;
>> +		}
>> +
>> +		reg_cnt++;
>> +
>> +		/* Initialize Previous temp */
>> +		k3_thermal_get_temp(&data[id], &data[id].prev_temp);
>> +	}
>> +
>> +	platform_set_drvdata(pdev, bgp);
>> +
>> +	return 0;
>> +
>> +err_alloc:
>> +	pm_runtime_put_sync(&pdev->dev);
>> +	pm_runtime_disable(&pdev->dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static int k3_bandgap_remove(struct platform_device *pdev)
>> +{
>> +	pm_runtime_put_sync(&pdev->dev);
>> +	pm_runtime_disable(&pdev->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id of_k3_bandgap_match[] = {
>> +	{
>> +		.compatible = "ti,am654-vtm",
>> +	},
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, of_k3_bandgap_match);
>> +
>> +static struct platform_driver k3_bandgap_sensor_driver = {
>> +	.probe = k3_bandgap_probe,
>> +	.remove = k3_bandgap_remove,
>> +	.driver = {
>> +		.name = "k3-soc-thermal",
>> +		.of_match_table	= of_k3_bandgap_match,
>> +	},
>> +};
>> +
>> +module_platform_driver(k3_bandgap_sensor_driver);
>> +
>> +MODULE_DESCRIPTION("K3 bandgap temperature sensor driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
>>
> 
> 
