Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7AE248C52
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgHRRAe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 13:00:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32996 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgHRQ4T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2020 12:56:19 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07IGuFU8108023;
        Tue, 18 Aug 2020 11:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597769775;
        bh=GsIk/233sXDbKwSAqxENWcQiMVlD1bZlmMIXu/P3m3s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZykcEFHRfrpX++PtZ3aG6D2q0R1u7Xw4LTbvwwQVJFoeh5VnQ80kXP+TxqXH7IN/c
         2lWDQ4fvx8ldYI+z9PYHnX2kBF8TFBtQ8l9lpI/Ndj+89/BLuZMOVrPdi88rbOh0fi
         wQwX/IIgvHgrHAKENX1fShgZkK/tP69oWxhMKqX0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07IGuF40024785;
        Tue, 18 Aug 2020 11:56:15 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 18
 Aug 2020 11:56:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 18 Aug 2020 11:56:10 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07IGuA2I028209;
        Tue, 18 Aug 2020 11:56:10 -0500
Subject: Re: [PATCH v1 1/2] dt-bindings: power: Add the bq256xx dt bindings
To:     Rob Herring <robh@kernel.org>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
CC:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200817191723.22416-1-r-rivera-matos@ti.com>
 <20200817191723.22416-2-r-rivera-matos@ti.com>
 <20200818164305.GB3586878@bogus>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <3928a95f-1f60-5f0f-2cfa-ab9b40038003@ti.com>
Date:   Tue, 18 Aug 2020 11:56:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818164305.GB3586878@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

I think you made a comment on my DT to make this ti,watchdog-timeout-ms 
and then we can remove the type.


>
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Watchdog timer in milli seconds. 0 (default) disables the watchdog
> If you have units, then you should use standard unit suffix.
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
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
> monitored-battery not required?
>
> Add:
>
> additionalProperties: false

What about using

unevaluatedProperties: false

Dan

