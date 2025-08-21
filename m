Return-Path: <linux-pm+bounces-32764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7F8B2ED99
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 07:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B757B19C2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FF6194124;
	Thu, 21 Aug 2025 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="my1DS10T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5117BA3;
	Thu, 21 Aug 2025 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755754274; cv=none; b=Em1NrHs9dp7qgbYwfQu/oW29yVoAk3dPogGiL59a/x8mPVcHpty7Kg14dcsHV4rfW+U6RwxEIiECf0dkcviJZwTWz/Pi8ENej5vo+WQfoJj0UqDpmEk4ELpzWISvr8h0+GZxR6ioAJ2UueneAf/mElFD52PuthnXsdvHjSZkuZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755754274; c=relaxed/simple;
	bh=ByOwWFgENBglSn1IxGsaorQ+VuWdxYOizN6UpvpUOc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxFfd9tPnp7tWAL/GumxqsLdfDGs9BJ5AT6smBYt+/ULpI5cPt4r0252nCnv2QQYVKkt0ZBNIkZoVDI+EDnT5Elj/Bq3uHPpyY0QFSg8E3INW0itH5j3TqY38V/cCfPx3NTypM2Ad1fC7lmw+dEk75azOXuQ8KEJI+SeDJqxX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=my1DS10T; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55ce526627dso548758e87.3;
        Wed, 20 Aug 2025 22:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755754269; x=1756359069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHzzL5gL+xatIzyNdHGCqo8FCwnQF4KH0Erk1MDNyww=;
        b=my1DS10TtNVuNqdUvcs5zs7ujsdfXloodNLJ5YVr4Fpda8gb9Z68foAWTYUQGkL9d0
         vVe+vpVIOcabyg4xYx11/C2C8l2GoOd7AepVJlLqeehrEUGZjez54GT9f7XdksQ7sDSk
         tJBSG6UDzmjYh9d4pdAQ/qt6JsdsblK5hZDwAUNXGpioIB0zSSwqTsRImfTQuFQne5T9
         GIh0QoVn3Mtvrtl50vdrLPC0VT7qq59CSC9p2S6bzYy9bTUfDm78c4avP+GKPX+mQ3DD
         uNaCBbF+Llr4qn8RJYaT+f+O08arvSFExKIaWR8v+A+AA/jp2J8GkiTjK+N8kEwGki5k
         DcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755754269; x=1756359069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHzzL5gL+xatIzyNdHGCqo8FCwnQF4KH0Erk1MDNyww=;
        b=BBJG8vq1n7n/PbxItAnJ3IkAf2sHkXsMCeJVQDZWv1BEBijUCxbcISf//yrSNMMUGi
         v0exoy2/vzTvsFypO9Ivh5P/rmawuq63a8K+tlpD7afzGXv/ulb6Ew6RwF59lFAb9UQ1
         fWpGEOA2I/6Ejq3VXJckE/o/0+zUE3SjYbWCZzrlpmDjAhlFAq/NyzWloYAxJ7IScHn7
         0PsiWy1QWqSkX6P9VB0mSw+U4NroTTkgvY2PwlH2oIxCzxnnu+o0O/6pLHRQs7GC83Nq
         /7fQlORFNy2+dGVpgfFOVE2FkcbU25p8hae7dongnTsHLFmlFgyBG2B/M+c3CkQZgC6o
         J+qA==
X-Forwarded-Encrypted: i=1; AJvYcCUs2xl2yVIrx5APjvTwVOQ0FBuWuNW/crNf/FeBTBLyo8CslLRNS0R8/npGr8CXwouv571WEpQKNL7JMes=@vger.kernel.org, AJvYcCWX3aLRsHx9zR/cmKYf3sQlZPG+cmbwuj2Is8cJc2UA8LBceoAkLDMgSVK0nUhhwOVxEKARJOOoKyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIGQCdF8Tal6RO57Pltll9J04PZJmODAg6GuYSWNEv3LyTV8P
	HWe+m1AHKetbOvlgOG36lDOoA78sJ0vFiS83SLND1pDqVAps1Og50ozd0Qrd9w==
X-Gm-Gg: ASbGnctlP5VE5LwNy2FlNG0eJoA7JpEcmQJe7rDK+kagXFN24SKfLnVwnZ3r5Euyux2
	nMX8P0BS0EZ7GiWFrAqyMrDMu37wBV2j+Bw98to9YXP3qtrzVaj8sXya1jorjduZWbGwgMa1fj3
	QmIGkM0+nIWUz78jXN3I4G7+FkcNatx4o5NTptuwr/z605WKb1gtRoJ396FMqWVUf5nQ0yxGeXq
	0IzI4bepY+UAZJu3cq/R1jaw2v3dVqKfYCGL1Z1x8/EnJ3PkvbOw7S1zd47+LjCTvULvXEtvQZ3
	vpwCg40jaEfbLDqamdQY3Ue059Q1n7T9wJydspozFyMh7Z6PKrjpiYWlnrx3LC4tkCvDIhVIvr2
	mCAjDz9fOBAAiuMe3AV2i8k+8q/if0jGUbrOKTWLjRkeb01ysvx7YE1JMoGqrmu4H4qA6Ltbv83
	069erS2LMABnpVoA==
X-Google-Smtp-Source: AGHT+IFyeIy9FFIAXwuDAznoL/SIDjDlRRvkrsvn2dYShpqionzXRW82OUT5sJM0CNz4zb8SbI66qQ==
X-Received: by 2002:a05:6512:3d22:b0:553:abe6:e3e7 with SMTP id 2adb3069b0e04-55e0d5b2e63mr440922e87.47.1755754268330;
        Wed, 20 Aug 2025 22:31:08 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cca00sm2972147e87.93.2025.08.20.22.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 22:31:07 -0700 (PDT)
Message-ID: <dc2a9ea1-29fd-4ae8-b414-ca3acb0d8ad3@gmail.com>
Date: Thu, 21 Aug 2025 08:31:06 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
 <20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
 <bf82cd81-bcc7-4929-aa84-b749533d5b95@kernel.org>
 <20250817101121.19a86716@akair>
 <bbd17f22-8834-42d8-a109-971bdd2e0fa1@kernel.org>
 <e8955365-73c0-4c7a-a579-0ee6940340b2@gmail.com>
 <20250818103600.0c3a015d@akair>
 <3dd9aa2d-a318-4a94-b53f-11dac139ccb2@gmail.com>
 <20250820180523.170acbea@akair>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250820180523.170acbea@akair>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2025 19:05, Andreas Kemnade wrote:
> Am Mon, 18 Aug 2025 12:32:43 +0300
> schrieb Matti Vaittinen <mazziesaccount@gmail.com>:
> 
>>> Kobo kernels have these tables as part of the driver, the right one is
>>> selected via an index in the NTX_HWCONFIG blob provided by the
>>> bootloader to the kernel. So that is not necessarily a problem. It
>>> could be translated into dt.
>>>
>>> static int ocv_table_28_PR284983N[23] = {
>>>           //4200000, 4162288, 4110762, 4066502, 4025265, 3988454, 3955695, 3926323, 3900244, 3876035, 3834038, 3809386, 3794093, 3782718, 3774483, 3768044, 3748158, 3728750, 3704388, 3675577, 3650676, 3463852, 2768530
>>>           4200000, 4166349, 4114949, 4072016, 4031575, 3995353, 3963956, 3935650, 3910161, 3883395, 3845310, 3817535, 3801354, 3789708, 3781393, 3774994, 3765230, 3749035, 3726707, 3699147, 3671953, 3607301, 3148394
>>> };
>>>
>>> static int vdr_table_h_28_PR284983N[23] = {
>>>           //100, 100, 101, 101, 102, 102, 103, 103, 104, 104, 105, 106, 106, 107, 107, 108, 108, 109, 110, 112, 124, 157, 786
>>>           100, 100, 101, 102, 102, 105, 106, 107, 112, 108, 108, 105, 105, 108, 110, 110, 110, 111, 112, 114, 120, 131, 620
>>> };
>>>
>>> static int vdr_table_m_28_PR284983N[23] = {
>>>           //100, 100, 101, 101, 102, 102, 103, 103, 104, 104, 105, 102, 100, 100, 102, 103, 103, 105, 108, 112, 124, 157, 586
>>>           100, 100, 103, 106, 110, 114, 115, 119, 122, 122, 115, 113, 112, 114, 117, 124, 126, 123, 122, 126, 140, 156, 558
>>> };
>>>
>>> static int vdr_table_l_28_PR284983N[23] = {
>>>           //100, 100, 103, 105, 110, 110, 113, 112, 112, 112, 105, 110, 110, 111, 122, 131, 138, 143, 150, 166, 242, 354, 357
>>>           100, 100, 105, 110, 114, 117, 121, 125, 126, 122, 116, 114, 115, 118, 124, 132, 140, 148, 156, 170, 210, 355, 579
>>> };
>>>
>>> static int vdr_table_vl_28_PR284983N[23] = {
>>>           //100, 100, 103, 106, 108, 111, 114, 117, 118, 115, 108, 106, 108, 113, 115, 114, 118, 125, 144, 159, 204, 361, 874
>>>           100, 100, 109, 115, 118, 123, 127, 130, 140, 139, 134, 130, 128, 138, 140, 150, 154, 164, 178, 204, 271, 362, 352
>>> };
>>
>> Oh, good. If we can get the right battery parameters from the vendor
>> driver, then the main problem gets solved. Although, multiple sets of
>> different VDR tables probably means, that there are variants with
>> different types of battery out there. I assume the bootloader can
>> somehow detect the battery type to provide the correct blob?
> 
> Historically the Kobo devices ship said HWCONFIG blob apparently to use
> the same kernel on multiple devices, then devicetree was invented and
> used what was available. There is then a
>                  switch(gptHWCFG->m_val.bBattery) {
> ...
>                                  ocv_table_default =
>                                  ocv_table_28_PR284983N;
> 
> 
> 
> So that all only means there
> are several different batteries amoung the devices supported by that
> kernel.

Ah. So you believe the other batteries are used on other devices which 
run the same kernel. Makes sense.

> From my guts feeling I wonder if the is_relaxed stuff is
> properly working and I wonder whether a Kalman filter would give better
> results, but that is all something for the future.

I believe your experience is stronger than mine (also) here :) I don't 
really know the theory behind the 'relaxed battery' (or much of other 
battery chemistry stuff). I was merely trusting the inventions of the HQ 
engineers, who told me that the OCV tables can be used to adjust the 
coulomb counter when the battery is 'relaxed'. 'Relaxed' here meaning 
that it has not been charged (or a lot of current has not been drawn 
from it) recently. AFAIR, most of the PMIC models had some hardware 
support for detecting if the battery is in 'relaxed' state.

I admit it sounds like somewhat uncertain approach. I'd love to hear how 
you think the filter would help. I suppose you think of applying some 
filtering to the CC correction? Eg, 'smoothen' the CC resetting based on 
relaxed OCV, by applying some filtering to the correction values? Sounds 
cool! But... It does also sound the analysis about the impact of the 
filtering will be hard.

The reason why I dropped the simple-gauge RFC is, that I don't even have 
a BD71828 which is connected to a battery (and even with that the 
testing would be hard and slow). I thought of trying to do some 
simulation, but even that felt quite futile without some proper 
battery-data. So, my work was largely just shooting blindly and 
listening if some customer started screaming so loud it could be heard 
in Finland ^_^;

I think the "ideology" of the fuel-gauging in the HQ was to accept some 
of the errors and trust the VDR table based zero-correction to fix 
things when battery was about to get empty. The thinking was that more 
accurate battery status gets important only when the battery is getting 
exhausted - and that's when the zero-correction kicks in.

Yours,
	-- Matti

