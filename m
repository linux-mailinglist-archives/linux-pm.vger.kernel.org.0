Return-Path: <linux-pm+bounces-16266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDA29AB839
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 23:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F962281B9D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F6B1CC17D;
	Tue, 22 Oct 2024 21:09:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1251C1CC146;
	Tue, 22 Oct 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631390; cv=none; b=hjP6YSygpxNIUrGavNWgWyePzuPwLXa+bDyvfyVZAgJXsl6JDdiUv3Swrreg1izjwnAwzkb2a7e9PaUqxwnGk/4PQjc/zJEOokOfxkm7AEZJW/jVk9wzULOkl/WtWc9RYCAR61dAhqBpcykvQ33l+AXKIAGoa9OjRDU64sLB028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631390; c=relaxed/simple;
	bh=kBNarLiPJW16vrWPYEyxUqfujGcxrMZwV4NYDtC3x64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eO2P7gt0GqMLc1tqytxPnoJjyRyax1O92Nz3XECbPPaRW0J0XjgL+khqGWSrPTgqHhqImgP9FuYixcXd5uE/LTMJ8RxekdxsG3CnCmIkpqHo2b4UN7rW73GpaxtJjhXn1nbNifSq8xrfQUWL2milmrEubvrwXk0uZWZtXshW8AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24DB8497;
	Tue, 22 Oct 2024 14:10:18 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47BCB3F71E;
	Tue, 22 Oct 2024 14:09:47 -0700 (PDT)
Message-ID: <ea44a43b-a02f-47ca-8143-38ae21f476be@arm.com>
Date: Tue, 22 Oct 2024 22:10:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] thermal: core: Call thermal_governor_update_tz()
 outside of cdev lock
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <7749552.EvYhyI6sBW@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <7749552.EvYhyI6sBW@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/24 23:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Holding a cooling device lock under thermal_governor_update_tz() is not
> necessary and it may cause lockdep to complain if any governor's
> .update_tz() callback attempts to lock a cdev.
> 
> For this reason, move the thermal_governor_update_tz() calls in
> thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip() from
> under the cdev lock.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a resend of
> 
> https://lore.kernel.org/linux-pm/1921484.CQOukoFCf9@rjwysocki.net/
> 
> ---
>   drivers/thermal/thermal_core.c |   11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -832,13 +832,13 @@ static int thermal_bind_cdev_to_trip(str
>   	if (!result) {
>   		list_add_tail(&dev->trip_node, &td->thermal_instances);
>   		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
> -
> -		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
>   	}
>   	mutex_unlock(&cdev->lock);
>   
> -	if (!result)
> +	if (!result) {
> +		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
>   		return 0;
> +	}
>   
>   	device_remove_file(&tz->device, &dev->weight_attr);
>   remove_trip_file:
> @@ -873,9 +873,6 @@ static void thermal_unbind_cdev_from_tri
>   		if (pos->cdev == cdev) {
>   			list_del(&pos->trip_node);
>   			list_del(&pos->cdev_node);
> -
> -			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
> -
>   			mutex_unlock(&cdev->lock);
>   			goto unbind;
>   		}
> @@ -885,6 +882,8 @@ static void thermal_unbind_cdev_from_tri
>   	return;
>   
>   unbind:
> +	thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
> +
>   	device_remove_file(&tz->device, &pos->weight_attr);
>   	device_remove_file(&tz->device, &pos->attr);
>   	sysfs_remove_link(&tz->device.kobj, pos->name);
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

