Return-Path: <linux-pm+bounces-43484-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHY5LybTpmk3XQAAu9opvQ
	(envelope-from <linux-pm+bounces-43484-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 13:25:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 662BF1EF5A4
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 13:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26DA93053B3C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB3B33DEC0;
	Tue,  3 Mar 2026 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LNy6Pi/8"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BB339098C;
	Tue,  3 Mar 2026 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538977; cv=none; b=cPs0lsnPwy1Od7xV/2OEl8S4uvtGT7LW+m1VUAaKkSGAuHIh1FAAdQnrRQzFQWAnBW2j3eZ9fgxdiahzst2xbb2/CA9182FVEHMHq2mLoqcdAsbhJNLC7xczFh0CjolSSQWV/vTWVv/G1ebkZ6ywLOq3gWBL5reD388+szz/dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538977; c=relaxed/simple;
	bh=sgMOqDcNlto+J2Kv0QFzgGKoB5VeKg7mqEZMMA4ucSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q69vz5lIwWvn0T3iV8vc+qMeRy+SCejV10IHPmSrbJtzA4gZo5dF8hGY8/V8tnILz/dEEcN0zpVNDFHGqnR8irjxajCE2ciglppdsW75+4jnWk9uheDUdqS9HpKsQIoCabGbI+iTBGt/Yb+62yleTFIKvzgyFbCwGn9/yF7/e94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LNy6Pi/8; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dWbW+I65H3egyVKGZi6qoKyjYWW3z3p08sMJeN/z738=;
	b=LNy6Pi/8gG0wFckH6lXFZcR91L2HvcBOycYNJfOWxhuQailH9tZxwghdcLBNdLuLDneVvBuW1
	ZiuNgj9uCb8NMTogivDH3gkO2OfXQs2+UMwZN1NI+AbE9p/+ssJtp9cm/l7md03RStgrjVw9VDR
	aklIQ2WifZ1jdYh1zttGKCA=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fQDf36cp1zpStt;
	Tue,  3 Mar 2026 19:51:07 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id B44BA40561;
	Tue,  3 Mar 2026 19:56:05 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 19:56:05 +0800
Message-ID: <fa9bc543-d27c-4e35-9014-34a91ad8eddd@huawei.com>
Date: Tue, 3 Mar 2026 19:56:04 +0800
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr200004.china.huawei.com (7.202.195.241)
X-Rspamd-Queue-Id: 662BF1EF5A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43484-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangpengjie2@huawei.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hisilicon.com:email,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Action: no action

Hi MyungJoo, Kyungmin, and Chanwoo,

Just a gentle ping on this patch.

It has been a while since v5 was submitted, and it seems to have
reached a consensus. It has now collected the following tags:
Reviewed-by: Jonathan Cameron jonathan.cameron@huawei.com
Reviewed-by: Jie Zhan zhanjie9@hisilicon.com
Reviewed-by: Lifeng Zheng zhenglifeng1@huawei.com

Could you please let me know if there are any remaining concerns or if
it can be considered for the next devfreq tree update?

Thanks, Pengjie


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

