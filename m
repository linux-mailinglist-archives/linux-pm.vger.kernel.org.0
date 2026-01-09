Return-Path: <linux-pm+bounces-40520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BFAD07BD3
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 09:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872BC3005EA3
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266392F9984;
	Fri,  9 Jan 2026 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU1blxB8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C62F83D8
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946441; cv=none; b=JjFgkYnLTfRB37l+RvLdVB6W1AbTo9mQFpPG4o28tSaMVkK+flLqr6vyd4PfrKHqD3ESfXt0Fn+Zm0MRDBkisamlIwm4sRjpH6bTHEua0ij7XGvwNwnuX5aeAS8zu30Fne6rEGGkbShG/mdICsFEbj2a6zQ+9WNuLJsKx5b3z60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946441; c=relaxed/simple;
	bh=TegNChNmHEzD8+9WeNnVdBonXBPxxrbHlIIxhxeFES4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4BFwvTyjS9k0rn289n7iMA4lcuJttCi48GH2QDsiIV78vEVyXOvbvZdhKKXrMdBB9iixxy0Jo0Fw4jZvcMXiTS1ryFEx6cMHUs16JCTKsmKo671frAiVw0H40pWaadTY1wJM8unlr5YWRqC9EuFryci5uUxDxKRknhsLPQKxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU1blxB8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b736ffc531fso762350266b.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 00:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767946437; x=1768551237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpBRuHMiMCleFgRr0io9MPn59FZX7HGviJTaLToKJC0=;
        b=fU1blxB8sSExuyCg8n8tHPkjEUhDvgX57cvRrMOWdiHRMJHwj0eGpP94OWFCPbeVUk
         gDm+pfRUlPmjvqYpqo45wSU1KuFAuGkP4oGR87I+YFsLx7DyJ1946UekZHMMac4yfnVG
         wi209brfG2rB2eq1dj3wE1n3BF1TypGAyIgZbortinGjP+tsOFh0LBqLBliCiIKv91/7
         8M6vxXQty+3lGR96ap5zC2dTPKKEqyhizU+OQcYuWGEFTkIULNEIaaUF3iE6d6GVkCNK
         IGKoXTs7v4JULUEwHFDJdcxZ7xTNq57j6pCZ5wukbelUIpZ9w0fEiam7qtv7aOaDh6+y
         UU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767946437; x=1768551237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpBRuHMiMCleFgRr0io9MPn59FZX7HGviJTaLToKJC0=;
        b=Md/btSkfoSadBUcZHmH0yTjzymXUUi+NGGzC/OedqFN2umd+p7QNumRMRTT7sEs4Mh
         jt8Djo/2Tna5vxjS7GlBZyN/zukWJmopk5jJODqnZA0lXBnmQYfl7YGlTZLi6opJxaR1
         rD7yr2WOzCGq6bCQIjJSTK01PhbK75v94n+kzqRTpzc4sWNYuxn5qM17EFk7D+D4+yHQ
         rbv/6qnh//tjCoJG4k8oLwwRwReS0+Myg1aSaOzPOj5YsdhU4t8je+wKTvJMT18eIual
         muOw0+xpHIk/aG298EglIqYYrPkP3pnZtnIM1X2GADX7qt23Y5q3CEPJXSZ1J7EwjCDS
         ieRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7T52z9IK7vYhoKZcmbOX7hnN2mjYqYL/AJqPPFxNuKDGiTzwqMcOmOosFYlLvHVPnAlTqgO2zhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8LRt7bruHqnS6S5ZSSW+75G9XJ/B4WShc8NkQWmg5sNFw6qa5
	uL9Quouq0nJaCHvowWKbqHt2kXsLQF2ahml3N6vdaEaVVQmGRSh7qT9ZXt/iZnFKexM=
X-Gm-Gg: AY/fxX7yN/R8dfj5BMBT2olpXG4HmQo09o/KMcrAEiPh62ExGb1U4gmzq/soV9gB2fv
	QkUtkhBsST/mqI2+8cuDuggrasZcv88nXJLF7XihzPli1mz7j1HhpSPETWaVl3eJmDOVJGYGc1V
	hqV/imK/Z7Q4Ed41vSVGWxMHrQFkScPd+ws5F//gSLc9m5iOjKkyimQlvrrqR6/JORfcbm3IyTG
	J9PeqYILes8ic78CvKfI3PPYaUyqrDOP7X0clg6hauS+tyYykO/pxlPdS9jqm80qOESvQp3ynkH
	vPy7HkGTYwcRW4JWKqD6RZ1laXKVYnYorQr2Z3QocLK077aA2MGh6KS/PidWN5zdfWowoPZeqmI
	hZZAqAucdHKK++vp0y0mt/+5Xlba+UTr6dsAL1R8FH5V6ax7kxHfAV63+RinoZouCIvuEmvFAsx
	eGH3D3WCogjg+UPTzR3xiMTNZXrcmB8m/5NFUCQIQbCilsansEXb+EF3vKEvzqBOBmjsQ4
X-Google-Smtp-Source: AGHT+IEbfnpAwTBpMLXsSD7GLLq4RdVLr81UJhXWfoMR4g3wMxGRElDJAG31EIjk//ER3TZlJZdKiQ==
X-Received: by 2002:a2e:b8d0:0:b0:382:ff8c:c9c3 with SMTP id 38308e7fff4ca-382ff8ccac1mr27076741fa.3.1767940183581;
        Thu, 08 Jan 2026 22:29:43 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb7cc214sm21543771fa.22.2026.01.08.22.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 22:29:42 -0800 (PST)
Message-ID: <63bc889a-b97e-43c3-9f46-9ca444873b70@gmail.com>
Date: Fri, 9 Jan 2026 08:29:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v6 00/17] Support ROHM BD72720 PMIC
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
 <20260108172735.GK302752@google.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260108172735.GK302752@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/01/2026 19:27, Lee Jones wrote:
> On Mon, 15 Dec 2025, Matti Vaittinen wrote:
> 
>> Resending the v6
>>
>> Series is same as v6 _except_ being rebased on v6.19-rc1 - and adding rb
>> tags which were replied to v6.
>>
>> The ROHM BD72720 is a new power management IC for portable, battery
>> powered devices. It integrates 10 BUCKs and 11 LDOs, RTC, charger, LEDs,
>> GPIOs and a clock gate. To me the BD72720 seems like a successor to the
>> BD71828 and BD71815 PMICs.
>>
>> This series depends on
>> 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
>> which is in power-supply tree, for-next. Thus, the series is based on
>> it.
>>
>> The testing since v4 has suffered some hardware-issues after I
>> accidentally enabled charging while the PMIC's battery pin was connected
>> to the I/O domain. Some heat was generated, not terribly lot smoke
>> though...
>>
>> After the incident I've had occasional I2C failures. I, however, suspect
>> the root cause is HW damage in I/O lines.
>>
>> Revision history:
>>    v6 resend:
>>    - Rebased on v6.19-rc1 and collected rb-tags from v6.
>>
>>    v5 => v6:
>>    - MFD fixes as suggested by Lee
>>      - Styling mostly
>>      - New patch to Fix comment style for MFD driver
>>    More accurate changelog in individual patches
>>
>>    v4 => v5:
>>    - dt-binding fixes as discussed in v4 reviews.
>>      - Drop rohm,vdr-battery.yaml and add vdr properties to battery.yaml
>>      - Drop 'rohm,' -vendor-prefix from vdr properties
>>    - Link to v4:
>>      https://lore.kernel.org/all/cover.1763022807.git.mazziesaccount@gmail.com/
>>    More accurate changelog in individual patches
>>
>>    v3 => v4:
>>    - dt-binding fixes to the BD72720 MFD example and regulator bindings
>>    More accurate changelog in individual patches
>>
>>    v2 => v3:
>>    - rebased to power-supply/for-next as dependencies are merged to there
>>    - plenty of dt-binding changes as suggested by reviewers
>>    - add new patch to better document existing 'trickle-charging' property
>>    More accurate changelog in individual patches
>>
>>    RFCv1 => v2:
>>    - Drop RFC status
>>    - Use stacked regmaps to hide secondary map from the sub-drivers
>>    - Quite a few styling fixes and improvements as suggested by
>>      reviewers. More accurate changelog in individual patches.
>>    - Link to v1:
>>      https://lore.kernel.org/all/cover.1759824376.git.mazziesaccount@gmail.com/
>>
>> ---
>>
>> Matti Vaittinen (17):
>>    dt-bindings: regulator: ROHM BD72720
>>    dt-bindings: battery: Clarify trickle-charge
>>    dt-bindings: battery: Add trickle-charge upper limit
>>    dt-bindings: battery: Voltage drop properties
>>    dt-bindings: mfd: ROHM BD72720
>>    dt-bindings: leds: bd72720: Add BD72720
>>    mfd: rohm-bd71828: Use regmap_reg_range()
>>    mfd: rohm-bd71828: Use standard file header format
>>    mfd: rohm-bd71828: Support ROHM BD72720
>>    regulator: bd71828: rename IC specific entities
>>    regulator: bd71828: Support ROHM BD72720
>>    gpio: Support ROHM BD72720 gpios
>>    clk: clk-bd718x7: Support BD72720 clk gate
>>    rtc: bd70528: Support BD72720 rtc
>>    power: supply: bd71828: Support wider register addresses
>>    power: supply: bd71828-power: Support ROHM BD72720
>>    MAINTAINERS: Add ROHM BD72720 PMIC
>>
>>   .../bindings/leds/rohm,bd71828-leds.yaml      |    7 +-
>>   .../bindings/mfd/rohm,bd72720-pmic.yaml       |  339 ++++++
>>   .../bindings/power/supply/battery.yaml        |   33 +-
>>   .../regulator/rohm,bd72720-regulator.yaml     |  148 +++
>>   MAINTAINERS                                   |    2 +
>>   drivers/clk/Kconfig                           |    4 +-
>>   drivers/clk/clk-bd718x7.c                     |   10 +-
>>   drivers/gpio/Kconfig                          |    9 +
>>   drivers/gpio/Makefile                         |    1 +
>>   drivers/gpio/gpio-bd72720.c                   |  281 +++++
>>   drivers/mfd/Kconfig                           |   18 +-
>>   drivers/mfd/rohm-bd71828.c                    |  555 ++++++++-
>>   drivers/power/supply/bd71828-power.c          |  160 ++-
>>   drivers/regulator/Kconfig                     |    8 +-
>>   drivers/regulator/bd71828-regulator.c         | 1025 ++++++++++++++++-
>>   drivers/rtc/Kconfig                           |    3 +-
>>   drivers/rtc/rtc-bd70528.c                     |   21 +-
>>   include/linux/mfd/rohm-bd72720.h              |  634 ++++++++++
>>   include/linux/mfd/rohm-generic.h              |    1 +
>>   19 files changed, 3127 insertions(+), 132 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
>>   create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml
>>   create mode 100644 drivers/gpio/gpio-bd72720.c
>>   create mode 100644 include/linux/mfd/rohm-bd72720.h
> 
> The MFD parts LGTM.

Thanks Lee!

> What Acks are you waiting on?  What's the merge strategy?

I think everything else has been acked by maintainers, except the 
power-supply parts. I think those have only been looked at by Andreas 
and Linus W. Haven't heard anything from Sebastian :(

I would love to see the patches 1 - 14 and 17 to be merged (via MFD?). I 
could then re-spin the 15 and 16 to limited audience as I hope Sebastian 
had time to take a look at them. However, I don't think any of the other 
patches in the series depend on the last .

Yours,
  -- Matti.


---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

