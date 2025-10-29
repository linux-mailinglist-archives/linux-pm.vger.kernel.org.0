Return-Path: <linux-pm+bounces-37023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63260C1A52E
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 13:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B823563349
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C40368F4F;
	Wed, 29 Oct 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKusNya+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D235BDDA
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740592; cv=none; b=hXllxrJ7OvEWEDulxmC5mvV8Gqkg461VvMCnolSQHfgT11G2Z3fYUlEjvPRbnxgbXEfc/BO/dmBYm19BuZwHy3sq/IgqK+DeQvA/a8cuutJ8igJcJgJDP1kPPrLaSvNgm/+QE8X1BlTsW75J8rEq1pdQoxEYmIfSA4oTGt8lpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740592; c=relaxed/simple;
	bh=4q7J4aubuQWsGwr0ektsFotDhPgrwX82ZQ+g0OMBrag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkFiJvSHo6PnlrEQNI7rUsXE4hN8PjRJCm3F4oiiAspmUagO1TuRdPAClcl69dUEldRvzPaNHgFK1azpTNb+1EpzgO4ZRYS/BqCzAGoBfqavMX1EK2FH0ySYqav8iXGDzi64k6WVpuJv0f4uPe+47PJWFU0Qfj9Of4w9xQzy7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKusNya+; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-378d50162e0so82419951fa.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 05:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761740588; x=1762345388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwOTcdAl6vDZ/MWyMdXE0a7QobEAic8ni59wBqX8fPs=;
        b=aKusNya+J1epch69ax/IhqtTcFFpOXJlXycJ3taG2vAOmbfp5vZwMNwAwBFguwg3/Z
         iA5ZMqVWcGfEE/fkTY2j6W8/t6u/Amc3PuCCNe8K3HEP9bi88kUMQEnLT50SmA0xR8oz
         kjgeFGRrAQY7/0L/g/TilJzqMIeIakGJOXRFkr3nWwMw69QcKH4JjpCPNH/8JsOMzS/K
         G//42m3pFRCNn1P2pYqDJZZ7i0fwtn36IiINOJPRcWNJ7n5RPen4uWKfsa00ir6XNTiv
         s4+BR3zF4LXbN2b/x5+DHA325CzYi4Y9bsxThtoQgnfy0Y14RIJAMO5CBUtgcTLfo4Dc
         lfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740588; x=1762345388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwOTcdAl6vDZ/MWyMdXE0a7QobEAic8ni59wBqX8fPs=;
        b=Jx1kFCCsCiH42MSMvKDMknCg8suY6Xtc+sqC5rQvk4wUSOJw2rUJG7TKiMqaAFVpEF
         oFSE5VvtJMLz/CJYpFl0VZ6oLjJxLohcPrtfhft9tlaRyRE7l6gBHJ3W0aY2Riu84ltY
         d1w+9nvzj6N5xR+Z1TLJ+16BGbBHyGELW4yZRlleylm3LfJrliw72hW15RuekgvNJ/E0
         MZ4olF8iDPnOmtmTvrHXTt0H9tH+TgVqI+E9fHA4VMO+obqaJiF+kSyJ7wzmZVYFP+hv
         0lmPleATAbLRuTOJHJUxq3Ka3YU+WwL/OmldM3lCVorgqAU9YNFH9l/+Xhm/sMACL/yV
         Y4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVzqKMOo+CbpMrGysh27cYxwOcGci2/EK47TIDf34J3gvqoGM/fTwxrd7n8UcWhhBMNjtKJyvfJjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC2keWCvjpw2otmExeSgCDST3jCV/YDu6nV1WnW+TnuX1sEgvK
	TgtNIKziVhlTLrXa5c3Uc8qPTtPTXQkV5osKP3hD8WWBf6EgGTfRvc7b2nDnAzMc
X-Gm-Gg: ASbGncv7aHj535CWB3WKZtb6SCLVYIvFrRywFLJDaQNTFGdDmkw9N6UkbHTnBlzdn7M
	YUq+0erltHIfsvAvEj0qGgLo/DGRj7tX93/FzKNHlFwV9ZCMqIy4ehvA04nrb+i1/Ao8bCseXiS
	wupyAI6HZqn+MYxv2N3imGqTERB0kzetCUE7rUXbQXlPR/RdTBqkALGfd/n2PtXKqr4KPDgKxXY
	fc9YSfMUMXZJqilnJrP25rcoheOSApVGAeb9ZS2fUHQOi6aDmYdZS6aKR9exCzYf7xzGt9gb3dt
	rHHuZCO1UxzN4NYPY+JEr+sFn4ikcOCsgdAc2+lF8ql4k0ftuYMPi2LA7DGJ2tVUrDAdmnPsZzw
	08BwsWSPczn/5bpFX4DBtXNFjBPVUPN9P6IZE4KJAFChdftfOAfSJpAwlZiiwM+g1a7V15RpMnc
	NRrKg+/A3UfA==
X-Google-Smtp-Source: AGHT+IFFUkHYksyaF7YXcZrhW6iSWoG+pahPESVLSjEUcjb9W1AN2WMoPe9CQ3dBxP/T6OWyot0tAg==
X-Received: by 2002:a05:651c:1ca:b0:378:ec26:bac with SMTP id 38308e7fff4ca-37a023c5e6fmr9540811fa.15.1761740588247;
        Wed, 29 Oct 2025 05:23:08 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f5f98esm3814707e87.57.2025.10.29.05.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 05:23:07 -0700 (PDT)
Message-ID: <49612d39-e2ba-4cf1-8bd2-3da1e9869069@gmail.com>
Date: Wed, 29 Oct 2025 14:23:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] dt-bindings: mfd: ROHM BD72720
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <a5957c4f83724d4f32527fb892fc340af4eeddde.1761564043.git.mazziesaccount@gmail.com>
 <20251027222030.560def67@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251027222030.560def67@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2025 23:20, Andreas Kemnade wrote:
> On Mon, 27 Oct 2025 13:45:46 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
>> charger, LEDs, RTC and a clock gate.
>>
>> Add dt-binding doc for ROHM BD72720.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
> [...]
>> +
>> +  rohm,charger-sense-resistor-milli-ohms:
>> +    minimum: 10
>> +    maximum: 50
>> +    description: |
>> +      BD72720 has a SAR ADC for measuring charging currents. External sense
>> +      resistor (RSENSE in data sheet) should be used. If some other but
>> +      30 mOhm resistor is used the resistance value should be given here in
>> +      milli Ohms.
>> +
> rohm,bd71828.yaml has rohm,charger-sense-resistor-micro-ohms, lets
> keep that unified.

Absolutely! Good catch, thanks!

Yours,
	-- Matti

