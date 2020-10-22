Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6913E296032
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444531AbgJVNkl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 09:40:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437595AbgJVNkk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 09:40:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9CE98CCD67AE021F82B3;
        Thu, 22 Oct 2020 21:40:37 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 22 Oct 2020
 21:40:35 +0800
Subject: Re: [PATCH 3/3] PM: runtime: Resume the device earlier in
 __device_release_driver()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <6543936.FbWAdBN1tG@kreacher> <1708806.S9fAqql2gf@kreacher>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Saravana Kannan <saravanak@google.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <e9466a28-5c6a-f88a-51ab-547ecc21e5d0@hisilicon.com>
Date:   Thu, 22 Oct 2020 21:40:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1708806.S9fAqql2gf@kreacher>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

在 2020/10/22 3:14, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since the device is resumed from runtime-suspend in
> __device_release_driver() anyway, it is better to do that before
> looking for busy managed device links from it to consumers, because
> if there are any, device_links_unbind_consumers() will be called
> and it will cause the consumer devices' drivers to unbind, so the
> consumer devices will be runtime-resumed.  In turn, resuming each
> consumer device will cause the supplier to be resumed and when the
> runtime PM references from the given consumer to it are dropped, it
> may be suspended.  Then, the runtime-resume of the next consumer
> will cause the supplier to resume again and so on.
>
> Update the code accordingly.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
> Cc: All applicable <stable@vger.kernel.org> # All applicable
> ---
>   drivers/base/dd.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/base/dd.c
> ===================================================================
> --- linux-pm.orig/drivers/base/dd.c
> +++ linux-pm/drivers/base/dd.c
> @@ -1117,6 +1117,8 @@ static void __device_release_driver(stru
>   
>   	drv = dev->driver;
>   	if (drv) {
> +		pm_runtime_get_sync(dev);
> +
>   		while (device_links_busy(dev)) {
>   			__device_driver_unlock(dev, parent);
>   
> @@ -1132,8 +1134,6 @@ static void __device_release_driver(stru

pm_runtime_put_sync() is required to be called if existed from here.

>   				return;
>   		}
>   
> -		pm_runtime_get_sync(dev);
> -
>   		driver_sysfs_remove(dev);
>   
>   		if (dev->bus)
>
>
>
>
> .
>


