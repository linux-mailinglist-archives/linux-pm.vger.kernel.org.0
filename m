Return-Path: <linux-pm+bounces-38427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA7C7ED2B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 03:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529103A5072
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 02:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655F28B3E2;
	Mon, 24 Nov 2025 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8x/Irwa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B14B665
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763951653; cv=none; b=klhAqA4I8F+WietTwyQmN3Q4Is4jOSEAsaFiw5LdrQ5wBUvSBzB8eRiv7Mf4Rg02kIBWyQKSS3DpIh3Hv1bqdrsotiy7oVOF6xdcgo+uBCWrL7d6vvi4lXKONQR8i+EZqp+oJHOwLjTjXgqsUO3MHLaFo6RKwsaVNbYAGezRbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763951653; c=relaxed/simple;
	bh=u50wiEtGTDGab7ZHLTtEof0ZVgdLfgY/RffYitv2A9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gi3FckYzPxFwlZQhTqQ4y3Oz4nKqrtJBMRZJQWe6bjPW1C0DIMDuwr3rkW193D1/jR+N9pa5/qPXIWFjBQapAQHpbUIrHnxv2WJk+psWIBCV7jYLwPs98QU4QYzASiznHEqyByGlloTVC/KpG+zckfRZZcN+eBpLc4dlQI1vPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8x/Irwa; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78aa642f306so3603187b3.2
        for <linux-pm@vger.kernel.org>; Sun, 23 Nov 2025 18:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763951649; x=1764556449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJnKQ9oJ9uOzEtfzk8AKk4PwanNXBUdVi5ibWSqh/IQ=;
        b=m8x/IrwaiGnCb0YBQz7bEJk0cbf46DK1nrNm2Kwf8vW9VvfhJto4J7VC6xJdKeWM58
         GEWqUnq2+rVPoIN+62SlrcgIizlmxlvmG50u0HenUdY3x7ttd2jzBxl7Fo08vaqaJXLU
         1lGuLVic55gDwMu+dOLEa9KHlp/YqJCukKMKeiZKRwyyq9WyIypGGv+Kh8wntAI3/Tgs
         RzDKPQOETilaHBt0vgwifEkDh24ZrSqIkox8G9aqwCOzyXZ+KVBt9nQqpqUahk3jc0yS
         U/2W2W4UvLW6njF1ue9GuGHZwkt1He9eUc8hRVE0rcX7BMQAttBfHYqs+Iog8XQl53M/
         WOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763951649; x=1764556449;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJnKQ9oJ9uOzEtfzk8AKk4PwanNXBUdVi5ibWSqh/IQ=;
        b=YTz9Av6/wAV8fyM8mliGi3TlFV1dtK9Kq4n820jXbQQwAdF/GJR0FQDyIrDZZ4XJwK
         mIN2akZXt5OI2O1/sCcdNeBb16oGtmefyNvX1pnql6bXfVOJcJjWfDnaVUmrKa/DClM2
         Oo7Vag6qVkfsfY1YgVS6nivNgKWLwsQiYdR9d1kJwKPPBjPn94Q2fOjqXoyozdOmaWm+
         1fhkJEtvDowmXE+V8+CyHdmbjBwgfd5jy4sR9uRKN9wIvBMK66Wo6qWopgH8r2GaHaOl
         GgB4szb8m5bvwlxKe4cWOAw53+PW3ljeqe3bWZMQ3ZCkcQiFHJrP5iOyQTr3XFL4wSck
         W5fw==
X-Forwarded-Encrypted: i=1; AJvYcCVN6DVd+adTp3cVS02LyBTBae9hkRPB0S1oAm72OTTQfEI1pQHKJiAOr1EGmJm+o/RqWz01QsxOEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUx4Ww0DNr3822jMI5VhalD24J2Gonp6u0Bk9cBWHwAgAt/Kd8
	EU+XHfvBrgNbZAyt2vZ3tUVAVSwd3D6r+Agqu3hbTeEa2hV9khQXWAfDVeEteHSeVg==
X-Gm-Gg: ASbGncv1fN0y+dc4N8CjGcaElgzZ/4s1/945KBhEVhTYYqBPNiqywYz7y7jwSgi2/Q/
	8HtgITUYXfrV1k9+FVxSY5h8N4TYbpaIWwxpcEOsAwvZ+Gb44F1/SbcuDXbFdXX/vyZGZOwyJfR
	mqkq4fa/20bBRGyf2Eu7NrI2JGPfRcmgv3NVNgNPTEgzC8zF+AgMY8JMOtq5fdtpKWXmhFf1LTx
	leRNWxTExLwIY0dVmCyCdaDhy42DQgBHa7Jk27Y0uSEZn+vn+vFlLYyl8PRUWKqyqST3/oS+USg
	C/i8nNOCnv6RVEeOMEkkG58hAAPLKEEXUWggQbMpo2OiVaJ1F9xowfaFd6ub7enX3KkhmmiEgye
	lnWPI5zcTP5n3Nhz87GKi/GiXvooeBoIqA9xWx0kuBAQkwAivItSA0X8SbBmecMzDzPG5QAuKxH
	8EeUPtLjgesWQ1M45zHRCl41VY2itAlbNcI3kGlNI634KnIKTjpFUQuZDwJAI=
X-Google-Smtp-Source: AGHT+IHxC+BdP7vzl95DrlP/y364+xUvzMJ0RS3cskY282bYh7RWJ066M6U+GDgwPwRF2d9d7KuiRA==
X-Received: by 2002:a05:690e:400d:b0:641:f5bc:699a with SMTP id 956f58d0204a3-64302b37d39mr6827251d50.72.1763951649099;
        Sun, 23 Nov 2025 18:34:09 -0800 (PST)
Received: from ?IPV6:2600:1700:4570:89a0:1806:1fd4:facd:d088? ([2600:1700:4570:89a0:1806:1fd4:facd:d088])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5decsm40005717b3.21.2025.11.23.18.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 18:34:08 -0800 (PST)
Message-ID: <c9b059f8-9219-4219-95c8-23a3733fea58@google.com>
Date: Sun, 23 Nov 2025 18:34:05 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: power: supply: Add Maxim MAX77759
 charger
To: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
 <20251123-max77759-charger-v1-1-6b2e4b8f7f54@google.com>
 <d4455f4b-2a0f-4bc0-b897-14f2e27af3ea@kernel.org>
From: Amit Sunil Dhamne <amitsd@google.com>
Content-Language: en-US
In-Reply-To: <d4455f4b-2a0f-4bc0-b897-14f2e27af3ea@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 11/23/25 1:28 AM, Krzysztof Kozlowski wrote:
> On 23/11/2025 09:35, Amit Sunil Dhamne via B4 Relay wrote:
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add bindings for Maxim max77759 charger device.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>  .../power/supply/maxim,max77759-charger.yaml       | 36 ++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
>> new file mode 100644
>> index 000000000000..71f866419774
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
>> @@ -0,0 +1,36 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/maxim,max77759-charger.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim Integrated MAX77759 Battery charger
>> +
>> +maintainers:
>> +  - Amit Sunil Dhamne <amitsd@google.com>
>> +
>> +description: |
>> +  This module is part of the MAX77759 PMIC. For additional information, see
>> +  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
>> +
>> +  The Maxim MAX77759 is a dual input switch mode battery charger for portable
>> +  applications. It supports wired and wireless charging and can operate in buck
>> +  and boost mode.
>> +
>> +allOf:
>> +  - $ref: power-supply.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: maxim,max77759-charger
>> +
> This should be just folded into parent node, no need for separate
> charger device or is just incomplete.

Thanks for the review! You are right, the binding is incomplete. This
charger block actually listens on its own I2C address, distinct from the
main PMIC.

I will update v2 to include the reg property. I will also add the
standard properties `constant-charge-current-max-microamp` and
`constant-charge-voltage-max-microvolt` to configure the hardware
limits, as this charger device does not manage the battery profile
directly (that is handled by a separate fuel gauge).


Thanks,

Amit

>
>> +  usb-otg-vbus-regulator:
>> +    type: object
>> +    description: Provides Boost for sourcing VBUS.
>> +    $ref: /schemas/regulator/regulator.yaml#
>> +    unevaluatedProperties: false
>> +
> Best regards,
> Krzysztof

