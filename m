Return-Path: <linux-pm+bounces-778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D322E808366
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 09:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36751C21D4E
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7931C19447;
	Thu,  7 Dec 2023 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c+HI7W2z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB2DD4A
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 00:43:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54dcfca54e0so320092a12.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 00:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701938627; x=1702543427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJsI1iyVrzkD4HE017Pl+ikJ/8c50MiFk/XRDKW8Bao=;
        b=c+HI7W2zzxmytyoUq6ghNTdussr0A8hv0aNNUyS9xjcbLNMhtSymK6FiOWIh2B8PS0
         V5QLlrQoHBep2kbkbjSpT5PqNnOzcU54qaMFFmlYSGA5pQNgHW8YjanPIjZ0Zag1tEMD
         tqFoWeJnMs/apRn7viDE0ZFspWpmZt8HhSliW4eHxnp+jtNI17RNvcVWG7rsnj3bAo4A
         tjNV7h5idKXM9yKac8VqTGPiizlxDXQhW7irDOdRSEXcyFekLIA6qM94VqVWve0H2pCA
         AFoXFWZ3lDYai2iGdm0/q/xxxzOHNdsiwS+loALs0NZbmRbT3xglk9XSorN0mpd9Air+
         mIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701938627; x=1702543427;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJsI1iyVrzkD4HE017Pl+ikJ/8c50MiFk/XRDKW8Bao=;
        b=w3Lzsy/8drqRh90B3rmF7alDeHQheZQKeMQluSuPVZbUnLbr6WwtLXIcdIpC9zN4Cx
         AEAg24yZcp+b4iwH/7Y23lzu1MOrtMJmWt8HRuOemr8CqVLBpI/uSdnGaxn0G7vVPwys
         tif9xFTNbGQLfkP1aVrGPtT4uvD1B9q34CgSrsfXrC9DqO1ELdECaDzkQY9w5BhSM3wO
         vIpoCtNYzVTNWmw3UpyDtvL10oFlF3s6K3X0uEFOzJroCp4RjuO8oyi/PbA4sdLuYLp6
         dXV5/cNvM06TkOYGze0I/XSAfcztgl5XBIeBe0bed1HSaoGeSJvxbPtso5i7gUJjrYx/
         XDtQ==
X-Gm-Message-State: AOJu0YzB7SbUfCAzjOdLMPDXhai02ptJPMrkZh533XHWyzXktCKzDKf0
	5hxxdh8wtsoMrv5vIf5tECV9SQ==
X-Google-Smtp-Source: AGHT+IGXAZfmHKuPnV3Z3Iqo8Tq3e9H4qHa638hZCzYhQXfJC2C4Gu3E0ImYKDSx09n2Ncmvvb3rnQ==
X-Received: by 2002:a17:906:81c2:b0:a19:a1ba:da49 with SMTP id e2-20020a17090681c200b00a19a1bada49mr1467077ejx.112.1701938627315;
        Thu, 07 Dec 2023 00:43:47 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id ov3-20020a170906fc0300b00a1c76114fcesm516299ejb.218.2023.12.07.00.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 00:43:46 -0800 (PST)
Message-ID: <114c9baf-66d1-4055-a47c-916642b6dedd@linaro.org>
Date: Thu, 7 Dec 2023 09:43:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>
Cc: Support Opensource <support.opensource@diasemi.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Steve Twiss <stwiss.opensource@diasemi.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
References: <20231206155740.5278-1-biju.das.jz@bp.renesas.com>
 <20231206155740.5278-9-biju.das.jz@bp.renesas.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231206155740.5278-9-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/12/2023 16:57, Biju Das wrote:
> Convert the da9062 PMIC device tree binding documentation to json-schema.
> 
> Update the example to match reality.
> 
> While at it, update description with link to product information.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Split the thermal binding patch separate.
>  * Updated the description.
> v2->v3:
>  * Fixed bot errors related to MAINTAINERS entry, invalid doc
>    references and thermal examples by merging patch#4.
> v2:
>  * New patch
> ---
>  .../bindings/input/dlg,da9062-onkey.yaml      |   3 +-
>  .../devicetree/bindings/mfd/da9062.txt        | 124 ------------
>  .../devicetree/bindings/mfd/dlg,da9063.yaml   | 186 +++++++++++++++++-
>  .../bindings/thermal/dlg,da9062-thermal.yaml  |   2 +-
>  4 files changed, 183 insertions(+), 132 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml b/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
> index 4cff91f4bd34..18b6a3f02c07 100644
> --- a/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
> +++ b/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
> @@ -11,8 +11,7 @@ maintainers:
>  
>  description: |
>    This module is part of the DA9061/DA9062/DA9063. For more details about entire
> -  DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
> -  For DA9063 see Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> +  DA906{1,2,3} chips see Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
>  
>    This module provides the KEY_POWER event.
>  
> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
> deleted file mode 100644
> index c8a7f119ac84..000000000000
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ /dev/null
> @@ -1,124 +0,0 @@
> -* Dialog DA9062 Power Management Integrated Circuit (PMIC)
> -
> -Product information for the DA9062 and DA9061 devices can be found here:
> -- https://www.dialog-semiconductor.com/products/da9062
> -- https://www.dialog-semiconductor.com/products/da9061
> -
> -The DA9062 PMIC consists of:
> -
> -Device                   Supply Names    Description
> -------                   ------------    -----------
> -da9062-regulator        :               : LDOs & BUCKs
> -da9062-rtc              :               : Real-Time Clock
> -da9062-onkey            :               : On Key
> -da9062-watchdog         :               : Watchdog Timer
> -da9062-thermal          :               : Thermal
> -da9062-gpio             :               : GPIOs
> -
> -The DA9061 PMIC consists of:
> -
> -Device                   Supply Names    Description
> -------                   ------------    -----------
> -da9062-regulator        :               : LDOs & BUCKs
> -da9062-onkey            :               : On Key
> -da9062-watchdog         :               : Watchdog Timer
> -da9062-thermal          :               : Thermal
> -
> -======
> -
> -Required properties:
> -
> -- compatible : Should be
> -    "dlg,da9062" for DA9062
> -    "dlg,da9061" for DA9061
> -- reg : Specifies the I2C slave address (this defaults to 0x58 but it can be
> -  modified to match the chip's OTP settings).
> -
> -Optional properties:
> -
> -- gpio-controller : Marks the device as a gpio controller.
> -- #gpio-cells     : Should be two. The first cell is the pin number and the
> -                    second cell is used to specify the gpio polarity.
> -
> -See Documentation/devicetree/bindings/gpio/gpio.txt for further information on
> -GPIO bindings.
> -
> -- interrupts : IRQ line information.
> -- interrupt-controller
> -
> -See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
> -further information on IRQ bindings.
> -
> -Sub-nodes:
> -
> -- regulators : This node defines the settings for the LDOs and BUCKs.
> -  The DA9062 regulators are bound using their names listed below:
> -
> -    buck1    : BUCK_1
> -    buck2    : BUCK_2
> -    buck3    : BUCK_3
> -    buck4    : BUCK_4
> -    ldo1     : LDO_1
> -    ldo2     : LDO_2
> -    ldo3     : LDO_3
> -    ldo4     : LDO_4
> -
> -  The DA9061 regulators are bound using their names listed below:
> -
> -    buck1    : BUCK_1
> -    buck2    : BUCK_2
> -    buck3    : BUCK_3
> -    ldo1     : LDO_1
> -    ldo2     : LDO_2
> -    ldo3     : LDO_3
> -    ldo4     : LDO_4
> -
> -  The component follows the standard regulator framework and the bindings
> -  details of individual regulator device can be found in:
> -  Documentation/devicetree/bindings/regulator/regulator.txt
> -
> -  regulator-initial-mode may be specified for buck regulators using mode values
> -  from include/dt-bindings/regulator/dlg,da9063-regulator.h.
> -
> -- rtc : This node defines settings required for the Real-Time Clock associated
> -  with the DA9062. There are currently no entries in this binding, however
> -  compatible = "dlg,da9062-rtc" should be added if a node is created.
> -
> -- onkey : See ../input/dlg,da9062-onkey.yaml
> -
> -- watchdog: See ../watchdog/dlg,da9062-watchdog.yaml
> -
> -- thermal : See ../thermal/dlg,da9062-thermal.yaml
> -
> -Example:
> -
> -	pmic0: da9062@58 {
> -		compatible = "dlg,da9062";
> -		reg = <0x58>;
> -		interrupt-parent = <&gpio6>;
> -		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> -		interrupt-controller;
> -
> -		rtc {
> -			compatible = "dlg,da9062-rtc";
> -		};
> -
> -		regulators {
> -			DA9062_BUCK1: buck1 {
> -				regulator-name = "BUCK1";
> -				regulator-min-microvolt = <300000>;
> -				regulator-max-microvolt = <1570000>;
> -				regulator-min-microamp = <500000>;
> -				regulator-max-microamp = <2000000>;
> -				regulator-initial-mode = <DA9063_BUCK_MODE_SYNC>;
> -				regulator-boot-on;
> -			};
> -			DA9062_LDO1: ldo1 {
> -				regulator-name = "LDO_1";
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <3600000>;
> -				regulator-boot-on;
> -			};
> -		};
> -	};
> -
> diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> index 676b4f2566ae..54bb23dbc73f 100644
> --- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> +++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mfd/dlg,da9063.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Dialog DA9063/DA9063L Power Management Integrated Circuit (PMIC)
> +title: Dialog DA906{3L,3,2,1} Power Management Integrated Circuit (PMIC)
>  
>  maintainers:
>    - Steve Twiss <stwiss.opensource@diasemi.com>
> @@ -17,10 +17,17 @@ description: |
>    moment where all voltage monitors are disabled. Next, as da9063 only supports
>    UV *and* OV monitoring, both must be set to the same severity and value
>    (0: disable, 1: enable).
> +  Product information for the DA906{3L,3,2,1} devices can be found here:
> +  - https://www.dialog-semiconductor.com/products/da9063l
> +  - https://www.dialog-semiconductor.com/products/da9063
> +  - https://www.dialog-semiconductor.com/products/da9062
> +  - https://www.dialog-semiconductor.com/products/da9061
>  
>  properties:
>    compatible:
>      enum:
> +      - dlg,da9061
> +      - dlg,da9062
>        - dlg,da9063
>        - dlg,da9063l
>  
> @@ -35,6 +42,19 @@ properties:
>    "#interrupt-cells":
>      const: 2
>  
> +  gpio:

Old binding did not have such node and nothing in commit msg explained
changes from pure conversion.

> +    type: object
> +    $ref: /schemas/gpio/gpio.yaml#

?!? Why? First: It's always selected. Second, so you have two gpio
controllers? And original binding had 0? Why this is not explained at
all? Open the binding and look at its properties.


> +    unevaluatedProperties: false
> +    properties:
> +      compatible:
> +        const: dlg,da9062-gpio
> +
> +  gpio-controller: true

And here is the second gpio-controller...

> +
> +  "#gpio-cells":
> +    const: 2
> +
>    onkey:
>      $ref: /schemas/input/dlg,da9062-onkey.yaml
>  
> @@ -42,7 +62,7 @@ properties:
>      type: object
>      additionalProperties: false
>      patternProperties:
> -      "^(ldo([1-9]|1[01])|bcore([1-2]|s-merged)|b(pro|mem|io|peri)|bmem-bio-merged)$":
> +      "^(ldo([1-9]|1[01])|bcore([1-2]|s-merged)|b(pro|mem|io|peri)|bmem-bio-merged|buck[1-4])$":
>          $ref: /schemas/regulator/regulator.yaml
>          unevaluatedProperties: false
>  
> @@ -52,7 +72,12 @@ properties:
>      unevaluatedProperties: false
>      properties:
>        compatible:
> -        const: dlg,da9063-rtc
> +        enum:
> +          - dlg,da9063-rtc
> +          - dlg,da9062-rtc
> +
> +  thermal:
> +    $ref: /schemas/thermal/dlg,da9062-thermal.yaml
>  
>    watchdog:
>      $ref: /schemas/watchdog/dlg,da9062-watchdog.yaml
> @@ -60,8 +85,65 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-controller
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - dlg,da9063
> +              - dlg,da9063l
> +    then:
> +      properties:
> +        thermal: false
> +        gpio: false
> +        gpio-controller: false
> +        "#gpio-cells": false
> +        regulators:
> +          patternProperties:
> +            "^buck[1-4]$": false
> +      required:
> +        - interrupts
> +        - interrupt-controller
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - dlg,da9062
> +    then:
> +      properties:
> +        regulators:
> +          patternProperties:
> +            "^(ldo([5-9]|10|11)|bcore([1-2]|s-merged)|b(pro|mem|io|peri)|bmem-bio-merged)$": false
> +      required:
> +        - gpio
> +        - onkey
> +        - rtc
> +        - thermal
> +        - watchdog
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - dlg,da9061
> +    then:
> +      properties:
> +        gpio: false
> +        gpio-controller: false
> +        "#gpio-cells": false
> +        regulators:
> +          patternProperties:
> +            "^(ldo([5-9]|10|11)|bcore([1-2]|s-merged)|b(pro|mem|io|peri)|bmem-bio-merged|buck4)$": false
> +        rtc: false
> +      required:
> +        - onkey
> +        - thermal
> +        - watchdog
>  
>  additionalProperties: false
>  
> @@ -118,4 +200,98 @@ examples:
>          };
>        };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/regulator/dlg,da9063-regulator.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pmic@58 {
> +        compatible = "dlg,da9062";
> +        reg = <0x58>;
> +        #interrupt-cells = <2>;
> +        interrupt-parent = <&gpio1>;
> +        interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-controller;
> +
> +        gpio {
> +          compatible = "dlg,da9062-gpio";
> +          status = "disabled";

Why?
Where are gpio-controller and cells? For this node and for parent? Why
this example is incomplete?

> +        };
> +
> +        onkey {
> +          compatible = "dlg,da9062-onkey";
> +        };


Best regards,
Krzysztof


