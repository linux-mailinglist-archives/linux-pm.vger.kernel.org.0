Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0225715168F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 08:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgBDHnt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 02:43:49 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:63314 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgBDHnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2020 02:43:49 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200204074346epoutp01c6ed7dec99da424b8b22630a2a80b5fa~wIz-fukFl0856708567epoutp01Q
        for <linux-pm@vger.kernel.org>; Tue,  4 Feb 2020 07:43:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200204074346epoutp01c6ed7dec99da424b8b22630a2a80b5fa~wIz-fukFl0856708567epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580802226;
        bh=zdGbeOsD5707B4vcjzzLr1xkIJMF4GifHOCKQpezfLk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pkm+B00l743ZughmbdEN6pWmNJu2r11wXFxwvXPZDIk45dlKixSnjLxSA57IOEpfs
         WkE+c819gvscN7GhWFgbLEjoq98FrMwgPi6mUYd6ZSgeb8N7zEkRmpeOGz8PS/0V+U
         oiwirR3mnbN5KxjHuB9OedV2FWjsBOgebrb2w5ZY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200204074345epcas1p4ee9f0620ec052f03a84ff6002fb25ac4~wIz_qKpER2159521595epcas1p4W;
        Tue,  4 Feb 2020 07:43:45 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48BcBk5PJdzMqYks; Tue,  4 Feb
        2020 07:43:42 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.31.57028.EA0293E5; Tue,  4 Feb 2020 16:43:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200204074342epcas1p263395811ff32432f672d4786fd3f1c1d~wIz7aKGLd2817828178epcas1p2J;
        Tue,  4 Feb 2020 07:43:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200204074342epsmtrp10b926b3f8da52285956842f586987906~wIz7ZZQyk0736207362epsmtrp14;
        Tue,  4 Feb 2020 07:43:42 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-ab-5e3920ae6a0c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.EB.10238.DA0293E5; Tue,  4 Feb 2020 16:43:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200204074341epsmtip25a5905540f53b7338c5286eba3b87350~wIz7LXqDV0993909939epsmtip20;
        Tue,  4 Feb 2020 07:43:41 +0000 (GMT)
Subject: Re: [PATCHv2 1/2] PM / devfreq: Remove unneeded extern keyword
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lukasz.luba@arm.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fa1d0201-b7af-2093-8ae3-67266ca245e1@samsung.com>
Date:   Tue, 4 Feb 2020 16:51:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200203011733.7639-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmvu46Bcs4gyuftC0m3rjCYnG26Q27
        xeVdc9gsPvceYbRY2NTCbnG7cQWbA5vHmnlrGD02repk8+jbsorR4/MmuQCWqGybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDlSgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjAdf/rMVrHep
        eHH4E0sDY6t5FyMnh4SAicSJlVNZuxi5OIQEdjBKTDzwkgXC+cQo0TP1ElTmG6PE3d9PmWBa
        3uyaDpXYyyjx9eNUdgjnPaPEzee3WECqhAXcJZ7M2ArWISJgJXH6fwcziM0skCRx+MtVRhCb
        TUBLYv+LG2wgNr+AosTVH4+B4hwcvAJ2ErdP+IGEWQRUJFbOvAo2UlQgTOLkthawVl4BQYmT
        M5+AxTmBxv89tZ8dYry4xK0n85kgbHmJ7W/nMIPcJiHwmE1i3qI1UB+4SBy785gRwhaWeHV8
        CzuELSXxsr8Nyq6WWHnyCBtEcwejxJb9F1ghEsYS+5dOZgI5lFlAU2L9Ln2IsKLEzt9zGSEW
        80m8+9rDClIiIcAr0dEmBFGiLHH5wV2oEyQlFrd3sk1gVJqF5J1ZSF6YheSFWQjLFjCyrGIU
        Sy0ozk1PLTYsMESO7U2M4ISpZbqDcco5n0OMAhyMSjy8F+ws4oRYE8uKK3MPMUpwMCuJ8NZZ
        mcYJ8aYkVlalFuXHF5XmpBYfYjQFhvZEZinR5HxgMs8riTc0NTI2NrYwMTQzNTRUEud9GKkZ
        JySQnliSmp2aWpBaBNPHxMEp1cDImjR9zX7lC+eFruwWq8w38KxYEjVt2hP/+1tFhU2Ftq1Q
        MHlwtcZ42YuEB0uebItK+/xePKRIeGWV+c83i88UZXlITz4vIPxa/vHV58+uyLvkPOJ8fvtn
        Fu+SpxOKCqfpbbB+4mEXt/Zvo9GySOFXIotPzShYsGmiF0NHzItVyScemk+4EHGsU4mlOCPR
        UIu5qDgRAIlYVE6uAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXnetgmWcwZ0f5hYTb1xhsTjb9Ibd
        4vKuOWwWn3uPMFosbGpht7jduILNgc1jzbw1jB6bVnWyefRtWcXo8XmTXABLFJdNSmpOZllq
        kb5dAlfGgy//2QrWu1S8OPyJpYGx1byLkZNDQsBE4s2u6axdjFwcQgK7GSVOLv7KApGQlJh2
        8ShzFyMHkC0scfhwMUhYSOAto8SzZ0YgtrCAu8STGVuZQGwRASuJ0/87mEFsZoEkiZOv7rJA
        zOxllLh/ZxEbSIJNQEti/4sbYDa/gKLE1R+PGUHm8wrYSdw+4QcSZhFQkVg58yrYCaICYRI7
        lzwGm88rIChxcuYTsDgn0K6/p/azQ+xSl/gz7xLUXnGJW0/mM0HY8hLb385hnsAoPAtJ+ywk
        LbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw3Ghp7mC8vCT+EKMA
        B6MSD+8FO4s4IdbEsuLK3EOMEhzMSiK8dVamcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5n+Yd
        ixQSSE8sSc1OTS1ILYLJMnFwSjUwuss85tie7Vuky/5a0CpVb114tYNxzJN7H4Jer2p8uJhZ
        8siyg5V2El9PLOCQWjdllvSKdOXTRZ56B0vvvDyw2ciyjTPvGh9beQnjuc3GNzw1FP7WNDbc
        NHx7yPZ7Ccu154feBSepXJxwLTbiWvGV37d/XdDN4vI/U3ut4pIwC+/jMH5O/4+flViKMxIN
        tZiLihMBS2Ek7pcCAAA=
X-CMS-MailID: 20200204074342epcas1p263395811ff32432f672d4786fd3f1c1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200203010946epcas1p16010f3f1e5b079927bd81b8e70c0a015
References: <CGME20200203010946epcas1p16010f3f1e5b079927bd81b8e70c0a015@epcas1p1.samsung.com>
        <20200203011733.7639-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/3/20 10:17 AM, Chanwoo Choi wrote:
> Remove unneeded extern keyword from devfreq-related header file
> and adjust the indentation of function parameter to keep the
> consistency in header file
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes from v1:
> - Add reviewed tag of Lukasz
> 
>  drivers/devfreq/governor.h |  17 +++----
>  include/linux/devfreq.h    | 100 ++++++++++++++++++-------------------
>  2 files changed, 57 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index dc7533ccc3db..5ba3e051b1d0 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -57,17 +57,16 @@ struct devfreq_governor {
>  				unsigned int event, void *data);
>  };
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
>  static inline int devfreq_update_stats(struct devfreq *df)
>  {
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index c6f82d4bec9f..82630fafacde 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -201,24 +201,23 @@ struct devfreq_freqs {
>  };
>  
>  #if defined(CONFIG_PM_DEVFREQ)
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
>  /* Supposed to be called by PM callbacks */
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
>  /**
>   * update_devfreq() - Reevaluate the device and configure frequency
> @@ -226,35 +225,34 @@ extern void devfreq_resume(void);
>   *
>   * Note: devfreq->lock must be held
>   */
> -extern int update_devfreq(struct devfreq *devfreq);
> +int update_devfreq(struct devfreq *devfreq);
>  
>  /* Helper functions for devfreq user device driver with OPP. */
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
>  				struct devfreq *devfreq,
>  				struct notifier_block *nb,
>  				unsigned int list);
> -extern void devm_devfreq_unregister_notifier(struct device *dev,
> +void devm_devfreq_unregister_notifier(struct device *dev,
>  				struct devfreq *devfreq,
>  				struct notifier_block *nb,
>  				unsigned int list);
> -extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
> -						int index);
> +struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index);
>  
>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
>  /**
> @@ -311,9 +309,9 @@ struct devfreq_passive_data {
>  
>  #else /* !CONFIG_PM_DEVFREQ */
>  static inline struct devfreq *devfreq_add_device(struct device *dev,
> -					  struct devfreq_dev_profile *profile,
> -					  const char *governor_name,
> -					  void *data)
> +					struct devfreq_dev_profile *profile,
> +					const char *governor_name,
> +					void *data)
>  {
>  	return ERR_PTR(-ENOSYS);
>  }
> @@ -350,31 +348,31 @@ static inline void devfreq_suspend(void) {}
>  static inline void devfreq_resume(void) {}
>  
>  static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
> -					   unsigned long *freq, u32 flags)
> +					unsigned long *freq, u32 flags)
>  {
>  	return ERR_PTR(-EINVAL);
>  }
>  
>  static inline int devfreq_register_opp_notifier(struct device *dev,
> -					 struct devfreq *devfreq)
> +					struct devfreq *devfreq)
>  {
>  	return -EINVAL;
>  }
>  
>  static inline int devfreq_unregister_opp_notifier(struct device *dev,
> -					   struct devfreq *devfreq)
> +					struct devfreq *devfreq)
>  {
>  	return -EINVAL;
>  }
>  
>  static inline int devm_devfreq_register_opp_notifier(struct device *dev,
> -						     struct devfreq *devfreq)
> +					struct devfreq *devfreq)
>  {
>  	return -EINVAL;
>  }
>  
>  static inline void devm_devfreq_unregister_opp_notifier(struct device *dev,
> -							struct devfreq *devfreq)
> +					struct devfreq *devfreq)
>  {
>  }
>  
> @@ -393,22 +391,22 @@ static inline int devfreq_unregister_notifier(struct devfreq *devfreq,
>  }
>  
>  static inline int devm_devfreq_register_notifier(struct device *dev,
> -				struct devfreq *devfreq,
> -				struct notifier_block *nb,
> -				unsigned int list)
> +					struct devfreq *devfreq,
> +					struct notifier_block *nb,
> +					unsigned int list)
>  {
>  	return 0;
>  }
>  
>  static inline void devm_devfreq_unregister_notifier(struct device *dev,
> -				struct devfreq *devfreq,
> -				struct notifier_block *nb,
> -				unsigned int list)
> +					struct devfreq *devfreq,
> +					struct notifier_block *nb,
> +					unsigned int list)
>  {
>  }
>  
>  static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
> -							int index)
> +					int index)
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
