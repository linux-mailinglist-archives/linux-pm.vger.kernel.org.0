Return-Path: <linux-pm+bounces-38664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AAAC87818
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 00:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11F384E5D10
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 23:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423EA2F3613;
	Tue, 25 Nov 2025 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9C44DAq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8962F3600
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114517; cv=none; b=ISQz7XXQGDXQah9oJU6+y14jE17587Vd8SvLiTYEQRDYzGjllbhYb1jlAxSt84hHb3zlazCGKZvSnVYTmpZ7ABDV0kH74Cg27JlPwo4Jpcoi4vcz7ZjnT/h7Bv7TV8j1cbuUs4+j30+VoOKQyjB6noOZ2n1Yw6baheJJPiMl6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114517; c=relaxed/simple;
	bh=oScQiDTMf1Y91j2Mn7iEF+isUfVWzJF/RUcB/AmLVGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtKWKcwEnCh9q5gW/UnMkYGEfDw4Jzw128EH+hMLstKL71Y0HgkQzDkjeE1OM9AjR60P0V3C39Y6Lsirr9aGe2cg0YND99Gq6f0lqV9VU8Yke5ODTsY4Mr6QEMtyJGCHDq6lKI9PiL9pz79NrSDDpiL9RY9AodMzGa0TFTHFMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9C44DAq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7ba92341f83so8549658b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 15:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764114514; x=1764719314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvscaJfwgdQ/hGiq+gLyeXsz4eE6z2MvV6KE287vjdk=;
        b=I9C44DAq9cmhMqOVa9nNuMednuSZuvaSyQnIlPnUiKcQ9K2oZfRVTau2sQ4/BIDeuh
         uYlAOV81hJY0t34enEskFvvwurnOoWDRp3Bm8+dK5S4QOQ0fUKUP3y7OLcy9Z2vc5mzO
         LKGQUB/dX7E+z6+jJOWbeRUw5ueLIX09pbj90ERAhq+ZV8zFZ/GhVomV+DBicxdCjrLL
         nqrgMtgQeDAI0TfoCzxrV/FwLhlt+EWIrLWXUVtde+9tUjgsWrUdew8/qe8SkjqQ9hM/
         UZDA4FfM2LiBUd76E3M4o8OywR76B6PfNQ8549K6u0Qs1gMiUDUXf0qo2TZ7ibJN9Mi7
         eJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114514; x=1764719314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvscaJfwgdQ/hGiq+gLyeXsz4eE6z2MvV6KE287vjdk=;
        b=ZDU+E6EQ0Fuy5siubBRn25HXltHtiIt3W16Hh1qNdHxmrP55MY2fddv/RJNd7ucI1d
         B20qoATKcMdki8Y1k9wVBB6gSJvatGRP+IYw+Qhncj/9OXiba74E0iv/N3TztNufWUvw
         9JqHYRLxkiMS2vsEjEhYybWraAzDc7PmHKSlQ1yorI4BzkuAyl0tBG8R6nMfYUhYOn2z
         u2mXD6gbEPD++RvV6QNst5UWgGeEdv4urMwIgaSlHXSx9c+8S/zwL3BuW1TBeCg2AEaa
         OFoTBOtILZv0IV0AgAeJ5Bz5B9H4OqcH6sjz58NfEJGbEY6hflD9f4JSkd5QdtHpvmFY
         V4kA==
X-Forwarded-Encrypted: i=1; AJvYcCWrM4/iXqKpx/e/BWz+WqQYNqp+/pTEs6NCsDYF/xVmG42LOGyO2i7fvpCUeS54xM6o5NpsTGyMkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx839oABWLl07WyNtn6/AHfL515LtqR0bdhO14PldtzdmfPt0Gm
	u2SqBRrFkXxETjIQu4yf5sUPwvgA/u57WGrnDP7ABjRT/kYIErEtut+qljTxK7HGeQ==
X-Gm-Gg: ASbGncvVobGQNOUT9MRsyldssrnOx3InVY+o40jzaR2gyst9vKPxgHwu4jOrt2zbq6A
	bVE/IQ7vtYoa5fIIpVW2reVEDSSa34wCjYCUX6gYY2aW+qoV6Or+ppsD59kMogY1fBx0bbqGmPb
	GkijNumimVbazYqYDag4fSqI09QZnehM/dfJBY4e+b82439VABla1GLvJm4zvITQ760thniVkJ3
	3jw2YYqJiw0JRSiUlTM6F7+duDH/QDh1c0CmoXs/g8z8jNA9DtIuTnhWU3XbXN+01xySFR4ZEPi
	tnqJ4VoPQ9BhRcDaM1iO4Jy0ygYbD7qg/bOMj5SrUvVYcI6Qjm1eCv0mXS8R//L+o8tbQ5lw9cK
	cnmxhNGSq0ibPGSnoCLTTupM1IrvohmttJQvK1A5XmOOu1MuFndN6c0NR0vmF8LgoeOJLmtwghb
	Wcnja9u2AA3d8LkKhbJh0q1oW58Sfv759pesvir/g6LonlwTtB0L63ascICBadEInMKBdM0cell
	3qUz6gXKU8/n8B7q3dIxMU9
X-Google-Smtp-Source: AGHT+IFNoWpHHgr9DMjNpMFfmlPDcxXbJRHzRrtGLWmztsEVr2SiPhFDxdBsTEMKUGnJfCeOhy8LQA==
X-Received: by 2002:a05:7022:4583:b0:11b:9386:7ed1 with SMTP id a92af1059eb24-11cbba58e50mr3870990c88.46.1764114513885;
        Tue, 25 Nov 2025 15:48:33 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:c98d:9e96:d0be:bc30? ([2a00:79e0:2e7c:8:c98d:9e96:d0be:bc30])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6dbc8sm89670760c88.10.2025.11.25.15.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 15:48:33 -0800 (PST)
Message-ID: <7ad91325-e881-461d-b39e-6ff15d98b3c5@google.com>
Date: Tue, 25 Nov 2025 15:48:32 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: power: supply: Add Maxim MAX77759
 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
 <20251123-max77759-charger-v1-1-6b2e4b8f7f54@google.com>
 <d4455f4b-2a0f-4bc0-b897-14f2e27af3ea@kernel.org>
 <c9b059f8-9219-4219-95c8-23a3733fea58@google.com>
 <20251125-amorphous-bobcat-of-whirlwind-afdab1@kuoka>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20251125-amorphous-bobcat-of-whirlwind-afdab1@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/25/25 1:56 AM, Krzysztof Kozlowski wrote:
> On Sun, Nov 23, 2025 at 06:34:05PM -0800, Amit Sunil Dhamne wrote:
>> Hi Krzysztof,
>>
>> On 11/23/25 1:28 AM, Krzysztof Kozlowski wrote:
>>> On 23/11/2025 09:35, Amit Sunil Dhamne via B4 Relay wrote:
>>>> From: Amit Sunil Dhamne <amitsd@google.com>
>>>>
>>>> Add bindings for Maxim max77759 charger device.
>>>>
>>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>>> ---
>>>>   .../power/supply/maxim,max77759-charger.yaml       | 36 ++++++++++++++++++++++
>>>>   1 file changed, 36 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
>>>> new file mode 100644
>>>> index 000000000000..71f866419774
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
>>>> @@ -0,0 +1,36 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/power/supply/maxim,max77759-charger.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Maxim Integrated MAX77759 Battery charger
>>>> +
>>>> +maintainers:
>>>> +  - Amit Sunil Dhamne <amitsd@google.com>
>>>> +
>>>> +description: |
>>>> +  This module is part of the MAX77759 PMIC. For additional information, see
>>>> +  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
>>>> +
>>>> +  The Maxim MAX77759 is a dual input switch mode battery charger for portable
>>>> +  applications. It supports wired and wireless charging and can operate in buck
>>>> +  and boost mode.
>>>> +
>>>> +allOf:
>>>> +  - $ref: power-supply.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: maxim,max77759-charger
>>>> +
>>> This should be just folded into parent node, no need for separate
>>> charger device or is just incomplete.
>> Thanks for the review! You are right, the binding is incomplete. This
>> charger block actually listens on its own I2C address, distinct from the
>> main PMIC.
>>
>> I will update v2 to include the reg property. I will also add the
> AFAIK, the main (parent) device schema does not reference children via
> any sort of addressing, so reg here would not be suitable.

I agree that currently nvmem and gpio devices (which are children of 
PMIC device) are not referenced using any address. But I was guessing 
that's because they share the i2c client id with the PMIC and sharing 
its address space (implied).

The charger device while being part of the MAX77759 PMIC package has 
it's own i2c client id and address space that's why I proposed "reg". 
The underlying assumption I made was separate client id implies that a 
"reg" property required. But maybe that's incorrect.

I can understand the argument against having a "reg" property. As the 
i2c client id will remain same for a max77759 charger device (as it's a 
chip property and not a board property) it will always remain a 
constant. I will drop the "reg" proposal.


>
>> standard properties `constant-charge-current-max-microamp` and
>> `constant-charge-voltage-max-microvolt` to configure the hardware
>> limits, as this charger device does not manage the battery profile
>> directly (that is handled by a separate fuel gauge).
> Well, still, what's the benefit for the bindings to have it as a
> separate child? Kind of depends on your example, which is quite small -
> one regulator and supply. Grow the example with battery and other
> independent resources (if they are) to justify it. Or show arguments why
> this is re-usable.

The primary reasons for keeping the charger as a distinct child node are 
to model the hardware topology for the power supply subsystem and to 
house the OTG regulator provided by the charger block.
The charger needs to be referenced by the Fuel Gauge (which handles the 
battery profile) via power-supplies. Additionally, the charger block 
provides a regulator for USB OTG VBUS, which is cleaner to represent as 
a child node of the charger rather than mixing it into the top-level 
PMIC node.

The final goal is to correctly represent the hardware connections so 
that I can use it for [2]. The dts would ideally look like this:

```

maxtcpc: usb-typec@25 {
         compatible = "maxim,max77759-tcpci";
         ...
         otg-vbus-supply = <&otg_vbus_reg>;
};

pmic@66 {

         compatible = "maxim,max77759";
         ....
         chg: charger {
                 compatible = "maxim,max77759-charger";
                 power-supplies = <&maxtcpc>;
                 otg_vbus_reg: usb-otg-vbus-regulator {
                         regulator-name = "usb-otg-vbus"

                 };

         };

};

battery: battery {
     compatible = "simple-battery";
     ....

};

fuel-guage@36 {
         compatible = "maxim,max77759-fg";
         ....
         power-supplies = <&chg>;
         monitored-battery = <&battery>;

};

```

[1] 
https://lore.kernel.org/all/20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be/

[2] 
https://lore.kernel.org/all/20250507-batt_ops-v2-0-8d06130bffe6@google.com/


BR,

Amit

>
> Best regards,
> Krzysztof
>

