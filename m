Return-Path: <linux-pm+bounces-6950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3302E8AF62A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 20:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AA428F11D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA52013E3F2;
	Tue, 23 Apr 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/FgQXI8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30513E3F3
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895237; cv=none; b=LLuGPwUbeD3JWz22PI0WwD4x2OqoDOvv+pEjyMCC8j9wM8jfVNO6A8aSxMwUYJQ5mSE57S0ZlGJNWUkiEW6hMqZ8PGLWEY9JrtZtpVECRDUE5MlbHxx6QrDaXscFeG5mb4oECJzMB7E05s+Px0M9AGta+38HAAwvII4fuU1NYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895237; c=relaxed/simple;
	bh=+Ycvpa9EG63dR81CHp5JkGsctcaf5dahBQ8q1erP7GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqYMAHXt42gGxU1FYzleIZUhenwSMGcWGAIoYJfJC5XFvzRY0P9SqHFOhggvu5g2GCU7jyR6EvY7YGDo8n7/FIrSaJzSdKeB+gsa96q3VE+Om3ufIZl0yPYplNwT4YDtAc5KFDJ3KqLnKrIVhTofnBHZ/bYwbkS+Av6/NwTu5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q/FgQXI8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41adf155cffso3468865e9.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713895234; x=1714500034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrPlhm46dVYsHXusJ+hWfPOX88ZyITI8Ng81vweSato=;
        b=Q/FgQXI86olQ97k3hGIw14RYQByjGCJ5vLqQJYqJabPsEFqVsU5zPyV5/jMzDveqcC
         8ukn06NqaSKFVJ4q8ykkSEDguWJl3gpUxtbLdCtx1qk+vyURJJj46r87Eo9UP+I5BJ5f
         RMU3lQW6ufLPK326PsRE7iE84WndcXaCl1tDA1JT0e4rRrP2otv67PpzN9p8kglZK5o8
         m02TchMPDf0UrM+DGWJQqfrSs0th2J0+vqNwd3Fs9yzKKXCIzrjvB8ksmngUOE6lIZuR
         NKxBnlcrOuQQ9rlj5lj6JNnsD7dUpf1GeQVR3tJ507xa3BlZNGALjJDJopie0nIkN9E3
         nTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895234; x=1714500034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrPlhm46dVYsHXusJ+hWfPOX88ZyITI8Ng81vweSato=;
        b=i00PaXX3+A0QN7CSLe+56ILGORkYSYjZkKqvzoWPcrk9pBWSH81lW5pBLUkGCtU3O8
         7hCYhqQyupWj6XM1gDVgdE/zEC1zJSEAvFTkCxafWlQA2KshBQ32UoxTzHXwZitdbEHe
         4W0bWJrpYboDgBA5dqHM8mpLpb81ZEnlpNDPoDY8wBt9iDxt7ExM0N7R4GIWH3901L6v
         aOaWeM7CkyQzYaRhARboISVAdRgCXkPwRRfSdzlEoYMirFo3Zli3VAe7gc0SGBa/w1wF
         2asinbPLSt484//bE3C3uKEqE7JmhADaLK/nfttS1Td1M2zEmkr1AGxq0wHJz/T4KIJT
         hdGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8qA5jtJh4xN3CvkvsBhoBXekGGYI8DCMumgGHRuedDgImhEuHZLSoYHaUYbDsthvZUW+91D3NbGn0btwnRHGbixSWXQv5KTk=
X-Gm-Message-State: AOJu0Yyv33hM86R2dy/Dgh/5lX/z22kNNm+Z/U43kY8s+k+JokikRcZ1
	Dt3hDOluGbDBHfR4mTovyZsubAslrHyzaedWOjQRsaxTBeXTpgLS9/b8VuJsmgw=
X-Google-Smtp-Source: AGHT+IFPKxRpVw/tgIobHtXRwOUabSviwAvOx44Txi85lVaXClZmQ6awKbEmi2X3Yz//oeXnMfcuvg==
X-Received: by 2002:a05:600c:3b07:b0:418:a2ce:77ae with SMTP id m7-20020a05600c3b0700b00418a2ce77aemr11122wms.27.1713895234395;
        Tue, 23 Apr 2024 11:00:34 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b5-20020a05600c4e0500b0041a7fe7a300sm6223533wmq.26.2024.04.23.11.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 11:00:33 -0700 (PDT)
Message-ID: <33cafcb3-af9c-4058-b6b6-4e5aab6e21cb@linaro.org>
Date: Tue, 23 Apr 2024 20:00:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/16] thermal: gov_power_allocator: Eliminate a
 redundant variable
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <1913649.CQOukoFCf9@kreacher>
 <8e26c3cb-1283-4561-95aa-30432f1d13ee@linaro.org>
 <CAJZ5v0h=15LYhukPWmHPK5hvD=2u75rTEiC8oJMVBFziMkB5gQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0h=15LYhukPWmHPK5hvD=2u75rTEiC8oJMVBFziMkB5gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/04/2024 19:54, Rafael J. Wysocki wrote:
> On Tue, Apr 23, 2024 at 7:35 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 10/04/2024 18:12, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Notice that the passive field in struct thermal_zone_device is not
>>> used by the Power Allocator governor itself and so the ordering of
>>> its updates with respect to allow_maximum_power() or allocate_power()
>>> does not matter.
>>>
>>> Accordingly, make power_allocator_manage() update that field right
>>> before returning, which allows the current value of it to be passed
>>> directly to allow_maximum_power() without using the additional update
>>> variable that can be dropped.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>
>> The step_wise and the power allocator are changing the tz->passive
>> values, so telling the core to start and stop the passive mitigation timer.
>>
>> It looks strange that a plugin controls the core internal and not the
>> opposite.
>>
>> I'm wondering if it would not make sense to have the following ops:
>>
>>          .start
>>          .stop
>>
>> .start is called when the first trip point is crossed the way up
>> .stop is called when the first trip point is crossed the way down
>>
>>    - The core is responsible to start and stop the passive mitigation timer.
>>
>>    - the governors do no longer us tz->passive
>>
>> The reset of the governor can happen at start or stop, as well as the
>> device cooling states.
> 
> I have a patch that simply increments tz->passive when a passive trip
> point is passed on the way up and decrements it when a passive trip
> point is crossed on the way down.  It appears to work reasonably well.

Does it make the governors getting ride of it ? Or at least not changing 
its value ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


