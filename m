Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DBD1D0A8F
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 10:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgEMINO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 04:13:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbgEMINO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 May 2020 04:13:14 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 37502C7752804B7190DE;
        Wed, 13 May 2020 16:13:11 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 13 May 2020 16:13:01 +0800
Subject: Re: [PATCH V3 2/2] thermal: Add HiSilicon Kunpeng thermal driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "shenyang (M)" <shenyang39@huawei.com>, <rui.zhang@intel.com>,
        <amit.kucheria@verdurent.com>
References: <1587455093-33876-1-git-send-email-shenyang39@huawei.com>
 <1587455093-33876-3-git-send-email-shenyang39@huawei.com>
 <53ca3883-9155-c023-7916-10ec8cccf977@linaro.org>
 <0be585d3-1180-7b42-8b51-392a34793f70@huawei.com>
 <b1739246-3639-a6c1-6c0d-275eb2ab0d16@linaro.org>
 <5EB65D33.80105@hisilicon.com>
 <96c7578e-25cf-d258-6505-8c1c631dbe82@linaro.org>
 <5EB8A9DC.9030004@hisilicon.com>
 <85f9f90f-2b67-4cfd-cc28-b14e037755b7@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linuxarm@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5EBBABF1.1060207@hisilicon.com>
Date:   Wed, 13 May 2020 16:12:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <85f9f90f-2b67-4cfd-cc28-b14e037755b7@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/5/11 16:14, Daniel Lezcano wrote:
> On 11/05/2020 03:26, Zhou Wang wrote:
>> On 2020/5/10 13:04, Daniel Lezcano wrote:
>>> On 09/05/2020 09:35, Zhou Wang wrote:
>>>> On 2020/4/28 22:02, Daniel Lezcano wrote:
>>>>> On 28/04/2020 13:58, shenyang (M) wrote:
>>>>>> On 2020/4/27 20:13, Daniel Lezcano wrote:
>>>>>>> On 21/04/2020 09:44, Yang Shen wrote:
>>>>>>>> Support HiSilicon Kunpeng tsensor. the driver will report the max
>>>>>>>> temperature for each core.
>>>>>>>
>>>>>>> As this is a new driver, can you give a bit more details of the hardware
>>>>>>> in this description.
>>>>>>>
>>>>>>> A subsidiary question, why do you want to aggregate the temperatures in
>>>>>>> this driver ?
>>>>>>>
>>>>>>
>>>>>> OK. In fact, there are five temperature sensors distributed in the SOC.
>>>>>> And our strategy is to collect all temperatures and return the max to
>>>>>> the interface.
>>>>>
>>>>> The aggregation should be done in the thermal framework not in the driver.
>>>>>
>>>>> Why not create one sensor per thermal zone, so giving the opportunity to
>>>>> create different configurations with different cooling device ?
>>>>
>>>> Hi Daniel,
>>>>
>>>> In our SoC, we use IMU(Intelligent Management Unit) which is an out of band
>>>> management processor to control cooling device. We use fans to cool CPU, one
>>>> fan is for one SoC. So getting one temperature for one SoC is enough here.
>>>>
>>>> We also want to report temperature of the SoC from kernel thermal subsystem,
>>>> so users get get SoC temperature from sysfs or user space tool, like Im-sensor.
>>>> The goal of this driver is just to do this.
>>>
>>> Are you saying you don't care of any cooling devices from the kernel as
>>> the IMU is taking care of it ?
>>
>> Yes.
>>
>>>
>>> Do you have a pointer to a DT where the thermal zones are defined?
>>
>> These sensors are in an aarch64 server system(Kunpeng920), which is based on ACPI.
> 
> Ah right.
> 
> What is the benefit of hiding the real hardware by taking the max value
> of all the sensors and providing to the userspace a truncated view of
> what is happening on the system?

As above discussion, we only want to show the temperature of SoCs, it
is simple and can satisfy our requirement.

As the cooling devices are fans in SoC level, exporting lower level sensors
seems not much useful in the future too.

And user can get the temperature of SoCs by the server's BMC Web interface
according to IMU. We also make temperatures to be the same value in both scenarios

Best,
Zhou

> 
> Why not simply register a thermal_zone_device per sensor and get rid of
> the 'max' value? So the userspace can have a correct view of the thermal
> behavior of its system.
> 
> 
> 
> 
