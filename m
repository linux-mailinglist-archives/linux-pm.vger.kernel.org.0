Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F2F29076D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395312AbgJPOnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 10:43:24 -0400
Received: from foss.arm.com ([217.140.110.172]:38476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395275AbgJPOnY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Oct 2020 10:43:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2BF030E;
        Fri, 16 Oct 2020 07:43:22 -0700 (PDT)
Received: from [10.57.21.20] (unknown [10.57.21.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 698AA3F71F;
        Fri, 16 Oct 2020 07:43:18 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     Quentin Perret <qperret@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
References: <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
 <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org>
 <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
 <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
 <00ceec64-3273-bb4a-6f38-22de8d877ab5@linaro.org>
 <CAJZ5v0hV8fwRnADdjiiF=zapO3AE6=_W_PeOQ_WhUirCcFkgdA@mail.gmail.com>
 <e321191c-61d2-a15d-47c2-653b277984ca@linaro.org>
 <20201016121844.GA2420691@google.com>
 <b3c6d7a5-0564-6e84-77ff-9afe10d7ee27@linaro.org>
 <20201016130905.GA2426638@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <deffb2b4-34cb-3f46-af89-cc216d1cf5c5@arm.com>
Date:   Fri, 16 Oct 2020 15:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201016130905.GA2426638@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/16/20 2:09 PM, Quentin Perret wrote:
> On Friday 16 Oct 2020 at 14:50:29 (+0200), Daniel Lezcano wrote:
>> On 16/10/2020 14:18, Quentin Perret wrote:
>>> On Friday 16 Oct 2020 at 13:48:33 (+0200), Daniel Lezcano wrote:
>>>> If the SCMI is returning abstract numbers, the thermal IPA governor will
>>>> use these numbers as a reference to mitigate the temperature at the
>>>> specified sustainable power which is expressed in mW in the DT. So it
>>>> does not work and we can not detect such conflict.
>>>>
>>>> That is why I'm advocating to keep mW for the energy model and make the
>>>> SCMI and DT power numbers incompatible.
>>>
>>> I think it's fair to say SCMI-provided number should only be compared to
>>> other SCMI-provided numbers, so +1 on that. But what I don't understand
>>> is why specifying the EM in mW helps with that?
>>
>> It is already specified in mW. I'm just saying to not add the
>> 'scale'/'abstract'/'bogoWatt' in the documentation.
>>
>>> Can we not let the providers specify the unit?
>>
>> Yes, it is possible but the provider must give the 'unit' and the energy
>> model must store this information along with the "power" numbers, so we
>> can compare apple with apple.
>>
>> Today, the energy model is using the mW unit only and the providers are
>> not telling the 'unit', so both are missing.
>>
>> Because both are missing, it does not make sense to talk about
>> 'abstract' values in the energy model documentation until the above is
>> fixed.
> 
> Right, so that sounds like a reasonable way forward with this series.
> 
> Lukasz would you be able to re-spin this with a first patch that allows
> the EM provider to specify a unit? And perhaps we could use Doug's idea
> for the sustained power DT binding and allow specifying a unit
> explicitly there too, so we're sure to compare apples with apples.

Do you mean a new entry in DT which will be always below
'dynamic-power-coefficient' and/or 'sustainable-power' saying the unit
of above value?

There was discussion with Rob (and Doug) about this. I got the
impression he was against any new DT stuff [1].
We don't have to, I think we all agree that DT will only support mW.

I have agreed to this idea having a 'flag' inside EM [2], which
indicates the mW or bogoWatts. It could be set via API:
em_dev_register_perf_domain() and this new last argument.

I can write that patch. There is only two usage (3rd is on LKML) of
that function. The DT way, which is via:
dev_pm_opp_of_register_em() will always set 'true';
Driver direct calls of em_dev_register_perf_domain(), will have to
set appropriate value ('true' or 'false'). The EM struct em_perf_domain
will have the new bool field set based on that.
Is it make sense?

Regards,
Lukasz

[1] 
https://lore.kernel.org/lkml/CAL_JsqJ=brfbLiTm9D+p2N0Az-gcStbYj=RS2EaG50dHo0-5WA@mail.gmail.com/
[2] 
https://lore.kernel.org/lkml/3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com/

> 
> Thanks,
> Quentin
> 
