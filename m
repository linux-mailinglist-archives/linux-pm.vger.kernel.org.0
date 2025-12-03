Return-Path: <linux-pm+bounces-39132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4414DC9D821
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 02:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E211934AE67
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614AC221FBF;
	Wed,  3 Dec 2025 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J+KuWgrI"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1AE21ADA7;
	Wed,  3 Dec 2025 01:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764725856; cv=none; b=Qm5/28s3JgC5Usd6J+mrXiGRNO+06P/FAkU1CeN06QSC5BIRJBeILrKQyqlsx5vepx4pwrynMwDTlWOxCunIvZDtakSxJoXBBID8dyh+Kgs/e2gh2WdMOKCUlJ6UrRxn09zHX8Hf7eer7gBBzB6puTDhDOHPeEIWNWTicrfsbo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764725856; c=relaxed/simple;
	bh=XDWR0vEcq4vO6PEkDmATJhmByTtRltAnzDRhyh9PSmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2KY0GiTISn1ZsjKBIlIjdTbMK2/X41gH3oqNxmrlfcPEqbEKD7PoXkpU3fz9s2NXJ4OYoTZPyqB7SLPNKBc8v+Ej30AoZg63km/QT2JBfS6/twmAimyRxunkUF4+hDoYOmSSAa6sr1GcWcFCaIWnaRa+JkYWjdLp4Z8wPcSqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J+KuWgrI; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764725850; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=an4R6xa2fLB/70bklypUmneKfSy9mWtoggXotgtPyIY=;
	b=J+KuWgrIGfkDR9o1Mcj4U9f7VCbU1pfj5MYZkWEIgXf/9xYYFPzdwevnIUFryQNuZD20FtzEeN4H7qpMVwNh2QIqqlsIS9Lw2op1yYfel8MwmVGbNz/gofBoSFTVNjGK9AOemoEJOk5ql1tzpnbHFzXt9VJukaPnx6nXHqeCSa0=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wtyqdim_1764725849 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Dec 2025 09:37:29 +0800
Message-ID: <587213a8-9332-4384-b26b-21f55d8b480b@linux.alibaba.com>
Date: Wed, 3 Dec 2025 09:37:28 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: sprd: Fix raw temperature clamping in
 sprd_thm_rawdata_to_temp
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Freeman Liu <freeman.liu@unisoc.com>
Cc: stable@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251202114644.374869-2-thorsten.blum@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251202114644.374869-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/2 19:46, Thorsten Blum wrote:
> The raw temperature data was never clamped to SPRD_THM_RAW_DATA_LOW or
> SPRD_THM_RAW_DATA_HIGH because the return value of clamp() was not used.
> Fix this by assigning the clamped value to 'rawdata'.
> 
> Casting SPRD_THM_RAW_DATA_LOW and SPRD_THM_RAW_DATA_HIGH to u32 is also
> redundant and can be removed.
> 
> Cc: stable@vger.kernel.org
> Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/thermal/sprd_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> index e546067c9621..f7fa83b2428e 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -178,7 +178,7 @@ static int sprd_thm_sensor_calibration(struct device_node *np,
>   static int sprd_thm_rawdata_to_temp(struct sprd_thermal_sensor *sen,
>   				    u32 rawdata)
>   {
> -	clamp(rawdata, (u32)SPRD_THM_RAW_DATA_LOW, (u32)SPRD_THM_RAW_DATA_HIGH);
> +	rawdata = clamp(rawdata, SPRD_THM_RAW_DATA_LOW, SPRD_THM_RAW_DATA_HIGH);
>   
>   	/*
>   	 * According to the thermal datasheet, the formula of converting

Ah, good catch. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

