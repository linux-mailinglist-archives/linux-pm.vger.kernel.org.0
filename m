Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3D23B8FF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgHDKoO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 06:44:14 -0400
Received: from foss.arm.com ([217.140.110.172]:42436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgHDKoO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 06:44:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BE5F31B;
        Tue,  4 Aug 2020 03:44:13 -0700 (PDT)
Received: from [10.37.12.45] (unknown [10.37.12.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF34E3F718;
        Tue,  4 Aug 2020 03:44:11 -0700 (PDT)
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        cristian.marussi@arm.com, rjw@rjwysocki.net
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <20200730085333.qubrsv7ufqninihd@vireshk-mac-ubuntu>
 <20200730091014.GA13158@bogus> <3b3a56e9-29ec-958f-fb3b-c689a9389d2f@arm.com>
 <20200804053502.35d3x3vnb3mggtqs@vireshk-mac-ubuntu>
 <f784bf30-83a6-55ff-8fa6-f7bd2d4399b9@arm.com>
 <20200804103857.mxgkmt6qmmzejuzb@vireshk-mac-ubuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <1f978078-b2df-a2e5-6af8-e73f65044ba7@arm.com>
Date:   Tue, 4 Aug 2020 11:44:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200804103857.mxgkmt6qmmzejuzb@vireshk-mac-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/4/20 11:38 AM, Viresh Kumar wrote:
> On 04-08-20, 11:29, Lukasz Luba wrote:
>> On 8/4/20 6:35 AM, Viresh Kumar wrote:
>>> IIUC, the only concern right now is to capture stats with fast switch ? Maybe we
>>> can do something else in that case and brainstorm a bit..
>>
>> Correct, the fast switch is the only concern right now and not tracked. We
>> could fill in that information with statistics data from firmware
>> with a cpufreq driver help.
>>
>> I could make the if from patch 1/4 covering narrowed case, when
>> fast switch is present, check for drivers stats.
>> Something like:
>> -----------8<------------------------------------------------------------
>> if (policy->fast_switch_enabled)
>> 	if (policy->has_driver_stats)
>> 		return cpufreq_stats_present_driver_data(policy, buf);
>> 	else
>> 		return 0;
>> -------------->8----------------------------------------------------------
> 
> I don't think doing it with help of firmware is the right thing to do
> here then. For another platform we may not have a firmware which can
> help us, we need something in the opp core itself for that. Lemme see
> if I can do something about it.

OK, great, I will wait then with this patch series v2 which would change
into debugfs scmi only. Could you please add me on CC, I am very
interested in.

> 
>>> Why is firmware the governor here ? Aren't you talking about the simple fast
>>> switch case only ?
>>
>> I used a term 'governor' for the firmware because it makes the final
>> set for the frequency. It (FW) should respect the frequency value
>> set using the fast switch. I don't know how other firmware (e.g. Intel)
>> treats this fast switch value or if they even expose FW stats, though.
> 
> For Intel I think, Linux is one of the entities that vote for deciding
> the frequency of the CPUs and the firmware (after taking all such
> factors into account) chooses a frequency by its own, which must be >=
> the frequency requested by Linux.
> 
>> You can read about this statistics region in [1] at:
>> 4.5.5 Performance domain statistics shared memory region
>>
>>>
>>> Over that, I think this cpufreq stats information isn't parsed by any tool right
>>> now and tweaking it a bit won't hurt anyone (like if we start capturing things a
>>> bit differently). So we may not want to worry about breaking userspace ABI here,
>>> if what we are looking to do is the right thing to do.
>>
>> So, there is some hope... IMHO it would be better to have this cpufreq
>> stats in normal location, rather then in scmi debugfs.
> 
> I agree.
> 
>>> I am not sure what notifications are we talking about here.
>>
>> There is a notification mechanism described in the SCMI spec [1] at
>> 4.5.4 Notifications.
>> We were referring to that mechanism.
> 
> Ahh, I see. All I was thinking was about the cpufreq specific
> notifiers :)
> 
