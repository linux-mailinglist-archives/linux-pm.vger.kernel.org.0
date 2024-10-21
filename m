Return-Path: <linux-pm+bounces-16149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061729A9308
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4811C220C3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFD71FDFA7;
	Mon, 21 Oct 2024 22:10:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FBB1FCC51;
	Mon, 21 Oct 2024 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548618; cv=none; b=aUZzJcn+UyBJNRdxgf3tLrKy7B+OrWuzjcoA6lj7Wqv5Nfbsxpj4ArITG70RNvc2p8MLQm9PS96zEfi93x4xb+MH5c4fZyPNfQKkXWQP0aNSJ1isTa/kkHfMQsiS0fuBz46J6cm36WhmXfKoZC9wJGBMOzwXORzvp/TMEvC8iL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548618; c=relaxed/simple;
	bh=jnXeoGKRGFTD/K1W6aKJIn+T/e/NqOSJnYi1PDW4t3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUk4YsA5+IWpV4glWfVz7vYIB5vtbsdLAaY8btYKAqP+e31yruXW9MA4iVVfEnqWqbsLfXXCtuv9A7pD3S9wIu87lQPZYaUCZI5zmReT150rJCSNWL2kn6FyTX7UcQgsl6S+ojObvTkaPz76tq6Wv/TXkAuwr/qHIBYHHybcY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31F46497;
	Mon, 21 Oct 2024 15:10:45 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6E833F71E;
	Mon, 21 Oct 2024 15:10:13 -0700 (PDT)
Message-ID: <0c02c5a3-9eea-495e-aa39-3aac862b5427@arm.com>
Date: Mon, 21 Oct 2024 23:11:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: gov_power_allocator: Granted power set to max
 when nobody request power
To: ZhengShaobo <zhengshaobo1@xiaomi.com>
Cc: zhuzhangwei <chuci@xiaomi.com>, Zhang Rui <rui.zhang@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 dingchongchong <dingchongchong@xiaomi.com>, chendejun
 <chendejun@xiaomi.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241021121138.422-1-zhengshaobo1@xiaomi.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241021121138.422-1-zhengshaobo1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello ZhengShaobo,

On 10/21/24 13:11, ZhengShaobo wrote:
> From: zhengshaobo1 <zhengshaobo1@xiaomi.com>
> 
> When total_req_power is 0, divvy_up_power() will set granted_power to 0,
> and cdev will be limited to the lowest performance. If our polling delay
> is set to 200ms, it means that cdev cannot perform better within 200ms
> even if cdev has a sudden load. This will affect the performance of cdev
> and is not as expected.
> 
> For this reason, if nobody requests power, then set the granted power to
> the max_power.
> 
> Signed-off-by: zhengshaobo1 <zhengshaobo1@xiaomi.com>
> ---
>   drivers/thermal/gov_power_allocator.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 1b2345a697c5..4301516c0938 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -356,11 +356,19 @@ static void divvy_up_power(struct power_actor *power, int num_actors,
>   	u32 extra_power = 0;
>   	int i;
>   
> -	/*
> -	 * Prevent division by 0 if none of the actors request power.
> -	 */
> -	if (!total_req_power)
> -		total_req_power = 1;
> +	if (!total_req_power) {
> +		/*
> +		 * Nobody requested anything, just give everybody
> +		 * the maximum power
> +		 */
> +		for (i = 0; i < num_actors; i++) {
> +			struct power_actor *pa = &power[i];
> +
> +			pa->granted_power = pa->max_power;
> +		}
> +
> +		return;
> +	}
>   
>   	for (i = 0; i < num_actors; i++) {
>   		struct power_actor *pa = &power[i];

Thank you for the patch. Good catch of that corner case.

If there is no load on those devices, then the temperature should
be low, lower than the 1st trip point. In that case we should
reset the PID and call allow_maximum_power()...

Although, what if the temperature is higher, e.g. due to
ambient temperature and no load on the devices. Then we
hit that corner case and your code would help.

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

