Return-Path: <linux-pm+bounces-40922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A75DED241D3
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 12:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8581300698D
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A22314B71;
	Thu, 15 Jan 2026 11:17:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65AB35B125;
	Thu, 15 Jan 2026 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475850; cv=none; b=i2hFhPw5NMp/SOD6P6U5o6eOFRDKY6mZuDuk4t0ygkQOQFa5jXDGepiJ5CluFHfPu7mW/K8eEzHkx4SWChEvcjAIb7KzR3QEHK2jwPtaeNtaCoTqdrXoN/ZLrOj70pCQO/qByzj32QjZObesLdjXzcds5u72AWPbulmAT17X978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475850; c=relaxed/simple;
	bh=Eg8fBWrolo6udHHO75eu/I+s+u90cH7QotrwanlvoYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKtkpnDofcQ2bWCvDvbDxTKQsjH1AwItnBQ161LzjtaTzoNUl0t8MB3r5JsQLizDzVfjVehta+8QVwkWqLTqPKCKu2iSMeL1ZB/zuSyuDf5/Wo8rX1Y893lZ6xZvoY2aNeZuJiEH2+gQX6C00LyGkHAKX2AaTXtdUFHdUNvsoZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD170FEC;
	Thu, 15 Jan 2026 03:17:18 -0800 (PST)
Received: from [10.1.37.67] (e127648.arm.com [10.1.37.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A89EE3F694;
	Thu, 15 Jan 2026 03:17:23 -0800 (PST)
Message-ID: <8e230c6d-ddd7-4385-865e-257168dc0057@arm.com>
Date: Thu, 15 Jan 2026 11:17:21 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] sched: Ignore overutilized by lone task on max-cap
 CPU
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rafael@kernel.org,
 peterz@infradead.org, pierre.gondois@arm.com, qperret@google.com,
 sven@svenpeter.dev
References: <20251230093037.427141-1-christian.loehle@arm.com>
 <20260113131134.n4ixed2awnikgmeq@airbuntu>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260113131134.n4ixed2awnikgmeq@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 13:11, Qais Yousef wrote:
> On 12/30/25 09:30, Christian Loehle wrote:
>> I'm trying to deliver on my overdue promise of redefining overutilized state.
>> My investigation basically lead to redefinition of overutilized state
>> bringing very little hard improvements, while it comes with at least
>> some risk of worsening platforms and workload combinations I might've
>> overlooked, therefore I only concentrate on one, the least
>> controversial, for now.
> 
> What are the controversial bits?
> 
> This is a step forward, but not sure it is in the right direction. The concept
> of a *cpu* being overutilized === rd is overutilized no longer makes sense
> since misfit was decoupled from this logic which was the sole reason to
> require this check at CPU level.  Overutilized state is, rightly, set at the
> rootdomain level. And the check makes sense to be done at that level too by
> traversing the perf domains and seeing if we are in a state that requires
> moving tasks around. Which should be done in update_{sg,sd}_lb_stats() logic
> only.
> 
> I guess the difficult question (which might be what you're referring to as
> controversial), is at what point we can no longer pack (use EAS) and must
> distribute tasks around?

And that is precisely the 'controversial bits', I didn't want to touch them
with this patch specifically.
A more holistic redefinition of OU is still on the table, but it needs to
a) Still fulfill the requirements we want from it (guarantee of accurate PELT
values because compute capacity was 'always' provided, switching to throughput
maximization when needed).
b) Provide sufficient testing to convince us of not regressing anything majorly
on the quite diverse EAS platforms we have today.

I think $SUBJECT does a) and b) well, but of course it's for improving a
specific set of systems and doesn't address the issues with OU that have been
named in the past.

> 
> I think this question is limited by what the lb can do today. With push lb,
> I believe the current global lb is likely to be unnecessary in small systems
> (single LLC) since it can shuffle things around immediately to handle misfit
> and overload.
> 
> On top of that, what can the existing global lb do? I am not sure to be honest.
> The system has to have a number of long running tasks > num_cpus for it to be
> useful. But given util signal will lose its meaning under these circumstances,
> I am not sure the global lb can do a better job than push lb trying to move
> these tasks around. But it could do a more comprehensive job in one go? I'll
> defer to Vincent, he probably more able to answer this from the top of his
> head. But the answer to this question is the key to how we want to define this
> *system* is overutilized state.
> 
> Assuming this is on top of push lb, I believe something like below which will
> trigger overutilized only if all cpus are overutilized (ie system is nearly
> maxed out (has 20% or less headroom)) is a good starting point at least.

It's an approach, but it needs a lot of data to convince everyone that
push lb + much more liberal OU state outperforms current global LB OU.

Given this is not really about defining OU in a final state, any comments from
you and Vincent on $SUBJECT and the problem it's addressing would be 
much appreciated!

> [snip]

