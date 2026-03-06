Return-Path: <linux-pm+bounces-43765-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOl+Hz6dqmnPUQEAu9opvQ
	(envelope-from <linux-pm+bounces-43765-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 10:24:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F721DD8E
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 10:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12236300A622
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D5733A9D3;
	Fri,  6 Mar 2026 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MYAS18R1"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02F8479;
	Fri,  6 Mar 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788903; cv=none; b=Orkv5FN2oYiN+v9uzfVmaO9tQrGWxLSRMDxcNI+szSv4oJQfsEz0euq1XmtG8ciLGbzgMJfbK5aG8O4c8YXyhxWAME2lgEue4MKBrAgxa9IL83RSLTi6sfeomBzbyP0o9q43VTRqOZOpzfraeSHJ25Lju3LtuXkqn3DUjyvujD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788903; c=relaxed/simple;
	bh=UJimAI6MpCPZRXpsGNMkGh2U7w9l7SJBEU5HYIMCLT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Syf5HOQfdvRiqnm9IBkJy6B4Ea+hgjtHK2tvfdteT+LcEmChV0iWYr775uehOHU8spTRFHfev4f9z9QNtlMscPieP4K2UsSzOBZ0SXcV4xk+fE8krC/bjb/Tjc2TqiO/Fzmkx84RsKYxYi2I19GYQoEiiFAjLq8aVDP2z/u0lbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MYAS18R1; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=thjf5LS0d0/tsenwyiZ3DkOlfTBMesq+nQklXQnMHPw=;
	b=MYAS18R13QfJXJ5ijJQ+d7n6dhbDE2QD/Frii3kKwfCfSQkvdm+KLAB45848VPF1sBLBUwMNQ
	kLU+4cNByA7m+YlreSglA5s+MDeoQxYxBDjuw3WjkIxV0xkY8PbcS92AdKD1HfMWTbPUyaTKUHM
	L8c7+9ROt1FQV8wNESn8Q08=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fS14V6R26zKm9v;
	Fri,  6 Mar 2026 17:16:42 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id CE0F24055B;
	Fri,  6 Mar 2026 17:21:35 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 17:21:35 +0800
Message-ID: <541a8677-7482-4463-9463-21d7410f65b1@huawei.com>
Date: Fri, 6 Mar 2026 17:21:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cpufreq: governor: Apply limits with target_freq
 instead of policy->cur
To: Jie Zhan <zhanjie9@hisilicon.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <mingo@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
 <8f50fe29-c2f6-465a-b04a-6eac79ed49dd@hisilicon.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <8f50fe29-c2f6-465a-b04a-6eac79ed49dd@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Queue-Id: CD9F721DD8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-43765-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Action: no action

On 3/5/2026 8:19 PM, Jie Zhan wrote:
> 
> On 2/10/2026 7:54 PM, Lifeng Zheng wrote:
>> The motivation for this patchset cames from a test on our platform:
>>
>> With conservative governor and some pressure on CPU, the frequency rapidly
>> reach the max supported frequency, such as 2GHz.
>>
>> Later, some frequency division strategies on our platform were triggered
>> and the actual frequency become 500MHz -- 1/4 of the OS distribution
>> frequency.
>>
>> At that time, if someone excecutes 'cat cpuinfo_cur_freq', the actual
>> frequency will become 250MHz -- 1/4 of the min supported frequency.
>>
>> After the platform recovering from the frequency division, the frequency
>> will stay on 1GHz, until the pressure disappear.
>>
>> The reason this happens is that in cpufreq_verify_current_freq(), if
>> policy->cur != new_freq, policy->update will be queued, which will
>> ultimately lead to a call to cpufreq_policy_apply_limits(), and update the
>> target frequency to policy->min. And then in cs_dbs_update(), since the
>> pressure never vanish, it will always hit the following branches:
>>
>> 	if (load > dbs_data->up_threshold) {
>> 		dbs_info->down_skip = 0;
>>
>> 		/* if we are already at full speed then break out early */
>> 		if (requested_freq == policy->max)
>> 			goto out;
>>
>> Therefore, the target frequency will always remain at the lowest frequency.
> I feel like this is a common issue that some special handling in the
> governor should happen when the frequency limits changes, i.e.
> governor->limits() gets called.  See 'limits_changed' or 'need_freq_update'
> in the schedutil governor.
> 
> Do you think it's reasonable to mark such a flag in 'cpufreq_policy' when
> its limits changes, and any governor can use that for their own code?

Yes. This is why I said 'The branching conditions in cs_dbs_update() may
not be strict enough'. However, using policy->cur to decide the target freq
is unreasonable to me. So this patch set is still meaningful I think.

> 
> Jie
>>
>> The branching conditions in cs_dbs_update() may not be strict enough, but
>> the root cause of this problem is that the target frequency was updated
>> when querying cpuinfo_cur_freq. For ondemand and schedutil governor,
>> although the frequency will not always remain at the lowest level without
>> rising, will still be min_freq in a short period of time when the query
>> action occurs.
>>
>> Using the freq requested by the governor to decide whether to update the
>> target frequency is more reasonable in cpufreq_policy_apply_limits().
>>
>> Lifeng Zheng (2):
>>   cpufreq: governor: Move requested_freq to policy_dbs_info
>>   cpufreq: governor: Apply limits with requested_freq or next_freq
>>
>>  drivers/cpufreq/cpufreq_conservative.c | 14 ++++----------
>>  drivers/cpufreq/cpufreq_governor.c     |  3 ++-
>>  drivers/cpufreq/cpufreq_governor.h     | 12 ++++++++++++
>>  drivers/cpufreq/cpufreq_ondemand.c     | 10 +++++-----
>>  include/linux/cpufreq.h                |  7 ++++---
>>  kernel/sched/cpufreq_schedutil.c       |  4 ++--
>>  6 files changed, 29 insertions(+), 21 deletions(-)
>>


