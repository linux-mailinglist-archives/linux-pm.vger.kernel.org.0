Return-Path: <linux-pm+bounces-25597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A8A91366
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BBD189E38D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 05:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7D1E1DEB;
	Thu, 17 Apr 2025 05:57:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1EF1B4223;
	Thu, 17 Apr 2025 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744869476; cv=none; b=pt/DKvC4QUiWPLZtvLFuIQLwiixTfE2YFRhMWj0KBGWTx3Fx8qmvg+tCtGOnq1+QARqSU0NowXUOMozOe6pQv7URu7UXaj1lxDqpyM+cNhTFbALTUDEY85JWwgF+185dy8ROu6sm0T0pOl6riEj95dAul3FKR0Q09aTGMXGrDKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744869476; c=relaxed/simple;
	bh=u8zjkPFaeKGDmMPx2SMuPTj91LKk5AD9oTuAIaEtfBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsJUhj8CZtaH1+YcIZ9koTPGb8rlZsprIlCX1ZZM503kJ6hN4/ltFlW5ji8oZm1pB2xYhi3hRbaX/unSRFDjYE9414yWjN5GpzjFI7BamgbAufWmALqkc60j6Q2OOI2BuAXv1q5rJaR5LJQ4GZIOxPa3ZCbzMu37p5i8k/olKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B65F02B;
	Wed, 16 Apr 2025 22:57:50 -0700 (PDT)
Received: from [10.57.72.153] (unknown [10.57.72.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20F1A3F694;
	Wed, 16 Apr 2025 22:57:51 -0700 (PDT)
Message-ID: <1ca192e6-3a45-45c6-b4f0-be6a89eaf192@arm.com>
Date: Thu, 17 Apr 2025 06:57:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: Yaxiong Tian <iambestgod@qq.com>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yaxiong Tian <tianyaxiong@kylinos.cn>
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <tencent_2256A7C02F7849F1D89390E488704E826D06@qq.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <tencent_2256A7C02F7849F1D89390E488704E826D06@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/25 02:07, Yaxiong Tian wrote:
> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
> 
> When the device is of a non-CPU type, table[i].performance won't be
> initialized in the previous em_init_performance(), resulting in division
> by zero when calculating costs in em_compute_costs().
> 
> Since the 'cost' algorithm is only used for EAS energy efficiency
> calculations and is currently not utilized by other device drivers, we
> should add the _is_cpu_device(dev) check to prevent this division-by-zero
> issue.
> 
> Fixes: 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove division")
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>   kernel/power/energy_model.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index d9b7e2b38c7a..41606247c277 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -233,6 +233,10 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>   	unsigned long prev_cost = ULONG_MAX;
>   	int i, ret;
>   
> +	/* This is needed only for CPUs and EAS skip other devices */
> +	if (!_is_cpu_device(dev))
> +		return 0;
> +
>   	/* Compute the cost of each performance state. */
>   	for (i = nr_states - 1; i >= 0; i--) {
>   		unsigned long power_res, cost;


Please stop for a while. I have to check what happened that you
faced the issue in the first place. I have been testing the GPU
EMs and there was no issues...

Let me debug that today.

