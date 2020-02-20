Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D817216561E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 05:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBTENJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 23:13:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43230 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgBTENJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 23:13:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01K4CuOG110720;
        Wed, 19 Feb 2020 22:12:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582171976;
        bh=VnPvu6lppxPv2dAKzH9uu04g0NKMjMplhPQHKEVZkYQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=B722om15HqawzVDoJiHSFhM8PBZDDsGrXsRDRpnPmdR0juUnMEVWjSl2YfIv+igMb
         OHh96HuFmTEpBHucnG08YMMrsPhGpb9S0mMq0Pb96VW/iPNmB3pX63P/kt8P4c8Gc9
         snGryF61C+HuGEiobV1QYz+3+rFJ8G55bFbb+Wn0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01K4Cu4w025017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Feb 2020 22:12:56 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 19
 Feb 2020 22:12:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 19 Feb 2020 22:12:56 -0600
Received: from [10.24.69.174] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01K4Cqv0056397;
        Wed, 19 Feb 2020 22:12:53 -0600
Subject: Re: [PATCH v3 1/4] dt-bindings: thermal: k3: Add VTM bindings
 documentation
To:     Rob Herring <robh@kernel.org>
CC:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>, <t-kristo@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
References: <20200219074314.22829-1-j-keerthy@ti.com>
 <20200219074314.22829-2-j-keerthy@ti.com> <20200219145227.GA1317@bogus>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <55b68963-b931-bf67-482e-146e42af4298@ti.com>
Date:   Thu, 20 Feb 2020 09:42:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219145227.GA1317@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 19/02/20 8:22 pm, Rob Herring wrote:
> On Wed, Feb 19, 2020 at 01:13:11PM +0530, Keerthy wrote:
>> Add VTM bindings documentation. In the Voltage Thermal
>> Management Module(VTM), K3 AM654 supplies a voltage
>> reference and a temperature sensor feature that are gathered in the band
>> gap voltage and temperature sensor (VBGAPTS) module. The band
>> gap provides current and voltage reference for its internal
>> circuits and other analog IP blocks. The analog-to-digital
>> converter (ADC) produces an output value that is proportional
>> to the silicon temperature.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Changes in v3:
>>
>>    * Fixed errors seen with:
>>      dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>>
>>   .../bindings/thermal/ti,am654-thermal.yaml    | 57 +++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>> new file mode 100644
>> index 000000000000..b6dc95c3acab
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>> @@ -0,0 +1,57 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/ti,am654-thermal.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments AM654 VTM (DTS) binding
>> +
>> +maintainers:
>> +  - Keerthy <j-keerthy@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,am654-vtm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +    description: phandle to the associated power domain
> 
> No need to redefine a standard property description.

Okay.

> 
>> +
>> +  "#thermal-sensor-cells":
>> +    const: 1
>> +
>> +required:
>> +  - "#thermal-sensor-cells"
>> +  - compatible
>> +  - reg
>> +  - power-domains
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +    vtm: wkup_vtm0@42050000 {
> 
> thermal-sensor@...
> 
> Use generic node names and don't use '_' in node names

vtm stands for voltage thermal manager and comprises of multiple 
sensors. This is similar to omap bandgap. Should i replace vtm with more 
generic name like thermal? as used in:

Documentation/devicetree/bindings/thermal/st,stm32-thermal.yaml

- Keerthy

> 
>> +        compatible = "ti,am654-vtm";
>> +        reg = <0x0 0x42050000 0x0 0x25c>;
>> +        power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
>> +        #thermal-sensor-cells = <1>;
>> +    };
>> +
>> +    mpu0_thermal: mpu0_thermal {
>> +        polling-delay-passive = <250>; /* milliseconds */
>> +        polling-delay = <500>; /* milliseconds */
>> +        thermal-sensors = <&vtm0 0>;
>> +
>> +        trips {
>> +                mpu0_crit: mpu0_crit {
>> +                        temperature = <125000>; /* milliCelsius */
>> +                        hysteresis = <2000>; /* milliCelsius */
>> +                        type = "critical";
>> +                };
>> +        };
>> +    };
>> +...
>> -- 
>> 2.17.1
>>
