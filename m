Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1A93D0DA9
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhGUKs2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 06:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbhGUKIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jul 2021 06:08:38 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC5BC061762
        for <linux-pm@vger.kernel.org>; Wed, 21 Jul 2021 03:48:29 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 283833F74F;
        Wed, 21 Jul 2021 12:48:25 +0200 (CEST)
Subject: Re: [PATCH v6 8/9] dt-bindings: cpufreq: qcom-hw: Add bindings for
 8998
To:     Rob Herring <robh@kernel.org>
Cc:     bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        paul.bouchara@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, jeffrey.l.hugo@gmail.com
References: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
 <20210701105730.322718-9-angelogioacchino.delregno@somainline.org>
 <20210714213946.GA3568065@robh.at.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <7d012e8c-4570-9d60-32c3-fb271ce636b8@somainline.org>
Date:   Wed, 21 Jul 2021 12:48:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210714213946.GA3568065@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 14/07/21 23:39, Rob Herring ha scritto:
> On Thu, Jul 01, 2021 at 12:57:29PM +0200, AngeloGioacchino Del Regno wrote:
>> The OSM programming addition has been done under the
>> qcom,cpufreq-hw-8998 compatible name: specify the requirement
>> of two additional register spaces for this functionality.
>> This implementation, with the same compatible, has been
>> tested on MSM8998 and SDM630.
> 
> Certainly we should be using the new binding for any new SoCs.
> 

Yes that's totally true, I should've probably added the new bindings directly
instead of making it implicit that the 8998 model is valid for the others.
Adding more bindings will explicitly clarify that the support is extended to
630/660 so yeah, I agree.

>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 67 ++++++++++++++-----
>>   1 file changed, 52 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
>> index bc81b6203e27..29b663321a0b 100644
>> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
>> @@ -18,6 +18,10 @@ description: |
>>   properties:
>>     compatible:
>>       oneOf:
>> +      - description: Non-secure v1 of CPUFREQ HW
>> +        items:
>> +          - const: qcom,cpufreq-hw-8998
>> +
>>         - description: v1 of CPUFREQ HW
>>           items:
>>             - const: qcom,cpufreq-hw
>> @@ -28,21 +32,9 @@ properties:
>>                 - qcom,sm8250-cpufreq-epss
>>             - const: qcom,cpufreq-epss
>>   
>> -  reg:
>> -    minItems: 2
>> -    maxItems: 3
>> -    items:
>> -      - description: Frequency domain 0 register region
>> -      - description: Frequency domain 1 register region
>> -      - description: Frequency domain 2 register region
>> +  reg: {}
>>   
>> -  reg-names:
>> -    minItems: 2
>> -    maxItems: 3
>> -    items:
>> -      - const: freq-domain0
>> -      - const: freq-domain1
>> -      - const: freq-domain2
>> +  reg-names: {}
>>   
>>     clocks:
>>       items:
>> @@ -57,10 +49,55 @@ properties:
>>     '#freq-domain-cells':
>>       const: 1
>>   
>> +if:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: qcom,cpufreq-hw-8998
>> +then:
>> +  properties:
>> +    reg:
>> +      minItems: 2
>> +      maxItems: 6
>> +      items:
>> +        - description: Frequency domain 0 register region
>> +        - description: Operating State Manager domain 0 register region
>> +        - description: Frequency domain 1 register region
>> +        - description: Operating State Manager domain 1 register region
>> +        - description: PLL ACD domain 0 register region (if ACD programming required)
>> +        - description: PLL ACD domain 1 register region (if ACD programming required)
>> +
>> +    reg-names:
>> +      minItems: 2
>> +      maxItems: 6
>> +      items:
>> +        - const: "osm-domain0"
>> +        - const: "freq-domain0"
>> +        - const: "osm-domain1"
>> +        - const: "freq-domain1"
>> +        - const: "osm-acd0"
>> +        - const: "osm-acd1"
> 
> This is different enough and there's not much else to this bindings, so
> I think you should do a separate schema doc.
> 
> BTW, Don't need quotes here.
> 

If you think that this would be appropriate, then I guess it's trivial to
do that and I will... though, I am 99% sure that these bindings will never
get updated, as Qualcomm has shifted to do the programming in TZ and there
surely will never be any new SoC requiring this kind of thing.

The ones that do require this should be around 6, if my memory isn't failing...

>> +
>> +else:
>> +  properties:
>> +    reg:
>> +      minItems: 2
>> +      maxItems: 3
>> +      items:
>> +        - description: Frequency domain 0 register region
>> +        - description: Frequency domain 1 register region
>> +        - description: Frequency domain 2 register region
>> +    reg-names:
>> +      minItems: 2
>> +      maxItems: 3
>> +      items:
>> +        - const: "freq-domain0"
>> +        - const: "freq-domain1"
>> +        - const: "freq-domain2"
>> +
>>   required:
>>     - compatible
>>     - reg
>> -  - reg-names
>>     - clocks
>>     - clock-names
>>     - '#freq-domain-cells'
>> -- 
>> 2.32.0
>>
>>

