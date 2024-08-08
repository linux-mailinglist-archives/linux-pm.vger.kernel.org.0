Return-Path: <linux-pm+bounces-11996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B8C94BE95
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 15:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E46B1F2124C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CDA18DF7A;
	Thu,  8 Aug 2024 13:35:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E018B482;
	Thu,  8 Aug 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124110; cv=none; b=Fxepq85NAgfTnMrI84+OWbBlmDkFC3b6k3K6WlDsdkvlkb3564jEWp6d7U7hUSi+rafdLuX+XU8Fu0VuPjxklmu5qUA8c/3XhwjmZfUJmntnwst6gBYWKw2JfFVkpiRY3jEswcvAPFhQ1+Iu5K1PCbLSly3dz6tThWncNZGV2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124110; c=relaxed/simple;
	bh=WXIyTlcdgUzPFu87MyoQWD5cIqEe88qH81lSYORid6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXKkcfd5ganzJ8EXMxJ/ZJXzIgWQFBNLlOjVhirLy4DGENRwLsWl8y+gzl0Xrr2KEhq3BGieHjsi0qtMmvixbZe9vpdYW+T1Dr3qdzGNa9FM57yggp7GnG1OifbTVEKQjZC8yzZcajdO4nvq0Fn0LdDHXTKecuhkABOh5eKq2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.109] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <abelova@astralinux.ru>)
	id 1sc2ru-005DVs-2M; Thu, 08 Aug 2024 16:07:50 +0300
Received: from [10.198.3.10] (unknown [10.198.3.10])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4WfnRF4zm3zkWKB;
	Thu,  8 Aug 2024 16:08:25 +0300 (MSK)
Message-ID: <69c57210-8a48-4ae2-b529-a4cd6dbd0121@astralinux.ru>
Date: Thu, 8 Aug 2024 16:07:19 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] cpufreq: amd-pstate: add check for cpufreq_cpu_get's
 return value
Content-Language: ru
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240603110741.24818-1-abelova@astralinux.ru>
 <ZmGHqL93i2GDHsWb@BLRRASHENOY1.amd.com>
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <ZmGHqL93i2GDHsWb@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehnrghsthgrshhirgcuuegvlhhovhgruceorggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepjeefheffjeehtdehvdeugfehiedvleejhfeugeeuhffguefhgffgtdfhgfdvgfegnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepuddtrdduleekrdefrddutdenucfrrghrrghmpehhvghloheplgdutddrudelkedrfedruddtngdpihhnvghtpedutddrudelkedrfedruddtmeefleeivdekpdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepledprhgtphhtthhopehgrghuthhhrghmrdhshhgvnhhohiesrghmugdrtghomhdprhgtphhtthhopehrrgihrdhhuhgrnhhgsegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehpvghrrhihrdihuhgrnhesrghmugdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhgvshhhrdhkuh
 hmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrghenucffrhdrhggvsgcutehnthhishhprghmmecunecuvfgrghhsme
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1723114910#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12094220, Updated: 2024-Aug-08 11:40:48 UTC]

Hello,

06/06/24 12:55, Gautham R. Shenoy пишет:
> Hello,
>
> On Mon, Jun 03, 2024 at 02:07:41PM +0300, Anastasia Belova wrote:
>> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
>> and return in case of error.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> Thank you for the patch. Indeed we should be checking if the policy is
> valid before dereferencing it.
>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 1b7e82a0ad2e..672cb6c280a4 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -621,6 +621,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>>   	unsigned long max_perf, min_perf, des_perf,
>>   		      cap_perf, lowest_nonlinear_perf, max_freq;
>>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>> +	if (!policy)
>> +		return;
> This patch mixes code and declarations. While I personally don't
> prefer that, since we have moved to using C99, the compiler does
> not complain, nor does checkpatch complain.
>
> So is this ok for cpufreq, Rafael?

Should I form the second version without mixing code and declarations?
Or it is better to wait for Rafael's answer?

>
> Or would you prefer something like:
>
> 	unsigned long cap_perf, lowest_nonlinear_perf;
> 	unsigned long max_perf, min_perf, des_perf;
> 	struct cpufreq_policy *policy;
> 	struct amd_cpudata *cpudata;
> 	unsigned int target_freq;
> 	unsigned long max_freq;
>
> 	policy = cpufreq_cpu_get(cpu);
> 	if (!policy)
> 		return;
>
> 	cpudata = policy->driver_data;
>
>
>
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>>   	unsigned int target_freq;
>>   
>> @@ -777,6 +779,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>>   static void amd_pstate_update_limits(unsigned int cpu)
>>   {
>>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>> +	if (!policy)
>> +		return;
> Ditto.
>
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>>   	u32 prev_high = 0, cur_high = 0;
>>   	int ret;
>> -- 
>> 2.30.2
>>
> --
> Thanks and Regards
> gautham.

Thanks,
Anastasia Belova

