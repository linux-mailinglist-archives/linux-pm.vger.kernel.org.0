Return-Path: <linux-pm+bounces-39133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F13C9D830
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 02:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CA1734AD41
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 01:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FFD22D7B1;
	Wed,  3 Dec 2025 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nJ4bGY90"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D24226541;
	Wed,  3 Dec 2025 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764725931; cv=none; b=rqwTb7dq2y8ajMMvtyEGq7+Tcq6S4MIFj4iZI3PcSVNzk8oM3O1nZXzYy6Jyb0Zk9YGDY0X6LEcm88UG5Iz8esnke7wWKieELYjGFhp/U+Zo/VgdOi8c7FBUVYPcC7Dhg3TwGubAu6lOFDbvyg9NiU6RvTWpB+RjSGQ6qPMstH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764725931; c=relaxed/simple;
	bh=PfMQaeDnnl4MnyiXtJJS2dAvrHk1YXK41DCfQnVk6BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UllkxBAHkc20thKV9cc/DhNtPW+4O1IhnXJYTbQmQBwD7NZL9qjTEgpg5isdHS/GvJOuEzuQzSVdYay5qnzGemQUSyCf/H8FnHVjWaONb85szscDZreZ6Siqw2eqWKCUPCWPyvt8yZ0bacNRLs5/ZiRzT1ItJeGf+ib9N6dJSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nJ4bGY90; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764725925; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lWIxNJVoc17yULX/RoqXddhpKPmOtUO39F9coOv9XGI=;
	b=nJ4bGY90EsvRcP4p/x76YDqJA5m4RFN5YeIAYB/bMl/47NSly6BuQAdyac2rpvIR2CXtkkA25hBzCjGGlQftGb2XLojighErq7XawEPE95Jo25p5Y9PaQCmbEs+M4OGgRWteUKxzE7Z4LPry8L6qH7ookXsVdi1xXvjhR/m30uA=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wtyqe5d_1764725924 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Dec 2025 09:38:44 +0800
Message-ID: <426fda8e-44f7-44a3-9bc8-97abbf000f21@linux.alibaba.com>
Date: Wed, 3 Dec 2025 09:38:43 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: sprd: Fix temperature clamping in
 sprd_thm_temp_to_rawdata
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Freeman Liu <freeman.liu@unisoc.com>
Cc: stable@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251202114758.375008-2-thorsten.blum@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251202114758.375008-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/2 19:47, Thorsten Blum wrote:
> The temperature was never clamped to SPRD_THM_TEMP_LOW or
> SPRD_THM_TEMP_HIGH because the return value of clamp() was not used. Fix
> this by assigning the clamped value to 'temp'.
> 
> Casting SPRD_THM_TEMP_LOW and SPRD_THM_TEMP_HIGH to int is also
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
> index f7fa83b2428e..44fa45f74da7 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -192,7 +192,7 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
>   {
>   	u32 val;
>   
> -	clamp(temp, (int)SPRD_THM_TEMP_LOW, (int)SPRD_THM_TEMP_HIGH);
> +	temp = clamp(temp, SPRD_THM_TEMP_LOW, SPRD_THM_TEMP_HIGH);
>   
>   	/*
>   	 * According to the thermal datasheet, the formula of converting

Good catch. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

