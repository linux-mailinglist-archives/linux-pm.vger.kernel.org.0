Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3547E646AD3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 09:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLHIns (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Dec 2022 03:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiLHIn3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2022 03:43:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C9C0663F4;
        Thu,  8 Dec 2022 00:43:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A9F123A;
        Thu,  8 Dec 2022 00:43:31 -0800 (PST)
Received: from [192.168.33.10] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B8FB3F73D;
        Thu,  8 Dec 2022 00:43:22 -0800 (PST)
Message-ID: <a6b22f53-da3a-559b-9244-425ba0d7f9c3@arm.com>
Date:   Thu, 8 Dec 2022 08:43:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] cpufreq: schedutil: Optimize operations with
 single max CPU capacity
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, saravanak@google.com,
        wusamuel@google.com, isaacmanjarres@google.com,
        kernel-team@android.com, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
References: <20221207101705.9460-1-lukasz.luba@arm.com>
 <20221207101705.9460-3-lukasz.luba@arm.com>
 <20221208040921.tgwegk7fvdm4nkiu@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221208040921.tgwegk7fvdm4nkiu@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/8/22 04:09, Viresh Kumar wrote:
> On 07-12-22, 10:17, Lukasz Luba wrote:
>> The max CPU capacity is the same for all CPUs sharing frequency domain
>> and thus 'policy' object. There is a way to avoid heavy operations
>> in a loop for each CPU by leveraging this knowledge. Thus, simplify
>> the looping code in the sugov_next_freq_shared() and drop heavy
>> multiplications. Instead, use simple max() to get the highest utilization
>> from these CPUs. This is useful for platforms with many (4 or 6) little
>> CPUs.
>>
>> The max CPU capacity must be fetched every time we are called, due to
>> difficulties during the policy setup, where we are not able to get the
>> normalized CPU capacity at the right time.
>>
>> The stored value in sugov_policy::max is also than used in
>> sugov_iowait_apply() to calculate the right boost. Thus, that field is
>> useful to have in that sugov_policy struct.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> Looks okay to me.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thank you Viresh!

As Rafael said, it will wait after 6.2-rc1 is out.

Regards,
Lukasz
