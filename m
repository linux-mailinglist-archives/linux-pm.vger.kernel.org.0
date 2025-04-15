Return-Path: <linux-pm+bounces-25443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FACA89716
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75EE189D968
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF61DF759;
	Tue, 15 Apr 2025 08:50:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BBE19C553;
	Tue, 15 Apr 2025 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707026; cv=none; b=bh5hQIT7fJSfgpgF2RUqEmuliGkLMTI6QA3azQ12ImMgxJemmDDc3kcThvWbNO3iT2vIqXBropVmDluyZNKpSKlWZwDFy785lYF07n+/9YiLJ8q2WmqIhQD6mvuYlMzBZrXQUTAmM1uUC/kV+Jpj/D7iDt83Atw4LhPAjbmKAEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707026; c=relaxed/simple;
	bh=n03h9Zy7GpkRKI6xjpJWJQOJLZGcig0IBGto/J35gn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nde0l6uBAb6zE8QXDG2XOV8/Hx2JogFeG7YpHwKhw8lC5UlrkxF2NQykdNyFRQ9ioZodz/a52ISotGwL1ssd5GcxiE09jHR+V2l7y2AuVWc2AkUXsDflFrFixtJAsrVKKojbjbBpmqamQUiTJ28ELOMaCmJzeITZY5Nup3l+qFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C6BE339;
	Tue, 15 Apr 2025 01:50:19 -0700 (PDT)
Received: from [10.57.68.100] (unknown [10.57.68.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA43A3F694;
	Tue, 15 Apr 2025 01:50:19 -0700 (PDT)
Message-ID: <0fc11aa1-e329-4f0d-a547-1ead73111088@arm.com>
Date: Tue, 15 Apr 2025 09:50:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: Yaxiong Tian <iambestgod@qq.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <tencent_6D2374392DB66C9D23BF6E2546638A42EC08@qq.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <tencent_6D2374392DB66C9D23BF6E2546638A42EC08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/25 10:04, Yaxiong Tian wrote:
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
> Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove division")
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>   kernel/power/energy_model.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index d9b7e2b38c7a..fc972cc1fc12 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -235,7 +235,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>   
>   	/* Compute the cost of each performance state. */
>   	for (i = nr_states - 1; i >= 0; i--) {
> -		unsigned long power_res, cost;
> +		unsigned long power_res, cost = 0;
>   
>   		if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
>   			ret = cb->get_cost(dev, table[i].frequency, &cost);
> @@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>   					cost, ret);
>   				return -EINVAL;
>   			}
> -		} else {
> +		} else if (_is_cpu_device(dev)) {
>   			/* increase resolution of 'cost' precision */
>   			power_res = table[i].power * 10;
>   			cost = power_res / table[i].performance;

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

