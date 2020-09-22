Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1FD273E91
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgIVJcS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 05:32:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbgIVJcS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Sep 2020 05:32:18 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3048B6FD9E563A753E73;
        Tue, 22 Sep 2020 17:32:15 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 22 Sep 2020
 17:32:08 +0800
Subject: Re: [RFC PATCH] PM:runtime:Remove the link state check in function
 rpm_get_supplier()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <1596088129-88814-1-git-send-email-chenxiang66@hisilicon.com>
 <28bc46a7-7140-cc80-43a5-c1de8adfd81f@hisilicon.com>
 <CAJZ5v0hkUqBLw-PjTeP2nSxF1+knTUoFevv3hPQL=6x1t5BcoA@mail.gmail.com>
CC:     Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
        "John Garry" <john.garry@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <3c2764f0-8e8d-3d3e-baff-f3972013e263@hisilicon.com>
Date:   Tue, 22 Sep 2020 17:32:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hkUqBLw-PjTeP2nSxF1+knTUoFevv3hPQL=6x1t5BcoA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



在 2020/9/22 0:02, Rafael J. Wysocki 写道:
> On Mon, Sep 21, 2020 at 9:12 AM chenxiang (M) <chenxiang66@hisilicon.com> wrote:
>>
>>
>> 在 2020/7/30 13:48, chenxiang 写道:
>>> From: Xiang Chen <chenxiang66@hisilicon.com>
>>>
>>> To support runtime PM for hisi SAS driver (the dirver is in directory
>>> drivers/scsi/hisi_sas), we add device link between scsi_device->sdev_gendev
>>> (consumer device) and hisi_hba->dev(supplier device) with flags
>>> DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE.
>>> After runtime suspended consumers and supplier, unload the dirver which
>>> cause a hung. We find that it calls function device_release_driver_internal()
>>> to release supplier device hisi_hba->dev, as the device link is busy,
>>> it sets the device link as DL_STATE_SUPPLIER_UNBIND, and then call function
>>> device_release_driver_internal() to release consumer device
>>> scsi_device->sdev_gendev). Then It will try to call pm_runtime_get_sync()
>>> to resume consumer device, as consumer-supplier relation exists, it will try
>>> to resume supplier first, but as the link state is already set as
>>> DL_STATE_SUPPLIER_UNBIND, so it skips resuming supplier and only resume
>>> consumer which cause a hung (it sends IOs to resume scsi_device while
>>> SAS controller is suspended). Simple flow is as follows:
>>>
>>> device_release_driver_internal -> (supplier device)
>>>       if device_links_busy ->
>>>            device_links_unbind_consumers ->
>>>                ...
>>>                WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND)
>>>                device_release_driver_internal (consumer device)
>>>       pm_runtime_get_sync -> (consumer device)
>>>        ...
>>>        __rpm_callback ->
>>>            rpm_get_suppliers ->
>>>                if link->state == DL_STATE_SUPPLIER_UNBIND -> skip the action of resuming the supplier
>>>                ...
>>>       pm_runtime_clean_up_links
>>>       ...
>> Hi Rafael, do you have any idea about this issue?
>>
>>> It should guarantee correct suspend/resume ordering between a supplier
>>> device and its consumer devices (resume the supplier device before resuming
>>> consumer devices, and suspend consumer devices before suspending supplier
>>> device) for runtime PM, but it seems the check in rpm_get_supplier() breaks
>>> the rule, so remove it.
>>>
>>> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
>>> ---
>>>    drivers/base/power/runtime.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>>> index 9f62790..a8edd92 100644
>>> --- a/drivers/base/power/runtime.c
>>> +++ b/drivers/base/power/runtime.c
>>> @@ -291,8 +291,7 @@ static int rpm_get_suppliers(struct device *dev)
>>>                                device_links_read_lock_held()) {
>>>                int retval;
>>>
>>> -             if (!(link->flags & DL_FLAG_PM_RUNTIME) ||
>>> -                 READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
>>> +             if (!(link->flags & DL_FLAG_PM_RUNTIME))
> AFAICS you need to make the analogous change in rpm_put_suppliers(),
> but apart from this it should be fine.

Thanks, i will add the change in next version.

>
> Thanks!
>
>>>                        continue;
>>>
>>>                retval = pm_runtime_get_sync(link->supplier);
>>
> .
>


