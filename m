Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A481A3DA40B
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 15:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhG2N0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 09:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbhG2N0O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 09:26:14 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187FC061765;
        Thu, 29 Jul 2021 06:26:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 61D393F359;
        Thu, 29 Jul 2021 15:26:08 +0200 (CEST)
Subject: Re: [PATCH v7 5/5] dt-bindings: soc: qcom: spm: Document SDM660 and
 MSM8998 compatibles
To:     Rob Herring <robh@kernel.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jami.kettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        stephan@gerhold.net
References: <20210622141117.358893-1-angelogioacchino.delregno@somainline.org>
 <20210622141117.358893-6-angelogioacchino.delregno@somainline.org>
 <20210713222111.GA944952@robh.at.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <285d7b38-da08-e263-d664-1cdf73d7c0d1@somainline.org>
Date:   Thu, 29 Jul 2021 15:26:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210713222111.GA944952@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 14/07/21 00:21, Rob Herring ha scritto:
> On Tue, Jun 22, 2021 at 04:11:17PM +0200, AngeloGioacchino Del Regno wrote:
>> The driver was updated to add SAW2 v4.1 support for new SoCs: document
>> the new compatibles.
> 
> Can't take patches without a S-o-b. Run checkpatch.pl, it points this
> out for you.
> 

I am truly sorry for missing my S-o-b.

>> ---
>>   .../bindings/soc/qcom/qcom,spm.yaml           | 21 +++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
>> index 4aaa319b2932..0faf52700dec 100644
>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
>> @@ -17,6 +17,10 @@ description: |
>>   properties:
>>     compatible:
>>       enum:
>> +      - qcom,sdm660-gold-saw2-v4.1-l2
>> +      - qcom,sdm660-silver-saw2-v4.1-l2
>> +      - qcom,msm8998-gold-saw2-v4.1-l2
>> +      - qcom,msm8998-silver-saw2-v4.1-l2
> 
> What's the difference between gold and silver? Are the h/w instances
> different (I realize the CPUs are) in some way? How does the OS use the
> different compatible strings?
> 

They have different configuration parameters and the HW instances should
be different indeed (at least from what I remember), plus they're always
at different iostart.

The driver is using the different compatible strings to choose which
configuration gets written. You can also avoid writing the configuration
to one of them or both (if you wish to lose capabilities given by this
driver, perhaps also if you want to simply never use the gold cluster, for
example).


>>         - qcom,msm8974-saw2-v2.1-cpu
>>         - qcom,apq8084-saw2-v2.1-cpu
>>         - qcom,apq8064-saw2-v1.1-cpu
>> @@ -33,6 +37,8 @@ additionalProperties: false
>>   
>>   examples:
>>     - |
>> +
>> +    /* Example 1: SoC using SAW2 and kpss-acc-v2 CPUIdle */
>>       cpus {
>>           #address-cells = <1>;
>>           #size-cells = <0>;
>> @@ -52,4 +58,19 @@ examples:
>>           reg = <0xf9089000 0x1000>;
>>       };
>>   
>> +  - |
>> +
>> +    /* Example 2: New-gen multi cluster SoC using SAW only for L2;
>> +     * This does not require any cpuidle driver, nor any cpu phandle.
>> +     */
>> +    power-controller@17812000 {
>> +        compatible = "qcom,msm8998-gold-saw2-v4.1-l2", "qcom,saw2";
>> +        reg = <0x17812000 0x1000>;
>> +    };
>> +
>> +    power-controller@17912000 {
>> +        compatible = "qcom,msm8998-silver-saw2-v4.1-l2", "qcom,saw2";
>> +        reg = <0x17912000 0x1000>;
>> +    };
>> +
>>   ...
>> -- 
>> 2.32.0
>>
>>

