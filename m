Return-Path: <linux-pm+bounces-33792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ACAB431A4
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAC56841E3
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 05:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8B9225765;
	Thu,  4 Sep 2025 05:34:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7FD8F40;
	Thu,  4 Sep 2025 05:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756964054; cv=none; b=j7iEsXbWEcqWKGSy9Y6h7SY+aNey6Wv7a0Ah67qyPlKyZEvWSMH7GfsPgCKaktWXzsEsWuS1hpBTTtBOwUkp4ZmEwOviCuP4GhHI+mDivFnGanZcoP2B31k74rwEM1zIMfbMr6S0BmcAcf9xwkpnogDlWeR3n8vxsIUjNuuSsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756964054; c=relaxed/simple;
	bh=dVA1sh5/4tNj1irys2HDUW8x5U34dwpBEa6/c7osDpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZmJZU4wJhzzq1DMZI95zYmklpJc9lh9J41nPbhd5r6D0Rpiixbp0xDf9d7oyb/gqjOlkIexWNFPTBKlLWCAe/he4rPPU2TJQplmQEdyLuShc7FmksW/dMRKwg1Tx0RDdUN3JUzXwayoIPGvv4acJ433ociGRRmka8vlJTGAM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c46a823c895011f0b29709d653e92f7d-20250904
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1dd3973b-f040-4b1a-842e-bc10317294e6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b45f3d8ab14e5ed8d1296dbb5da40e85,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c46a823c895011f0b29709d653e92f7d-20250904
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1646123066; Thu, 04 Sep 2025 13:34:03 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3AE73E008FA5;
	Thu,  4 Sep 2025 13:34:03 +0800 (CST)
X-ns-mid: postfix-68B924CB-1066366
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 9FF8EE008FA2;
	Thu,  4 Sep 2025 13:34:02 +0800 (CST)
Message-ID: <cec3bcea-4c75-4869-b9b8-efd3412a1e17@kylinos.cn>
Date: Thu, 4 Sep 2025 13:34:01 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] cpufreq: Make cpufreq_frequency_table_verify()
 internal
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
 Saravana Kannan <saravanak@google.com>, zhenglifeng
 <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-4-zhangzihuan@kylinos.cn>
 <20250904044557.tde36hekoeuhnsci@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250904044557.tde36hekoeuhnsci@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/4 12:45, Viresh Kumar =E5=86=99=E9=81=93:
> On 04-09-25, 11:22, Zihuan Zhang wrote:
>> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq=
.c
>> index 642ddb9ea217..ee3fd1e71b90 100644
>> --- a/drivers/cpufreq/sh-cpufreq.c
>> +++ b/drivers/cpufreq/sh-cpufreq.c
>> @@ -90,10 +90,8 @@ static int sh_cpufreq_verify(struct cpufreq_policy_=
data *policy)
>>   {
>>   	struct clk *cpuclk =3D &per_cpu(sh_cpuclk, policy->cpu);
>>  =20
>> -	if (policy->freq_table)
>> -		return cpufreq_frequency_table_verify(policy);
>> -
>> -	cpufreq_verify_within_cpu_limits(policy);
>> +	if (!cpufreq_generic_frequency_table_verify(policy))
>> +		return 0;
>>  =20
>>   	policy->min =3D (clk_round_rate(cpuclk, 1) + 500) / 1000;
>>   	policy->max =3D (clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
>> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtu=
al-cpufreq.c
>> index 6ffa16d239b2..2498f40cd57e 100644
>> --- a/drivers/cpufreq/virtual-cpufreq.c
>> +++ b/drivers/cpufreq/virtual-cpufreq.c
>> @@ -249,10 +249,7 @@ static int virt_cpufreq_offline(struct cpufreq_po=
licy *policy)
>>  =20
>>   static int virt_cpufreq_verify_policy(struct cpufreq_policy_data *po=
licy)
>>   {
>> -	if (policy->freq_table)
>> -		return cpufreq_frequency_table_verify(policy);
>> -
>> -	cpufreq_verify_within_cpu_limits(policy);
>> +	cpufreq_generic_frequency_table_verify(policy);
>>   	return 0;
>>   }
> You ended up changing the logic of both these files and it isn't the
> same anymore. Earlier if freq_table was there and
> cpufreq_frequency_table_verify() failed, we used to return, but not
> anymore.
>
> And we don't return the error anymore for virtual driver.


Thanks for pointing this out, Viresh.

You are correct =E2=80=94 with the current changes, if
cpufreq_generic_frequency_table_verify() fails, we no longer return
an error in these drivers. For drivers that lack a frequency table,
they can still operate, which is why I wasn=E2=80=99t sure whether return=
ing
an error is strictly necessary.

I would appreciate your advice here: should we preserve the old
behavior and return an error on failure, or is it acceptable for
drivers without a table to continue without it?


>

