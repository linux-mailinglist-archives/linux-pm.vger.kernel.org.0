Return-Path: <linux-pm+bounces-38688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F1C88EBB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 10:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E45E343AAC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0E92D6619;
	Wed, 26 Nov 2025 09:24:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11861280CF6;
	Wed, 26 Nov 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149076; cv=none; b=Dp3O+J9L2qOIe5tusTWKrERTk9aCvqtC67VfZ+I1rcn6dO4VRhEY4jhgrP1mY9B3I8NFGccMMcWjyJYMKgOBGDtyXCysW+vfmkP+lCi+Q9XK+1YteRO1xCZYj/GpClQcp5Po3jFYAZ7T+T875LBLWPBQ1SE1peFGlvtv1/sczJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149076; c=relaxed/simple;
	bh=ZbvWSOa3bdB3MogkqGNG4XO6vIUgxi8jYGAGmvrbm/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faQ85DKPmhUhxxbhouTsgKFAZhFfDixm6aDON1/n3nymxxnKtE+moYpKgs2QQc9w3WcEG7xJXIOFkdq52ZqQEQw+1pn3zgoB0LnFAjZoI3R0MQB/lowf+cPWiWdXm8EopBJ9ROKnmyCnYl8a03AEg047OocZgeSgDs/XBUC6CM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b2460c3acaa911f0a38c85956e01ac42-20251126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:e4444327-b6e3-415f-81fa-8da61bf44ee5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:f47ca7371079c753383697253af4dd65,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b2460c3acaa911f0a38c85956e01ac42-20251126
X-User: luriwen@kylinos.cn
Received: from [10.42.13.61] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1996568405; Wed, 26 Nov 2025 17:24:23 +0800
Message-ID: <b832176d-dc48-4c5b-ae69-aca885667cc0@kylinos.cn>
Date: Wed, 26 Nov 2025 17:24:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] PM: devfreq: handle invalid parameters gracefully
 in simpleondemand
To: Chanwoo Choi <chanwoo@kernel.org>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251118032339.2799230-1-luriwen@kylinos.cn>
 <20251118032339.2799230-2-luriwen@kylinos.cn>
 <25a5c859-357f-4e31-9b47-822d0c32ce70@kernel.org>
Content-Language: en-US
From: luriwen <luriwen@kylinos.cn>
In-Reply-To: <25a5c859-357f-4e31-9b47-822d0c32ce70@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/11/23 23:24, Chanwoo Choi 写道:
> 25. 11. 18. 12:23에 Riwen Lu 이(가) 쓴 글:
>> Instead of returning -EINVAL when upthreshold > 100 or upthreshold <
>> downdifferential, fall back to default threshold values to ensure the
>> governor continues functioning.
>>
>> Additionally, the validation is now scoped to the if (data) block,
>> preventing unnecessary checks when no user data is provided, while the
>> fallback mechanism ensures reliability with invalid configurations.
>>
>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>> ---
>>   drivers/devfreq/governor_simpleondemand.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
>> index b4d7be766f33..7205891d2ec6 100644
>> --- a/drivers/devfreq/governor_simpleondemand.c
>> +++ b/drivers/devfreq/governor_simpleondemand.c
>> @@ -36,10 +36,15 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>>   			dfso_upthreshold = data->upthreshold;
>>   		if (data->downdifferential)
>>   			dfso_downdifferential = data->downdifferential;
>> +
>> +		if (dfso_upthreshold > 100 ||
>> +		    dfso_upthreshold < dfso_downdifferential) {
>> +			dfso_upthreshold = DFSO_UPTHRESHOLD;
>> +			dfso_downdifferential = DFSO_DOWNDIFFERENTIAL;
>> +			pr_debug("Invalid thresholds, using defaults: up = %u, down = %u\n",
>> +				dfso_upthreshold, dfso_downdifferential);
>> +		}
>>   	}
>> -	if (dfso_upthreshold > 100 ||
>> -	    dfso_upthreshold < dfso_downdifferential)
>> -		return -EINVAL;
>>   
>>   	/* Assume MAX if it is going to be divided by zero */
>>   	if (stat->total_time == 0) {
> If there are wrong initialization of devfreq_simple_ondemand,
> it should point out what is wrong because it makes some confusion if there are no error.
>
>
The original intention behind falling back to default values was to ensure the governor remains functional even with invalid configurations. However, I agree that silently using defaults could hide configuration issues from users.

I'd like to keep fallback but add explicit warning or error.

```c

if (dfso_upthreshold > 100 ||
     dfso_upthreshold < dfso_downdifferential) {
         pr_warn("Invalid thresholds (up = %u, down = %u), using 
defaults: up = %u, down = %u\n",
                 dfso_upthreshold, dfso_downdifferential,
                 DFSO_UPTHRESHOLD, DFSO_DOWNDIFFERENTIAL);
         dfso_upthreshold = DFSO_UPTHRESHOLD;
         dfso_downdifferential = DFSO_DOWNDIFFERENTIAL;
}

--

Best Regards,

Riwen Lu






