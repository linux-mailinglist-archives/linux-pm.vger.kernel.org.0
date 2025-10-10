Return-Path: <linux-pm+bounces-35901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C5CBCC802
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 12:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22BC4082FA
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F12820A4;
	Fri, 10 Oct 2025 10:17:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF26230BCC;
	Fri, 10 Oct 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091450; cv=none; b=Kp8dr5QIALC1Myd0Au1+YInGs4mk3oOzojhHOITVEVlKKiwAlEdt+I62j2I7BDCsaEH0oQAUadk0cRNqkxWRM1Yf8BYVe7NQ6tdgUgZqDGzsfXJaE5NWJUJp1KCgmwG+uOx0TM4ny9+dYBOyD2ghM7yzP7/uuGoOOGrEs8Db7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091450; c=relaxed/simple;
	bh=Te5zx+I8ZGzATf8fVoQHHROklL7hc8sZQMuNJyj4QfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtZW9c44UHN8V6A2CNQ1fJazwvA6nNniNpXBN5x1IBQhdn0HNKsmctay7FXkMEuvSjWAaDOD25cqkcBKGf/X3/AQJ6AvZtdMSV/hhEcO170vyTqe7stmolsk6r2vgjTZL2S9cx5+sVVLGqmHNTnePJ0FsCOOXYNwWgWGgTGIWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F6A71595;
	Fri, 10 Oct 2025 03:17:18 -0700 (PDT)
Received: from [10.57.84.93] (unknown [10.57.84.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54FAC3F66E;
	Fri, 10 Oct 2025 03:17:24 -0700 (PDT)
Message-ID: <9c07dd28-e40d-4212-8b26-2909e0179ab0@arm.com>
Date: Fri, 10 Oct 2025 11:17:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 08/10] PM: EM: Implement em_notify_pd_deleted()
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-9-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250921031928.205869-9-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/25 04:19, Changwoo Min wrote:
> Add the event notification infrastructure and implement the event
> notification for when a performance domain is deleted (EM_CMD_PD_DELETED).
> 
> The event contains the ID of the performance domain (EM_A_PD_TABLE_PD_ID)
> so the userspace can identify the changed performance domain for further
> processing.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   kernel/power/em_netlink.c | 56 +++++++++++++++++++++++++++++++++++++++
>   kernel/power/em_netlink.h | 18 +++++++++++++
>   2 files changed, 74 insertions(+)
> 
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index 59953cfedf78..ff6aa848d998 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -213,6 +213,62 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
>   	return ret;
>   }
>   
> +
> +/**************************** Event encoding *********************************/
> +int em_notify_pd_created(const struct em_perf_domain *pd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int em_notify_pd_updated(const struct em_perf_domain *pd)
> +{
> +	return -EOPNOTSUPP;
> +}

Those two functions doesn't belong to this patch $subject.
I would recommend adding them in the following patch where they
are properly defined.

> +
> +static int __em_notify_pd_deleted_size(const struct em_perf_domain *pd)
> +{
> +	int id_sz = nla_total_size(sizeof(u32)); /* EM_A_PD_TABLE_PD_ID */
> +
> +	return nlmsg_total_size(genlmsg_msg_size(id_sz));
> +}
> +
> +int em_notify_pd_deleted(const struct em_perf_domain *pd)
> +{
> +	struct sk_buff *msg;
> +	int ret = -EMSGSIZE;
> +	void *hdr;
> +	int msg_sz;
> +
> +	if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
> +		return 0;
> +
> +	msg_sz = __em_notify_pd_deleted_size(pd);
> +
> +	msg = genlmsg_new(msg_sz, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
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
> +	return 0;
> +
> +out_free_msg:
> +	nlmsg_free(msg);
> +	return ret;
> +}

It looks like we don't handle the error outputs of those
em_notify_* function (based on last patch in the set.

Can we just simply change the function to void?
It would also avoid some spurious static analysis tools checking the
code in future.


