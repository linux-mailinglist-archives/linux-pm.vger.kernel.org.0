Return-Path: <linux-pm+bounces-14341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2797A465
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8149B1F22E4E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5257C15852F;
	Mon, 16 Sep 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbsb4xmc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A0155336;
	Mon, 16 Sep 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498046; cv=none; b=am/XNqbO33qbR1d5dMzraCn/DrBcKOx+SJMeHbYgjubCm04ToLgJr1aamLrw/Uc3FmzjLo5E0fTxVgK7BByIoupcjVqqxdRKWE+Mk4w+rS2XoZBBPb6Nb7uxGmvh0n2rsKHB0grqIM5nlnZejCG2x4eycBYL4cmQIKlWPaVuKW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498046; c=relaxed/simple;
	bh=r28B7KOlyk0USWch3chI75N3jUpy9XYDxZu7HjFeA6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQuDVEL6lSyDIPOyIPiGBAm5xTpul+kCWRQXoEXcyOrOWtZGjEGBvyyhBGMOQsb/4jATmvzmSoUHIlK0pYo37d21ooTthDltA2ZXSHclOmg2ANMoooQaiKrCsI5JjJTKTShi1LNG2d1RMFOazmyQx9w7kGeY0dRoQnOdKyqd8DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbsb4xmc; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so3676254a12.1;
        Mon, 16 Sep 2024 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726498044; x=1727102844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJ8ddh1mE+rZEVPh4FlUNjjQ/3bZOvBuJzK+R3GghbU=;
        b=dbsb4xmcGAoHQw64IJehbUiHCxhX64hmv+g8nw0wKjv7E7EgeMW3zkZT+ibJeJzSll
         PVFDMhotyDH3ih/+EJFXBRl0FUIkdF6auoBYG2O4mC0GaZhPZ2InCw1o/XjMTgQ6blwY
         hBKoK3TqMh4jwWIBFsiTKcCziv18mZtjjx6X6MqPj5f8bFty1q7gkUskIACAWZQC6QHh
         JqDtGDMV0xTXQUKNAPnx/a067MBAPJXPEFhfMiYQZ6YnrwbU+9uccS4InATshbOufWmA
         2reT0Xt0rXIyF7XZkIiz+jFIroUj5NVKGBMDjmW5iKm3BD+A2CYG/2BTJ/Hjb3A8vtXZ
         a5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726498044; x=1727102844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ8ddh1mE+rZEVPh4FlUNjjQ/3bZOvBuJzK+R3GghbU=;
        b=AaW/8+5pQN5vpJn/ynLfo41+BMYa3mfZKf0P5TwAmU5EFE7awG53I9DV8493Z0ig5l
         VbqA5NLsE8NXeMDyUyz8xVh++qOuqKcuEwkkBXd81W/ec3ih5tA14nOPhTS9zWwrJ+Gs
         9Hph2EwfNvFrGPW1DjRZ0FRJZhZnYgvuBombPJCb8/zch/xdv/0c0K2B2zQ7gFGYwXkF
         nwsXdCuxdKu4hqLh7pkLsU5R/8LCsg2Ab1O/YGLDMeJmxZ9gQVAS8sv4vZJQnchiku9f
         wcPw12imu7ncLTiB0fjhP6EOk4iTWulb+ZENi2St0YoDkywhwYwzqtFDmgF16nwZnxCz
         iwzw==
X-Forwarded-Encrypted: i=1; AJvYcCVQcO5wtidyQo6Rn0ASe+xtwMZLwM+fbs4TB8wRHTa8ID4Nxc99MrH3/c4Ow1ehI8Lv7Rd2oQcwNeZ1@vger.kernel.org, AJvYcCWCLOCQaQKcIjgtxHagO0an3n3IcwLjs4y2bQapv51VERYv02duu9vlyYK3CB1nkPRBYJAX3c34QMlDsw+J5js=@vger.kernel.org, AJvYcCWXrktjUPGxbjBF7zRjSTs410N2GgVfujLiJDyRKiROU3keWnQ/3Lixm6FOVZYNIpITEbSlxlHNZSyrIg==@vger.kernel.org, AJvYcCX2dwigRFzETvyeeKq0H2cLUjPKdJZlh/UwvIs73uMqi2GBNyeLmRuRTpw4rnxZNXxSQgF1cjeukho=@vger.kernel.org, AJvYcCXCMTuLnCau48/hjxs+iuL/N9VujHEK5OFLs9FKXrvHIVqIMrvybbaA67u3hrWi8fpF0zrXpI+OjxFVf9Qd@vger.kernel.org
X-Gm-Message-State: AOJu0YycBbRAhWdAGMWuESgLNoc4619fZtccylikzJREGfpzG8I4DPxL
	o2EmW9Nd7Czpii6UNeOMqm/zcLcCSeoElqk3pQqhE+qptcg+DwM/
X-Google-Smtp-Source: AGHT+IG1wHKbJb2JdItsRdO+p6aWLUSqzhZx/7SQGfo5/vw1/UAnjlLHgs8oWzTV5MspFfN72B9h4g==
X-Received: by 2002:a05:6a21:3993:b0:1cf:4ed:ffc0 with SMTP id adf61e73a8af0-1cf7559895dmr22944550637.4.1726498043924;
        Mon, 16 Sep 2024 07:47:23 -0700 (PDT)
Received: from [172.20.10.2] ([182.153.8.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b301sm3795675b3a.107.2024.09.16.07.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 07:47:23 -0700 (PDT)
Message-ID: <c5407291-a799-4b41-aa84-4717a476b661@gmail.com>
Date: Mon, 16 Sep 2024 22:47:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/20] dt-bindings: arm: cpus: Add Apple A7-A11 CPU
 cores
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
 <20240915080733.3565-2-towinchenmi@gmail.com>
 <m4hw6wt2xcsgt23fvu7okump62bqhugpyecp3hqlj37x6m4gno@tmui7wdzhs3h>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <m4hw6wt2xcsgt23fvu7okump62bqhugpyecp3hqlj37x6m4gno@tmui7wdzhs3h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/9/2024 22:34, Krzysztof Kozlowski wrote:
> On Sun, Sep 15, 2024 at 03:58:46PM +0800, Nick Chan wrote:
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
>> This follows the existing newest-first order.
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
> Please keep alphabetical order. And no, just because earlier Hector
> added stuff in reversed order, is not a reason to keep doing the same.
Ack. All bindings added in this series except

Documentation/devicetree/bindings/arm/apple.yaml

will be changed to alphabetical order in v2.

> 
> Best regards,
> Krzysztof
> 

Nick Chan

