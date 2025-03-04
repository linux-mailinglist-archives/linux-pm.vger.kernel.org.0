Return-Path: <linux-pm+bounces-23367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F9CA4E0DA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FDB178BEF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7643205E34;
	Tue,  4 Mar 2025 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/Kb52GX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE62063F0
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098277; cv=none; b=oTVA/OyMH6hCzGp/5EMlZ4b5rewkOSH7FI4A9J+wXT6HN6kVo0YYVVhE28saZxwfMfqpfuOVh74oz81GC0oVfrp5qaokwAinwmYqKY4L1xukPWiBDM2yhNHjmWyjQ7D+Zkuv8VXfP1Ii6ShYfXIYjuKgVoyRJNWKL7wbvThgIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098277; c=relaxed/simple;
	bh=3ZzzgJRoOQWaG7inXe75TBdfo18aiMq4hX11zKK9ysU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzgSKVeVb7PaFpbGTWPxtX4bQd/sLzeG4oX5ukBpp8tZ2GkpolZLym/IXLikEMbEL5WQMwO5R6WiwnVMJ+nrHZAuAIceOIH1ztcnrzbSAgsG1nA12YGD0KNEYQ6X1UcZ6HZoRb/xUiEgPpo4dm1yYNU1BqZi6gqNErpW1boMfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B/Kb52GX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bca8cabc8so1656425e9.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Mar 2025 06:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741098273; x=1741703073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KTwOJrqmamZnp6Bot/ZyUgvSrbVR9/Qa0k7QMOX2SR4=;
        b=B/Kb52GXl7MMPrBhyfuqFrAC91xpEwhKwEs7H+OPx99bPmawFhuN9grChrbMp0qdr8
         qqjzD6kjA9Ts5IhTr1aic8+LdOkh5DxQwJdRmelotdRujS+fTbIP8JBGhRvO19FFe0I1
         b4swvsPeP2nCNR6kDaec7fCaDokyuLmYu1oGEOJcPo1uynJPZSeid1NENCZrhu5LIiiJ
         pcbej9M8OzCCr+7tPUFVdB4WiScL6t3LEL72jI0W/LV+GTUbk3bRqLOkqZRRYMe5GMds
         ahE2bv8xQKE9dt1RYQTM4CbpNwTgwSmaB3oheHTUDC+7gy9RFzKccNckxFBn7wBMj0Kw
         FELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098273; x=1741703073;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTwOJrqmamZnp6Bot/ZyUgvSrbVR9/Qa0k7QMOX2SR4=;
        b=MIDhpCX9SXuV6h7+u9PXEqDNZYxW1kpDYwLVLh6r7wJWr5Wz6TkDqY5qXBku4RRjar
         QDn3M+Eggo40pp6Qkc3U6WjVjNoK+YW3E1F/uwIUWoIs2y8ocA4RmDgSMnZnyjv0lBNk
         CZcGUb0FCuL/9e1bL2PTps6ds3Nitq5rmvYzygAAhs2HHukzOO2XrlbwOM5kjy4fguXP
         CmTtQYuurO69pZV6ebuJbs5QtrYl8AKljx6TVN+0GiW22j3iJcdi81HpNAcz1DbJFps8
         o1NVHUbhobOa5uUUnbYtBQZvJ7iVXwsjN/FdYdWbHk/dASutyLwAg7F0ivX30+jyiHY2
         rKXQ==
X-Gm-Message-State: AOJu0YxrDrsxPjrDwsM8NaqU4mrFAtICx6ybo8/6WhhnJVYRsFACLwJC
	cVmTAGvyEF288ghTIChPnGA2Ap/3E4mEA9IsO6bzHGiBvNVdgl/iuGCQIrSqGMY=
X-Gm-Gg: ASbGncufFpBlOuSln7XxcVFPu5HvlVM3LplgZwMPQuXm5maUlkAvY13WhpTKrC+lE+9
	U+iTnpFfUQtW8LmumeEF7juyHgjIyoo3kfc+/HKSgK1dCRNBL/kYtHtnB3PpFC/L66SpyEVAtLm
	kNrZoKyOzG/3G5oglBIm/Lp8COeauRvveSQ5KBbQ/T4MJyRcAY0ZsdU2+/ztU++ecB2F4XHs6MN
	opW0tghKbu9Eb6YIC20aIA0Il/xbNj9SvZ716gOJ5UsNbtIZD/qsoErRomuRyQU+ECtQCe8filP
	h6CP+ChIXwnmyqJ2BAxtu8DLbS13rzWhpVn5D9KhCFmwkllkPnKZYfp4AGV7p0uv
X-Google-Smtp-Source: AGHT+IFj9ezRvL/GLf1WAnJfc8xPWJf43URunIbh41dUWBZ8qbLw/49jjj+OZEUxoVFQ7GuZnOV0Tw==
X-Received: by 2002:a05:600c:1c1c:b0:439:9a5a:d3bb with SMTP id 5b1f17b1804b1-43bcb9314b0mr10869245e9.2.1741098273370;
        Tue, 04 Mar 2025 06:24:33 -0800 (PST)
Received: from [192.168.1.20] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28b285sm200979005e9.33.2025.03.04.06.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 06:24:32 -0800 (PST)
Message-ID: <31806087-fbe3-4631-9de7-7eb48955cf4e@linaro.org>
Date: Tue, 4 Mar 2025 15:24:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] dt-bindings: firmware: thead,th1520: Add support
 for firmware node
To: Michal Wilczynski <m.wilczynski@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, jszhang@kernel.org, ulf.hansson@linaro.org,
 m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20250303145901.446791-1-m.wilczynski@samsung.com>
 <CGME20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f@eucas1p1.samsung.com>
 <20250303145901.446791-2-m.wilczynski@samsung.com>
 <edb3dd6e-8b56-42b3-8bb2-8ed7ad186b75@kernel.org>
 <8dcdd2ec-e4b6-4fc0-be50-12fe187cd5e0@kernel.org>
 <99fcf36f-7fed-43e8-a94f-47563ab00fc6@samsung.com>
 <377951ad-341f-4e19-a582-a534567dc466@kernel.org>
 <08e5ffb9-2187-42b6-8090-9922b349fe2a@samsung.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <08e5ffb9-2187-42b6-8090-9922b349fe2a@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2025 08:52, Michal Wilczynski wrote:
> 
> 
> On 3/4/25 08:45, Krzysztof Kozlowski wrote:
>> On 04/03/2025 08:43, Michal Wilczynski wrote:
>>>
>>>
>>> On 3/3/25 18:46, Krzysztof Kozlowski wrote:
>>>> On 03/03/2025 18:42, Krzysztof Kozlowski wrote:
>>>>> On 03/03/2025 15:58, Michal Wilczynski wrote:
>>>>>> The kernel communicates with the E902 core through the mailbox
>>>>>> transport using AON firmware protocol. Add dt-bindings to document it
>>>>>> the dt node.
>>>>>>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>
>>>>>
>>>>> How is this possible? That's v1 and I never review outside of mailing list.
>>>>>
>>>> OK, I found v5:
>>>> https://lore.kernel.org/all/20250219140239.1378758-4-m.wilczynski@samsung.com/
>>>>
>>>> so is this the same?
>>>
>>> Yeah, I thought by splitting the patchset and creating new sub-series I
>>> should start versioning from v1 again, and leave that bigger patchset as
>>
>> What was unclear in my "keep versioning and keep changelog"? How this
>> can lead to "start new versioning"?
> 
> OK, my bad misunderstood you. I don't want to spam too much so maybe I
> should wait if there will be any comments before re-sending with the proper
> changelog and version.

Just provide changelog as response to your cover letter.

Best regards,
Krzysztof

