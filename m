Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A211F9B01
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 16:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgFOOyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 10:54:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56830 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbgFOOyr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 10:54:47 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05FEsjMp110611;
        Mon, 15 Jun 2020 09:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592232885;
        bh=cjIJPnhR3kqcfNu9LZGQ5SEJ4kOkzzb7m9+JyUtpNrI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=g0G4o2jKVGOR4thr7e5Orlqyed+JShzFdV4ifTlmVgGVo85myCb3YCHGnG4kgQQ0G
         GzsQ1xg4pvnHGmxeGNijwG0ZoyRj+dVzZDCpPKNECG6yXARojQoiDrcucw+4JGlQju
         h6aq4lOX7VD1D5YwIqJMpB/5OQ84pbeBIEvRoBIo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05FEsjV2060326
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Jun 2020 09:54:45 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 15
 Jun 2020 09:54:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 15 Jun 2020 09:54:44 -0500
Received: from [10.250.43.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05FEsiKq087936;
        Mon, 15 Jun 2020 09:54:44 -0500
Subject: Re: [EXTERNAL] Re: [PATCH v12 2/4] dt-bindings: power: Convert
 battery.txt to battery.yaml
To:     Rob Herring <robh@kernel.org>
CC:     <sre@kernel.org>, <pali@kernel.org>, <afd@ti.com>,
        <dmurphy@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sspatil@android.com>
References: <20200528225350.661-1-r-rivera-matos@ti.com>
 <20200528225350.661-3-r-rivera-matos@ti.com> <20200529221613.GA3064745@bogus>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <c4a6ec9b-960d-b91d-6821-7daf225efc13@ti.com>
Date:   Mon, 15 Jun 2020 09:54:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529221613.GA3064745@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 5/29/20 5:16 PM, Rob Herring wrote:
> On Thu, May 28, 2020 at 05:53:48PM -0500, Ricardo Rivera-Matos wrote:
>> From: Dan Murphy <dmurphy@ti.com>
>>
>> Convert the battery.txt file to yaml and fix up the examples.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../bindings/power/supply/battery.txt         |  82 +---------
>>   .../bindings/power/supply/battery.yaml        | 143 ++++++++++++++++++
>>   2 files changed, 144 insertions(+), 81 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> index 3049cf88bdcf..b9a81621ce59 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -1,81 +1 @@
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
>> -
>> -Required Properties:
>> - - compatible: Must be "simple-battery"
>> -
>> -Optional Properties:
>> - - voltage-min-design-microvolt: drained battery voltage
>> - - voltage-max-design-microvolt: fully charged battery voltage
>> - - energy-full-design-microwatt-hours: battery design energy
>> - - charge-full-design-microamp-hours: battery design capacity
>> - - precharge-current-microamp: current for pre-charge phase
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
>> +The contents of this file has been moved to battery.yaml
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
>> new file mode 100644
>> index 000000000000..f0b544a22219
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
>> @@ -0,0 +1,143 @@
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
> I suspect we'll need a battery.yaml and simple-battery.yaml schema if
> these properties are used for other batteries. Not sure really, so fine
> for now.
ACK
>
>> +
>> +  voltage-min-design-microvolt:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> Don't need types on many of these as standard units have a type already.
ACK
>
>> +    description: drained battery voltage
>> +
>> +  voltage-max-design-microvolt:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: fully charged battery voltage
>> +
>> +  energy-full-design-microwatt-hours:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: battery design energy
>> +
>> +  charge-full-design-microamp-hours:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: battery design capacity
>> +
>> +  precharge-current-microamp:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: current for pre-charge phase
>> +
>> +  charge-term-current-microamp:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: current for charge termination phase
>> +
>> +  constant-charge-current-max-microamp:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: maximum constant input current
>> +
>> +  constant-charge-voltage-max-microvolt:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: maximum constant input voltage
>> +
>> +  factory-internal-resistance-micro-ohms:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: battery factory internal resistance
>> +
>> +  ocv-capacity-table-0:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    description: |
>> +      An array providing the open circuit voltage (OCV)
>> +      of the battery and corresponding battery capacity percent, which is used
>> +      to look up battery capacity according to current OCV value. And the open
>> +      circuit voltage unit is microvolt.
>> +
>> +  ocv-capacity-table-1:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    description: Same as ocv-capacity-table-0
>> +
>> +  ocv-capacity-table-n:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    description: Same as ocv-capacity-table-0
> Make this a pattern under patternProperties: '^ocv-capacity-table-[0-9]$'
>
> Is 10 enough or maybe you need more.
>
> maxItems: 100 ?? I asssume 1% granularity would be enough for everyone?
> items:
>    items:
>      - description: open circuit voltage (OCV) in microvolts
>      - description: battery capacity percent
>        maximum: 100
ACK
>
>> +
>> +  ocv-capacity-celsius:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: |
>> +      An array containing the temperature in degree Celsius,
>> +      for each of the battery capacity lookup table. The first temperature value
>> +      specifies the OCV table 0, and the second temperature value specifies the
>> +      OCV table 1, and so on.
>> +
>> +  resistance-temp-table:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    description: |
>> +      An array providing the temperature in degree Celsius
>> +      and corresponding battery internal resistance percent, which is used to
>> +      look up the resistance percent according to current temperature to get an
>> +      accurate batterty internal resistance in different temperatures.
> Similar definition needed here.
ACK
>
>> +
>> +  monitored-battery:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: phandle to the battery node being monitored
> As this is the battery node, this property doesn't belong here.
I am confused about this. I thought the reason Dan converted 
battery.yaml was to make use of this.
>
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    power {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      battery:battery {
>> +        compatible = "simple-battery";
>> +        voltage-min-design-microvolt = <3200000>;
>> +        voltage-max-design-microvolt = <4200000>;
>> +        energy-full-design-microwatt-hours = <5290000>;
>> +        charge-full-design-microamp-hours = <1430000>;
>> +        precharge-current-microamp = <256000>;
>> +        charge-term-current-microamp = <128000>;
>> +        constant-charge-current-max-microamp = <900000>;
>> +        constant-charge-voltage-max-microvolt = <4200000>;
>> +        factory-internal-resistance-micro-ohms = <250000>;
>> +        ocv-capacity-celsius = <(-10) 0 10>;
>> +        ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>;
>> +        ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>;
>> +        resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;
>> +      };
>> +
>> +      charger:charger@11 {
> Drop unused labels.
ACK
>
>> +        reg = <0x11>;
>> +        monitored-battery = <&battery>;
>> +      };
>> +
>> +      fuel_gauge:fuel-gauge@22 {
>> +        reg = <0x22>;
>> +        monitored-battery = <&battery>;
>> +      };
>> +    };
>> -- 
>> 2.26.2
>>
