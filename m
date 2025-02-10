Return-Path: <linux-pm+bounces-21677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBA1A2EB05
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C6FB7A401C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8791DF738;
	Mon, 10 Feb 2025 11:26:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E796D1DCB24;
	Mon, 10 Feb 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186784; cv=none; b=l5803dAu5sI8VPd4VgJEM7syE+8s5TXVfcBGkC5+nD/DJsscpgGqT4y+88uxiQeNHzIgtambp4nx9HOi2GjjXOZGBTHwvE3AOSMqWJKbba40lyBCFfe60vyovqdEV0EezlZIPmNM/wlC+1EyQK9lJqyC/y9CrBXInGgviWdMvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186784; c=relaxed/simple;
	bh=4A+9AS7XUuPFQBrIrVMzc8DAD6y7ciR+xgYvNRW55w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQlFpF+cUsPgkl8X1WBFCRRBdyaZ3Q6OiCex++laNKfRan8kmObpshQGG2j595UjVE3dDWHmDlBJWTkRUpQ2BBETMT/DTRbK9H6Zq/XOyPAl0hLQeQ1nIvMFgbzI6ArhZlV0dN/Mvod3oX5dzO0cYvX96UmZlKJ5KZVqw+HZpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CE741007;
	Mon, 10 Feb 2025 03:26:44 -0800 (PST)
Received: from [10.57.77.229] (unknown [10.57.77.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4057F3F5A1;
	Mon, 10 Feb 2025 03:26:21 -0800 (PST)
Message-ID: <8d075300-1faf-4bdf-9b55-eee35528eba5@arm.com>
Date: Mon, 10 Feb 2025 11:26:19 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] PM: EM: Slightly reduce em_check_capacity_update()
 overhead
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <6137833.lOV4Wx5bFT@rjwysocki.net>
 <1925950.tdWV9SEqCh@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1925950.tdWV9SEqCh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/27/25 13:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Every iteration of the loop over all possible CPUs in
> em_check_capacity_update() causes get_cpu_device() to be called twice
> for the same CPU, once indirectly via em_cpu_get() and once directly.
> 
> Get rid of the indirect get_cpu_device() call by moving the direct
> invocation of it earlier and using em_pd_get() instead of em_cpu_get()
> to get a pd pointer for the dev one returned by it.
> 
> This also exposes the fact that dev is needed to get a pd, so the code
> becomes somewhat easier to follow after it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   kernel/power/energy_model.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -774,7 +774,8 @@
>   		}
>   		cpufreq_cpu_put(policy);
>   
> -		pd = em_cpu_get(cpu);
> +		dev = get_cpu_device(cpu);
> +		pd = em_pd_get(dev);
>   		if (!pd || em_is_artificial(pd))
>   			continue;
>   
> @@ -798,7 +799,6 @@
>   		pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n",
>   			 cpu, cpu_capacity, em_max_perf);
>   
> -		dev = get_cpu_device(cpu);
>   		em_adjust_new_capacity(dev, pd);
>   	}
>   
> 
> 
> 


LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

