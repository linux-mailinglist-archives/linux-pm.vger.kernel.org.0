Return-Path: <linux-pm+bounces-25200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0CCA8512D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 03:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73146465E1A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 01:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E626FA7B;
	Fri, 11 Apr 2025 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HVwQ6Qif"
X-Original-To: linux-pm@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2226FD83;
	Fri, 11 Apr 2025 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334499; cv=none; b=LihH4njy9V6xE9ALj0N/6qDvtg+5PoitDIjHdcxzG6xS37K0d5GuLXclT/cOoAePZBUlDOyP8cQioQon/P7xVKxnpPm/ZAFm1Kvq8fVXBqt0HYM4noo0daLj7Q00uRV5h2HNa+oNXSmhwc1xiHIY9/k3iqlb4tq9DbRCtRxqIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334499; c=relaxed/simple;
	bh=A540L/314HODQoI/fe0JjdJqlHuZScJRsJaBxZ0kkq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4bVyj4/na/3m4w6jC5NOtYoZBpA4uAb5t4ujdLHYr/iK+huH/58ovp9T6tTYEIujQQn+Vq+SuNayep4bLG2hdnuq0gab9FGCbAjAHLoX0RiQUyw8HmJ3aueLoj1D5MrM8PVH8nP47D8co37EIeRtCkIFXYjDOIpzcooXShadhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HVwQ6Qif; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744334185; bh=lPgew/ZydjVlFhZ2JlF+s+97+YPhdSx++24EM+lK7L4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HVwQ6Qifd9MWfPiCl0stsYBkpQIsM+0bRoN/OvRzmxlQXi1ucJMTVqosP/y1zC8lV
	 1jJ05T7Voz3rnlOmLZbXlAk5MoARc62a0TVegdJI3Ugb3oos72qT0BW6VZMAhGlIsE
	 vP828EttGtqJIM3REQqVuMqaRnvdfgm2m8/Rxbx4=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 3AD86AA1; Fri, 11 Apr 2025 09:14:45 +0800
X-QQ-mid: xmsmtpt1744334085tq1ydih63
Message-ID: <tencent_06EA95EC8D190B318CDCE5E4D8C276D6FE0A@qq.com>
X-QQ-XMAILINFO: MmAB1QhttJoEF87Qa5Jj+DB/UodpSVmzOQIcGvJ4S4DEP5E6kq4b5NH/Vw3XLR
	 qf6CclLIcnS+2iz4fKCDX1KbQHILAmldhDxZfCFEy0Dcdpmihz+Lwk8pqgRYeQWGk23COC+/MQlT
	 nWeBZTwnjq810VvNmgx0p47XbnZIAVktbG1JCEGyUtx1gcgZMOozSqCu0PWefXr2loIwphI9BGc8
	 l/DgWy0E+5LbBtn552jlWG3W0Wphpzw4Fwd0257osi3Dipp8gBIrboyZuz+aZCy/zDoIyY3n4cZF
	 pE6CucokwTGl06l9+gOlvJekJ+x19iWhHLJ/glQxH0WIazmQbvLpntxHnhUnCQOMp97GLOFogugv
	 MDXgWhOUFVaomGTduAN0zAmQwpDxAIH+pOYTxlvffyZ+DztQA4VvaWMssxPz7mkRFS2tI4b2kOnx
	 E8u4MPVhVecfqr8+RuxRHmwj97+1qAuoBIRE75Hl3gvp4tnsxmYGdhEcXrW7RkIOHMbWbGVU0AHh
	 +mnyMtrpLhFao9woAe3R6BKARwdZXL/2IMugH55Uo7kA8duEIBeRl7T2b9n3FJtYrqQ7lKyh3aWL
	 pLwNXxaESjkyOYfQW+8iKp4peV0yQlQfxpt+fka240XE9K7yk5fcrEh/M6BYTmiYglV9rLByiaQ0
	 2z+2pRFk+EcOJzCMSwbvJLbagDMau/BbsZWgB8dFFcRZtupnZj6CG/WcmxmMi7SwwpANsQviKE+o
	 8lwnVQCDFj6uqU27DanKQvksZJIrtkSqW/9eFMEUtbEW0DDVf+XGsrNr7tvUpCG13ErahT+tmSka
	 S1A4FYoJGzsv6pvxQujD1om1INrAPyjNfijW8N3DC6npv+gZLdu3iBiVqU2HLwpvLf5+CTHW9ZU4
	 H2hQdo9M1NnZfk2KO3vqifAgBwDRRouOS/JBpLPO0Fv90E+u+6A/Iteb0ryjBsD8cJwjjU0rOa
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <2826a8b9-ad77-411c-aa05-a4ec604726fb@qq.com>
Date: Fri, 11 Apr 2025 09:14:45 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lukasz.luba@arm.com, len.brown@intel.com, pavel@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yaxiong Tian <tianyaxiong@kylinos.cn>
References: <tencent_8478BF8F2549630842D323E7394CB6F49D08@qq.com>
 <CAJZ5v0jfAdBbKXBg7k0og6MucptJc9G=RTzFPd=N3Q0VdfToFQ@mail.gmail.com>
Content-Language: en-US
From: Yaxiong Tian <iambestgod@qq.com>
In-Reply-To: <CAJZ5v0jfAdBbKXBg7k0og6MucptJc9G=RTzFPd=N3Q0VdfToFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/10 21:23, Rafael J. Wysocki 写道:
> On Thu, Apr 10, 2025 at 7:39 AM Yaxiong Tian <iambestgod@qq.com> wrote:
>>
>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>
>> When the device is of a non-CPU type, table[i].performance won't be
>> initialized in the previous em_init_performance(), resulting in division
>>   by zero when calculating costs in em_compute_costs().
>>
>> Considering that the performance field in struct em_perf_state is defined
>> as "CPU performance (capacity) at a given frequency", the original
>> calculation method should be maintained when the device is of a non-CPU
>> type.
>>
>> Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove division")
>>
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   kernel/power/energy_model.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index d9b7e2b38c7a..bbd95573d91e 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -231,9 +231,11 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>>                              unsigned long flags)
>>   {
>>          unsigned long prev_cost = ULONG_MAX;
>> +       u64 fmax;
> 
> Why not initialize it here?  Also please retain the reverse x-mas tree
> ordering of declarations.
> 
There is indeed an issue with imperfect code style here.

>>          int i, ret;
>>
>>          /* Compute the cost of each performance state. */
>> +       fmax = (u64) table[nr_states - 1].frequency;
> 
> No need to cast to u64 explicitly (it will be cast anyway).
> 
>>          for (i = nr_states - 1; i >= 0; i--) {
>>                  unsigned long power_res, cost;
>>
>> @@ -245,9 +247,15 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>>                                  return -EINVAL;
>>                          }
>>                  } else {
>> -                       /* increase resolution of 'cost' precision */
>> -                       power_res = table[i].power * 10;
>> -                       cost = power_res / table[i].performance;
>> +                       if (	) {
>> +                               /* increase resolution of 'cost' precision */
>> +                               power_res = table[i].power * 10;
>> +                               cost = power_res / table[i].performance;
>> +                       } else {
>> +                               power_res = table[i].power;
>> +                               cost = div64_u64(fmax * power_res, table[i].frequency);
> 
> Why is it necessary to compute the "cost" field value for non-CPU
> devices at all?
> 
Indeed, I didn't think of this issue—I was focused on ensuring the rest
of the code was correct and forgot that the 'cost' algorithm was only
for EAS energy efficiency calculations. I checked other parts of the
code, and 'cost' isn't used elsewhere. Therefore, this bug can be fixed
simply by adding a _is_cpu_device(dev) check. I'll make the change in
the next version and update the commit message accordingly.

>> +
> 
> An excess empty line.
> 
>> +                       }
>>                  }
>>
>>                  table[i].cost = cost;
>> --


