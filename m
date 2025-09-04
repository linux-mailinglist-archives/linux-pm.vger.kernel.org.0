Return-Path: <linux-pm+bounces-33803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A31BB43472
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 09:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F79F7B096D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7B2BD58C;
	Thu,  4 Sep 2025 07:45:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D782BD00C;
	Thu,  4 Sep 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971905; cv=none; b=XjHGH1ZAd0ITTqDDqWAV+InscXoitIXpv9pMSBb5lwWYIZXWRMEa0xsDREAaVtE+bag2yZnJ1R/EfwEBTSzgj8A/HciDnVcaxeH0Ea89HYzKjvXgH5NnoSXAn0IETbi986zcDwTZxX00uiOWjP0owBedSFxEx2CBxyXp6/fh7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971905; c=relaxed/simple;
	bh=TSD2eyDvGbT+G+NFzPxAADdNjJbXKtxf4AbD+yj1rwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjsiO/d2ZNcu0ITU1k3T1AWFnthj+3E49yuNjatR//IOYzigoRS8it8fXoafgPMBQpKZBd6GnAg+zsR4oIl4OOHgXI1mgjCMw8ahAe0UGfBQf1mveNf+Ee6a54UJ575bCgkxPhQAkxrALP2U7jfMsgeTv8SoIEzPWqAlDUbBmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19751596;
	Thu,  4 Sep 2025 00:44:54 -0700 (PDT)
Received: from [10.57.60.120] (unknown [10.57.60.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 116383F694;
	Thu,  4 Sep 2025 00:45:01 -0700 (PDT)
Message-ID: <a7dfd3da-fb55-411a-8410-062931c97e3d@arm.com>
Date: Thu, 4 Sep 2025 08:45:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: hwmon: replace deprecated strcpy() with
 strscpy()
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com
References: <20250903192059.11353-1-osama.abdelkader@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250903192059.11353-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/3/25 20:20, Osama Abdelkader wrote:
> strcpy() is deprecated, use strscpy() instead for consistency with thermal
> subsystem since this is the only strcpy there.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v2:
> Improve the commit msg: add that this is the only strcpy left in thermal subsystem
> ---
>   drivers/thermal/thermal_hwmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index 0ecccd4d8556..64cc3ab949fe 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -96,7 +96,7 @@ thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
>   
>   	mutex_lock(&thermal_hwmon_list_lock);
>   	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
> -		strcpy(type, tz->type);
> +		strscpy(type, tz->type);
>   		strreplace(type, '-', '_');
>   		if (!strcmp(hwmon->type, type)) {
>   			mutex_unlock(&thermal_hwmon_list_lock);


LGTM, that was indeed the single occurrence in thermal sub-system.
Thanks!

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

