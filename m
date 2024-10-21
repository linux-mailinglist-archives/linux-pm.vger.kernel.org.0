Return-Path: <linux-pm+bounces-16066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A4E9A5FA0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9041C21727
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB81E1C24;
	Mon, 21 Oct 2024 09:03:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1091E1C14;
	Mon, 21 Oct 2024 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501407; cv=none; b=P5pe6DG0KEsORXjiSZ+Ey+rQy97H7U4JodyWFE0Hm2u5x5wKX+EklChTCumdHTM8m57x7gfsFUQGXAKREh9ORpXibuIfXR1xLcQ3el7XM7ubTluEZ+yM/NrJiDx+L8fbxh1wt1Dj5rt12oJYX0A10S+tVdfY7OfV5BrXtydFCVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501407; c=relaxed/simple;
	bh=gTdjB8yMcC8EqTM95nhnowlGWr5yTHLEcM648G18GUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxSQZQsgF5z0XYzKtJrIQUpVl1X6Q80fSsylVnEGI5tOz5XG6aGkLZDEt97frS6EWoardPFJt82jkMuCrve+Rt1uCKxiMSn2TdWdHuZ0ps1YW7rQ/iJdVKX2mhjB1eUmbExiozptSIyftFZY3Ruwuy1RRfQ7LOp6bq8omGeSud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6228DA7;
	Mon, 21 Oct 2024 02:03:53 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5773F73B;
	Mon, 21 Oct 2024 02:03:22 -0700 (PDT)
Message-ID: <a91881c5-ec98-41fb-8742-661d1ee001d4@arm.com>
Date: Mon, 21 Oct 2024 10:03:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] cpuidle/menu: Address performance drop from favoring
 physical over polling cpuidle state
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gautam@linux.ibm.com
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
 <93d9ffb2-482d-49e0-8c67-b795256d961a@arm.com>
 <9e5ef8ab0f0f3e7cb128291cd60591e3d07b33e4.camel@linux.ibm.com>
 <4c897ab4-d592-427b-9a97-79c2b14d5c46@arm.com>
 <6371848e9c260743f381be6e0114743ffab5e5bb.camel@linux.ibm.com>
 <6ae997ca-9712-4497-b666-11b976b1816d@arm.com>
 <592a0c06-a23c-464a-9f67-2ce8ce91a306@arm.com>
 <964275d1-5f31-4eef-8dcd-fa8f11dbb830@arm.com>
 <f951ac01-d074-41b6-b7a6-689f6146faf4@arm.com>
 <96960c17eb8325973dcb907fa19533ee1130e2a2.camel@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <96960c17eb8325973dcb907fa19533ee1130e2a2.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 09:02, Aboorva Devarajan wrote:
> On Thu, 2024-09-19 at 15:38 +0100, Christian Loehle wrote:
>> [...]
>> And of course I realise right after sending I did indeed make a mistake.
>> RESIDENCY_THRESHOLD_NS is 15us so timer is actually polled and the fields
>> populated accurately, but also in the for loop it checks polling for idx == 0.
>> predicted_ns should still be the value from get_typical_interval(), but
>> that is unable to ever enforce a polling state, making your proposed code
>> change the only obvious fix.
> 
>> Essentially with only one non-polling state the get_typical_interval()
>> logic might as well be skipped, it never affects anything.
>>
>> If I'm correct this time then I'm not really sure how to proceed.
>> On the one hand, if we trust predicted_ns we should indeed select a state
>> with predicted_ns < s->target_residency_ns, no matter if polling or not,
>> but that would be quite a behaviour change for x86 users too.
> 
> That's right, so far this is the only solution I can think of that
> improves performance, But, I'm open to trying alternative suggestions
> if any.

It's the most reasonable I can think of anyway.

>> I'm still curious on why teo wouldn't solve your problem, it's intercept
>> logic doesn't care if it selects a polling state or not because of it.
>>
> I confirmed that "teo" doesn't have the reported issue, and when compared
> to the  vanilla menu governor switching to "teo" does improve the performance
> of some workloads, though not the original workload I tested. I'll look into
> why that's the case.

I'd be really curious about the workload that improves with your patch but
doesn't perform well on teo.

> However, we would still want to resolve the issue with the menu governor,
> as it's the default governor currently enabled and have been tested so
> far. While switching to "teo" could be an option in the future.

Understandable and I think your change makes sense, although that logic is
quite old as I dug up.
The modern arm64 but also x86 platforms AFAICS are unlikely to be affected by
your change as they have efficient/responsive physical idle states (or for
arm64 don't have any non-polling state usually) so the prediction logic
would have to spit out something like <1000 ns to take affect and at that
point getting over that statistically significance is quite unlikely.
OTOH if there were power regressions they might be with platforms where they
would never be reported.
Anyway, Rafael's call here.
If he's willing to take it I would include the historical part in the commit
message so that doesn't need to be dug up again.

Regards,
Christian

