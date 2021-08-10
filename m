Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382F33E7C5C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbhHJPd5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 11:33:57 -0400
Received: from foss.arm.com ([217.140.110.172]:58176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243118AbhHJPd5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 11:33:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25BF81FB;
        Tue, 10 Aug 2021 08:33:35 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F7EA3F718;
        Tue, 10 Aug 2021 08:33:33 -0700 (PDT)
Subject: Re: [PATCH 1/8] cpufreq: Auto-register with energy model if asked
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <b48e2c944db072c220a1b0ae0c3d94eb1c4da7ab.1628579170.git.viresh.kumar@linaro.org>
 <f96f852f-0d73-7ad2-d7a9-eab6a5b7f454@arm.com>
 <20210810093828.drel3kuurmhd4ki7@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <821da524-0ca5-6923-2f57-2d6ed4723c7d@arm.com>
Date:   Tue, 10 Aug 2021 16:33:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210810093828.drel3kuurmhd4ki7@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/10/21 10:38 AM, Viresh Kumar wrote:
> On 10-08-21, 10:36, Lukasz Luba wrote:
>> The of_cpufreq_cooling_register() should be called after the EM
>> is present for the CPU device. When you check that function,
>> you will see that we call
>> em_cpu_get(policy->cpu)
>> to get the EM pointer. Otherwise IPA might fail.
> 
> Good point.
> 

In other patch set I had a discussion with Quentin and I've checked
the Performance Domains setup code. There is a code triggering the
rebuilding perf domains with EM from governor. We cannot call
EM registration so late in this cpufreq_online(), not after
cpufreq_init_policy() call.

So this dev_pm_opp_of_unregister_em() must be called before
the policy is initialized. I'm not sure if you still would like
to push forward this patch set in this case.
