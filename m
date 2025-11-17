Return-Path: <linux-pm+bounces-38131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2BAC64F60
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 16:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B8C94EDA94
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37193298CAF;
	Mon, 17 Nov 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COEwFccW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD0298CB2
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394495; cv=none; b=kYqcp2a+9gu0SRftI+nL+QzQ9m66JhL0/owlFZKbrMovAnrq39KPrY3HAZB5rYhgg6dKrwbfg9SKS366HqlRDMlcDD8AFzoWxnDcvDRnNZ3nAKkQtY3ja5iOqXWg9XKrb7Z7XPyFuXppbDaVvsCI2/87CUxlVSFLddtaJfuHiQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394495; c=relaxed/simple;
	bh=ROYTcX0lToNnERFrzzVSCpniaTAJj6i4Bcg2Nx6hBo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVz90+b7AUzDyr88Gn/35r3DmeTTpVa9Hz6PKEKNzJuJxQNgadJAsGSdF4xUuFYxcCHhCha7qY1p4+aVGT2a1h1+GxgXHx9efJTOTtmgzhuLhQtwsaLQqATUaX3m5ndY2V0elzimZkxTspJVMM0i+fc4euFPrMjkbdweUGC6HkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COEwFccW; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37902f130e1so35463331fa.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763394491; x=1763999291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/DUma0uZd8iCNzJFNlwxYelZvsQPcM9gT0Fu/UGP5Y=;
        b=COEwFccWnTSZZhfIMmxf9dxlSNeit2WGTrtffdB+zcsa5PeFEl+Ewx6wVLeYeTJf7I
         R8HNcH3LTQuaCYbIPHINb4jbHhK2d0Lcb/JGCjDkDm1BmoizG3cJf3PeJ5p0sVX8o3c/
         SdmOXYZIs6WAWS8jFVnPko0njBkg5sMY96DOL8ZuMirBrs+iBCYzkPva2BvkAfDsbBa5
         F6Dk2ClIzu1W0nE52d2rVOi6odN60iWsoii10RtMvpyJ00k3LKJMRQ7Sgrsh2XnV2EDV
         iSoqf0pODs+pklwWmxVhw1oaLenrRALUGhvA8jwUxZb5v3L87wZ+ZsH3DvSv01DFZW80
         koiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763394491; x=1763999291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/DUma0uZd8iCNzJFNlwxYelZvsQPcM9gT0Fu/UGP5Y=;
        b=Ju3cQGLdZX/26yKmvd4TNAsmg2xIAwTWK07JZxnoQZOz+GYiAZ6p/r4UjwTfZoTx0S
         jYB7XUw10T/vKHUuW/W5ViIYOLhboYpQkDGVj+J5+FViv3289jKFzSqwezpPja/W5OKs
         owM+oEF1xi8+1N4c5XBxmmxI7mhjvukK7ZnHAmsQT392XijoJ/iuxE3zgxwZBpe8Kpc3
         wSl8OlWnMv6ESIN8kDdHYI8b2Q3HdzVDlBwaU3KpOOEdKlXQC2xjsgmaJUls72DlGkYr
         rPmzLSrI+4YF+XW/yJbdA2VYwjDS99vMpUGMMJx8QMZN5XGkO6ltdr9XUtZ84cS+Z9Jf
         a1Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWfFtI1C0Vb3A6xg0iNH1Ug0BG5RKbj18dXmzR+rcpX745gS15HV7mDt79kBP41ttnUw58d4TsAOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNDgDJn0bjFLQYq+ECdrE5hrAo51YgM8pWtADgmFHGZgDX5S4
	AT8HikJ7B+3nFSe62f280Jx+inVejsNC123ZFi/y8GCfxqbwfeeNt9rF
X-Gm-Gg: ASbGncvffvcrveJMKQdYr2PhIt74WSaRf4N6Dvble+cNwFz+kDuh8MuD3BBOQ50U2Xu
	qQ7eEVg+oIqLDCXK6Bfzk/SjiIZUYGpGkN4yM4EYyOj/hn0RuaRf9PRVmBPJyiZ9j04+bme5H3Q
	zYHpzec44635SP7NhzUr7DTffuXX/mizyIxA/bPq+/KOwraIzD+2bUqzOFTeDjMogE/2XVROmiG
	XEST5CEipeZWYC5yaXOiyoIJVnSIZkLgxqj1h2ScKQRy58bVjwrPihhyxy1JeVNag4sf4M7W6xy
	TU7kY9n+BRD/weDkEqypzHmfeRInFGzFl1CWGooMBVLjFxSdoNBvGyCsR5MTt9A/4iP+mrU8/5P
	DpTq1/sDm0bM0cmZzULIxrT7lcArYQ49/xK4PJZi4xrRg+Crjt75NnJbz3jr39ieJL0sJLysCPw
	g7JMgw+aogIRvr2/rx1QWYhl9MqKqHgB91D7DfcPcunNAfXzMYxrDOFnf5Tw==
X-Google-Smtp-Source: AGHT+IEz1qxf+9MTduFUs5dbOjZ/dHS2S6pFFr0IgbhUuNlZhrUTtDy15iSqTT9lE0arzv+pzqRA9A==
X-Received: by 2002:a2e:b052:0:b0:37a:75c6:b44 with SMTP id 38308e7fff4ca-37babb47988mr26872821fa.3.1763394490823;
        Mon, 17 Nov 2025 07:48:10 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ce25408sm28328821fa.20.2025.11.17.07.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 07:48:10 -0800 (PST)
Message-ID: <52b99bf7-bfea-4cee-aa57-4c13e87eaa0d@gmail.com>
Date: Mon, 17 Nov 2025 17:48:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/16] dt-bindings: power: supply: BD72720 managed
 battery
To: Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sre@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 linux-leds@vger.kernel.org, Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org, Lee Jones <lee@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
 <ac5a4e992e4fb9c7bffb1e641a7cd61f74af4cba.1763022807.git.mazziesaccount@gmail.com>
 <176303119683.3716572.16868393928566655866.robh@kernel.org>
 <ee36d7d1-ef47-4a35-9aff-baa6ed32105a@gmail.com>
 <20251114163954.GA3399895-robh@kernel.org>
 <32303b95-3fd5-44c4-bb7d-e2957a6064fc@gmail.com>
 <20251117152341.GA1944698-robh@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251117152341.GA1944698-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/11/2025 17:23, Rob Herring wrote:
> On Mon, Nov 17, 2025 at 10:12:01AM +0200, Matti Vaittinen wrote:
>> On 14/11/2025 18:39, Rob Herring wrote:
>>> On Fri, Nov 14, 2025 at 11:04:27AM +0200, Matti Vaittinen wrote:
>>>> On 13/11/2025 12:53, Rob Herring (Arm) wrote:
>>>>>
>>>>> On Thu, 13 Nov 2025 10:52:19 +0200, Matti Vaittinen wrote:
>>>>>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> //snip
>>
>>>>

>> For VDR there are only:
>>
>> rohm,voltage-vdr-thresh-microvolt,
> 
> So "voltage voltage drop rate"? And '-microvolt' says this is voltage
> too. :)

Hm. Yes. This is a threshold voltage for applying the "zero-correction" 
algorithm, which uses these "VDR" (a.k.a voltage drop rate) tables. Eg, 
the algorithm should only used for the correction when battery voltage 
drops below this threshold. AFAICS, this is usually designed to be 
slightly higher than the voltage where the system stays still operable. 
I suppose this could also be "zero-correction-threshold", but this would 
introduce another "buzzword".

>> rohm,volt-drop-soc-bp,
>> rohm,volt-drop-temperatures-millicelsius
>>
>> and
>>
>> patternProperties:
>>    '^rohm,volt-drop-[0-9]-microvolt':
>>
>> So, from the binding point of view (.yaml), it's not _that_ lot. In the .dts
>> there will be quite some noise as the tables have several values.
>>
>>
>>> If that
>>> happens, either we are doing a poor job of generically describing
>>> battery parameters or chargers and batteries are tightly coupled and
>>> can't be described independently.
>>
>> I am under impression that chargers tend to be pretty flexible, and they can
>> be configured to work with many different batteries by altering the charging
>> profiles. Most of the battery properties (like and charging phases [like
>> pre, CC, CV], their limits, currents and voltages etc) are very generally
>> usable. So, large subset of charging functionality can be handled with
>> standard properties. I believe it is only the fuel-gauging where things get
>> more hairy.
>>
>> I did prepare a series which does the split and adds new compatible for the
>> 'rohm,vdr-battery'. (The power-supply class is not yet modified in the
>> series, but we would probably want to modify the battery-info getters to
>> also accept the 'rohm,vdr-battery' -compatible.)
> 
> I don't think that's the right direction. It's not a Rohm battery.
> 
>> I wonder if I should actually prepare also a series where these properties
>> are just placed in the existing static battery node without adding new
>> compatible. That way it would be easier to see which way is better.
> 
> That seems like the right thing to do here.
> 
> The main question for me is whether these should even be Rohm specific?
> That would probably require a 2nd user to answer for sure.
> 

This is a question Linus W asked as well :)
I believe this technique could be applied to other batteries. I, 
however, am not aware of any other than ROHM charger drivers which 
implement the algorithm. Furthermore, I was told that the mechanism to 
measure these "VDR-tables" for batteries is one of those things which 
should be "kept under your hat". I think ROHM has also patented some 
stuff related to that. Hence I prefixed these tables by "rohm,".

I have no strong objections to dropping the "rohm," though - but I doubt 
these tables will be heavily used by any other but ROHM chargers.

>> If I do that, should I only spin these bindings as RFC to avoid the
>> unnecessary noise?
> 
> Only if you think something is not complete and/or the patches should
> not be applied.

Oh, Ok. Then I will send only one of the approaches - probably the one 
where properties are added to the simple-battery.

Thanks for all the support!

Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

