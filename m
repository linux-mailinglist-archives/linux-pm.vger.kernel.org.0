Return-Path: <linux-pm+bounces-25353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E52A879D9
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 10:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3928D7A4503
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 08:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9160025DAE6;
	Mon, 14 Apr 2025 08:09:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9C025D8E3;
	Mon, 14 Apr 2025 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618140; cv=none; b=TXG+Pt+dJPN0ph7A8TxCqof56HGjJ2cK/iQdZxUu4OEDW8Cgk7YnuRwIvCNlr7SvrzrpFyGgx4hjk6eWzbR1V1IY7S6xW6Y1jdpJXur2Ga5z0NB6sMZLzhFJYv8NWPa/SK98/9yqJZ/Z6y0nkCA1GtX9HPrgKxX+jWh6SWoJ0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618140; c=relaxed/simple;
	bh=crlDOiIzpqHhF4EOe6WJHSMXqxU4ESK+mUAWvlLuFik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxIMpO1ZmIVie0OIeosHYc7CsAcrlu+vegaJlKz1VxV939LTius+gXZ0szR5VtVsj5EvfdVkr3FhaEtCtJgILvB48ndcxcKckV9TZa79lDI9RFP4NcV3MseQxzfXKdzX6a6lzGuhTXFEobljswJWpzXlEWlCCs6F/U4k8F3CUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D8C71007;
	Mon, 14 Apr 2025 01:08:56 -0700 (PDT)
Received: from [10.57.72.8] (unknown [10.57.72.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8752A3F694;
	Mon, 14 Apr 2025 01:08:56 -0700 (PDT)
Message-ID: <143378b0-5740-4f2b-9a79-f04cf9ef1f77@arm.com>
Date: Mon, 14 Apr 2025 09:08:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: Yaxiong Tian <iambestgod@qq.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yaxiong,

On 4/11/25 02:28, Yaxiong Tian wrote:
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
>   kernel/power/energy_model.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index d9b7e2b38c7a..d1fa7e8787b5 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>   					cost, ret);
>   				return -EINVAL;
>   			}
> -		} else {
> +		} else if (_is_cpu_device(dev)) {
>   			/* increase resolution of 'cost' precision */
>   			power_res = table[i].power * 10;
>   			cost = power_res / table[i].performance;


As the test robot pointed out, please set the 'cost' to 0
where it's declared.

The rest should be fine.

Regards,
Lukasz

