Return-Path: <linux-pm+bounces-14048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E110975A74
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 20:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8461C22C44
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2A81B6558;
	Wed, 11 Sep 2024 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+1qFSI4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574F1B4C4A;
	Wed, 11 Sep 2024 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080017; cv=none; b=azb1fPFHMhCXn6i+Hhoa/8TtOROJf96a81M3o3naD7qphNAeWo+2FiyuXlEXhgrVQJBcp7bB1mfU8zzmV/xKw7Of1QvKz72ENMEqVB2SwMl+F13KdUHi8aXjtLJfALI+5XeR2ByAgvKxvT+6F8oif5lZRrrSsazPn1xXl67eYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080017; c=relaxed/simple;
	bh=7LZvl8bR4J5JCUKcVqkF7fXZODe/gIENMVevu9s2WTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGNGNr23lMluykWlotnEvrIH0y20lBhloBYT4OuNgStHQON2moV6rAq84oPw0B5NBbh6xd3br7qmXY+lT8oXokKCn4sToSjizhIA77XWaQFVt2X6zx8h4bcYcAnhZpB1nMZwtA4mYkMeQJpZOZ5qLrSiudD/H3n3eLKL30LYHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+1qFSI4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c1324be8easo917217a12.1;
        Wed, 11 Sep 2024 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726080015; x=1726684815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+7p3Z5qCC26Ye8mLVaKGA4gMsf3x0zTnnTmPLOwPnE=;
        b=i+1qFSI4gY676GNwveSu4V7ORnz6yXZTmQvdx4cK/sXoBOyrCHdXukbiV3+iGF2vCx
         JtvB6a7ixrfy51KZAqH8HUBw/B5dfnYl7r/F6/zOsrudO7JyO8YvXZiWGZbZlcQbM8RZ
         S1qNC8blUoQsJei5UK9ykRQCjjSJfhbgdKlPR8G6YbtGWZvdNwltGDuNG+zBBreiYlDe
         G5x8L51uS+vM+qX6XyGoFZTg291f4InaoYaQVeyPGmUii+vUCmt1rKDUXBHbMO8uje+9
         d0Q7gGDZ8Hby/J4J1Dcw6xG8LyaA9V5F2Dulb1ckJ9H4BQyp7UnUVsp5NO/Cp5KtDf/D
         KPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726080015; x=1726684815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+7p3Z5qCC26Ye8mLVaKGA4gMsf3x0zTnnTmPLOwPnE=;
        b=Zfyvxo0sGUxiKe6cxz0deVm9SixlrdwFhIZuKqFO4uNyTAF/ZBl+27cl5w8Bsga7m/
         EXBK3BbOnxcs05Wj91NBLb6QqY9Y5u3HOpgG5mvMNxxaoFG/1L42kDthFplRcF2yjKbd
         hzCss07Pi2mbcRoWXJFmmw1flcu3L7YqvfBMCN1rMkeAtkS/kcYOnMaqJmEDRTIUl8cs
         kLKcnkOx4vVrosq269ifxAKIKK9o01grbyOG5QSJ9RT1NsUNTd1Pq8piao4maoRCKrCn
         bqNMI99IOGg5zJl49RFV1V/Uqm7I0U7w9Pp9GEBFusd0FkVGDKOgbK5rTNor6aQbe69m
         QJMg==
X-Forwarded-Encrypted: i=1; AJvYcCUae9TUCIjPUVHo0W+pcGMOvZYWPVQyTL3vZE/SdCO3JxBFW4Tm/WHndgIoqHnI3FnkNzaiqbGSD3UQ5UBK@vger.kernel.org, AJvYcCVIBKvGTTtxziesPcP9FJ2pXlKSq/rw9UQ1655mtrf5npn/f+t/iFOGVqj1InupdLfBsg18YigqfW8=@vger.kernel.org, AJvYcCVdQhGNLQ2uv5rcGD5winkTVSPovPuKHL/NRAzt4x2P76HVFEa7mc/CGNzeuHGTNddGGeubfCBC2Cks6AfWWaQ=@vger.kernel.org, AJvYcCVuaxwKtkPVJsQVI0oMDs2sHNWZvGHfNTHhHtD85KI+FqQDAxsQpjDVIa/ZfrQkk/dQ0ZoozYuoEIQJ@vger.kernel.org, AJvYcCXIcYvrXZD+wseqhNiZ3kmfV49P14JOqYyVsApwyTCznGW4HH+rz5U1JUkTePqnYJ4Duac4RnEE0569xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zFRjcrTw9/c8GA1H0F3AmgiseC6zEhNOVcUsPHjGW/v3IHqO
	Zb7diNYCfInhlOHcfnf9PT3P4udcM1SMvTxcYs6vRBOyauHRZ83z
X-Google-Smtp-Source: AGHT+IGWNpBp0JEJJKNe7VJxVt4ola9QUy4T9WHvT1vG5vjPcbQJy+069xnc1aIkGvbTJudOOVEgTw==
X-Received: by 2002:a17:902:e80f:b0:205:5f95:c283 with SMTP id d9443c01a7336-2074c5d28d9mr77798925ad.4.1726080014877;
        Wed, 11 Sep 2024 11:40:14 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b039539sm2541905ad.309.2024.09.11.11.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:40:14 -0700 (PDT)
Message-ID: <a3849bc0-000a-4290-b2c3-71a50a750495@gmail.com>
Date: Thu, 12 Sep 2024 02:40:09 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] dt-bindings: arm: cpus: Add Apple A7-A11 CPU cores
Content-Language: en-MW
To: Conor Dooley <conor@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>,
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
 <20240911084353.28888-3-towinchenmi@gmail.com>
 <20240911-unsuited-pranker-60a7d0b6caf9@spud>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20240911-unsuited-pranker-60a7d0b6caf9@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/9/2024 02:16, Conor Dooley wrote:
> On Wed, Sep 11, 2024 at 04:40:51PM +0800, Nick Chan wrote:
>> Add the following CPU cores:
>>
>> - apple,cyclone: A7 cores
>> - apple,typhoon: A8 cores
>> - apple,twister: A9 cores
>> - apple,hurricane-zephyr: A10 logical cores
>> - apple,monsoon: A11 performance cores
>> - apple,mistral: A11 efficiency cores
>>
>> In the Apple A10, there are physical performance-efficiency cores that
>> forms logical cores to software depending on the current p-state, and
>> only one type of core may be active at one time.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
>> index f308ff6c3532..3959e022079f 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
>> @@ -89,6 +89,12 @@ properties:
>>        - apple,blizzard
>>        - apple,icestorm
>>        - apple,firestorm
>> +      - apple,mistral
>> +      - apple,monsoon
>> +      - apple,hurricane-zephyr
>> +      - apple,twister
>> +      - apple,typhoon
>> +      - apple,cyclone
> 
> Same on this one, can you add these in alphanumerical order, even if the
> existing 3 devices are not in it? You could take the opportunity to
> reshuffle icestorm and firestorm while you're at it.
(Same goes for the watchdog, pinctrl and cluster-cpufreq bindings)
I am not actually sure what is the right thing to do here. It seems that
these bindings are
originally sorted using SoC types (desktop or mobile) and generations.
But then again I have
looked at some other in-tree bindings from asahi, and it seems to be a
mix of alphabetical
and logical sorting in the way mentioned above.

Maybe we can get some clarification from an Asahi Maintainer?

For the soc-level machine compatibles though, I believe that should be
retaining the logical
order instead of trying to use alphabetical order.

> 
> Cheers,
> Conor.
> 
>>        - arm,arm710t
>>        - arm,arm720t
>>        - arm,arm740t
>> -- 
>> 2.46.0
>>

Nick Chan


