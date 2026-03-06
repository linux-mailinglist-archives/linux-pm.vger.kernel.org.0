Return-Path: <linux-pm+bounces-43740-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG1PO0VTqmnhPQEAu9opvQ
	(envelope-from <linux-pm+bounces-43740-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 05:08:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E721B60F
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 05:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D8C63041BED
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 04:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB186369992;
	Fri,  6 Mar 2026 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oAI/9p3Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF131E833;
	Fri,  6 Mar 2026 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772770113; cv=none; b=cK6x+va0OOR8vzQkDjc1PNWVQIicXMsUTO/zCgLGAC2QcggbX8XyfUOz0FN+opSPknn+iOksdg0mJJxabR0zPskir42pJN26ZQKHuG9tVBocZcXoasUYvEFamArxijrwX9vaPp2k9vgDvRP8wpO4Hjb4Sh629z4di9Dp4on+qAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772770113; c=relaxed/simple;
	bh=HyLqhznrdDRyJYjsKjDR10rTQ7tqdzJiG4lx4BjTo3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nS2rpbW07i0tqZnKE1BgV3S3uAl31Nl6/mEEQZxjdkgPZjjquQEIFWCTKr3XuH/KP8oBCeUwxbDGFQGgYlG9/O7U9N1jIvt4yd+ofyJuknJZfqGe5BVphBQmAyEQxjTfIdlCv6wA4FwFHFo2dCqwyAqoLV++FES11FaV+nhTqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oAI/9p3Z; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=P4D4f2Zp4ozD3ytu4PP2OsEuJ7FfV6y5KtTCZP8a/8s=;
	b=oAI/9p3Z6mqmJI7y5LQ+fyl2bq/mv+xf+iLycEFYoCmyiZvMjzlPgEAA9GG+YA1qytYzT7/bG
	d4TdamsFCO76Wx8ozNyVIw46o2pSR6jMQFw6njGImvo91cDuyDPEVkNWd03HEdAiNxzI2GIJD1E
	k84E66+ccq8+/67XZY+srmY=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fRt7C1d0gzmV6t;
	Fri,  6 Mar 2026 12:03:35 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 56DF54056C;
	Fri,  6 Mar 2026 12:08:28 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 12:08:27 +0800
Message-ID: <f2603645-ba35-482c-8908-19a04d76c58d@huawei.com>
Date: Fri, 6 Mar 2026 12:08:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq: governor: Apply limits with requested_freq
 or next_freq
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <mingo@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
 <20260210115458.3493646-3-zhenglifeng1@huawei.com>
 <bx2qtqvaoaf2nnlb7335onsolgdqtcfaqkkifhlvwhxsorujmp@jndpowazrp3p>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <bx2qtqvaoaf2nnlb7335onsolgdqtcfaqkkifhlvwhxsorujmp@jndpowazrp3p>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Queue-Id: 9D2E721B60F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-43740-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+]
X-Rspamd-Action: no action

On 3/5/2026 2:21 PM, Viresh Kumar wrote:
> On 10-02-26, 19:54, Lifeng Zheng wrote:
>> For conservative, ondemand and schedutil governor,
>> cpufreq_policy_apply_limits() is called in .limits(). This function updates
>> the target because the limits (policy->max and policy->min) may be changed.
>> However, it uses policy->cur as the reference for the target frequency.
>> This may cause some problems because the value of policy->cur is influenced
>> by a variety of factors.
>>
>> For example, for some reason, the platform determines a final
>> frequency divided from the frequency distributed by the OS, and this is
>> reflected in policy->cur. After that, cpufreq_policy_apply_limits() is
>> called and because policy->cur is out of limmit, policy->min will be used
>> as the new target.
> 
> Yes, but policy->min should be higher than current frequency then. The algorithm
> has derived policy->cur to be a reasonable frequency, and we are taking decision
> based on that, which looks absolutely fine. We can fix the algorithm
> (governors), so they choose the right frequency, but this logic looks to be okay
> I guess.
> 
>> This caused the real frequency lower but it's
>> unnecessary.
> 
> Lower than what ? It is still higher than the last configured frequency.

Hi Viresh,

You can take a look at the example I showed in the cover letter. On our
platform, under certain special circumstances, the final adjusted frequency
is obtained by dividing the frequency sent by the OS. Therefore, when the
frequency of OS updates decreases, it will also lead to a decrease in the
final frequency. Furthermore, since requested_freq remains at the highest
frequency, the conservative governor will not update the frequency again
until the utilization rate drops. This will cause the frequency issued by
the OS to remain at the lowest frequency even after the frequency division
is restored.

> 


