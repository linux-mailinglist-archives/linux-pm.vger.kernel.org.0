Return-Path: <linux-pm+bounces-11467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D293DDD2
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 10:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652251F21B40
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 08:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25E720B33;
	Sat, 27 Jul 2024 08:15:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE81CD26;
	Sat, 27 Jul 2024 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722068149; cv=none; b=lHBxmYyr2E0cFKJYClw/EpL9VHgUWunNRaygqH6V05uFlHKFMC3ohwyNbHJQzH9WzliIlWL7CrjoNGeW7wZO1MW8qQmmy0S7+Hu2YD6M4V+92IdWkTT6wtOpNKNS9OAmT91rQTI9Ixz1Ldp/EpnCk+WCQyxzwJluf1OQ3zfhJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722068149; c=relaxed/simple;
	bh=c0HkLBzLxjXhROnMwtb5vgjiCp0jImc3wEw9yyW8COU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIAK/hUvp+XyQhQMmACS6xL1ghQ1Cp1ga5CHkytW/grHSOK0TBCE+AkS5JkW8F82n21j1fUv0nnnD3OU+8k9qqO1wlvrSHOCYtx4gHeu8b7uMRlpMtGZzDU8E3va0RLMcG5C+AMJyGPu2dKSA75L0EPxZBQyXkFUd6kE5C7vCRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00C1D1007;
	Sat, 27 Jul 2024 01:16:12 -0700 (PDT)
Received: from [10.25.200.97] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81FD3F73F;
	Sat, 27 Jul 2024 01:15:42 -0700 (PDT)
Message-ID: <962a0fe6-c6bf-415a-9c57-ecb259bd0066@arm.com>
Date: Sat, 27 Jul 2024 10:15:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Hongyan Xia <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240619201409.2071728-1-qyousef@layalina.io>
 <f281ba07-d54a-460a-8f78-f7eb6bd8ed88@arm.com>
 <20240628015200.vw75huo53redgkzf@airbuntu>
 <d510f41a-1225-46d9-a2d7-ff9e6ff599d2@arm.com>
 <20240705002205.nnrgq7savzvsoqgl@airbuntu>
 <2e988929-142c-4e69-8e2e-2f3e64c9f08c@arm.com>
 <20240724211012.mxb6vgbhurk7rcvc@airbuntu>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240724211012.mxb6vgbhurk7rcvc@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2024 23:10, Qais Yousef wrote:
> On 07/05/24 13:50, Dietmar Eggemann wrote:

[...]

>> I tried to explained it in the 4 lines below. With a local 'decayed'
>> update_cfs_rq_load_avg() and propagate_entity_load_avg() set it every
>> time update_load_avg() gets called. And this then determines whether
>> update_tg_load_avg() is called on this cfs_rq later in update_load_avg().
>>
>> The new code:
>>
>>   cfs_rq->decayed |= update_cfs_rq_load_avg() (*)
>>   cfs_rq->decayed |= propagate_entity_load_avg()
>>
>> will not reset 'cfs_rq->decayed' for non-root cfs_rq's.
>>
>> (*) You changed this in v3 from:
>>
>>   cfs_rq->decayed  = update_cfs_rq_load_avg()
>>
>>
>>>> update_load_avg() itself. They will stay decayed after cfs_rq->decayed
>>>> has been set to 1 once and will never be reset to 0. So with UPDATE_TG
>>>> update_tg_load_avg() will then always be called on those non-root
>>>> cfs_rq's all the time.
>>>
>>> We could add a check to update only the root cfs_rq. But what do we gain? Or
>>> IOW, what is the harm of unconditionally updating cfs_rq->decayed given that we
>>> only care about the root cfs_rq? I see more if conditions and branches which
>>> I am trying to avoid.
>>
>> Yes, keep 'decayed' local and add a:
>>
>>     if (cfs_rq == &rq_of(cfs_rq)->cfs)
>>         cfs_rq->decayed = decayed
> 
> I still don't see a problem here. If we don't do it this way, how the outcome
> of frequency selection will change? You're replacing set-but-not-cleared with
> never-set, and un unconditional write with a branch.

This seems to be a misunderstanding. The problem is not with the
frequency selection.

The issue I see is when you set 'cfs_rq->decayed' for a non-root cfs_rq
it stays set forever since there is no code to reset it. This leads to
the fact that update_tg_load_avg(..., UPDATE_TG) is then always called
for this cfs_rq within update_load_avg() whereas before 'decayed' was
evaluated with each invocation of update_load_avg().

[...]













