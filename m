Return-Path: <linux-pm+bounces-12608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044B959806
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 12:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1451F23487
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40221649C6;
	Wed, 21 Aug 2024 08:50:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7241607B0;
	Wed, 21 Aug 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230200; cv=none; b=bHefmoBFn5BNaaLoxezJ5KQ1YE1RlnK0PnJGvEfH51dyZjl38q1k0V53s1Y6i/qkBAXWp6ZqT93Xzu7oR58B+zHtPgR5TI/S87Rpqz6Bf11I54P0igi9qdah8YjbR4R01LlfO8vXLL2mwRRoHbAKiAJLsEV+68i1PcCLkuWWRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230200; c=relaxed/simple;
	bh=LirYJXZb09EV7XOmz4Iw6ZLeN4E3SQFaNblmlIT1gXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g07/CBsFkr005PhUnlakjoeYB+TLmHdYI/w0DwEbDaXz6EJHZsffshc7eZD8sGqQ1EogEeW9/KNzOtSvNgqDirTg0p84TbVPrL35ogtv/t0WNZuX3EGBllQwAXMAfoi34bQSoI4oDWomZtnK7/uN6BZtAqX+ipjJy1TBAOPvCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WpfzX0fBTz20ltp;
	Wed, 21 Aug 2024 16:45:12 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F796180019;
	Wed, 21 Aug 2024 16:49:53 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 16:49:53 +0800
Message-ID: <68ed6185-a602-c0fc-721e-b5d68fea83f8@huawei.com>
Date: Wed, 21 Aug 2024 16:49:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 02/14] thermal: core: Rearrange checks in
 thermal_bind_cdev_to_trip()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui
	<rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3324214.44csPzL39Z@rjwysocki.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <3324214.44csPzL39Z@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/19 23:51, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is not necessary to look up the thermal zone and the cooling device
> in the respective global lists to check whether or not they are
> registered.  It is sufficient to check whether or not their respective
> list nodes are empty for this purpose.
>
> Use the above observation to simplify thermal_bind_cdev_to_trip().  In
> addition, eliminate an unnecessary ternary operator from it.
>
> Moreover, add lockdep_assert_held() for thermal_list_lock to it because
> that lock must be held by its callers when it is running.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v3: No changes
>
> ---
>   drivers/thermal/thermal_core.c |   16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -781,25 +781,17 @@ int thermal_bind_cdev_to_trip(struct the
>   {
>   	struct thermal_instance *dev;
>   	struct thermal_instance *pos;
> -	struct thermal_zone_device *pos1;
> -	struct thermal_cooling_device *pos2;
>   	bool upper_no_limit;
>   	int result;
>   
> -	list_for_each_entry(pos1, &thermal_tz_list, node) {
> -		if (pos1 == tz)
> -			break;
> -	}
> -	list_for_each_entry(pos2, &thermal_cdev_list, node) {
> -		if (pos2 == cdev)
> -			break;
> -	}
> +	lockdep_assert_held(&thermal_list_lock);
>   
> -	if (tz != pos1 || cdev != pos2)
> +	if (list_empty(&tz->node) || list_empty(&cdev->node))
The old verification is ensure that tz and cdev already add to 
thermal_tz_list and thermal_cdev_list，respectively.
Namely, tz and cdev are definitely registered and intialized.
The check is ok for all untizalized thermal_zone_device and cooling device.
But the new verification doesn't seem to do that.
>   		return -EINVAL;
>   
>   	/* lower default 0, upper default max_state */
> -	lower = lower == THERMAL_NO_LIMIT ? 0 : lower;
> +	if (lower == THERMAL_NO_LIMIT)
> +		lower = 0;
>   
>   	if (upper == THERMAL_NO_LIMIT) {
>   		upper = cdev->max_state;
>
>
>
>
> .

