Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC69D3A2C07
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFJMzT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 08:55:19 -0400
Received: from foss.arm.com ([217.140.110.172]:59212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhFJMzS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Jun 2021 08:55:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B68F106F;
        Thu, 10 Jun 2021 05:53:20 -0700 (PDT)
Received: from [10.57.4.220] (unknown [10.57.4.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C24F3F73D;
        Thu, 10 Jun 2021 05:53:17 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20210604080954.13915-1-lukasz.luba@arm.com>
 <20210604080954.13915-2-lukasz.luba@arm.com>
 <2f2fc758-92c6-5023-4fcb-f9558bf3369e@arm.com>
 <905f1d29-50f9-32be-4199-fc17eab79d04@arm.com>
 <3cfa5690-644b-ba80-3fc3-7c5a3f292e70@arm.com>
 <c77d00b9-d7a3-0e8a-a528-ab0c1773496f@arm.com>
 <CAKfTPtAc62gyjxSiSY2vD_qr-WjqbC91_GF-LXgNXh8T0Xx-yw@mail.gmail.com>
 <d4383b7a-a5e7-18ca-14ed-c533b4d43f62@arm.com>
 <CAKfTPtBD2qa3qwpoLuLNuF-hZAGpDvsahx6Tx_enLT2DAs4fiQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <80283949-8a07-5aed-1e56-0a1094ba3ba0@arm.com>
Date:   Thu, 10 Jun 2021 13:53:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBD2qa3qwpoLuLNuF-hZAGpDvsahx6Tx_enLT2DAs4fiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/10/21 1:40 PM, Vincent Guittot wrote:
> On Thu, 10 Jun 2021 at 14:30, Lukasz Luba <lukasz.luba@arm.com> wrote:

[snip]

>>
>> So for this scenario, where we want to just align EAS with SchedUtil
>> frequency decision, which is instantaneous and has 'raw' value
>> of capping from policy->max, shouldn't we use:
>>
>> thermal_pressure = arch_scale_thermal_pressure(cpu_id)
> 
> Yes you should probably use arch_scale_thermal_pressure(cpu) instead
> of thermal_load_avg(rq) in this case
> 

Thank you Vincent for valuable opinions!
I will rewrite it and experiment with a new approach,
then send a v3.

Regards,
Lukasz
