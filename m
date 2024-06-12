Return-Path: <linux-pm+bounces-8997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B99904D29
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 09:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C833B283B3E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48D16B73F;
	Wed, 12 Jun 2024 07:53:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8222772A;
	Wed, 12 Jun 2024 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178794; cv=none; b=RvMQLfHaONF6U2Bt8cnyhtpoVmABkyuTmZ4Pl0QrCBqcK3klye2IoQKi249Pm2wlI9M37ppL1yk7y5usZU3J97lzdnvm5I2B5UCetGHrEkzeBMuCsxj3iNhCLLmjqqL4Wr04gd3/JwBp9P7Yr/sILSR6XAG+P6zLRnCuZGTR2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178794; c=relaxed/simple;
	bh=yZsBP9m4WWs5zCRUxsl4WsBOoGGwuUfEVhbz0xFqIRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/GO0OBI4O+83rLIsd5TjkbwSqUuhliUs0omVpTXYwBCRCZ3sJdbb05LHhp7HxwpAr4f1dMnM8TcajsMIWaovbugsmEEulrvDQII/YLY12xgubm46PmnqRIk5ElALQ2TTc8mG0CwfIlh6KTqFqXyE2a6Yfob49C4ot0z8sKF2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EC2F1595;
	Wed, 12 Jun 2024 00:53:35 -0700 (PDT)
Received: from [10.57.72.106] (unknown [10.57.72.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C655F3F64C;
	Wed, 12 Jun 2024 00:53:08 -0700 (PDT)
Message-ID: <d539bd2c-89f9-4a04-900c-41d257123163@arm.com>
Date: Wed, 12 Jun 2024 08:53:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To: Qais Yousef <qyousef@layalina.io>
Cc: Kajetan Puchalski <kajetan.puchalski@arm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com, dsmythies@telus.net,
 yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Todd Kjos <tkjos@google.com>,
 "wvw@google.com" <wvw@google.com>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
 <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu>
 <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
 <20240529101950.bjpmmdqfhjg3aol6@airbuntu>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240529101950.bjpmmdqfhjg3aol6@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Qais,

+Todd and Wei on CC

On 5/29/24 11:19, Qais Yousef wrote:
> On 05/28/24 11:29, Vincent Guittot wrote:
>> Hi All,
>>
>> I'm quite late on this thread but this patchset creates a major
>> regression for psci cpuidle driver when using the OSI mode (OS
>> initiated mode).  In such a case, cpuidle driver takes care only of
>> CPUs power state and the deeper C-states ,which includes cluster and
>> other power domains, are handled with power domain framework. In such
>> configuration ,cpuidle has only 2 c-states : WFI and cpu off states
>> and others states that include the clusters, are managed by genpd and
>> its governor.
>>
>> This patch selects cpuidle c-state N-1 as soon as the utilization is
>> above CPU capacity / 64 which means at most a level of 16 on the big
>> core but can be as low as 4 on little cores. These levels are very low
>> and the main result is that as soon as there is very little activity
>> on a CPU, cpuidle always selects WFI states whatever the estimated
>> sleep duration and which prevents any deeper states. Another effect is
>> that it also keeps the tick firing every 1ms in my case.
> 
> Unfortunately I think we need to revert this. We've been seeing the power
> regressions for a long while now and it doesn't seem we'll see an improvement
> soon based on last discussion.

Could you be more precised when you say 'we'?
It's not Vincent, because he said he cannot measure power on his end.

Do you mean Google ACK? Or Google Pixel Team?
You send emails from your private account and people are confused when
you say 'we'.

> 
>>
>> IMO, we should at least increase the utilization level
> 
> This won't help. We tried different values, unfortunately the logic is flawed.
> Utilization value on its own says nothing about the idleness of the system.

This is not true. When you up-migrate a task to big CPU, then CPU idle
gov can instantly benefit from utilization information and won't make
mistake based on old local history and won't use deep idle state.
So migrating the utilization from one CPU to another CPU says a lot
about the idleness to that destination CPU.

When Christian removed the util he got -4.5% lower score in GB5, so
this util has impact [1].

> I think best to revert and rethink the logic. Which is something we're pursuing
> and we'll share outcome when we have something to share. As it stands, this
> doesn't help. And we should really strive to avoid magic thresholds and values.
> They don't scale.

Please share the power numbers. It's not helping when you just say
some power regression w/o numbers, but with assumption that you
are working for big company.

Regards,
Lukasz

[1] 
https://lore.kernel.org/lkml/20240611112413.1241352-1-christian.loehle@arm.com/

