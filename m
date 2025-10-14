Return-Path: <linux-pm+bounces-36064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD16FBD9472
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 14:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF531188C837
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11CA2874ED;
	Tue, 14 Oct 2025 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGoHvT9i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9445270553
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443925; cv=none; b=Ustdb3x0rpqGNtSrublxobt/Nynxg+ysDw4Cv9Eq2OhV4rriEz7tGs9j36MPvxEx1Xex2pbiXG9P/16cPA+0GJewbcYJT+xS5xusJxMacutOT4BexFw5rKFqnLul4ZpaeVvtkx7FHKZXuyRvmg5nzppZ2BM1zrdsooJxJcWNBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443925; c=relaxed/simple;
	bh=vv6SCZXUdjxEguAATuwGq3R/PnOOppUOkjoieyZK+QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmPDJT5zMfUPB20QbLqAmWVddwiziFTccg6OBX9OfgazZRfFoqg7N/XaTjzbjYokdstP9qMR0Hzi8PfqG8gGSgAov5BjkUfN7zHhkX2BIRW/A7/tbWO+KKy/1kUBMxmI8DWtCiU6fu95c+3MWynxX/zypYoJ5DKJR43ymTHAGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGoHvT9i; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-36a6a397477so53568071fa.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 05:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760443919; x=1761048719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19UY8Ondjgi9nEDc4X9WWhtcIr4QTybVkR2WGWv5OR0=;
        b=nGoHvT9imkjXZP7O1ZAgzncMDDkL/jFwW2yzfWA4NYcYhYRp71DfzoOyUsa0wn8SyE
         a58ks1YfrrUw3k+vP6yAWeeWlT16lPYRxRV14nQ50VIh1yJScO45ivD2fS/z02tv4XpW
         7VgKLU8p+c4+m9FUY9dbOE1nTZZNd+7Hc1bdMlBUyTi+C7Kb5J70X4T7Vfy0UI/EcXHg
         CA0mt+MBaB6zixHfnk6NEaxqsEkIkvs/y/g2xIYeJ2g3kVqwNZdWq+NS0U1hh91t0PDD
         23cFquPMzol1o/8a7CVYGbslIUM1elKwdlIhtL17DynnP7VC013CwwCHOZg3zrRYnXPw
         r5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760443919; x=1761048719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19UY8Ondjgi9nEDc4X9WWhtcIr4QTybVkR2WGWv5OR0=;
        b=aCorL1ytlzxKrIMnXrXT5AtePxJuW6o8SgGkNkTjDsiPyuc9ZrBOL21Y1K13UZmM9T
         E3+SjrE5G085v7ZX2o9/He0rQzYyHhY9QH2WFpVX4+vWlfuhcBAht+X4RhCApbqrE8hV
         S2QEg79YqDJxlbQVQtGtIQL/t4FIt384+n0aMg4uhC/P4apcX+ZF3wAeHnki0gMWFqHo
         ANV/DxfuX7GTI9ni/q8s3Dqrl01ddTJjEqUKGeocHDT1nEuQpj0fOzwjNXYLiOKu1GtL
         99NBhlxdIdqgKs3h/rCdgey4G1hpdD18iycp7oxyVXumvGLUZh+U18Vji5cuU+KpufGj
         Czvw==
X-Forwarded-Encrypted: i=1; AJvYcCVm9gnvwUhxtEGK0Zng8W9UZh4mCP4uH0tUkOYR7rqYURVdE3G58uilElXY11DxFt0lXh1D+8CvsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvMBYDxN2oSsFAw0NAJqlWs7AEwCefDHxpfBcylegKZdHCEtFA
	1qGVbdexB1jygZaJjQbNep8F4P/egG1XCtLZaue8pv7Ftq/izNToIVU5
X-Gm-Gg: ASbGnctslVcdqRoiaf/rkBLtu88w1Q19Sy1F4/oy2P7a+CyvTIJGdtfCL4pi56if+eH
	lA5oX4gqy0bAxNqazNLapsfvPStD0Ivk4KiiPN73RYgTmg0ggmXkqpV069stdiiZatv8OHbfvCX
	JDJN0vEDbof9M4w2BkODN9yQM0w9V8/y4tQuekwk82g/5n01YFh2hCgj2neoHTLhvTIKffgF25e
	aSNKECJtpsEuSNc6Pgs4e5O91id8p+Nq4E81lkkBjVHQ3C7PAmyF7wWR6hxU9S58WwrQxegj2k/
	PGkohfvNX6l9BXdf360SyyhWDggbTsOHip/vyt1gWSQRZRZReQeEJ1hPaqRH8pn+B9lpiOuavdt
	OPcS/7mRNN1ztvbhrnFo5aTu9oBl7qh38tMa01SkwC2FaOqgdXBGx2Bv5DdvPTCYIPPS6R1AB9n
	q7XoZJG0LVHUaZJiZ7/k0LntRAIdmT/gbuqA==
X-Google-Smtp-Source: AGHT+IGW8zh9AOgyW7nkUtmNQqz6PJovnO6f6RGpy2I05ufukYy7iqHPI6QQtLY8F4LP884y1HCvzg==
X-Received: by 2002:a2e:be1d:0:b0:373:a537:6a00 with SMTP id 38308e7fff4ca-37609ea4554mr56777981fa.30.1760443919151;
        Tue, 14 Oct 2025 05:11:59 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea3b31bsm39258931fa.47.2025.10.14.05.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 05:11:57 -0700 (PDT)
Message-ID: <cac4222e-1f66-40e1-abf8-7d4661d43bbf@gmail.com>
Date: Tue, 14 Oct 2025 15:11:56 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/13] dt-bindings: mfd: ROHM BD72720
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1759824376.git.mazziesaccount@gmail.com>
 <fe1f4a0947c864496f4eeec8eef806afcf6094a4.1759824376.git.mazziesaccount@gmail.com>
 <CACRpkdZnoMvYBXN7b6dw+uPs=f1WXr9wX-0VF1c1qd-rq+17LQ@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CACRpkdZnoMvYBXN7b6dw+uPs=f1WXr9wX-0VF1c1qd-rq+17LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/10/2025 15:58, Linus Walleij wrote:
> Hi Matti,
> 
> thanks for your patch!

Thank You for taking the time to review of this RFC!

> On Tue, Oct 7, 2025 at 10:33 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> 
>> +  rohm,pin-dvs0:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      BD72720 has 4 different OTP options to determine the use of dvs0-pin.
>> +      OTP0 - regulator RUN state control.
>> +      OTP1 - GPI.
>> +      OTP2 - GPO.
>> +      OTP3 - Power sequencer output.
>> +      This property specifies the use of the pin.
>> +    enum:
>> +      - dvs-input
>> +      - gpi
>> +      - gpo
>> +
>> +  rohm,pin-dvs1:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      see rohm,pin-dvs0
>> +    enum:
>> +      - dvs-input
>> +      - gpi
>> +      - gpo
>> +
>> +  rohm,pin-exten0:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: BD72720 has an OTP option to use exten0-pin for different
>> +      purposes. Set this property accrdingly.
> 
> accordingly?
> 
>> +    const: gpo
>> +
>> +  rohm,pin-exten1:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: BD72720 has an OTP option to use exten1-pin for different
>> +      purposes. Set this property accrdingly.
> 
> accordingly?
> 
>> +    const: gpo
>> +
>> +  rohm,pin-fault_b:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: BD72720 has an OTP option to use fault_b-pin for different
>> +      purposes. Set this property accrdingly.
> 
> accordingly?

Gah. Well spotted, thanks!

> 
>> +    const: gpo
> 
> These are a bit idiomatic, not using the actual framework for such
> things (pin control) BUT: they are on the other hand crystal
> clear for an integrator working with this device tree, and only
> four pins so why over-engineer it. I am fine
> with them if the DT people are.

I kind of like to emphasize the fact that this is not really a pin-mux 
in a traditional sense. We can't change the routing after OTP is 
written. As such, it more resembles "wiring" of the signal inside the 
PMIC, and this property is not a control but tells us how the signal is 
wired. But yeah, let's see what others think of it.

Yours,
	-- Matti

