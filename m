Return-Path: <linux-pm+bounces-43679-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANWQK3V1qWnl7wAAu9opvQ
	(envelope-from <linux-pm+bounces-43679-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 13:22:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD3211862
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 13:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B082B305BA8D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 12:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF3D39A07A;
	Thu,  5 Mar 2026 12:19:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213B2D2486;
	Thu,  5 Mar 2026 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713194; cv=none; b=iHDUWnlcYdZ5ZwKkk92HdxrhuYXnR2SkF6k2KThqQzaeV3vFNFdaqTkrVP5V02stREjKfQ2Hk0l40nmBzfRb9a27wnotCmZQopvlwL2hQI2vN69wYr7xnNZi/GlNM+Srx2FeqHbKPOV2ir5LiDaDAW6N5h7o7J73C7Q35j0CRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713194; c=relaxed/simple;
	bh=bGs1rKOgtKmzisCitlFZlHuha8aLsLZLkpkf6bA+Iec=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kikm0uP1v03LiBNiyNRhSaa/Xv+qvqUWCGXsoRU50HpM0T53R6QItv4lCS0zDZ2PhMrakHe5aTuOBsWjoLVpAzyK0ePXQSYSac+wDTX2AOAyHWnJix0dfr+WFxo119bHyFin+Ha+1bNzQYqHWNZxrdTWauX8Gu5gbs2+S6XFU4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fRT4b0JBwzKm5j;
	Thu,  5 Mar 2026 20:14:55 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AEFA4056C;
	Thu,  5 Mar 2026 20:19:47 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Mar
 2026 20:19:46 +0800
Message-ID: <8f50fe29-c2f6-465a-b04a-6eac79ed49dd@hisilicon.com>
Date: Thu, 5 Mar 2026 20:19:45 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cpufreq: governor: Apply limits with target_freq
 instead of policy->cur
To: Lifeng Zheng <zhenglifeng1@huawei.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <mingo@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)
X-Rspamd-Queue-Id: E9AD3211862
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjie9@hisilicon.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43679-lists,linux-pm=lfdr.de];
	NEURAL_HAM(-0.00)[-0.993];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 2/10/2026 7:54 PM, Lifeng Zheng wrote:
> The motivation for this patchset cames from a test on our platform:
> 
> With conservative governor and some pressure on CPU, the frequency rapidly
> reach the max supported frequency, such as 2GHz.
> 
> Later, some frequency division strategies on our platform were triggered
> and the actual frequency become 500MHz -- 1/4 of the OS distribution
> frequency.
> 
> At that time, if someone excecutes 'cat cpuinfo_cur_freq', the actual
> frequency will become 250MHz -- 1/4 of the min supported frequency.
> 
> After the platform recovering from the frequency division, the frequency
> will stay on 1GHz, until the pressure disappear.
> 
> The reason this happens is that in cpufreq_verify_current_freq(), if
> policy->cur != new_freq, policy->update will be queued, which will
> ultimately lead to a call to cpufreq_policy_apply_limits(), and update the
> target frequency to policy->min. And then in cs_dbs_update(), since the
> pressure never vanish, it will always hit the following branches:
> 
> 	if (load > dbs_data->up_threshold) {
> 		dbs_info->down_skip = 0;
> 
> 		/* if we are already at full speed then break out early */
> 		if (requested_freq == policy->max)
> 			goto out;
> 
> Therefore, the target frequency will always remain at the lowest frequency.
I feel like this is a common issue that some special handling in the
governor should happen when the frequency limits changes, i.e.
governor->limits() gets called.  See 'limits_changed' or 'need_freq_update'
in the schedutil governor.

Do you think it's reasonable to mark such a flag in 'cpufreq_policy' when
its limits changes, and any governor can use that for their own code?

Jie
> 
> The branching conditions in cs_dbs_update() may not be strict enough, but
> the root cause of this problem is that the target frequency was updated
> when querying cpuinfo_cur_freq. For ondemand and schedutil governor,
> although the frequency will not always remain at the lowest level without
> rising, will still be min_freq in a short period of time when the query
> action occurs.
> 
> Using the freq requested by the governor to decide whether to update the
> target frequency is more reasonable in cpufreq_policy_apply_limits().
> 
> Lifeng Zheng (2):
>   cpufreq: governor: Move requested_freq to policy_dbs_info
>   cpufreq: governor: Apply limits with requested_freq or next_freq
> 
>  drivers/cpufreq/cpufreq_conservative.c | 14 ++++----------
>  drivers/cpufreq/cpufreq_governor.c     |  3 ++-
>  drivers/cpufreq/cpufreq_governor.h     | 12 ++++++++++++
>  drivers/cpufreq/cpufreq_ondemand.c     | 10 +++++-----
>  include/linux/cpufreq.h                |  7 ++++---
>  kernel/sched/cpufreq_schedutil.c       |  4 ++--
>  6 files changed, 29 insertions(+), 21 deletions(-)
> 

