Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09324255054
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 23:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgH0VHt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 17:07:49 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53710 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0VHs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 17:07:48 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07RL7kW9085385;
        Thu, 27 Aug 2020 16:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598562466;
        bh=orOymVe73TBSkWAYk73bDZMOSqPRJVCgZxMk1N12HM4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tMbOvipiJAoNYEyyAUvoNpvDYzLS8ljsdiRBT9LmbJscw69BQCWYlnChd0RMXc+5j
         Iqwby4p+0kJqZMx7K1xDG+7UnAUAdM+Ld/qTuSYynC+q/N7xb3B1E/9O1X29LfSp4r
         i4zjQjRSS80J/CM3NPffNutZmNEfLtSsqMiy+ZXQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07RL7kXd060964
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Aug 2020 16:07:46 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 27
 Aug 2020 16:07:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 27 Aug 2020 16:07:46 -0500
Received: from [10.250.66.180] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07RL7j3I073126;
        Thu, 27 Aug 2020 16:07:45 -0500
Subject: Re: [EXTERNAL] Re: [PATCH v1 1/2] dt-bindings: power: Add the bq256xx
 dt bindings
To:     Rob Herring <robh@kernel.org>
CC:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmurphy@ti.com>
References: <20200817191723.22416-1-r-rivera-matos@ti.com>
 <20200817191723.22416-2-r-rivera-matos@ti.com>
 <20200818164305.GB3586878@bogus>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <cf979e7d-2108-8bef-77af-25e152a80173@ti.com>
Date:   Thu, 27 Aug 2020 16:07:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818164305.GB3586878@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rob

On 8/18/20 11:43 AM, Rob Herring wrote:
> On Mon, Aug 17, 2020 at 02:17:22PM -0500, Ricardo Rivera-Matos wrote:
>> Add the bindings for the bq256xx series of battery charging ICs.
>>
>> Datasheets:
>> - https://www.ti.com/lit/ds/symlink/bq25600.pdf
>> - https://www.ti.com/lit/ds/symlink/bq25601.pdf
>> - https://www.ti.com/lit/ds/symlink/bq25600d.pdf
>> - https://www.ti.com/lit/ds/symlink/bq25601d.pdf
>> - https://www.ti.com/lit/ds/symlink/bq25611d.pdf
>> - https://www.ti.com/lit/ds/symlink/bq25618.pdf
>> - https://www.ti.com/lit/ds/symlink/bq25619.pdf
>>
>> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>> ---
>>   .../bindings/power/supply/bq256xx.yaml        | 99 +++++++++++++++++++
>>   1 file changed, 99 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
>> new file mode 100644
>> index 000000000000..67db4ba9fdb6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
>> @@ -0,0 +1,99 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +# Copyright (C) 2020 Texas Instruments Incorporated
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/power/supply/bq256xx.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: TI bq256xx Switch Mode Buck Charger
>> +
>> +maintainers:
>> +  - Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>> +
>> +description: |
>> +  The bq256xx devices are a family of highly-integrated battery charge
>> +  management and system power management ICs for single cell Li-ion and Li-
>> +  polymer batteries.
>> +
>> +  Datasheets:
>> +    - https://www.ti.com/lit/ds/symlink/bq25600.pdf
>> +    - https://www.ti.com/lit/ds/symlink/bq25601.pdf
>> +    - https://www.ti.com/lit/ds/symlink/bq25600d.pdf
>> +    - https://www.ti.com/lit/ds/symlink/bq25601d.pdf
>> +    - https://www.ti.com/lit/ds/symlink/bq25611d.pdf
>> +    - https://www.ti.com/lit/ds/symlink/bq25618.pdf
>> +    - https://www.ti.com/lit/ds/symlink/bq25619.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,bq25600
>> +      - ti,bq25601
>> +      - ti,bq25600d
>> +      - ti,bq25601d
>> +      - ti,bq25611d
>> +      - ti,bq25618
>> +      - ti,bq25619
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  ti,watchdog-timer:
> Poorly named since we have 'ti,watchdog-timers' already and is
> completely different.
ACK, will use ti,watchdog-timeout-ms  instead
>
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Watchdog timer in milli seconds. 0 (default) disables the watchdog
> If you have units, then you should use standard unit suffix.
ACK
>
>> +    minimum: 0
>> +    maximum: 160000
>> +    enum: [ 0, 40000, 80000, 160000]
>> +
>> +  input-voltage-limit-microvolt:
>> +    description: |
>> +       Minimum input voltage limit in micro volts with a 100000 micro volt step
>> +    minimum: 3900000
>> +    maximum: 5400000
>> +
>> +  input-current-limit-microamp:
>> +    description: |
>> +       Maximum input current limit in micro amps with a 100000 micro amp step
>> +    minimum: 100000
>> +    maximum: 3200000
> Aren't these properties of the battery, not the charger?
These are input current and voltage limit for the charger, not the battery
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
> monitored-battery not required?
ACK
>
> Add:
>
> additionalProperties: false
additionalProperties: false or unevaluatedProperties: false
>
>
>> +
>> +examples:
>> +  - |
>> +    bat: battery {
>> +      compatible = "simple-battery";
>> +      constant-charge-current-max-microamp = <2040000>;
>> +      constant-charge-voltage-max-microvolt = <4352000>;
>> +      precharge-current-microamp = <180000>;
>> +      termination-current-microamp = <180000>;
>> +    };
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c0 {
> i2c {
ACK
>
>> +      pinctrl-names = "default";
>> +      pinctrl-0 = <&i2c2_pins>;
> Not relevant to the example.
ACK
>
>> +
>> +      status = "okay";
> Don't show status in examples.
ACK
>
>> +      clock-frequency = <400000>;
>> +
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      bq25601@6b {
> charger@6b
ACK
>
>> +        compatible = "ti,bq25601";
>> +        reg = <0x6b>;
>> +        monitored-battery = <&bat>;
>> +
>> +        interrupt-parent = <&gpio1>;
>> +        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
>> +        watchdog-timer = <40000>;
>> +
>> +        input-voltage-limit-microvolt = <4500000>;
>> +        input-current-limit-microamp = <2400000>;
>> +       };
>> +    };
>> +...
>> -- 
>> 2.28.0
>>
Ricardo
