Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4008B29E83E
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 11:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgJ2KEW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 06:04:22 -0400
Received: from foss.arm.com ([217.140.110.172]:58524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgJ2KEW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 06:04:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C972139F;
        Thu, 29 Oct 2020 03:04:21 -0700 (PDT)
Received: from [10.57.13.20] (unknown [10.57.13.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A333F66E;
        Thu, 29 Oct 2020 03:04:18 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-sustainable bindings
To:     Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        rafael@kernel.org, sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201028140847.1018-2-lukasz.luba@arm.com>
 <20201028214713.zttk47qtua5jhieo@pureness>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5b3a99a8-6972-5c60-6cc5-00ec84387b97@arm.com>
Date:   Thu, 29 Oct 2020 10:04:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201028214713.zttk47qtua5jhieo@pureness>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/28/20 9:47 PM, Nishanth Menon wrote:
> On 14:08-20201028, Lukasz Luba wrote:
>> Add opp-sustainable as an additional property in the OPP node to describe
>> the sustainable performance level of the device. This will help to
>> estimate the sustainable performance of the whole system.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   Documentation/devicetree/bindings/opp/opp.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>> index 9847dfeeffcb..cd01028de305 100644
>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>> @@ -154,6 +154,10 @@ Optional properties:
>>   - opp-suspend: Marks the OPP to be used during device suspend. If multiple OPPs
>>     in the table have this, the OPP with highest opp-hz will be used.
>>   
>> +- opp-sustainable: Marks the OPP as sustainable. This property can be used for
>> +  estimating sustainable performance of the whole system. If multiple OPPs in
>> +  the table have this, the OPP with highest opp-hz will be used.
> 
> 
> By "sustainable", do you mean sustainable across Process, Voltage and
> Temperature corners upto the max rated operational Power-ON hours
> without IDLE state being achieved on the processor?

Yes, in case of CPU: running 100% without idle at that particular OPP.
Running above that OPP would lead to cross control temperature.

> 
> OR do you mean to leave it up to interpretation?

I can tell how I would use them. There is thermal governor IPA, which
needs sustainable power either form DT or uses internal algorithm to
estimate it based on lowest allowed freq OPPs. Then it estimated
internal coefficients based on that value, which is not optimal
for lowest OPPs. When some higher OPP could be marked as sustainable,
it would lead to better estimation and better power budget split.

Regards,
Lukasz
