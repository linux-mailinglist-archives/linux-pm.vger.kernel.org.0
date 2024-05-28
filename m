Return-Path: <linux-pm+bounces-8241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E68D17ED
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 12:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C901D1F25C85
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 10:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A716D315;
	Tue, 28 May 2024 09:59:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2E16D30D;
	Tue, 28 May 2024 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890384; cv=none; b=NTYfjTqpgPu1HpCVjEJ2msUSHFp2G3vTgWEhnqu7k95ewhYt8FBp/zUdSueSDMunl4OQvZ7A/CRUyAb/c6aLrbUL0FnewzxSHmk4fGE1OQSefRtP26rASyrqDEHFvsNZngf6yRnpWdTmd2N1FYztK8QhsiYgj9SmPdVFnXDkNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890384; c=relaxed/simple;
	bh=6IFA55jtMNIG7Pnm8j3wKdfzBTaH2nHVfcNaxRQClHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAhoXqm++repWZWM2pbrIdGUHE2N1cNNqWd6bbj/A+gABVmwESD/5sSpP0iSM1QYR7gsDNoxh4K3S3C80DScz9hyi7zvzFcn0ILCdNpfTCSNKKZHMljuGwVDKO3gq2BJ+vrKq+l2rUFT19WQMrJhWgNHEOJi6IkWo0F9zd7NtTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4B44339;
	Tue, 28 May 2024 03:00:04 -0700 (PDT)
Received: from [10.57.68.138] (unknown [10.57.68.138])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E5643F762;
	Tue, 28 May 2024 02:59:38 -0700 (PDT)
Message-ID: <d54d6115-a4d6-466b-a4a2-9c064194f06e@arm.com>
Date: Tue, 28 May 2024 10:59:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To: Vincent Guittot <vincent.guittot@linaro.org>
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
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

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

Thanks for reporting this.
Could you add what regression it's causing, please?
Performance or higher power?
Do you have some handy numbers, so we can see the problem size?

> 
> IMO, we should at least increase the utilization level

Something worth to discuss, or make it configurable even.

Regards,
Lukasz

> 
> Regards,
> Vincent

