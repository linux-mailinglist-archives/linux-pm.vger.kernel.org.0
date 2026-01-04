Return-Path: <linux-pm+bounces-40164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7980BCF076D
	for <lists+linux-pm@lfdr.de>; Sun, 04 Jan 2026 02:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D20C43004CC9
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jan 2026 01:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC216FBF;
	Sun,  4 Jan 2026 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6mXntMat"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869271367;
	Sun,  4 Jan 2026 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767488458; cv=none; b=uDf4bcj8HbTG7NbJJ3daj4Cd2aLHRevCdVEgWP4V1yxbxCWuNtSwNX/3HxzhG+vIMYh0FYQ+hVaXxAbaEL73fQjwxGvBwHdCgg6naYjJ3x/BNSBcQxki/Q1kxUm1lszj9efCTFbT1vLZ8LBALh5Nb481ydmfA4j6JW8gPQ8hcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767488458; c=relaxed/simple;
	bh=BLi8gcZs+BLgDSuleS0pWbxaXcg2SsyI68mkV/2ksfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jKx0g4iwQ1y7yRJIaIgb5hkS/FvCbSc4T6dNH6cg4qIV1OV9r9A3VKCdy5vlHpIodINyGGHbw+k5eQNW88kmuxUN/HU+6Cw64Uk38qMH+u7LJ0bmBi0wi4PY/ZgRG8kjkshobyFiYomQggZ358UMYo+Don1SgnaRjXtp02EGGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6mXntMat; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0N0nXstzGf7SICd45vbDSRXYSblJOqcnmeCTqY5D0qY=;
	b=6mXntMatRdRRfErj2PD14eMfDwIX8Y18pXxIPxOfSKTXlDLItUaE8VBWJ5gDBuT9KVmw6WxxY
	qu8IF1pHZjZ9wfg1yw/b2YC8Vg85gvS7Ro9ej0Rr+lW7zPa2jwdXlwq40NcUutFhqxdj+mtB5q6
	Xty4J81hehxshmCRMWsVHek=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dkJvM39fvz1T4FY;
	Sun,  4 Jan 2026 08:58:07 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 637B040539;
	Sun,  4 Jan 2026 09:00:44 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 4 Jan
 2026 09:00:43 +0800
Message-ID: <5fef4ab5-9fd0-40bc-8785-992cd89cf2ef@huawei.com>
Date: Sun, 4 Jan 2026 09:00:42 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PM / devfreq: use _visible attribute to replace
 create/remove_sysfs_files()
To: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20251216031153.2242306-1-zhangpengjie2@huawei.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <20251216031153.2242306-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Hi,

Just a gentle ping in case this was missed.🙂

Thanks,
Pengjie

On 12/16/2025 11:11 AM, Pengjie Zhang wrote:
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
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
> changes in v5:
> -Remove the curly braces of an if statement
> -Added a note explaining why locking is necessary.
> Link to v4:https://lore.kernel.org/all/20251205083724.4068896-1-zhangpengjie2@huawei.com/
>
> changes in v4:
> -Remove the DEFINE_SYSFS_GROUP_VISIBLE macro and directly set the is_visible function.
> -Remove unnecessary ret variables
> Link to v3:https://lore.kernel.org/lkml/20251107031706.1698396-1-zhangpengjie2@huawei.com/
>
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
>   drivers/devfreq/devfreq.c | 103 ++++++++++++++++++++++----------------
>   1 file changed, 60 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2e8d01d47f69..7673a39baaa6 100644
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
> @@ -995,12 +994,9 @@ int devfreq_remove_device(struct devfreq *devfreq)
>   
>   	devfreq_cooling_unregister(devfreq->cdev);
>   
> -	if (devfreq->governor) {
> +	if (devfreq->governor)
>   		devfreq->governor->event_handler(devfreq,
>   						 DEVFREQ_GOV_STOP, NULL);
> -		remove_sysfs_files(devfreq, devfreq->governor);
> -	}
> -
>   	device_unregister(&devfreq->dev);
>   
>   	return 0;
> @@ -1460,7 +1456,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>   			 __func__, df->governor->name, ret);
>   		goto out;
>   	}
> -	remove_sysfs_files(df, df->governor);
>   
>   	/*
>   	 * Start the new governor and create the specific sysfs files
> @@ -1489,7 +1484,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>   	 * Create the sysfs files for the new governor. But if failed to start
>   	 * the new governor, restore the sysfs files of previous governor.
>   	 */
> -	create_sysfs_files(df, df->governor);
> +	ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
>   
>   out:
>   	mutex_unlock(&devfreq_list_lock);
> @@ -1807,14 +1802,17 @@ static struct attribute *devfreq_attrs[] = {
>   	&dev_attr_trans_stat.attr,
>   	NULL,
>   };
> -ATTRIBUTE_GROUPS(devfreq);
>   
>   static ssize_t polling_interval_show(struct device *dev,
>   				     struct device_attribute *attr, char *buf)
>   {
>   	struct devfreq *df = to_devfreq(dev);
>   
> -	if (!df->profile)
> +	/* Protect against race between sysfs attrs update and read/write */
> +	guard(mutex)(&devfreq_list_lock);
> +
> +	if (!df->profile || !df->governor ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
>   		return -EINVAL;
>   
>   	return sprintf(buf, "%d\n", df->profile->polling_ms);
> @@ -1828,7 +1826,10 @@ static ssize_t polling_interval_store(struct device *dev,
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
> @@ -1847,7 +1848,10 @@ static ssize_t timer_show(struct device *dev,
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
> @@ -1861,7 +1865,10 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
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
> @@ -1905,37 +1912,47 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
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
> -}
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct devfreq *df = to_devfreq(dev);
>   
> -/* Remove the specific sysfs files which depend on each governor. */
> -static void remove_sysfs_files(struct devfreq *devfreq,
> -				const struct devfreq_governor *gov)
> -{
> -	if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
> -		sysfs_remove_file(&devfreq->dev.kobj,
> -				&dev_attr_polling_interval.attr);
> -	if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
> -		sysfs_remove_file(&devfreq->dev.kobj, &dev_attr_timer.attr);
> +	if (!df->governor || !df->governor->attrs)
> +		return 0;
> +
> +	if (attr == &dev_attr_polling_interval.attr &&
> +	    IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
> +		return attr->mode;
> +
> +	if (attr == &dev_attr_timer.attr &&
> +	    IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
> +		return attr->mode;
> +
> +	return 0;
>   }
>   
> +static const struct attribute_group devfreq_group = {
> +	.attrs = devfreq_attrs,
> +};
> +
> +static const struct attribute_group gov_attr_group = {
> +	.attrs = governor_attrs,
> +	.is_visible = gov_attr_visible,
> +};
> +
> +static const struct attribute_group *devfreq_groups[] = {
> +	&devfreq_group,
> +	&gov_attr_group,
> +	NULL
> +};
> +
>   /**
>    * devfreq_summary_show() - Show the summary of the devfreq devices
>    * @s:		seq_file instance to show the summary of devfreq devices

