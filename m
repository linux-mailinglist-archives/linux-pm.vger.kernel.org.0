Return-Path: <linux-pm+bounces-16150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962239A9311
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD891F22522
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4861FB3F4;
	Mon, 21 Oct 2024 22:15:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C271C68BC;
	Mon, 21 Oct 2024 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548900; cv=none; b=X1SizMTLsvpTdj2PQK5GAYHV2/UzqZrQLsJrsUaw/o4SYPGUBBuTtUdCXF+83U6pesJewkN49bRV3pCnSVzsrui4Zdoi+295xWmwUYleqnV9hWmXsmaaevrOaSKt8WMmQjpOoTlrkHShoNKBHWV4yySaKHchMmxTn/MDMRsINAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548900; c=relaxed/simple;
	bh=W9HY08KdiLPFLFE6KN3n1h29/2yl4jr6VssCyrQZpCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+zUQ1yElAhbHiQBOYcvvIk1bVUzria9Ae/4U7lRuRfbBEP7aBErPlPK0VCj7UyuAvL9fOYvYlTnhUFYGNOMEx6v5K79Aq7DcPHI4/hqYDmO6Br6W68ohCZ1k6stg6ZvcNp1tUAGXqtn6pWH3+GLS0G/+eTfnbgDKirXYtIMxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C35AA497;
	Mon, 21 Oct 2024 15:15:27 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C424C3F71E;
	Mon, 21 Oct 2024 15:14:56 -0700 (PDT)
Message-ID: <6b8787ee-31a1-4d09-a856-dd69f8c5ae28@arm.com>
Date: Mon, 21 Oct 2024 23:16:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] thermal: core: Initialize thermal zones before
 registering them
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <3336146.44csPzL39Z@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3336146.44csPzL39Z@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since user space can start interacting with a new thermal zone as soon
> as device_register() called by thermal_zone_device_register_with_trips()
> returns, it is better to initialize the thermal zone before calling
> device_register() on it.
> 
> Fixes: d0df264fbd3c ("thermal/core: Remove pointless thermal_zone_device_reset() function")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/10527854.nUPlyArG6x@rjwysocki.net/
> 
> v1 -> v2: Fix typo in the subject
> 
> ---
>   drivers/thermal/thermal_core.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1465,6 +1465,7 @@ thermal_zone_device_register_with_trips(
>   		thermal_zone_destroy_device_groups(tz);
>   		goto remove_id;
>   	}
> +	thermal_zone_device_init(tz);
>   	result = device_register(&tz->device);
>   	if (result)
>   		goto release_device;
> @@ -1503,7 +1504,6 @@ thermal_zone_device_register_with_trips(
>   
>   	mutex_unlock(&thermal_list_lock);
>   
> -	thermal_zone_device_init(tz);
>   	/* Update the new thermal zone and mark it as already updated. */
>   	if (atomic_cmpxchg(&tz->need_update, 1, 0))
>   		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

