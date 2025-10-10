Return-Path: <linux-pm+bounces-35896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69FABCC5B4
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 11:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AEB407E65
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 09:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF34270EBC;
	Fri, 10 Oct 2025 09:32:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C42926B75B;
	Fri, 10 Oct 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088740; cv=none; b=ILUf8mUqJyJhb4W/owVhOmSXaZThYKrEleatZJixT1br7kw37aKvhuLxnokMe+EpyqSPY+n5Wh5GZ7zFCAVfjaP0NUhxhZzrxib9umyzAwDSIFlCnOQb5dnY1CKDgGDq2cieLGt5mgaRtx/cZELvxrRB6txVpgg+OpV22r3Gh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088740; c=relaxed/simple;
	bh=zvXQ3aAsM/PqS0XEz0tavtBpshfkfSFCqC31NPz018E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNVglNHq1m9kWKu+gaTiaDUFGBFPPbd6SFQdqQoEgwM/+mHO4sIfOY1GpevJcN6RD4bejW3tZv4rmZWVq6qLOqNK9En5LtvHpkncKWxx6+25Jw/iLdGDfQc9KDTwI1ESpde+mi2nYXcSnLRmWJAauP2Gt20Ryi8xMg3tGAnRZLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC0261595;
	Fri, 10 Oct 2025 02:32:02 -0700 (PDT)
Received: from [10.57.84.93] (unknown [10.57.84.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A78D73F738;
	Fri, 10 Oct 2025 02:32:08 -0700 (PDT)
Message-ID: <716995b1-2d70-4053-a929-2f94e696a025@arm.com>
Date: Fri, 10 Oct 2025 10:32:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 06/10] PM: EM: Implement em_nl_get_pds_doit()
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-7-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250921031928.205869-7-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/25 04:19, Changwoo Min wrote:
> When a userspace requests EM_CMD_GET_PDS, the kernel responds with
> information on all performance domains. The message format of the
> response is as follows:
> 
> EM_A_PDS_PD (NLA_NESTED)*
>      EM_A_PD_PD_ID (NLA_U32)
>      EM_A_PD_FLAGS (NLA_U64)
>      EM_A_PD_CPUS (NLA_STRING)
> 
> where EM_A_PDS_PD can be repeated as many times as there are performance
> domains, and EM_A_PD_CPUS is a hexadecimal string representing a CPU
> bitmask.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   kernel/power/em_netlink.c | 82 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index f3fbfeff29a4..31b27c6fe3c9 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -17,9 +17,89 @@
>   #include "em_netlink.h"
>   #include "em_netlink_autogen.h"
>   
> +#define EM_A_PD_CPUS_LEN		256
> +
> +/*************************** Command encoding ********************************/
> +static int __em_nl_get_pd_size(struct em_perf_domain *pd, void *data)
> +{
> +	char cpus_buf[EM_A_PD_CPUS_LEN];
> +	int *tot_msg_sz = data;
> +	int msg_sz, cpus_sz;
> +
> +	cpus_sz = snprintf(cpus_buf, sizeof(cpus_buf), "%*pb",
> +			   cpumask_pr_args(to_cpumask(pd->cpus)));
> +
> +	msg_sz = nla_total_size(0) +			/* EM_A_PDS_PD */
> +		 nla_total_size(sizeof(u32)) +		/* EM_A_PD_PD_ID */
> +		 nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PD_FLAGS */
> +		 nla_total_size(cpus_sz);		/* EM_A_PD_CPUS */
> +
> +	*tot_msg_sz += nlmsg_total_size(genlmsg_msg_size(msg_sz));
> +	return 0;
> +}
> +
> +static int __em_nl_get_pd(struct em_perf_domain *pd, void *data)
> +{
> +	char cpus_buf[EM_A_PD_CPUS_LEN];
> +	struct sk_buff *msg = data;
> +	struct nlattr *entry;
> +
> +	entry = nla_nest_start(msg, EM_A_PDS_PD);
> +	if (!entry)
> +		goto out_cancel_nest;
> +
> +	if (nla_put_u32(msg, EM_A_PD_PD_ID, pd->id))
> +		goto out_cancel_nest;
> +
> +	if (nla_put_u64_64bit(msg, EM_A_PD_FLAGS, pd->flags, EM_A_PD_PAD))
> +		goto out_cancel_nest;
> +
> +	snprintf(cpus_buf, sizeof(cpus_buf), "%*pb",
> +		 cpumask_pr_args(to_cpumask(pd->cpus)));
> +	if (nla_put_string(msg, EM_A_PD_CPUS, cpus_buf))
> +		goto out_cancel_nest;
> +
> +	nla_nest_end(msg, entry);
> +
> +	return 0;
> +
> +out_cancel_nest:
> +	nla_nest_cancel(msg, entry);
> +
> +	return -EMSGSIZE;
> +}
> +
>   int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info)
>   {
> -	return -EOPNOTSUPP;
> +	struct sk_buff *msg;
> +	void *hdr;
> +	int cmd = info->genlhdr->cmd;
> +	int ret = -EMSGSIZE, msg_sz = 0;
> +
> +	for_each_em_perf_domain(__em_nl_get_pd_size, &msg_sz);
> +
> +	msg = genlmsg_new(msg_sz, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_put_reply(msg, info, &em_nl_family, 0, cmd);
> +	if (!hdr)
> +		goto out_free_msg;
> +
> +	ret = for_each_em_perf_domain(__em_nl_get_pd, msg);
> +	if (ret)
> +		goto out_cancel_msg;
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +
> +out_cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +out_free_msg:
> +	nlmsg_free(msg);
> +
> +	return ret;
>   }
>   
>   int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


