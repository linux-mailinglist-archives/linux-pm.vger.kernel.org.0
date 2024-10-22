Return-Path: <linux-pm+bounces-16223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54009AA2ED
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B3D1C2234F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8073719DF5F;
	Tue, 22 Oct 2024 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLHyQXEy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769441C27
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603300; cv=none; b=uOFJDoF+4bbD9BlF7CpEmeZ0FgLnh+qMQCVblFjuDYGRDxvt683I4Prafz3mT+SczbARuT87pdCDwhfg/9jjPXkQfNH2VGwD/3GTfftP7chvlCq+WYPwVn82Y6p7LP6N7qzg+qV2aaIKX5AXGbkPC1DcAdUR+vMKqoSygPMAnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603300; c=relaxed/simple;
	bh=l5ripOHNP9g2QR+4SBCzJLunmINoL4ZUXOuOQewZA8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5WKo8pbadYgiKOmUeJD2t7RVGXfkoQ9VSWCJuWkN3ErTYplPU3oLVUAzL8pagnqQkJG7mFSqEw7InKFhusPXJRhYx8tjIENvigK9173laYpLEq6wM25QP+YY4CpVGcCMIuggKecnrLDqe0qgVmkQRNBRICgWLzphkONGMH+EQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oLHyQXEy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2704585f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 06:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729603297; x=1730208097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMu5y2W0aq7zTeZANduollxVJZLzNvVjuzGgrRDXkrg=;
        b=oLHyQXEybzvWDnPzoblJkTynkkO2wWq5b4Gb72VYZgyw6bStyZpTgPTGvImWOat5l7
         0VDN0sklcnls1Or4pDlXWvKzeRcz9klHhtE2NnQb2fmuy8MhKjvwRFlyT6RBExMYy0Ut
         qUqmkdPOnSEPfetqJs7ybJkJXKkSuQKB/e8gPpeh/zTyyjraXNqun0WABJ8LiydlIWLD
         EhzxbRRPcy6+B2nD4bK2yIuADX4XMTUn7hlaP6SBIw68jKvq2c4afn9XfxGlSsIYsYV5
         TOwAuNL0dnzvruXCfpFuUMBK/XA/XMbfGXFJDcqZt5Ruy0BINdmWbuLCqfU4OmyLvEkE
         vH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729603297; x=1730208097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMu5y2W0aq7zTeZANduollxVJZLzNvVjuzGgrRDXkrg=;
        b=ELBE093OAS0z7pZ8RdvLQgiecG6dt8iILAJm4VtZMgpUbA9JTl6XrRZJa7eb7rxC3R
         ZHa5xTInub2UojHI5s01zgANcatM8sVcJBQfmauAgN5s1FhA6LUFFK0lw8y/z1z7dmCr
         ue8hivRAeNE2sjc1NT4SfNDng2YUT/kwMmD+HVn9oQWYOuWMIQF/jfLjne3esAlj2OCG
         SauDYH1w7RxNLNiVCK9RMjFuEdjgTIQmMbF+NVRFDNT+J7TR5EG+J6vXdI8HiDSpx/iC
         /ByCeU9YRsQ80StDvQ3crXMK78Ux3uDPm+MyyiJ8gDBLfgIfOCw3IAyCp3Ykr1pjfjgy
         HG3A==
X-Gm-Message-State: AOJu0YzxZY9oD7TkiPVNS8pLJJnTybrg+1lDXhicGW+Dgu9mt8bm+KW6
	gTcJtBmW9vtnQFiNBHcyZEDKGywQb/x4rfOD1BSP9TZJq23rz2tnlzYWUlig/vs=
X-Google-Smtp-Source: AGHT+IH5TL+Yq9mzeqh/9s8h4lzyYSHSrwKMG6/TSoSh/DZ94FYQ0q+Vp8nsrzY1TyezKsrM0n4vHw==
X-Received: by 2002:adf:f24e:0:b0:37d:373c:ed24 with SMTP id ffacd0b85a97d-37ea2136f4fmr10679791f8f.4.1729603296615;
        Tue, 22 Oct 2024 06:21:36 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4316f570dd5sm88588425e9.3.2024.10.22.06.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 06:21:36 -0700 (PDT)
Message-ID: <4fcfd585-7872-4728-978a-33f30bed3a0d@linaro.org>
Date: Tue, 22 Oct 2024 15:21:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] tools/lib/thermal: Add the threshold netlink ABI
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-4-daniel.lezcano@linaro.org>
 <eedddb6e-fe0b-4785-9590-4b607d775769@arm.com>
 <b648f0b6-2df3-43ca-880e-a5290d0b8381@linaro.org>
 <e7fcd734-53a2-4650-8657-2eadd58fbf92@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e7fcd734-53a2-4650-8657-2eadd58fbf92@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/10/2024 11:50, Lukasz Luba wrote:
> 
> 
> On 10/22/24 08:49, Daniel Lezcano wrote:
>> On 21/10/2024 22:47, Lukasz Luba wrote:
>>>
>>>
>>> On 10/14/24 10:43, Daniel Lezcano wrote:
>>>> The thermal framework supports the thresholds and allows the userspace
>>>> to create, delete, flush, get the list of the thresholds as well as
>>>> getting the list of the thresholds set for a specific thermal zone.
>>>>
>>>> Add the netlink abstraction in the thermal library to take full
>>>> advantage of thresholds for the userspace program.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---

[ ... ]

>>>> +    nla_for_each_nested(attr, info- 
>>>> >attrs[THERMAL_GENL_ATTR_THRESHOLD], rem) {
>>>> +
>>>> +        if (nla_type(attr) == THERMAL_GENL_ATTR_THRESHOLD_TEMP) {
>>>> +
>>>> +            size++;
>>>> +
>>>> +            __tt = realloc(__tt, sizeof(*__tt) * (size + 2));
>>>> +            if (!__tt)
>>>> +                return THERMAL_ERROR;
>>>> +
>>>> +            __tt[size - 1].temperature = nla_get_u32(attr);
>>>> +        }
>>>> +
>>>> +        if (nla_type(attr) == THERMAL_GENL_ATTR_THRESHOLD_DIRECTION)
>>>> +            __tt[size - 1].direction = nla_get_u32(attr);
>>>
>>> We probably relay on some order here, because the 'size -1' needs to be
>>> done after first 'size++'.
>>> If that the case then maybe it's worth a comment. Or if it wasn't
>>> intended and there are no strong guarantees, then this needs a fix.
>>
>> The size contains the size of the array and we want to access the last 
>> element, size - 1
>>
>> I will add this sentence above as a comment if it is ok for you
> 
> Yes, please add some comment e.g. that size=0 will be then
> first modified by the 1st 'if()' so 'size++' will happen
> and there is no way that the 2nd 'if()' will trigger before that.
> Those 2 'if()' are kind of independent in the code and it's
> not obvious from that part of code, why the 2nd 'if()' won't
> run at the beginning. The dangerous situation would be:
> '__tt[0 - 1].direction = ' assignment, which is due to
> 'size=0' init value.
> 
>>
>>>> +    }
>>>> +
>>>> +    if (__tt)
>>>> +        __tt[size].temperature = INT_MAX;
>>>> +
>>>> +    tz->thresholds = __tt;
>>>
>>> I wonder what would happen to the previous 'tz->thresholds' when
>>> we just put new one here... I cannot find other place when it's set.
>>>
>>> Since we have '*__tt = NULL' then one of the solutions would be
>>> to simply call:
>>>      free(tz->thresholds);
>>>      tz->thresholds = __tt;
>>>
>>> Am I missing something, when it might be cleaned in different place?
>>
>> The caller is supposed to pass a clean empty structure.
>>
>> Usually, this function is to discover the current configuration, so it 
>> is a one shot call keeping the structure in memory for the libthermal 
>> lifecycle.
>>
>> The events sends updates of the thermal zones. So with the events and 
>> the initial configuration from the discovery, the userspace is always 
>> up-to-date with the thermal setup.
> 
> So we cannot receive that we have new thresholds?
> I thought we will get that information, even in runtime, so the old
> memory should be just freed.

Sorry may be I was unclear. I meant we will have the list of thresholds 
and we will then receive event when they are created, deleted, etc ...


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

