Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A7B5E59D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 15:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGCNjB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 09:39:01 -0400
Received: from foss.arm.com ([217.140.110.172]:48220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCNjB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 09:39:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C9052B;
        Wed,  3 Jul 2019 06:39:00 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C42B3F718;
        Wed,  3 Jul 2019 06:38:58 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/5] sched/cpufreq: Make schedutil energy aware
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        quentin.perret@arm.com, patrick.bellasi@arm.com,
        dietmar.eggemann@arm.com
References: <20190627171603.14767-1-douglas.raillard@arm.com>
 <20190702154422.GV3436@hirez.programming.kicks-ass.net>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <590e3dd9-ea4e-5230-d12c-d04bb3916e89@arm.com>
Date:   Wed, 3 Jul 2019 14:38:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190702154422.GV3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

On 7/2/19 4:44 PM, Peter Zijlstra wrote:
> On Thu, Jun 27, 2019 at 06:15:58PM +0100, Douglas RAILLARD wrote:
>> Make schedutil cpufreq governor energy-aware.
>>
>> - patch 1 introduces a function to retrieve a frequency given a base
>>    frequency and an energy cost margin.
>> - patch 2 links Energy Model perf_domain to sugov_policy.
>> - patch 3 updates get_next_freq() to make use of the Energy Model.
> 
>>
>> 1) Selecting the highest possible frequency for a given cost. Some
>>     platforms can have lower frequencies that are less efficient than
>>     higher ones, in which case they should be skipped for most purposes.
>>     They can still be useful to give more freedom to thermal throttling
>>     mechanisms, but not under normal circumstances.
>>     note: the EM framework will warn about such OPPs "hertz/watts ratio
>>     non-monotonically decreasing"
> 
> Humm, for some reason I was thinking we explicitly skipped those OPPs
> and they already weren't used.
> 
> This isn't in fact so, and these first few patches make it so?

That's correct, the cost information about each OPP has been introduced recently in mainline
by the energy model series. Without that info, the only way to skip them that comes to my
mind is to set a policy min frequency, since these inefficient OPPs are usually located
at the lower end.


Thanks,
Douglas
