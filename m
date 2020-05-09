Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5721CBE6D
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 09:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgEIHfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 May 2020 03:35:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51908 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728714AbgEIHfr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 9 May 2020 03:35:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 90C86A7A1339BCC1D9DB;
        Sat,  9 May 2020 15:35:44 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 15:35:38 +0800
Subject: Re: [PATCH V3 2/2] thermal: Add HiSilicon Kunpeng thermal driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "shenyang (M)" <shenyang39@huawei.com>, <rui.zhang@intel.com>,
        <amit.kucheria@verdurent.com>
References: <1587455093-33876-1-git-send-email-shenyang39@huawei.com>
 <1587455093-33876-3-git-send-email-shenyang39@huawei.com>
 <53ca3883-9155-c023-7916-10ec8cccf977@linaro.org>
 <0be585d3-1180-7b42-8b51-392a34793f70@huawei.com>
 <b1739246-3639-a6c1-6c0d-275eb2ab0d16@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linuxarm@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5EB65D33.80105@hisilicon.com>
Date:   Sat, 9 May 2020 15:35:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <b1739246-3639-a6c1-6c0d-275eb2ab0d16@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/4/28 22:02, Daniel Lezcano wrote:
> On 28/04/2020 13:58, shenyang (M) wrote:
>> On 2020/4/27 20:13, Daniel Lezcano wrote:
>>> On 21/04/2020 09:44, Yang Shen wrote:
>>>> Support HiSilicon Kunpeng tsensor. the driver will report the max
>>>> temperature for each core.
>>>
>>> As this is a new driver, can you give a bit more details of the hardware
>>> in this description.
>>>
>>> A subsidiary question, why do you want to aggregate the temperatures in
>>> this driver ?
>>>
>>
>> OK. In fact, there are five temperature sensors distributed in the SOC.
>> And our strategy is to collect all temperatures and return the max to
>> the interface.
> 
> The aggregation should be done in the thermal framework not in the driver.
> 
> Why not create one sensor per thermal zone, so giving the opportunity to
> create different configurations with different cooling device ?

Hi Daniel,

In our SoC, we use IMU(Intelligent Management Unit) which is an out of band
management processor to control cooling device. We use fans to cool CPU, one
fan is for one SoC. So getting one temperature for one SoC is enough here.

We also want to report temperature of the SoC from kernel thermal subsystem,
so users get get SoC temperature from sysfs or user space tool, like Im-sensor.
The goal of this driver is just to do this.

Best,
Zhou

> 
> The function thermal_zone_of_get_sensor_id() will return the sensor id
> associated with the thermal zone. So you can get inspiration from
> imx_sc_thermal_probe() to instantiate multiple sensors from the thermal
> zone.
> 
> The platform will end up with one thermal zone per core (assuming that
> is what you have).
> 
> Each thermal zone will be cool down by the same cooling device, the
> thermal framework will aggregate the decision and it will take the max
> cooling level requested by each governor of each thermal zone, that ends
> up to the same result as aggregating the temperature in the driver.
> 
> By doing this, you keep the possibility to do different combinations at
> the DT level for better thermal control with different type of cooling
> device.
> 
> 
>> I will add a description of the hardware in the next version.
>>
> 
> [ ... ]
> 
>>>> +static int kunpeng_thermal_temp_correct(u32 tmp, u32 trim)
>>>> +{
>>>> +    int trim_high = KUNPENG_TSENSOR_TRIM_HIGH(trim);
>>>> +    int trim_low = KUNPENG_TSENSOR_TRIM_LOW(trim);
>>>> +    int val = KUNPENG_TSENSOR_TEMP_VAL(tmp);
>>>> +
>>>> +    if (trim_high == trim_low)
>>>> +        return INT_MIN;
>>>> +
>>>> +    /* temperature of tsensor needs to be calibrated */
>>>> +    return KUNPENG_TSENSOR_BASIC_TRIM_RANGE * (val - trim_low) /
>>>> +           (trim_high - trim_low) + KUNPENG_TSENSOR_BASIC_TMP;
>>>
>>> Is it possible to give some details about why this is done?
>>>
>>
>> The hardware will measure the two standard temperature readings and
>> write them into the registers, and the driver will calibrate the
>> current readings according to the two standard temperature readings.
>>
>> I will add this comment.
>>
> 
> [ ... ]
> 
>>> What is the IMU ?
>>>
>>
>> IMU is stand for Intelligent Management Unit. It functions as a
>> supervisor and a manager of the chip. It has complete SoC
>> components and is totally independent from the application processor
>> system.
>> So the IMU will read the tsensors temperature registers too.
>>
>>> I don't see in this driver anything related to the sensors being shared
>>> with something else.
>>>
>>
>> Yes. This driver use the device independently. But the driver cannot
>> disable devices when it is removed.
>> I add comments here to avoid user confusion.
> 
> I see, the kernel has no knowledge of it.
> 
> Thanks for the clarification.
> 
>>>> + */
>>>> +static int kunpeng_thermal_remove(struct platform_device *pdev)
>>>> +{
>>>> +    struct thermal_zone_device *thermal_zone =
>>>> platform_get_drvdata(pdev);
>>>> +
>>>> +    thermal_zone_device_unregister(thermal_zone);
>>> Why not add a devm_thermal_zone_device_register() ? and get rid of this
>>> function ?
>>>
>>
>> Do  you ask me to add this function in thermal_core.c?
> 
> Yes
> 
> 
