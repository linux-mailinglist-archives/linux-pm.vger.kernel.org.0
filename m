Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98941A0492
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 03:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDGBgS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 21:36:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34180 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgDGBgR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 21:36:17 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0371a2mr099188;
        Mon, 6 Apr 2020 20:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586223363;
        bh=RMkSGchD+bJ2vzbZvvD9aI/oPbB/u3xEJqJPtplbABo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vdzx1TJopX7tEmUBLcATi2AnLZDXYKJDwWTTtMjPyQo3RatKRwH1PxxF/rNZ+V+E9
         maCMowMwjjGqVlupHEYWldLzbKwQBXx3KA8IAsGPSXMbh/vY7hFsRJWdLWxx/n2zd4
         Q9jV0r3PRu+gNeQj9MsrTUOFt4kUDpZ89FOJKMMc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0371a2d7109754
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Apr 2020 20:36:02 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Apr
 2020 20:36:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Apr 2020 20:36:02 -0500
Received: from [10.250.133.125] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0371Zwol116791;
        Mon, 6 Apr 2020 20:35:59 -0500
Subject: Re: [PATCH v5 4/4] arm64: dts: ti: am6: Add VTM node
To:     Amit Kucheria <amit.kucheria@verdurent.com>
CC:     Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, <t-kristo@ti.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20200331075356.19171-1-j-keerthy@ti.com>
 <20200331075356.19171-5-j-keerthy@ti.com>
 <CAHLCerOwqOmGRotiofs_xtB9XEa-YUwYWFgJGNMXQqifW+azAA@mail.gmail.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <c32f0401-357c-c59d-d589-840f46b95fa0@ti.com>
Date:   Tue, 7 Apr 2020 07:05:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerOwqOmGRotiofs_xtB9XEa-YUwYWFgJGNMXQqifW+azAA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/7/2020 12:35 AM, Amit Kucheria wrote:
> On Tue, Mar 31, 2020 at 1:24 PM Keerthy <j-keerthy@ti.com> wrote:
>>
>> VTM stands for voltage and thermal management. Add the vtm node and
>> the associated thermal zones on the SoC.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
>> index f4227e2743f2..54a133fa1bf2 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
>> @@ -89,4 +89,15 @@
>>                  clocks = <&k3_clks 59 0>;
>>                  clock-names = "gpio";
>>          };
>> +
>> +       wkup_vtm0: thermal@42050000 {
>> +               compatible = "ti,am654-vtm";
>> +               reg = <0x42050000 0x25c>;
>> +               power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
>> +               #thermal-sensor-cells = <1>;
>> +       };
>> +
> 
> Make this patch 3
> 
>> +       thermal_zones: thermal-zones {
>> +               #include "k3-am654-industrial-thermal.dtsi"
>> +       };
>>   };
> 
> Move this with what is currently patch 3.

Agreed on all the comments on patch 3 & 4.

I will incorporate them.

- Keerthy
> 
>> --
>> 2.17.1
>>
