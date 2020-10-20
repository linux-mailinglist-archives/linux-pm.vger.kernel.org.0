Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC429330A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 04:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgJTCYB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 22:24:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730333AbgJTCYB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Oct 2020 22:24:01 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 90530E5B8FA64ADC1577;
        Tue, 20 Oct 2020 10:23:58 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 10:23:50 +0800
Subject: Re: [PATCH v2] PM:runtime:Remove the link state check in function
 rpm_get_supplier() and rpm_put_supplier()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <1600780266-155908-1-git-send-email-chenxiang66@hisilicon.com>
 <CAJZ5v0jXWV0ewLWbn2Fabp1HsK8oCsio3J1h7UMr5ZEcVTGjqg@mail.gmail.com>
 <CAJZ5v0h6Sf9zpKFZsmzwpOiSWnqrASEo8PQVr5rTm=pwUxM-bw@mail.gmail.com>
CC:     Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <3b56a749-b145-6a41-c069-571ca784ca9b@hisilicon.com>
Date:   Tue, 20 Oct 2020 10:23:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h6Sf9zpKFZsmzwpOiSWnqrASEo8PQVr5rTm=pwUxM-bw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

在 2020/10/20 1:03, Rafael J. Wysocki 写道:
> On Fri, Sep 25, 2020 at 5:02 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Tue, Sep 22, 2020 at 3:15 PM chenxiang <chenxiang66@hisilicon.com> wrote:
>>> From: Xiang Chen <chenxiang66@hisilicon.com>
>>>
>>> To support runtime PM for hisi SAS driver (the driver is in directory
>>> drivers/scsi/hisi_sas), we add device link between scsi_device->sdev_gendev
>>> (consumer device) and hisi_hba->dev(supplier device) with flags
>>> DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE.
>>> After runtime suspended consumers and supplier, unload the dirver which
>>> cause a hung. We find that it calls function device_release_driver_internal()
>>> to release supplier device hisi_hba->dev, as the device link is busy,
>>> it sets the device link as DL_STATE_SUPPLIER_UNBIND, and then call function
>>> device_release_driver_internal() to release consumer device
>>> scsi_device->sdev_gendev). Then it will try to call pm_runtime_get_sync()
>>> to resume consumer device, as consumer-supplier relation exists, it will try
>>> to resume supplier first,
> It looks like I have overlooked one thing here.
>
> Does it help (without the $subject patch) to move the
> pm_runtime_get_sync(dev) in __device_release_driver() before the while
> (device_links_busy(dev)) loop?

I have tested it, and it also solve the issue.


>
>>> but as the link state is already set as
>>> DL_STATE_SUPPLIER_UNBIND, so it skips resuming supplier and only resume
>>> consumer which cause a hung (it sends IOs to resume scsi_device while
>>> SAS controller is suspended). Simple flow is as follows:
>>>
>>> device_release_driver_internal -> (supplier device)
>>>      if device_links_busy ->
>>>          device_links_unbind_consumers ->
>>>              ...
>>>              WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND)
>>>              device_release_driver_internal (consumer device)
>>>      pm_runtime_get_sync -> (consumer device)
>>>          ...
>>>          __rpm_callback ->
>>>              rpm_get_suppliers ->
>>>                  if link->state == DL_STATE_SUPPLIER_UNBIND -> skip the action of resuming the supplier
>>>                  ...
>>>      pm_runtime_clean_up_links
>>>      ...
>>>
>>> It should guarantee correct suspend/resume ordering between a supplier
>>> device and its consumer devices (resume the supplier device before resuming
>>> consumer devices, and suspend consumer devices before suspending supplier
>>> device) for runtime PM, but it seems the checks in rpm_get_supplier() and
>>> rpm_put_supplier() break the rule, so remove them.
>>>
>>> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
>>> ---
>>>   drivers/base/power/runtime.c | 5 +----
>>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>>> index 8143210..6f605f7 100644
>>> --- a/drivers/base/power/runtime.c
>>> +++ b/drivers/base/power/runtime.c
>>> @@ -291,8 +291,7 @@ static int rpm_get_suppliers(struct device *dev)
>>>                                  device_links_read_lock_held()) {
>>>                  int retval;
>>>
>>> -               if (!(link->flags & DL_FLAG_PM_RUNTIME) ||
>>> -                   READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
>>> +               if (!(link->flags & DL_FLAG_PM_RUNTIME))
>>>                          continue;
>>>
>>>                  retval = pm_runtime_get_sync(link->supplier);
>>> @@ -312,8 +311,6 @@ static void rpm_put_suppliers(struct device *dev)
>>>
>>>          list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>>>                                  device_links_read_lock_held()) {
>>> -               if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
>>> -                       continue;
>>>
>>>                  while (refcount_dec_not_one(&link->rpm_active))
>>>                          pm_runtime_put(link->supplier);
>>> --
>> Applied as 5.10 material with some edits in the subject and changelog, thanks!
> I may need to revert it, because it introduced a (theoretical for now)
> race condition between PM-runtime and pm_runtime_clean_up_links().
>
> Thanks!
>
> .
>


