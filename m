Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFFD1A3561
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 16:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgDIOID (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 10:08:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46444 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgDIOID (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2020 10:08:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 039E7h6o029946;
        Thu, 9 Apr 2020 09:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586441263;
        bh=3gqI19XisR3qGspsaOL9E0JWEAZr7zQg0fFq2CZV2Hw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZUcjlDHmHGAQ3KizNSZbsviTkSZsndRLH+jqcIGMJXtwnMLTDVRn4WYCQUu9sSV5F
         f2SHCNtP1PQCbHHf3drpLKr/EMOEPDf6Uf85/jfE6iMdI5W7TXJQA7Lns0Sx33szc4
         9MdeVOaYmM2ytt+ox7WeZrg/P/senUa/89m/rU3g=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 039E7hiX028657
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Apr 2020 09:07:43 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Apr
 2020 09:07:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Apr 2020 09:07:43 -0500
Received: from [10.250.133.160] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 039E7dJM126106;
        Thu, 9 Apr 2020 09:07:40 -0500
Subject: Re: [PATCH v6 0/4] thermal: k3: Add support for bandgap sensors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>
CC:     <amit.kucheria@verdurent.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
References: <20200407055116.16082-1-j-keerthy@ti.com>
 <3c69e3c6-5549-e891-fde6-95a2ecc49f77@linaro.org>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <0817f9ee-c72f-3e9f-00cf-e8ddaf608020@ti.com>
Date:   Thu, 9 Apr 2020 19:37:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3c69e3c6-5549-e891-fde6-95a2ecc49f77@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/9/2020 7:19 PM, Daniel Lezcano wrote:
> 
> Hi Keerthy,
> 
> On 07/04/2020 07:51, Keerthy wrote:
>> Add VTM thermal support. In the Voltage Thermal
>> Management Module(VTM), K3 AM654 supplies a voltage
>> reference and a temperature sensor feature that are gathered in the band
>> gap voltage and temperature sensor (VBGAPTS) module. The band
>> gap provides current and voltage reference for its internal
>> circuits and other analog IP blocks. The analog-to-digital
>> converter (ADC) produces an output value that is proportional
>> to the silicon temperature.
>>
>> Add support for bandgap sensors. Currently reading temperatures
>> is supported.
> 
> How do you want to proceed? Shall I take patches 1 & 2 ?

+Tero

Hi Tero,

Can you pull 3 & 4? Or Daniel can take all 4?

- Keerthy

> 
> 
>> Changes in v6:
>>
>>    * Removed bunch of unused #defines and couple of redundant variables.
>>    * Reordered patches a bit.
>>    * Minor reordering in dt binding patch.
>>
>> Changes in v5:
>>
>>    * Removed thermal work function which was unused.
>>    * Removed unused preve_tenmp and a couple more struct variables.
>>    * Removed couple of redundant header function include.
>>
>> Changes in v4:
>>
>>    * Fixed comments from Daniel to remove trend function.
>>    * Mostly cleaned up all the unused variables.
>>    * Driver from bool to tristate.
>>
>> Changes in v3:
>>
>>    * Fixed errors seen with:
>>      dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>>
>> Changes in v2:
>>
>>    * Fixed yaml errors
>>    * renamed am654-industrial-thermal.dtsi to k3-am654-industrial-thermal.dtsi
>>      to follow the convention for k3 family.
>>
>> Keerthy (4):
>>    dt-bindings: thermal: k3: Add VTM bindings documentation
>>    thermal: k3: Add support for bandgap sensors
>>    arm64: dts: ti: am65-wakeup: Add VTM node
>>    arm64: dts: ti: am654: Add thermal zones
>>
>>   .../bindings/thermal/ti,am654-thermal.yaml    |  56 ++++
>>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  11 +
>>   .../dts/ti/k3-am654-industrial-thermal.dtsi   |  45 +++
>>   drivers/thermal/Kconfig                       |  10 +
>>   drivers/thermal/Makefile                      |   1 +
>>   drivers/thermal/k3_bandgap.c                  | 264 ++++++++++++++++++
>>   6 files changed, 387 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
>>   create mode 100644 drivers/thermal/k3_bandgap.c
>>
> 
> 
