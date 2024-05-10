Return-Path: <linux-pm+bounces-7726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA228C2977
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 19:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74325286E88
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 17:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049A199B9;
	Fri, 10 May 2024 17:42:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45D11C6A5;
	Fri, 10 May 2024 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362940; cv=none; b=Nop1Zo/IPdEdLYxpbZbzGJF1C/pO8MZzauk35MAHHv8ygn7MDmWQkLhvVCFOH9CBLMqObP0zfQ0HBqDhT7GS0g61fVXFtSBy4nNb0BPIFhQBDtV5zEJi+SBT9jj9gWEikPc+6SyO4voeXrNHx+wHjTz4dNNMCw2fs/+YDOV6e1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362940; c=relaxed/simple;
	bh=6Rt5NSPnzn2NwoYdNUH+A4syqFWse6boHm56KdEPN7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlH1Oq1GNQCA2iUReiY+jV17tugQtKV28dzLHmSWcdxGkVhAWU5zTqG+9ShRXeTHR8/HKdu6ezvG0jgXc/Jl+9HJpFKU8T54hGfsBuH+by8lTl/HBp6zgLBZWTvv7tOwODiT07rJhOkmx4ZmWFnwtoCIXhDYKWXzLc8KzVr9nAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9082711FB;
	Fri, 10 May 2024 10:42:42 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 831123F6A8;
	Fri, 10 May 2024 10:42:15 -0700 (PDT)
Date: Fri, 10 May 2024 18:42:13 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: sun50i: replace of_node_put() with
 automatic cleanup handler
Message-ID: <20240510184213.68f92cab@donnerap.manchester.arm.com>
In-Reply-To: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-2-0a2352cac46b@gmail.com>
References: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
	<20240503-sun50i-cpufreq-nvmem-cleanup-v1-2-0a2352cac46b@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 May 2024 19:52:33 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

Hi,

> Make use of the __free() cleanup handler to automatically free nodes
> when they get out of scope.

Looks alright, the last function is now particularly neat.

> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

I haven't tested the error paths yet, but it certainly boots fine on an
OrangePi Zero3.

Cheers,
Andre

> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index ef83e4bf2639..eb47c193269c 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -131,14 +131,14 @@ static const struct of_device_id cpu_opp_match_list[] = {
>  static bool dt_has_supported_hw(void)
>  {
>  	bool has_opp_supported_hw = false;
> -	struct device_node *np;
>  	struct device *cpu_dev;
>  
>  	cpu_dev = get_cpu_device(0);
>  	if (!cpu_dev)
>  		return false;
>  
> -	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +	struct device_node *np __free(device_node) =
> +		dev_pm_opp_of_get_opp_desc_node(cpu_dev);
>  	if (!np)
>  		return false;
>  
> @@ -149,8 +149,6 @@ static bool dt_has_supported_hw(void)
>  		}
>  	}
>  
> -	of_node_put(np);
> -
>  	return has_opp_supported_hw;
>  }
>  
> @@ -165,7 +163,6 @@ static int sun50i_cpufreq_get_efuse(void)
>  	const struct sunxi_cpufreq_data *opp_data;
>  	struct nvmem_cell *speedbin_nvmem;
>  	const struct of_device_id *match;
> -	struct device_node *np;
>  	struct device *cpu_dev;
>  	u32 *speedbin;
>  	int ret;
> @@ -174,19 +171,18 @@ static int sun50i_cpufreq_get_efuse(void)
>  	if (!cpu_dev)
>  		return -ENODEV;
>  
> -	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +	struct device_node *np __free(device_node) =
> +		dev_pm_opp_of_get_opp_desc_node(cpu_dev);
>  	if (!np)
>  		return -ENOENT;
>  
>  	match = of_match_node(cpu_opp_match_list, np);
> -	if (!match) {
> -		of_node_put(np);
> +	if (!match)
>  		return -ENOENT;
> -	}
> +
>  	opp_data = match->data;
>  
>  	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
> -	of_node_put(np);
>  	if (IS_ERR(speedbin_nvmem))
>  		return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
>  				     "Could not get nvmem cell\n");
> @@ -301,14 +297,9 @@ MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);
>  
>  static const struct of_device_id *sun50i_cpufreq_match_node(void)
>  {
> -	const struct of_device_id *match;
> -	struct device_node *np;
> -
> -	np = of_find_node_by_path("/");
> -	match = of_match_node(sun50i_cpufreq_match_list, np);
> -	of_node_put(np);
> +	struct device_node *np __free(device_node) = of_find_node_by_path("/");
>  
> -	return match;
> +	return of_match_node(sun50i_cpufreq_match_list, np);
>  }
>  
>  /*
> 


