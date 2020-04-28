Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153D71BBCE6
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 13:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgD1L6N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 07:58:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbgD1L6M (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Apr 2020 07:58:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BB2F859E7DABCBD492CE;
        Tue, 28 Apr 2020 19:58:10 +0800 (CST)
Received: from [127.0.0.1] (10.74.173.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 19:58:04 +0800
Subject: Re: [PATCH V3 2/2] thermal: Add HiSilicon Kunpeng thermal driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <amit.kucheria@verdurent.com>
References: <1587455093-33876-1-git-send-email-shenyang39@huawei.com>
 <1587455093-33876-3-git-send-email-shenyang39@huawei.com>
 <53ca3883-9155-c023-7916-10ec8cccf977@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linuxarm@huawei.com>,
        <wangzhou1@hisilicon.com>
From:   "shenyang (M)" <shenyang39@huawei.com>
Message-ID: <0be585d3-1180-7b42-8b51-392a34793f70@huawei.com>
Date:   Tue, 28 Apr 2020 19:58:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <53ca3883-9155-c023-7916-10ec8cccf977@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.173.6]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/4/27 20:13, Daniel Lezcano wrote:
> On 21/04/2020 09:44, Yang Shen wrote:
>> Support HiSilicon Kunpeng tsensor. the driver will report the max
>> temperature for each core.
>
> As this is a new driver, can you give a bit more details of the hardware
> in this description.
>
> A subsidiary question, why do you want to aggregate the temperatures in
> this driver ?
>

OK. In fact, there are five temperature sensors distributed in the SOC.
And our strategy is to collect all temperatures and return the max to
the interface.

I will add a description of the hardware in the next version.

>> Signed-off-by: Yang Shen <shenyang39@huawei.com>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Kunshan Tang <tangkunshan@huawei.com>
>> ---
>>  drivers/thermal/Kconfig           |   8 ++
>>  drivers/thermal/Makefile          |   1 +
>>  drivers/thermal/kunpeng_thermal.c | 216 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 225 insertions(+)
>>  create mode 100644 drivers/thermal/kunpeng_thermal.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 5a05db5..7611b5d 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -239,6 +239,14 @@ config HISI_THERMAL
>>  	  thermal framework. cpufreq is used as the cooling device to throttle
>>  	  CPUs when the passive trip is crossed.
>>
>> +config KUNPENG_THERMAL
>> +	tristate "HiSilicon kunpeng thermal driver"
>> +	depends on ARM64 || COMPILE_TEST
>> +	help
>> +	  Enable this to plug HiSilicon kunpeng's thermal sensors driver into
>> +	  the Linux thermal framework, which supports to get the highest
>> +	  temperature of one Kunpeng SoC.
>> +
>>  config IMX_THERMAL
>>  	tristate "Temperature sensor driver for Freescale i.MX SoCs"
>>  	depends on ARCH_MXC || COMPILE_TEST
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 9fb88e2..88ffca5 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -57,3 +57,4 @@ obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>>  obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
>>  obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>> +obj-$(CONFIG_KUNPENG_THERMAL)     += kunpeng_thermal.o
>> diff --git a/drivers/thermal/kunpeng_thermal.c b/drivers/thermal/kunpeng_thermal.c
>> new file mode 100644
>> index 0000000..d22e875
>> --- /dev/null
>> +++ b/drivers/thermal/kunpeng_thermal.c
>> @@ -0,0 +1,216 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2020 HiSilicon Limited. */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/thermal.h>
>> +
>> +#define KUNPENG_TSENSOR_CONTROL			0x20D0
>> +#define KUNPENG_TSENSOR_ST			0x60D0
>> +#define KUNPENG_TSENSOR_SAMPLE			0x60D4
>> +#define KUNPENG_TSENSOR_CONTROL_EN		BIT(0)
>> +
>> +#define KUNPENG_TSENSOR_IS_READY(reg)		(((reg) >> 12) & 0x1)
>> +#define KUNPENG_TSENSOR_IS_VALID(reg)		(((reg) >> 31) & 0x1)
>> +#define KUNPENG_TSENSOR_TRIM_HIGH(reg)		(((reg) >> 15) & 0x7FF)
>> +#define KUNPENG_TSENSOR_TRIM_LOW(reg)		((reg) & 0x7FF)
>> +#define KUNPENG_TSENSOR_TEMP_VAL(reg)		((reg) & 0x3FF)
>> +#define KUNPENG_TSENSOR_BASE_NUM(num)		(2 * (num))
>> +#define KUNPENG_TSENSOR_TRIM_NUM(num)		(2 * (num) + 1)
>> +
>> +#define KUNPENG_TSENSOR_RD_INTVRL_US		5
>> +#define KUNPENG_TSENSOR_RD_TMOUT_US		5000
>> +#define KUNPENG_TSENSOR_BASIC_TMP		25000
>> +#define KUNPENG_TSENSOR_BASIC_TRIM_RANGE	80000
>> +
>> +struct kunpeng_tsensor {
>> +	void __iomem *base;
>> +	void __iomem *trim_register;
>> +};
>> +
>> +struct kunpeng_thermal_dev {
>> +	u32 num_tsensors;
>> +	struct kunpeng_tsensor tsensor[];
>> +};
>> +
>> +static int kunpeng_thermal_temp_correct(u32 tmp, u32 trim)
>> +{
>> +	int trim_high = KUNPENG_TSENSOR_TRIM_HIGH(trim);
>> +	int trim_low = KUNPENG_TSENSOR_TRIM_LOW(trim);
>> +	int val = KUNPENG_TSENSOR_TEMP_VAL(tmp);
>> +
>> +	if (trim_high == trim_low)
>> +		return INT_MIN;
>> +
>> +	/* temperature of tsensor needs to be calibrated */
>> +	return KUNPENG_TSENSOR_BASIC_TRIM_RANGE * (val - trim_low) /
>> +	       (trim_high - trim_low) + KUNPENG_TSENSOR_BASIC_TMP;
>
> Is it possible to give some details about why this is done?
>

The hardware will measure the two standard temperature readings and
write them into the registers, and the driver will calibrate the
current readings according to the two standard temperature readings.

I will add this comment.

>> +}
>> +
>> +static int kunpeng_thermal_get_temp(struct thermal_zone_device *thermal,
>> +				    int *temp)
>> +{
>> +	struct kunpeng_thermal_dev *tdev = thermal->devdata;
>> +	int tempmax = INT_MIN;
>> +	u32 i, reg, tmp, trim;
>> +	int ret;
>> +
>> +	for (i = 0; i < tdev->num_tsensors; i++) {
>> +		/* Waiting for tsensor ready */
>> +		ret = readl_relaxed_poll_timeout(tdev->tsensor[i].base +
>> +						 KUNPENG_TSENSOR_ST, reg,
>> +						 KUNPENG_TSENSOR_IS_READY(reg),
>> +						 KUNPENG_TSENSOR_RD_INTVRL_US,
>> +						 KUNPENG_TSENSOR_RD_TMOUT_US);
>> +		if (ret) {
>> +			dev_err(&thermal->device,
>> +				"Tsensor%u isn't ready!\n", i);
>> +			continue;
>> +		}
>> +
>> +		/* checking if temperatures are valid */
>> +		tmp = readl_relaxed(tdev->tsensor[i].base +
>> +				    KUNPENG_TSENSOR_SAMPLE);
>> +		if (!KUNPENG_TSENSOR_IS_VALID(tmp)) {
>> +			dev_err(&thermal->device,
>> +				"Tsensor%u temperature is invalid!\n", i);
>> +			continue;
>> +		}
>> +
>> +		trim = readl_relaxed(tdev->tsensor[i].trim_register);
>> +
>> +		ret = kunpeng_thermal_temp_correct(tmp, trim);
>> +		if (ret == INT_MIN) {
>> +			dev_err(&thermal->device,
>> +				"Tsensor%u trim value is invalid!\n", i);
>> +			continue;
>> +		}
>> +
>> +		tempmax = max(ret, tempmax);
>> +	}
>> +
>> +	if (tempmax == INT_MIN)
>> +		return -EINVAL;
>> +
>> +	*temp = tempmax;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct thermal_zone_device_ops ops = {
>> +	.get_temp	= kunpeng_thermal_get_temp,
>> +};
>> +
>> +static int kunpeng_thermal_get_iobase(struct platform_device *pdev,
>> +				      struct kunpeng_tsensor *tsensor,
>> +				      u32 resource_num)
>> +{
>> +	struct resource *res;
>> +	void __iomem *base;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, resource_num);
>> +	if (!res)
>> +		return -EINVAL;
>> +
>> +	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>> +	if (IS_ERR(base))
>> +		return -EINVAL;
>> +
>> +	if (resource_num & 1)
>> +		tsensor->trim_register = base;
>> +	else
>> +		tsensor->base = base;
>> +
>> +	return 0;
>> +}
>> +
>> +static int kunpeng_thermal_probe(struct platform_device *pdev)
>> +{
>> +	u32 num_tsensors = pdev->num_resources >> 1;
>> +	struct thermal_zone_device *thermal_zone;
>> +	struct kunpeng_thermal_dev *tdev;
>> +	u32 i, reg;
>> +	int ret;
>> +
>> +	tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev) + sizeof(*tdev->tsensor) *
>> +			    num_tsensors, GFP_KERNEL);
>> +	if (!tdev)
>> +		return -ENOMEM;
>> +
>> +	tdev->num_tsensors = num_tsensors;
>> +
>> +	for (i = 0; i < num_tsensors; i++) {
>> +		ret = kunpeng_thermal_get_iobase(pdev, &tdev->tsensor[i],
>> +						 KUNPENG_TSENSOR_BASE_NUM(i));
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "Fail to ioremap base!\n");
>> +			return ret;
>> +		}
>> +
>> +		ret = kunpeng_thermal_get_iobase(pdev, &tdev->tsensor[i],
>> +						 KUNPENG_TSENSOR_TRIM_NUM(i));
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "Fail to ioremap trim register!\n");
>> +			return ret;
>> +		}
>
> I initially thought there was a bug because the function is called with
> the &tsensor[i] twice, then noticed the spin in the underlying function.
>
> It is probably better to make the code a bit more self-explicit. May be
> increment 'i' by a step of 2?
>
>

My original idea was to extract the iobase function as a separate
function, so I named it kunpeng_thermal_get_iobase.
I can modify it to be a function for initializing the iobase of a
single sensor, which might be easier to understand.

>> +		reg = readl_relaxed(tdev->tsensor[i].base +
>> +				    KUNPENG_TSENSOR_CONTROL);
>> +		writel_relaxed(reg | KUNPENG_TSENSOR_CONTROL_EN,
>> +			       tdev->tsensor[i].base +
>> +			       KUNPENG_TSENSOR_CONTROL);
>
> Please add helpers with explicit function name for understanding.
>

OK, I will fix in next version.

>> +	}
>> +
>> +	thermal_zone = thermal_zone_device_register("kunpeng_thermal", 0, 0,
>> +						    tdev, &ops, NULL, 0, 0);
>> +	if (IS_ERR(thermal_zone)) {
>> +		dev_err(&pdev->dev, "Fail to register to thermal subsystem\n");
>> +		return PTR_ERR(thermal_zone);
>> +	}
>> +
>> +	platform_set_drvdata(pdev, thermal_zone);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * kunpeng_thermal_remove() - Unregister device from thermal.
>> + *
>> + * This driver and IMU share tsensor devices. This function only unregister
>> + * devices from thermal but never disable tsensors.
>
> What is the IMU ?
>

IMU is stand for Intelligent Management Unit. It functions as a
supervisor and a manager of the chip. It has complete SoC
components and is totally independent from the application processor
system.
So the IMU will read the tsensors temperature registers too.

> I don't see in this driver anything related to the sensors being shared
> with something else.
>

Yes. This driver use the device independently. But the driver cannot
disable devices when it is removed.
I add comments here to avoid user confusion.

>> + */
>> +static int kunpeng_thermal_remove(struct platform_device *pdev)
>> +{
>> +	struct thermal_zone_device *thermal_zone = platform_get_drvdata(pdev);
>> +
>> +	thermal_zone_device_unregister(thermal_zone);
> Why not add a devm_thermal_zone_device_register() ? and get rid of this
> function ?
>

Do  you ask me to add this function in thermal_core.c?

>> +	return 0;
>> +}
>> +
>> +static const struct acpi_device_id kunpeng_thermal_acpi_match[] = {
>> +	{ "HISI0371", 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, kunpeng_thermal_acpi_match);
>> +
>> +static struct platform_driver kunpeng_thermal_driver = {
>> +	.probe		= kunpeng_thermal_probe,
>> +	.remove		= kunpeng_thermal_remove,
>> +	.driver		= {
>> +		.name	= "kunpeng_thermal",
>> +		.acpi_match_table = ACPI_PTR(kunpeng_thermal_acpi_match),
>> +	},
>> +};
>> +
>> +module_platform_driver(kunpeng_thermal_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Yang Shen <shenyang39@huawei.com>");
>> +MODULE_DESCRIPTION("HiSilicon Kunpeng thermal driver");
>> --
>> 2.7.4
>>
>
>

