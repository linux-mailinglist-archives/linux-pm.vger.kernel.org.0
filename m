Return-Path: <linux-pm+bounces-8242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CF58D18AA
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 12:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EAB1F2281C
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00C516191B;
	Tue, 28 May 2024 10:35:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805D813AD3E;
	Tue, 28 May 2024 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892540; cv=none; b=Ms1VDfwixw3+i7PVzBSdOyefsxTKA1XuJgJ2h8hTITWjl3qMvwx0nyoqdKOncQzJoct2NtsituIKd4D/DtrbDD45G8EIsKJjlOWH5zf23K0YGWh4SJ0z1xxirV8v0hXoaYeXpS/6Whc3gGgg5VpH0pMK9FqGWn8aOLTUYFPvCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892540; c=relaxed/simple;
	bh=hVV0lCQ/MHFmBqjNr9W7erWq4n/YoJx9UYV3uZmC7Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlB5598eyAXnfwUTxDeNEXUHUkcS4i1EERHFdbzU9spflyBPpz5KuivP8QcJLyq0dFbvZHixLQCOpqCx+nbQBEuThkQQo6+73PKeSOnE5hWcMrZgagvo4/BjAi7qX1WMqqD59ltfhtZ9dPUrXexBcTSMS099wUlzW+IZ30v1WX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91403339;
	Tue, 28 May 2024 03:36:01 -0700 (PDT)
Received: from [10.57.4.203] (unknown [10.57.4.203])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8559E3F762;
	Tue, 28 May 2024 03:35:34 -0700 (PDT)
Message-ID: <fa510ad1-9045-468b-ad37-109c11484d51@arm.com>
Date: Tue, 28 May 2024 11:35:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Qais Yousef <qyousef@layalina.io>
Cc: Kajetan Puchalski <kajetan.puchalski@arm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, lukasz.luba@arm.com, Dietmar.Eggemann@arm.com,
 dsmythies@telus.net, yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
 <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu>
 <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 10:29, Vincent Guittot wrote:
> Hi All,
> 
> I'm quite late on this thread but this patchset creates a major
> regression for psci cpuidle driver when using the OSI mode (OS
> initiated mode).  In such a case, cpuidle driver takes care only of
> CPUs power state and the deeper C-states ,which includes cluster and
> other power domains, are handled with power domain framework. In such
> configuration ,cpuidle has only 2 c-states : WFI and cpu off states
> and others states that include the clusters, are managed by genpd and
> its governor.
> 
> This patch selects cpuidle c-state N-1 as soon as the utilization is
> above CPU capacity / 64 which means at most a level of 16 on the big
> core but can be as low as 4 on little cores. These levels are very low
> and the main result is that as soon as there is very little activity
> on a CPU, cpuidle always selects WFI states whatever the estimated
> sleep duration and which prevents any deeper states. Another effect is
> that it also keeps the tick firing every 1ms in my case.
> 
> IMO, we should at least increase the utilization level
> 
> Regards,
> Vincent

I looked at teo too and what you describe looks reasonable within my
expectation.
Could you describe your workload a bit and details about the (I assume)
power regression?
Maybe compare with 64/32/16 as a divisor and a hack that doesn't override
tick_stop on utilization?
While /64 might seem aggressive (maybe it is too aggressive) I think it
tries to avoid cpu_idle_miss on c1 (too deep state selected) much more than
c0 (too shallow selected), because the latter only costs us some (small?)
energy while the former costs us performance and energy.
Basically WFI should already be really efficient and thus selecting
anything deeper be avoided as long as there is still some utilization.
But I'd be curious on your numbers.

Kind Regards,
Christian

