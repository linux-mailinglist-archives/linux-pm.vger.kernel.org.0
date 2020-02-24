Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D81C8169BA3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 02:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBXBNB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Feb 2020 20:13:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48240 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXBNB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Feb 2020 20:13:01 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01O1Cl99116584;
        Sun, 23 Feb 2020 19:12:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582506767;
        bh=IqVWASLT7aINSbL5SEyNqr9FEXULB8G5X7AY+iwQoX4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=G5rowaEp6JlthuiWuocNqdJxXGH2PUygMpd9oymQNtxnZbSCwac80hGHlk7eU67vc
         DyNpwvT26Uleu33CUthsYe7/cQhgmO9iInF7VMJjgqzZh8yJ48qVW71YfFOwdk4R/i
         oZ5TNU8/m293ezyP2z/r8tritGHMOWDzjAXrM7vQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01O1ClLZ121797
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Feb 2020 19:12:47 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 23
 Feb 2020 19:12:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 23 Feb 2020 19:12:46 -0600
Received: from [10.250.132.7] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01O1ChMI046730;
        Sun, 23 Feb 2020 19:12:43 -0600
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: k3: Add VTM bindings
 documentation
To:     Rob Herring <robh@kernel.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Tero Kristo <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20200214063443.23589-1-j-keerthy@ti.com>
 <20200214063443.23589-2-j-keerthy@ti.com> <20200218202048.GA32279@bogus>
 <6895cf5e-9195-c914-f4ce-a83f36027dbf@ti.com>
 <CAL_JsqLamx4hdXLJ5SCP1FPHRP11JP6V-1=NyRY2QM1bvtMtpg@mail.gmail.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <fb571925-a4c7-d7ea-ddc4-d5573f1727e1@ti.com>
Date:   Mon, 24 Feb 2020 06:42:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLamx4hdXLJ5SCP1FPHRP11JP6V-1=NyRY2QM1bvtMtpg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/21/2020 1:58 AM, Rob Herring wrote:
> On Wed, Feb 19, 2020 at 1:40 AM Keerthy <j-keerthy@ti.com> wrote:
>>
>>
>>
>> On 19/02/20 1:50 am, Rob Herring wrote:
>>> On Fri, 14 Feb 2020 12:04:40 +0530, Keerthy wrote:
>>>> Add VTM bindings documentation. In the Voltage Thermal
>>>> Management Module(VTM), K3 AM654 supplies a voltage
>>>> reference and a temperature sensor feature that are gathered in the band
>>>> gap voltage and temperature sensor (VBGAPTS) module. The band
>>>> gap provides current and voltage reference for its internal
>>>> circuits and other analog IP blocks. The analog-to-digital
>>>> converter (ADC) produces an output value that is proportional
>>>> to the silicon temperature.
>>>>
>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>>
>>>>     * Fixed make dt_binding_check errors.
>>>>
>>>>    .../bindings/thermal/ti,am654-thermal.yaml    | 57 +++++++++++++++++++
>>>>    1 file changed, 57 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>>>>
>>>
>>> My bot found errors running 'make dt_binding_check' on your patch:
>>>
>>> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
>>> Error: Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dts:21.41-42 syntax error
>>> FATAL ERROR: Unable to parse input tree
>>> scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml' failed
>>> make[1]: *** [Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml] Error 1
>>> Makefile:1263: recipe for target 'dt_binding_check' failed
>>> make: *** [dt_binding_check] Error 2
>>>
>>> See https://patchwork.ozlabs.org/patch/1237882
>>> Please check and re-submit.
>>
>> Rob,
>>
>> I am using:
>>
>> Tree: https//github.com/devicetree-org/dt-schema.git
>> branch: master
>>
>> I have make dt_binding_check working for
>> Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml
>>
>> Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dts
>> is created without any errors :
>>
>> https://pastebin.ubuntu.com/p/6MkMbKPpbY/
>>
>> I did not see any errors as the other files erred out.
> 
> 'make -k' is your friend.
> 

Okay

> What branch are you on. Only linux-next breaks generally.

linux-next

Thanks,
Keerthy
> 
>> Today i tried with DT_SCHEMA_FILES option and then finally reproduced
>> the errors. It is a bit confusing for the first time users.
>>
>> Now i have it compiled without any errors.
>>
>> Posting v3 in a bit.
>>
>> - Keerthy
>>
>>
>>>
