Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC15323A0A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 10:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhBXJ6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 04:58:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12996 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhBXJ5M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 04:57:12 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dlrqx6LFrzjRHk;
        Wed, 24 Feb 2021 17:54:53 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Feb 2021
 17:56:20 +0800
Subject: Re: [PATCH 1/4] driver core: Use subdir-ccflags-* to inherit debug
 flag
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <giometti@enneenne.com>, <abbotti@mev.co.uk>,
        <hsweeten@visionengravers.com>, <kw@linux.com>,
        <helgaas@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kbuild@vger.kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <linuxarm@openeuler.org>, <prime.zeng@huawei.com>
References: <1612518255-23052-1-git-send-email-yangyicong@hisilicon.com>
 <1612518255-23052-2-git-send-email-yangyicong@hisilicon.com>
 <YB0Vk6ERJ3lFc3WD@kroah.com>
 <08017751-a1be-ea07-50de-73d14ab6d57e@hisilicon.com>
 <YCEWtxYgbRPET4Sr@kroah.com>
 <1f0b2f37-db56-c220-dfe1-8c376031404f@hisilicon.com>
 <20210210114203.jvhst2veqbx73r5g@maple.lan>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <ea4ff7f8-11c8-010c-7b6e-f7faa4e14db4@hisilicon.com>
Date:   Wed, 24 Feb 2021 17:56:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210210114203.jvhst2veqbx73r5g@maple.lan>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021/2/10 19:42, Daniel Thompson wrote:
> On Mon, Feb 08, 2021 at 09:09:20PM +0800, Yicong Yang wrote:
>> On 2021/2/8 18:47, Greg KH wrote:
>>> On Mon, Feb 08, 2021 at 06:44:52PM +0800, Yicong Yang wrote:
>>>> On 2021/2/5 17:53, Greg KH wrote:
>>>>> What does this offer in benefit of the existing way?  What is it fixing?
>>>>> Why do this "churn"?
>>>>
>>>> currently we have added ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG in the Makefile
>>>> of driver/base and driver/base/power, but not in the subdirectory
>>>> driver/base/firmware_loader. we cannot turn the debug on for subdirectory
>>>> firmware_loader if we config DEBUG_DRIVER and there is no kconfig option
>>>> for the it.
>>>
>>> Is that necessary?  Does that directory need it?
>>
>> there are several debug prints in firmware_loader/main.c:
>>
>> ./main.c:207:   pr_debug("%s: fw-%s fw_priv=%p\n", __func__, fw_name, fw_priv);
>> ./main.c:245:                   pr_debug("batched request - sharing the same struct fw_priv and lookup for multiple requests\n");
>> <snip>
> 
> Even if these are not in scope for CONFIG_DEBUG_DRVIER there is a
> config option that would allow you to observe them without changing
> any code (CONFIG_DYNAMIC_DEBUG).
> 

yes. they're two mechanisms of debug. i think it's the right thing to make
both work properly.

> 
> Daniel.
> 
> .
> 

