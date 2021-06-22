Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014593B0658
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFVOBQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 10:01:16 -0400
Received: from foss.arm.com ([217.140.110.172]:49662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhFVOBQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Jun 2021 10:01:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 232A5ED1;
        Tue, 22 Jun 2021 06:59:00 -0700 (PDT)
Received: from [10.57.7.129] (unknown [10.57.7.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 124733F694;
        Tue, 22 Jun 2021 06:58:57 -0700 (PDT)
Subject: Re: [RFC PATCH 2/4] cpuidle: Add Active Stats calls tracking idle
 entry/exit
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
References: <20210622075925.16189-1-lukasz.luba@arm.com>
 <20210622075925.16189-3-lukasz.luba@arm.com>
 <CAJZ5v0iGv_1d3BT0HowLgecOfhNHNQdOwH6Kef5WE4-zeBbp2Q@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2f7d855c-5232-ddbe-8403-db3596dcebc5@arm.com>
Date:   Tue, 22 Jun 2021 14:58:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iGv_1d3BT0HowLgecOfhNHNQdOwH6Kef5WE4-zeBbp2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/22/21 1:33 PM, Rafael J. Wysocki wrote:
> On Tue, Jun 22, 2021 at 9:59 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The Active Stats framework tracks and accounts the activity of the CPU
>> for each performance level. It accounts the real residency,
> 
> No, it doesn't.  It just measures the time between the entry and exit
> and that's not the real residency (because it doesn't take the exit
> latency into account, for example).

It's 'just' a 'model' and as other models has limitations, but it's
better than existing one, which IPA has to use:
cpu_util + currect_freq_at_sampling_time

> 
>> when the CPU was not idle, at a given performance level. This patch adds needed calls
>> which provide the CPU idle entry/exit events to the Active Stats
>> framework.
> 
> And it adds overhead to overhead-sensitive code.
> 
> AFAICS, some users of that code will not really get the benefit, so
> adding the overhead to it is questionable.
> 
> First, why is the existing instrumentation in the idle loop insufficient?

The instrumentation (tracing) cannot be used at run time AFAIK. I need
this idle + freq information combined in a running platform, not for
post-processing (like we have in LISA). The thermal governor IPA would
use them for used power estimation.

> 
> Second, why do you need to add locking to this code?

The idle entry/exit updates the CPU's accounting data structure.
There is a reader of those data structures: thermal governor,
run from different CPU, which is the reason why I put locking for them.


