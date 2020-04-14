Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872001A7B05
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 14:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440148AbgDNMmw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 08:42:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440146AbgDNMmo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Apr 2020 08:42:44 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 31E10F12F002A6D48390;
        Tue, 14 Apr 2020 20:42:41 +0800 (CST)
Received: from [127.0.0.1] (10.74.173.6) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Apr 2020
 20:42:32 +0800
From:   "shenyang (M)" <shenyang39@huawei.com>
Subject: Re: [PATCH V2 1/2] thermal: Add HiSilicon Kunpeng thermal driver
To:     Amit Kucheria <amit.kucheria@verdurent.com>
References: <1584363301-15858-1-git-send-email-shenyang39@huawei.com>
 <1584363301-15858-2-git-send-email-shenyang39@huawei.com>
 <CAHLCerMfny5vGFr=966LZpt_ocZQXH4wo5hHCea1EPWkMB=sXg@mail.gmail.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Zhou Wang" <wangzhou1@hisilicon.com>
Message-ID: <75c2e94b-8fdf-dd59-c30c-342e79dbc7b2@huawei.com>
Date:   Tue, 14 Apr 2020 20:42:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerMfny5vGFr=966LZpt_ocZQXH4wo5hHCea1EPWkMB=sXg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.173.6]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Amit,

Thanks a lot for your review!

Yang

On 2020/4/7 18:09, Amit Kucheria wrote:
> Hi Yang,
>
> On Mon, Mar 16, 2020 at 6:25 PM Yang Shen <shenyang39@huawei.com> wrote:
>>
>> Support HiSilicon Kunpeng tsensor. the driver will report the max
>> temperature for each core.
>>
>> Signed-off-by: Yang Shen <shenyang39@huawei.com>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Kunshan Tang <tangkunshan@huawei.com>
>> ---
>>  drivers/thermal/Kconfig           |   8 ++
>>  drivers/thermal/Makefile          |   1 +
>>  drivers/thermal/kunpeng_thermal.c | 219 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 228 insertions(+)
>>  create mode 100644 drivers/thermal/kunpeng_thermal.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 5a05db5..7611b5d 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -239,6 +239,14 @@ config HISI_THERMAL
>>           thermal framework. cpufreq is used as the cooling device to throttle
>>           CPUs when the passive trip is crossed.
>>
>> +config KUNPENG_THERMAL
>> +       tristate "HiSilicon kunpeng thermal driver"
>> +       depends on ARM64 || COMPILE_TEST
>
> Please make this depend on your SoC, not all of ARM64. Perhaps ARCH_HISI?
>

This driver depend on ARM64 only.

>> +       help
>> +         Enable this to plug HiSilicon kunpeng's thermal sensors driver into
>> +         the Linux thermal framework, which supports to get the highest
>> +         temperature of one Kunpeng SoC.
>> +
>>  config IMX_THERMAL
>>         tristate "Temperature sensor driver for Freescale i.MX SoCs"
>>         depends on ARCH_MXC || COMPILE_TEST
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 9fb88e2..88ffca5 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -57,3 +57,4 @@ obj-$(CONFIG_GENERIC_ADC_THERMAL)     += thermal-generic-adc.o
>>  obj-$(CONFIG_ZX2967_THERMAL)   += zx2967_thermal.o
>>  obj-$(CONFIG_UNIPHIER_THERMAL) += uniphier_thermal.o
>>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>> +obj-$(CONFIG_KUNPENG_THERMAL)     += kunpeng_thermal.o
>> diff --git a/drivers/thermal/kunpeng_thermal.c b/drivers/thermal/kunpeng_thermal.c
>> new file mode 100644
>> index 0000000..5b5df82
>> --- /dev/null
>> +++ b/drivers/thermal/kunpeng_thermal.c
>> @@ -0,0 +1,219 @@
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
>> +#define KUNPENG_TSENSOR_CONTROL                        0x20D0
>> +#define KUNPENG_TSENSOR_ST                     0x60D0
>> +#define KUNPENG_TSENSOR_SAMPLE                 0x60D4
>> +#define KUNPENG_TSENSOR_CONTROL_EN             BIT(0)
>> +
>> +#define KUNPENG_TSENSOR_IS_ENABLE(reg)         ((reg) & 0x1)
>
> Typo: ENABLED
>

I'll fix this in next version, thanks!

>> +#define KUNPENG_TSENSOR_IS_READY(reg)          (((reg) >> 12) & 0x1)
>> +#define KUNPENG_TSENSOR_IS_VALID(reg)          (((reg) >> 31) & 0x1)
>> +#define KUNPENG_TSENSOR_TRIM_HIGH(reg)         (((reg) >> 15) & 0x7FF)
>> +#define KUNPENG_TSENSOR_TRIM_LOW(reg)          ((reg) & 0x7FF)
>> +#define KUNPENG_TSENSOR_TEMP_VAL(reg)          ((reg) & 0x3FF)
>> +#define KUNPENG_TSENSOR_BASE_NUM(num)          (2 * (num))
>> +#define KUNPENG_TSENSOR_TRIM_NUM(num)          (2 * (num) + 1)
>> +
>> +#define KUNPENG_TSENSOR_RD_INTVRL_US           5
>> +#define KUNPENG_TSENSOR_RD_TMOUT_US            2000
>> +#define KUNPENG_TSENSOR_BASIC_TMP              25000
>> +#define KUNPENG_TSENSOR_BASIC_TRIM_RANGE       80000
>> +
>> +struct kunpeng_tsensor {
>> +       void __iomem *base;
>> +       void __iomem *trim_register;
>> +};
>> +
>> +struct kunpeng_thermal_dev {
>> +       u32 num_tsensors;
>> +       struct kunpeng_tsensor tsensor[];
>> +};
>> +
>> +static int kunpeng_thermal_temp_correct(u32 tmp, u32 trim)
>> +{
>> +       int trim_high = KUNPENG_TSENSOR_TRIM_HIGH(trim);
>> +       int trim_low = KUNPENG_TSENSOR_TRIM_LOW(trim);
>> +       int val = KUNPENG_TSENSOR_TEMP_VAL(tmp);
>> +
>> +       if (trim_high == trim_low)
>> +               return INT_MIN;
>> +
>> +       /* temperature of tsensor needs to be calibrated */
>> +       return KUNPENG_TSENSOR_BASIC_TRIM_RANGE * (val - trim_low)
>> +              / (trim_high - trim_low) + KUNPENG_TSENSOR_BASIC_TMP;
>> +}
>> +
>> +static int kunpeng_thermal_get_temp(struct thermal_zone_device *thermal,
>> +                                   int *temp)
>> +{
>> +       struct kunpeng_thermal_dev *tdev = thermal->devdata;
>> +       int tempmax = INT_MIN;
>> +       u32 i, reg, tmp, trim;
>> +       int ret;
>> +
>> +       for (i = 0; i < tdev->num_tsensors; i++) {
>> +               /* Waiting for tsensor ready */
>> +               ret = readl_relaxed_poll_timeout(tdev->tsensor[i].base +
>> +                                                KUNPENG_TSENSOR_ST, reg,
>> +                                                KUNPENG_TSENSOR_IS_READY(reg),
>> +                                                KUNPENG_TSENSOR_RD_INTVRL_US,
>> +                                                KUNPENG_TSENSOR_RD_TMOUT_US);
>> +               if (ret) {
>> +                       dev_err(&thermal->device,
>
> dev_dbg? If it's an error, you probably want to return here. No point
> in flooding the console with messages.
>

Thanks. But our SoC have more than one sensor. In this function, even if 
some of sensors don't work normal, I want to return the max temperature 
of the working sensors and tell the user which one has problem.

>> +                               "Tsensor%u isn't ready!\n", i);
>> +                       continue;
>> +               }
>> +
>> +               /* checking if tsensors are valid */
>
> s/tsensors/temperature/ ?
>

I'll fix this in next version, thanks!

>> +               tmp = readl_relaxed(tdev->tsensor[i].base
>> +                                   + KUNPENG_TSENSOR_SAMPLE);
>> +               if (!KUNPENG_TSENSOR_IS_VALID(tmp)) {
>> +                       dev_err(&thermal->device,
>
> dev_dbg?
>

the same as above

>> +                               "Tsensor%u temperature is invalid!\n", i);
>> +                       continue;
>> +               }
>> +
>> +               trim = readl_relaxed(tdev->tsensor[i].trim_register);
>> +
>> +               ret = kunpeng_thermal_temp_correct(tmp, trim);
>> +               if (ret == INT_MIN) {
>> +                       dev_err(&thermal->device,
>
> dev_dbg?
>

the same as above

>> +                               "Tsensor%u trim value is invalid!\n", i);
>> +                       continue;
>> +               }
>> +
>> +               tempmax = max(ret, tempmax);
>> +       }
>> +
>> +       if (tempmax == INT_MIN)
>> +               return -EINVAL;
>> +
>> +       *temp = tempmax;
>> +
>> +       return 0;
>> +}
>> +
>> +static struct thermal_zone_device_ops ops = {
>> +       .get_temp       = kunpeng_thermal_get_temp,
>> +};
>> +
>> +static int kunpeng_thermal_get_iobase(struct platform_device *pdev,
>> +                                     struct kunpeng_tsensor *tsensor,
>> +                                     u32 resource_num)
>> +{
>> +       struct resource *res;
>> +       void __iomem *base;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, resource_num);
>> +       if (!res)
>> +               return -EINVAL;
>> +
>> +       base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>
> Consider using devm_ioremap_resource()
>

In this driver, one sensor device needs two types register to work. One 
is used to control device, and the other provides temperature 
calibration value.
But here is a question that sensors distributed on C die and IO die have 
different register offset address. The two types of sensor registers on 
IO die are distributed on the same page, but those on C die are 
distributed on different pages.
For compatibility reasons,the ACPI provides two resource for one sensor. 
The first one is used to map control register, and the second one is 
used to map temperature calibration value register which will lead to 
mapping conflicts when using devm_ioremap_resource() to map the device 
register on IO die.

>> +       if (IS_ERR(base))
>> +               return -EINVAL;
>> +
>> +       if (resource_num & 1)
>> +               tsensor->trim_register = base;
>> +       else
>> +               tsensor->base = base;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * kunpeng_thermal_probe() - Enable tsensors. And register device to thermal.
>> + *
>> + * This driver and IMU share tsensor devices. This funciton only enable the
>
> Typo: function
>

Sorry, I'll fix this.

>> + * devices but never change configure or disable them.
>
> Probe functions typically only enable the device. I don't think you
> need to put that into comments.
>

Here I don't do any operation to devices on driver remove function. I'm 
afraid that users are confused about this, so I've added a comment here. 
Maybe moving this to the front of the remove function is a little better.

>> + */
>> +static int kunpeng_thermal_probe(struct platform_device *pdev)
>> +{
>> +       u32 num_tsensors = pdev->num_resources >> 1;
>> +       struct thermal_zone_device *thermal_zone;
>> +       struct kunpeng_thermal_dev *tdev;
>> +       u32 i, reg;
>> +       int ret;
>> +
>> +       tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev) + sizeof(*tdev->tsensor) *
>> +                           num_tsensors, GFP_KERNEL);
>> +       if (!tdev)
>> +               return -ENOMEM;
>> +
>> +       tdev->num_tsensors = num_tsensors;
>> +
>> +       for (i = 0; i < num_tsensors; i++) {
>> +               ret = kunpeng_thermal_get_iobase(pdev, &tdev->tsensor[i],
>> +                                                KUNPENG_TSENSOR_BASE_NUM(i));
>> +               if (ret) {
>> +                       dev_err(&pdev->dev, "Fail to ioremap base!\n");
>> +                       return ret;
>> +               }
>> +
>> +               ret = kunpeng_thermal_get_iobase(pdev, &tdev->tsensor[i],
>> +                                                KUNPENG_TSENSOR_TRIM_NUM(i));
>> +               if (ret) {
>> +                       dev_err(&pdev->dev, "Fail to ioremap trim register!\n");
>> +                       return ret;
>> +               }
>> +
>> +               /* Enable thermal sensors when devices are disable */
>
> Get rid of this comment
>

OK, I'll fix this in next version.

>> +               reg = readl_relaxed(tdev->tsensor[i].base +
>> +                                   KUNPENG_TSENSOR_CONTROL);
>> +               if (!KUNPENG_TSENSOR_IS_ENABLE(reg))
>> +                       writel_relaxed(reg | KUNPENG_TSENSOR_CONTROL_EN,
>> +                                      tdev->tsensor[i].base +
>> +                                      KUNPENG_TSENSOR_CONTROL);
>
> Is it a problem if the sensor is enabled twice? Does firmware
> initialise this sensor? I suggest getting rid of the check and just
> enable it again in the driver.
>
>

I'll fix this in next version, thanks!

>> +       }
>> +
>> +       thermal_zone = thermal_zone_device_register("kunpeng_thermal", 0, 0,
>> +                                                   tdev, &ops, NULL, 0, 0);
>> +       if (IS_ERR(thermal_zone)) {
>> +               dev_err(&pdev->dev, "Fail to register to thermal subsystem\n");
>> +               return PTR_ERR(thermal_zone);
>> +       }
>> +
>> +       platform_set_drvdata(pdev, thermal_zone);
>> +
>> +       return 0;
>> +}
>> +
>> +static int kunpeng_thermal_remove(struct platform_device *pdev)
>> +{
>> +       struct thermal_zone_device *thermal_zone = platform_get_drvdata(pdev);
>> +
>> +       thermal_zone_device_unregister(thermal_zone);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct acpi_device_id kunpeng_thermal_acpi_match[] = {
>> +       { "HISI0371", 0 },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, kunpeng_thermal_acpi_match);
>> +
>> +static struct platform_driver kunpeng_thermal_driver = {
>> +       .probe          = kunpeng_thermal_probe,
>> +       .remove         = kunpeng_thermal_remove,
>> +       .driver         = {
>> +               .name   = "kunpeng_thermal",
>> +               .acpi_match_table = ACPI_PTR(kunpeng_thermal_acpi_match),
>> +       },
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
> .
>

