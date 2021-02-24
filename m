Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66E632361D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 04:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhBXDnJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Feb 2021 22:43:09 -0500
Received: from regular1.263xmail.com ([211.150.70.195]:36752 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhBXDnI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2021 22:43:08 -0500
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id C902D1CB0;
        Wed, 24 Feb 2021 11:37:07 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P17142T139833559475968S1614137826308926_;
        Wed, 24 Feb 2021 11:37:07 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <81531836e9dde48ef5fd1b797e21ffcd>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: kever.yang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [REPORT_ISSUE]: RK3399 pd power down failed
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     heiko <heiko@sntech.de>, Finley Xiao <finley.xiao@rock-chips.com>,
        "len.brown" <len.brown@intel.com>, pavel <pavel@ucw.cz>,
        gregkh <gregkh@linuxfoundation.org>,
        khilman <khilman@kernel.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        "Huang, Tao" <huangtao@rock-chips.com>,
        =?UTF-8?B?6LCi5L+u6ZGr?= <tony.xie@rock-chips.com>,
        =?UTF-8?B?5p2o5Yev?= <kever.yang@rock-chips.com>
References: <20210120172939160049119@rock-chips.com>
 <CAPDyKFqm06KDw_p8WXsM4dijDbho4bb6T4k50UqqvR1_COsp8g@mail.gmail.com>
 <5598462.KkIXRrj88c@kreacher>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <130265d7-25dc-2bb4-3120-a9730d2d85e1@rock-chips.com>
Date:   Wed, 24 Feb 2021 11:37:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5598462.KkIXRrj88c@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,  Rafael:

在 2021/2/24 上午1:09, Rafael J. Wysocki 写道:
> On Tuesday, February 23, 2021 12:30:39 PM CET Ulf Hansson wrote:
>> On Wed, 20 Jan 2021 at 10:30, zhangqing@rock-chips.com
>> <zhangqing@rock-chips.com> wrote:
>>> Hi, Heiko :
>>>
>>> In rk3399 evb board,  I found a probabilistic problem about PD. Turning off PD occasionally failed.
>>>
>>> log show：
>>> Open the vop
>>> #modetest -M rockchip -s 42@36:1536x2048 -P 31@36:1536x2048@AR24 -a
>>>
>>> close the vop
>>> #enter
>>>
>>>   # cat sys/kernel/debug/pm_genpd/pm_genpd_summary
>>> domain                          status          slaves
>>>      /device                                             runtime status
>>> ----------------------------------------------------------------------
>>> pd_vopl                         off
>>> pd_vopb                         on
>>>      /devices/platform/ff903f00.iommu                     suspended
>>>      /devices/platform/ff900000.vop                          suspended
>>>
>>> I have checked the codes and concluded that there is a window of time for PD to be closed when using the device link. Once queue_work is executed immediately,  PD power off may be failed.
>>> The process is as follows:
>>>
>>> VOP requests to power off PD:
>>> pm_runtime_put_sync(vop->dev)
>>>      -> rpm_idle(vop)
>>>          -> rpm_suspend(vop)
>>>              -> __update_runtime_status(dev, RPM_SUSPENDING)
>>>                  -> rpm_callback(vop)
>>>                      -> __rpm_callback(vop)
>>>                          -> do power off pd callback(genpd_power_off)
>>>                              -> list_for_each_entry(pdd, &genpd->dev_list, list_node), ff900000.vop: suspending， ff903f00.iommu : active，so not_suspended = 2 return -EBUSY; Not really power off PD。
>>>                                  -> Handle link device callbacks according to device link（rpm_put_suppliers）
>>>                                      -> pm_runtime_put(link->supplier)
>>>                                          -> queue_work(pm_wq, &dev->power.work), execute immediately
>>>                                              ->rpm_idle(iommu)
>>>                                                  -> rpm_suspend(iommu)
>>>                                                      -> rpm_callback(iommu)
>>>                                                          -> rk_iommu_suspend
>>>                                                              ->  do power off pd callback(genpd_power_off)
>>>                                                                  -> list_for_each_entry(pdd, &genpd->dev_list, list_node), ff900000.vop: suspending， ff903f00.iommu : suspending，so not_suspended = 2 return -EBUSY; Not really power off PD。
>>>                                                                      -> iommu do __update_runtime_status(dev, RPM_SUSPENDED)
>>>                                                                          -> vop do __update_runtime_status(dev, RPM_SUSPENDED)
>> So, rpm_suspend() tries to suspend the supplier device link via
>> rpm_put_suppliers(), before it has updated its consumer device's state
>> to RPM_SUSPENDED.
>>
>> This looks worrying to me, both because it's seems wrong to allow a
>> supplier to be suspended before a consumers device's state has reached
>> RPM_SUSPENDED - but also because it's not consistent with the way we
>> treat parent/child devices. The child's state will always be set to
>> RPM_SUSPENDED, before we try to suspend its parent by calling
>> rpm_idle() for it in rpm_suspend().
>>
>> Rafael, what's your take on this? Would it make sense to align the
>> behavior for consumer/supplier-links in rpm_suspend() according to
>> child/parents?
> Suspending the suppliers before changing the consumer RPM status to
> "suspended" is indeed incorrect, which is something I overlooked when
> writing the code in question.
>
> Fortunately, it seems to be relatively easy to address.
>
> Please see the appended tentative patch (untested).  It also avoids reading
> runtime_status outside the lock which is arguably fishy.
>
> ---
>   drivers/base/power/runtime.c |   24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -330,7 +330,11 @@ static int __rpm_callback(int (*cb)(stru
>   
>   	if (dev->power.irq_safe) {
>   		spin_unlock(&dev->power.lock);
> +	} else if (!use_links) {
> +		spin_unlock_irq(&dev->power.lock);
>   	} else {
> +		bool get = dev->power.runtime_status == RPM_RESUMING;
> +
>   		spin_unlock_irq(&dev->power.lock);
>   
>   		/*
> @@ -340,7 +344,7 @@ static int __rpm_callback(int (*cb)(stru
>   		 * routine returns, so it is safe to read the status outside of
>   		 * the lock.
>   		 */
> -		if (use_links && dev->power.runtime_status == RPM_RESUMING) {
> +		if (get) {
>   			idx = device_links_read_lock();
>   
>   			retval = rpm_get_suppliers(dev);
> @@ -355,7 +359,21 @@ static int __rpm_callback(int (*cb)(stru
>   
>   	if (dev->power.irq_safe) {
>   		spin_lock(&dev->power.lock);
> +	} if (!use_links) {
> +		spin_lock_irq(&dev->power.lock);
>   	} else {
> +		bool put;
> +
> +		spin_lock_irq(&dev->power.lock);
> +
> +		put = dev->power.runtime_status == RPM_SUSPENDING && !retval;
> +		if (put)
> +			__update_runtime_status(dev, RPM_SUSPENDED);
> +		else
> +			put = dev->power.runtime_status == RPM_RESUMING && retval;
> +
> +		spin_unlock_irq(&dev->power.lock);
> +
>   		/*
>   		 * If the device is suspending and the callback has returned
>   		 * success, drop the usage counters of the suppliers that have
> @@ -363,9 +381,7 @@ static int __rpm_callback(int (*cb)(stru
>   		 *
>   		 * Do that if resume fails too.
>   		 */
> -		if (use_links
> -		    && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
> -		    || (dev->power.runtime_status == RPM_RESUMING && retval))) {
> +		if (put) {
>   			idx = device_links_read_lock();
>   
>    fail:

Thank you for your reply.

I have tested this patch, and it's works well.Perfect solution to our 
problem.

We expect this patch to be committed to the mainline branch.

>
>
>
>


