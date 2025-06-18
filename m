Return-Path: <linux-pm+bounces-29011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AAAADF6F7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 21:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2891BC01DD
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 19:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F89213E6D;
	Wed, 18 Jun 2025 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEcZv57L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362A19DF7A;
	Wed, 18 Jun 2025 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275509; cv=none; b=JSguxg8+IXZlw7PrSH1WIHgpksXi+qk9C3VuiWt2rWHityV0UN/HTeiL1M3enYCHVcWEfSkE2dKskmGZVG9SDrsNVgS6kbZVUjhOFIPz4HtJ+eQ6JVfRDQ8PNxk9T7sFBwflUpaKeXaUYWupVNRZRnFg2vQsW9/wa2tXXvOVj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275509; c=relaxed/simple;
	bh=d1whGUe6/gw5D8L1TsbBMFsSRpmq5A/atFpTf7gs4bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plt3DQX6R/jNYGCvCz+Z7ywWliVjiOs6Rx5iw0RmtlLodbjRug8uz2Jg6IlCfyU81gcn8SJZ6rFB/9o130QzKl0o4Nw7ImT0iZOC5wVzb5DLFxBo49qDo8pSlIrwNThlMcsp3/ITG5ZPwhlkoqJpZJxa6cLScpkdW9vjgXwCwSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEcZv57L; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so183755e9.3;
        Wed, 18 Jun 2025 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750275506; x=1750880306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2D68AjOhD65ob6ahc321W824b9bdePyaOMeGU4pu4s=;
        b=EEcZv57LV+/GQznMnC6aieF7rKuZevPAxQ/aIj7LuVvVCuFyz2CUnSGDaA/uWsskaE
         znND6sd44aZkfNwknJNZ9G3sr/xYN4qL4LSFdhqNiwhllckasPOjB1lWkfeKHNp3jKuo
         lWvKiW+syotQV7myuv/1/F0bb32M9Uoijs44yLyjybAfA8G19UjIXjOoIRqE9iuljasd
         aMCbeAY9ybq4LjG1C8cMdhEyShq8ufowsutbCwdvmYnSakdS1W/TaVWVbfsHXrRLy4Jp
         oXKP/xkU1mt8iFZKKi16h07Oz+3makQw/cx7bj1ITxs6+ixYnfSiMNNXzpfiFqJOQ3iI
         +pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750275506; x=1750880306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2D68AjOhD65ob6ahc321W824b9bdePyaOMeGU4pu4s=;
        b=SZALCZEijKxdYVPVnljc8j7CYTg92RerDv0YXFJrC13XGqjtEkJC107aSeQJ1+e7Yo
         7/2V0cJkBeljT2PGnll/IUsxyb7A2z3VftiKhDwZWh/HCZ0U9zySDKu9xJV36jDDqZWf
         mwa7TXGZa7GX9uhMvFy6SEsAnW1dB6iRks6DmnENBBKjipSQoEqwJdYsRsaRmzfpsQQQ
         LLj/ymbjbxzTPzauZzL2PuEonVk8Qa2LhiSG9DjpSc0uiY7U01nDVzLia+6YPkQ1C3Wf
         xUv1BrwoSfiSSrZUyAvK7f/Riu5r48XEJ3lJStgGtzqLCWuadDbmToaEHLx35T3onzCk
         QDxw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Lx6Y8clDPZarcO4XsBLgtKdOZy7NOrvVQLbz4uhJ9+V9aux8KA+adG+kAIbvOMcdWvsCQPLnjZc=@vger.kernel.org, AJvYcCWh8ijdIHdRlQU492x9XCZlyiDta0VgzL7VFbcrXapiEw0p109z3ML5jFXhER+33xF78LtdVjilMTmfGc19@vger.kernel.org, AJvYcCWlelS5aFZYuL1EbknObxH426JsfgrKv70iHl3sUMwkIt++xK+9ekgJ/paR/gB5SQATHE3VNlznRyppMwin@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYKnHoqlVrISI9AkbBX+pagQ+P0cqWLvgSTnzTZaSJS9yVQUb
	EezrSUf6rLFXeFSeanVKgUGE6i6+8XycZmVQcwhGrJSp8DZp3p65O9kM
X-Gm-Gg: ASbGncutLKo2HSFwUCsT3y6yPvnbF8ISDUeEM+MpDj3LwMEbNRa865yMdUGzx663t3v
	c8UqpSb0z700aDiuZeH6ToTtXG0YR2Wr5Rc2GSLi888mJGYaOfTIsD1v9dVFOasrT2344+X0nPp
	HSvqbkYCSiK/kuikRspj8o+rDHq6ripueXgGjmHc5+JyjAANa7Ex0qzASlv7tChhKZkYBY1og/w
	9zxlPZtLNBHxlUhJu8jAVLHBMKS+Z574V9mHwp+uv5R2+YlIGMC2XfuYZL018XQ4eUOoZ6/iVPn
	nOpl158ZecevsRCie9VF7aYYfoPvthyaINq23PxNBxOzvgmIZcV9jrJEjh24WSJNAqaskr2JjQc
	vEkg7BGYAGwpkB8v9mXL0lpUGCIM=
X-Google-Smtp-Source: AGHT+IEAlu8eaLc4zokaEd0yP7OxADSH00EGrKoNAOkdeTQ8e1Zn5FmjRwQrIlj8sevy2FyyZoKXRw==
X-Received: by 2002:a05:600c:3587:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-4533cad1aa0mr195109995e9.31.1750275505926;
        Wed, 18 Jun 2025 12:38:25 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8c41sm5947235e9.26.2025.06.18.12.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 12:38:25 -0700 (PDT)
Message-ID: <5f8c1163-d347-4c93-968c-3fd191336f04@gmail.com>
Date: Wed, 18 Jun 2025 21:38:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: avoid memory allocation when 'icc_bw_lock'
 is held
Content-Language: hu
To: Johan Hovold <johan@kernel.org>, Georgi Djakov <djakov@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250529-icc-bw-lockdep-v1-1-3d714b6a9374@gmail.com>
 <aFK0a8AIOl704DpP@hovoldconsulting.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <aFK0a8AIOl704DpP@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Johan,

Thank you for taking a look into this.

2025. 06. 18. 14:43 keltezéssel, Johan Hovold írta:
> On Thu, May 29, 2025 at 04:46:22PM +0200, Gabor Juhos wrote:
>> The 'icc_bw_lock' mutex is introduced in commit af42269c3523
>> ("interconnect: Fix locking for runpm vs reclaim") in order
>> to decouple serialization of bw aggregation from codepaths
>> that require memory allocation.
>>
>> However commit d30f83d278a9 ("interconnect: core: Add dynamic
>> id allocation support") added a devm_kasprintf() call into a
>> path protected by the 'icc_bw_lock' which causes this lockdep
>> warning (at least on the IPQ9574 platform):
>>
>>     ======================================================
>>     WARNING: possible circular locking dependency detected
>>     6.15.0-next-20250529 #0 Not tainted
>>     ------------------------------------------------------
>>     swapper/0/1 is trying to acquire lock:
>>     ffffffc081df57d8 (icc_bw_lock){+.+.}-{4:4}, at: icc_init+0x8/0x108
>>
>>     but task is already holding lock:
>>     ffffffc081d7db10 (fs_reclaim){+.+.}-{0:0}, at: icc_init+0x28/0x108
>>
>>     which lock already depends on the new lock.
> 
> Thanks for fixing this. I get a similar splat with sc8280xp and the
> icc_ism_l3 driver since 6.16-rc1.
> 
> Georgi, this is a regression that prevents lockdep from being used on a
> bunch of Qualcomm platforms and should be fixed in mainline ASAP (e.g.
> to avoid further locking issues from being introduced).
> 
>> Move the memory allocation part of the code outside of the protected
>> path to eliminate the warning. Also add a note about why it is moved
>> to there,
>>
>> Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>> ---
>>  drivers/interconnect/core.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 1a41e59c77f85a811f78986e98401625f4cadfa3..acdb3b8f1e54942dbb1b71ec2b170b08ad709e6b 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -1023,6 +1023,16 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>>  		return;
>>  
>>  	mutex_lock(&icc_lock);
>> +
>> +	if (node->id >= ICC_DYN_ID_START) {
>> +		/*
>> +		 * Memory allocation must be done outside of codepaths
>> +		 * protected by icc_bw_lock.
>> +		 */
>> +		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
>> +					    node->name, dev_name(provider->dev));
>> +	}
> 
> The node name has already been set by the caller and the node has not
> been added yet, so I think you should move this before taking the
> icc_lock.

It seems reasonable. I will send a modified version, which also contains
handling of memory allocation failures.

> 
>> +
>>  	mutex_lock(&icc_bw_lock);
>>  
>>  	node->provider = provider;
> 
> With that addressed, feel free to add my:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>


Regards,
Gabor

