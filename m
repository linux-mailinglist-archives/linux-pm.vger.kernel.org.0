Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C797014C99B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 12:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgA2Lar (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 06:30:47 -0500
Received: from foss.arm.com ([217.140.110.172]:39818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgA2Lar (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jan 2020 06:30:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA76A1FB;
        Wed, 29 Jan 2020 03:30:46 -0800 (PST)
Received: from [10.37.12.123] (unknown [10.37.12.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B5463F67D;
        Wed, 29 Jan 2020 03:30:44 -0800 (PST)
Subject: Re: [PATCH 1/2] PM / devfreq: Remove unneeded extern keyword
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <CGME20200129111225epcas1p3f9b495ee2565858d19bce43fb6e86ac1@epcas1p3.samsung.com>
 <20200129112002.6998-1-cw00.choi@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ad034210-24ca-5eb6-a359-ae3151805c98@arm.com>
Date:   Wed, 29 Jan 2020 11:30:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200129112002.6998-1-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 1/29/20 11:20 AM, Chanwoo Choi wrote:
> Remove unneeded extern keyword from devfreq-related header file
> and adjust the indentation of function parameter to keep the
> consistency in header file
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>   drivers/devfreq/governor.h |  17 +++----
>   include/linux/devfreq.h    | 100 ++++++++++++++++++-------------------
>   2 files changed, 57 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index dc7533ccc3db..5ba3e051b1d0 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -57,17 +57,16 @@ struct devfreq_governor {
>   				unsigned int event, void *data);
>   };
>   
> -extern void devfreq_monitor_start(struct devfreq *devfreq);
> -extern void devfreq_monitor_stop(struct devfreq *devfreq);
> -extern void devfreq_monitor_suspend(struct devfreq *devfreq);
> -extern void devfreq_monitor_resume(struct devfreq *devfreq);
> -extern void devfreq_interval_update(struct devfreq *devfreq,
> -					unsigned int *delay);
> +void devfreq_monitor_start(struct devfreq *devfreq);
> +void devfreq_monitor_stop(struct devfreq *devfreq);
> +void devfreq_monitor_suspend(struct devfreq *devfreq);
> +void devfreq_monitor_resume(struct devfreq *devfreq);
> +void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay);
>   
> -extern int devfreq_add_governor(struct devfreq_governor *governor);
> -extern int devfreq_remove_governor(struct devfreq_governor *governor);
> +int devfreq_add_governor(struct devfreq_governor *governor);
> +int devfreq_remove_governor(struct devfreq_governor *governor);
>   
> -extern int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
> +int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
>   
>   static inline int devfreq_update_stats(struct devfreq *df)
>   {
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index c6f82d4bec9f..82630fafacde 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -201,24 +201,23 @@ struct devfreq_freqs {
>   };
>   
>   #if defined(CONFIG_PM_DEVFREQ)
> -extern struct devfreq *devfreq_add_device(struct device *dev,
> -				  struct devfreq_dev_profile *profile,
> -				  const char *governor_name,
> -				  void *data);
> -extern int devfreq_remove_device(struct devfreq *devfreq);
> -extern struct devfreq *devm_devfreq_add_device(struct device *dev,
> -				  struct devfreq_dev_profile *profile,
> -				  const char *governor_name,
> -				  void *data);
> -extern void devm_devfreq_remove_device(struct device *dev,
> -				  struct devfreq *devfreq);
> +struct devfreq *devfreq_add_device(struct device *dev,
> +				struct devfreq_dev_profile *profile,
> +				const char *governor_name,
> +				void *data);
> +int devfreq_remove_device(struct devfreq *devfreq);
> +struct devfreq *devm_devfreq_add_device(struct device *dev,
> +				struct devfreq_dev_profile *profile,
> +				const char *governor_name,
> +				void *data);
> +void devm_devfreq_remove_device(struct device *dev, struct devfreq *devfreq);
>   
>   /* Supposed to be called by PM callbacks */
> -extern int devfreq_suspend_device(struct devfreq *devfreq);
> -extern int devfreq_resume_device(struct devfreq *devfreq);
> +int devfreq_suspend_device(struct devfreq *devfreq);
> +int devfreq_resume_device(struct devfreq *devfreq);
>   
> -extern void devfreq_suspend(void);
> -extern void devfreq_resume(void);
> +void devfreq_suspend(void);
> +void devfreq_resume(void);
>   
>   /**
>    * update_devfreq() - Reevaluate the device and configure frequency
> @@ -226,35 +225,34 @@ extern void devfreq_resume(void);
>    *
>    * Note: devfreq->lock must be held
>    */
> -extern int update_devfreq(struct devfreq *devfreq);
> +int update_devfreq(struct devfreq *devfreq);
>   
>   /* Helper functions for devfreq user device driver with OPP. */
> -extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
> -					   unsigned long *freq, u32 flags);
> -extern int devfreq_register_opp_notifier(struct device *dev,
> -					 struct devfreq *devfreq);
> -extern int devfreq_unregister_opp_notifier(struct device *dev,
> -					   struct devfreq *devfreq);
> -extern int devm_devfreq_register_opp_notifier(struct device *dev,
> -					      struct devfreq *devfreq);
> -extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
> -						struct devfreq *devfreq);
> -extern int devfreq_register_notifier(struct devfreq *devfreq,
> -					struct notifier_block *nb,
> -					unsigned int list);
> -extern int devfreq_unregister_notifier(struct devfreq *devfreq,
> -					struct notifier_block *nb,
> -					unsigned int list);
> -extern int devm_devfreq_register_notifier(struct device *dev,
> +struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
> +				unsigned long *freq, u32 flags);
> +int devfreq_register_opp_notifier(struct device *dev,
> +				struct devfreq *devfreq);
> +int devfreq_unregister_opp_notifier(struct device *dev,
> +				struct devfreq *devfreq);
> +int devm_devfreq_register_opp_notifier(struct device *dev,
> +				struct devfreq *devfreq);
> +void devm_devfreq_unregister_opp_notifier(struct device *dev,
> +				struct devfreq *devfreq);
> +int devfreq_register_notifier(struct devfreq *devfreq,
> +				struct notifier_block *nb,
> +				unsigned int list);
> +int devfreq_unregister_notifier(struct devfreq *devfreq,
> +				struct notifier_block *nb,
> +				unsigned int list);
> +int devm_devfreq_register_notifier(struct device *dev,
>   				struct devfreq *devfreq,
>   				struct notifier_block *nb,
>   				unsigned int list);
> -extern void devm_devfreq_unregister_notifier(struct device *dev,
> +void devm_devfreq_unregister_notifier(struct device *dev,
>   				struct devfreq *devfreq,
>   				struct notifier_block *nb,
>   				unsigned int list);
> -extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
> -						int index);
> +struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index);
>   
>   #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
>   /**
> @@ -311,9 +309,9 @@ struct devfreq_passive_data {
>   
>   #else /* !CONFIG_PM_DEVFREQ */
>   static inline struct devfreq *devfreq_add_device(struct device *dev,
> -					  struct devfreq_dev_profile *profile,
> -					  const char *governor_name,
> -					  void *data)
> +					struct devfreq_dev_profile *profile,
> +					const char *governor_name,
> +					void *data)
>   {
>   	return ERR_PTR(-ENOSYS);
>   }
> @@ -350,31 +348,31 @@ static inline void devfreq_suspend(void) {}
>   static inline void devfreq_resume(void) {}
>   
>   static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
> -					   unsigned long *freq, u32 flags)
> +					unsigned long *freq, u32 flags)
>   {
>   	return ERR_PTR(-EINVAL);
>   }
>   
>   static inline int devfreq_register_opp_notifier(struct device *dev,
> -					 struct devfreq *devfreq)
> +					struct devfreq *devfreq)
>   {
>   	return -EINVAL;
>   }
>   
>   static inline int devfreq_unregister_opp_notifier(struct device *dev,
> -					   struct devfreq *devfreq)
> +					struct devfreq *devfreq)
>   {
>   	return -EINVAL;
>   }
>   
>   static inline int devm_devfreq_register_opp_notifier(struct device *dev,
> -						     struct devfreq *devfreq)
> +					struct devfreq *devfreq)
>   {
>   	return -EINVAL;
>   }
>   
>   static inline void devm_devfreq_unregister_opp_notifier(struct device *dev,
> -							struct devfreq *devfreq)
> +					struct devfreq *devfreq)
>   {
>   }
>   
> @@ -393,22 +391,22 @@ static inline int devfreq_unregister_notifier(struct devfreq *devfreq,
>   }
>   
>   static inline int devm_devfreq_register_notifier(struct device *dev,
> -				struct devfreq *devfreq,
> -				struct notifier_block *nb,
> -				unsigned int list)
> +					struct devfreq *devfreq,
> +					struct notifier_block *nb,
> +					unsigned int list)
>   {
>   	return 0;
>   }
>   
>   static inline void devm_devfreq_unregister_notifier(struct device *dev,
> -				struct devfreq *devfreq,
> -				struct notifier_block *nb,
> -				unsigned int list)
> +					struct devfreq *devfreq,
> +					struct notifier_block *nb,
> +					unsigned int list)
>   {
>   }
>   
>   static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
> -							int index)
> +					int index)
>   {
>   	return ERR_PTR(-ENODEV);
>   }
> 

Looks good to me.


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


Regards,
Lukasz
