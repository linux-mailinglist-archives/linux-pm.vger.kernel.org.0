Return-Path: <linux-pm+bounces-32796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A8AB2F47A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE411CE1DC2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E687D2DAFD8;
	Thu, 21 Aug 2025 09:45:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C42DA74D;
	Thu, 21 Aug 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769541; cv=none; b=rmYHwFYMrieVHTNOUjf71VZX1A48v91xqMr0vctatiUpduLScaGSBvlSJ6ItumSAv5S7ebiiF6f/C1KGnFipQLp8k8NJYlcIsKNu5yzUjUCnPg9+QWsEGbn2OAZBlcB1CyfyIdsYflytVybYOYVVmto3ZsEzg2Ut1Dw7AnCXHks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769541; c=relaxed/simple;
	bh=JCE4eD09R2Kzy3VA6o7eJI35KvE9PttQ2K4NiKhvUGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q886htd3ylfVEGQPekXIU1dq1+WO9d6/Q/YS5GWxwbUyWL5ZY5RlA5tGEialoGGLg1N8Y8iEMmbVp8v02MEttyUO+C7STQVKFoh+UbLht/IxSXy0snDTxuUvt2a8BFbNdHrEQL7kjRZcSa2kkOTsAqgE770AcuGvPuTHf8r5fyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 915e9a8c7e7311f0b29709d653e92f7d-20250821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:77ea37a4-dee0-4272-83ce-18724bd0cbb4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:183395a8de58174fc9f9b764b8bf8282,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 915e9a8c7e7311f0b29709d653e92f7d-20250821
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 462410041; Thu, 21 Aug 2025 17:45:27 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 335B0E008FA3;
	Thu, 21 Aug 2025 17:45:27 +0800 (CST)
X-ns-mid: postfix-68A6EAB6-113887902
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id B26CFE008FA2;
	Thu, 21 Aug 2025 17:45:25 +0800 (CST)
Message-ID: <b72c666e-b286-45b6-92d9-7c6dfe5753eb@kylinos.cn>
Date: Thu, 21 Aug 2025 17:45:24 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: simplify setpolicy/target check in driver
 verification
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
 zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250821090020.167786-1-zhangzihuan@kylinos.cn>
 <20250821090020.167786-3-zhangzihuan@kylinos.cn>
 <20250821091716.x7y76wfvvez6g7el@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250821091716.x7y76wfvvez6g7el@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/21 17:17, Viresh Kumar =E5=86=99=E9=81=93:
> On 21-08-25, 17:00, Zihuan Zhang wrote:
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index a067b5447fe8..92633ff2c4f3 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2908,6 +2908,8 @@ static int cpuhp_cpufreq_offline(unsigned int cp=
u)
>>   int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>>   {
>>   	unsigned long flags;
> driver_data can be NULL here. It is checked at a later point.
>
Thanks for your feedback. I did think about the case where driver_data=20
is NULL, but I didn=E2=80=99t think it through properly at the time.

You are right =E2=80=94 this clearly can cause issues.

>> +	bool has_setpolicy =3D driver_data->setpolicy;
> This is a pointer and ..
>
>> +	bool has_target =3D driver_data->target_index || driver_data->target=
;
> .. this is bool.
>
> Their comparison will always fail. Did you actually try this with both
> setpolicy and target() set for a cpufreq driver to check if it really
> fails ?
>
> What you need is:
>
> 	bool has_setpolicy =3D !!driver_data->setpolicy;
Sorry about that. I only tested the case where driver registration succee=
ds.

Do you have any suggestions on how to better test or handle the cases=20
where driver registration could fail?
>>   	int ret;
>>  =20
>>   	if (cpufreq_disabled())
>> @@ -2921,10 +2923,7 @@ int cpufreq_register_driver(struct cpufreq_driv=
er *driver_data)
>>   		return -EPROBE_DEFER;
>>  =20
>>   	if (!driver_data || !driver_data->verify || !driver_data->init ||
>> -	    !(driver_data->setpolicy || driver_data->target_index ||
>> -		    driver_data->target) ||
>> -	     (driver_data->setpolicy && (driver_data->target_index ||
>> -		    driver_data->target)) ||
>> +	     (has_setpolicy =3D=3D has_target) ||
> I would rather do:
>
> 	(!!driver_data->setpolicy =3D=3D (driver_data->target_index || driver_=
data->target))

The current version of the code is much better and safer.

Thanks for pointing this out.

I will carefully test all cases, including potential failure paths, and=20
send a next version accordingly.

>>   	     (!driver_data->get_intermediate !=3D !driver_data->target_inte=
rmediate) ||
>>   	     (!driver_data->online !=3D !driver_data->offline) ||
>>   		 (driver_data->adjust_perf && !driver_data->fast_switch))
>> --=20
>> 2.25.1

