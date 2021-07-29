Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8697A3DA4AF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 15:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhG2Nsw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 09:48:52 -0400
Received: from m-r2.th.seeweb.it ([5.144.164.171]:59517 "EHLO
        m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbhG2Nsv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 09:48:51 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 28A2A3F403;
        Thu, 29 Jul 2021 15:48:47 +0200 (CEST)
Subject: Re: [PATCH 14/39] arm64: dts: qcom: sdm630: Add TSENS node
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org, marijn.suijten@somainline.org,
        jamipkettunen@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210728222542.54269-1-konrad.dybcio@somainline.org>
 <20210728222542.54269-15-konrad.dybcio@somainline.org>
 <860f1120-c5a4-f531-3ea9-aa90c6b063dc@linaro.org>
 <2318377c-959a-a42b-81b5-44e2629570d5@somainline.org>
 <afee55a8-d7d3-709a-ea4f-0306698c9976@linaro.org>
 <b16d8000-85a7-d957-77d2-d921e5b09829@somainline.org>
 <a7f90fe0-ee24-a47d-089d-e716a5766fcd@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <2ffc4e54-a501-bd2d-3f29-a6df34023445@somainline.org>
Date:   Thu, 29 Jul 2021 15:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <a7f90fe0-ee24-a47d-089d-e716a5766fcd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 29/07/21 13:14, Thara Gopinath ha scritto:
> 
> 
> On 7/29/21 6:55 AM, Konrad Dybcio wrote:
>>
>> On 29.07.2021 12:54, Thara Gopinath wrote:
>>>
>>>
>>> On 7/29/21 6:52 AM, Konrad Dybcio wrote:
>>>>
>>>> On 29.07.2021 12:50, Thara Gopinath wrote:
>>>>> Hi Konrad,
>>>>>
>>>>> On 7/28/21 6:25 PM, Konrad Dybcio wrote:
>>>>>> This will enable temperature reporting for various SoC
>>>>>> components.
>>>>>>
>>>>>> Signed-off-by: AngeloGioacchino Del Regno 
>>>>>> <angelogioacchino.delregno@somainline.org>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>>> ---
>>>>>>     .../devicetree/bindings/thermal/qcom-tsens.yaml       |  1 +
>>>>>>     arch/arm64/boot/dts/qcom/sdm630.dtsi                  | 11 +++++++++++
>>>>>>     2 files changed, 12 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml 
>>>>>> b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>>>> index 4a2eaf28e3fd..d3b9e9b600a2 100644
>>>>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>>>> @@ -48,6 +48,7 @@ properties:
>>>>>>                   - qcom,sc7180-tsens
>>>>>>                   - qcom,sc7280-tsens
>>>>>>                   - qcom,sc8180x-tsens
>>>>>> +              - qcom,sdm630-tsens
>>>>>>                   - qcom,sdm845-tsens
>>>>>>                   - qcom,sm8150-tsens
>>>>>>                   - qcom,sm8250-tsens
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi 
>>>>>> b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>>>>> index 1e54828817d5..7e9c80e35fba 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>>>>> @@ -627,6 +627,17 @@ mnoc: interconnect@1745000 {
>>>>>>                      <&mmcc AHB_CLK_SRC>;
>>>>>>             };
>>>>>>     +        tsens: thermal-sensor@10ae000 {
>>>>>> +            compatible = "qcom,sdm630-tsens", "qcom,tsens-v2";
>>>>>> +            reg = <0x010ae000 0x1000>, /* TM */
>>>>>> +                  <0x010ad000 0x1000>; /* SROT */
>>>>>> +            #qcom,sensors = <12>;
>>>>>
>>>>> Are all 12 sensors used ? I see that in a later patch "arm64: dts: qcom: 
>>>>> sdm630: Add thermal-zones configuration" only 9 are used.
>>>>
>>>> Hi,
>>>>
>>>> if I recall correctly, they all give output but not all of the mappings were 
>>>> documented in the downstream sources and we have no documentation whatsoever :(
>>>
>>> Right. In that case, why not change #qcom,sensors to 9 and add rest of the 
>>> sensors if and when needed ?
>>>
>> I don't think it makes sense to describe the hardware incorrectly, even if some 
>> of it is unused.
> 
> My thinking was more along the lines of don't expose unused h/w bits.
> 

You're right about not exposing unused HW bits, but even PC x86 motherboards
(I mean the smbus/i2c drivers for the big holy management/sensors chips) do
have such a "base" configuration, where some lines are read as 0 because they
are effectively not connected by hardware.

In order to avoid confusion to other developers, in my personal opinion, it would
be good go for the current value of 12 (which isn't incorrect, as that's what the
SoC supports)... I don't think that anyone would be confused by seeing zero
readings on some sensors (if their device don't support such sensor), as I think
that everyone is used to that anyway, even if that's in other circumstances...

In any case, luckily that's also safe, because there's no firmware that restricts
the readings to a subset of sensors in this domain (nobody is going to get a
hypervisor fault for that).

I would also, in case, propose to see how things go: I would expect other
developers to push device trees for many SDM630/636/660 devices, including but
not limited to smartphones and SBCs.. so perhaps if we find out that really
nobody uses the 12 sensors, or if the very vast majority uses a different amount,
perhaps we may just transfer the value to device-specific configurations in one
go, as to avoid unnecessary noise... I think :)))

>>
>>
>>
> 

