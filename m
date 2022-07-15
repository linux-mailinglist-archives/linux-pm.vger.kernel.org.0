Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C5D5760CF
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiGOLrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 07:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiGOLrm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 07:47:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5A9E88F12;
        Fri, 15 Jul 2022 04:47:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E705B1474;
        Fri, 15 Jul 2022 04:47:40 -0700 (PDT)
Received: from [10.57.11.112] (unknown [10.57.11.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48E533F73D;
        Fri, 15 Jul 2022 04:47:39 -0700 (PDT)
Message-ID: <deddd9cc-f517-cff9-e304-e1f09c6784b7@arm.com>
Date:   Fri, 15 Jul 2022 12:47:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] cpufreq: schedutil: Move max CPU capacity to sugov_policy
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20220711124229.16516-1-lukasz.luba@arm.com>
 <1198724e-d94f-0b7c-9c4a-90595f8426d2@arm.com>
 <CAJZ5v0gh78z3tw6simaZ5S6dmGvDc-OE6t02N8vQYk-2eoFQgA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0gh78z3tw6simaZ5S6dmGvDc-OE6t02N8vQYk-2eoFQgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/15/22 12:44, Rafael J. Wysocki wrote:
> On Fri, Jul 15, 2022 at 10:47 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> gentle ping.
>>
>> On 7/11/22 13:42, Lukasz Luba wrote:
>>> There is no need to keep the max CPU capacity in the per_cpu instance.
>>> Furthermore, there is no need to check and update that variable
>>> (sg_cpu->max) everytime in the frequency change request, which is part
>>> of hot path. Instead use struct sugov_policy to store that information.
>>> Initialize the max CPU capacity during the setup and start callback.
>>> We can do that since all CPUs in the same frequency domain have the same
>>> max capacity (capacity setup and thermal pressure are based on that).
>>>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>>    kernel/sched/cpufreq_schedutil.c | 30 +++++++++++++++---------------
>>>    1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> The patch got Ack from Viresh.
>> Could you take it?
> 
> Yes, it's there in my queue.  Same for the EM changes.

Thank you Rafael!
