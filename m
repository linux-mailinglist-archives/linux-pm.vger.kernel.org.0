Return-Path: <linux-pm+bounces-23889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F4FA5CE24
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 19:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C6717EFAB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22C1263F3C;
	Tue, 11 Mar 2025 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yjKA1n//"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F35263F28
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718536; cv=none; b=ahBSmBekohNnYGd2tOBN7OlLHUV8aZSg2825mRZ17oFn47jzavRfhlUY9oEdxrNegvaBb36SVrBM9128xIoLg2aN1UZ+NFsDQxGtQfEGNuS7//M5Whvom+oHZtmWEE09q79htlq5n9Skhrj0Pmp5v2PjQ5oBFUlRjndR9vDzwdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718536; c=relaxed/simple;
	bh=sI+nRleyqDcowWvuzMlvVLXmCdvrFdWkmE3QCcnfhHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXpD4EeRtYXq7mUapuk2OssOWITYLy/mjkZl+ujdPEnfbwaqUSyttKA/0ZwGirLqIyc0Bycl+1P0LIkDNQ1YG6ew4mZETjJSFt20vNK2HZ3Dbju3yGAgfYNrOZkRVgz8VvzmqS4Jpnt9bK924K/hrTkvODmbpi/60h8h6ShLYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yjKA1n//; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so5154875e9.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741718533; x=1742323333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hn7P74ivpKMKAmZ8EBBuLNM7zkI0rkJeGu1GImdfrTA=;
        b=yjKA1n//wjPusp+S0FkZks6hGY2taXON6p3hpPGoGQ+pTCyrurWwE8u5YtZYNBAFTH
         B6Af+8bKucrRSOxHoLJZWjXNf/mcJkMBIgH/kQ9RffiacwpNlyNbj3f4/IVpFSleZlqL
         AtKCSUHaqTAezAN4QMcK/agmSMI/C0vAib1uO3OVJ7Pssa761q+B4e89znOUr8xmZTZU
         Qx2Q4tXFhyaviUA7VcZZ8lK0rlNGD7zddyQAVc9job7ZlHbKYLq6r/81V7J/4CnZ5MPe
         X07zgnMdrwC0ABec9iwap8M5Gb76FxcwYEQNpYEq91tniQNTcVJueVYgs5FWUcvrJLq8
         pPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741718533; x=1742323333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn7P74ivpKMKAmZ8EBBuLNM7zkI0rkJeGu1GImdfrTA=;
        b=G5AnPul8U+35NRCozhMhgMkkjbQ0nrTbjXA2UHOiYHBPE/APTd+Up8Jv+NmbNXKAc+
         wdx+4ZeIAA9UuioTQfF7gXHFBoLCuKA4zoTJuZKXExH4juVr4vQ0CblylDTr/WWdiQEX
         HOkRk6oOs/5Q8yfa1iM/pBz+otl0BgVFZ58jBtymqtyov1Y2wLQYOJFYNBG8tljD9AzF
         5xHkFO14yAUAtfQ4TKFeUYoJsgbInTXISi6ThDo07thDw1n6DmZ56lY19PpIoKmiJbyY
         PQPCL9CWl11Hms1zFGfhQbBzbjVhJeXW66Sg2b9S8ZB9QrTtjBeIETgO+Hbqnawo7mlk
         oZww==
X-Forwarded-Encrypted: i=1; AJvYcCXQaYMcYTZQ2hSuXV3cZubZtlbK2Xe7F5qkhVszL6U82sEPPWv/CfQeKuNauYFRsBsuHtK9vbzTrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtjmoYwyBZhdzgtIHDNRxD1uJsq4MeKHX2IN3tv+oYSlsf4S0u
	k5oW3A3Nu2t+s+hCJLSlMkEGT5KKALSvfNkQ4skcSicfxSKfqqvk1p62VPdf5QE=
X-Gm-Gg: ASbGncto0yW7p3QRjEx+vnaZ9Bx3Et/ogLDmH7uNQ6XCc+CjfisMD6J/uPYNyZth+Lh
	7Xeyv+sxT0FMvu9nSe6w8OVHKLIVZKNBM54ek0pZy5ctZtSOWpM4WF60KPNecWzAswzTboU5Op1
	VFBD6Aa+Rtoba26u87505XC46fFhBrIfoY8WYyrHjyyzRojRBGXylFHFqi1x9wpp/LcEWrHXPVa
	VAH8TAwn6JL3CX/nSsG7Ziq7IyUZywh1LEP2tF1sFE18NqlHjozJzIu0yQdkDt8xMBjKGlSxhzQ
	s6xgmewjklHeY+4wxouth7ENM+48Opn+ewbkRif2nw7cbWYqoHkyouWMKl01fzeYF4VCvezNAKQ
	PTsLmfQJx
X-Google-Smtp-Source: AGHT+IE//vBMCbkh48ggcE62G5gTNxd9gO+SkXvlcwEQIFbLhh5emFKx7ijF9NdelP+D5ypn0246qw==
X-Received: by 2002:a5d:47cd:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-39132d16d9fmr14777767f8f.3.1741718532583;
        Tue, 11 Mar 2025 11:42:12 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfe61sm19145782f8f.38.2025.03.11.11.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:42:09 -0700 (PDT)
Message-ID: <03c2833d-d80c-4146-911d-8d1a524a2b13@linaro.org>
Date: Tue, 11 Mar 2025 19:42:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TEO as default governor ?
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org>
 <4a50de85-0deb-4864-b7b5-ee81cec7f167@arm.com>
 <CAJZ5v0jBFOZ-z29-KwgHN9cL4sEPsW9K5TG6XeT7Y-ADbVPcCw@mail.gmail.com>
 <9b4a15c4-4e0c-43f6-b2ec-e98bc02f67cc@linaro.org>
 <CAJZ5v0iJTB_JTb9YMVBCjd=iOPuCRdNQNLS7wXwHRD4kz5h-Og@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iJTB_JTb9YMVBCjd=iOPuCRdNQNLS7wXwHRD4kz5h-Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/03/2025 19:26, Rafael J. Wysocki wrote:
> On Tue, Mar 11, 2025 at 7:00 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 11/03/2025 18:34, Rafael J. Wysocki wrote:
>>> On Tue, Mar 11, 2025 at 5:47 PM Christian Loehle
>>> <christian.loehle@arm.com> wrote:
>>>>
>>>> On 3/11/25 16:31, Daniel Lezcano wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I think we can agree the teo governor is better then the menu governor.
>>>>>
>>>>> Would it make sense to make the teo governor the default governor ?
>>>>>
>>>>>
>>>>
>>>> Rafael's position seems to be quite conservative here.
>>>> Fact is menu is still the default on many systems.
>>>> Even worse, the really bad performance disadvantage when
>>>> using menu in an intercept-heavy workload has been fixed by Rafael :)
>>>> https://lore.kernel.org/lkml/bc7f915b-8d9f-4e05-9939-8b7ecc078f85@arm.com/
>>>>
>>>> FWIW I proposed this a while ago:
>>>> https://lore.kernel.org/lkml/20240905092645.2885200-3-christian.loehle@arm.com/
>>>
>>> It will help if one can make a really convincing case for this change
>>> (that is, show that menu with the most recent fixes included is really
>>> significantly worse on their platform).
>>
>> For all the platforms I've been testing, the teo governor is always the
>> best one.
> 
> Great!  Can you please share any numbers?

There are some at a publication doing an evaluation of the irq 
prediction [1]

>> Using the menu governor has also an impact on the user experience as it
>> lags on mobile.
> 
> Well, I'm not quite sure what you mean here?

For example, the user feels the lag when touching the screen on a mobile 
or scrolling a document. Changing from menu to teo solves this issue.


>> After studying the history of the menu governor few years ago, it
>> appeared the menu governor was introduced before the SMP was widely
>> used. The strength of the menu governor was the ability to find
>> repeating intervals but with he multiplication of the cores, the IPIs
>> were introduced which increased the entropy of the busy-idle cycles
>> duration, thus making the duration much more random and altering the
>> menu governor prediction accuracy.
> 
> While this arguably is the case, menu has also been changed quite a
> bit since its introduction.
> 
> What I'm looking for really is a set of numbers showing the difference
> and clearly pointing out that teo should be preferred.

Ok, let me check if I can find a platform doing energy measurement.

I guess x86 is not a good target as the firmware overcomes the kernel 
decisions right ?


   -- D.


[1] 
https://hal.science/hal-04095844v1/file/O_S_level_interrupt_prediction_for_performance_and_energy_management_on_Android.pdf

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

