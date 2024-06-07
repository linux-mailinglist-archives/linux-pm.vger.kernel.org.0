Return-Path: <linux-pm+bounces-8766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF328FFFAE
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6951F21A55
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5514F10E;
	Fri,  7 Jun 2024 09:36:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A022C132139;
	Fri,  7 Jun 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752960; cv=none; b=XoyG6j/0teQ/bv1e5v2rCXmEF0b01uwFcsOARU/22JGJ8KQNRvcZWKTBCwnGjPWu0VBPx15LZ6ggz3FqHkMks8bZnYcl4ujORe86nEzh2qm324fQF0hW04RpEIeugKsaphj++N9jOiUzGE7ndmvkYqty0s1RbScpSA9ple+pdwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752960; c=relaxed/simple;
	bh=oTDTxjuZkTvSB42v+me5M4PJ7i/VHqUvXYJkggMqRPU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fshiX+lZI8mxyC2ox8HZH79TUt/B4ZcmPcFrbY/WJpDY0JPeP3AvPHGasRjFbvg8jBBzmu7UbO40YPXFQSXmH4iE53TtZ3kQoEt7POv9kHuo4jUoTlqOwep5u59NQ3/k6+OnMclXoLkBi9bIaJ0yefyI7Xzd2bsyRL8oTHtOkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BC532F4;
	Fri,  7 Jun 2024 02:36:22 -0700 (PDT)
Received: from [10.57.70.22] (unknown [10.57.70.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BA743F762;
	Fri,  7 Jun 2024 02:35:55 -0700 (PDT)
Message-ID: <53190254-4e9a-4204-b09a-fb1eb31d0efb@arm.com>
Date: Fri, 7 Jun 2024 10:35:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 1/6] cpuidle: teo: Increase util-threshold
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-2-christian.loehle@arm.com>
 <19d87e24-7c2b-4396-9514-74150b896cf3@arm.com>
Content-Language: en-US
In-Reply-To: <19d87e24-7c2b-4396-9514-74150b896cf3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 09:01, Dietmar Eggemann wrote:
> On 06/06/2024 11:00, Christian Loehle wrote:
>> Increase the util-threshold by a lot as it was low enough for some
>> minor load to always be active, especially on smaller CPUs.
> 
> We see the blocked part of the CPU utilization as something telling the
> task scheduler that the corresponding tasks might be runnable soon again
> on this CPU.
> 
> This model seems to be used here as well. I guess folks are still
> debating whether the amount of blocked utilization is a good enough
> indicator for the length of idle time.

Right, the blocked utilization is treated as an indicator that we will
be brought out of sleep by a non-timer wakeup.

> 
>> For small cap CPUs (Pixel6) the util threshold is as low as 1.
>> For CPUs of capacity <64 it is 0. So ensure it is at a minimum, too.
> 
> So before this threshold was 16 on a 1024 CPU, now it's 256?
> 
> A <= 200 CPU has now a threshold of 50.
> 
> Where do those numbers come from? Just from running another workload on
> a specific device?
> 
> [...]

More or less yes.
Kajetan identified two broad use-cases for the utilization-based state
bypass: Early utilization ramp-up and high utilization scenarios.
The reports made it clear that the former can't be handled with a
threshold for just a single value as it will be too aggressive in
sustained (non-ramp-up) workloads.
To be fair, with patches 5 and 6 of this series, the ramp-up is
also handled quite early by the intercepts logic itself.
So as a fix I increased the value high enough to not trigger in
low-utilization scenarios.
There is likely room for optimization here, e.g. many wakeups
are also IPIs more related to the general system utilization instead
of the current CPU.

