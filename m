Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E5413561B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 10:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgAIJri (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 04:47:38 -0500
Received: from foss.arm.com ([217.140.110.172]:55898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbgAIJrh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Jan 2020 04:47:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB55D31B;
        Thu,  9 Jan 2020 01:47:36 -0800 (PST)
Received: from [10.37.12.111] (unknown [10.37.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 399463F6C4;
        Thu,  9 Jan 2020 01:47:33 -0800 (PST)
Subject: Re: [PATCH v2 01/11] PM / devfreq: Add devfreq_get_devfreq_by_node
 function
To:     Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        krzk@kernel.org, heiko@sntech.de, leonard.crestez@nxp.com
Cc:     mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20191220002430.11995-1-cw00.choi@samsung.com>
 <CGME20191220001759epcas1p4bbbcf6a84c09229db0ddae86be294405@epcas1p4.samsung.com>
 <20191220002430.11995-2-cw00.choi@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <71da0ef9-1e72-dddc-dcb4-e4cb28b67183@arm.com>
Date:   Thu, 9 Jan 2020 09:47:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191220002430.11995-2-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,


On 12/20/19 12:24 AM, Chanwoo Choi wrote:
> From: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Split off part of devfreq_get_devfreq_by_phandle into a separate
> function. This allows callers to fetch devfreq instances by enumerating
> devicetree instead of explicit phandles.
> 
> [lkp: Reported the build error]
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> [cw00.choi: Export devfreq_get_devfreq_by_node function and
>   add function to devfreq.h when CONFIG_PM_DEVFREQ is enabled.]
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>   drivers/devfreq/devfreq.c | 46 +++++++++++++++++++++++++++++----------
>   include/linux/devfreq.h   |  6 +++++
>   2 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 89260b17598f..cb8ca81c8973 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -966,6 +966,32 @@ struct devfreq *devm_devfreq_add_device(struct device *dev,
>   EXPORT_SYMBOL(devm_devfreq_add_device);
>   
>   #ifdef CONFIG_OF
> +/*
> + * devfreq_get_devfreq_by_node - Get the devfreq device from devicetree
> + * @node - pointer to device_node
> + *
> + * return the instance of devfreq device
> + */
> +struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
> +{
> +	struct devfreq *devfreq;
> +
> +	if (!node)
> +		return ERR_PTR(-EINVAL);
> +
> +	mutex_lock(&devfreq_list_lock);
> +	list_for_each_entry(devfreq, &devfreq_list, node) {
> +		if (devfreq->dev.parent
> +			&& devfreq->dev.parent->of_node == node) {
> +			mutex_unlock(&devfreq_list_lock);
> +			return devfreq;
> +		}
> +	}
> +	mutex_unlock(&devfreq_list_lock);
> +
> +	return ERR_PTR(-ENODEV);
> +}
> +
>   /*
>    * devfreq_get_devfreq_by_phandle - Get the devfreq device from devicetree
>    * @dev - instance to the given device
> @@ -988,26 +1014,24 @@ struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>   	if (!node)
>   		return ERR_PTR(-ENODEV);
>   
> -	mutex_lock(&devfreq_list_lock);
> -	list_for_each_entry(devfreq, &devfreq_list, node) {
> -		if (devfreq->dev.parent
> -			&& devfreq->dev.parent->of_node == node) {
> -			mutex_unlock(&devfreq_list_lock);
> -			of_node_put(node);
> -			return devfreq;
> -		}
> -	}
> -	mutex_unlock(&devfreq_list_lock);
> +	devfreq = devfreq_get_devfreq_by_node(node);
>   	of_node_put(node);
>   
> -	return ERR_PTR(-EPROBE_DEFER);
> +	return devfreq;
>   }
> +
>   #else
> +struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
>   struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>   {
>   	return ERR_PTR(-ENODEV);
>   }
>   #endif /* CONFIG_OF */
> +EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_node);
>   EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);
>   
>   /**
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index c6f82d4bec9f..1dccc47acbce 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -253,6 +253,7 @@ extern void devm_devfreq_unregister_notifier(struct device *dev,
>   				struct devfreq *devfreq,
>   				struct notifier_block *nb,
>   				unsigned int list);
> +extern struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);

It can go without 'extern' in the header.

>   extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
>   						int index);
>   
> @@ -407,6 +408,11 @@ static inline void devm_devfreq_unregister_notifier(struct device *dev,
>   {
>   }
>   
> +static inline struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
>   static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
>   							int index)
>   {
> 

Apart from this minor thing, looks good to me.
When you fix it, feel free to add

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
