Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A3948B3A4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jan 2022 18:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344084AbiAKRUH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jan 2022 12:20:07 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52282
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344463AbiAKRTx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jan 2022 12:19:53 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 224B13FFD9
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641921592;
        bh=tMk/EODLwapagAZ+KOB7czHiIxd7367rZZ5fV9nlNS8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=gN8NQDkXbI7OYMq1zeW07uihHwXNDGDm64YRhoUwDa4+qLGzYTbCFpN3leexsHJag
         L+nndL0banlNZmSKv8IE2ftjf0E8D3Q2IjUycgplOMaWz6XnU1nZp9qjignarsbHs7
         cBK65BSs1UbVDW1gcPlUqCFaYAvjkp3OifbZj1ve79lByncuFT9UAucIZjx4aKx6TP
         ae1ivUwge7VNq5A1Z1A4G5diUgg7WJKLTnmKio2BzPmE5q5q2oGiCt5NanDM3lWXNJ
         xpv9uw4hewH5I62vvhpe5v65kwu5OXQKlhDNAFDsiqSssNfyreAdVZnYAjbxfZgzzw
         QxyTdo7IYjHsw==
Received: by mail-ed1-f70.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so13928429edb.4
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 09:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tMk/EODLwapagAZ+KOB7czHiIxd7367rZZ5fV9nlNS8=;
        b=TpLEkqRIVVsyMtLtLw7rIbgNFPwHHa5dQ1YxSA2Rea1gu5rbkwqLJpJ0eUJ++WwVkJ
         iYCuTmGJRqApcgclzuXDDqJRPsbu3mBlp33GXRF6NVgz7fhEwL7byxRLla+bQT0G5x7M
         C2Rf86N97y2Rzli0YHdqPt+6MGSfbWJ8gK2JGYiv1JU3cUH3X3BelqU9ClYPQ3m7Rd0I
         U+Iz3H6Umf0THmGOIssRhLvu2wMhfBT9DTUqxUdkXpKahvqPiLoiBLJ8/wZwRyH2eq8T
         /RvIwuZyHfZKvZdg5YRChod2zLSXFhNFn78qNtg8ICIPyYlcp15WJ/32Ofp2aDZTPVJj
         socQ==
X-Gm-Message-State: AOAM531RMhHHaVPnkdkLrzJ3J9AVEtxMnAPh/lVv33KKqkwnHIdRVeEc
        jR/ZGU2WbZ59oDL8B06L6K6Lg1DSaixXszomTo37sQXu4B43s1UrdJsN06JpB+qtS9Iu2ASci8G
        rdfW+iKE45VUeYNlbRxUdGyzMuZl0PLeSdZTV
X-Received: by 2002:a05:6402:50cf:: with SMTP id h15mr5210337edb.318.1641921591713;
        Tue, 11 Jan 2022 09:19:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVuUt4/8KGFqaKtdFM8TbZ8vr/UIvGQ8UctKpKbW9rlOGiZwh6uKpZaZepGYntI6wpKZ2Hlg==
X-Received: by 2002:a05:6402:50cf:: with SMTP id h15mr5210323edb.318.1641921591470;
        Tue, 11 Jan 2022 09:19:51 -0800 (PST)
Received: from [192.168.0.25] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p11sm3757995ejo.136.2022.01.11.09.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 09:19:51 -0800 (PST)
Message-ID: <64649172-e32c-2d1a-9c12-aed562071876@canonical.com>
Date:   Tue, 11 Jan 2022 18:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 4/4] dt-bindings: mfd: maxim,max14577: convert to dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211229141524.34174-1-krzysztof.kozlowski@canonical.com>
 <20211229141524.34174-5-krzysztof.kozlowski@canonical.com>
 <YdyMiHcyKNHipYCE@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YdyMiHcyKNHipYCE@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/01/2022 20:44, Rob Herring wrote:
> On Wed, Dec 29, 2021 at 03:15:24PM +0100, Krzysztof Kozlowski wrote:
>> Convert the MFD part of Maxim MAX14577/MAX77836 MUIC to DT schema
>> format.  The example DTS was copied from existing DTS
>> (exynos3250-rinato.dts), so keep the license as GPL-2.0-only.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../devicetree/bindings/mfd/max14577.txt      | 147 -------------
>>  .../bindings/mfd/maxim,max14577.yaml          | 195 ++++++++++++++++++
>>  MAINTAINERS                                   |   2 +-
>>  3 files changed, 196 insertions(+), 148 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
>>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
>> deleted file mode 100644
>> index be11943a0560..000000000000
>> --- a/Documentation/devicetree/bindings/mfd/max14577.txt
>> +++ /dev/null
>> @@ -1,147 +0,0 @@
>> -Maxim MAX14577/77836 Multi-Function Device
>> -
>> -MAX14577 is a Multi-Function Device with Micro-USB Interface Circuit, Li+
>> -Battery Charger and SFOUT LDO output for powering USB devices. It is
>> -interfaced to host controller using I2C.
>> -
>> -MAX77836 additionally contains PMIC (with two LDO regulators) and Fuel Gauge.
>> -For the description of Fuel Gauge low SOC alert interrupt see:
>> -../power/supply/max17040_battery.txt
>> -
>> -
>> -Required properties:
>> -- compatible : Must be "maxim,max14577" or "maxim,max77836".
>> -- reg : I2C slave address for the max14577 chip (0x25 for max14577/max77836)
>> -- interrupts : IRQ line for the chip.
>> -
>> -
>> -Required nodes:
>> - - charger :
>> -	Node for configuring the charger driver.
>> -	Required properties:
>> -		- compatible : "maxim,max14577-charger"
>> -			or "maxim,max77836-charger"
>> -		- maxim,fast-charge-uamp : Current in uA for Fast Charge;
>> -			Valid values:
>> -			- for max14577: 90000 - 950000;
>> -			- for max77836: 45000 - 475000;
>> -		- maxim,eoc-uamp : Current in uA for End-Of-Charge mode;
>> -			Valid values:
>> -			- for max14577: 50000 - 200000;
>> -			- for max77836: 5000 - 100000;
>> -		- maxim,ovp-uvolt : OverVoltage Protection Threshold in uV;
>> -			In an overvoltage condition, INT asserts and charging
>> -			stops. Valid values:
>> -			- 6000000, 6500000, 7000000, 7500000;
>> -		- maxim,constant-uvolt : Battery Constant Voltage in uV;
>> -			Valid values:
>> -			- 4000000 - 4280000 (step by 20000);
>> -			- 4350000;
>> -
>> -
>> -Optional nodes:
>> -- max14577-muic/max77836-muic :
>> -	Node used only by extcon consumers.
>> -	Required properties:
>> -		- compatible : "maxim,max14577-muic" or "maxim,max77836-muic"
>> -
>> -- regulators :
>> -	Required properties:
>> -		- compatible : "maxim,max14577-regulator"
>> -			or "maxim,max77836-regulator"
>> -
>> -	May contain a sub-node per regulator from the list below. Each
>> -	sub-node should contain the constraints and initialization information
>> -	for that regulator. See regulator.txt for a description of standard
>> -	properties for these sub-nodes.
>> -
>> -	List of valid regulator names:
>> -	- for max14577: CHARGER, SAFEOUT.
>> -	- for max77836: CHARGER, SAFEOUT, LDO1, LDO2.
>> -
>> -	The SAFEOUT is a fixed voltage regulator so there is no need to specify
>> -	voltages for it.
>> -
>> -
>> -Example:
>> -
>> -#include <dt-bindings/interrupt-controller/irq.h>
>> -
>> -max14577@25 {
>> -	compatible = "maxim,max14577";
>> -	reg = <0x25>;
>> -	interrupt-parent = <&gpx1>;
>> -	interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>> -
>> -	muic: max14577-muic {
>> -		compatible = "maxim,max14577-muic";
>> -	};
>> -
>> -	regulators {
>> -		compatible = "maxim,max14577-regulator";
>> -
>> -		SAFEOUT {
>> -			regulator-name = "SAFEOUT";
>> -		};
>> -		CHARGER {
>> -			regulator-name = "CHARGER";
>> -			regulator-min-microamp = <90000>;
>> -			regulator-max-microamp = <950000>;
>> -			regulator-boot-on;
>> -		};
>> -	};
>> -
>> -	charger {
>> -		compatible = "maxim,max14577-charger";
>> -
>> -		maxim,constant-uvolt = <4350000>;
>> -		maxim,fast-charge-uamp = <450000>;
>> -		maxim,eoc-uamp = <50000>;
>> -		maxim,ovp-uvolt = <6500000>;
>> -	};
>> -};
>> -
>> -
>> -max77836@25 {
>> -	compatible = "maxim,max77836";
>> -	reg = <0x25>;
>> -	interrupt-parent = <&gpx1>;
>> -	interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>> -
>> -	muic: max77836-muic {
>> -		compatible = "maxim,max77836-muic";
>> -	};
>> -
>> -	regulators {
>> -		compatible = "maxim,max77836-regulator";
>> -
>> -		SAFEOUT {
>> -			regulator-name = "SAFEOUT";
>> -		};
>> -		CHARGER {
>> -			regulator-name = "CHARGER";
>> -			regulator-min-microamp = <90000>;
>> -			regulator-max-microamp = <950000>;
>> -			regulator-boot-on;
>> -		};
>> -		LDO1 {
>> -			regulator-name = "LDO1";
>> -			regulator-min-microvolt = <2700000>;
>> -			regulator-max-microvolt = <2700000>;
>> -		};
>> -		LDO2 {
>> -			regulator-name = "LDO2";
>> -			regulator-min-microvolt = <800000>;
>> -			regulator-max-microvolt = <3950000>;
>> -		};
>> -	};
>> -
>> -	charger {
>> -		compatible = "maxim,max77836-charger";
>> -
>> -		maxim,constant-uvolt = <4350000>;
>> -		maxim,fast-charge-uamp = <225000>;
>> -		maxim,eoc-uamp = <7500>;
>> -		maxim,ovp-uvolt = <6500000>;
>> -	};
>> -};
>> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max14577.yaml b/Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
>> new file mode 100644
>> index 000000000000..512fd671595c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
>> @@ -0,0 +1,195 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/maxim,max14577.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim MAX14577/MAX77836 MicroUSB and Companion Power Management IC
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +
>> +description: |
>> +  This is a part of device tree bindings for Maxim MAX14577/MAX77836 MicroUSB
>> +  Integrated Circuit (MUIC).
>> +
>> +  The Maxim MAX14577 is a MicroUSB and Companion Power Management IC which
>> +  includes voltage safeout regulators, charger and MicroUSB management IC.
>> +
>> +  The Maxim MAX77836 is a MicroUSB and Companion Power Management IC which
>> +  includes voltage safeout and LDO regulators, charger, fuel-gauge and MicroUSB
>> +  management IC.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - maxim,max14577
>> +      - maxim,max77836
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  wakeup-source: true
>> +
>> +  charger:
>> +    $ref: ../power/supply/maxim,max14577.yaml
> 
> /schemas/power/...
> 
> With those fixed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, fixed also regulator reference below and the regulator bindings
as in my other Maxim patches.


Best regards,
Krzysztof
