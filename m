Return-Path: <linux-pm+bounces-15414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19978997231
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 18:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FA51F2675A
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9B1D0E38;
	Wed,  9 Oct 2024 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GIL+PgTv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCC119B5B4
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492250; cv=none; b=cDVG17om+kzmxPh/NGRIkhi+TbvqDAtOadvh2lrc9wtS032Py6EgeYq9VLBayH+mMozP5elsfAr2tgtGPdJ8Th2wQvBRVn3nma32U/b8PtJMdm6v3X2iCAjvQmNewlPEWOJjMnfdHAN11eI+9qqaoGltY5AkrV21/R5BTJMo77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492250; c=relaxed/simple;
	bh=D/ATif+FqzBtAjcsK3PLdJ9wBPPJ3TlVgxQQvLfT5Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhdcQbkWUUKxT6pxAtM8i0XdC67bdWI40MMVLEB/MWYtXsJshHn68x0g5rJN+ub+zGmQhTtjWKB7f0oYLyDjpHdTkF0yzKG+R+cZnLVJcG8SHxjLGyUWSMWweNP6c3PZqrHcZNn2eeNoAxatwRqXi7Zfn808g1e1fSbeDx7mzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GIL+PgTv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43055b43604so18403315e9.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728492247; x=1729097047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DgWt5N50dewsiM1DJ8VdtT2+tonXn/iS/XV0z+JVXL0=;
        b=GIL+PgTvZjcTNLf2cBfV3S5r5DJrk3r6h9mVFLT1sOyv+NRxIyQ2Rc+7fP5eZ9oEcF
         tE6hQxqlAdC/6oU2urIHNMaAtdYRJNGK1isVQIIqZajZWmlBfmXY6gcJ6DMWmDSmfLA7
         UHWL2tRrdbb8P6LKSexDnYFAkr4PCjAmZ9Kopf2FJ3nYLWWXv0LV+OdrzNLBdg1IznNZ
         eWP/MQzJEXUz3+6aODJbY1VnfHTwgddiCsWblCB8rk5h5lEfr09z9vhKdPafTgme9tee
         fdsgUYnICZDclDp29MoF78Vyp9VGegEBQfojLxReiiWsofY1E0QJsp+YrRlX++IJUN0P
         03Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728492247; x=1729097047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgWt5N50dewsiM1DJ8VdtT2+tonXn/iS/XV0z+JVXL0=;
        b=bKkakgDtN8e0o7W5XEBm0/PuxBz6iSrbBdEam2tUhzyDgR9gU0tez7uEDcK0dtt34Y
         nb1LJrgHYzfxdhpBcEa1WMBWdVae6s1H89hhZUt58Lavfd2EmGI+JqXMwrQrfaKEByWn
         Xy6MGRMGSGmwDEPSiSdWzfzCtjmsaORPFmqCAsmUeE+WBbzUMqaw3ZPLd4W2iZO0M7ov
         1z7Yj1v7AAhVgdxo00oYQojP6vfEtIKVmyfCuzDMSCWAhb1RuIxfkhil8sFjZ+qgeMnm
         uFOhB44O4mmgxB+PHActk8Rv6aCoVsYJKO1InnlfHlFnxyT2HJ6uLR32qdexEXw2/BCM
         HR3g==
X-Gm-Message-State: AOJu0YzbHvRSjxv3+ujh+xo2/VxL0qj8DzS8bd1z63xrj1qzKVFk8T05
	vjmPtgek5eOJt7vOhjFX/IVTH7PkfN6PjbjK1uGPEXslMrovi8i6wASaZVDlESk=
X-Google-Smtp-Source: AGHT+IFcPeE7etnbjKaCYJjCl7GhUciXgRxF88kKkwyfykZCLevXWfv5LuWu7sNbJ8Rvpk6l5sAUCw==
X-Received: by 2002:a05:600c:1e10:b0:428:f0c2:ef4a with SMTP id 5b1f17b1804b1-430ccf1d7fdmr28454605e9.13.1728492246656;
        Wed, 09 Oct 2024 09:44:06 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-430d6faa2a8sm25580465e9.46.2024.10.09.09.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:44:06 -0700 (PDT)
Message-ID: <bb4741a1-0a1a-42a9-b71a-0ecd9d34b231@linaro.org>
Date: Wed, 9 Oct 2024 18:44:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] thermal/core: Add user thresholds support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, lukasz.luba@arm.com, quic_manafm@quicinc.com
References: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
 <20240923100005.2532430-2-daniel.lezcano@linaro.org>
 <CAJZ5v0i9N_ie_duMXYSumQSnFDVxHj1h1ikSyrApJyEjXs_mQg@mail.gmail.com>
 <CAJZ5v0jCOHAmpmniVRuGCrtvKj6+YtCKidKSJf1t+HitwpKrwg@mail.gmail.com>
 <d9682276-1068-4b90-8478-bf1f5047d306@linaro.org>
 <CAJZ5v0iUYnJi61TAaUz5exRhH7fjwDSXCCeVVUQgm80L-ujfnw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iUYnJi61TAaUz5exRhH7fjwDSXCCeVVUQgm80L-ujfnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/10/2024 17:59, Rafael J. Wysocki wrote:
> Hi Daniel,
> 
> On Wed, Oct 9, 2024 at 5:40 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> On 02/10/2024 14:22, Rafael J. Wysocki wrote:
>>> On Tue, Oct 1, 2024 at 9:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>
>>>> On Mon, Sep 23, 2024 at 12:00 PM Daniel Lezcano
>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>
>>>>> The user thresholds mechanism is a way to have the userspace to tell
>>>>> the thermal framework to send a notification when a temperature limit
>>>>> is crossed. There is no id, no hysteresis, just the temperature and
>>>>> the direction of the limit crossing. That means we can be notified
>>>>> when a threshold is crossed the way up only, or the way down only or
>>>>> both ways. That allows to create hysteresis values if it is needed.
>>
>> [ ... ]
>>
>>
>>> I'm inclined to apply these 2 patches with the change mentioned above,
>>> so that I can base my 6.13 work on them.
>>
>> I was expecting you to pick these two patches and do the modifications
>> but I don't see them in your tree. Did I misunderstood your comment?
> 
> That's still the plan, I've been waiting for you to respond and confirm.
> 
> I gather that this is OK then.

Yes, it is ;)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

