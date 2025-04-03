Return-Path: <linux-pm+bounces-24750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6370A7A018
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 11:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7763E7A69BE
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BBB241678;
	Thu,  3 Apr 2025 09:34:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006E1991B2;
	Thu,  3 Apr 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743672867; cv=none; b=hxDLDWzK8sG2GYeuDq3HN0Dhel0hZjBHPQFxw6/R25gTFMcLh2G1nJEwdKpieIBdxf0Y1vv0445X9d27hryGjF+uPOQiLzlnQ0CpJOcI2RaKNJBPABlLhCTDQupphpJM3UfiyOBIb8a/7xQ2QhewYsQFB7bV/kATmy1/JxULUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743672867; c=relaxed/simple;
	bh=5Y6jaR7HbDn6WObktyGLGv3XbIgeZSDezEEbbZOY4bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zcap+El+uZA5a/5+jOs87UTrkT1tTm4xKFB45KKdcFZpmTlsHHq+dUEQpCMgvNvLkFI3aniIdYOzBjTJaDImSSgzWOMi1milXBrUawj79GStgCzo+sc3GkplFtUy3C6yv0BwItsTb8UgsgRmawXgtbhRVguqN6Nf5NEDMQOVnfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50C45106F;
	Thu,  3 Apr 2025 02:34:27 -0700 (PDT)
Received: from [10.57.40.234] (unknown [10.57.40.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFA883F63F;
	Thu,  3 Apr 2025 02:34:23 -0700 (PDT)
Message-ID: <0d420c47-f336-41c0-83df-066131338b49@arm.com>
Date: Thu, 3 Apr 2025 10:34:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: menu: Optimize bucket assignment when
 next_timer_ns equals KTIME_MAX
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250403092852.1072015-1-quic_zhonhan@quicinc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250403092852.1072015-1-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/25 10:28, Zhongqiu Han wrote:
> Directly assign the last bucket value instead of calling which_bucket()
> when next_timer_ns equals KTIME_MAX, the largest possible value that
> always falls into the last bucket. This avoids unnecessary calculations
> and enhances performance.
> 
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpuidle/governors/menu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 39aa0aea61c6..8fc7fbed0052 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -255,7 +255,12 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		 */
>  		data->next_timer_ns = KTIME_MAX;
>  		delta_tick = TICK_NSEC / 2;
> -		data->bucket = which_bucket(KTIME_MAX);
> +		/*
> +		 * Assign the last bucket value directly instead of calling
> +		 * which_bucket(), since KTIME_MAX is the largest possible
> +		 * value that always falls into the last bucket.
> +		 */

comment almost seems overkill.

> +		data->bucket = BUCKETS - 1;
>  	}
>  
>  	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||


