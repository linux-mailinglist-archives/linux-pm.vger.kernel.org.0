Return-Path: <linux-pm+bounces-35899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B598EBCC744
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 12:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61125423615
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F440247284;
	Fri, 10 Oct 2025 10:01:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B533E1C5D44;
	Fri, 10 Oct 2025 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760090480; cv=none; b=cRnMbU6s9NJsbHOAGnrXA75XrBb/Zw0TiEFzZqy5RRsuq1o9Q4yV7tlncV5OvHwt4skpMioIGidCy9MuHDURUdctDVCw2+/Bt/uKD90fOpI46kEk4OO7IXQmFRyl8cEaZFA/+h9nrzVIbcGEoamztelMQTghDHqcZ4SGYQpzg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760090480; c=relaxed/simple;
	bh=nh+5ldkaSuy38QmIqKEwVo2k/48eAkJJamMWDKHe5F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyYa6K6Eq/wTlF4R5+QdOouoWCaFX+/rGYBD5RPBkqXrtSTN5kyZNiecDjzC9ZgUMDGhpeNTOnB9KLPiWdcSM6meBeoYNDYlU1iG2yCS2s9r16V3MOJqinyJaMhtsQVtYLynLHGUcGIgJ04V1d//7bHhVD/M3nFXSPfEblhgkpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 246901595;
	Fri, 10 Oct 2025 03:01:10 -0700 (PDT)
Received: from [10.57.84.93] (unknown [10.57.84.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 780F63F66E;
	Fri, 10 Oct 2025 03:01:15 -0700 (PDT)
Message-ID: <23fe1144-eecc-4e7d-aef7-9b6370d0e24a@arm.com>
Date: Fri, 10 Oct 2025 11:01:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 07/10] PM: EM: Implement
 em_nl_get_pd_table_doit()
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-8-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250921031928.205869-8-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/25 04:19, Changwoo Min wrote:
> When a userspace requests EM_CMD_GET_PD_TABLE with an ID of a performancei

s/performancei/performance/

> domain, the kernel reports back the energy model table of the specified
> performance domain. The message format of the response is as follows:
> 
> EM_A_PD_TABLE_PD_ID (NLA_U32)
> EM_A_PD_TABLE_PS (NLA_NESTED)*
>      EM_A_PS_PERFORMANCE (NLA_U64)
>      EM_A_PS_FREQUENCY (NLA_U64)
>      EM_A_PS_POWER (NLA_U64)
>      EM_A_PS_COST (NLA_U64)
>      EM_A_PS_FLAGS (NLA_U64)
> 
> where EM_A_PD_TABLE_PS can be repeated as many times as there are
> performance states (struct em_perf_state).
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   kernel/power/em_netlink.c | 108 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index 31b27c6fe3c9..59953cfedf78 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -102,9 +102,115 @@ int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info)
>   	return ret;
>   }
>   
> +static struct em_perf_domain *__em_nl_get_pd_table_id(struct nlattr **attrs)
> +{
> +	struct em_perf_domain *pd;
> +	int id;
> +
> +	if (!attrs[EM_A_PD_TABLE_PD_ID])
> +		return NULL;
> +
> +	id = nla_get_u32(attrs[EM_A_PD_TABLE_PD_ID]);
> +	pd = em_perf_domain_get_by_id(id);
> +	return pd;
> +}
> +
> +static int __em_nl_get_pd_table_size(const struct em_perf_domain *pd)
> +{
> +	int id_sz, ps_sz;
> +
> +	id_sz = nla_total_size(sizeof(u32));		/* EM_A_PD_TABLE_PD_ID */
> +	ps_sz = nla_total_size(0) +			/* EM_A_PD_TABLE_PS */
> +		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_PERFORMANCE */
> +		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_FREQUENCY */
> +		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_POWER */
> +		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_COST */
> +		nla_total_size_64bit(sizeof(u64));	/* EM_A_PS_FLAGS */
> +	ps_sz *= pd->nr_perf_states;
> +
> +	return nlmsg_total_size(genlmsg_msg_size(id_sz + ps_sz));
> +}
> +
> +static int __em_nl_get_pd_table(struct sk_buff *msg, const struct em_perf_domain *pd)
> +{
> +	struct em_perf_state *table, *ps;
> +	struct nlattr *entry;
> +	int i;
> +
> +	if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id))
> +		goto out_err;
> +
> +	rcu_read_lock();
> +	table = em_perf_state_from_pd((struct em_perf_domain *)pd);
> +
> +	for (i = 0; i < pd->nr_perf_states; i++) {
> +		ps = &table[i];
> +
> +		entry = nla_nest_start(msg, EM_A_PD_TABLE_PS);
> +		if (!entry)
> +			goto out_unlock_ps;
> +
> +		if (nla_put_u64_64bit(msg, EM_A_PS_PERFORMANCE,
> +				      ps->performance, EM_A_PS_PAD))
> +			goto out_cancel_ps_nest;
> +		if (nla_put_u64_64bit(msg, EM_A_PS_FREQUENCY,
> +				      ps->frequency, EM_A_PS_PAD))
> +			goto out_cancel_ps_nest;
> +		if (nla_put_u64_64bit(msg, EM_A_PS_POWER,
> +				      ps->power, EM_A_PS_PAD))
> +			goto out_cancel_ps_nest;
> +		if (nla_put_u64_64bit(msg, EM_A_PS_COST,
> +				      ps->cost, EM_A_PS_PAD))
> +			goto out_cancel_ps_nest;
> +		if (nla_put_u64_64bit(msg, EM_A_PS_FLAGS,
> +				      ps->flags, EM_A_PS_PAD))
> +			goto out_cancel_ps_nest;
> +
> +		nla_nest_end(msg, entry);
> +	}
> +	rcu_read_unlock();
> +	return 0;
> +
> +out_cancel_ps_nest:
> +	nla_nest_cancel(msg, entry);
> +out_unlock_ps:
> +	rcu_read_unlock();
> +out_err:
> +	return -EMSGSIZE;
> +}
> +
>   int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
>   {
> -	return -EOPNOTSUPP;
> +	struct sk_buff *msg;
> +	struct em_perf_domain *pd;
> +	void *hdr;
> +	int cmd = info->genlhdr->cmd;
> +	int msg_sz, ret = -EMSGSIZE;

Please put them in the reverse christmas tree order.

> +
> +	pd = __em_nl_get_pd_table_id(info->attrs);
> +	if (!pd)
> +		return -EINVAL;
> +
> +	msg_sz = __em_nl_get_pd_table_size(pd);
> +
> +	msg = genlmsg_new(msg_sz, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_put_reply(msg, info, &em_nl_family, 0, cmd);
> +	if (!hdr)
> +		goto out_free_msg;
> +
> +	ret = __em_nl_get_pd_table(msg, pd);
> +	if (ret)
> +		goto out_free_msg;
> +
> +	genlmsg_end(msg, hdr);
> +	return genlmsg_reply(msg, info);
> +
> +out_free_msg:
> +	nlmsg_free(msg);
> +	return ret;
>   }
>   
>   static int __init em_netlink_init(void)

After fixing that cosmetic thing you can add:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

