Return-Path: <linux-pm+bounces-39310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCB0CAD487
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 14:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60DC63027E0B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3033148A5;
	Mon,  8 Dec 2025 13:31:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DCC1EE033;
	Mon,  8 Dec 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200702; cv=none; b=PXOiA8C4Z2LD9PiQV25De+MgkRuAJzuTXYscbfQtbFyxjkJRhZ5vtQaKxZq07RAT63Dv5acRmOAVpp0KSLdhPulkbqiJfcMvmZZ+HHNRwYZNI6DI/LAKqsqdIFCbhgbGQDKwlU0yeejPSt/gGHfECSTuFiSkiWhMjYsvo0IKU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200702; c=relaxed/simple;
	bh=6y3GM72uagpXLLTp6gZX3kDn5Pb1zt77/ijxRpA11SI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7mW++gddbbhSiREzhv4pF56G7+yMTN3iWQPzj+74kM+3sa8M9lP/fJ9VJQ03IkY2NNUbus5w8OsTgTJ5rfucd5PnF48JutayPRmObDHIv+4OdQbws4me0hCTYd4FL5gxY3m675epWE2VTqvqkXWR5U7gadhTwq5lJmWYjE1hqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dQ2tp4VNjzJ469d;
	Mon,  8 Dec 2025 21:31:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F68F40565;
	Mon,  8 Dec 2025 21:31:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 8 Dec
 2025 13:31:28 +0000
Date: Mon, 8 Dec 2025 13:31:26 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Pengjie Zhang <zhangpengjie2@huawei.com>, <linuxarm@huawei.com>
CC: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <jonathan.cameron@huawei.com>,
	<wangzhi12@huawei.com>
Subject: Re: [PATCH v4] PM / devfreq: use _visible attribute to replace 
 create/remove_sysfs_files()
Message-ID: <20251208133126.00006756@huawei.com>
In-Reply-To: <20251205083724.4068896-1-zhangpengjie2@huawei.com>
References: <20251205083724.4068896-1-zhangpengjie2@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 5 Dec 2025 16:37:24 +0800
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

Hi,

Been a while since I looked at this series (sorry about that!)

A few trivial things inline and one suggestion for a possible follow up
patch.
None are significant enough that I'll look again at this so:

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
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
>  left unReleased.
> Link to v1:https://lore.kernel.org/lkml/20251025135238.3576861-1-zhangpengjie2@huawei.com/
> 
>  drivers/devfreq/devfreq.c | 99 +++++++++++++++++++++++----------------
>  1 file changed, 58 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2e8d01d47f69..afcfc1be2e64 100644
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

This file adopts (at least in first case I looked at) convention of no {}
when a single call is made in if blocks (even when it is multiline).
Coding standard has never been particularly clear on this corner case
so normally I'd advise following local style.

>  		devfreq->governor->event_handler(devfreq,
>  						 DEVFREQ_GOV_STOP, NULL);
> -		remove_sysfs_files(devfreq, devfreq->governor);
>  	}
> -

Technically an unrelated change that I'd be temped to undo just to slightly
reduce patch size.

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

Not directly relevant to this patch, but this function smells like one
that would significantly benefit from guard() and early returns in error paths.

>  
>  out:
>  	mutex_unlock(&devfreq_list_lock);
> @@ -1807,14 +1803,16 @@ static struct attribute *devfreq_attrs[] = {
>  	&dev_attr_trans_stat.attr,
>  	NULL,
>  };

> @@ -1847,7 +1848,10 @@ static ssize_t timer_show(struct device *dev,
>  {
>  	struct devfreq *df = to_devfreq(dev);
>  
> -	if (!df->profile)
> +	guard(mutex)(&devfreq_list_lock);

For these I'd be tempted to add a trivial comment about the race they
are protecting against.  I think it is the window between setting
the IS_SUPPORTED_ATTR() and isvisible being called.

> +
> +	if (!df->profile || !df->governor ||
> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
>  		return -EINVAL;
>  
>  	return sprintf(buf, "%s\n", timer_name[df->profile->timer]);
> @@ -1861,7 +1865,10 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
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


