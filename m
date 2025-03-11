Return-Path: <linux-pm+bounces-23887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D5A5CCFC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 19:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC7F189D9EE
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F88925C6F5;
	Tue, 11 Mar 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Di8Jvj77"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5341C3C07
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716052; cv=none; b=MeYP0FsBxFNE8Q9J9NkACMrdxrMOZXIzPd2uPD7zOhIO+J0v2LAd4+aRMOnyxXPR1RUYj+J2dEF6TH0bUWMs90NbbVv6rMcZnK+4kjx8QUONq3R91BrJ2ItTlkqpa1zrOEO2xV3IlH1zFdX5ohMgnswPOn9C0WvB/s+7NeiSEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716052; c=relaxed/simple;
	bh=aQdxjZ7k28UaV/HEH6jxKhV8xP0jjZdVFKf6nqPzQXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubocHeLHxbUsAS9/qXWNgf4OESkOwwmDS8eHHPQT8p2xf+kDpQa8MnGeI60Ugnhv21EUg2hviYef/DEJ23K3SVXEzQbQbWBRXSuEyikhpMvZtPW6WCdMf9b6epX/0GVh6gfg1MhHgbmGU4yk8gMG5nPrlLPD+4RSYs4/JnOCudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Di8Jvj77; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43690d4605dso36413255e9.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741716049; x=1742320849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dPm8miq1+9Ll+phUgmFPGfOSK01MKSZ6oz/HF4A8F6M=;
        b=Di8Jvj77rPrI9hAC4sbaReaLviW3zA2gYqL/SV1SZ+kKdTjkPeyn45MiHEcYRdxL2C
         wO983UYXFRr+3r+5XAOb6WDpKzOW6maQ+Je29Ri7izKabVfvW8oZa+QtTvcOGzhGM/O9
         WYJwPEws6DzEm1/QGsTroNV7k32XOesX0dDqCsra9TkR+VGBJXugwzCL+NB6oz1MPoU+
         qTSd7suxh6NwxSLl8FKVK1RHDyD4hfE6k0GHdDX4XVTJvxWHPZZ9fthitKjfgFt9d8GT
         SmZTAnMGmMBo8yEhw5/flTM2lNn+VwPg9BRivx7hD5cw38yjixXrrz2UsuGF9U/V2Ahy
         0FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741716049; x=1742320849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPm8miq1+9Ll+phUgmFPGfOSK01MKSZ6oz/HF4A8F6M=;
        b=SgT9mr6E1bOXQf8tyC6uE3ODunsoB2QIT5uNjRm9Wx5YuxDh+HakMDwzAZjK65Z7Cz
         FOIGUSHRH6I0ruTjm/1vmACh8rZ8vddn0KyKuuuEfcrVLzsWG2GjZ+ATD1oLfXTaflyd
         nqIvIo8woqKDjPS70zdwL5kNd1Puw+Sg5m1yHQ6nUfBGCZjemWHL29NtUdC0qQHZLHDU
         5pSUPbFUBvZRkpAHtSzlnVbV3FUPlXfP+/iJADSkjgvxk87T8in3vR1nE/HWsvT/AHsU
         ssi+5jAwdYgg0/gDiwn1PdPvL7PdI0T864DKxe4Q7RMgnB3Wb4xBBd/ooraQb3H16vwm
         Sqkg==
X-Forwarded-Encrypted: i=1; AJvYcCUXxXJE+0GbmbDDDPNvOFqU+CSVyTM9KQoEXxtmlo/j/l9eT3bYwysXWRtMfF5M+tzKQnItrtX8Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmRAu1XRB/GJypFtiB2cePrBIxe4Bg48HvEDqa5fcakk8l6Ma
	K3X3fJpB4o4Itfg5XO1fYNLg05TPYuhg5qU2meptXT4gIODd7WXVkqbeoM5dsL8=
X-Gm-Gg: ASbGncuqMM55e4UbQYEK9683ivljXLoBPtp/81/MPVCFaP5enfGRyDhxdJOxS8Ygh1a
	IUqqHlTbkloYlpEW68a5Z3XC3Lmx2m9avUtZF//vZXEtN6RY00z8PEmzYJ/KTh4Qw5EXlI5Hquz
	00CTVCsxfV6CPpuScdvphFat6xn25srA5WvQdVKYMSZo4o4Ol5IIZit9icg1AowBpLvGkHtT9Qg
	TTF7dRVlRdgWODw0Zgo90u3zHd8vkyu2K8Zms5HkqOXd5o1evBybQEbYmv3ZMGPbyiCTBVhJACV
	CVU9hZz8Sc1Y+PAvrDEzOWORLJvZM9XWKggtesTPkH5eEj2f6Xj0zk5YpAt3Y32YjuWLPHBSkp4
	rB20WfxSV
X-Google-Smtp-Source: AGHT+IEYPcNKVQ5GA5Wv6Cif5yxckVkR8PybJxgtyaF153yqKKkyN9hdLeeXMCAQ5mSRshm7S6QK4A==
X-Received: by 2002:a05:600c:4751:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-43cfffc7ca2mr74716305e9.8.1741716048567;
        Tue, 11 Mar 2025 11:00:48 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfb16sm18573590f8f.29.2025.03.11.11.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:00:48 -0700 (PDT)
Message-ID: <9b4a15c4-4e0c-43f6-b2ec-e98bc02f67cc@linaro.org>
Date: Tue, 11 Mar 2025 19:00:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TEO as default governor ?
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org>
 <4a50de85-0deb-4864-b7b5-ee81cec7f167@arm.com>
 <CAJZ5v0jBFOZ-z29-KwgHN9cL4sEPsW9K5TG6XeT7Y-ADbVPcCw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jBFOZ-z29-KwgHN9cL4sEPsW9K5TG6XeT7Y-ADbVPcCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/03/2025 18:34, Rafael J. Wysocki wrote:
> On Tue, Mar 11, 2025 at 5:47 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 3/11/25 16:31, Daniel Lezcano wrote:
>>>
>>> Hi,
>>>
>>> I think we can agree the teo governor is better then the menu governor.
>>>
>>> Would it make sense to make the teo governor the default governor ?
>>>
>>>
>>
>> Rafael's position seems to be quite conservative here.
>> Fact is menu is still the default on many systems.
>> Even worse, the really bad performance disadvantage when
>> using menu in an intercept-heavy workload has been fixed by Rafael :)
>> https://lore.kernel.org/lkml/bc7f915b-8d9f-4e05-9939-8b7ecc078f85@arm.com/
>>
>> FWIW I proposed this a while ago:
>> https://lore.kernel.org/lkml/20240905092645.2885200-3-christian.loehle@arm.com/
> 
> It will help if one can make a really convincing case for this change
> (that is, show that menu with the most recent fixes included is really
> significantly worse on their platform).

For all the platforms I've been testing, the teo governor is always the 
best one.

Using the menu governor has also an impact on the user experience as it 
lags on mobile.

After studying the history of the menu governor few years ago, it 
appeared the menu governor was introduced before the SMP was widely 
used. The strength of the menu governor was the ability to find 
repeating intervals but with he multiplication of the cores, the IPIs 
were introduced which increased the entropy of the busy-idle cycles 
duration, thus making the duration much more random and altering the 
menu governor prediction accuracy.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

