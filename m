Return-Path: <linux-pm+bounces-18371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30AF9E0B1A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 19:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C7C282186
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2DB1DDC39;
	Mon,  2 Dec 2024 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjrBh33F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336270805;
	Mon,  2 Dec 2024 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164483; cv=none; b=qjsReaRB9IhQNwTwJ00z5XNlW35jkKodaReVe/FqD/sVgGQq3vJpzI507MBLucddt/D03A10QqneAgno5tx/NGdViTsypQimCL+az197YbSroI1ClRG3iIZ9hsG1q8+fuAb5tFI8xZWqptTSlgOYdr7PGNXy075tzf/Ne2dZBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164483; c=relaxed/simple;
	bh=w7+TjjMa4hcPmMEI/iUbF42Sq9G4esf/zUXgYlaYYQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0zFmTOMbqTrflL7kdmVASFYiFxHPG+mzZ7lni6X9ABznDpvCwHTplfW6BlA1de887cllhaJVPAKUPADH39NUqmj1pNDZ+F47QLSGunTIxLn4icuMOX/H+mForp/g1m93YQ+soSSvtcT7x3oAkectf12UcQ5FE44a4Ne9rE4qxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjrBh33F; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385d6e36de7so4023942f8f.0;
        Mon, 02 Dec 2024 10:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733164479; x=1733769279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdNngqGjPgL3P4DeiY0oFYOBDi1lPXH2hvH4Y2w5NdU=;
        b=hjrBh33FU3EWh5qHHe0crcBLobRGwFCApBNy8N5quWwJ4dA6zHBH56dZ0icTRtLaHt
         9B0/ol8UN1nPJclTvc9OPqcdSU2qpxyB4SnBGnJeIpYIDLVnUEa49Bw5MqGdmd3VPcaQ
         1a9UuH5deA1ldOPoQwRpBViGAEEXgwlVtExmRJKe6+1KdDKqE0d6l4p5Ypus5qkRMeO5
         JyeQ3CQFWMrPSbCnHfvvGFTPGxLr8gmhFG3oMd/Ag9cER5uK37c+l1/jbaeHjd8T7Kzn
         by2N5eEuWFHC6FHVrNIcaMsVO1LbwkwgZ++P9B7pJ4hDhEwxEjnZpQBZUEYgxrfJZZ8E
         +zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733164479; x=1733769279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdNngqGjPgL3P4DeiY0oFYOBDi1lPXH2hvH4Y2w5NdU=;
        b=pe5YgFGkULWuqLCDxmuUz1+Uwo7vHcLbIEHwmLvjDEpUIAv8HTlkxE5a0ILN/t1sqx
         jo0AUs2UF4RFF+zal+caUelsDv5dSC/5xrEhr6BtpwQjzegru9qgxBwPyCZcA3tnzRGe
         cOQGmDSFhjA5UoSWeD/GI3g0GHjeTj6f5geJXZbGhAVPOwfmMHuP9b2T2YauU3FBGBTC
         s4+sA3RU2gFy95Wya3Vv2ursnNtsIrzcikwEsueNCi3LpDjNZtB/o7a0CR2yNMqQQYC6
         lXWL+HQKPU8W79k0XI6B6oPUm4Bs7cUJBODG4xMSpJjlWIaTg07tLdd49wzjdi9GFeLN
         9New==
X-Forwarded-Encrypted: i=1; AJvYcCU2bnjNmnRUKKZtZT5Kwp3ZXSUOuKaBh7t33ZAaXtgVI8jI5R23UoMrTQa5ZSEeaelGk23jQEFNrYl3IxA7@vger.kernel.org, AJvYcCV71skKavwBkRNUNvGONoAZz5TOxfPJ75VC4yCGuzuf438lDefflL5/Aio9PDtbkxsLeUcFl43BCuuf+M8=@vger.kernel.org, AJvYcCVnD52etRDOQ5Tkl+ghw+PX8Tb4oY9jBtLUQhfNhT0/jqG+j4Q9OyBNNTWD8MWD4I02CKhKm7USBGHu@vger.kernel.org, AJvYcCXF+IFYdyFIkSC8rr4vcVEO6ipSGvHwPa0LzoWT8NkLSS6dCgDnubXnrjri+kEKXmXppbWoMSLWvZMtSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGh8fjC8ME0gdsKEfQGQ5UkzKXXelMfgcX4l2kMLirnyy+A00
	V8R/vE2nyZ1rPOysQvMAHx8IxcXBIEGDdwlaxAECWZ89fOJ5s6fC
X-Gm-Gg: ASbGnctgABe2oEYyttMKMdDfyivdG3e9e6aWSi7YLoi8R/T4A11n2mRJaaAY5sNQ4WF
	h6OUCIaB4hnnN18bHPBEVKHF8qEQTa/j6pLrgf/QjMa93PFXYX4BAYPbNVYUc/Nw5vmJS0gqa+v
	ZTLZoolX8vbYJiSGXBkA41GoB7pUECwXD0jXKltV4ExgYA1vcFlyz48cvsx7rOLchZipTvqVrk0
	v+LXu3VaGkoCrGmv0YgE+AEb2wKATMnBTtefoU+B0D5D95AORvJ7eOmCU6vLrQ=
X-Google-Smtp-Source: AGHT+IFTs9nQsYKTa8mf+UgRlTGVkJvOJrefe9/gekWw/ONQ/23aZWmDIeD6FYulsuhRtZb/LhW6/w==
X-Received: by 2002:a05:6000:1a8f:b0:385:e3c2:a47d with SMTP id ffacd0b85a97d-385e3c2a4ebmr10128976f8f.23.1733164478708;
        Mon, 02 Dec 2024 10:34:38 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0c93e5d37sm3203030a12.35.2024.12.02.10.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 10:34:37 -0800 (PST)
Message-ID: <dd08d546-b4a0-c3e0-685d-6b742bf73fb2@gmail.com>
Date: Mon, 2 Dec 2024 19:34:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 4/9] dt-bindings: mfd: add maxim,max77705
Content-Language: en-US
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Hans de Goede <hdegoede@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
 <20241202-starqltechn_integration_upstream-v9-4-a1adc3bae2b8@gmail.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20241202-starqltechn_integration_upstream-v9-4-a1adc3bae2b8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dzmitry,

On 12/2/24 10:47, Dzmitry Sankouski wrote:
> Add maxim,max77705 binding.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes in v9:
> - replace max77705 fuel gauge with max17042
> - remove monitored battery because not supported by max17042
> 
> Changes in v8:
> - fix leds compatible
> 
> Changes in v6:
> - unevaluatedProperties must be false
> - drop excessive sentence from description,
>    just describe the device
> - change leds compatible to maxim,max77705-rgb
> 
> Changes in v5:
> - formatting changes
> - add unevaluatedProperties: false for nodes referencing
>    common schemas
> - remove additionalProperties on nodes with
>    unevaluatedProperties: false
> - add min and max to led index
> Changes in v4:
> - change dts example intendation from tabs
>   to spaces
> - remove interrupt-names property
> - remove obvious reg description
> - split long(>80) lines
> ---
>   Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   MAINTAINERS                                               |   1 +
>   2 files changed, 156 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
> new file mode 100644
> index 000000000000..fbc264cfc609
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77705 Companion Power Management IC and USB Type-C interface IC
> +
> +maintainers:
> +  - Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +description: |
> +  The Maxim MAX77705 is a Companion Power Management and Type-C
> +  interface IC which includes charger, fuelgauge, LED, haptic motor driver and
> +  Type-C management IC.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77705
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  charger:
> +    $ref: /schemas/power/supply/power-supply.yaml
> +    unevaluatedProperties: false
> +    properties:
> +      compatible:
> +        const: maxim,max77705-charger
> +
> +    required:
> +      - compatible
> +      - monitored-battery
> +
> +  fuel-gauge:
> +    $ref: /schemas/power/supply/maxim,max17042.yaml#
> +
> +  haptic:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: maxim,max77705-haptic
> +
> +      haptic-supply: true
> +
> +      pwms:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - haptic-supply
> +      - pwms
> +
> +  leds:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Up to 4 LEDs supported. One LED is represented by one child node.
> +
> +    properties:
> +      compatible:
> +        const: maxim,max77705-rgb
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^led@[0-3]$":
> +        $ref: /schemas/leds/common.yaml#
> +        type: object
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            description: LED index.
> +            minimum: 0
> +            maximum: 3
> +
> +        required:
> +          - reg
> +
> +    required:
> +      - compatible
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/leds/common.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@66 {
> +            compatible = "maxim,max77705";
> +            reg = <0x66>;
> +            interrupt-parent = <&pm8998_gpios>;
> +            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +            pinctrl-0 = <&chg_int_default>;
> +            pinctrl-names = "default";
> +
> +            leds {
> +                compatible = "maxim,max77705-rgb";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                led@1 {
> +                    reg = <1>;
> +                    label = "red:usr1";

In the driver you're using devm_led_classdev_register_ext(), but in DT
example you're proposing to use legacy 'label' property, instead of
'color' and 'function' devm_led_classdev_register_ext() is able to
parse. Either use devm_led_classdev_register() (discouraged), or modify
this example to use modern LED DT properties.

> +                };
> +
> +                led@2 {
> +                    reg = <2>;
> +                    label = "green:usr2";
> +                };
> +
> +                led@3 {
> +                    reg = <3>;
> +                    label = "blue:usr3";
> +                };
> +            };
> +
> +            max77705_charger: charger {
> +                compatible = "maxim,max77705-charger";
> +                monitored-battery = <&battery>;
> +            };
> +
> +            fuel-gauge {
> +                compatible = "maxim,max77705-battery";
> +                power-supplies = <&max77705_charger>;
> +                maxim,rsns-microohm = <5000>;
> +            };
> +
> +            haptic {
> +                compatible = "maxim,max77705-haptic";
> +                haptic-supply = <&vib_regulator>;
> +                pwms = <&vib_pwm 0 50000>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1240e75ecf4b..c3f66093edd1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14185,6 +14185,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
>   F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
>   F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
>   F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
> +F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
>   F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
>   F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
>   F:	drivers/*/*max77843.c
> 

-- 
Best regards,
Jacek Anaszewski

