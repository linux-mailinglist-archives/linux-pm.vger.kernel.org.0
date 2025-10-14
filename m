Return-Path: <linux-pm+bounces-36050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E42BD8438
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE9D423BF1
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 08:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4633823C8D5;
	Tue, 14 Oct 2025 08:48:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B059322068F;
	Tue, 14 Oct 2025 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431687; cv=none; b=qlhTwBC9+dhipdrUQIGDOtEz+wMfHJGtT+ZwP3bAr+06StNFsEaier4dGof0l06qLEkRYMu5yA/S627RL1ltcOP4sBxLXhYTl9JBEOsRWmvSoFnBHNywxsWsH0rRhmdP6uJt0Zlds7kc6FuEtM4Swd/16vBtDtJ+RfPQcPhc9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431687; c=relaxed/simple;
	bh=E3HQll0idNq6id5MYj4s9sVcDcTmbmCXUUSyJppEjRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEEyD+P+olMQ4R96QCozV9JAoQN2SlKUBe3aex21IwzT7fyq2iyCcmspBIE32XwwxM8EdGLE0hiXf9EaaRs7ivZc/GlDkjTgs1eT1/C9t5Vzu71nqjBEtq6xW0JpuRTjQ9NmYbPfWc2DYpx6HOoAFrnVKKAlxjMIarLQh1nqMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 336A31A9A;
	Tue, 14 Oct 2025 01:47:57 -0700 (PDT)
Received: from [10.57.5.128] (unknown [10.57.5.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2ED03F6A8;
	Tue, 14 Oct 2025 01:48:02 -0700 (PDT)
Message-ID: <0c362b01-5f51-4aab-9ad5-a37173fbfe3a@arm.com>
Date: Tue, 14 Oct 2025 09:48:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] PM: EM: Implement em_notify_pd_created/updated()
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251014001055.772422-1-changwoo@igalia.com>
 <20251014001055.772422-10-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251014001055.772422-10-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/25 01:10, Changwoo Min wrote:
> Implement two event notifications when a performance domain is created
> (EM_CMD_PD_CREATED) and updated (EM_CMD_PD_UPDATED). The message format
> of these two event notifications is the same as EM_CMD_GET_PD_TABLE --
> containing the performance domain's ID and its energy model table.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   kernel/power/em_netlink.c | 44 +++++++++++++++++++++++++++++++++++++++
>   kernel/power/em_netlink.h |  6 ++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index 90ae6f1c9c9a..2c55c758de6b 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -215,6 +215,50 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   
>   /**************************** Event encoding *********************************/
> +static void __em_notify_pd_table(const struct em_perf_domain *pd, int ntf_type)
> +{
> +	struct sk_buff *msg;
> +	int msg_sz, ret = -EMSGSIZE;
> +	void *hdr;
> +
> +	if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
> +		return;
> +
> +	msg_sz = __em_nl_get_pd_table_size(pd);
> +
> +	msg = genlmsg_new(msg_sz, GFP_KERNEL);
> +	if (!msg)
> +		return;
> +
> +	hdr = genlmsg_put(msg, 0, 0, &em_nl_family, 0, ntf_type);
> +	if (!hdr)
> +		goto out_free_msg;
> +
> +	ret = __em_nl_get_pd_table(msg, pd);
> +	if (ret)
> +		goto out_free_msg;
> +
> +	genlmsg_end(msg, hdr);
> +
> +	genlmsg_multicast(&em_nl_family, msg, 0, EM_NLGRP_EVENT, GFP_KERNEL);
> +
> +	return;
> +
> +out_free_msg:
> +	nlmsg_free(msg);
> +	return;
> +}
> +
> +void em_notify_pd_created(const struct em_perf_domain *pd)
> +{
> +	__em_notify_pd_table(pd, EM_CMD_PD_CREATED);
> +}
> +
> +void em_notify_pd_updated(const struct em_perf_domain *pd)
> +{
> +	__em_notify_pd_table(pd, EM_CMD_PD_UPDATED);
> +}
> +
>   static int __em_notify_pd_deleted_size(const struct em_perf_domain *pd)
>   {
>   	int id_sz = nla_total_size(sizeof(u32)); /* EM_A_PD_TABLE_PD_ID */
> diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
> index d56e5865e1ed..583d7f1c3939 100644
> --- a/kernel/power/em_netlink.h
> +++ b/kernel/power/em_netlink.h
> @@ -13,7 +13,9 @@
>   int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
>   			    void *data);
>   struct em_perf_domain *em_perf_domain_get_by_id(int id);
> +void em_notify_pd_created(const struct em_perf_domain *pd);
>   void em_notify_pd_deleted(const struct em_perf_domain *pd);
> +void em_notify_pd_updated(const struct em_perf_domain *pd);
>   #else
>   static inline
>   int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
> @@ -27,7 +29,11 @@ struct em_perf_domain *em_perf_domain_get_by_id(int id)
>   	return NULL;
>   }
>   
> +static inline void em_notify_pd_created(const struct em_perf_domain *pd) {}
> +
>   static inline void em_notify_pd_deleted(const struct em_perf_domain *pd) {}
> +
> +static inline void em_notify_pd_updated(const struct em_perf_domain *pd) {}
>   #endif
>   
>   #endif /* _EM_NETLINK_H */



Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

