Return-Path: <linux-pm+bounces-35736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8810EBBE757
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 17:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4523D3B088D
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464B2D6E54;
	Mon,  6 Oct 2025 15:14:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ED12D6400;
	Mon,  6 Oct 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763661; cv=none; b=PeBBpYyay/X5zJolggNnWwzYPrQWDFNlud9KvOH16xjqbVoK5L14ltjiRcUhk5tnKkQKyN9xElrqf7xNE/AFm+HnZlBPbGXl/4IS2C60si9b8MkZ2EzeRMgaTQaq9tFfMDzzcN2DnHVJ0jiPeMeNJB9kGw0beXl/OyqdzW4yaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763661; c=relaxed/simple;
	bh=GLwTmNbaE5ztZ0vdwoTwTWKhIPtRaHXVJ6jDdkayzk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBZRDLcy4xDdlLQTsmZldClmHV2iVpcAmwiDao7flvNqiHcXSyADlIzKen0qAdLKbe9BMwCGoSm5RHSqjjuswxvQTs2ttXd4AKyKGzCeqpx5ZsqlFGwCJFMNCZBsd0a/fBF9a3ljK5MBO62lwRivHnIlgARv2yq/SL7bttxyItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF8071515;
	Mon,  6 Oct 2025 08:14:10 -0700 (PDT)
Received: from [10.57.81.187] (unknown [10.57.81.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8A0B3F66E;
	Mon,  6 Oct 2025 08:14:16 -0700 (PDT)
Message-ID: <13c009f6-5fc9-41ef-aa94-acd99b9c774d@arm.com>
Date: Mon, 6 Oct 2025 16:14:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 03/10] PM: EM: Add an iterator and accessor for
 the performance domain
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-4-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250921031928.205869-4-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/25 04:19, Changwoo Min wrote:
> Add an iterator function (for_each_em_perf_domain) that iterates all the
> performance domains in the global list. A passed callback function (cb) is
> called for each performance domain.
> 
> Additionally, add a lookup function (em_perf_domain_get_by_id) that
> searches for a performance domain by matching the ID in the global list.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   include/linux/energy_model.h | 15 +++++++++++++++
>   kernel/power/energy_model.c  | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 49 insertions(+)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 43aa6153dc57..21279e779188 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -344,6 +344,10 @@ struct em_perf_state *em_perf_state_from_pd(struct em_perf_domain *pd)
>   	return rcu_dereference(pd->em_table)->state;
>   }
>   
> +int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
> +			    void *data);
> +struct em_perf_domain *em_perf_domain_get_by_id(int id);
> +

This doesn't have to go into this header.

>   #else
>   struct em_data_callback {};
>   #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
> @@ -420,6 +424,17 @@ int em_update_performance_limits(struct em_perf_domain *pd,
>   }
>   static inline void em_adjust_cpu_capacity(unsigned int cpu) {}
>   static inline void em_rebuild_sched_domains(void) {}
> +static inline
> +int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
> +			    void *data)
> +{
> +	return -EINVAL;
> +}
> +static inline
> +struct em_perf_domain *em_perf_domain_get_by_id(int id)
> +{
> +	return NULL;
> +}
>   #endif


Please create a local helpers header:
kernel/power/em_helpers.h

and add these two declarations there. In that new
local header there is no need to implement the empty
inline functions as well (so would be simpler).

>   
>   #endif
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 8998a7f4910a..740076d24479 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -1000,3 +1000,37 @@ void em_rebuild_sched_domains(void)
>   	 */
>   	schedule_work(&rebuild_sd_work);
>   }
> +
> +int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
> +			    void *data)
> +{
> +	struct em_perf_domain *pd;
> +
> +	lockdep_assert_not_held(&em_pd_mutex);
> +	guard(mutex)(&em_pd_list_mutex);
> +
> +	list_for_each_entry(pd, &em_pd_list, node) {
> +		int ret;
> +
> +		ret = cb(pd, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +struct em_perf_domain *em_perf_domain_get_by_id(int id)
> +{
> +	struct em_perf_domain *pd;
> +
> +	lockdep_assert_not_held(&em_pd_mutex);
> +	guard(mutex)(&em_pd_list_mutex);
> +
> +	list_for_each_entry(pd, &em_pd_list, node) {
> +		if (pd->id == id)
> +			return pd;
> +	}
> +
> +	return NULL;
> +}

That code looks good, you can keep it. Although, please
add the comments above these functions that they are
only used locally as helpers for the notifications.

