Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27A83DA430
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 15:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhG2N24 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 09:28:56 -0400
Received: from relay05.th.seeweb.it ([5.144.164.166]:58931 "EHLO
        relay05.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbhG2N2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 09:28:53 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 60C9C3EBCB;
        Thu, 29 Jul 2021 15:28:47 +0200 (CEST)
Subject: Re: [PATCH v6 9/9] dt-bindings: cpufreq: qcom-hw: Make reg-names a
 required property
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
 <20210701105730.322718-10-angelogioacchino.delregno@somainline.org>
 <20210713224245.GA981311@robh.at.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <0a4a4328-0b8b-46d0-53b9-8a3566c46ca9@somainline.org>
Date:   Thu, 29 Jul 2021 15:28:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210713224245.GA981311@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 14/07/21 00:42, Rob Herring ha scritto:
> On Thu, Jul 01, 2021 at 12:57:30PM +0200, AngeloGioacchino Del Regno wrote:
>> The property reg-names is required after the addition of the OSM
>> programming sequence, as that mandates specifying different register
>> domains; to avoid confusion and improve devicetree readability,
>> specifying the regions names was made mandatory.
> 
> Can't take patches missing a S-o-b.
> 

Sorry again. Didn't notice at all.

> Making existing properties required breaks compatibility. That's okay on
> *all* the platforms using this? If so, that needs to be crystal clear in
> the commit msg.
> 

Yes that's just fine on all platforms using this. In any case, they all
do have the reg-names specified in their DT, even if previously not required,
so there's nothing to update, even.

I will make it crystal clear in the commit message in the next version.

>> ---
>>   Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
>> index 29b663321a0b..17fd6a6cefb0 100644
>> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
>> @@ -98,6 +98,7 @@ else:
>>   required:
>>     - compatible
>>     - reg
>> +  - reg-names
>>     - clocks
>>     - clock-names
>>     - '#freq-domain-cells'
>> -- 
>> 2.32.0
>>
>>

