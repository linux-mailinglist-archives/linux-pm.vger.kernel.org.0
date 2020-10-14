Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20A728DC76
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 11:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgJNJLg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 05:11:36 -0400
Received: from foss.arm.com ([217.140.110.172]:56956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgJNJLg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Oct 2020 05:11:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17C7530E;
        Wed, 14 Oct 2020 02:11:35 -0700 (PDT)
Received: from [10.57.50.223] (unknown [10.57.50.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 324C23F73C;
        Wed, 14 Oct 2020 02:11:32 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        chris.redpath@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7> <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7> <20201012154915.GD16519@bogus>
 <20201012165219.GA3573@arm.com>
 <17819d4d-9e7e-9a38-4227-d0d10a0749f1@arm.com>
 <20201014042531.r7iykzygkvmpsqck@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <666fc9cf-ac5a-2289-d838-14c36dc8dfcb@arm.com>
Date:   Wed, 14 Oct 2020 10:11:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201014042531.r7iykzygkvmpsqck@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/14/20 5:25 AM, Viresh Kumar wrote:
> On 12-10-20, 18:18, Lukasz Luba wrote:
>> On 10/12/20 5:52 PM, Ionela Voinescu wrote:
>>> On Monday 12 Oct 2020 at 16:49:30 (+0100), Sudeep Holla wrote:
>>>> On Fri, Oct 09, 2020 at 11:09:21AM +0530, Viresh Kumar wrote:
>>>>> - I wonder if we can keep using that instead of creating new bindings
>>>>>     for exact same stuff ? Though the difference here would be that the
>>>>>     OPP may not have any other entries.
>>>>
>>>> Well summarised, sorry for chiming in late. I could have not summarised
>>>> any better. Just saw the big thread and was thinking of summarising.
>>>> If the last point on OPP is possible(i.e. no OPP entries but just use
>>>> it for fetch the information) for $subject patch is trying to achieve,
>>>> then it would be good.
> 
> Under normal circumstances, I wouldn't have suggested empty opp-tables
> for sure but it doesn't seem worth adding another binding to get this
> information out :)
> 
>>>
>>> Just to put in my two pennies worth: using opp-shared (in possibly empty
>>> OPP table) as alternative to cpu-perf-dependencies sounds good enough
>>> to me as well.
>>
>> +1
> 
> Now that (almost) everyone agrees, I don't think we need to make any
> change anywhere, in code or bindings. This should work right now as
> well.  The code should never try to create OPP tables and the core
> will not create one. Your driver (which want to get this information
> out of empty OPP tables) shall call dev_pm_opp_of_get_sharing_cpus(),
> which just parses the DT to get this information out.
> 

Thank you Viresh. We are going to experiment with this and come back
soon.

Regards,
Lukasz
