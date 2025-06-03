Return-Path: <linux-pm+bounces-27995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4E0ACC2BC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 11:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518AD3A5330
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A2F227EA7;
	Tue,  3 Jun 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpBJBlMd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DED271452;
	Tue,  3 Jun 2025 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942114; cv=none; b=Ksfr5fTj+X2i9rpb5uBwESTTPvc+qyiSwpeEQqusIvtW7FlgGU54FwL5JYyre1OkGgFCBueum5LHMLhHNlAUktPTHXtlwR3H+4Tet/SK2Gvpp5xD4MsKwfh8zqcRrFL4ghACF/uMBOc2uXFYHJy5rKJ/vnuUJlO0cOh42ZmtP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942114; c=relaxed/simple;
	bh=90J89FRoLbaCkl5i5DlgQt/UDCz7Fg3Kq4DQuJxYYY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDJIum2VTlJic+/angBIaivG4yORzBNb5eSHOuFYndBDTeSLvGIEOrjZfPL4I3COCfIANjI0ZNoPLxpj27uB4XUFjf1VsMO/8H86Vz1o54X6sviu/ogrmEVfKHSXadwAf4i24YS9F8ddc4YoXTicG+/cCp2Ex5BflikQvg4QKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpBJBlMd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so32591605e9.1;
        Tue, 03 Jun 2025 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748942111; x=1749546911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqNY6j4SjmSasikzYTEU+CWGtge3RNhUNmH36kstVFM=;
        b=EpBJBlMdBkr0fvAC3FLGRWHTbZsGDIgc69YLLFg+pxPfjogBnM9ZRpQk6rs1oqXwD2
         XloIAWzNa31Z/NF5DkhTvD3y/FmDCZEDINuoUtE9oxYC4uNIwLiUY9C/JpNiNgJxBnxH
         roXLNZyXEl6jpmkF6NGyM56Mr5HsOYkqyZUlLf058KqdZoRA2oCwAncjpOASML2kaj8h
         yzYNYQSB3mRSgFjJfSLvs4OgJHcoLttavnBTpt8AxA9vsTl3UvA27f4KHDwns4zBUgIb
         bCDf7KrJCu9U/MAflSwwNaJenCYWxX8m2tWE8yVuxnxhAcrHnR86sXC59oZ4zZMgbaJQ
         axYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942111; x=1749546911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqNY6j4SjmSasikzYTEU+CWGtge3RNhUNmH36kstVFM=;
        b=oMVXZUysT+hKlsDPjoqZBQfcAg3dhNijeWABUzXj4FMB8dyi+W4Ra9Pqr71waNjraJ
         XDV0x44tmLF0gAGBU5o2YKPKhOhueodXA0vb/9fgk+pZV4mGQo4BWMRFfW97u1y7ufIG
         GSEG+qM+n0pneU3t8kBG3pSUaqRBSqLglRnr1E5PTLnEQYRMsHRyOafvE4KapvzRoPQH
         L2FyxIy9LaTVhn+/niz5f6vC8AYG8Uy4HbVSyH2rYMWMKG/YCX77jWy44G0GsYAq3R7p
         Nhhss2FyxPnYwg1ax2oA+y5kbnt3Dnfaz/owIGyEZI6iZ/EdPfv1nV6rwtM2n021qJC7
         R8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCW407I7yCzOTUUppzKJyxMFIinqP6f7rfFloJ01LyfOOZRV0pOz6oBcLBHe8sp8N8LEjTIMy8AR48ksTHU4@vger.kernel.org, AJvYcCXdKdRjDTr5z31r/MJsG1IejvSlLLim7bBukkyHD2ECFrcaOImUNyAsbjAEDtDLCKQOsi4837AkKHceDChe@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2jc+F5AYWu7o8/IQv2jJmggc/4wuxPPHtHsC/gQ9NDqdpL1q
	H+4LUmS+n5llL4es/xYv/X0NpClw18jwgp1YlVSwZGasRDKFte5Y7zVfdlpGwQ==
X-Gm-Gg: ASbGnctTbeQlkJlyfUf0WJXVvxBG2VUhsnWOv6JJYTCvpBy60hqfuUQV8A3nOtT7A/V
	b2nf9zwkdj5LOmYjVHX/bs3621Au1DgVgFdXSrgrCIp7Ki3dqhkhcEx1TqzAA78ippbsI9eF5CW
	g7KSWpCRY1CWUXOyq/IqAUANa4JqowRKTYJIqFfrPpqHCd2iFNFHw0h/eCB+r9FmWcAt32QPPeU
	rj6KtFLVYLrNGRU4BfvJCXrNX6FXItYGF9P0l889KZXdQXunixH8zsAUqvXwZy/8/TG9XhjiF18
	ZCzXgC2fhPoG+1dAHkWEnL4oBqTJK+nhF+X0bP3goqYxC5XtFqnqjH8N4sDtGRNwhjqI+BmkWY6
	YQtDpMbYxZKIdehMN
X-Google-Smtp-Source: AGHT+IGlciBL7ibK9r1TZdS0EGS445Io4fw9r6wQOCycQseCqwJpofmOfXb5C/grck1buIn+MTnYUA==
X-Received: by 2002:a05:600c:810c:b0:441:ac58:ead5 with SMTP id 5b1f17b1804b1-450d6560164mr165346345e9.31.1748942110854;
        Tue, 03 Jun 2025 02:15:10 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c842sm17349917f8f.29.2025.06.03.02.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 02:15:10 -0700 (PDT)
Message-ID: <75a46897-040f-4608-88f5-22c99c8bed97@gmail.com>
Date: Tue, 3 Jun 2025 11:15:09 +0200
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
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Georgi Djakov <djakov@kernel.org>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <TIkPOGVjPeCjPzjVtlSb6V5CIcpaXf2-6WG6HjAyaOW59Hj01-9VK7Z8DKadakOKr6fJeQICi6h0Z8mft9DQyg==@protonmail.internalid>
 <20250529-icc-bw-lockdep-v1-1-3d714b6a9374@gmail.com>
 <ca9f7308-4b92-4d23-bfe7-f8d18d20de10@linaro.org>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <ca9f7308-4b92-4d23-bfe7-f8d18d20de10@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Bryan,

Sorry for the late reply, I missed your mail.

2025. 05. 30. 11:16 keltezéssel, Bryan O'Donoghue írta:
> On 29/05/2025 15:46, Gabor Juhos wrote:
>> The 'icc_bw_lock' mutex is introduced in commit af42269c3523
>> ("interconnect: Fix locking for runpm vs reclaim") in order
>> to decouple serialization of bw aggregation from codepaths
>> that require memory allocation.
>>
>> However commit d30f83d278a9 ("interconnect: core: Add dynamic
>> id allocation support") added a devm_kasprintf() call into a
>> path protected by the 'icc_bw_lock' which causes this lockdep
>> warning (at least on the IPQ9574 platform):
> 
> Missing a Fixes tag.

Erm, it is before my s-o-b tag.

...

>> Move the memory allocation part of the code outside of the protected
>> path to eliminate the warning. Also add a note about why it is moved
>> to there,
>>
>> Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>> ---
>>   drivers/interconnect/core.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index
>> 1a41e59c77f85a811f78986e98401625f4cadfa3..acdb3b8f1e54942dbb1b71ec2b170b08ad709e6b 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -1023,6 +1023,16 @@ void icc_node_add(struct icc_node *node, struct
>> icc_provider *provider)
>>           return;
>>
>>       mutex_lock(&icc_lock);
>> +
>> +    if (node->id >= ICC_DYN_ID_START) {
>> +        /*
>> +         * Memory allocation must be done outside of codepaths
>> +         * protected by icc_bw_lock.
>> +         */
>> +        node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
>> +                        node->name, dev_name(provider->dev));
>> +    }
>> +
>>       mutex_lock(&icc_bw_lock);
>>
>>       node->provider = provider;
>> @@ -1038,10 +1048,6 @@ void icc_node_add(struct icc_node *node, struct
>> icc_provider *provider)
>>       node->avg_bw = node->init_avg;
>>       node->peak_bw = node->init_peak;
>>
>> -    if (node->id >= ICC_DYN_ID_START)
>> -        node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
>> -                        node->name, dev_name(provider->dev));
>> -
>>       if (node->avg_bw || node->peak_bw) {
>>           if (provider->pre_aggregate)
>>               provider->pre_aggregate(node);
>>
>> ---
>> base-commit: 5fed7fe33c2cd7104fc87b7bc699a7be892befa2
>> change-id: 20250529-icc-bw-lockdep-ed030d892a19
>>
>> Best regards,
>> -- 
>> Gabor Juhos <j4g8y7@gmail.com>
>>
>>
> 
> The locking in this code is a mess.
> 
> Which data-structures does icc_lock protect node* pointers I think and which
> data-structures does icc_bw_lock protect - "bw" data structures ?
> 
> Hmm.
> 
> Looking at this code I'm not sure at all what icc_lock was introduced to do.

Initially, only the 'icc_lock' mutex was here, and that protected 'everything'.
The 'icc_bw_lock' has been introduced later by commit af42269c3523
("interconnect: Fix locking for runpm vs reclaim") as part of the
"drm/msm+PM+icc: Make job_run() reclaim-safe" series [1].

Here is the reason copied from the original commit message:

    "For cases where icc_bw_set() can be called in callbaths that could
    deadlock against shrinker/reclaim, such as runpm resume, we need to
    decouple the icc locking.  Introduce a new icc_bw_lock for cases where
    we need to serialize bw aggregation and update to decouple that from
    paths that require memory allocation such as node/link creation/
    destruction."

> Can we not just drop it entirely ?

I'm not an expert in locking, but I doubt that we can easily drop any of the two
mutexes without reintroducing the problem fixed by the change mentioned above.

[1] https://lore.kernel.org/all/20230807171148.210181-1-robdclark@gmail.com/

Regards,
Gabor


