Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DC2316299
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 10:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhBJJoh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 04:44:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12606 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBJJmz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 04:42:55 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DbFB74MS2z165Dl;
        Wed, 10 Feb 2021 17:40:47 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Wed, 10 Feb 2021
 17:42:01 +0800
Subject: Re: [PATCH v2 2/4] hwmon: Use subdir-ccflags-* to inherit debug flag
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <gregkh@linuxfoundation.org>, <jdelvare@suse.com>,
        <giometti@enneenne.com>, <abbotti@mev.co.uk>,
        <hsweeten@visionengravers.com>, <kw@linux.com>,
        <helgaas@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kbuild@vger.kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <prime.zeng@huawei.com>, <linuxarm@openeuler.org>
References: <1612868899-9185-1-git-send-email-yangyicong@hisilicon.com>
 <1612868899-9185-3-git-send-email-yangyicong@hisilicon.com>
 <20210209150658.GA31002@roeck-us.net>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <128d71da-b07b-237c-d6a5-205513f3b093@hisilicon.com>
Date:   Wed, 10 Feb 2021 17:42:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210209150658.GA31002@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021/2/9 23:06, Guenter Roeck wrote:
> On Tue, Feb 09, 2021 at 07:08:17PM +0800, Yicong Yang wrote:
>> From: Junhao He <hejunhao2@hisilicon.com>
>>
>> We use ccflags-$(CONFIG_HWMON_DEBUG_CHIP) for the debug
>> message in drivers/hwmon, but the DEBUG flag will not pass to
>> the subdirectory.
>>
>> Considering CONFIG_HWMON_DEBUG_CHIP intends to have DEBUG
>> recursively in driver/hwmon. It will be clearer
>> to use subdir-ccflags-* instead of ccflags-* to inherit
>> the debug settings from Kconfig when traversing subdirectories,
>> and it will avoid omittance of DEBUG define when debug messages
>> added in the subdirectories.
>>
> 
> The above paragraph doesn't add clarity and may as well be dropped.
> On the other side, the commit message still doesn't mention that
> pr_debug depends on DEBUG, which I am sure many people don't know
> or remember. This is the prime reason why this patch is acceptable,
> so it most definitely needs to be mentioned here.

sorry, i didn't realize that you mean this. will impove this in the next
version after the lunar new year holiday over.

Thanks,
Yicong

> 
> Guenter
> 
>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/hwmon/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 09a86c5..1c0c089 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -201,5 +201,5 @@ obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
>>  obj-$(CONFIG_SENSORS_OCC)	+= occ/
>>  obj-$(CONFIG_PMBUS)		+= pmbus/
>>  
>> -ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>> +subdir-ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>>  
>> -- 
>> 2.8.1
>>
> 
> .
> 

