Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E154D216DA9
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 15:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGGN0h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 09:26:37 -0400
Received: from foss.arm.com ([217.140.110.172]:49576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGN0h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jul 2020 09:26:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D699C0A;
        Tue,  7 Jul 2020 06:26:36 -0700 (PDT)
Received: from [10.37.12.65] (unknown [10.37.12.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B6033F71E;
        Tue,  7 Jul 2020 06:26:32 -0700 (PDT)
Subject: Re: [PATCH 0/5] cpuidle: psci: Various improvements for PSCI PM
 domains
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
 <f924de32-f780-e921-fe45-cf26e70e1c66@arm.com>
 <CAPDyKFrQfjL2kBOOJj49Pf1An5ubng9_nE5=urPZM5yATR2HBg@mail.gmail.com>
 <cf424e19-de17-8fa8-f2a3-9e8f996fa7ad@arm.com>
 <CAPDyKFpc+LKZ8Khjau9iLD0YJTHvqav2HD4+aDhMaPpSEXPawA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <894922ca-6ae0-6397-117c-561919bc1ef3@arm.com>
Date:   Tue, 7 Jul 2020 14:26:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpc+LKZ8Khjau9iLD0YJTHvqav2HD4+aDhMaPpSEXPawA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/7/20 1:51 PM, Ulf Hansson wrote:
> On Tue, 7 Jul 2020 at 14:37, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 7/7/20 12:53 PM, Ulf Hansson wrote:
>>> Hi Lukaz,
>>>
>>> On Tue, 30 Jun 2020 at 12:23, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>> Hi Ulf,
>>>>
>>>> On 6/15/20 4:20 PM, Ulf Hansson wrote:
>>>>> The main change in this series is done in patch 5/5, which implements support
>>>>> to prevent domain idlestates until all PSCI PM domain consumers are ready for
>>>>> it. To reach that point the corresponding code for cpuidle-psci and
>>>>> cpuidle-psci-domain, needed to be converted into platform drivers, which is
>>>>> done by the earlier changes in the series.
>>>>>
>>>>> Additionally, some improvements have been made to the error path, which becomes
>>>>> easier when the code gets converted to platform drivers.
>>>>>
>>>>> Deployment for a Qcom SoC, which actually takes full benefit of these changes
>>>>> are also in the pipe, but deferring then a bit until $subject series have been
>>>>> discussed.
>>>>>
>>>>> Kind regards
>>>>> Ulf Hansson
>>>>>
>>>>> Ulf Hansson (5):
>>>>>      cpuidle: psci: Fail cpuidle registration if set OSI mode failed
>>>>>      cpuidle: psci: Fix error path via converting to a platform driver
>>>>>      cpuidle: psci: Split into two separate build objects
>>>>>      cpuidle: psci: Convert PM domain to platform driver
>>>>>      cpuidle: psci: Prevent domain idlestates until consumers are ready
>>>>>
>>>>>     drivers/cpuidle/Kconfig.arm           |  10 ++
>>>>>     drivers/cpuidle/Makefile              |   5 +-
>>>>>     drivers/cpuidle/cpuidle-psci-domain.c |  74 +++++++++-----
>>>>>     drivers/cpuidle/cpuidle-psci.c        | 141 +++++++++++++++-----------
>>>>>     drivers/cpuidle/cpuidle-psci.h        |  11 +-
>>>>>     5 files changed, 150 insertions(+), 91 deletions(-)
>>>>>
>>>>
>>>> Since I am interested in some CPU idle statistics (residency, etc),
>>>> I would like to help you and Sudeep in reviewing the patch set.
>>>
>>> Thanks, much appreciated!
>>>
>>>>
>>>> Could you clarify some bit below?
>>>> 1. There is Qcom SoC which has dependencies between PSCI PM domain
>>>> consumers and this CPU idle - thus we cannot register and use CPU
>>>> idle driver till related drivers fully setup.
>>>
>>> I think you got it right, but let me clarify.
>>>
>>> On Qcom SoC, PSCI PM domain consumers aren't solely CPU devices, but
>>> also the 'qcom,rpmh-rsc' device is a consumer, for example.
>>>
>>> That doesn't mean the CPU idle driver can't be probed/initialized, but
>>> rather that the PSCI PM domain must not be powered off. The power off
>>> needs to wait until all the consumers of the PSCI PM domain have been
>>> registered/probed.
>>>
>>> See more details in the commit message of patch5.
>>>
>>>> 2. The proposed solution is to use platform driver and plat. device
>>>> for this CPU idle driver, to have access to deferred probe mechanism and
>>>> wait for the consumer drivers fully probed state.
>>>
>>> Correct, but let me fill in some more.
>>>
>>> I would like to use the ->sync_state() callback of the PSCI PM domain
>>> driver, as a way to understand that all consumers have been probed.
>>>
>>>> 3. Do you have maybe some estimations how long it takes for these
>>>> consumers to be fully probed?
>>>
>>> I am not sure I understand the reason for the question.
>>
>> I was wondering if this is because of HW issue of long setup, thus
>> we need to wait a bit longer with drivers deferred probing.
>> But this is not the case as I can see now.
>>
>>
>>>
>>> Anyway, at this point, I am looking at the qcom,rpmh-rsc device, which
>>> is being probed by the drivers/soc/qcom/rpmh-rsc.c driver. Moving
>>> forward, in principle it can be any device/driver that is a consumer
>>> of the PSCI PM domain. I am not even excluding that drivers can be
>>> modules. It should work for all cases.
>>
>> The late_initcall won't help, this is a really tough requirement:
>> being a module...
>>
>>
>>>
>>>> 4. Changing just this CPU idle driver registration point (to
>>>> late_initcall()) phase in time is not a solution.
>>>
>>> Correct, it doesn't work.
>>>
>>> Playing with initcalls doesn't guarantee anything when it comes to
>>> making sure all consumers are ready.
>>
>> I agree, especially when modules are involved.
>>
>>>
>>> Hope this clarifies things a bit for you, but just tell me if there is
>>> anything more I can do to further explain things.
>>
>> Yes, thank you. I can see now why you need this explicit ->sync_state()
>> callback.
>> I don't see better solution to what you have proposed here.
>> I will go through the patches once again to check and add some
>> reviewed-by.
>>
> 
> Thanks a lot for your time! I am just about to post a v2, to re-order
> the series so patch 3 comes first, according to suggestions from Lina.
> 
> Please move over to review that version instead, in a few minutes.

OK, got it in my mailbox, thanks!

Regards,
Lukasz
