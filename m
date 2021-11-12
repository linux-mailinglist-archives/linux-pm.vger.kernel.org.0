Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F4044E02F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 03:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhKLCTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 21:19:15 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26303 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhKLCTP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Nov 2021 21:19:15 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hr2Br1zShzbhrh;
        Fri, 12 Nov 2021 10:11:32 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Fri, 12 Nov 2021 10:16:23 +0800
Received: from [10.174.179.215] (10.174.179.215) by
 dggema769-chm.china.huawei.com (10.1.198.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Fri, 12 Nov 2021 10:16:21 +0800
Subject: Re: [PATCH -next] thermal: int340x: processor_thermal: Fix build
 error
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211111070716.20260-1-yuehaibing@huawei.com>
 <b91c26d828b24479369fa1f17d8d03c324b5bebd.camel@linux.intel.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <6446d19d-9580-c172-79c7-7cb40815cedb@huawei.com>
Date:   Fri, 12 Nov 2021 10:16:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <b91c26d828b24479369fa1f17d8d03c324b5bebd.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021/11/11 22:51, Srinivas Pandruvada wrote:
> On Thu, 2021-11-11 at 15:07 +0800, YueHaibing wrote:
>> drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c: In
>> function ‘send_mbox_cmd’:
>> drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c:79:16:
>>  error: implicit declaration of function ‘readq’; did you mean
>> ‘readl’? [-Werror=implicit-function-declaration]
>>     *cmd_resp = readq((void __iomem *) (proc_priv->mmio_base +
>> MBOX_OFFSET_DATA));
>>                 ^~~~~
>>                 readl
>>
>> Add missing include to fix this.
> Have you checked a patch titled "thermal/drivers/int340x: limit Kconfig
> to 64-bit"?

Thanks for your info, the patch fix the issue.

> 
> Thanks,
> Srinivas
> 
>>
>> Fixes: aeb58c860dc5 ("thermal/drivers/int340x: processor_thermal:
>> Suppot 64 bit RFIM responses")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git
>> a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
>> b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
>> index a86521973dad..01008ae00e7f 100644
>> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
>> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/pci.h>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>>  #include "processor_thermal_device.h"
>>  
>>  #define MBOX_CMD_WORKLOAD_TYPE_READ    0x0E
> 
> 
> .
> 
