Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41A122F792
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 20:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgG0SRM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 14:17:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35642 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgG0SRM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 14:17:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06RIH9ME130279;
        Mon, 27 Jul 2020 13:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595873829;
        bh=XZn0oBqm7H2Wj3jkQ1MdF24a746Xzql/Out0DHD3Ei0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sd6cxuro4X7zXK50zLFH5sthib96eCNth3ygm32P2ti6QW5H22B1JbmdMp/rQxEMm
         O/cmEqxMApkaG0briUDTvLAb4VlMuvIli9j0ClFPv/pJWJPA/AufSC/kDn0ONEd5K4
         Rq3GjeinBBVvQAjrcI1CW/ZMr1I4DyZ+yMDSfCe8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06RIH9ra027104
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 13:17:09 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Jul 2020 13:17:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Jul 2020 13:17:08 -0500
Received: from [10.250.43.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06RIH8R1010609;
        Mon, 27 Jul 2020 13:17:08 -0500
Subject: Re: [EXTERNAL] Re: [PATCH v17 2/4] dt-bindings: power: Convert
 battery.txt to battery.yaml
To:     Sebastian Reichel <sre@kernel.org>
CC:     <pali@kernel.org>, <robh@kernel.org>, <afd@ti.com>,
        <dmurphy@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sspatil@android.com>
References: <20200720204400.7351-1-r-rivera-matos@ti.com>
 <20200720204400.7351-3-r-rivera-matos@ti.com>
 <20200726232440.valzl3omfbfyi75z@earth.universe>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <1a779c34-2b11-3b1a-402f-d3e61d6ccac9@ti.com>
Date:   Mon, 27 Jul 2020 13:17:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200726232440.valzl3omfbfyi75z@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/26/20 6:24 PM, Sebastian Reichel wrote:
> Hi,
>
> On Mon, Jul 20, 2020 at 03:43:58PM -0500, Ricardo Rivera-Matos wrote:
>> From: Dan Murphy <dmurphy@ti.com>
>>
>> Convert the battery.txt file to yaml and fix up the examples.
> The examples were correct for the existing binding. What you did
> is completly changing the binding description (without modifying
> the code) resulting in examples and any existing users being
> incorrect and code not matching up with the binding.
ACK
>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../bindings/power/supply/battery.txt         |  86 +---------
>>   .../bindings/power/supply/battery.yaml        | 157 ++++++++++++++++++
>>   2 files changed, 158 insertions(+), 85 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> index 5e29595edd74..a9f80cc49068 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -1,87 +1,3 @@
>> -Battery Characteristics
>> -
>> -The devicetree battery node provides static battery characteristics.
>> -In smart batteries, these are typically stored in non-volatile memory
>> -on a fuel gauge chip. The battery node should be used where there is
>> -no appropriate non-volatile memory, or it is unprogrammed/incorrect.
>> -
>> -Upstream dts files should not include battery nodes, unless the battery
>> -represented cannot easily be replaced in the system by one of a
>> -different type. This prevents unpredictable, potentially harmful,
>> -behavior should a replacement that changes the battery type occur
>> -without a corresponding update to the dtb.
>> +The contents of this file has been moved to battery.yaml
>>   
>>   Please note that not all charger drivers respect all of the properties.
>> -
>> -Required Properties:
>> - - compatible: Must be "simple-battery"
>> -
>> -Optional Properties:
>> - - over-voltage-threshold-microvolt: battery over-voltage limit
>> - - re-charge-voltage-microvolt: limit to automatically start charging again
>> - - voltage-min-design-microvolt: drained battery voltage
>> - - voltage-max-design-microvolt: fully charged battery voltage
>> - - energy-full-design-microwatt-hours: battery design energy
>> - - charge-full-design-microamp-hours: battery design capacity
>> - - trickle-charge-current-microamp: current for trickle-charge phase
>> - - precharge-current-microamp: current for pre-charge phase
>> - - precharge-upper-limit-microvolt: limit when to change to constant charging
>> - - charge-term-current-microamp: current for charge termination phase
>> - - constant-charge-current-max-microamp: maximum constant input current
>> - - constant-charge-voltage-max-microvolt: maximum constant input voltage
>> - - factory-internal-resistance-micro-ohms: battery factory internal resistance
>> - - ocv-capacity-table-0: An array providing the open circuit voltage (OCV)
>> -   of the battery and corresponding battery capacity percent, which is used
>> -   to look up battery capacity according to current OCV value. And the open
>> -   circuit voltage unit is microvolt.
>> - - ocv-capacity-table-1: Same as ocv-capacity-table-0
>> - ......
>> - - ocv-capacity-table-n: Same as ocv-capacity-table-0
>> - - ocv-capacity-celsius: An array containing the temperature in degree Celsius,
>> -   for each of the battery capacity lookup table. The first temperature value
>> -   specifies the OCV table 0, and the second temperature value specifies the
>> -   OCV table 1, and so on.
>> - - resistance-temp-table: An array providing the temperature in degree Celsius
>> -   and corresponding battery internal resistance percent, which is used to look
>> -   up the resistance percent according to current temperature to get a accurate
>> -   batterty internal resistance in different temperatures.
>> -
>> -Battery properties are named, where possible, for the corresponding
>> -elements in enum power_supply_property, defined in
>> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/power_supply.h
>> -
>> -Batteries must be referenced by chargers and/or fuel-gauges
>> -using a phandle. The phandle's property should be named
>> -"monitored-battery".
>> -
>> -Example:
>> -
>> -	bat: battery {
>> -		compatible = "simple-battery";
>> -		voltage-min-design-microvolt = <3200000>;
>> -		voltage-max-design-microvolt = <4200000>;
>> -		energy-full-design-microwatt-hours = <5290000>;
>> -		charge-full-design-microamp-hours = <1430000>;
>> -		precharge-current-microamp = <256000>;
>> -		charge-term-current-microamp = <128000>;
>> -		constant-charge-current-max-microamp = <900000>;
>> -		constant-charge-voltage-max-microvolt = <4200000>;
>> -		factory-internal-resistance-micro-ohms = <250000>;
>> -		ocv-capacity-celsius = <(-10) 0 10>;
>> -		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
>> -		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
>> -		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
>> -		resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;
>> -	};
>> -
>> -	charger: charger@11 {
>> -		....
>> -		monitored-battery = <&bat>;
>> -		...
>> -	};
>> -
>> -	fuel_gauge: fuel-gauge@22 {
>> -		....
>> -		monitored-battery = <&bat>;
>> -		...
>> -	};
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
>> new file mode 100644
>> index 000000000000..d7a2380b46f9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
>> @@ -0,0 +1,157 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/battery.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Battery Characteristics
>> +
>> +maintainers:
>> +  - Sebastian Reichel <sre@kernel.org>
>> +
>> +description: |
>> +  The devicetree battery node provides static battery characteristics.
>> +  In smart batteries, these are typically stored in non-volatile memory
>> +  on a fuel gauge chip. The battery node should be used where there is
>> +  no appropriate non-volatile memory, or it is unprogrammed/incorrect.
>> +
>> +  Upstream dts files should not include battery nodes, unless the battery
>> +  represented cannot easily be replaced in the system by one of a
>> +  different type. This prevents unpredictable, potentially harmful,
>> +  behavior should a replacement that changes the battery type occur
>> +  without a corresponding update to the dtb.
>> +
>> +  Battery properties are named, where possible, for the corresponding elements
>> +  in enum power_supply_property, defined in include/linux/power_supply.h
>> +
>> +  Batteries must be referenced by chargers and/or fuel-gauges using a phandle.
>> +  The phandle's property should be named "monitored-battery".
>> +
>> +properties:
>> +  compatible:
>> +    const: simple-battery
>> +
>> +  over-voltage-threshold-microvolt:
>> +    description: battery over-voltage limit
>> +
>> +  re-charge-voltage-microvolt:
>> +    description: limit to automatically start charging again
>> +
>> +  voltage-min-design-microvolt:
>> +    description: drained battery voltage
>> +
>> +  voltage-max-design-microvolt:
>> +    description: fully charged battery voltage
>> +
>> +  energy-full-design-microwatt-hours:
>> +    description: battery design energy
>> +
>> +  charge-full-design-microamp-hours:
>> +    description: battery design capacity
>> +
>> +  trickle-charge-current-microamp:
>> +    description: current for trickle-charge phase
>> +
>> +  precharge-current-microamp:
>> +    description: current for pre-charge phase
>> +
>> +  precharge-upper-limit-microvolt:
>> +    description: limit when to change to constant charging
>> +
>> +  charge-term-current-microamp:
>> +    description: current for charge termination phase
>> +
>> +  constant-charge-current-max-microamp:
>> +    description: maximum constant input current
>> +
>> +  constant-charge-voltage-max-microvolt:
>> +    description: maximum constant input voltage
>> +
>> +  factory-internal-resistance-micro-ohms:
>> +    description: battery factory internal resistance
>> +
>> +  monitored-battery:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: phandle to the battery node being monitored
> monitored-battery is not a valid property of simple-battery node
> (the one having compatible = "simple-battery"). It needs to be
> listed in the binding _using_ simple-battery (which you did in
> the bq2515x binding). Drop it.
ACK
>
>> +required:
>> +  - compatible
>> +
>> +patternProperties:
>> +  '^ocv-capacity-table-[0-100]$':
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    description: |
>> +      An array providing the open circuit voltage (OCV)
>> +      of the battery and corresponding battery capacity percent, which is used
>> +      to look up battery capacity according to current OCV value. And the open
>> +      circuit voltage unit is microvolt.
>> +    maxItems: 100
>> +    items:
>> +      items:
>> +        - description: open circuit voltage (OCV) in microvolts
>> +        - description: battery capacity percent
>> +          maximum: 100
> This looks ok.
Sounds good
>
>> +  '^resistance-temp-table-[0-100]$':
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    description: |
>> +      An array providing the temperature in degree Celsius
>> +      and corresponding battery internal resistance percent, which is used to
>> +      look up the resistance percent according to current temperature to get an
>> +      accurate batterty internal resistance in different temperatures.
>> +    maxItems: 100
>> +    items:
>> +      items:
>> +        - description: internal resistance percent
>> +        - description: battery capacity percent
>> +          maximum: 100
> This is a single property ("resistance-temp-table") describing
> a graph with temperature on one axis and battery internal resistance
> on the other axis. The first cell is temperature in degree Celsius
> and the second cell is internal resistance percentage. So old
> example
>
> resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;
>
> translates into
>
> 20° => 100% of "factory-internal-resistance-micro-ohms"
> 10° => 90% of "factory-internal-resistance-micro-ohms"
Okay thanks for explaining this.
>
>> +  '^ocv-capacity-celsius-[0-100]$':
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    description: |
>> +      An array containing the temperature in degree Celsius,
>> +      for each of the battery capacity lookup table.
>> +    maxItems: 100
>> +    items:
>> +      items:
>> +        - description: temperature in degree Celsius
>> +        - description: battery capacity percent
>> +          maximum: 100
> This is also incorrect. This is a single property ("ocv-capacity-celsius"),
> which is the lookup table for "^ocv-capacity-table-[0-100]$". It maps
> ocv-capacity tables to temperatures. Let me use the example from the
> old *.txt binding again:
>
> ocv-capacity-celsius = <(-10) 0 10>;
> ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
> ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
> ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
>
> -10 degree Celsius is index 0, so ocv-capacity-table-0 should be
> used for -10 degrees Celsius.
>
> 0 degrees Celsius is index 1, so ocv-capacity-table-1 should
> be used for this temperature.
>
> 10 degrees Celsius is index 2, so ocv-capacity-table-2
> should be used for this temperature.
ACK
>
> -- Sebastian
>
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    power {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      battery: battery {
>> +        compatible = "simple-battery";
>> +        over-voltage-threshold-microvolt = <4500000>;
>> +        re-charge-voltage-microvolt = <250000>;
>> +        voltage-min-design-microvolt = <3200000>;
>> +        voltage-max-design-microvolt = <4200000>;
>> +        energy-full-design-microwatt-hours = <5290000>;
>> +        charge-full-design-microamp-hours = <1430000>;
>> +        precharge-current-microamp = <256000>;
>> +        precharge-upper-limit-microvolt = <2500000>;
>> +        charge-term-current-microamp = <128000>;
>> +        constant-charge-current-max-microamp = <900000>;
>> +        constant-charge-voltage-max-microvolt = <4200000>;
>> +        factory-internal-resistance-micro-ohms = <250000>;
>> +        ocv-capacity-celsius-0 = <(-10) 10>;
>> +        ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>;
>> +        resistance-temp-table-0 = <20 100>, <10 90>, <0 80>, <(-10) 60>;
>> +      };
>> +
>> +      charger@11 {
>> +        reg = <0x11>;
>> +        monitored-battery = <&battery>;
>> +      };
>> +
>> +      fuel-gauge@22 {
>> +        reg = <0x22>;
>> +        monitored-battery = <&battery>;
>> +      };
>> +    };
>> -- 
>> 2.27.0
