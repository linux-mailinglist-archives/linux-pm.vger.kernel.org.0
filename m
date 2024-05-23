Return-Path: <linux-pm+bounces-8076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACEE8CD342
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 15:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4011C21FB3
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F614A4C1;
	Thu, 23 May 2024 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SJ7zIdPY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF213B7BC
	for <linux-pm@vger.kernel.org>; Thu, 23 May 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469810; cv=none; b=NtomMt9+KfpbytajL58WQR6QxVkJ3H8eUSGLFgMrCFQp+iMEw9qSEcYOM9xdEZSm9Ky5/Zr9GOi6lyQhVYGHvHdGTRPcPIAHn39xLWCIhai50712q+vV37kr0IO8RPs/O3tSqkS2GIKicYuCEClIl3CX9wxLgazB/xkVJJ59R5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469810; c=relaxed/simple;
	bh=7/zN4LutuvDH5MlsPYdxcjgISQwlC47iGGavoXQlvDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZORzktfrNgI9jB4zAXiKjWeA81Um1Egp9IguZVreAumcRQgYBmNErzyoo0rSrJJa2TniVRJubs/MIlsuL7D/GU54ORm5d4AJZuyJm9L52jNm9/qJoZyGmVFs0nJDCmrzr3/hzC2VurrQo77I8EU8AACMR/mA4rv0MmzT5TjC3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SJ7zIdPY; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e564cad1f6so108666261fa.1
        for <linux-pm@vger.kernel.org>; Thu, 23 May 2024 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716469806; x=1717074606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NccXt9V6EN2SZG8Lr1Uq+9HYjGPYWjd0QyMlNEPIscY=;
        b=SJ7zIdPYJcDoZQDp9mfkzz/2gh9LjUVxz3X801uIKrfamHZhoDN/cvIjvzFe70gZYG
         CZ2PdHU3+9I8NKHcaT5JnpPTtkBcWn1s4XemYC04Iig8fV5Vf7zZIiE9jcpTZ4vmnDVx
         KU6wAW2l9XDtVr7YrDtH5VIPAuO3lL5ZV8Sdg49AVHr9mNmUlGmOQc3bNlPTaJAzEGBK
         CVnBx6wcdi9GhArCUXiCDEt8zZvMcOw1nU46qIeQUm0Gboll4QbycAx+JvAjM0npctmd
         K9imgDDwcXZVfXPn1/ZNIUMYAB+IFe2hYh9k68ajjUWqSxktAwALOX1KejeKMbBFYQZi
         cBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716469806; x=1717074606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NccXt9V6EN2SZG8Lr1Uq+9HYjGPYWjd0QyMlNEPIscY=;
        b=cyJJRfIV/y94ANswQdU4g7omoDBIbDQQ+lVpVLIGGVcb4/wyrEooCSGNTgNh7wMZos
         YzB29o1HGP/2oJ4Tb78dqDv1qyIZQiqbFwZYwMFKP5zYgBAV9spH6+t/mkFODCCZ0M0I
         zc2DJmciRSHHfWZy2ye29e45viK9972tk9KXuETP5NFg9auYT3UFW+3HLO8OBObhFGy5
         8Q3I8cNEqosB4w9xswxG276kusj9bXPHMdORI1240V650ubudaxE0s9HGldoJBJlyDLu
         UT+idWHIj2b+A7S3+0occ1jwjNMzvdLL1mq6q4iF+/s7B9Ct7OD7JVJXrWVQ+wn6CC7d
         iJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBkLPsRw7HGxZtxoJtBBJreniN8uiqNT3fovyNzU6Buj9CuDvFJL32AGRTiDGBTC9gZl5aXp0tPJxWIRbZgejeSwMR6mTwmis=
X-Gm-Message-State: AOJu0YxnNOGwSGM0TOLL0B5FEuYMPgL70dFt7megiP6kczQemB8cCFqQ
	tBDUo2kVFM3dsNGCtQausRVmiZMc5cNapQj7FFGatA9Hlt0C7r2+E3nGFq50KXBePvtdeMevV7B
	iNk8=
X-Google-Smtp-Source: AGHT+IF//hB8svNbFPr+Fzi5E4/LRkRs6MwKRwT77fKfQWBL+TGZH5TPLNErkfhtpJJqNcroXOX4DA==
X-Received: by 2002:a2e:a444:0:b0:2e5:2c7e:257 with SMTP id 38308e7fff4ca-2e94949dfa2mr32000371fa.30.1716469806333;
        Thu, 23 May 2024 06:10:06 -0700 (PDT)
Received: from ?IPV6:2a04:cec2:21:7ed1:cc40:dfff:5a22:b06a? ([2a04:cec2:21:7ed1:cc40:dfff:5a22:b06a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f64f98sm24634225e9.24.2024.05.23.06.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 06:10:05 -0700 (PDT)
Message-ID: <f00a65a9-e7b0-4811-ba25-2a5a0f932a49@baylibre.com>
Date: Thu, 23 May 2024 15:10:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] thermal: Add support of multiple sensors
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240119110842.772606-1-abailon@baylibre.com>
 <03fbaefa-de17-47f0-a48d-7b40e5df50f6@linaro.org>
Content-Language: en-US
From: Alexandre Bailon <abailon@baylibre.com>
In-Reply-To: <03fbaefa-de17-47f0-a48d-7b40e5df50f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 4/30/24 16:37, Daniel Lezcano wrote:
> 
> Hi Alexandre,
> 
> On 19/01/2024 12:08, Alexandre Bailon wrote:
>> Following this comment [1], this updates thermal_of to support multiple
>> sensors.
>>
>> This has some limitations:
>> - A sensor must have its own termal zone, even if it is also registered
>>    inside a thermal zone supporting multiple sensors.
>> - Only support weighted average
> 
> Is it possible to elaborate why this feature is needed ?
> 
> The thermal framework is able to aggregate the cooling device requests, 
> so having multiple sensors aggregated or the cooling device requests is 
> from my point of view the same.
> 
> I can imagine one reason to do that is to group the sensors in order to 
> use the IPA because it won't work the setup mentioned above.
> 
> Is that the goal you want to achieve ?
Yes, the goal is to use IPA.
I will give more details in the v3.

Thanks,
Alexandre
> 
>> Changes in v2:
>> - Rebased on 6.7
>> - Seperated generic multi sensor and dt specfic code
>> - Simplified the code
>> - Drop min / max and only do weighted average (seems more adequate for 
>> IPA)
>>
>> [1]: https://patchwork.kernel.org/comment/24723927/
>>
>> Alexandre Bailon (3):
>>    dt-bindings: thermal: Restore the thermal-sensors property
>>    thermal: Add support of multi sensors to thermal_core
>>    thermal: Add support of multi sensors to thermal_of
>>
>>   .../bindings/thermal/thermal-zones.yaml       |   5 +-
>>   drivers/thermal/Makefile                      |   1 +
>>   drivers/thermal/thermal_core.h                |   7 +
>>   drivers/thermal/thermal_multi.c               | 178 ++++++++++++++++++
>>   drivers/thermal/thermal_of.c                  | 139 ++++++++++++++
>>   5 files changed, 327 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/thermal/thermal_multi.c
>>
> 

