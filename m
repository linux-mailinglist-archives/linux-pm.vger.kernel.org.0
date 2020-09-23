Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211CB274E40
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 03:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIWBO6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 21:14:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39534 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIWBO5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 21:14:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08N1EtHk066667;
        Tue, 22 Sep 2020 20:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600823695;
        bh=wcSWEBmH5x1ltGxwEa7htad4Yz2JjO8aFqarvE2rOQI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yXUvEOfn/ErtQDmh8GU1GtIqjt4Aq9e+sOV/Qxhg29ng5LnZsTuopTOcbp2vSbPuL
         6S4tOq916GMltAHD8BWkYBl/aIOq3iUEwT4vUq3x7uI1TL/8E0qzZPK1D6YOpTIJVh
         BgV9OqDwyXbeyv9/PziAecUvrvSmESRaOwEeKi4g=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08N1Etoi040566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 20:14:55 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Sep 2020 20:14:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Sep 2020 20:14:54 -0500
Received: from [10.250.32.225] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08N1Esp0034162;
        Tue, 22 Sep 2020 20:14:54 -0500
Subject: Re: [EXTERNAL] Re: [PATCH v3 1/2] dt-bindings: power: Add the bq256xx
 dt bindings
To:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
CC:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200910164534.16987-1-r-rivera-matos@ti.com>
 <20200910164534.16987-2-r-rivera-matos@ti.com>
 <20200922222203.GA3360459@bogus>
 <db285d10-2c9a-22bc-1853-cf6e24486d27@ti.com>
 <4d53d479-94b1-8c34-c4f4-a50e12f08a2b@ti.com>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <86462574-2f6e-070e-9a79-fed39d120288@ti.com>
Date:   Tue, 22 Sep 2020 20:14:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4d53d479-94b1-8c34-c4f4-a50e12f08a2b@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dan

On 9/22/20 8:05 PM, Dan Murphy wrote:
> RIcardo
>
> On 9/22/20 5:56 PM, Ricardo Rivera-Matos wrote:
>> Rob
>>
>> On 9/22/20 5:22 PM, Rob Herring wrote:
>>> On Thu, Sep 10, 2020 at 11:45:33AM -0500, Ricardo Rivera-Matos wrote:
>>>> Add the bindings for the bq256xx series of battery charging ICs.
>>>>
>>>> Datasheets:
>>>> - https://www.ti.com/lit/ds/symlink/bq25600.pdf
>>>> - https://www.ti.com/lit/ds/symlink/bq25601.pdf
>>>> - https://www.ti.com/lit/ds/symlink/bq25600d.pdf
>>>> - https://www.ti.com/lit/ds/symlink/bq25601d.pdf
>>>> - https://www.ti.com/lit/ds/symlink/bq25611d.pdf
>>>> - https://www.ti.com/lit/ds/symlink/bq25618.pdf
>>>> - https://www.ti.com/lit/ds/symlink/bq25619.pdf
>>>>
>>>> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>>>> ---
>>>>   .../bindings/power/supply/bq256xx.yaml        | 97 
>>>> +++++++++++++++++++
>>>>   1 file changed, 97 insertions(+)
>>>>   create mode 100644 
>>>> Documentation/devicetree/bindings/power/supply/bq256xx.yaml
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml 
>>>> b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
>>>> new file mode 100644
>>>> index 000000000000..8cc2242f7df0
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
>>>> @@ -0,0 +1,97 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>>>> +# Copyright (C) 2020 Texas Instruments Incorporated
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: "http://devicetree.org/schemas/power/supply/bq256xx.yaml#"
>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>> +
>>>> +title: TI bq256xx Switch Mode Buck Charger
>>>> +
>>>> +maintainers:
>>>> +  - Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>>>> +
>>>> +description: |
>>>> +  The bq256xx devices are a family of highly-integrated battery 
>>>> charge
>>>> +  management and system power management ICs for single cell 
>>>> Li-ion and Li-
>>>> +  polymer batteries.
>>>> +
>>>> +  Datasheets:
>>>> +    - https://www.ti.com/lit/ds/symlink/bq25600.pdf
>>>> +    - https://www.ti.com/lit/ds/symlink/bq25601.pdf
>>>> +    - https://www.ti.com/lit/ds/symlink/bq25600d.pdf
>>>> +    - https://www.ti.com/lit/ds/symlink/bq25601d.pdf
>>>> +    - https://www.ti.com/lit/ds/symlink/bq25611d.pdf
>>>> +    - https://www.ti.com/lit/ds/symlink/bq25618.pdf
>>>> +    - https://www.ti.com/lit/ds/symlink/bq25619.pdf
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - ti,bq25600
>>>> +      - ti,bq25601
>>>> +      - ti,bq25600d
>>>> +      - ti,bq25601d
>>>> +      - ti,bq25611d
>>>> +      - ti,bq25618
>>>> +      - ti,bq25619
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  ti,watchdog-timer:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description: |
>>>> +      Watchdog timer in ms. 0 (default) disables the watchdog
>>>> +    minimum: 0
>>>> +    maximum: 160000
>>>> +    enum: [ 0, 40000, 80000, 160000]
>>>> +
>>>> +  input-voltage-limit-microvolt:
>>>> +    description: |
>>>> +       Minimum input voltage limit in µV with a 100000 µV step
>>>> +    minimum: 3900000
>>>> +    maximum: 5400000
>>>> +
>>>> +  input-current-limit-microamp:
>>>> +    description: |
>>>> +       Maximum input current limit in µA with a 100000 µA step
>>>> +    minimum: 100000
>>>> +    maximum: 3200000
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - monitored-battery
>>> additionalProperties: false
>>>
>>> And then fix what breaks in the example.
>> ACK. I will document the monitored-battery and interrupts properties 
>> and fix the example. Is ti,watchdog-timer okay as it is currently 
>> documented?
>
> For TI consistency please use ti,watchdog-timeout-ms
ACK, thanks.
>
> Dan
>
> Ricardo

