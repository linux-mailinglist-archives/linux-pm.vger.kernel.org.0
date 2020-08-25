Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEB6251422
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 10:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHYIZT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 04:25:19 -0400
Received: from foss.arm.com ([217.140.110.172]:53192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgHYIZT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 04:25:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0939A30E;
        Tue, 25 Aug 2020 01:25:18 -0700 (PDT)
Received: from [10.37.12.65] (unknown [10.37.12.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EF863F68F;
        Tue, 25 Aug 2020 01:25:14 -0700 (PDT)
Subject: Re: [PATCH v1] thermal/of: Introduce k-po, k-pu and k-i for a thermal
 zone
To:     Rob Herring <robh@kernel.org>
Cc:     Finley Xiao <finley.xiao@rock-chips.com>, heiko@sntech.de,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        huangtao@rock-chips.com, tony.xie@rock-chips.com, cl@rock-chips.com
References: <20200811123115.8144-1-finley.xiao@rock-chips.com>
 <20200824230956.GA3500214@bogus>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c3f54e18-8683-8bd9-90fa-e3465cddf8e8@arm.com>
Date:   Tue, 25 Aug 2020 09:25:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200824230956.GA3500214@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 8/25/20 12:09 AM, Rob Herring wrote:
> On Tue, Aug 11, 2020 at 08:31:15PM +0800, Finley Xiao wrote:
>> The default value for k_pu is:
>>      2 * sustainable_power / (desired_temperature - switch_on_temp)
>> The default value for k_po is:
>>      sustainable_power / (desired_temperature - switch_on_temp)
>> The default value for k_i is 10.
>>
>> Even though these parameters of the PID controller can be changed
>> by the following sysfs files:
>>      /sys/class/thermal/thermal_zoneX/k_pu
>>      /sys/class/thermal/thermal_zoneX/k_po
>>      /sys/class/thermal/thermal_zoneX/k_i
>>
>> But it's still more convenient to change the default values by devicetree,
>> so introduce these three optional properties. If provided these properties,
>> they will be parsed and associated with the thermal zone via the thermal
>> zone parameters.
>>
>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>> ---
>>   Documentation/devicetree/bindings/thermal/thermal.txt | 14 ++++++++++++++
> 
> Bindings should be a separate file and this one is a DT schema now.
> 
>>   drivers/thermal/thermal_of.c                          |  7 +++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index f78bec19ca35..ebe936b57ded 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -165,6 +165,20 @@ Optional property:
>>   			2000mW, while on a 10'' tablet is around
>>   			4500mW.
>>   
>> +- k-po:			Proportional parameter of the PID controller when
>> +			current temperature is above the target.
>> +  Type: signed
>> +  Size: one cell
>> +
>> +- k-pu:			Proportional parameter of the PID controller when
>> +			current temperature is below the target.
>> +  Type: signed
>> +  Size: one cell
>> +
>> +- k-i:			Integral parameter of the PID controller.
>> +  Type: signed
>> +  Size: one cell
> 
> What's PID?
> 
> I know nothing about the sysfs params, but the binding needs to stand on
> it's own and needs enough detail to educate me.
> 

Sorry for the delay, I missed that patch.
These parameters are the coefficients for the
Proportional-Integral-Derivative (PID) controller [1], which is the
core of the Intelligent Power Allocation (IPA) thermal governor.

Only IPA uses them, thus I don't think the governors parameters:
k-po, k-pu, k-i
should be part of the DeviceTree. I haven't seen such governors
tunnables in the DT, please point me if they exist somewhere.

Do you think Rob they might be specified in the DT?

Regards,
Lukasz

[1] https://en.wikipedia.org/wiki/PID_controller
