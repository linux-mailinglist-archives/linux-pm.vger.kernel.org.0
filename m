Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C173BA433
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhGBTKB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jul 2021 15:10:01 -0400
Received: from foss.arm.com ([217.140.110.172]:52972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhGBTKA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Jul 2021 15:10:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39E061FB;
        Fri,  2 Jul 2021 12:07:28 -0700 (PDT)
Received: from [10.57.14.38] (unknown [10.57.14.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 270633F718;
        Fri,  2 Jul 2021 12:07:24 -0700 (PDT)
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAJZ5v0iOzp5FKo4NsNE-m+sEXZUvv1TbkAO_9+jSidx9c0iq8A@mail.gmail.com>
 <ffc63114-c1c2-f866-8b2a-15e9fd0a7818@arm.com>
Message-ID: <6ce4d4c8-889b-f2cf-f282-213b9a7651ab@arm.com>
Date:   Fri, 2 Jul 2021 20:07:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ffc63114-c1c2-f866-8b2a-15e9fd0a7818@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

Gentle ping.
You might missed my previous email.

On 6/30/21 6:28 PM, Lukasz Luba wrote:
> 
> 
> On 6/30/21 6:01 PM, Rafael J. Wysocki wrote:
>> On Fri, Jun 25, 2021 at 5:26 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>> The Energy Aware Scheduler (EAS) tries to find best CPU for a waking up
>>> task. It probes many possibilities and compares the estimated energy 
>>> values
>>> for different scenarios. For calculating those energy values it 
>>> relies on
>>> Energy Model (EM) data and em_cpu_energy(). The precision which is 
>>> used in
>>> EM data is in milli-Watts (or abstract scale), which sometimes is not
>>> sufficient. In some cases it might happen that two CPUs from different
>>> Performance Domains (PDs) get the same calculated value for a given task
>>> placement, but in more precised scale, they might differ. This rounding
>>> error has to be addressed. This patch prepares EAS code for better
>>> precision in the coming EM improvements.
>>>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>
>> If you want me to pick up this series, this patch requires an ACK from
>> the scheduler maintainers.
>>
> 
> It would be great, if you could take it after e.g. Peter ACK it.
> 
> Peter could you have a look at it, please?
> In this patch 1/3 we have only variables upgrade.
> 
> Regards,
> Lukasz

Could you have a look and ACK the patch 1/3, please?
