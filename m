Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A741A360C
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgDIOhW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 10:37:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34870 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgDIOhV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2020 10:37:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 039EbA5j008107;
        Thu, 9 Apr 2020 09:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586443030;
        bh=t0Pz8343qyR0XZCGjZzKoEfLBwp8RY74fZEv6viiDRk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wQflHXbmBySjer9/hT20YQkA86nduHAOQSxNmJ+JkcmfIybnRtPjd/+QLdn6sXnAh
         q3n9Sgybhy/GZJNlkTgoZXm/j8qRzyRSSJC25TycQOpENGyElgMxLxVKhz3kx7jSi+
         U9oXaQOZxwn2oS+o8pb9d4QW+B5hAjNHkE39Un1k=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 039EbANt016166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Apr 2020 09:37:10 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Apr
 2020 09:37:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Apr 2020 09:37:08 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 039Eb6BD069628;
        Thu, 9 Apr 2020 09:37:06 -0500
Subject: Re: [PATCH v6 0/4] thermal: k3: Add support for bandgap sensors
To:     "J, KEERTHY" <j-keerthy@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <robh+dt@kernel.org>
CC:     <amit.kucheria@verdurent.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
References: <20200407055116.16082-1-j-keerthy@ti.com>
 <3c69e3c6-5549-e891-fde6-95a2ecc49f77@linaro.org>
 <0817f9ee-c72f-3e9f-00cf-e8ddaf608020@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <e7dd6470-5992-8d22-5d0c-7532a47a400c@ti.com>
Date:   Thu, 9 Apr 2020 17:37:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0817f9ee-c72f-3e9f-00cf-e8ddaf608020@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/04/2020 17:07, J, KEERTHY wrote:
> 
> 
> On 4/9/2020 7:19 PM, Daniel Lezcano wrote:
>>
>> Hi Keerthy,
>>
>> On 07/04/2020 07:51, Keerthy wrote:
>>> Add VTM thermal support. In the Voltage Thermal
>>> Management Module(VTM), K3 AM654 supplies a voltage
>>> reference and a temperature sensor feature that are gathered in the band
>>> gap voltage and temperature sensor (VBGAPTS) module. The band
>>> gap provides current and voltage reference for its internal
>>> circuits and other analog IP blocks. The analog-to-digital
>>> converter (ADC) produces an output value that is proportional
>>> to the silicon temperature.
>>>
>>> Add support for bandgap sensors. Currently reading temperatures
>>> is supported.
>>
>> How do you want to proceed? Shall I take patches 1 & 2 ?
> 
> +Tero
> 
> Hi Tero,
> 
> Can you pull 3 & 4? Or Daniel can take all 4?

Let me pull the DT patches, that way we avoid any conflicts in the 
arm64/dts tree. There has been quite a bit of traffic on that front 
lately and we did mess up something with the current merge window already.

I believe you are picking the driver side changes to 5.8?

-Tero

> 
> - Keerthy
> 
>>
>>
>>> Changes in v6:
>>>
>>>    * Removed bunch of unused #defines and couple of redundant variables.
>>>    * Reordered patches a bit.
>>>    * Minor reordering in dt binding patch.
>>>
>>> Changes in v5:
>>>
>>>    * Removed thermal work function which was unused.
>>>    * Removed unused preve_tenmp and a couple more struct variables.
>>>    * Removed couple of redundant header function include.
>>>
>>> Changes in v4:
>>>
>>>    * Fixed comments from Daniel to remove trend function.
>>>    * Mostly cleaned up all the unused variables.
>>>    * Driver from bool to tristate.
>>>
>>> Changes in v3:
>>>
>>>    * Fixed errors seen with:
>>>      dt_binding_check 
>>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml 
>>>
>>>
>>> Changes in v2:
>>>
>>>    * Fixed yaml errors
>>>    * renamed am654-industrial-thermal.dtsi to 
>>> k3-am654-industrial-thermal.dtsi
>>>      to follow the convention for k3 family.
>>>
>>> Keerthy (4):
>>>    dt-bindings: thermal: k3: Add VTM bindings documentation
>>>    thermal: k3: Add support for bandgap sensors
>>>    arm64: dts: ti: am65-wakeup: Add VTM node
>>>    arm64: dts: ti: am654: Add thermal zones
>>>
>>>   .../bindings/thermal/ti,am654-thermal.yaml    |  56 ++++
>>>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  11 +
>>>   .../dts/ti/k3-am654-industrial-thermal.dtsi   |  45 +++
>>>   drivers/thermal/Kconfig                       |  10 +
>>>   drivers/thermal/Makefile                      |   1 +
>>>   drivers/thermal/k3_bandgap.c                  | 264 ++++++++++++++++++
>>>   6 files changed, 387 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>>>   create mode 100644 
>>> arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
>>>   create mode 100644 drivers/thermal/k3_bandgap.c
>>>
>>
>>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
