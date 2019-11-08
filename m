Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0B4F4A54
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 13:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbfKHMI1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 07:08:27 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48576 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbfKHLkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 06:40:32 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id c6a3f0ec310a8f1c; Fri, 8 Nov 2019 12:40:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / core: Cleanup some function definitions in power.h
Date:   Fri, 08 Nov 2019 12:40:31 +0100
Message-ID: <2547127.Nu07Onx00h@kreacher>
In-Reply-To: <20191016141627.18642-1-ulf.hansson@linaro.org>
References: <20191016141627.18642-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 16, 2019 4:16:27 PM CET Ulf Hansson wrote:
> The power.h is a bit messy due to the various existing CONFIG_PM* Kconfig
> combinations. However the final section for wakeup_source_sysfs*() can be
> moved inside one of the existing sections rather than adding yet another
> one, so let's do that to clean up the code a little bit.

Fair enough.

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/power.h | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 39a06a0cfdaa..444f5c169a0b 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -117,6 +117,13 @@ static inline bool device_pm_initialized(struct device *dev)
>  	return dev->power.in_dpm_list;
>  }
>  
> +/* drivers/base/power/wakeup_stats.c */
> +extern int wakeup_source_sysfs_add(struct device *parent,
> +				   struct wakeup_source *ws);
> +extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
> +
> +extern int pm_wakeup_source_sysfs_add(struct device *parent);
> +
>  #else /* !CONFIG_PM_SLEEP */
>  
>  static inline void device_pm_sleep_init(struct device *dev) {}
> @@ -141,6 +148,11 @@ static inline bool device_pm_initialized(struct device *dev)
>  	return device_is_registered(dev);
>  }
>  
> +static inline int pm_wakeup_source_sysfs_add(struct device *parent)
> +{
> +	return 0;
> +}
> +
>  #endif /* !CONFIG_PM_SLEEP */
>  
>  static inline void device_pm_init(struct device *dev)
> @@ -149,21 +161,3 @@ static inline void device_pm_init(struct device *dev)
>  	device_pm_sleep_init(dev);
>  	pm_runtime_init(dev);
>  }
> -
> -#ifdef CONFIG_PM_SLEEP
> -
> -/* drivers/base/power/wakeup_stats.c */
> -extern int wakeup_source_sysfs_add(struct device *parent,
> -				   struct wakeup_source *ws);
> -extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
> -
> -extern int pm_wakeup_source_sysfs_add(struct device *parent);
> -
> -#else /* !CONFIG_PM_SLEEP */
> -
> -static inline int pm_wakeup_source_sysfs_add(struct device *parent)
> -{
> -	return 0;
> -}
> -
> -#endif /* CONFIG_PM_SLEEP */
> 

Applying as 5.5 material, thanks!



