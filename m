Return-Path: <linux-pm+bounces-12613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2CC95989F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 12:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D047D1F225AB
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE661E7931;
	Wed, 21 Aug 2024 09:19:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84791E792A;
	Wed, 21 Aug 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231954; cv=none; b=R9ct8Fy1g1tPN5aCrVI2rCiI4ENoSz1cabvp7d0fER2UO/SA/2HkSQRe6Y2pXJkXYJQMnOHfED6wb1omQSQnnpCBlGFzIuC7a8/dsns21eOFIMJ5t3Zk+aT0/2L/+cqzhITqbu9eWnlosKVAhovzHTrXZV7ts8wQ8rDr8Q+aVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231954; c=relaxed/simple;
	bh=STLh8cZrdthMOQTjFWVlASDYQEDa29kidX5MGa4Lpak=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tTTnJ1N6nGavUT2MrbqSOhoPzwW4EgHLU9c2uDOIDqZGe1O8ejqVgacrNPVXmwZ7BxwFDabUeF4zLslcDrjE3RCpT/3GQksdfQ8GtHZYhsjXLHlV2T9Z0doB4pyd9FZdopEeBGUvnN3pgfvnlmtkmka4GZ8QOQgiasmRPS3qQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wpgkc03tsz1j6mW;
	Wed, 21 Aug 2024 17:19:04 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DF3F1402D0;
	Wed, 21 Aug 2024 17:19:06 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 17:18:51 +0800
Message-ID: <bab5dfa4-7b75-0f21-e20d-371230df7e8f@huawei.com>
Date: Wed, 21 Aug 2024 17:18:50 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 08/14] thermal: core: Unexport
 thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui
	<rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3512161.QJadu78ljV@rjwysocki.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <3512161.QJadu78ljV@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/20 0:05, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
> are only called locally in the thermal core now, they can be static,
> so change their definitions accordingly and drop their headers from
> the global thermal header file.
The thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip() are 
used by acpi/thermal.c.
I guess that the patch [07/14] I didn't receive must have done that.
If so, I'd like add:
Acked-by: Huisong Li <lihuisong@huawei.com>
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v2 -> v3: Rebase after dropping patches [04-05/17] from the series
>
> v1 -> v2: No changes
>
> ---
>   drivers/thermal/thermal_core.c |   10 ++++------
>   include/linux/thermal.h        |    8 --------
>   2 files changed, 4 insertions(+), 14 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -773,7 +773,7 @@ struct thermal_zone_device *thermal_zone
>    *
>    * Return: 0 on success, the proper error value otherwise.
>    */
> -int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
> +static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
>   				     const struct thermal_trip *trip,
>   				     struct thermal_cooling_device *cdev,
>   				     unsigned long upper, unsigned long lower,
> @@ -877,7 +877,6 @@ free_mem:
>   	kfree(dev);
>   	return result;
>   }
> -EXPORT_SYMBOL_GPL(thermal_bind_cdev_to_trip);
>   
>   int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>   				     int trip_index,
> @@ -913,9 +912,9 @@ EXPORT_SYMBOL_GPL(thermal_zone_bind_cool
>    *
>    * Return: 0 on success, the proper error value otherwise.
>    */
> -int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
> -				  const struct thermal_trip *trip,
> -				  struct thermal_cooling_device *cdev)
> +static int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
> +					 const struct thermal_trip *trip,
> +					 struct thermal_cooling_device *cdev)
>   {
>   	struct thermal_instance *pos, *next;
>   
> @@ -945,7 +944,6 @@ unbind:
>   	kfree(pos);
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(thermal_unbind_cdev_from_trip);
>   
>   int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
<...>
>
>
>
>
> .

