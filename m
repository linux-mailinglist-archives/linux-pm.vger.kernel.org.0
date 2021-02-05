Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7715A31190A
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 03:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhBFCxb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 21:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhBFClL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 21:41:11 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A059C0698CA;
        Fri,  5 Feb 2021 14:23:01 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9D6E13F290;
        Fri,  5 Feb 2021 23:22:56 +0100 (CET)
Subject: Re: [PATCH v5 3/7] dt-bindings: arm: cpus: Document
 'qcom,freq-domain' property
To:     Rob Herring <robh@kernel.org>
Cc:     viresh.kumar@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20210121195250.492500-1-angelogioacchino.delregno@somainline.org>
 <20210121195250.492500-4-angelogioacchino.delregno@somainline.org>
 <20210205214641.GA3802952@robh.at.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <65135511-1360-c094-9eaf-fec75f9ab53a@somainline.org>
Date:   Fri, 5 Feb 2021 23:22:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205214641.GA3802952@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 05/02/21 22:46, Rob Herring ha scritto:
> On Thu, Jan 21, 2021 at 08:52:46PM +0100, AngeloGioacchino Del Regno wrote:
>> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> Add devicetree documentation for 'qcom,freq-domain' property specific
>> to Qualcomm CPUs. This property is used to reference the CPUFREQ node
>> along with Domain ID (0/1).
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
>> index 14cd727d3c4b..1d60975df23a 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
>> @@ -290,6 +290,12 @@ properties:
>>   
>>         * arm/msm/qcom,kpss-acc.txt
>>   
>> +  qcom,freq-domain:
> 
> What happened to having a standard property here? There were 1 or 2
> other cases of doing the same thing.
> 

The original discussion didn't have any more replies, so I thought to
bring it back on the table.
I have no idea about what are the other cases, but if you can suggest
a different property name (just "frequency-domain"?) I can send a new
one with the suggested one!

Though, since I don't know about other cases, how would this get
described?

frequency-domain:
"CPUs supporting frequency-domain must set this property with phandle
  to the appropriate [domain node or cpufreq node?] followed by the
  Domain ID"

Would this be fine?

Thanks,
- Angelo

>> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
>> +    description: |
>> +      CPUs supporting freq-domain must set their "qcom,freq-domain" property
>> +      with phandle to a cpufreq_hw node followed by the Domain ID(0/1).
>> +
>>     rockchip,pmu:
>>       $ref: '/schemas/types.yaml#/definitions/phandle'
>>       description: |
>> -- 
>> 2.30.0
>>

