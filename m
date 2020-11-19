Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E442F2B960F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgKSPX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 10:23:27 -0500
Received: from foss.arm.com ([217.140.110.172]:60256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgKSPX1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Nov 2020 10:23:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 070C511D4;
        Thu, 19 Nov 2020 07:23:27 -0800 (PST)
Received: from [10.57.24.96] (unknown [10.57.24.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79ADE3F719;
        Thu, 19 Nov 2020 07:23:22 -0800 (PST)
Subject: Re: [PATCH v8 2/3] dt-bindings: arm: cpus: Document
 'mediatek,freq-domain' property
To:     Rob Herring <robh@kernel.org>,
        Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
References: <1603700349-5922-1-git-send-email-hector.yuan@mediatek.com>
 <1603700349-5922-3-git-send-email-hector.yuan@mediatek.com>
 <20201028150858.GA4029348@bogus>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <65a4e167-9d2c-7fcb-5373-33af5e002333@arm.com>
Date:   Thu, 19 Nov 2020 15:23:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201028150858.GA4029348@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/28/20 3:08 PM, Rob Herring wrote:
> On Mon, Oct 26, 2020 at 04:19:08PM +0800, Hector Yuan wrote:
>> From: "Hector.Yuan" <hector.yuan@mediatek.com>
>>
>> Add devicetree documentation for 'mediatek,freq-domain' property specific
>> to Mediatek CPUs. This property is used to reference the CPUFREQ node
>> along with the domain id.
>>
>> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
>> ---
>>   Documentation/devicetree/bindings/arm/cpus.yaml |    6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
>> index 1222bf1..e995b26 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
>> @@ -255,6 +255,12 @@ properties:
>>   
>>         where voltage is in V, frequency is in MHz.
>>   
>> +  mediatek,freq-domain:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
>> +    description:
>> +      CPUs supporting freq-domain must set their "mediatek,freq-domain" property
>> +      with phandle to a cpufreq_hw node followed by the domain id.
> 
> This needs to be a common binding shared with SCMI domains.

Would it be accurate to create a new binding file:
Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.txt
?

There is already cpufreq-qcom-hw.txt with 'qcom,freq-domain'
and analogous purpose.

Regards,
Lukasz
