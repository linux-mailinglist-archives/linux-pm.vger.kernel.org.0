Return-Path: <linux-pm+bounces-36049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1008BD8420
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEC2424477
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3FA2DEA8E;
	Tue, 14 Oct 2025 08:46:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6C42DF137;
	Tue, 14 Oct 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431603; cv=none; b=XVwXsr9oQiIqQgzYzX4uUAbBlVDsIRRbmjrw6NvbJP1wYcZE3KwTwJenaTmulPtF1PSlqWREpsm1+Ci6BkbxP9jKXcpAZEKDC0WefVzpaVuG5Sjn2X/xD3y8lML+BvpfymfPG8k6VtkEP00zz76yt9hF0+1rXZFzpETjKJKIDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431603; c=relaxed/simple;
	bh=ynRzWPF8u4o0QT4EVcdfViXpoN7TuEfq2/YzZ/74pT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDDVgDcb0XUmxWKoEd4kRdBirk0ajAhlwj3kYBcdPgo+uMy46umACjri6RLU8g94rcNlZ9hzK21VLnk0EIwfdXP0Ie18DADwib2RoPRvbKZnhVDjcjlBoKIcM/Mb9dJ1sLJIH71VA52MD31QfeEoZd3qMxzxEsjQm18NIuoiD4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A45E41A9A;
	Tue, 14 Oct 2025 01:46:33 -0700 (PDT)
Received: from [10.57.5.128] (unknown [10.57.5.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1E113F6A8;
	Tue, 14 Oct 2025 01:46:39 -0700 (PDT)
Message-ID: <fd486f5e-784f-43f1-83a4-44ea43019921@arm.com>
Date: Tue, 14 Oct 2025 09:47:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] PM: EM: Implement em_notify_pd_deleted()
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251014001055.772422-1-changwoo@igalia.com>
 <20251014001055.772422-9-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251014001055.772422-9-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/25 01:10, Changwoo Min wrote:
> Add the event notification infrastructure and implement the event
> notification for when a performance domain is deleted (EM_CMD_PD_DELETED).
> 
> The event contains the ID of the performance domain (EM_A_PD_TABLE_PD_ID)
> so the userspace can identify the changed performance domain for further
> processing.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   kernel/power/em_netlink.c | 46 +++++++++++++++++++++++++++++++++++++++
>   kernel/power/em_netlink.h |  3 +++
>   2 files changed, 49 insertions(+)
> 
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index 2addc143401b..90ae6f1c9c9a 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -213,6 +213,52 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
>   	return ret;
>   }
>   
> +
> +/**************************** Event encoding *********************************/
> +static int __em_notify_pd_deleted_size(const struct em_perf_domain *pd)
> +{
> +	int id_sz = nla_total_size(sizeof(u32)); /* EM_A_PD_TABLE_PD_ID */
> +
> +	return nlmsg_total_size(genlmsg_msg_size(id_sz));
> +}
> +
> +void em_notify_pd_deleted(const struct em_perf_domain *pd)
> +{
> +	struct sk_buff *msg;
> +	int ret = -EMSGSIZE;
> +	void *hdr;
> +	int msg_sz;
> +
> +	if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
> +		return;
> +
> +	msg_sz = __em_notify_pd_deleted_size(pd);
> +
> +	msg = genlmsg_new(msg_sz, GFP_KERNEL);
> +	if (!msg)
> +		return;
> +
> +	hdr = genlmsg_put(msg, 0, 0, &em_nl_family, 0, EM_CMD_PD_DELETED);
> +	if (!hdr)
> +		goto out_free_msg;
> +
> +	if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id)) {
> +		ret = -EMSGSIZE;
> +		goto out_free_msg;
> +	}
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
> +/**************************** Initialization *********************************/
>   static int __init em_netlink_init(void)
>   {
>   	return genl_register_family(&em_nl_family);
> diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
> index 8114b018c73b..d56e5865e1ed 100644
> --- a/kernel/power/em_netlink.h
> +++ b/kernel/power/em_netlink.h
> @@ -13,6 +13,7 @@
>   int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
>   			    void *data);
>   struct em_perf_domain *em_perf_domain_get_by_id(int id);
> +void em_notify_pd_deleted(const struct em_perf_domain *pd);
>   #else
>   static inline
>   int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
> @@ -25,6 +26,8 @@ struct em_perf_domain *em_perf_domain_get_by_id(int id)
>   {
>   	return NULL;
>   }
> +
> +static inline void em_notify_pd_deleted(const struct em_perf_domain *pd) {}
>   #endif
>   
>   #endif /* _EM_NETLINK_H */


LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

