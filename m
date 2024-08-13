Return-Path: <linux-pm+bounces-12151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C5E950646
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 15:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636C3280FB8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E889C19B5BB;
	Tue, 13 Aug 2024 13:19:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35C19B5AA;
	Tue, 13 Aug 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555141; cv=none; b=Dk1ae1sr7+Q9aVHastAzE+HEeYuQ88O1MC6qETWV8ujNS0oaGpe2P3QWSQebLA0qMobdxK+Xr+r4l8l27lm6OaUoXpDGAG+1INTDXHUZbvK939kA2VZbA3RtA0ULpF8Ca9e6tM8iDi2lyaYcwKvck/EjCRwH5FSjh/JICcGJO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555141; c=relaxed/simple;
	bh=As2Ctddd9kS83EAEw6FmFisbJ2kCBeI6qG1/GGqbgQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5YKQCAbaEzrNROWC8ZT8OT8zlRu/8rzrLQLuj94VkJMLvaNmRN27m/4GXtQ3ygX9oPm97+iej+q1ETYEHVQewwRd1P9TSopuffzsijTiUMtz8cMrHQXJ1yIeXqdX69pwjEajUXEexQ7BXJ1EKUnDo0K73LHz3/Vr1M2DXgbyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD19312FC;
	Tue, 13 Aug 2024 06:19:24 -0700 (PDT)
Received: from [10.57.84.20] (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3F453F6A8;
	Tue, 13 Aug 2024 06:18:55 -0700 (PDT)
Message-ID: <86d4bf8f-186d-4a65-9f06-3e4d5a2a2e1c@arm.com>
Date: Tue, 13 Aug 2024 14:18:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] cpuidle: teo: Remove recent intercepts metric
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, ulf.hansson@linaro.org, anna-maria@linutronix.de,
 dsmythies@telus.net, kajetan.puchalski@arm.com, lukasz.luba@arm.com,
 dietmar.eggemann@arm.com
References: <20240628095955.34096-1-christian.loehle@arm.com>
 <CAJZ5v0jPyy0HgtQcSt=7ZO-khSGex2uAxL1x6HZFkFbvpbxcmA@mail.gmail.com>
 <9bbf6989-f41f-4533-a7c8-b274744663cd@arm.com>
 <181bb5c2-5790-41bf-9ed8-3d3164b8697d@arm.com>
 <2024081236-entourage-matter-37c6@gregkh>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2024081236-entourage-matter-37c6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/24 13:42, Greg KH wrote:
> On Mon, Aug 05, 2024 at 03:58:09PM +0100, Christian Loehle wrote:
>> commit 449914398083148f93d070a8aace04f9ec296ce3 upstream.
>>
>> The logic for recent intercepts didn't work, there is an underflow
>> of the 'recent' value that can be observed during boot already, which
>> teo usually doesn't recover from, making the entire logic pointless.
>> Furthermore the recent intercepts also were never reset, thus not
>> actually being very 'recent'.
>>
>> Having underflowed 'recent' values lead to teo always acting as if
>> we were in a scenario were expected sleep length based on timers is
>> too high and it therefore unnecessarily selecting shallower states.
>>
>> Experiments show that the remaining 'intercept' logic is enough to
>> quickly react to scenarios in which teo cannot rely on the timer
>> expected sleep length.
>>
>> See also here:
>> https://lore.kernel.org/lkml/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com/
>>
>> Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
>> Link: https://patch.msgid.link/20240628095955.34096-3-christian.loehle@arm.com
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/cpuidle/governors/teo.c | 79 ++++++---------------------------
>>  1 file changed, 14 insertions(+), 65 deletions(-)
> 
> We can't just take a 6.1.y backport without newer kernels also having
> this fix.  Can you resend this as backports for all relevant kernels
> please?

Hi Greg,
the email thread might've looked a bit strange to you but as I wrote
in a previous reply:
https://lore.kernel.org/linux-pm/20240628095955.34096-1-christian.loehle@arm.com/T/#ma5bcd00c4b0ffa1fc34e8d7fa237b8de4ee8a25c
@stable
4b20b07ce72f cpuidle: teo: Don't count non-existent intercepts
449914398083 cpuidle: teo: Remove recent intercepts metric
0a2998fa48f0 Revert: "cpuidle: teo: Introduce util-awareness"
apply as-is to
linux-6.10.y
linux-6.6.y
for linux-6.1.y only 449914398083 ("cpuidle: teo: Remove recent intercepts metric")
is relevant, I'll reply with a backport.


Ideally I would wait for an Ack from Rafael though.
Hopefully that makes more sense then.

