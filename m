Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96FE423E84
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhJFNVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 09:21:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36888 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhJFNVF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 09:21:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 196DJ8iR055040;
        Wed, 6 Oct 2021 08:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633526349;
        bh=Nb8U4U2trMtARelPANdTerZUVjPr3+IxvmjVKxEf6QM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GkQAffm8zbALvXMB3C69UTdCQ4x2AlQtRmcVstYXcgVUKv4pKRck9b/Teg3EiBH22
         HcZ4v32n2MZdMwvGBda3zIFlA24fIWn6xi672N/7H96CswPAcVD9ABT8RYl71YXqbx
         7B1j/AC2lxV7iqpYdnzIHu/MwkfsNotUecGVVS4Y=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 196DJ8uG113063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Oct 2021 08:19:08 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Oct 2021 08:19:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Oct 2021 08:19:08 -0500
Received: from [10.250.233.140] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 196DJ4e9064609;
        Wed, 6 Oct 2021 08:19:05 -0500
Subject: Re: [PATCH 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20211004112550.27546-1-j-keerthy@ti.com>
 <20211004112550.27546-2-j-keerthy@ti.com>
 <1633436798.497006.3226792.nullmailer@robh.at.kernel.org>
 <CAL_JsqKLuE+RhH+T4UKecMhRjbm69rwA1a2+FjrnMPKUf13J6A@mail.gmail.com>
 <edb3e75a-1092-7e90-40d0-225dd4d4764c@linaro.org>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <03549a90-4bf7-70a8-39f9-b3dd15d5ca45@ti.com>
Date:   Wed, 6 Oct 2021 18:49:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <edb3e75a-1092-7e90-40d0-225dd4d4764c@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/6/2021 3:12 PM, Daniel Lezcano wrote:
> 
> Keerthy,
> 
> did you receive this answer ?

Daniel,

Thanks for sending this. I did not receive Rob's responses.

Rob,

Apologies. I will get this rectified before i send the V2 with the 
reported issue fixed. It seems issue with my particular e-mail account.

Apologies for the inconvenience once again!

Best Regards,
Keerthy


> 
> 
> On 05/10/2021 15:05, Rob Herring wrote:
>> On Tue, Oct 5, 2021 at 7:26 AM Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Mon, 04 Oct 2021 16:55:47 +0530, Keerthy wrote:
>>>> Add VTM bindings documentation. In the Voltage Thermal
>>>> Management Module(VTM), K3 J72XX supplies a voltage
>>>> reference and a temperature sensor feature that are gathered in the band
>>>> gap voltage and temperature sensor (VBGAPTS) module. The band
>>>> gap provides current and voltage reference for its internal
>>>> circuits and other analog IP blocks. The analog-to-digital
>>>> converter (ADC) produces an output value that is proportional
>>>> to the silicon temperature.
>>>>
>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>> ---
>>>>   .../bindings/thermal/ti,j72xx-thermal.yaml    | 58 +++++++++++++++++++
>>>>   1 file changed, 58 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
>>>>
>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> Woot, TI has blacklisted me:
>>
>> The response from the remote server was:
>> 553 Sorry, your email address has been blacklisted. Please contact
>> Texas Instruments Inc to have yourself removed.
>>
> 
> 
