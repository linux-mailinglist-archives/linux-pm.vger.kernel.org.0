Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB0A3119CF
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 04:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhBFDUV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 22:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhBFCpi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 21:45:38 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7057BC0698CB;
        Fri,  5 Feb 2021 14:23:15 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E16573F290;
        Fri,  5 Feb 2021 23:23:13 +0100 (CET)
Subject: Re: [PATCH v5 7/7] dt-bindings: cpufreq: qcom-hw: Add bindings for
 8998
To:     Rob Herring <robh@kernel.org>
Cc:     viresh.kumar@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
References: <20210121195250.492500-1-angelogioacchino.delregno@somainline.org>
 <20210121195250.492500-8-angelogioacchino.delregno@somainline.org>
 <20210205215125.GA3810714@robh.at.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <8e7efd35-791c-da49-c9db-bc8a94021c42@somainline.org>
Date:   Fri, 5 Feb 2021 23:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205215125.GA3810714@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 05/02/21 22:51, Rob Herring ha scritto:
> On Thu, Jan 21, 2021 at 08:52:50PM +0100, AngeloGioacchino Del Regno wrote:
>> The OSM programming addition has been done under the
>> qcom,cpufreq-hw-8998 compatible name: specify the requirement
>> of two additional register spaces for this functionality.
>> This implementation, with the same compatible, has been
>> tested on MSM8998 and SDM630.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 66 +++++++++++++++----
>>   1 file changed, 52 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
>> index bc81b6203e27..17fd6a6cefb0 100644
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
>> @@ -57,6 +49,52 @@ properties:
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
> Don't need quotes.
> 

Ack

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
>> -- 
>> 2.30.0
>>

