Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5427E74F8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 16:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfJ1PWF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 11:22:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42632 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfJ1PWF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 11:22:05 -0400
Received: from cust-east-parth2-46-193-72-114.wb.wifirst.net (46.193.72.114) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 5e1bbc9d50f66428; Mon, 28 Oct 2019 16:22:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mtosatti@redhat.com
Subject: Re: [PATCH v2] cpuidle: not unset the driver if it already exist
Date:   Mon, 28 Oct 2019 16:22:02 +0100
Message-ID: <3207655.LvExCM5pf1@kreacher>
In-Reply-To: <1571795834-2027-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1571795834-2027-1-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 23, 2019 3:57:14 AM CET Zhenzhong Duan wrote:
> __cpuidle_set_driver() check if there is an already exist driver and
> unset it before return with -EBUSY. The next call will succeed as it's
> just unset.
> 
> check if any of the CPUs in the mask have a driver different from drv
> already and if so return -EBUSY before updating any cpuidle_drivers
> per-CPU pointers.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
> v2: update code logic per Rafael
> 
>  drivers/cpuidle/driver.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 80c1a83..acfce04 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -62,24 +62,23 @@ static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>   * __cpuidle_set_driver - set per CPU driver variables for the given driver.
>   * @drv: a valid pointer to a struct cpuidle_driver
>   *
> - * For each CPU in the driver's cpumask, unset the registered driver per CPU
> - * to @drv.
> - *
> - * Returns 0 on success, -EBUSY if the CPUs have driver(s) already.
> + * Returns 0 on success, -EBUSY if any CPU in the cpumask have a driver
> + * different from drv already.
>   */
>  static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>  {
>  	int cpu;
>  
>  	for_each_cpu(cpu, drv->cpumask) {
> +		struct cpuidle_driver *old_drv;
>  
> -		if (__cpuidle_get_cpu_driver(cpu)) {
> -			__cpuidle_unset_driver(drv);
> +		old_drv = __cpuidle_get_cpu_driver(cpu);
> +		if (old_drv && old_drv != drv)
>  			return -EBUSY;
> -		}
> +	}
>  
> +	for_each_cpu(cpu, drv->cpumask)
>  		per_cpu(cpuidle_drivers, cpu) = drv;
> -	}
>  
>  	return 0;
>  }
> 

Applied as 5.5 material, thanks!



