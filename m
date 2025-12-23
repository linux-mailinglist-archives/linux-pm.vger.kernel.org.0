Return-Path: <linux-pm+bounces-39830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76159CD8A89
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 10:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 589EE302A3A8
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6331F32A3D7;
	Tue, 23 Dec 2025 09:53:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5E8328B41;
	Tue, 23 Dec 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766483615; cv=none; b=eheLcqHvfkHj31Up/HKygAcVwlgxWPZlj5w/9bJ3Cnjp5wb6fqrtm0NFTT56NxfvtQUUGLb20UHaAzwlMY7UipZsLbXD6BQNQVu7oGamJomllYzFxCTwDhjIDp9pR3J19mVqh0LBzI5exVkrHiBl8d7hOPn4h2FCnRcn8Nwnnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766483615; c=relaxed/simple;
	bh=ZVPdBjtssde6KJL6psLfvd2uXsdsZ3jIMOMYglwtbLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nf7xpPqCS4VNN1j/yZ1FD4vvIBD8IOay9kevjOxBkoMTd8lHwqbJRp6XAiGOTdOfaDCNPQ0bXu9X4RJaW3Pk8njbWpFoot2c0CxrvcxjJtjBfsSbNJQf2qdOkVd4w76LaeJKsguSYN8PTR9QCjdtXSqmBnAYchwbfqhoj4LxMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE5E3497;
	Tue, 23 Dec 2025 01:53:23 -0800 (PST)
Received: from [10.57.78.114] (unknown [10.57.78.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 764AC3F5A1;
	Tue, 23 Dec 2025 01:53:29 -0800 (PST)
Message-ID: <a4f9b322-befd-4727-b4a0-9894685dea76@arm.com>
Date: Tue, 23 Dec 2025 09:53:27 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 17/23] coresight: Discard pm_runtime_put() return
 values
Content-Language: en-GB
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <2058657.yKVeVyVuyW@rafael.j.wysocki>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <2058657.yKVeVyVuyW@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/12/2025 20:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Failing a debugfs write due to pm_runtime_put() returning a negative
> value is not particularly useful.
>   
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.  It also happens when the kernel
> has been configured with CONFIG_PM unset, in which case
> debug_disable_func() in the coresight driver will always return an
> error.
> 
> For this reason, update debug_disable_func() to simply discard the
> return value of pm_runtime_put(), change its return type to void, and
> propagate that change to debug_func_knob_write().
> 
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This patch is part of a series, but it doesn't depend on anything else
> in that series.  The last patch in the series depends on it.
> 
> It can be applied by itself and if you decide to do so, please let me
> know.
> 
> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.


Happy for you to pick it with your series.

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


> 
> ---
>   drivers/hwtracing/coresight/coresight-cpu-debug.c |   12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -451,10 +451,10 @@ err:
>   	return ret;
>   }
>   
> -static int debug_disable_func(void)
> +static void debug_disable_func(void)
>   {
>   	struct debug_drvdata *drvdata;
> -	int cpu, ret, err = 0;
> +	int cpu;
>   
>   	/*
>   	 * Disable debug power domains, records the error and keep
> @@ -466,12 +466,8 @@ static int debug_disable_func(void)
>   		if (!drvdata)
>   			continue;
>   
> -		ret = pm_runtime_put(drvdata->dev);
> -		if (ret < 0)
> -			err = ret;
> +		pm_runtime_put(drvdata->dev);
>   	}
> -
> -	return err;
>   }
>   
>   static ssize_t debug_func_knob_write(struct file *f,
> @@ -492,7 +488,7 @@ static ssize_t debug_func_knob_write(str
>   	if (val)
>   		ret = debug_enable_func();
>   	else
> -		ret = debug_disable_func();
> +		debug_disable_func();
>   
>   	if (ret) {
>   		pr_err("%s: unable to %s debug function: %d\n",
> 
> 
> 


