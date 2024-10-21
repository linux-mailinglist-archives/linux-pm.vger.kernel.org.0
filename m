Return-Path: <linux-pm+bounces-16160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A83EC9A936D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569351F219B1
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE50A1FDFB1;
	Mon, 21 Oct 2024 22:35:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F33137750;
	Mon, 21 Oct 2024 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550105; cv=none; b=SyGrKGIVc2POx8Wz+gNeX82sUgM0IG3QzSpfN4+p2Ubu98FSW77dsUS5sjFVMbt94jacegC+GqCImy5hTf3UYtlMe2v2Mtl+K2SR3iYn8CzEGQkwphRpFDmTMsYTlge/bEhfm6uKs/kPjTlFV3nfEY0uXGWf1HCHLSrO6Jw6P+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550105; c=relaxed/simple;
	bh=f98/qo00noQWRFkD9nuXXI/RV1bePugekkJnkv6zlb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+ktZOTbMmOz+EIWjQUf2lw2N/uvbTouHA8HonZTX5Wf3GeQz36BT7QFadLhHXVuXGh9oHd3qPwXjuiQZXSMrTbolbJ5qpAJRTo3Yt5I1jTr/19AWPQmjfVPEiOg06GCabSPDNm54o7Dy/0yRvTx1GRMCtrs/GdZxk7aGdAgMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0355497;
	Mon, 21 Oct 2024 15:35:32 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9789C3F71E;
	Mon, 21 Oct 2024 15:35:01 -0700 (PDT)
Message-ID: <01c9767b-d90f-4ea4-9b6a-4179f998f67b@arm.com>
Date: Mon, 21 Oct 2024 23:36:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] thermal: core: Drop need_update field from
 struct thermal_zone_device
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <2495061.jE0xQCEvom@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2495061.jE0xQCEvom@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:35, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After previous changes, the need_update field in struct thermal_zone_device
> is only set and never read, so drop it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/3261209.5fSG56mABF@rjwysocki.net/
> 
> v1 -> v2: Rebase.
> 
> ---
>   drivers/thermal/thermal_core.c |    4 ----
>   drivers/thermal/thermal_core.h |    2 --
>   2 files changed, 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -840,7 +840,6 @@ static int thermal_bind_cdev_to_trip(str
>   	if (!result) {
>   		list_add_tail(&dev->tz_node, &tz->thermal_instances);
>   		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
> -		atomic_set(&tz->need_update, 1);
>   
>   		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
>   	}
> @@ -1505,9 +1504,6 @@ thermal_zone_device_register_with_trips(
>   	if (result)
>   		goto remove_id;
>   
> -	/* A new thermal zone needs to be updated anyway. */
> -	atomic_set(&tz->need_update, 1);
> -
>   	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
>   	if (result) {
>   		thermal_zone_destroy_device_groups(tz);
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -95,7 +95,6 @@ struct thermal_governor {
>   			trip point.
>    * @prev_high_trip:	the above current temperature if you've crossed a
>   			passive trip point.
> - * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
>    * @ops:	operations this &thermal_zone_device supports
>    * @tzp:	thermal zone parameters
>    * @governor:	pointer to the governor for this thermal zone
> @@ -129,7 +128,6 @@ struct thermal_zone_device {
>   	int passive;
>   	int prev_low_trip;
>   	int prev_high_trip;
> -	atomic_t need_update;
>   	struct thermal_zone_device_ops ops;
>   	struct thermal_zone_params *tzp;
>   	struct thermal_governor *governor;
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

