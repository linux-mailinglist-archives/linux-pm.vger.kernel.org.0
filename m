Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C042330D5
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 13:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgG3LQm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 07:16:42 -0400
Received: from foss.arm.com ([217.140.110.172]:38316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgG3LQm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 07:16:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 684C930E;
        Thu, 30 Jul 2020 04:16:41 -0700 (PDT)
Received: from [10.37.12.66] (unknown [10.37.12.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74C303F71F;
        Thu, 30 Jul 2020 04:16:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
 <681fb3e8-d645-2558-38de-b39b372499de@arm.com>
 <CAKfTPtA+BPegK2h6PQMFs+p4dpxO+sk1FDQuOfJvSpGCJ-rBrA@mail.gmail.com>
 <20200730062414.uq3ip7ukpu7nkiyg@vireshk-mac-ubuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <bc99342a-48ee-ce30-0116-4ba5c76787c2@arm.com>
Date:   Thu, 30 Jul 2020 12:16:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200730062414.uq3ip7ukpu7nkiyg@vireshk-mac-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 7/30/20 7:24 AM, Viresh Kumar wrote:
> On 17-07-20, 11:46, Vincent Guittot wrote:
>> On Thu, 16 Jul 2020 at 16:24, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>> On 7/16/20 12:56 PM, Peter Zijlstra wrote:
>>>> Currently cpufreq_cooling appears to estimate the CPU energy usage by
>>>> calculating the percentage of idle time using the per-cpu cpustat stuff,
>>>> which is pretty horrific.
>>>
>>> Even worse, it then *samples* the *current* CPU frequency at that
>>> particular point in time and assumes that when the CPU wasn't idle
>>> during that period - it had *this* frequency...
>>
>> So there is 2 problems in the power calculation of cpufreq cooling device :
>> - How to get an accurate utilization level of the cpu which is what
>> this patch is trying to fix because using idle time is just wrong
>> whereas scheduler utilization is frequency invariant
> 
> Since this patch is targeted only towards fixing this particular
> problem, should I change something in the patch to make it acceptable
> ?
> 
>> - How to get power estimate from this utilization level. And as you
>> pointed out, using the current freq which is not accurate.
> 
> This should be tackled separately I believe.
> 

I don't think that these two are separate. Furthermore, I think we
would need this kind of information also in future in the powercap.
I've discussed with Daniel this possible scenario.

We have a vendor who presented issue with the IPA input power and
pointed out these issues. Unfortunately, I don't have this vendor
phone but I assume it can last a few minutes without changing the
max allowed OPP. Based on their plots the frequency driven by the
governor is changing, also the idles are present during the IPA period.

Please give me a few days, because I am also plumbing these stuff
and would like to present it. These two interfaces: involving cpufreq
driver or fallback mode for utilization and EM.

Regards,
Lukasz
