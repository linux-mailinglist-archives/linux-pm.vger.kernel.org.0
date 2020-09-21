Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB4271B3E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIUHMI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 03:12:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbgIUHMI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Sep 2020 03:12:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2C66A4D19336C34FA5C8;
        Mon, 21 Sep 2020 15:12:05 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 15:11:58 +0800
Subject: Re: [RFC PATCH] PM:runtime:Remove the link state check in function
 rpm_get_supplier()
To:     <rafael@kernel.org>, <pavel@ucw.cz>, <sre@kernel.org>
References: <1596088129-88814-1-git-send-email-chenxiang66@hisilicon.com>
CC:     <john.garry@huawei.com>, <linux-pm@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <28bc46a7-7140-cc80-43a5-c1de8adfd81f@hisilicon.com>
Date:   Mon, 21 Sep 2020 15:11:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1596088129-88814-1-git-send-email-chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



ÔÚ 2020/7/30 13:48, chenxiang Ð´µÀ:
> From: Xiang Chen <chenxiang66@hisilicon.com>
>
> To support runtime PM for hisi SAS driver (the dirver is in directory
> drivers/scsi/hisi_sas), we add device link between scsi_device->sdev_gendev
> (consumer device) and hisi_hba->dev(supplier device) with flags
> DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE.
> After runtime suspended consumers and supplier, unload the dirver which
> cause a hung. We find that it calls function device_release_driver_internal()
> to release supplier device hisi_hba->dev, as the device link is busy,
> it sets the device link as DL_STATE_SUPPLIER_UNBIND, and then call function
> device_release_driver_internal() to release consumer device
> scsi_device->sdev_gendev). Then It will try to call pm_runtime_get_sync()
> to resume consumer device, as consumer-supplier relation exists, it will try
> to resume supplier first, but as the link state is already set as
> DL_STATE_SUPPLIER_UNBIND, so it skips resuming supplier and only resume
> consumer which cause a hung (it sends IOs to resume scsi_device while
> SAS controller is suspended). Simple flow is as follows:
>
> device_release_driver_internal -> (supplier device)
>      if device_links_busy ->
> 	    device_links_unbind_consumers ->
> 		...
> 		WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND)
> 		device_release_driver_internal (consumer device)
>      pm_runtime_get_sync -> (consumer device)
> 	...
> 	__rpm_callback ->
> 	    rpm_get_suppliers ->
> 		if link->state == DL_STATE_SUPPLIER_UNBIND -> skip the action of resuming the supplier
> 		...
>      pm_runtime_clean_up_links
>      ...

Hi Rafael, do you have any idea about this issue?

> It should guarantee correct suspend/resume ordering between a supplier
> device and its consumer devices (resume the supplier device before resuming
> consumer devices, and suspend consumer devices before suspending supplier
> device) for runtime PM, but it seems the check in rpm_get_supplier() breaks
> the rule, so remove it.
>
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>   drivers/base/power/runtime.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 9f62790..a8edd92 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -291,8 +291,7 @@ static int rpm_get_suppliers(struct device *dev)
>   				device_links_read_lock_held()) {
>   		int retval;
>   
> -		if (!(link->flags & DL_FLAG_PM_RUNTIME) ||
> -		    READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
> +		if (!(link->flags & DL_FLAG_PM_RUNTIME))
>   			continue;
>   
>   		retval = pm_runtime_get_sync(link->supplier);


