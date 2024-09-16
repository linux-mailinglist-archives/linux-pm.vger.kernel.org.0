Return-Path: <linux-pm+bounces-14342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0097A481
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 16:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B411F21923
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58960158DC3;
	Mon, 16 Sep 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsH3YxVx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2EF158DC2;
	Mon, 16 Sep 2024 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498345; cv=none; b=RLsc/0TfLmqWSfwGGk5K5xFiB/djVqqgG3zwqQxAvD1zzelPevyXt0SjQFJOoJ2Zgl0zJ7qP2eGfd/2lfJdkzZWKq9+bddvfif1XvSVvEX+bpWpfDeh9wxv9woclHY7iV/APlFY46EegJyTbSLqAwhQebHyaP+pxkMTkEgqQSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498345; c=relaxed/simple;
	bh=RhkHx3KEvVHKaUXYhsthTx+OT78125g8JMWGtokDp6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yl1vNUcsQ0wVz5UQVNbs5cCdQfWgfSQSXij7BtXc53AU+zoScwZOZJall90/sMYjXW3XLqMbamnSdu+VjD8aYxlW97TDZX46SBCGRil2TJuXP/YnyTZiYKC3Nd3rbLWgBwX5N3skIHYty82tFX5PyYzXv1OVED11sOkglJ23ODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsH3YxVx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-205909afad3so46883735ad.2;
        Mon, 16 Sep 2024 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726498343; x=1727103143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7O8aY6B3ufOpgcpOy0X8Q8VSRJdIp5sZRAiS7dUBXy4=;
        b=QsH3YxVxlB6fCbf842CQqkrx/5SPKc/QVGsVCf0Q7d0UoessYshDtkUXg7E5JsSFUv
         xodhm9loq5J88QQWdB2R9JPqa0OuB2ZB/viKJx+9X4nN69i7ChQdxwaM9suX+Kn4b28x
         75f9Qg3PFQdkxYbfxcOVDwKn5J99wTntyfktRGpb7SmfeYHcX39sAukIfBBlCfXsrAJV
         gYIW1PKuTo0hQFykFOHIl5Jc5/zXTwffFt5mqUSQaFmTLjAlApZjEHK2u27P8/Z7W/6f
         oqMoIHmKL6+1bWuP7BbvQ+RZnzw1UGZHY5x8H+ClmnyBCjby4tZ/EuCxFcq71ZQJmLup
         ydnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726498343; x=1727103143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7O8aY6B3ufOpgcpOy0X8Q8VSRJdIp5sZRAiS7dUBXy4=;
        b=M1oa0nLf1jBoEHIERtL95Te44NjeZAIEUqIbwPw0TpIWBeGBzG4FLQX/0JsezHO+94
         d+xSaqpFbh/1Y1lwhIiyaHDx1UCwrhZSA+pzywhMW6NFzKx09AIlTZDPmLbb9uusKJNI
         H3pK9uldBuzZBbr4f/dT1EeJ/zEIkUbjFJ9jIbomN7imBZMdouzFKvZ7lb2SSF1Spa1o
         0f8mdMKdJMpvpPwv+RNickVawkqZvf6jgQy1rKNblabMUBmkGLxjONFrfOo1pk7bvPBD
         qZEsY3Di0HuzJIR3bM0epWRQUwHC+4VVY3k/fR4u7NQybR6JLxy1OKq+0W7qy/2G0CIA
         9lEg==
X-Forwarded-Encrypted: i=1; AJvYcCUV0Ukm5cS4Tq9bPJe/uIf7B58LohQ7HKYhaQxhJjb0tAqAkME98hVfiWd7MF081Xs7SuAlElfFSv3Q/XiJ@vger.kernel.org, AJvYcCUj7/LuMAuJqFq+B05USoOCkRKo55/p0OK9UCeOZ6FhenaVgLjQOHoa7Wk8cQduWCiK0Cpwz0ZMiLg4jPU2gOM=@vger.kernel.org, AJvYcCUpp0FMdEL161MXVj/Orc8UluNrcPfrv6dDnbg9VdxONUVfuyb8i57tLT82t7F0AXFbvHg56sKsswo=@vger.kernel.org, AJvYcCXA23rVEugU6+3MCYx433GPMYaN9pW4PVr1qrfZAHhAspoNX/zB+X2pnOczk4KVcvuuN6H+ZgO/mlqx@vger.kernel.org, AJvYcCXyOQl2ZshFjM5L+VRnTZ7+HJ/8i3bh4y+h3W06e7U2ZVRWdqumXKtVoeXjH3fSJLyDHssUgA7WAxZSjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCxypgojy9q6n89PiTtXomThz+qOjyZ643BIV32s9H9WqztH5
	GIfH54zg2D4zPPCCMR6OBPFa88XkZB28LNp3FB4aSIMKWk0WRLPA
X-Google-Smtp-Source: AGHT+IHtQAbZITE1JFKfdxFWo2AvjAaAUQc9iG32G/Pn0bWjgrwustAbaqgNo9r+B5kDEpyamDKB/g==
X-Received: by 2002:a17:903:32c7:b0:207:2697:da17 with SMTP id d9443c01a7336-2076e355eb2mr225599265ad.23.1726498342899;
        Mon, 16 Sep 2024 07:52:22 -0700 (PDT)
Received: from [172.20.10.2] ([182.153.8.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601022sm37092445ad.74.2024.09.16.07.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 07:52:22 -0700 (PDT)
Message-ID: <a7f2c1fd-bd50-4d04-a2da-67bda6f7d55c@gmail.com>
Date: Mon, 16 Sep 2024 22:52:15 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/20] arm64: dts: apple: Add A10X devices
To: Krzysztof Kozlowski <krzk@kernel.org>
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
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20240915080733.3565-1-towinchenmi@gmail.com>
 <20240915080733.3565-19-towinchenmi@gmail.com>
 <ntl53bla2qwueycbffta5ytmmm7hxrthbfz2677mltldgu6roi@3f3pz6644vb5>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <ntl53bla2qwueycbffta5ytmmm7hxrthbfz2677mltldgu6roi@3f3pz6644vb5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/9/2024 22:39, Krzysztof Kozlowski wrote:
> On Sun, Sep 15, 2024 at 03:59:03PM +0800, Nick Chan wrote:
>> From: Konrad Dybcio <konradybcio@kernel.org>
>>
>> Add DTS files for the A10X SoC and the following devices based on it:
>>
>> - Apple TV 4K
>> - iPad Pro (2nd Generation) (10.5 Inch)
>> - iPad Pro (2nd Generation) (12.9 Inch)
>>
>> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
>> [Nick: SMP, m1n1 and Apple TV 4K support, uart interrupt and pinctrl fixes]
>> Co-developed-by: Nick Chan <towinchenmi@gmail.com>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  .../devicetree/bindings/arm/apple.yaml        |   8 +-
> 
> You need to split bindings.
Good catch. The bindings part needs to be squashed into the commit
adding the
bindings. This is a miscommited style fix up to not mention "Apple" when
we are
already in Apple ARM Machine bindings, unless it is part of the offical name
(like Apple TV).

> 
> Best regards,
> Krzysztof
> 

Nick Chan


