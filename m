Return-Path: <linux-pm+bounces-8360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21E18D3723
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 15:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5366F1F238E4
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287ECC136;
	Wed, 29 May 2024 13:09:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A34C2FD;
	Wed, 29 May 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988191; cv=none; b=Llg//98Zt14ElLGqnebD7uqd9dMXpDwCqL6sz9tjEkG9cx73SeNOU2/OFCXrCXnNeT9b1WdTlziv7eDhkVQKVi9W/pI0XwbbI/mUokftF1n2Wc8AUwptYxoWsypm4OPBqXmlakrm9BGjBEpMxAMitOpas3u6qTt3y+wUDB7Y/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988191; c=relaxed/simple;
	bh=w+pe0Z5laKPVOoSBdhBVIHrvGnyev/AXTveXL/veo0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROKQ1es2FmqK7XbEJ8nW/DVGv+pIx7ad9Wk+ja4Hof174Ly48FfkYwc89GPY13fzVCITj0renVJv3BkKf3VyRMp8E+q2rdzyoDNcJ6UpfKEOSORJQDzqn2Sr2aVsBMKe8CjmN55Dpa8nkDiwpHcbCHUZDaqizxD8zZ2zDeqY6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F55B339;
	Wed, 29 May 2024 06:10:12 -0700 (PDT)
Received: from [10.57.3.125] (unknown [10.57.3.125])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CC253F792;
	Wed, 29 May 2024 06:09:45 -0700 (PDT)
Message-ID: <4cd905e8-594e-4858-89df-a501184ee521@arm.com>
Date: Wed, 29 May 2024 14:09:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: Kajetan Puchalski <kajetan.puchalski@arm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com, dsmythies@telus.net,
 yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Qais Yousef <qyousef@layalina.io>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
 <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu>
 <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
 <d54d6115-a4d6-466b-a4a2-9c064194f06e@arm.com>
 <CAKfTPtB21aY9cgi5dSHB0jRp6pE85AfGcHrHjrcpMwi3fJL0FA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtB21aY9cgi5dSHB0jRp6pE85AfGcHrHjrcpMwi3fJL0FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 15:07, Vincent Guittot wrote:
> On Tue, 28 May 2024 at 11:59, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Vincent,
>>
>> On 5/28/24 10:29, Vincent Guittot wrote:
>>> Hi All,
>>>
>>> I'm quite late on this thread but this patchset creates a major
>>> regression for psci cpuidle driver when using the OSI mode (OS
>>> initiated mode).  In such a case, cpuidle driver takes care only of
>>> CPUs power state and the deeper C-states ,which includes cluster and
>>> other power domains, are handled with power domain framework. In such
>>> configuration ,cpuidle has only 2 c-states : WFI and cpu off states
>>> and others states that include the clusters, are managed by genpd and
>>> its governor.
>>>
>>> This patch selects cpuidle c-state N-1 as soon as the utilization is
>>> above CPU capacity / 64 which means at most a level of 16 on the big
>>> core but can be as low as 4 on little cores. These levels are very low
>>> and the main result is that as soon as there is very little activity
>>> on a CPU, cpuidle always selects WFI states whatever the estimated
>>> sleep duration and which prevents any deeper states. Another effect is
>>> that it also keeps the tick firing every 1ms in my case.
>>
>> Thanks for reporting this.
>> Could you add what regression it's causing, please?
>> Performance or higher power?
> 
> It's not a perf but rather a power regression. I don't have a power
> counter so it's difficult to give figures but I found it while running
> a unitary test below on my rb5:
> run 500us every 19457ms on medium core (uclamp_min: 600).

Is that supposed to say 19.457ms?
(Because below you say idle time is >18ms and total test time 5sec)
Is the utilisation more like 1/20000 or 1/20?
In any case what you describe is probably an issue, I'll try to reproduce.
Note also my findings here:
https://lore.kernel.org/lkml/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com/

Kind Regards,
Christian


