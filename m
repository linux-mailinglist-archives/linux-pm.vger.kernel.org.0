Return-Path: <linux-pm+bounces-35903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3467FBCC826
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 12:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13483A3902
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DF62820A3;
	Fri, 10 Oct 2025 10:20:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ED3222587;
	Fri, 10 Oct 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091624; cv=none; b=liMTs/vUbX5wGKtJ0tgnyBzJRITJ2GxEkMWU2if27P/6zynBsgCC4brLgPPwc+NnaADGVoaEWN7JR8fcp/uvD3M3LCtRsDP8a12uhwTwybPduRYQm6tbe/5Mogymetji+P4bHHLn5QxbreIxtWUZvga+xw3oKPZluJvPCqp256E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091624; c=relaxed/simple;
	bh=KfImDHlL/ITFgbqpsLvP+qWrAwwAaoTNYbFVyFzPkYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ps7ONEZhQuacvKC6vaszAGx5CxW0L3uP1HeKUDx7DGWqO/HgcBCOdH9Y64AFgcTqNUuNTrOrUK46Be0/3gJnNgn++fY2AyO7DvaqvcNv0u6V+2waTpsFKTC4MZvcrnyRC2YkWALzjZzmriWpvglYfTPy1lNlfobGN9thexD7yuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 349DC1595;
	Fri, 10 Oct 2025 03:20:14 -0700 (PDT)
Received: from [10.57.84.93] (unknown [10.57.84.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 083513F792;
	Fri, 10 Oct 2025 03:20:19 -0700 (PDT)
Message-ID: <eba311e7-2c8f-4c74-a065-17a12ee29bf8@arm.com>
Date: Fri, 10 Oct 2025 11:20:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 10/10] PM: EM: Notify an event when the
 performance domain changes
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-11-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250921031928.205869-11-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/25 04:19, Changwoo Min wrote:
> Send an event to userspace when a performance domain is created or deleted,
> or its energy model is updated.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   kernel/power/energy_model.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 740076d24479..fca32d1c6661 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -17,6 +17,8 @@
>   #include <linux/sched/topology.h>
>   #include <linux/slab.h>
>   
> +#include "em_netlink.h"
> +
>   /*
>    * Mutex serializing the registrations of performance domains and letting
>    * callbacks defined by drivers sleep.
> @@ -350,6 +352,8 @@ int em_dev_update_perf_domain(struct device *dev,
>   	em_table_free(old_table);
>   
>   	mutex_unlock(&em_pd_mutex);
> +
> +	em_notify_pd_updated(pd);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
> @@ -697,6 +701,7 @@ int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
>   	list_add_tail(&dev->em_pd->node, &em_pd_list);
>   	mutex_unlock(&em_pd_list_mutex);
>   
> +	em_notify_pd_created(dev->em_pd);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
> @@ -719,6 +724,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
>   	list_del_init(&dev->em_pd->node);
>   	mutex_unlock(&em_pd_list_mutex);
>   
> +	em_notify_pd_deleted(dev->em_pd);
> +
>   	/*
>   	 * The mutex separates all register/unregister requests and protects
>   	 * from potential clean-up/setup issues in the debugfs directories.

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

