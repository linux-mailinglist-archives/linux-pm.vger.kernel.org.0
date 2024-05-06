Return-Path: <linux-pm+bounces-7520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F278BCAF5
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 11:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E211F23566
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF68A1422CA;
	Mon,  6 May 2024 09:41:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B32142624;
	Mon,  6 May 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988518; cv=none; b=VqtlwvZZaH0ykO+zx7rndVCAnBdl17W3Qep1D/RESVEqr7VGVwmUPtCOM9JuONDFLGxhPxaZm/wKiI4a6R/eaRZhfdZqbfmC9x72s4Sm0uendpsLenhDbUfFyBo0ScbM4e5zEy959VF1D+y41HobU1+u9W6Y3Erw+XmPUPtkU5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988518; c=relaxed/simple;
	bh=+lHk3VtGSNSiz+wqOUZKtrJy7J/Ahy/OEilvl9DQpXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvtYm8mqt2hat7UF+PKE9pE0+7oyFff6Jawd7EKZVycQ5ynoTvO7VhBKlsZi8jg8sFUqosdJi0l7sAHhJKOTCY6IlpxuBCB0jLV10yZquHPAFHNd3Fd0oGhHHefdy0RBNuWj0pzMCOYjPMdmCCCa72MljVOFQ91GfZ5XrMo1UVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33FF0106F;
	Mon,  6 May 2024 02:42:19 -0700 (PDT)
Received: from [10.57.66.153] (unknown [10.57.66.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B40893F793;
	Mon,  6 May 2024 02:41:51 -0700 (PDT)
Message-ID: <67159a18-3923-4345-bff8-ade49cc769ba@arm.com>
Date: Mon, 6 May 2024 10:41:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/cpufreq: increment i in
 cpufreq_get_requested_power()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <a7c1fe73-b40e-437c-8ccb-7b3baad04df7@moroto.mountain>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <a7c1fe73-b40e-437c-8ccb-7b3baad04df7@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan,

On 5/4/24 12:25, Dan Carpenter wrote:
> We accidentally deleted the "i++" as part of a cleanup.  Restore it.
> 
> Fixes: 3f7ced7ac9af ("drivers/thermal/cpufreq_cooling : Refactor thermal_power_cpu_get_power tracing")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This is based on static analysis and not tested.

Thank you for the patch. I have analyzed the code and why it
haven't trigger an issue when I was testing it.

I looks like the function get_load() which is called above that 'i++'
and takes the 'i' as the last argument is compiled in 2 versions:
1. for SMP system and the last argument 'cpu_idx' is ignored
2. for !SMP where we use the last argument 'cpu_idx' which is 'i'
value. Although, for !SMP system we only have 1 cpu, thus the
initialized 'int i = 0' at the beginning of that
cpufreq_get_requested_power() is used correctly.
The loop for !SMP goes only once.

> 
>   drivers/thermal/cpufreq_cooling.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 280071be30b1..a074192896de 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -249,6 +249,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>   			load = 0;
>   
>   		total_load += load;
> +		i++;
>   	}
>   
>   	cpufreq_cdev->last_load = total_load;

Would you agree that I will keep you as 'Reported-by' and send a
separate patch to change that !SMP code completely in that
get_load() function and get rid of the 'cpu_idx' argument?
Or I'm happy that you can develop such code and I can review it.
It's up to you.

Regards,
Lukasz

