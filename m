Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C2F325B30
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 02:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBZBRg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Feb 2021 20:17:36 -0500
Received: from regular1.263xmail.com ([211.150.70.203]:51028 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhBZBRb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2021 20:17:31 -0500
Received: from localhost (unknown [192.168.167.130])
        by regular1.263xmail.com (Postfix) with ESMTP id 0A1297F0;
        Fri, 26 Feb 2021 09:11:15 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P21325T140438822438656S1614301874165605_;
        Fri, 26 Feb 2021 09:11:14 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f4a5708efab962670bcfc1bbf59d8cf6>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: ulf.hansson@linaro.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v2] PM: runtime: Update device status before letting
 suppliers suspend
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <2024466.aZ6alR0V7q@kreacher>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <e49804e9-24f3-006e-0668-f6df2176eafe@rock-chips.com>
Date:   Fri, 26 Feb 2021 09:11:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2024466.aZ6alR0V7q@kreacher>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Rafael:

The patch V2 test works well.

Tested-by: Elaine Zhang <zhangiqng@rock-chips.com>

ÔÚ 2021/2/26 ÉÏÎç2:23, Rafael J. Wysocki Ð´µÀ:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Because the PM-runtime status of the device is not updated in
> __rpm_callback(), attempts to suspend the suppliers of the given
> device triggered by rpm_put_suppliers() called by it may fail.
>
> Fix this by making __rpm_callback() update the device's status to
> RPM_SUSPENDED before calling rpm_put_suppliers() if the current
> status of the device is RPM_SUSPENDING and the callback just invoked
> by it has returned 0 (success).
>
> While at it, modify the code in __rpm_callback() to always check
> the device's PM-runtime status under its PM lock.
>
> Link: https://lore.kernel.org/linux-pm/CAPDyKFqm06KDw_p8WXsM4dijDbho4bb6T4k50UqqvR1_COsp8g@mail.gmail.com/
> Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
> Reported-by: elaine.zhang <zhangqing@rock-chips.com>
> Diagnosed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2:
>     * Initialize the "get" variable to avoid a false-positive warning from
>       the compiler.
>
> ---
>   drivers/base/power/runtime.c |   62 +++++++++++++++++++++++++------------------
>   1 file changed, 37 insertions(+), 25 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -325,22 +325,22 @@ static void rpm_put_suppliers(struct dev
>   static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>   	__releases(&dev->power.lock) __acquires(&dev->power.lock)
>   {
> -	int retval, idx;
>   	bool use_links = dev->power.links_count > 0;
> +	bool get = false;
> +	int retval, idx;
> +	bool put;
>   
>   	if (dev->power.irq_safe) {
>   		spin_unlock(&dev->power.lock);
> +	} else if (!use_links) {
> +		spin_unlock_irq(&dev->power.lock);
>   	} else {
> +		get = dev->power.runtime_status == RPM_RESUMING;
> +
>   		spin_unlock_irq(&dev->power.lock);
>   
> -		/*
> -		 * Resume suppliers if necessary.
> -		 *
> -		 * The device's runtime PM status cannot change until this
> -		 * routine returns, so it is safe to read the status outside of
> -		 * the lock.
> -		 */
> -		if (use_links && dev->power.runtime_status == RPM_RESUMING) {
> +		/* Resume suppliers if necessary. */
> +		if (get) {
>   			idx = device_links_read_lock();
>   
>   			retval = rpm_get_suppliers(dev);
> @@ -355,24 +355,36 @@ static int __rpm_callback(int (*cb)(stru
>   
>   	if (dev->power.irq_safe) {
>   		spin_lock(&dev->power.lock);
> -	} else {
> -		/*
> -		 * If the device is suspending and the callback has returned
> -		 * success, drop the usage counters of the suppliers that have
> -		 * been reference counted on its resume.
> -		 *
> -		 * Do that if resume fails too.
> -		 */
> -		if (use_links
> -		    && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
> -		    || (dev->power.runtime_status == RPM_RESUMING && retval))) {
> -			idx = device_links_read_lock();
> +		return retval;
> +	}
>   
> - fail:
> -			rpm_put_suppliers(dev);
> +	spin_lock_irq(&dev->power.lock);
>   
> -			device_links_read_unlock(idx);
> -		}
> +	if (!use_links)
> +		return retval;
> +
> +	/*
> +	 * If the device is suspending and the callback has returned success,
> +	 * drop the usage counters of the suppliers that have been reference
> +	 * counted on its resume.
> +	 *
> +	 * Do that if the resume fails too.
> +	 */
> +	put = dev->power.runtime_status == RPM_SUSPENDING && !retval;
> +	if (put)
> +		__update_runtime_status(dev, RPM_SUSPENDED);
> +	else
> +		put = get && retval;
> +
> +	if (put) {
> +		spin_unlock_irq(&dev->power.lock);
> +
> +		idx = device_links_read_lock();
> +
> +fail:
> +		rpm_put_suppliers(dev);
> +
> +		device_links_read_unlock(idx);
>   
>   		spin_lock_irq(&dev->power.lock);
>   	}
>
>
>
>
>
>


