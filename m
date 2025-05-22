Return-Path: <linux-pm+bounces-27488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C0AC066D
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 10:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821F01766B3
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62D255F42;
	Thu, 22 May 2025 08:01:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775AF255F20;
	Thu, 22 May 2025 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900883; cv=none; b=RSXu9CzVM4WyPhKIsrNcl8XPxgwTZPEd341iR7kLe3kQU+MryAwMn1zMcvkPVc3o7JGyKIAD8YUhvpFjKJgvaJGKP/SrWi0HijEdMHwQleI8OXzCFZPMZasm/Atm9jrS1n8TVbi76kuTqrWzdh0Qk+6oA4YHwjxfjUnZf+yfS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900883; c=relaxed/simple;
	bh=XdmeEDoNZYPpV8kEuitQPQUL2DyG8e+fdGW59aPkNI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXHhUpTyOQYpM2RrZsRMvul7aWnsNz3s0eUq7MAOCGjMexkh+1JaXzlyAq6tdqeABxWJVUolfQ4/yS5jo/tOhGl7/FxbsydhVlADM/nOLqj/8YCMwzsnTY6IKkkx3CQ7JvL4oOkpclEFSzON7NDdXYAMCsdkXbwqaaU/4DMbBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF95E1A32;
	Thu, 22 May 2025 01:01:06 -0700 (PDT)
Received: from [10.57.46.113] (unknown [10.57.46.113])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B47443F5A1;
	Thu, 22 May 2025 01:01:19 -0700 (PDT)
Message-ID: <bb462e70-bd55-44eb-9701-06905cf64986@arm.com>
Date: Thu, 22 May 2025 09:01:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: EM: Fix typos in example driver code
To: Atul Kumar Pant <atulpant.linux@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael@kernel.org, len.brown@intel.com, pavel@kernel.org
References: <20250511071141.13237-1-atulpant.linux@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250511071141.13237-1-atulpant.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/11/25 08:11, Atul Kumar Pant wrote:
> Fix the API name to free the allocated table in the example driver code
> that modifies the EM. Also fix the passing of correct table when
> updating the cost.
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>   Documentation/power/energy-model.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
> index ada4938c3..29388f6d1 100644
> --- a/Documentation/power/energy-model.rst
> +++ b/Documentation/power/energy-model.rst
> @@ -381,17 +381,17 @@ up periodically to check the temperature and modify the EM data::
>     26		rcu_read_unlock();
>     27
>     28		/* Calculate 'cost' values for EAS */
> -  29		ret = em_dev_compute_costs(dev, table, pd->nr_perf_states);
> +  29		ret = em_dev_compute_costs(dev, new_table, pd->nr_perf_states);
>     30		if (ret) {
>     31			dev_warn(dev, "EM: compute costs failed %d\n", ret);
> -  32			em_free_table(em_table);
> +  32			em_table_free(em_table);
>     33			return;
>     34		}
>     35
>     36		ret = em_dev_update_perf_domain(dev, em_table);
>     37		if (ret) {
>     38			dev_warn(dev, "EM: update failed %d\n", ret);
> -  39			em_free_table(em_table);
> +  39			em_table_free(em_table);
>     40			return;
>     41		}
>     42

Thanks for having a look at this, LGTM.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>



