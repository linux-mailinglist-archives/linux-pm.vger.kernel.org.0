Return-Path: <linux-pm+bounces-37197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E640C25A46
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F191893656
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206034C12C;
	Fri, 31 Oct 2025 14:42:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AAF34C829;
	Fri, 31 Oct 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921725; cv=none; b=khM3xvv0oANNB+ye2ZuoSY61eyiRJnw86bfZrzzOl3eu2fVUTX6WDNKhfBDEjf+rFtW6UzCmxYX8q0bBzvmx70y9FuBcxveq64UOehxANzS0wHJXAGicmnRHA1I5tP3XSESbe7ELhxxJOH/ZRarfebHXgafgwGc/G7yPQaFjuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921725; c=relaxed/simple;
	bh=bHhED8iYQydf3s9DLhw8XrjMCOF3voY0wx9ywG6arP4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jO5lcGyE3WIjmXS6DiJCHRmP+4QV+ApHW7fDkCwXPMsqKpbuIL1f7HFdjUQ4g56slzKTiFPt/XGCyXuDelJ7Fb52MpBQByaH6CCs/HQBop7mc9S0sd6AwnC5L9swcHQ2XiAd3YYTWybUGPv/Fd7ebtcWe2y+QvDFvofLvCS2xtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cykDv07rCzHnGhK;
	Fri, 31 Oct 2025 14:41:03 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CDBE140144;
	Fri, 31 Oct 2025 22:41:59 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 31 Oct
 2025 14:41:58 +0000
Date: Fri, 31 Oct 2025 14:41:57 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Pengjie Zhang <zhangpengjie2@huawei.com>
CC: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2] PM / devfreq: use _visible attribute to replace
 create/remove_sysfs_files()
Message-ID: <20251031144157.00000e51@huawei.com>
In-Reply-To: <20251028022458.2824872-1-zhangpengjie2@huawei.com>
References: <20251028022458.2824872-1-zhangpengjie2@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 28 Oct 2025 10:24:58 +0800
Pengjie Zhang <zhangpengjie2@huawei.com> wrote:

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
Hi

Various comments inline.

Jonathan

> @@ -1805,19 +1801,26 @@ static struct attribute *devfreq_attrs[] = {
>  	&dev_attr_min_freq.attr,
>  	&dev_attr_max_freq.attr,
>  	&dev_attr_trans_stat.attr,
> -	NULL,
> +	NULL
Whilst a good change, doesn't belong in a patch doing anything more
substantial.  So not in here.

>  };
> -ATTRIBUTE_GROUPS(devfreq);

>  static ssize_t polling_interval_store(struct device *dev,
> @@ -1828,15 +1831,22 @@ static ssize_t polling_interval_store(struct device *dev,
>  	unsigned int value;
>  	int ret;
>  
> -	if (!df->governor)
> +	mutex_lock(&devfreq_list_lock);

As below I'd use guard() to simplify this.  Applies in various other places in this
patch.


> +	if (!df->governor ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL)) {
> +		mutex_unlock(&devfreq_list_lock);
>  		return -EINVAL;
> +	}
>  
>  	ret = sscanf(buf, "%u", &value);
> -	if (ret != 1)
> +	if (ret != 1) {
> +		mutex_unlock(&devfreq_list_lock);
>  		return -EINVAL;
> +	}
>  
>  	df->governor->event_handler(df, DEVFREQ_GOV_UPDATE_INTERVAL, &value);
>  	ret = count;
> +	mutex_unlock(&devfreq_list_lock);
>  
>  	return ret;
>  }
> @@ -1846,11 +1856,19 @@ static ssize_t timer_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	int ret;
>  
> -	if (!df->profile)
> +	mutex_lock(&devfreq_list_lock);

guard() would be useful here.

> +	if (!df->profile || !df->governor ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, TIMER)) {
> +		mutex_unlock(&devfreq_list_lock);
>  		return -EINVAL;
> +	}
> +
> +	ret = sprintf(buf, "%s\n", timer_name[df->profile->timer]);
> +	mutex_unlock(&devfreq_list_lock);
>  
> -	return sprintf(buf, "%s\n", timer_name[df->profile->timer]);
> +	return ret;
>  }
>  
>  static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
> @@ -1861,12 +1879,18 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>  	int timer = -1;
>  	int ret = 0, i;
>  
> -	if (!df->governor || !df->profile)
> -		return -EINVAL;
> +	mutex_lock(&devfreq_list_lock);

Perhaps a follow up but this code would be more readable with use of guard()
and returns wherever we are done with anything other than unlocking.


> +	if (!df->governor || !df->profile ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, TIMER)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
>  	ret = sscanf(buf, "%16s", str_timer);
> -	if (ret != 1)
> -		return -EINVAL;
> +	if (ret != 1) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
>  	for (i = 0; i < DEVFREQ_TIMER_NUM; i++) {
>  		if (!strncmp(timer_name[i], str_timer, DEVFREQ_NAME_LEN)) {
> @@ -1901,40 +1925,64 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>  		dev_warn(dev, "%s: Governor %s not started(%d)\n",
>  			 __func__, df->governor->name, ret);
>  out:
> +	mutex_unlock(&devfreq_list_lock);
>  	return ret ? ret : count;
>  }
>  static DEVICE_ATTR_RW(timer);


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
> +	struct devfreq *df;
> +
> +	if (!dev)
> +		return false;
> +
> +	df = to_devfreq(dev);
> +	if (!df)
> +		return false;

Isn't to_devfreq() just a container_of() wrapper?
If that's the case it will always be there if dev is not NULL.

As such I not seeing how this group is likely to ever be
invisible.


> +
> +	return true;
>  }
> +DEFINE_SYSFS_GROUP_VISIBLE(gov);


