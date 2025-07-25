Return-Path: <linux-pm+bounces-31408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45672B11544
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 02:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF5F1C88096
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 00:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4708134BD;
	Fri, 25 Jul 2025 00:33:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8772E36F0;
	Fri, 25 Jul 2025 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403581; cv=none; b=FJQlWBWwrXSyK5Pr3+iVzxI/r1r9pIPnV7dmFiS8qddrpAp7Zd7Jy/SwzvuTFeeM/in2uz0RMCp+fqOuI1QEetDVsGWW3k3BuAzm15MK2SRn2X8SkQDCXQSBFUoPYCw6B8QnOCgp6XNw5NJ/QmdBKg6jEFrBeVkUatngQMblIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403581; c=relaxed/simple;
	bh=rttaPSvTluRw3XCY0wVJU9d7fHyHJUXOFdefoyPjj60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnZ/FOg7ottEBrdSP/5jh8JaCE+zWb6CCFiT83JXOlc6yfsW+/jSTjElmz3tz2cQISHGcnV8mOCjvzqqlZRHngkMIcu1ZNyejeSKt6WoSU9xoAnL7teRlXB5ZwwZeEIXZLgfYsnj36X3lER/5BWF8atdstt+Cwf1jP1d+Qazh1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e664007a68ee11f0b29709d653e92f7d-20250725
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ab1040be-2f53-497a-a18b-7b7e80c3cfcd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:29bb7efe8da50f824417d59962b880a6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e664007a68ee11f0b29709d653e92f7d-20250725
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1258036985; Fri, 25 Jul 2025 08:32:52 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 54AABE008FA3;
	Fri, 25 Jul 2025 08:32:52 +0800 (CST)
X-ns-mid: postfix-6882D0B4-1865519
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 59769E008FA2;
	Fri, 25 Jul 2025 08:32:50 +0800 (CST)
Message-ID: <2bc9cf4e-9ef8-4ac9-b40f-4ac949494c86@kylinos.cn>
Date: Fri, 25 Jul 2025 08:32:50 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: Avoid get_governor() for first policy
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 "rafael J . wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724093621.61871-1-zhangzihuan@kylinos.cn>
 <456c9900-1ce3-4a87-8c29-46e65e1240cb@huawei.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <456c9900-1ce3-4a87-8c29-46e65e1240cb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2025/7/24 19:28, zhenglifeng (A) =E5=86=99=E9=81=93:
> On 2025/7/24 17:36, Zihuan Zhang wrote:
>
>> When a cpufreq driver registers the first policy, it may attempt to
>> initialize the policy governor from `last_governor`. However, this is
>> meaningless for the first policy instance, because `last_governor` is
>> only updated when policies are removed (e.g. during CPU offline).
>>
>> The `last_governor` mechanism is intended to restore the previously
>> used governor across CPU hotplug events. For the very first policy,
>> there is no "previous governor" to restore, so calling
>> get_governor(last_governor) is unnecessary and potentially confusing.
>>
>> This patch skips looking up `last_governor` when registering the first
>> policy. Instead, it directly uses the default governor after all
>> governors have been registered and are available.
>>
>> This avoids meaningless lookups, reduces unnecessary module reference
>> handling, and simplifies the initial policy path.
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> ---
>>   drivers/cpufreq/cpufreq.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index d7426e1d8bdd..b5ebd4519eab 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1121,9 +1121,9 @@ static int cpufreq_init_policy(struct cpufreq_po=
licy *policy)
>>   	int ret;
>>  =20
>>   	if (has_target()) {
>> -		/* Update policy governor to the one used before hotplug. */
>> -		gov =3D get_governor(policy->last_governor);
>> -		if (gov) {
>> +		if (policy->last_governor[0] !=3D '\0') {
>> +			/* Update policy governor to the one used before hotplug. */
>> +			gov =3D get_governor(policy->last_governor);
> What if gov is null here? For example, the last governor has been remov=
ed.
> The default governor should be used in this situation I think.
>
Thank you for pointing it out, I will fix it in the next version.

>>   			pr_debug("Restoring governor %s for cpu %d\n",
>>   				 gov->name, policy->cpu);
>>   		} else {

