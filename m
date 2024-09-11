Return-Path: <linux-pm+bounces-14046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9299C975A51
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2931F252F8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 18:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A12E13AA36;
	Wed, 11 Sep 2024 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHlaPI+C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967FA1AC89C;
	Wed, 11 Sep 2024 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079070; cv=none; b=Wxy0viSoZebgcK9LflNAlZd8W888GH19prQqxK27aIedBCLIY80mSJASiZwkDzJ4tZch2RIu7krOJSbNT6Lgdk91l4sFze/pbjtiyVmKlDrlnx2UKd9SYYcBIPcqjweI/b7j7/kQwrU9Z+Jb9ChKWPOSlXK0A/YzgitT627tUh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079070; c=relaxed/simple;
	bh=cvqiyYpTKj6QlDq2ScTGcOqG00swdPqmgk62cIeBpTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyAUhMFhJ3Tyjbov+XmMJdmLfDo8zMCWrsw95BAw1ljF4e2wnaeQ7xdTxtxR1KY4h173e5lxMwKJdM+31B03GHfQhMpkctKvnG7qI70KZAk/pkijWq8RH6aU61Um3AFnxXPXlwqqvEu1uUFIHGO3x/FG0DQYpgWHW4YGl21E65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHlaPI+C; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20688fbaeafso2353255ad.0;
        Wed, 11 Sep 2024 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726079068; x=1726683868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfIVDRWLb0U29G6Ld/L8UCYuhUrTw/kzrAPqO0NhGVg=;
        b=eHlaPI+CudYfBLlHbCgc/9e31kTQa79XczLn7NMaNARYvC9WdSB0kljI1s2Yn5WMMO
         YckvwlPiir4IQlMRWJIk/ahnLbVozMe+DrmOGUUi96/RzNFEX1v04cfXL9WgRw6SzWFk
         ShiZbITsTd87DyvzY1vAEBNyEt7cUI1oBBvVX4UF3+OeD3wYBaYMsK38z3PdBf44J/KE
         mW37V90PuImMBIhnwzJfoXcISYil5vgSrux6Cg+gof+8GOdiZZsguTjdSWHY8fsMXze3
         1KVBs/XcfKumXaFnit35HqBLeO94glIrUCF2K0vKcBlpxIF0diUoVEGfElyvrriR98L9
         TDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726079068; x=1726683868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfIVDRWLb0U29G6Ld/L8UCYuhUrTw/kzrAPqO0NhGVg=;
        b=kbQHcWFLoyFYMrLZHLavnkwHvYF7uSBRsicI3ZjP4ujV3APR8CG2QL8GKDSygOr9GI
         wrm8U2UstHxV1YWHeqdTUMwIS1Y0Qa4j38uGqu/2Y+EIWBX8/Cx3jEuqMEg9ULPxOF98
         Pt5NYKP2BrObaWVs1nbXGLwbdy60dY2RfkfzMA33NwKntN6gy39a0qM6Fn06xy1XPksG
         gTQYtAbPhI/fDKYBWIuTRE8C/mUyyrpi1mw0wmKp0VR0cxueWCVySmsj/0bzeUp5N+Ro
         pFuS7FvXXyLbAClIMh6gMg7Yip0YznsCjI9newZwS+c2y3sBVBXUEFs0MzOfKKyRS6J/
         aR/g==
X-Forwarded-Encrypted: i=1; AJvYcCU5u0e//QwiC3Izv67q7f3F1VHZK/n1dLZe0dO4+e9qy7m3JxlooqqxV4v/Q0IgQm9pWmNNXzx7Au/fGkAH@vger.kernel.org, AJvYcCUEyX5WeuBvpEShS/VFkWwsbapCsCLMnB1rfLaZbzojcKMTzC4VqAMo5PsmOJd4iVKQg6vzCIoOi50=@vger.kernel.org, AJvYcCUoLqgRnVxpNq8qL7UHvyjRvKIEeMlijoCxqT3IE48skLNV16PbZvAwdh3FtCh1KV+kGr6ByYPPMsHA7A==@vger.kernel.org, AJvYcCWTH3PcRI/SqTQjP0Rn0NdABAugsOQ3dXORJxSbEN4IjL8Xed3RsI+OiIReCjGQad9xVbir+qr9o2ox09t2X9A=@vger.kernel.org, AJvYcCXTOAp9B8A18GpiBnA6R9bMWeybyEwgPPSZ4fKXCA6aqNk0qVqRSrf8eXP+twxgOq4SpiqQW3bfVoL5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5bNHzZzEwsS3AqCj5OL7xAXFE6yf6gOYP+MW47p0E/INiOHv
	UEOXSxWM0vh5Fd8iODCbbCmLgDdLvUT78xdELaEaIUDPqSd1Ctzm
X-Google-Smtp-Source: AGHT+IHHxXX5UoA4CTDu4tCRimM4Z3eVy1fID6lUB3MJ7mTupdKsilagtwt1uZjUhm4aOyBQP08guA==
X-Received: by 2002:a17:903:41cb:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-2076e45ad89mr3273875ad.56.1726079067573;
        Wed, 11 Sep 2024 11:24:27 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9e12sm2443985ad.200.2024.09.11.11.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:24:27 -0700 (PDT)
Message-ID: <fae6aad7-de6a-49ba-acf4-e1aa93baad2e@gmail.com>
Date: Thu, 12 Sep 2024 02:24:22 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] dt-bindings: arm: apple: Add A7 devices
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
 <20240911084353.28888-7-towinchenmi@gmail.com>
 <20240911-similarly-paragraph-0ca7a1d566c3@spud>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20240911-similarly-paragraph-0ca7a1d566c3@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/9/2024 02:13, Conor Dooley wrote:
> On Wed, Sep 11, 2024 at 04:40:55PM +0800, Nick Chan wrote:
>> This adds the following apple,s5l8960x platforms:
>>
>> - iPhone 5s
>> - iPad Air (1)
>> - iPad Mini 2
>> - iPad Mini 3
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  .../devicetree/bindings/arm/apple.yaml        | 26 ++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
>> index 883fd67e3752..3c81008f0e96 100644
>> --- a/Documentation/devicetree/bindings/arm/apple.yaml
>> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
>> @@ -12,7 +12,14 @@ maintainers:
>>  description: |
>>    ARM platforms using SoCs designed by Apple Inc., branded "Apple Silicon".
>>  
>> -  This currently includes devices based on the "M1" SoC:
>> +  This currently includes devices based on the "A7" SoC:
>> +
>> +  - iPhone 5s
>> +  - iPad Air (1)
>> +  - iPad Mini 2
>> +  - iPad Mini 3
>> +
>> +  Devices based on the "M1" SoC:
>>  
>>    - Mac mini (M1, 2020)
>>    - MacBook Pro (13-inch, M1, 2020)
>> @@ -65,6 +72,23 @@ properties:
>>      const: "/"
>>    compatible:
>>      oneOf:
>> +      - description: Apple A7 SoC based platforms
>> +        items:
>> +          - enum:
>> +              - apple,j71  # iPad Air (Wi-Fi)
>> +              - apple,j72  # iPad Air (Cellular)
>> +              - apple,j73  # iPad Air (Cellular, China)
>> +              - apple,j85  # iPad mini 2 (Wi-Fi)
>> +              - apple,j85m # iPad mini 3 (Wi-Fi)
>> +              - apple,j86  # iPad mini 2 (Cellular)
>> +              - apple,j86m # iPad mini 3 (Cellular)
>> +              - apple,j87  # Apple iPad Mini 2 (Cellular, China)
>> +              - apple,j87m # Apple iPad Mini 3 (Cellular, China)
>> +              - apple,n51  # iPhone 5s (GSM)
>> +              - apple,n53  # iPhone 5s (LTE)
>> +          - const: apple,s5l8960x
> 
> Is the "x" here a wildcard?
No. This is part of the SoC ID. This is the legacy naming from when Apple
used Samsung SoCs for iPhones and iPods, and every SoC would have an ID
beginning with "s5l", and ending with a "x". Apple A7 is last SoC to use
this legacy naming scheme.

> 
>> +          - const: apple,arm-platform
>> +
>>        - description: Apple M1 SoC based platforms
>>          items:
>>            - enum:
>> -- 
>> 2.46.0
>>

Nick Chan


