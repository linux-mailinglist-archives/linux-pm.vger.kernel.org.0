Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6668D2E0FBE
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 22:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgLVVMz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 16:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbgLVVMz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 16:12:55 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FF9C0613D6;
        Tue, 22 Dec 2020 13:11:59 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 62B943F343;
        Tue, 22 Dec 2020 22:11:54 +0100 (CET)
Subject: Re: [PATCH 13/13] dt-bindings: cpufreq: qcom-hw: Add bindings for
 8998
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, jorge.ramirez-ortiz@linaro.org,
        broonie@kernel.org, lgirdwood@gmail.com, daniel.lezcano@linaro.org,
        nks@flawful.org, bjorn.andersson@linaro.org, agross@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net,
        konrad.dybcio@somainline.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
 <20201126184559.3052375-14-angelogioacchino.delregno@somainline.org>
 <20201208181103.GA2795715@robh.at.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <ea5cb3fc-3bda-e220-c0ba-6fd50d648737@somainline.org>
Date:   Tue, 22 Dec 2020 22:11:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201208181103.GA2795715@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 08/12/20 19:11, Rob Herring ha scritto:

Hello! Replying very late seem to be obligatory for me nowadays
so for this and for any other late replies: I'm sorry!

> On Thu, Nov 26, 2020 at 07:45:59PM +0100, AngeloGioacchino Del Regno wrote:
>> The OSM programming addition has been done under the
>> qcom,cpufreq-hw-8998 compatible name: specify the requirement
>> of two additional register spaces for this functionality.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   .../bindings/cpufreq/qcom,cpufreq-hw.yaml     | 31 ++++++++++++++++---
>>   1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml b/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
>> index 94a56317b14b..f64cea73037e 100644
>> --- a/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
>> +++ b/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
>> @@ -23,17 +23,21 @@ properties:
>>             - qcom,cpufreq-epss
>>   
>>     reg:
>> +    description: Base address and size of the RBCPR register region
> 
> That doesn't make sense given you have 2 regions.
> 
>>       minItems: 2
>>       maxItems: 2
> 
> maxItems: 4
> 
Indeed it doesn't make sense.

>>   
>>     reg-names:
>>       description:
>> -      Frequency domain register region for each domain.
>> -    items:
>> -      - const: "freq-domain0"
>> -      - const: "freq-domain1"
>> +      Frequency domain register region for each domain. If OSM programming
>> +      does not happen in the bootloader and has to be done in this driver,
>> +      then also the OSM domain region osm-domain[0-1] has to be provided.
> 
> Don't write free form text for what can be expressed as schema.
> 
I guess the later 'if' for 8998 is sufficient to express that, then...
right?

>> +    minItems: 2
>> +    maxItems: 2
> 
> You obviously haven't tried this change with 8998. It will fail with
> more than 2. What you need here is:
> 
My testing methodology must be flawed. Or perhaps I just need some more 
sleep... probably the latter.

> minItems: 2
> maxItems: 4
> 
> items:
>    - const: "freq-domain0"
>    - const: "freq-domain1"
>    - const: "osm-domain0"
>    - const: "osm-domain1"
> 
> And then...
> 
>>   
>>     clock-names:
>> +    minItems: 2
>> +    maxItems: 2
>>       - const: xo
>>       - const: ref
>>   
>> @@ -53,9 +57,28 @@ properties:
>>         property with phandle to a cpufreq_hw followed by the Domain ID(0/1)
>>         in the CPU DT node.
>>   
>> +allOf:
>> + - if:
>> +     properties:
>> +       reg-names:
>> +         contains:
>> +           const: qcom,cpufreq-hw-8998
>> +   then:
>> +     properties:
>> +       reg:
>> +         minItems: 4
>> +         maxItems: 4
>> +       reg-names:
> 
> ...here just:
> 
> minItems: 4
> 
> And you'll need an 'else' clause with 'maxItems: 2' for reg and
> reg-names.
> 
Big thank you for that!!!

>> +         items:
>> +           - const: "freq-domain0"
>> +           - const: "freq-domain1"
>> +           - const: "osm-domain0"
>> +           - const: "osm-domain1"
>> +
>>   required:
>>     - compatible
>>     - reg
>> +  - reg-names
> 
> You can't make something that was optional now required. (Unless it was
> a mistake and all existing users always had 'reg-names'.)
> 
Well, yes. All existing users are already declaring reg-names, no DT 
changes to do for them.

>>     - clock-names
>>     - clocks
>>     - "#freq-domain-cells"
>> -- 
>> 2.29.2
>>

Thanks for the review.
A V2 of the entire series will come soon!

-- Angelo
