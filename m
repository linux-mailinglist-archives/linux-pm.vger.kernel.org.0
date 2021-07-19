Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EC93CCFCA
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jul 2021 11:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhGSIUU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jul 2021 04:20:20 -0400
Received: from foss.arm.com ([217.140.110.172]:53032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235728AbhGSIUO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Jul 2021 04:20:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D8B06D;
        Mon, 19 Jul 2021 01:52:10 -0700 (PDT)
Received: from [10.57.3.138] (unknown [10.57.3.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E93D3F73D;
        Mon, 19 Jul 2021 01:52:07 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/6] Introduce Active Stats framework with CPU
 performance statistics
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>, Beata.Michalska@arm.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kachhap <amit.kachhap@gmail.com>
References: <20210706131828.22309-1-lukasz.luba@arm.com>
 <CAJZ5v0ga1O9Y9Lam=BoXofE7sjTNpYVSTjAWvSGZ+j__aCeXJw@mail.gmail.com>
 <1de9d474-fdeb-8db6-0b01-53a90f7c20c8@arm.com>
 <CAJZ5v0gzpfT__EyrVuZSr32ms7-YJZw7qEok0WZECv1iDRRvWA@mail.gmail.com>
 <4d4801c3-1d84-9754-815c-71a6412cf4f3@arm.com>
 <CAJZ5v0i3UUKxQbcfTVWHOeje-LTOnuAMda3FX0D5sqHLXEs3Xg@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c54c4f02-56a8-9689-abd8-0632a2e3e1d1@arm.com>
Date:   Mon, 19 Jul 2021 09:52:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i3UUKxQbcfTVWHOeje-LTOnuAMda3FX0D5sqHLXEs3Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/14/21 7:30 PM, Rafael J. Wysocki wrote:
> Sorry for the delay.

Thank you for coming back with comments.
No worries, I've been on holidays last week :)

[snip]

>>>>
>>>> I understand your concerns. If you have another idea than this framework
>>>> I'm happy to hear it. Maybe better stats in cpuidle, which would be
>>>> are of the cpufreq?
>>>
>>> One idea that I have is outlined above and I'm not seeing a reason to
>>> put cpufreq statistics into cpuidle.
>>>
>>
>> I'm happy to prepare such RFC if you like.
> 
> Well, it should be quite clear that I would prefer this to the
> original approach, if viable at all. :-)

Sure, let me check if this approach is viable. I'll come back to you
in next days...

> 
>> I would just need a bit more information.
> 
> OK

For now I have only high level questions:
1. The stats data structures and related manageable code should
live in the cpuidle and cpufreq just calls some API to notify about
freq transition? (no split of data, code between these two frameworks)
2. The registration/allocation of these structures inside the
cpuidle could be done using cpufreq_register_notifier() with
notification mechanism?
3. CPU hotplug notification (which is needed for these stats) can be
used inside the cpuidle (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,...))?

