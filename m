Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF1ADC5C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 08:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfD2G4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 02:56:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726764AbfD2G4w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Apr 2019 02:56:52 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5ECC985FD7590DC8E2CB;
        Mon, 29 Apr 2019 14:56:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.180) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Apr 2019
 14:56:44 +0800
Subject: Re: [PATCH next 23/25] thermal: Use dev_get_drvdata()
To:     Zhang Rui <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
 <20190423075020.173734-24-wangkefeng.wang@huawei.com>
 <1556509663.2396.8.camel@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <c835c3db-a070-94d5-d4d1-ae9bb521b76d@huawei.com>
Date:   Mon, 29 Apr 2019 14:55:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1556509663.2396.8.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.177.19.180]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 2019/4/29 11:47, Zhang Rui wrote:
> On 二, 2019-04-23 at 15:50 +0800, Kefeng Wang wrote:
>> Using dev_get_drvdata directly.
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  .../intel/int340x_thermal/processor_thermal_device.c      | 8 +-----
>> --
>>  drivers/thermal/st/stm_thermal.c                          | 6 ++----
>>  2 files changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git
>> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
>> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
>> index 8e1cf4d789be..4ad54b8d4778 100644
>> ---
>> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
>> +++
>> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
>> @@ -81,8 +81,6 @@ static ssize_t
>> power_limit_##index##_##suffix##_show(struct device *dev, \
>>  					struct device_attribute
>> *attr, \
>>  					char *buf) \
>>  { \
>> -	struct pci_dev *pci_dev; \
>> -	struct platform_device *pdev; \
>>  	struct proc_thermal_device *proc_dev; \
>>  	\
>>  	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
>> @@ -91,11 +89,7 @@ static ssize_t
>> power_limit_##index##_##suffix##_show(struct device *dev, \
>>  	} \
>>  	\
>>  	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) { \
>> -		pdev = to_platform_device(dev); \
>> -		proc_dev = platform_get_drvdata(pdev); \
>> -	} else { \
>> -		pci_dev = to_pci_dev(dev); \
>> -		proc_dev = pci_get_drvdata(pci_dev); \
>> +		proc_dev = dev_get_drvdata(dev); \
>>  	} \
>>  	return sprintf(buf, "%lu\n",\
>>  	(unsigned long)proc_dev->power_limits[index].suffix * 1000);
>> \
> Sumeet has a patch to fix the same issue, which has been in my tree
> https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git/commit
> /?h=next&id=1948d498dcf680bc650391f23da2f97e59f9126d
>
> Plus, the previous fix is wrong because proc_dev will be left
> uninitialized if proc_thermal_emum_mode equals PROC_THERMAL_PCI.

oh, Sumeet's patch is the right one and much cleaner.


>
> thanks,
> rui
>
>> diff --git a/drivers/thermal/st/stm_thermal.c
>> b/drivers/thermal/st/stm_thermal.c
>> index bbd73c5a4a4e..cf9ddc52f30e 100644
>> --- a/drivers/thermal/st/stm_thermal.c
>> +++ b/drivers/thermal/st/stm_thermal.c
>> @@ -570,8 +570,7 @@ static int stm_thermal_prepare(struct
>> stm_thermal_sensor *sensor)
>>  static int stm_thermal_suspend(struct device *dev)
>>  {
>>  	int ret;
>> -	struct platform_device *pdev = to_platform_device(dev);
>> -	struct stm_thermal_sensor *sensor =
>> platform_get_drvdata(pdev);
>> +	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
>>  
>>  	ret = stm_thermal_sensor_off(sensor);
>>  	if (ret)
>> @@ -585,8 +584,7 @@ static int stm_thermal_suspend(struct device
>> *dev)
>>  static int stm_thermal_resume(struct device *dev)
>>  {
>>  	int ret;
>> -	struct platform_device *pdev = to_platform_device(dev);
>> -	struct stm_thermal_sensor *sensor =
>> platform_get_drvdata(pdev);
>> +	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
>>  
>>  	ret = stm_thermal_prepare(sensor);
>>  	if (ret)
> .
>

