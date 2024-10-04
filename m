Return-Path: <linux-pm+bounces-15136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FF098FE5D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 10:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211B21F21DAB
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 08:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB08B13CFBD;
	Fri,  4 Oct 2024 08:01:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8782913B58F;
	Fri,  4 Oct 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028895; cv=none; b=nTdD/B6Elx1irIvGyKcOlnsCziyAlcF5LyXJt0CbOfSkgIT0U8J6/FsulgjYSHpMeDemx2GfWei/6iZm/7/c8027hqNYUbrT7b1tvxwkhXVAonFEGXaM2sd3MEgEEiGR/BGCxoPLdf2+AkX/jjsl275l60SdE4+Y/e4ns3yumvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028895; c=relaxed/simple;
	bh=ZZ2+6eYhBqp1fE5+pAZtMP2mpfuyj8H7GtB08YmVhd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYIfxdeoTyvDZvAosFMzr8PBKcfV/6ajkWYLsovftvv4rZOrN54rJJ6OngvG1Te3GJS0SPsSaNN8SdDuWyC6pTYc3M/rj3mRgjXlElAPwmOdqwqWv5VuKMgC6LuYeleA8Zr+KZxHg0w6e9poFqIuneVUTrQwiyExUvVW9Pv8Lpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51A3C339;
	Fri,  4 Oct 2024 01:02:02 -0700 (PDT)
Received: from [10.57.77.142] (unknown [10.57.77.142])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7576F3F64C;
	Fri,  4 Oct 2024 01:01:31 -0700 (PDT)
Message-ID: <b2d949a2-2586-44ec-b0e7-0879fd3ac7cf@arm.com>
Date: Fri, 4 Oct 2024 09:02:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: core: Reference count the zone in
 thermal_zone_get_by_id()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <12549318.O9o76ZdvQC@rjwysocki.net>
 <6112242.lOV4Wx5bFT@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <6112242.lOV4Wx5bFT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 10/3/24 13:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are places in the thermal netlink code where nothing prevents
> the thermal zone object from going away while being accessed after it
> has been returned by thermal_zone_get_by_id().
> 
> To address this, make thermal_zone_get_by_id() get a reference on the
> thermal zone device object to be returned with the help of get_device(),
> under thermal_list_lock, and adjust all of its callers to this change
> with the help of the cleanup.h infrastructure.
> 
> Fixes: 1ce50e7d408e ("thermal: core: genetlink support for events/cmd/sampling")
> Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Use the cleanup.h infrastructure to reduce the amount of code changes.
> 
> ---
>   drivers/thermal/thermal_core.c    |    1 +
>   drivers/thermal/thermal_core.h    |    3 +++
>   drivers/thermal/thermal_netlink.c |    9 +++------
>   3 files changed, 7 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -728,6 +728,7 @@ struct thermal_zone_device *thermal_zone
>   	mutex_lock(&thermal_list_lock);
>   	list_for_each_entry(tz, &thermal_tz_list, node) {
>   		if (tz->id == id) {
> +			get_device(&tz->device);
>   			match = tz;
>   			break;
>   		}
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -194,6 +194,9 @@ int for_each_thermal_governor(int (*cb)(
>   
>   struct thermal_zone_device *thermal_zone_get_by_id(int id);
>   
> +DEFINE_CLASS(thermal_zone_get_by_id, struct thermal_zone_device *,
> +	     if (_T) put_device(&_T->device), thermal_zone_get_by_id(id), int id)
> +
>   static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
>   {
>   	return cdev->ops->get_requested_power && cdev->ops->state2power &&
> Index: linux-pm/drivers/thermal/thermal_netlink.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> +++ linux-pm/drivers/thermal/thermal_netlink.c
> @@ -443,7 +443,6 @@ static int thermal_genl_cmd_tz_get_trip(
>   {
>   	struct sk_buff *msg = p->msg;
>   	const struct thermal_trip_desc *td;
> -	struct thermal_zone_device *tz;
>   	struct nlattr *start_trip;
>   	int id;
>   
> @@ -452,7 +451,7 @@ static int thermal_genl_cmd_tz_get_trip(
>   
>   	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
>   
> -	tz = thermal_zone_get_by_id(id);
> +	CLASS(thermal_zone_get_by_id, tz)(id);
>   	if (!tz)
>   		return -EINVAL;
>   
> @@ -488,7 +487,6 @@ out_cancel_nest:
>   static int thermal_genl_cmd_tz_get_temp(struct param *p)
>   {
>   	struct sk_buff *msg = p->msg;
> -	struct thermal_zone_device *tz;
>   	int temp, ret, id;
>   
>   	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> @@ -496,7 +494,7 @@ static int thermal_genl_cmd_tz_get_temp(
>   
>   	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
>   
> -	tz = thermal_zone_get_by_id(id);
> +	CLASS(thermal_zone_get_by_id, tz)(id);
>   	if (!tz)
>   		return -EINVAL;
>   
> @@ -514,7 +512,6 @@ static int thermal_genl_cmd_tz_get_temp(
>   static int thermal_genl_cmd_tz_get_gov(struct param *p)
>   {
>   	struct sk_buff *msg = p->msg;
> -	struct thermal_zone_device *tz;
>   	int id, ret = 0;
>   
>   	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> @@ -522,7 +519,7 @@ static int thermal_genl_cmd_tz_get_gov(s
>   
>   	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
>   
> -	tz = thermal_zone_get_by_id(id);
> +	CLASS(thermal_zone_get_by_id, tz)(id);
>   	if (!tz)
>   		return -EINVAL;
>   
> 
> 
> 

I wasn't aware of that helpers in cleanup.h.

Could you help me to understand when this this
'if (_T) put_device((&_T->device)' will be called?

Regards,
Lukasz

