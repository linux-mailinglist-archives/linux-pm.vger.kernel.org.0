Return-Path: <linux-pm+bounces-43483-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC5qIlDSpmnHWgAAu9opvQ
	(envelope-from <linux-pm+bounces-43483-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 13:21:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E54AD1EF4D2
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 13:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB9F316E5DB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D833B6D9;
	Tue,  3 Mar 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GH7wbl7a"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3F33DEC0;
	Tue,  3 Mar 2026 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538524; cv=none; b=MVNMUwSebGrsqwGF7TJv5AmzoDcn1p1t/JxSlukWHSje+xkwVGcz2GZkUhr9icojO/BTzofBXTFw7ULe62XMO8sKfnmL30IVLBrtj0mPy3gjHB+MRVcNNmxvNMoRLkegLL+pL0lEFaQLtLFvSQ6K0g17DXdp6HLRVApCx94QZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538524; c=relaxed/simple;
	bh=G2pORIMZVD4wQgR1UkXfMxob1fq1DHYxDwRjHv4iWOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ci3LVylDbmYICE/ym3FhWOYYfcFTqTwF/Noddoj7FN69g4asyaqL0BC/O5bWVGEYevBgwMUW16HK8aJLqwO4CW+bzXhJKfFgMjOOm4PIWSIx+ycPg77IGOgxb08tYOMgAou/3JnKgng/uNuMES5isNecrFi+SB67tPTuwDl3+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GH7wbl7a; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6Xz97beUE6TqY1xMpE/mGANHT9HLCXancDy/XmYLqxk=;
	b=GH7wbl7a+04FQDsXRhJF2BAVNpE07cjlB+VOIuKaPC5QMnV4FX56go4pHtMGSyp0EplIMYgDm
	LkwQKqiqOgYbjSBZ/NQOtD2Yt/E/Y2fg9HoqVj+FKSap3J9fP9GsfvvJQh4yDwqQj63fy5cJjUx
	aIXLTxlH0FATRi4cH5KUypk=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fQDTS3RR6z1cyPB;
	Tue,  3 Mar 2026 19:43:40 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id C5F1540363;
	Tue,  3 Mar 2026 19:48:30 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 19:48:30 +0800
Message-ID: <a169bf69-b72f-4a95-85e3-569da22a2837@huawei.com>
Date: Tue, 3 Mar 2026 19:48:29 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Add debug print for current frequency in
 __cpufreq_driver_target()
To: <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>,
	<viresh.kumar@linaro.org>
References: <20260129121813.3874516-1-zhangpengjie2@huawei.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <20260129121813.3874516-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr200004.china.huawei.com (7.202.195.241)
X-Rspamd-Queue-Id: E54AD1EF4D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43483-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangpengjie2@huawei.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Action: no action

Can it be applied, please?

Best Regards,
Pengjie Zhang

On 1/29/2026 8:18 PM, Pengjie Zhang wrote:
> Include policy->cur in the debug message to explicitly show the frequency
> transition (from current to target).
>
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>   drivers/cpufreq/cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4472bb1ec83c..b3d2d2e0c864 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2361,8 +2361,8 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>   	target_freq = __resolve_freq(policy, target_freq, policy->min,
>   				     policy->max, relation);
>   
> -	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
> -		 policy->cpu, target_freq, relation, old_target_freq);
> +	pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
> +		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
>   
>   	/*
>   	 * This might look like a redundant call as we are checking it again

