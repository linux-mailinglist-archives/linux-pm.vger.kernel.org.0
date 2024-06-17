Return-Path: <linux-pm+bounces-9293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C085990A835
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 10:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738791F25006
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5AB19046F;
	Mon, 17 Jun 2024 08:13:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A46190041;
	Mon, 17 Jun 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611995; cv=none; b=XBZZZd1SBjw4ssVpM2L0thV8orSQejeynh4XG1rWrLEG3NLqXGdydODwac654ntEeexnzEmQaS8x6+K/MA6omLaqI7FfFGSUjsXgfqzJUhgDrIRhiIn5pP4PR1pSdtfIFmxN8xG0ymCr6UI9tAgGTtySSUg2GHPZIdSYM+xixrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611995; c=relaxed/simple;
	bh=9NNsAez8XIcZvCc4dnYvLcPL1Zbkb4WiKeq3E7go5Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtFa4Xbxc9l4ImPPuD2kxNY4XKECvmUPHmEe916tp7EhRB5dw/MJeBZXTHhkhW5OwapvCIJHjZ9cRJjGKPsqP160nH/c/T+/zod0IDVFEra85lKDZL4ttbCFfCPXdt0ULuBdXy6YubOQHIWpM6S7z6fq3CSrlIhEaHV6K5Ke9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95C99FEC;
	Mon, 17 Jun 2024 01:13:36 -0700 (PDT)
Received: from [10.57.71.231] (unknown [10.57.71.231])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 665493F64C;
	Mon, 17 Jun 2024 01:13:09 -0700 (PDT)
Message-ID: <64549818-e643-42fe-a65b-138a07319fde@arm.com>
Date: Mon, 17 Jun 2024 09:13:19 +0100
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
 <d539bd2c-89f9-4a04-900c-41d257123163@arm.com>
 <20240616214812.nxtz2kt3svo44mbe@airbuntu>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240616214812.nxtz2kt3svo44mbe@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/16/24 22:48, Qais Yousef wrote:
> On 06/12/24 08:53, Lukasz Luba wrote:
> 
>>> This won't help. We tried different values, unfortunately the logic is flawed.
>>> Utilization value on its own says nothing about the idleness of the system.
>>
>> This is not true. When you up-migrate a task to big CPU, then CPU idle
>> gov can instantly benefit from utilization information and won't make
>> mistake based on old local history and won't use deep idle state.
>> So migrating the utilization from one CPU to another CPU says a lot
>> about the idleness to that destination CPU.
> 
> You can migrate a 1024 tasks to a bigger core, but it could run for 3ms and
> sleep for 40ms. So unfortunately I have to disagree with you here.
> Generally a high util value doesn't mean we are not going to be idle long
> enough to satisfy min_residency of the CPU.

Please don't tell me theoretical workloads. We both know that the
display pipeline requires vsync every 16ms at least and on >100Hz
display it will be shorter.

> 
>> When Christian removed the util he got -4.5% lower score in GB5, so
>> this util has impact [1].
> 
> We need the idle governor to help with power saving. We can disable DVFS and
> all idle states and always get a better performance.
> 
> The residency is ~50% worse on some clusters with this change. Overall power
> impact is 2-4% in many use cases.

As I said, please provide power numbers - otherwise this discussion has
no value.

Also, please respond question from my previous email by who you mean
'we' when you claim power regression (also not showing the power
numbers).

This is really not the way how serious development should be done.

> 
> GB5 is not really a representative use case to measure the usefulness of the
> idle governor. Task placement to avoid the cost of idle exit latency is
> a completely different problem.

GB5 or GB6 are benchmarks that people use when they compare performance
of the phones or laptops and it's very important. If you follow the
evolution of modern processors (from different uArch) you will
notice that a new generation provides sometimes ~10% improvement to that
GB5 score in single-thread mode (at same freq).

Performance results are important as well as power in other tests.

