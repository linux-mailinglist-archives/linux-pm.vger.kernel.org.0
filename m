Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDB01BA0FB
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 12:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgD0KV0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 06:21:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33024 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgD0KV0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 06:21:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RALD0G051252;
        Mon, 27 Apr 2020 05:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587982873;
        bh=t1hJLC5kDuKcKibDcEkvU70NnV8yMMsoqioAltNhm5E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jXCx2mGcdqOH+pCxeX2NQcKVCe/0SfWqYzUECFMWb0sQ89mD7KuLjVgd3mxMeN3A7
         +J+6jQm4dfnG9d7smvfAK2Ct8EgtFsza5+VxOIjhgBIb0e+MAY/61JOaD5Pk1UBIaj
         kYypjGqMbypc0Oysqbwq/1rk9qilzeAEydH+naHs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03RALDoY044674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Apr 2020 05:21:13 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 05:21:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 05:21:13 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RALAt8032790;
        Mon, 27 Apr 2020 05:21:10 -0500
Subject: Re: [PATCH v6 0/4] thermal: k3: Add support for bandgap sensors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "J, KEERTHY" <j-keerthy@ti.com>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>
CC:     <amit.kucheria@verdurent.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
References: <20200407055116.16082-1-j-keerthy@ti.com>
 <3c69e3c6-5549-e891-fde6-95a2ecc49f77@linaro.org>
 <0817f9ee-c72f-3e9f-00cf-e8ddaf608020@ti.com>
 <e7dd6470-5992-8d22-5d0c-7532a47a400c@ti.com>
 <3221f241-7118-a586-1789-d427791215c6@linaro.org>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <1ee5ec60-97e9-930e-4bc2-4c10d1a82165@ti.com>
Date:   Mon, 27 Apr 2020 13:21:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3221f241-7118-a586-1789-d427791215c6@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/04/2020 17:47, Daniel Lezcano wrote:
> On 09/04/2020 16:37, Tero Kristo wrote:
>> On 09/04/2020 17:07, J, KEERTHY wrote:
>>>
>>>
>>> On 4/9/2020 7:19 PM, Daniel Lezcano wrote:
>>>>
>>>> Hi Keerthy,
>>>>
>>>> On 07/04/2020 07:51, Keerthy wrote:
>>>>> Add VTM thermal support. In the Voltage Thermal
>>>>> Management Module(VTM), K3 AM654 supplies a voltage
>>>>> reference and a temperature sensor feature that are gathered in the
>>>>> band
>>>>> gap voltage and temperature sensor (VBGAPTS) module. The band
>>>>> gap provides current and voltage reference for its internal
>>>>> circuits and other analog IP blocks. The analog-to-digital
>>>>> converter (ADC) produces an output value that is proportional
>>>>> to the silicon temperature.
>>>>>
>>>>> Add support for bandgap sensors. Currently reading temperatures
>>>>> is supported.
>>>>
>>>> How do you want to proceed? Shall I take patches 1 & 2 ?
>>>
>>> +Tero
>>>
>>> Hi Tero,
>>>
>>> Can you pull 3 & 4? Or Daniel can take all 4?
>>
>> Let me pull the DT patches, that way we avoid any conflicts in the
>> arm64/dts tree. There has been quite a bit of traffic on that front
>> lately and we did mess up something with the current merge window already.
>>
>> I believe you are picking the driver side changes to 5.8?
> 
> Applied patches 1 & 2

Queued patches 3 & 4 towards 5.8, thanks.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
