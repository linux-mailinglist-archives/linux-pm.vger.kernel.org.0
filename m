Return-Path: <linux-pm+bounces-39135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ABBC9D860
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 02:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F05114E021A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B022B5A5;
	Wed,  3 Dec 2025 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HfMMZ0j0"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16DC1BC2A;
	Wed,  3 Dec 2025 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726491; cv=none; b=QVmtNnU6K0J4smp0vdR3Y74SR9YEi1Io8+ZMocp4bon2jWOGXvE4cAaPs99JXYS/7JobqHr6BCKgfLNv0dF5+uB6qkGjgKuF+2eOWNYtUwtX8058AgmIhUx6shX7eZpJvC4cGyFW26GhQL4L6rGd4IGSZRiNR6joR+hFil9Z0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726491; c=relaxed/simple;
	bh=3IEbSSIGY1K2KBwwJCtYLO70n+uC1YRBMAZ0Xri1ef0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+MGZSTu8s/9I7lh5/aV0WRsvxX3GB667ptyt44/VSqxr1zWYxhQO83p1Qetz3+OxmJ5FBXOhCBMiel55GT3PPOEOj6TSos5vTelGbqnbWx7EeAYsGU80nMz2yDDUQLYH3FBTY4CUUcKEm5/ojB8sFbxAmiN9CAEazC0Jk8ZkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HfMMZ0j0; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764726485; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ORfL5gjDwRQCe60pr235jtLTbJGnEJ+qqnGzT1XI7xg=;
	b=HfMMZ0j0yg4sZBmUSTybXO9dJ1vTVw04wl75wxOQVsHTCpOH1dAY0xkqm9J7qTtRwwPBFxPSOnRvz70z49XSR+Ga3oT+da0v83CGpr8WX00iekE5nTndUuK+RDha/CECqXJbtdmd7POFqWqBTa450c65+QKkWeVxxzaTDjlSH/g=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wtz4oIL_1764726484 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Dec 2025 09:48:05 +0800
Message-ID: <4baf9afc-bcc5-405d-9d9b-55a988c9f43e@linux.alibaba.com>
Date: Wed, 3 Dec 2025 09:48:04 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: sprd: Use min instead of clamp in
 sprd_thm_temp_to_rawdata
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251202115034.375174-1-thorsten.blum@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251202115034.375174-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/2 19:50, Thorsten Blum wrote:
> Clamping 'val' to itself is unnecessary and the expression can be
> simplified by using min() instead. Casting SPRD_THM_RAW_DATA_HIGH to u32
> is also redundant and can be removed.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/thermal/sprd_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> index 44fa45f74da7..d683fcb0f8ab 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -201,7 +201,7 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
>   	 */
>   	val = (temp + sen->cal_offset) / sen->cal_slope;
>   
> -	return clamp(val, val, (u32)(SPRD_THM_RAW_DATA_HIGH - 1));
> +	return min(val, SPRD_THM_RAW_DATA_HIGH - 1);
>   }
>   
>   static int sprd_thm_read_temp(struct thermal_zone_device *tz, int *temp)

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

