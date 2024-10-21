Return-Path: <linux-pm+bounces-16157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FB49A9356
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817471F2181F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BAE1E0DE9;
	Mon, 21 Oct 2024 22:30:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25111EB56;
	Mon, 21 Oct 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549838; cv=none; b=RbyEJ6ygSUYEfWvMmJRMTBxQzCPq5fp5VfuRFxQ1ZyUwc7UIkA71d377106t5/5R5YgW1E/hR5YR6M+8MK5Q6KDDlM2lynKOUnKaoFBY5jXMro8uqmUq1+h284FAoKUDak4MP8Bev6aq3HCcrREp6Cc4porSm1bWsJp6grXNUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549838; c=relaxed/simple;
	bh=UD732M7EnrtgsamVXJ5QerbcYazpkpBNPLQt8vDJWpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFoalMG+WlYwSGypVnTi4W5lOkqPGFjRcXk0ISNJxhO6NxhGZkqKalNTgx/mfcTp3uDfbe5+Mr1ubftJeNBPAuCFPpk4pXCi3wj3I0eFCcFGoCWaw1w1lMZy3ZLR7C0fkno4L/tctH9wt+1Qfu+EMe/ESiuAU02FCUpY0VcCD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E87DA497;
	Mon, 21 Oct 2024 15:31:05 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 022A43F71E;
	Mon, 21 Oct 2024 15:30:34 -0700 (PDT)
Message-ID: <91641867-0dd9-46ab-90b7-1d687f3f4408@arm.com>
Date: Mon, 21 Oct 2024 23:31:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] thermal: core: Mark thermal zones as exiting
 before unregistration
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <4394176.ejJDZkT8p0@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4394176.ejJDZkT8p0@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In analogy with a previous change in the thermal zone registration code
> path, to ensure that __thermal_zone_device_update() will return early
> for thermal zones that are going away, introduce a thermal zone state
> flag representing the "exit" state and set it while deleting the thermal
> zone from thermal_tz_list.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/1997536.PYKUYFuaPT@rjwysocki.net/
> 
> v1 -> v2: Rebase.
> 
> ---
>   drivers/thermal/thermal_core.c |    3 +++
>   drivers/thermal/thermal_core.h |    1 +
>   2 files changed, 4 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1613,7 +1613,10 @@ void thermal_zone_device_unregister(stru
>   	}
>   
>   	mutex_lock(&tz->lock);
> +
> +	tz->state |= TZ_STATE_FLAG_EXIT;
>   	list_del(&tz->node);
> +
>   	mutex_unlock(&tz->lock);
>   
>   	/* Unbind all cdevs associated with 'this' thermal zone */
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -64,6 +64,7 @@ struct thermal_governor {
>   #define	TZ_STATE_FLAG_SUSPENDED	BIT(0)
>   #define	TZ_STATE_FLAG_RESUMING	BIT(1)
>   #define	TZ_STATE_FLAG_INIT	BIT(2)
> +#define	TZ_STATE_FLAG_EXIT	BIT(3)
>   
>   #define TZ_STATE_READY		0
>   
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

