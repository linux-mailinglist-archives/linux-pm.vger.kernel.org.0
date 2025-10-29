Return-Path: <linux-pm+bounces-37022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51345C1A4CB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 13:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C46567CF1
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4143358D24;
	Wed, 29 Oct 2025 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+WtS5yz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B4346A02
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740557; cv=none; b=NrIJjCtkOJ6fCWwr2qPsvgHo7MfHPU0A/7G5XIQiaUxOGHAsYmKSy6yyMioxNIT6XUwrfseryqIx2R6cUqVl2s5YDvK2IhhCMRy/XSQUMbhFV7VrffxlU8Spdh2oELyxaiUkLNayXu3lyisCP9M6sWVtA3+a9UhEydIn0q1INJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740557; c=relaxed/simple;
	bh=2uVsXjqYAFXDMXZsaLDabWe8n3+FWhGwBNQ1WHtgWew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJHHruDGjCtPLHeq0Lga00tQk7poMfwg8d/3eq3DvT6rzGBwrrHizgHEELgN8BvadjMYoH9gy9ebeqDwTaJVunE8Qun9k9Lhg/IRYh8lN6xBz9AEs7+Mcvbtq4xNR8ehSMoeCWhSDC7MSH9S32YR9mOK6jhzcbZFj6hEO8neCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+WtS5yz; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-378d50162e0so82411571fa.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 05:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761740553; x=1762345353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZgl3eI7vg5tzy1n/3yyz3iAkoVI/IBOnqdMyOqmVk0=;
        b=B+WtS5yzyIwpvOorO9CU/ozNNAtHkPHMMAjXFP3xqgEmQKRpMc19hxES+whEnMzcAP
         Ua+K9G9dmrezmc9/NmRa4iUEjIzTGkY1sJNOcurg27zKfDjsSk7k88GPK2LpN7RGussR
         n+9Antt2eU4T73u4NMvzOvv/58cz8kQd++01nlo8U7vF2ynyxq+t2vixohCpa7fsUsUE
         D7SujO1reH5jhOVg+/rZ7B7kvE2acaQV9nMuMgCcVuLUHdsm5psGYhPJw8Q/kyO8Vcnf
         AhU+tfTqYZReepGb7uXKa+w8I9df0RLPciZwLiEN+nq1O9XO/trAbUFiWpQdpFoyvC53
         Vq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740553; x=1762345353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZgl3eI7vg5tzy1n/3yyz3iAkoVI/IBOnqdMyOqmVk0=;
        b=eFhLRSsC6+bFyqwxz0gxRmZCGS8iBXIkeqAFRcslDdqSA2o0ecFujBSEvJGYKG+bTg
         h1KTL4ZeFLHukSansJnk5DpA7zQkNwQG9tg9tMWiMGKEaOhrCSVfu3fLnaNdjOOoHXpx
         klSpNxRXnVOLFCrqfdErkMgctd2VQnkAEZjyijuAUIyN/gKKKN+s1GyJkqa58sMDgjo7
         UfWf4RqigbEl+TiVOfG+kqnKGNIeqQ/BGsk6eN0m9KZUuxDllsuBoxZddaBVlfWq8hXU
         LJZrF4lpLChxEvN3xz0ItkMGtM3IYPEJz93rK6ur4xBW9scJ7bsyyUKYJ83X0wi5K5JK
         CFww==
X-Forwarded-Encrypted: i=1; AJvYcCUBUbysSPmVmm9nRCpBfm8Rp60CdVkcqMpWeTwgSYVq0Qi618qgTVqOIxJxEkpvhFFnxtfSZf6WBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/S5Resef/NJEiQzv1wMRMtF4233Wm8PBa6WQpPcnunOOtOuIy
	tAbkorqXURZHFSSHKASffTY8E/Sx3B5sYe35i5wq77GuK9QJOVByachh
X-Gm-Gg: ASbGncuobvC60EukLakJjJFja8SHcqk1YpR0bRvzPZA3iGGiQD/AOpWz7cTeUtNOhTo
	9W3x5BKMXFctUi/1kjxdV7XwiO+OVwwhSoKZQ7PoSNtZe8njHYp8UFLTaPp/e6nA2Bc6uEF7gX0
	W1E7F4le25sVKQstKkVuqXhICQGpnXKVUWYJEEOo6tfOIIkAofWv8bJrFBzcto8CWxy+aj/gRoI
	tjq9F43fGghAwJd2vfuVksWmWV3SJSqOsAo50wzLNSq1iPPSxwfhDzZvq6wrXzM4SBMmuK+DhIi
	Tf/14VQYy7cz/B79HGGAFc+rWsmVh9859ri1UfuphPQTTWcCFnzoEWcZUmdI6XU4ZfbcCRma5rj
	ecj8k66GwoxI/RFbHlMhT8v5QhEGBuMrlhRynsi1mJiFXVSTTp85pOvwa8wkcLx4owYZ9NPmyd6
	zqASWg6f60jw==
X-Google-Smtp-Source: AGHT+IE2iQbJln+N7SD4pplQmz5pd5RsqX+x6DtY4QwXN3fjqhUrh1ZJZX1iVGCG3vRTmo+/4QF4Bg==
X-Received: by 2002:a05:651c:1542:b0:36d:114b:52e2 with SMTP id 38308e7fff4ca-37a024017b7mr7425661fa.34.1761740552495;
        Wed, 29 Oct 2025 05:22:32 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee09229asm33470711fa.9.2025.10.29.05.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 05:22:31 -0700 (PDT)
Message-ID: <c28bbb75-36b0-4776-b81c-c5dc2dd5ae28@gmail.com>
Date: Wed, 29 Oct 2025 14:22:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] dt-bindings: mfd: ROHM BD72720
To: Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <a5957c4f83724d4f32527fb892fc340af4eeddde.1761564043.git.mazziesaccount@gmail.com>
 <20251027211351.GC1565353-robh@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251027211351.GC1565353-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2025 23:13, Rob Herring wrote:
> On Mon, Oct 27, 2025 at 01:45:46PM +0200, Matti Vaittinen wrote:
>> The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
>> charger, LEDs, RTC and a clock gate.
>>
>> Add dt-binding doc for ROHM BD72720.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>>   RFCv1 => v2:
>>   - Typofixes
>> ---
>>   .../bindings/mfd/rohm,bd72720-pmic.yaml       | 269 ++++++++++++++++++
>>   1 file changed, 269 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
>> new file mode 100644
>> index 000000000000..b0d4bc01d199
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
>> @@ -0,0 +1,269 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/rohm,bd72720-pmic.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ROHM BD72720 Power Management Integrated Circuit
>> +
>> +maintainers:
>> +  - Matti Vaittinen <mazziesaccount@gmail.com>
>> +
>> +description: |
>> +  BD72720 is a single-chip power management IC for battery-powered portable
>> +  devices. The BD72720 integrates 10 bucks and 11 LDOs, and a 3000 mA
>> +  switching charger. The IC also includes a Coulomb counter, a real-time
>> +  clock (RTC), GPIOs and a 32.768 kHz clock gate.
>> +
>> +# In addition to the properties found from the charger node, the ROHM BD72720
>> +# uses properties from a static battery node. Please see the:
>> +# Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.yaml
> 
> Why is all of this a comment?

Hi Rob,

Thanks for (all the) reviews! Much appreciated.

I added these as comments because they aren't meant to be in the BD72720 
charger-node (which is described by this driver), but in a static 
battery node. The battery node does not belong in the charger node.

My idea was still to document (for integrator) the battery properties 
this charger uses from a static battery node when present. Only thing we 
include directly to this node is the:
monitored-battery = <&battery>; - reference.

> 
>> +#
>> +# Following properties are used
>> +# when present:
>> +#
>> +# charge-full-design-microamp-hours: Battry capacity in mAh
>> +# voltage-max-design-microvolt:      Maximum voltage
>> +# voltage-min-design-microvolt:      Minimum voltage system is still operating.
>> +# degrade-cycle-microamp-hours:      Capacity lost due to aging at each full
>> +#                                    charge cycle.
>> +# ocv-capacity-celsius:              Array of OCV table temperatures. 1/table.
>> +# ocv-capacity-table-<N>:            Table of OCV voltage/SOC pairs. Corresponds
>> +#                                    N.th temperature in ocv-capacity-celsius
>> +#
>> +# ROHM specific properties:
>> +# rohm,voltage-vdr-thresh-microvolt: Threshold for starting the VDR correction
>> +# rohm,volt-drop-soc:                Table of capacity values matching the
>> +#                                    values in VDR tables.
>> +# rohm,volt-drop-high-temp-microvolt: VDR table for high temperature
>> +# rohm,volt-drop-normal-temp-microvolt: VDR table for normal temperature
>> +# rohm,volt-drop-low-temp-microvolt:  VDR table for low temperature
>> +# rohm,volt-drop-very-low-temp-microvolt: VDR table for very low temperature
>> +#
>> +# VDR tables are (usually) determined for a specific battery by ROHM.
>> +# The battery node would then be referred from the charger node:
>> +#
>> +# monitored-battery = <&battery>;
>> +
>> +properties:
>> +  compatible:
>> +    const: rohm,bd72720
>> +
>> +  reg:
>> +    description:
>> +      I2C slave address.
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  gpio-controller: true
>> +
>> +  "#gpio-cells":
>> +    const: 2
>> +    description: |

// snip

>> +
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
> 
> These 2 could be combined into a single entry in patternProperties.
> 
>> +
>> +  rohm,pin-exten0:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: BD72720 has an OTP option to use exten0-pin for different
>> +      purposes. Set this property accordingly.
>> +    const: gpo
>> +
>> +  rohm,pin-exten1:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: BD72720 has an OTP option to use exten1-pin for different
>> +      purposes. Set this property accordingly.
>> +    const: gpo
> 
> And these 2 also.
> 
>> +
>> +  rohm,pin-fault_b:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: BD72720 has an OTP option to use fault_b-pin for different
>> +      purposes. Set this property accordingly.
>> +    const: gpo
> 
> Seems like different purposes would have more than 1 option.

They do. I only omitted them because I don't think knowing those 
use-cases is relevant for the software. OTOH, maybe they some day can be 
so I will revise the other uses and make more complete list. Thanks.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - "#clock-cells"
>> +  - regulators
>> +  - gpio-controller
>> +  - "#gpio-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/leds/common.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        pmic: pmic@4b {
>> +            compatible = "rohm,bd71828";
>> +            reg = <0x4b>;
> 
> Just 1 complete example in the mfd schema and drop this example.

Hmm? This is the MFD schema, right? :)

Yours,
	-- Matti



