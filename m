Return-Path: <linux-pm+bounces-4943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E487BEEF
	for <lists+linux-pm@lfdr.de>; Thu, 14 Mar 2024 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49371F21123
	for <lists+linux-pm@lfdr.de>; Thu, 14 Mar 2024 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9862745B;
	Thu, 14 Mar 2024 14:32:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EF13D75;
	Thu, 14 Mar 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426744; cv=none; b=nBtiefEiN3PgBy3pdW/XcyNru5L6AXdOl9Pj8nVEAV8uqoupHSe3ekUoUqF2v/oIkjKu9HTHksZEVNWTN9HhapC9GegqD6AirkNjxdU7G4ynTNORc/S8Grsda8GA0ehbxZbXdTvzDbpXVsVyX027CXLrZMm0Ssqn8nJKUbGjb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426744; c=relaxed/simple;
	bh=d6bhwA/P3ncxIFhHlOOvQpGjSkuqQGU5Gk7Hkz0XghI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDDI8ZCkl5HRF4TONW5qom+IJD9yk+S94FLi57WtBNIn0CioMGZumDnAb6t2T6bCtS/+tWMlU8NqXhAYb35B11vo4RSL3/RkdXXoBQ/7mcdy0nrdjyKmSBN16FdogDO6pWhi/EVOfKWBNYUuF2/8rYjIjbZqj9ZVl0Z53T9ZUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30C4E1007;
	Thu, 14 Mar 2024 07:32:58 -0700 (PDT)
Received: from [10.1.38.62] (e133047.arm.com [10.1.38.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CADE3F762;
	Thu, 14 Mar 2024 07:32:19 -0700 (PDT)
Message-ID: <aefbb61c-8e15-4e40-9459-30bbbcb8d6f5@arm.com>
Date: Thu, 14 Mar 2024 14:32:17 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] PM: EM: Add em_dev_update_chip_binning()
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org,
 daniel.lezcano@linaro.org, rafael@kernel.org, viresh.kumar@linaro.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 m.szyprowski@samsung.com, mhiramat@kernel.org
References: <20240314140421.3563571-1-lukasz.luba@arm.com>
 <20240314140421.3563571-4-lukasz.luba@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240314140421.3563571-4-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 14:04, Lukasz Luba wrote:
> Add a function which allows to modify easily the EM after the new voltage
> information is available. The device drivers for the chip can adjust
> the voltage values after setup. The voltage for the same frequency in OPP
> can be different due to chip binning. The voltage impacts the power usage
> and the EM power values can be updated to reflect that.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h |  5 ++++
>  kernel/power/energy_model.c  | 51 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 770755df852f1..d30d67c2f07cf 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -172,6 +172,7 @@ struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
>  void em_table_free(struct em_perf_table __rcu *table);
>  int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
>  			 int nr_states);
> +int em_dev_update_chip_binning(struct device *dev);
>  
>  /**
>   * em_pd_get_efficient_state() - Get an efficient performance state from the EM
> @@ -387,6 +388,10 @@ int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
>  {
>  	return -EINVAL;
>  }
> +static inline int em_dev_update_chip_binning(struct device *dev)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #endif
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 6960dd7393b2d..1494a909844a4 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -808,3 +808,54 @@ static void em_update_workfn(struct work_struct *work)
>  {
>  	em_check_capacity_update();
>  }
> +
> +/**
> + * em_dev_update_chip_binning() - Update Energy Model with new values after
> + *			the new voltage information is present in the OPPs.
> + * @dev		: Device for which the Energy Model has to be updated.
> + *
> + * This function allows to update easily the EM with new values available in
> + * the OPP framework and DT. It can be used after the chip has been properly
> + * verified by device drivers and the voltages adjusted for the 'chip binning'.
> + * It uses the "dynamic-power-coefficient" DT property to calculate the power
> + * values for EM. For power calculation it uses the new adjusted voltage
> + * values known for OPPs, which might be changed after boot.
> + */
> +int em_dev_update_chip_binning(struct device *dev)
> +{
> +	struct em_perf_table __rcu *em_table;
> +	struct em_perf_domain *pd;
> +	int i, ret;
> +
> +	if (IS_ERR_OR_NULL(dev))
> +		return -EINVAL;
> +
> +	pd = em_pd_get(dev);
> +	if (!pd) {
> +		dev_warn(dev, "Couldn't find Energy Model %d\n", ret);

ret is uninitialized at this point, I guess just
+		dev_warn(dev, "Couldn't find Energy Model\n");
already contains everything relevant.

> [...]

