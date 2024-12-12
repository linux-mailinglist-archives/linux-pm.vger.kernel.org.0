Return-Path: <linux-pm+bounces-19116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23049EE4C6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 12:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98141886935
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2592116EE;
	Thu, 12 Dec 2024 11:09:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6E21EC4D2;
	Thu, 12 Dec 2024 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001745; cv=none; b=bCIJhNIzuVM1twKFkou+pOpxu/SIzdTm+yCEQUJ+cCx7M6RUe4nB7JUr7DE/k+qNEZVmmYPVPmOhW7iI9Yy2Z7mu8nzSpf1ChOBxacSGTXC83iFuPsnAuZ1X//U+ADxQesFLyS1tLb/RnY9t7+odTUk26Offnm56xP9lVG20rkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001745; c=relaxed/simple;
	bh=ZJDjwjbC1CKzMZcB6/ZePDOrO0Zf/UkPbY7IkUCpXH8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VBweBAGW3t0arR1Kpj4+bZ8pRAnU7bemlvJ7krjLKM7zkWH0ZQX3chWYByuFxp/TXSZZe8v8OAoX5hLxDSQik/7UMWwXy0JaaFtMoTp2MMYHeTzEOKPEJzdABcHkF9hI0FKiLltGB6apJBeW1NMeqoSzrccWVRgPih1eCn/ut6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F346153B;
	Thu, 12 Dec 2024 03:09:30 -0800 (PST)
Received: from [10.1.37.59] (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504363F720;
	Thu, 12 Dec 2024 03:08:59 -0800 (PST)
Message-ID: <2d262f80-81cf-4957-8d4d-ccb5f45e5d75@arm.com>
Date: Thu, 12 Dec 2024 11:08:57 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] cpufreq: apple-soc: Set fallback transition
 latency to APPLE_DVFS_TRANSITION_TIMEOUT
From: Christian Loehle <christian.loehle@arm.com>
To: Nick Chan <towinchenmi@gmail.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Asahi Linux <asahi@lists.linux.dev>,
 Linux ARM Kernel Architecture <linux-arm-kernel@lists.infradead.org>,
 Linux power management <linux-pm@vger.kernel.org>,
 Devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20241212070344.3858-1-towinchenmi@gmail.com>
 <20241212070344.3858-7-towinchenmi@gmail.com>
 <df140f26-496d-44ce-8363-ffc908f2effa@arm.com>
Content-Language: en-US
In-Reply-To: <df140f26-496d-44ce-8363-ffc908f2effa@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 11:06, Christian Loehle wrote:
> On 12/12/24 07:03, Nick Chan wrote:
>> The driver already assumes transitions will not take longer than
>> APPLE_DVFS_TRANSITION_TIMEOUT in apple_soc_cpufreq_set_target(), so it
>> makes little sense to set CPUFREQ_ETERNAL as the transition latency
>> when the transistion latency is not given by the opp-table.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> 
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> 
>> ---
>>  drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
>> index 94e57f055a5f..c9f31a3653e2 100644
>> --- a/drivers/cpufreq/apple-soc-cpufreq.c
>> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
>> @@ -291,7 +291,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
>>  
>>  	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
>>  	if (!transition_latency)
>> -		transition_latency = CPUFREQ_ETERNAL;
>> +		transition_latency = APPLE_DVFS_TRANSITION_TIMEOUT * 1000;

s/1000/NSEC_PER_USEC would have been the cleaner choice in case you respin.

>>  
>>  	policy->cpuinfo.transition_latency = transition_latency;
>>  	policy->dvfs_possible_from_any_cpu = true;
> 
> 


