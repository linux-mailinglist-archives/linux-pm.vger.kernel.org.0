Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669CB3EE913
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 11:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhHQJEx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 05:04:53 -0400
Received: from foss.arm.com ([217.140.110.172]:52676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239474AbhHQJEm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Aug 2021 05:04:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 513B331B;
        Tue, 17 Aug 2021 02:03:58 -0700 (PDT)
Received: from [10.57.11.194] (unknown [10.57.11.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF03D3F40C;
        Tue, 17 Aug 2021 02:03:55 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
 <CAJZ5v0hta1mEVatT=6ZMLhZCs3btcSbTT10YEihfdvB-WxDuzQ@mail.gmail.com>
 <20210817070619.g6ootmga3nyxm7tz@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <43cd2dfc-a9bf-ccaa-292c-a36124d57025@arm.com>
Date:   Tue, 17 Aug 2021 10:03:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210817070619.g6ootmga3nyxm7tz@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/17/21 8:06 AM, Viresh Kumar wrote:
> On 16-08-21, 16:19, Rafael J. Wysocki wrote:
>> On Tue, Aug 10, 2021 at 8:13 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>   I understand  that this was done to not do the efficient stuff in case of
>>>    userspace/powersave/performance governors.
>>>
>>>    What about reusing following for finding all such cases ?
>>>
>>>          policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING
>>>
>>>    The driver can set a flag to tell if it wants efficient frequencies
>>>    or not, and at runtime we apply efficient algorithm only if the
>>>    current governor does DVFS, which will leave out
>>>    userspace/performance/powersave.
>>
>> As long as this can be done without actually accessing
>> policy->governor->flags on every transition, it sounds like a good
>> idea.
> 
> Great.
> 
> Vincent, I hope you will be taking this forward then ?
> 

Vincent has been on vacations for quite a while, but he will be back
next week.

Thank you guys for the comments.
