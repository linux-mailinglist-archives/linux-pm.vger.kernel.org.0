Return-Path: <linux-pm+bounces-15135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC8F98FE2F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 09:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B442814AA
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD49139D03;
	Fri,  4 Oct 2024 07:56:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969AF7F7CA;
	Fri,  4 Oct 2024 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028576; cv=none; b=Tm6jwqcCxtgxHmgaFzl4KCO/E0xzhUh6aFFyGVFfnCBMCfY5AfaEGGYYPFTYa9lldm0Sj5R9rz9QgQkyvP+opnh79C6OioiyjGI6sVqEUAutj+3y1B+6s9ZHAgh6v8zjQEMyVf7dYIsVqTrM9Ha0xWNvZ+/ByC5wFhFKzUML+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028576; c=relaxed/simple;
	bh=vcUo44yXnAuxnWVyPnPjEmKC4oZy4wLFAKgzz/6lqdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/9W/5+ZnvrauJhvKuvGLio+3V0VKzJyQ+8dOBNYMUQCuXCMMIJ/+BxM9GA3riBATxO004bq1PaRIL5QwlANRTQPYb3zITWxoHBcjsrMwy3vb8qWfHJUNKRnYdjyA8mEOen48PXB+FtpoSmuYly1+xqQvNW6AYi7C6p9eC68G3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34703339;
	Fri,  4 Oct 2024 00:56:41 -0700 (PDT)
Received: from [10.57.77.142] (unknown [10.57.77.142])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736AD3F64C;
	Fri,  4 Oct 2024 00:56:10 -0700 (PDT)
Message-ID: <09a3f091-6201-4911-b8bb-21440f38df07@arm.com>
Date: Fri, 4 Oct 2024 08:57:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: core: Free tzp copy along with the
 thermal zone
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <12549318.O9o76ZdvQC@rjwysocki.net>
 <4623516.LvFx2qVVIh@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4623516.LvFx2qVVIh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/24 13:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The object pointed to by tz->tzp may still be accessed after being
> freed in thermal_zone_device_unregister(), so move the freeing of it
> to the point after the removal completion has been completed at which
> it cannot be accessed any more.
> 
> Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
> Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: No changes
> 
> ---
>   drivers/thermal/thermal_core.c |    4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1606,14 +1606,12 @@ void thermal_zone_device_unregister(stru
>   	ida_destroy(&tz->ida);
>   
>   	device_del(&tz->device);
> -
> -	kfree(tz->tzp);
> -
>   	put_device(&tz->device);
>   
>   	thermal_notify_tz_delete(tz);
>   
>   	wait_for_completion(&tz->removal);
> +	kfree(tz->tzp);
>   	kfree(tz);
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

