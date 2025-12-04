Return-Path: <linux-pm+bounces-39179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7176BCA2A5F
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 08:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69A0530202F8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 07:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB93002B4;
	Thu,  4 Dec 2025 07:36:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78BC2F5A39;
	Thu,  4 Dec 2025 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764833815; cv=none; b=h7gqnRbcQGdRCK2bLolp/WfdXm90vrXrSgEzqrDFfhk0esZ82SJzoZQtQV7E7iaUpZOBM5h0OI+ZtepXBkik6Hll/SU975EO6gHq7zJaue1nbPbZ982J700sz2e8vW11dXZoYTLrJPbvi/9AeT5H141AT4s6KWCw5B/vLfkRG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764833815; c=relaxed/simple;
	bh=zfYhwlK/YPN5JK5VD3k5tj9wBCp1eOJ5nWOy8+NNTdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CaboQzYf3dWvWCEnvZVfsOjJxpLqNfmvXQ+yS9NAHxR/2+TzbKK41+nOPU5+kyMljqvTEuW7OefOjdob5HBD+DSF+xi19gO0RPmrN0CFcrgWxyIUPUiOjrcNX3qhE2Q+uC9WHxE518+9E+D4aTDF94A2z7xWVIzOTD2XMFGxUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dMR90122pzpSxF;
	Thu,  4 Dec 2025 15:34:28 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 259D91402ED;
	Thu,  4 Dec 2025 15:36:49 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 15:36:48 +0800
Message-ID: <1f89f5f1-8743-4902-b103-66287a33c5ba@hisilicon.com>
Date: Thu, 4 Dec 2025 15:36:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM / devfreq: use _visible attribute to replace
 create/remove_sysfs_files()
To: Pengjie Zhang <zhangpengjie2@huawei.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
References: <20251107031706.1698396-1-zhangpengjie2@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20251107031706.1698396-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 11/7/2025 11:17 AM, Pengjie Zhang wrote:
> Previously, non-generic attributes (polling_interval, timer) used separate 
> create/delete logic, leading to race conditions during concurrent access in
> creation/deletion. Multi-threaded operations also caused inconsistencies   
> between governor capabilities and attribute states.                        
>                                                                            
> 1.Use is_visible + sysfs_update_group() to unify management of these       
> attributes, eliminating creation/deletion races.                           
> 2.Add locks and validation to these attributes, ensuring consistency       
> between current governor capabilities and attribute operations in          
> multi-threaded environments.                                               
>                                                                            
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>                    
Hi Pengjie,

The motivation looks fine but the implementation of gov_group_visible() and
gov_attr_visible() doesn't work right in my view.

See comments below.

Thanks!
Jie
> ---                                                                        
> changes in v3:                                                             
> - Use guard() to simplify lock acquisition and destruction.                
> - Eliminate redundant checks for df.                                       
> Link to v2:https://lore.kernel.org/lkml/20251028022458.2824872-1-zhangpengjie2@huawei.com/
>                                                                            
> Changes in v2:                                                             
> - Fix one problem reported by the kernel test robot.                       
> - Redirect all error paths in timer_store() to out to ensure locks are not 
>  left unReleased.                                                          
> Link to v1:https://lore.kernel.org/lkml/20251025135238.3576861-1-zhangpengjie2@huawei.com/
> 
>  drivers/devfreq/devfreq.c | 108 ++++++++++++++++++++++++--------------
>  1 file changed, 68 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2e8d01d47f69..674b794d553d 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -38,6 +38,7 @@
>  
>  static struct class *devfreq_class;
>  static struct dentry *devfreq_debugfs;
> +static const struct attribute_group gov_attr_group;
>  
>  /*
>   * devfreq core provides delayed work based load monitoring helper
> @@ -785,11 +786,6 @@ static void devfreq_dev_release(struct device *dev)
>  	kfree(devfreq);
>  }
>  
> -static void create_sysfs_files(struct devfreq *devfreq,
> -				const struct devfreq_governor *gov);
> -static void remove_sysfs_files(struct devfreq *devfreq,
> -				const struct devfreq_governor *gov);
> -
>  /**
>   * devfreq_add_device() - Add devfreq feature to the device
>   * @dev:	the device to add devfreq feature.
> @@ -956,7 +952,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  			 __func__);
>  		goto err_init;
>  	}
> -	create_sysfs_files(devfreq, devfreq->governor);
> +
> +	err = sysfs_update_group(&devfreq->dev.kobj, &gov_attr_group);
> +	if (err)
> +		goto err_init;
>  
>  	list_add(&devfreq->node, &devfreq_list);
>  
> @@ -998,9 +997,7 @@ int devfreq_remove_device(struct devfreq *devfreq)
>  	if (devfreq->governor) {
>  		devfreq->governor->event_handler(devfreq,
>  						 DEVFREQ_GOV_STOP, NULL);
> -		remove_sysfs_files(devfreq, devfreq->governor);
>  	}
> -
>  	device_unregister(&devfreq->dev);
>  
>  	return 0;
> @@ -1460,7 +1457,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  			 __func__, df->governor->name, ret);
>  		goto out;
>  	}
> -	remove_sysfs_files(df, df->governor);
>  
>  	/*
>  	 * Start the new governor and create the specific sysfs files
> @@ -1489,7 +1485,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	 * Create the sysfs files for the new governor. But if failed to start
>  	 * the new governor, restore the sysfs files of previous governor.
>  	 */
> -	create_sysfs_files(df, df->governor);
> +	ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
>  
>  out:
>  	mutex_unlock(&devfreq_list_lock);
> @@ -1807,17 +1803,22 @@ static struct attribute *devfreq_attrs[] = {
>  	&dev_attr_trans_stat.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(devfreq);
>  
>  static ssize_t polling_interval_show(struct device *dev,
>  				     struct device_attribute *attr, char *buf)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	int ret;
No need of this if restore the last line.
>  
> -	if (!df->profile)
> +	guard(mutex)(&devfreq_list_lock);
> +
> +	if (!df->profile || !df->governor ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
>  		return -EINVAL;
>  
> -	return sprintf(buf, "%d\n", df->profile->polling_ms);
It's fine to keep this line.
> +	ret = sprintf(buf, "%d\n", df->profile->polling_ms);
> +
> +	return ret;
>  }
>  
>  static ssize_t polling_interval_store(struct device *dev,
> @@ -1828,7 +1829,10 @@ static ssize_t polling_interval_store(struct device *dev,
>  	unsigned int value;
>  	int ret;
>  
> -	if (!df->governor)
> +	guard(mutex)(&devfreq_list_lock);
> +
> +	if (!df->governor ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
>  		return -EINVAL;
>  
>  	ret = sscanf(buf, "%u", &value);
> @@ -1847,7 +1851,10 @@ static ssize_t timer_show(struct device *dev,
>  {
>  	struct devfreq *df = to_devfreq(dev);
>  
> -	if (!df->profile)
> +	guard(mutex)(&devfreq_list_lock);
> +
> +	if (!df->profile || !df->governor ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
>  		return -EINVAL;
>  
>  	return sprintf(buf, "%s\n", timer_name[df->profile->timer]);
> @@ -1861,7 +1868,10 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>  	int timer = -1;
>  	int ret = 0, i;
>  
> -	if (!df->governor || !df->profile)
> +	guard(mutex)(&devfreq_list_lock);
> +
> +	if (!df->governor || !df->profile ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
>  		return -EINVAL;
>  
>  	ret = sscanf(buf, "%16s", str_timer);
> @@ -1905,36 +1915,54 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(timer);
>  
> -#define CREATE_SYSFS_FILE(df, name)					\
> -{									\
> -	int ret;							\
> -	ret = sysfs_create_file(&df->dev.kobj, &dev_attr_##name.attr);	\
> -	if (ret < 0) {							\
> -		dev_warn(&df->dev,					\
> -			"Unable to create attr(%s)\n", "##name");	\
> -	}								\
> -}									\
> +static struct attribute *governor_attrs[] = {
> +	&dev_attr_polling_interval.attr,
> +	&dev_attr_timer.attr,
> +	NULL
> +};
>  
> -/* Create the specific sysfs files which depend on each governor. */
> -static void create_sysfs_files(struct devfreq *devfreq,
> -				const struct devfreq_governor *gov)
> +static umode_t gov_attr_visible(struct kobject *kobj,
> +				struct attribute *attr, int n)
>  {
> -	if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
> -		CREATE_SYSFS_FILE(devfreq, polling_interval);
> -	if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
> -		CREATE_SYSFS_FILE(devfreq, timer);
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct devfreq *df = to_devfreq(dev);
> +
> +	if (!df->governor || !df->governor->attrs)
> +		return 0;
> +
> +	if (IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
> +		return attr->mode;
> +	if (IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
> +		return attr->mode;
This would expose both 'timer' and 'polling_interval' if either of them is
supported, which is wrong.
> +
> +	return 0;
>  }
>  
> -/* Remove the specific sysfs files which depend on each governor. */
> -static void remove_sysfs_files(struct devfreq *devfreq,
> -				const struct devfreq_governor *gov)
> +static bool gov_group_visible(struct kobject *kobj)
>  {
> -	if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
> -		sysfs_remove_file(&devfreq->dev.kobj,
> -				&dev_attr_polling_interval.attr);
> -	if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
> -		sysfs_remove_file(&devfreq->dev.kobj, &dev_attr_timer.attr);
> +	struct device *dev = kobj_to_dev(kobj);
> +
> +	if (!dev)
> +		return false;
kobj_to_dev(kobj) can't fail.  This check is unnecessary.
> +
> +	return true;
>  }
> +DEFINE_SYSFS_GROUP_VISIBLE(gov);
The implementation of gov_group_visible() and gov_attr_visible() doesn't
seem to comply with the design of DEFINE_SYSFS_GROUP_VISIBLE().

DEFINE_SYSFS_GROUP_VISIBLE is defined as:

#define DEFINE_SYSFS_GROUP_VISIBLE(name)                             \
        static inline umode_t sysfs_group_visible_##name(            \
                struct kobject *kobj, struct attribute *attr, int n) \
        {                                                            \
                if (n == 0 && !name##_group_visible(kobj))           \
                        return SYSFS_GROUP_INVISIBLE;                \
                return name##_attr_visible(kobj, attr, n);           \
        }

That means:
_group_visible controls whether to hide all the attrs in this group;
_attr_visible further decides whether to show each attr.

Hence,
1. gov_group_visible() should check if any attr in 'governor_attrs' should
be present, i.e. checking df->governor->attrs.
2. gov_attr_visible identifies which attr it is and checks whether the
governor supports it.

Neither is done in the above code, so this should be updated.
> +
> +static const struct attribute_group devfreq_group = {
> +	.attrs = devfreq_attrs,
> +};
> +
> +static const struct attribute_group gov_attr_group = {
> +	.attrs = governor_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(gov),
> +};
> +
> +static const struct attribute_group *devfreq_groups[] = {
> +	&devfreq_group,
> +	&gov_attr_group,
> +	NULL
> +};
>  
>  /**
>   * devfreq_summary_show() - Show the summary of the devfreq devices

