Return-Path: <linux-pm+bounces-16927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4C59BAF55
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 10:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08D31F21118
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12418A6DE;
	Mon,  4 Nov 2024 09:13:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6E914B06C;
	Mon,  4 Nov 2024 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711605; cv=none; b=uyWXgHeFsRLT7eE9T5VItXvud3Xz1BsdjYGbozRE6EbSi2FOwxC8OnuIPlVvMPopK4gbXBGYfTC5zlaIXY0nZuki+uNaGHaiJthw/bYu+AAcHeYaafz1XESNZOENTeqNkshR3tnxvy9EfRQEUfSa7nW+1hpemQr4b03nWQr06lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711605; c=relaxed/simple;
	bh=1Wn9lJJ64nG1dBRnKt1BRv0EoGO9m4PgqXk4KRYKZcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qR/iBd50gZpLl36T/LFYc76kixCTcvE2uw5qnhX09iXbOwgdwhWBjehPp0cM1K/8K/OfcXpE8tIy3CENnmf556RyL6Ts7D0kKgzzVBoWBLW5FhWCoQw8ULBdzMWMrlCEnVu8muFylniQ5r/K5NzvJATPdTRUQ/Mgnq5Bw8SPLEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FDC8FEC;
	Mon,  4 Nov 2024 01:13:51 -0800 (PST)
Received: from [10.57.56.89] (unknown [10.57.56.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42FF53F6A8;
	Mon,  4 Nov 2024 01:13:20 -0800 (PST)
Message-ID: <3386f37a-55f4-43e0-a991-7cf4ece2e55a@arm.com>
Date: Mon, 4 Nov 2024 09:14:36 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: Fix uninitialized power in em_create_perf_table
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20241104090351.1352997-1-ruanjinjie@huawei.com>
Content-Language: en-US
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
 linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, qperret@google.com
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241104090351.1352997-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jinjie,

On 11/4/24 09:03, Jinjie Ruan wrote:
> In em_create_perf_table(), power is uninitialized and passed the pointer
> to active_power() hook, but the hook function may not assign it and
> return 0, such as mtk_cpufreq_get_cpu_power(), so the later zero check for

Please fix the driver. I have checked that function. It must return
-EINVAL when the 'policy' is not found. We cannot progress with power=0.


> power is not invalid, initialize power to zero to fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7d9895c7fbfc ("PM / EM: introduce em_dev_register_perf_domain function")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   kernel/power/energy_model.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 927cc55ba0b3..866a3e9c05b2 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -344,7 +344,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>   				struct em_data_callback *cb,
>   				unsigned long flags)
>   {
> -	unsigned long power, freq, prev_freq = 0;
> +	unsigned long power = 0, freq, prev_freq = 0;
>   	int nr_states = pd->nr_perf_states;
>   	int i, ret;
>   


This patch proposal is just a workaround.

When you send a patch to that MTK driver, I can review it for you so
please add me on CC.

Regards,
Lukasz

