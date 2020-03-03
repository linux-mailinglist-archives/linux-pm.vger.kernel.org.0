Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE458176D7B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 04:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCCDRx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 22:17:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbgCCDRx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Mar 2020 22:17:53 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AC924DED1612D2282D3A;
        Tue,  3 Mar 2020 11:17:50 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.207) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 11:17:42 +0800
Subject: Re: [PATCH -next] drivers/base/power: fix build error without SYSFS
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <chenzhou10@huawei.com>,
        <rjw@rjwysocki.net>, <pavel@ucw.cz>
References: <20200302092918.40163-1-yaohongbo@huawei.com>
 <20200302093111.eavix4e65otpudb5@wittgenstein>
From:   Hongbo Yao <yaohongbo@huawei.com>
Message-ID: <c08c5a14-3188-cc67-f0c7-53f361552226@huawei.com>
Date:   Tue, 3 Mar 2020 11:17:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200302093111.eavix4e65otpudb5@wittgenstein>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.207]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2020/3/2 17:31, Christian Brauner wrote:
> On Mon, Mar 02, 2020 at 05:29:18PM +0800, Hongbo Yao wrote:
>> If CONFIG_SYSFS=n, the following error is seen while building 
>> drivers/base/power/sysfs.c:
>>
>> drivers/base/power/sysfs.c: In function dpm_sysfs_change_owner:
>> drivers/base/power/sysfs.c:708:44: error: passing argument 2 of
>> sysfs_group_change_owner from incompatible pointer type
>> [-Werror=incompatible-pointer-types]
>>   rc = sysfs_group_change_owner(&dev->kobj, &pm_attr_group, kuid, kgid);
>>                                             ^
>> In file included from ./include/linux/kobject.h:20:0,
>>                  from ./include/linux/device.h:17,
>>                  from drivers/base/power/sysfs.c:3:
>> ./include/linux/sysfs.h:564:19: note: expected const struct
>> attribute_group ** but argument is of type const struct attribute_group *
>>
>> dpm_sysfs_change_owner() should only used when CONFIG_SYSFS is
>> defined.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 3b52fc5d7876 ("drivers/base/power: add dpm_sysfs_change_owner()")
>> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> 
> Thanks for catching this!
> An organizational comment first. The series this belongs to is sitting
> in Dave Miller's net-next tree. So this fix needs to go through his tree
> to. This just means, you should Cc the netdev kernel mailing list and
> append make the subject
> [PATCH net-next] drivers/base/power: fix build error without SYSFS
> .

  Thanks, I'll resend it with this tag .


> But about the fix. It strikes me as odd that this fails in pm_attr_group
> since dpm_sysfs_add() doesn't but also unconditionally accesses pm_attr_group.

  The two functions have different parameter types when CONFIG_SYSFS=n.

> Christian
> 
> .
> 

