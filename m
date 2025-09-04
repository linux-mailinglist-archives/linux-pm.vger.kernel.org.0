Return-Path: <linux-pm+bounces-33791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6514B4318D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A13687E46
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 05:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9423A995;
	Thu,  4 Sep 2025 05:24:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2522C355;
	Thu,  4 Sep 2025 05:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963446; cv=none; b=hvUPhHf86MqybtX8PjBoDNiLgK54HGFGagQNVD1YOi+Zq0WwcOHEi/9JQq1gpJ8ebfWzRV3xbIFKdOREEOuWOkAP58Q+umwGjWeDouW5Y8EM93Qju2Ak8Je4gYWNINLXScES/9jqLL31RFD8iahgDCxsGbC3PofODsKZCOnPTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963446; c=relaxed/simple;
	bh=ps2vSL6FMlRnK/n3hdnbliP23/FN2FPWl5kCq8zoEps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moLM4Azxd23CUiVHFmSEFLDn/yrVs+Xh5MnScSskOEw5EQWdOh9ge5tSRCBvFecwENsqJLAZn651uSfekoKX98X4xtecmddzJqlef89AxBfxxQHPPx06idjFaXRSaSNF5sAuLGkhTAdKrarZe51cNdQVWaOAxftdGqzExiSWoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5b2dad2c894f11f0b29709d653e92f7d-20250904
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f25e3567-48cd-4b8c-a06f-3892f72d4ce9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b868f439536289f8e62dcf9eeb14dd12,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5b2dad2c894f11f0b29709d653e92f7d-20250904
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1322521824; Thu, 04 Sep 2025 13:23:57 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 2A326E008FA2;
	Thu,  4 Sep 2025 13:23:57 +0800 (CST)
X-ns-mid: postfix-68B9226D-137554
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 855C4E008FA2;
	Thu,  4 Sep 2025 13:23:56 +0800 (CST)
Message-ID: <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
Date: Thu, 4 Sep 2025 13:23:55 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even without
 frequency table
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
 Saravana Kannan <saravanak@google.com>, zhenglifeng
 <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
 <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/4 12:48, Viresh Kumar =E5=86=99=E9=81=93:
> On 04-09-25, 11:22, Zihuan Zhang wrote:
>> Currently, cpufreq_frequency_table_verify() simply returns when the dr=
iver=E2=80=99s
>> frequency table is missing (policy->freq_table =3D=3D NULL).
>> This means that cpufreq_verify_within_cpu_limits() is not invoked in s=
uch
>> cases, leaving policy->min and policy->max unchecked.
>>
>> Some cpufreq drivers handle this manually by calling
>> cpufreq_verify_within_cpu_limits() even when no frequency table is pre=
sent,
>> in order to ensure the policy stays within CPU limits.
>>
>> To avoid this inconsistency and potential misuse, make
>> cpufreq_generic_frequency_table_verify() always call
>> cpufreq_verify_within_cpu_limits(), regardless of whether policy->freq=
_table
>> is available. This unifies the behavior across all drivers and makes t=
he helper
>> safe to use universally.
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> ---
>>   drivers/cpufreq/freq_table.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table=
.c
>> index d5111ee56e38..f4b05dcc479b 100644
>> --- a/drivers/cpufreq/freq_table.c
>> +++ b/drivers/cpufreq/freq_table.c
>> @@ -105,6 +105,7 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
>>    */
>>   int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_dat=
a *policy)
>>   {
>> +	cpufreq_verify_within_cpu_limits(policy);
> So if we have a freq-table, we will call this twice now. Why make it
> bad for the existing users ?


Just to clarify, in the third patch of this series we remove
cpufreq_generic_frequency_table_verify() from the table_verify path,
so cpufreq_verify_within_cpu_limits() is now only called here. There
won=E2=80=99t be any duplicate invocation for drivers that already have a
frequency table.

This also resolves the semantic concern, since the helper is no
longer invoked outside of this context.

Thanks!


> And then the name of this function, it is all about freq-table. If it
> isn't there, not sure we should call it at all.


As it stands, only drivers that have a frequency table actually call
cpufreq_generic_frequency_table_verify(). Drivers without a table
implement their own verification logic. So in practice, this helper
is still only used in the context of a frequency table, keeping the
semantics consistent with its name.

>>   	if (!policy->freq_table)
>>   		return -ENODEV;
>>  =20
>> --=20
>> 2.25.1

