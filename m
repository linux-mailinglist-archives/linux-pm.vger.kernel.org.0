Return-Path: <linux-pm+bounces-15455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE722998790
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 15:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB5C1C21D07
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D01C9B9F;
	Thu, 10 Oct 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="plgBF/Aa"
X-Original-To: linux-pm@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D41C9DC6
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566684; cv=none; b=c6NxJTsCzHflXN+YRdYisNLAKn870ly0dc+jnVNPwu8HCz+GI7t5pZuS+lvAFWWua245Eaitbd+2tNiD1Da9qKOeeNpClsKxJ6CNvplG2HxsSKoDqrze3n5bJ2ZpCq+ZH63NJOLUeA0Jpdm0TL4TiIexKf5E3+ZqRhbt9RfHj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566684; c=relaxed/simple;
	bh=RPUzWRPmZGtFyZr0kjLm7nOCKdJiTpjtAznJ/S9/Fu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7mJ+8D9/J48/IGudX4z5CmAGWfyES2/N9IZXvm9aybz3TWyPtwgAcucYS55QbSpzo0EdRJKD976VUZ63foAojQIaaqJLufx4RahYfhkzsxds3xlRmYDI8CxFFC832GI4m5g/o6HJugWXFocbOoFpPOX5RvGnXdGNOJBfrAaPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=plgBF/Aa; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728566682;
	bh=UN6iJmBioqcajfS273owz7jWyQHQYDCLoGRNIcRMsEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=plgBF/AaALXUyCcwEzSU725LOltypIU++Xw3KTDZBrfeb+NkpQIy1PZHcKM5PE5E/
	 7+2wFplxuHJcQDAS9iotTBjlMz0O4UsYdMhKWpi+XeB9oZmuUqIWn9CFkZPJUTa6zW
	 kuuXZ80nBQ/GE+AyhxLlHbVZoPXq5B0YGS57pbgkjRWHdqXAGyZLbsWOOI+AaJHppm
	 u+SW5KtExW6p5IlAjKENcOfqzU0Ai9/W8XZp9lPxoHTojRctSIMwVu/eDfip34Sw5d
	 zIGUPJg+Zb94ClR2vvJqqZnf8fNPcys1Io96FVjiE6HpKuMxcx2AzEuk6QeGcIU9gM
	 D5/X6C3Aa1zrQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 92FC5A009C;
	Thu, 10 Oct 2024 13:24:38 +0000 (UTC)
Message-ID: <d1438cf0-8bea-4125-a046-6e4abfbba2fd@icloud.com>
Date: Thu, 10 Oct 2024 21:24:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] PM: sleep: wakeirq: Fix a serious logical error in
 dev_pm_disarm_wake_irq()
To: Johan Hovold <johan@kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Johan Hovold <johan+linaro@kernel.org>,
 Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240928-fix_wakeirq-v1-1-25d13a7e13ba@quicinc.com>
 <ZvqigTC7RvngLpme@hovoldconsulting.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZvqigTC7RvngLpme@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3dxJ_xHJTHPaMZnECM4qYor-VgcqZdeW
X-Proofpoint-GUID: 3dxJ_xHJTHPaMZnECM4qYor-VgcqZdeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410100089

On 2024/9/30 21:07, Johan Hovold wrote:
> On Sat, Sep 28, 2024 at 02:26:27AM -0700, Zijun Hu wrote:
>> IT is a serious logical error for dev_pm_disarm_wake_irq() not to disable
>> the wake irq enabled by dev_pm_arm_wake_irq()
> 
> You need to explain *why* you believe this is an error.
> 

thank you for code review.
sorry to give reply late due to travel.

by convention, dev_pm_disarm_wake_irq() needs to undo the jobs done by
dev_pm_arm_wake_irq(). but actually it does not do that.

>> fixed by simply correcting
>> the wrong if condition.
> 
> Your commit message is basically just claims "P is wrong, fix P", which
> doesn't really explain anything.
> 
> Writing good commit messages explaining what the problem is is not just
> required because this is a collaborative project where others need to
> understand your reasoning, but it also forces you as the author to think
> through your changes, which can often prevent broken patches from being
> submitted in the first place.
> 

thanks for these good suggestions and will follow it for further patches
(^^)(^^)

>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> List relevant commits as following:
>>
>> johan+linaro@kernel.org  2023-07-13
>> Commit: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
>>
>> tony@atomide.com  2018-02-09
>> Commit: 69728051f5bf ("PM / wakeirq: Fix unbalanced IRQ enable for wakeirq")
>>
>> The former commit fixes the later.
> 
> These references are relevant, but you need to include them in your
> commit messages (above ---) and explain why.
> 

got it, thank you

>> ---
>>  drivers/base/power/wakeirq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
>> index 5a5a9e978e85..8b15f9a0e8f9 100644
>> --- a/drivers/base/power/wakeirq.c
>> +++ b/drivers/base/power/wakeirq.c
>> @@ -356,7 +356,7 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
>>  		disable_irq_wake(wirq->irq);
>>  
>>  		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
>> -		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
>> +		    (wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
>>  			disable_irq_nosync(wirq->irq);
> 
> I think the current code works as intended.
>

thank you for this point and let me do more investigation.
(^^)

>>  	}
>>  }
> 
> Johan


