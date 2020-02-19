Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C912163DF3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 08:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgBSHkc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 02:40:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42636 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgBSHkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 02:40:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01J7eCE9039727;
        Wed, 19 Feb 2020 01:40:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582098012;
        bh=VaG7B2bGbHNlAfHLv9Ip0v42uYVXRIDKNvFcIuScbYw=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=q9i5Ygiz8OfuCBFhUGMe5KWJiArr5HftFtDaiDyPd8HHxDwgKm72sQr0xugcN/br8
         ps8KUzpV5mUHKnGTRgSx3FzpCJRLcRtGfWmCiikxWPp2LM0OfZq+DSMBfjubxPSH27
         ql4N0DeM6myYiGZ/U4xofSz7POyS03Ap7TYflsUU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01J7eCWc120603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Feb 2020 01:40:12 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 19
 Feb 2020 01:40:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 19 Feb 2020 01:40:11 -0600
Received: from [10.24.69.174] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01J7e8tQ093251;
        Wed, 19 Feb 2020 01:40:08 -0600
From:   Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: k3: Add VTM bindings
 documentation
To:     Rob Herring <robh@kernel.org>
CC:     <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
References: <20200214063443.23589-1-j-keerthy@ti.com>
 <20200214063443.23589-2-j-keerthy@ti.com> <20200218202048.GA32279@bogus>
Message-ID: <6895cf5e-9195-c914-f4ce-a83f36027dbf@ti.com>
Date:   Wed, 19 Feb 2020 13:10:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218202048.GA32279@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 19/02/20 1:50 am, Rob Herring wrote:
> On Fri, 14 Feb 2020 12:04:40 +0530, Keerthy wrote:
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
>> Changes in v2:
>>
>>    * Fixed make dt_binding_check errors.
>>
>>   .../bindings/thermal/ti,am654-thermal.yaml    | 57 +++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> Error: Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dts:21.41-42 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml] Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1237882
> Please check and re-submit.

Rob,

I am using:

Tree: https//github.com/devicetree-org/dt-schema.git
branch: master

I have make dt_binding_check working for 
Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml

Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dts
is created without any errors :

https://pastebin.ubuntu.com/p/6MkMbKPpbY/

I did not see any errors as the other files erred out.

Today i tried with DT_SCHEMA_FILES option and then finally reproduced 
the errors. It is a bit confusing for the first time users.

Now i have it compiled without any errors.

Posting v3 in a bit.

- Keerthy


> 
