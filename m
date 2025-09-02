Return-Path: <linux-pm+bounces-33603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7DAB3F4FF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 08:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C9B3BCE24
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 06:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4386D2E1751;
	Tue,  2 Sep 2025 06:06:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98EE2E090C;
	Tue,  2 Sep 2025 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793211; cv=none; b=MvFQY3v4eU7VH0du17beCAQOgqMADcG6ijHVw2Env2jSGtoogvTC1AqbJYysKJ+L6x49GVInYPeXr40TVwg47tf8dlBQSzHmzwWq9ZPZVTafrqHkfzxn83xDXaM5dSnUoMof9U9oUQYVjKeCO0FwTlXYbyFKPAisZhEG3ZZI9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793211; c=relaxed/simple;
	bh=9OBFVTHggg/n5c6Sx9H91lktZnY+gr8hWFHnwmIrO/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxaMNpx8b1wG3efOAt6p/V2PBc4C2divgipVpLG+94IFD9Teg9mL4oLF6ebOOUjRhH+KyVnb6+GgU4lOdaGR26kmAoHD1k713sUHhpi3dzAa5JiCrcqfATsVAHCYgGum4+Jz5Ui1gnyRnNBrAZgPds7+keJPPWU7OfTp9aqchHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fe6b9c6c87c211f0b29709d653e92f7d-20250902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b867a030-adb9-49cd-b98d-ec7e9f8f97ae,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:e4e9c6f290b3746950f8ceea0acc2412,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe6b9c6c87c211f0b29709d653e92f7d-20250902
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1136890991; Tue, 02 Sep 2025 14:06:41 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D1874E008FA3;
	Tue,  2 Sep 2025 14:06:40 +0800 (CST)
X-ns-mid: postfix-68B68970-768237113
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 37195E008FA2;
	Tue,  2 Sep 2025 14:06:40 +0800 (CST)
Message-ID: <34092883-c04d-4dbb-a756-eac89fbe6f3e@kylinos.cn>
Date: Tue, 2 Sep 2025 14:06:39 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cpufreq: sh: drop redundant freq_table argument
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
 zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
 <20250901112551.35534-3-zhangzihuan@kylinos.cn>
 <20250902054009.rhqu4ki3bl4kr5a7@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250902054009.rhqu4ki3bl4kr5a7@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/2 13:40, Viresh Kumar =E5=86=99=E9=81=93:
> On 01-09-25, 19:25, Zihuan Zhang wrote:
>> Previously, some cpufreq core helper functions accepted a separate
>> 'freq_table' argument even though the frequency table is now stored
>> inside struct cpufreq_policy.
>>
>> This patch updates all cpufreq core calls to remove the redundant
>> argument and use policy directly.
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> ---
>>   drivers/cpufreq/sh-cpufreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq=
.c
>> index 9c0b01e00508..75d224ba56ba 100644
>> --- a/drivers/cpufreq/sh-cpufreq.c
>> +++ b/drivers/cpufreq/sh-cpufreq.c
>> @@ -93,7 +93,7 @@ static int sh_cpufreq_verify(struct cpufreq_policy_d=
ata *policy)
>>  =20
>>   	freq_table =3D cpuclk->nr_freqs ? cpuclk->freq_table : NULL;
>>   	if (freq_table)
> Instead of above, you can now simply check if policy->freq_table is
> valid or not.


I also noticed that in some drivers like acpi-cpufreq.c, if freq_table=20
allocation fails, the driver won=E2=80=99t be registered at all.

In such cases,

should the NULL check be done inside the core helper functions, or=20
should it be left to the drivers?

>> -		return cpufreq_frequency_table_verify(policy, freq_table);
>> +		return cpufreq_frequency_table_verify(policy);
>>  =20
>>   	cpufreq_verify_within_cpu_limits(policy);
>>  =20
>> --=20
>> 2.25.1

