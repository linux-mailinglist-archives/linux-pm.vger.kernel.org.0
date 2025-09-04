Return-Path: <linux-pm+bounces-33785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B9AB43128
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F19D5629F0
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 04:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2AE2566E9;
	Thu,  4 Sep 2025 04:32:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0B248F5A;
	Thu,  4 Sep 2025 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960347; cv=none; b=WUqTn92YIASzz/wXR6puHiHU8aV2fGwdgfTc68SJiQ3LHb1wMNhA29JpZm7YirBw+H7yZRKKqcnkQUE3DU19FiFxZlS6TEip+ETPJBh4PZQZfErkwt/epl6vSsvVh9tzDbzFzatPAZDLJEOeCe6I0jHHZCX7kTXoM0LQTBN/7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960347; c=relaxed/simple;
	bh=LcDZQhkcMwba7JkT0p7KkSDYlKeumO7ncV9SrwwRBVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2nWln8uT1KgyZm92H5X3nHgMn7DZNi2R5ptSmNxm+4LCSBEAx0w5EK7Qx+ImBp+Bqnw7sOpetn99X0sZdl2l3AlzPobL+BVpQLkT2EJPy6zcUUGjVo6Hwls1OEgh7kpIWG89JB+MwTpDGzzEjb79i428S1G1JlKAmoh5YuDvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 242e2128894811f0b29709d653e92f7d-20250904
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d8e5f360-34f5-480b-be9b-25cecafd7d83,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ea8ac0a2738023c573ad850ccad84cbd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817,TC:nil,Content:-10|-
	8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 242e2128894811f0b29709d653e92f7d-20250904
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 726798956; Thu, 04 Sep 2025 12:32:18 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 6B56FE008FA5;
	Thu,  4 Sep 2025 12:32:18 +0800 (CST)
X-ns-mid: postfix-68B91651-6275844
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id CFDCEE008FA2;
	Thu,  4 Sep 2025 12:32:16 +0800 (CST)
Message-ID: <05c6d3bb-1fd4-4fb7-b1db-906a6689eb94@kylinos.cn>
Date: Thu, 4 Sep 2025 12:32:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Rearrange variable declaration
 involving __free()
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2251447.irdbgypaU6@rafael.j.wysocki>
 <20250904041508.z5546b6a4usk5go2@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250904041508.z5546b6a4usk5go2@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


> On 03-09-25, 16:59, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Follow cleanup.h recommendations and define and assign a variable
>> in one statement when __free() is used.
>>
>> No intentional functional impact.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> Zhang, I said the code structure here was intentional, but that was be=
fore
>> the cleanup.h recommendation was pointed out to me.
>>
>> ---
>>   drivers/cpufreq/intel_pstate.c |    4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -1502,9 +1502,7 @@ static void __intel_pstate_update_max_fr
>>  =20
>>   static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
>>   {
>> -	struct cpufreq_policy *policy __free(put_cpufreq_policy);
>> -
>> -	policy =3D cpufreq_cpu_get(cpudata->cpu);
>> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpufreq=
_cpu_get(cpudata->cpu);
>>   	if (!policy)
>>   		return false;
>>  =20

Reviewed-by:=C2=A0 =C2=A0Zihuan Zhang <zhangzihuan@kylinos.cn>

