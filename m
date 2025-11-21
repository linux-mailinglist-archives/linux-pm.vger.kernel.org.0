Return-Path: <linux-pm+bounces-38362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FF6C79066
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 319C74E2452
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 12:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425630274F;
	Fri, 21 Nov 2025 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="S1GmZrLn"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EE2882B8;
	Fri, 21 Nov 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763728405; cv=none; b=E0c1M1iO83d9uGdkMUplYI8VZlp/V3MrZEJt0lMdqmZ7OlWghf1L69/HRJ0o/vhdmTLFPtZxSJdsST9G9wXnOm/JyN27lHMVlOocoQU/KuzjnIir3hQ+x7NRKu6e/8Z/rha/+oMYv/wLTOkcAOBFPNNSHq7xCWQ9SeK/+ycE8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763728405; c=relaxed/simple;
	bh=h2p9n9HL07X7V1Dmpqbb7/35pYpOKbv1tzV544q1B+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fKE6Hfnfc2unMI1APwj2BlQ//QmqdUopcUGdyoHRH/ORvDU57pGJBaaA5bvLT/UFRdbYwHZ3kQ/CXGXiXBZEqbbj36t7nBsfHsfBieVwGFY411z4IabmrMsns+pMqbgVNNly3cQ1m9SM2DBvl449r0YZKPEftFrAZdioT8R7RtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S1GmZrLn; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TXgw7ZAAVoJUJUowbzTMYQN6JXMS+NzXRYgaB2geh2I=;
	b=S1GmZrLnXJe0/U4QGAew7aeZIpwyU5KdoDE+PFHRm3GGf/jNh16cGJyEdlxmJK7zsTXK4Jz8R
	3q/6gmEZEdJtfEuMBiStHjQtqlUSS4WZLSnNSMLaXCqxhl1cFsIhYnpSZU1m8w3HKVfSkAgWT2B
	n7POrxRluNc7mIV4Vq31H1c=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dCZMF6ghQzcZy9;
	Fri, 21 Nov 2025 20:31:05 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 167901402CF;
	Fri, 21 Nov 2025 20:33:12 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 21 Nov
 2025 20:33:11 +0800
Message-ID: <46b840b6-b172-4b7d-83d4-540c41608726@huawei.com>
Date: Fri, 21 Nov 2025 20:33:10 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM / devfreq: use _visible attribute to replace
 create/remove_sysfs_files()
To: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
References: <20251107031706.1698396-1-zhangpengjie2@huawei.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <20251107031706.1698396-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Gentle ping .

Thanks!


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
> ---
> changes in v3:
> - Use guard() to simplify lock acquisition and destruction.
> - Eliminate redundant checks for df.
> Link to v2:https://lore.kernel.org/lkml/20251028022458.2824872-1-zhangpengjie2@huawei.com/
>                                                                             
> Changes in v2:
> - Fix one problem reported by the kernel test robot.
> - Redirect all error paths in timer_store() to out to ensure locks are not
>   left unReleased.
> Link to v1:https://lore.kernel.org/lkml/20251025135238.3576861-1-zhangpengjie2@huawei.com/
>
>   drivers/devfreq/devfreq.c | 108 ++++++++++++++++++++++++--------------
>   1 file changed, 68 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2e8d01d47f69..674b794d553d 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -38,6 +38,7 @@
>   
>   static struct class *devfreq_class;
>   static struct dentry *devfreq_debugfs;
> +static const struct attribute_group gov_attr_group;
>   
>   /*
>    * devfreq core provides delayed work based load monitoring helper
> @@ -785,11 +786,6 @@ static void devfreq_dev_release(struct device *dev)
>   	kfree(devfreq);
>   }
>   
> -static void create_sysfs_files(struct devfreq *devfreq,
> -				const struct devfreq_governor *gov);
> -static void remove_sysfs_files(struct devfreq *devfreq,
> -				const struct devfreq_governor *gov);
> -
>   /**
>    * devfreq_add_device() - Add devfreq feature to the device
>    * @dev:	the device to add devfreq feature.
> @@ -956,7 +952,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>   			 __func__);
>   		goto err_init;
>   	}
> -	create_sysfs_files(devfreq, devfreq->governor);
> +
> +	err = sysfs_update_group(&devfreq->dev.kobj, &gov_attr_group);
> +	if (err)
> +		goto err_init;
>   
>   	list_add(&devfreq->node, &devfreq_list);
>   
> @@ -998,9 +997,7 @@ int devfreq_remove_device(struct devfreq *devfreq)
>   	if (devfreq->governor) {
>   		devfreq->governor->event_handler(devfreq,
>   						 DEVFREQ_GOV_STOP, NULL);
> -		remove_sysfs_files(devfreq, devfreq->governor);
>   	}
> -
>   	device_unregister(&devfreq->dev);
>   
>   	return 0;
> @@ -1460,7 +1457,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>   			 __func__, df->governor->name, ret);
>   		goto out;
>   	}
> -	remove_sysfs_files(df, df->governor);
>   
>   	/*
>   	 * Start the new governor and create the specific sysfs files
> @@ -1489,7 +1485,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>   	 * Create the sysfs files for the new governor. But if failed to start
>   	 * the new governor, restore the sysfs files of previous governor.
>   	 */
> -	create_sysfs_files(df, df->governor);
> +	ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
>   
>   out:
>   	mutex_unlock(&devfreq_list_lock);
> @@ -1807,17 +1803,22 @@ static struct attribute *devfreq_attrs[] = {
>   	&dev_attr_trans_stat.attr,
>   	NULL,
>   };
> -ATTRIBUTE_GROUPS(devfreq);
>   
>   static ssize_t polling_interval_show(struct device *dev,
>   				     struct device_attribute *attr, char *buf)
>   {
>   	struct devfreq *df = to_devfreq(dev);
> +	int ret;
>   
> -	if (!df->profile)
> +	guard(mutex)(&devfreq_list_lock);
> +
> +	if (!df->profile || !df->governor ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
>   		return -EINVAL;
>   
> -	return sprintf(buf, "%d\n", df->profile->polling_ms);
> +	ret = sprintf(buf, "%d\n", df->profile->polling_ms);
> +
> +	return ret;
>   }
>   
>   static ssize_t polling_interval_store(struct device *dev,
> @@ -1828,7 +1829,10 @@ static ssize_t polling_interval_store(struct device *dev,
>   	unsigned int value;
>   	int ret;
>   
> -	if (!df->governor)
> +	guard(mutex)(&devfreq_list_lock);
> +
> +	if (!df->governor ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
>   		return -EINVAL;
>   
>   	ret = sscanf(buf, "%u", &value);
> @@ -1847,7 +1851,10 @@ static ssize_t timer_show(struct device *dev,
>   {
>   	struct devfreq *df = to_devfreq(dev);
>   
> -	if (!df->profile)
> +	guard(mutex)(&devfreq_list_lock);
> +
> +	if (!df->profile || !df->governor ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
>   		return -EINVAL;
>   
>   	return sprintf(buf, "%s\n", timer_name[df->profile->timer]);
> @@ -1861,7 +1868,10 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>   	int timer = -1;
>   	int ret = 0, i;
>   
> -	if (!df->governor || !df->profile)
> +	guard(mutex)(&devfreq_list_lock);
> +
> +	if (!df->governor || !df->profile ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
>   		return -EINVAL;
>   
>   	ret = sscanf(buf, "%16s", str_timer);
> @@ -1905,36 +1915,54 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RW(timer);
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
>   {
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
> +
> +	return 0;
>   }
>   
> -/* Remove the specific sysfs files which depend on each governor. */
> -static void remove_sysfs_files(struct devfreq *devfreq,
> -				const struct devfreq_governor *gov)
> +static bool gov_group_visible(struct kobject *kobj)
>   {
> -	if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
> -		sysfs_remove_file(&devfreq->dev.kobj,
> -				&dev_attr_polling_interval.attr);
> -	if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
> -		sysfs_remove_file(&devfreq->dev.kobj, &dev_attr_timer.attr);
> +	struct device *dev = kobj_to_dev(kobj);
> +
> +	if (!dev)
> +		return false;
> +
> +	return true;
>   }
> +DEFINE_SYSFS_GROUP_VISIBLE(gov);
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
>   /**
>    * devfreq_summary_show() - Show the summary of the devfreq devices

