Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6022A2648
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 09:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgKBIlC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 03:41:02 -0500
Received: from foss.arm.com ([217.140.110.172]:55932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgKBIlC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Nov 2020 03:41:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C524101E;
        Mon,  2 Nov 2020 00:41:01 -0800 (PST)
Received: from [10.57.13.99] (unknown [10.57.13.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71DE23F718;
        Mon,  2 Nov 2020 00:40:58 -0800 (PST)
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-sustainable bindings
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201028140847.1018-2-lukasz.luba@arm.com> <20201030193427.GA4186428@bogus>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <569a07c0-be6b-7ffe-2920-accea1f932f0@arm.com>
Date:   Mon, 2 Nov 2020 08:40:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201030193427.GA4186428@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 10/30/20 7:34 PM, Rob Herring wrote:
> On Wed, Oct 28, 2020 at 02:08:44PM +0000, Lukasz Luba wrote:
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
>> +
> 
> Isn't this just the inverse of the turbo? or boost? flag we already
> have?

True, it could be possible to use those flags. Then a function which
returns one OPP below, would be 'sustainable'. I've already
suggested to skip binding and only have get/set functions for OPP
framework to mark 'sustainable' level, but Viresh is against.
We have discussed this new opp sustainable with Viresh and since it
would be only used by IPA but the definition is a bit blurry,
we decided to drop this series. Maybe in future when there will be
another user, we will come back to this.
I am going to use Energy Model and mark the em_perf_state as sustained.

> 
> Couldn't this be learned? I ran at this frequency and then overheated.
> That could be dependent on ambient temperatures or dust build up on
> fans/heatsink.

Yes it could be learned. IPA tries to do that for different workloads,
but it needs some starting conditions (coefficients and sustainable
power) to converge in short time. Sustainable power is currently
estimated based on lowest OPP. With that new 'sustainable' flag,
it would be much easier for IPA to converge.

Regards,
Lukasz

> 
> Rob
> 
