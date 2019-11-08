Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36149F4574
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 12:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfKHLLR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 06:11:17 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54553 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfKHLLR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 06:11:17 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id d53db4b0a350beab; Fri, 8 Nov 2019 12:11:15 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Shen Kai <shenkai8@huawei.com>
Cc:     viresh.kumar@linaro.org, hushiyuan@huawei.com,
        linfeilong@huawei.com, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3]cpufreq: add NULL check to the store method of cpufreq
Date:   Fri, 08 Nov 2019 12:11:15 +0100
Message-ID: <3342762.qvnmYYrl9k@kreacher>
In-Reply-To: <1573103297-7252-1-git-send-email-shenkai8@huawei.com>
References: <20191107030601.xqe2tpcprkg7epul@vireshk-i7> <1573103297-7252-1-git-send-email-shenkai8@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, November 7, 2019 6:08:17 AM CET Shen Kai wrote:
> From: Kai Shen <shenkai8@huawei.com>
> 
> Add NULL check in the store function here to avoid NULL callback invoking.
> Though some interfaces of cpufreq are set as read-only, user can still get 
> write permission using chmod which can lead to a kernel crash.
> 
> The following operations can lead to a kernel crash.
> 
> chmod +w /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> echo 1 >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> 
> This bug was found on linux 4.19
> 
> Signed-off-by: Kai Shen <shenkai8@huawei.com>
> Reported-by: Feilong Lin <linfeilong@huawei.com>
> Reviewed-by: Feilong Lin <linfeilong@huawei.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2->V3
> - use return value -EIO instead.
> - do NULL check in show method too.
> 
>  drivers/cpufreq/cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 48a224a..bc19d6c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -933,6 +933,9 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
>  	struct freq_attr *fattr = to_attr(attr);
>  	ssize_t ret;
>  
> +	if (!fattr->show)
> +		return -EIO;
> +
>  	down_read(&policy->rwsem);
>  	ret = fattr->show(policy, buf);
>  	up_read(&policy->rwsem);
> @@ -947,6 +950,9 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  	struct freq_attr *fattr = to_attr(attr);
>  	ssize_t ret = -EINVAL;
>  
> +	if (!fattr->store)
> +		return -EIO;
> +
>  	/*
>  	 * cpus_read_trylock() is used here to work around a circular lock
>  	 * dependency problem with respect to the cpufreq_register_driver().
> 

Applying as 5.5 material with updated subject and changelog (the original ones
did not mention the show() function).

Thanks!



