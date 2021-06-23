Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E313B1691
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 11:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFWJRE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 05:17:04 -0400
Received: from foss.arm.com ([217.140.110.172]:60362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFWJRD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Jun 2021 05:17:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7696C31B;
        Wed, 23 Jun 2021 02:14:46 -0700 (PDT)
Received: from [10.57.10.184] (unknown [10.57.10.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90D5A3F719;
        Wed, 23 Jun 2021 02:14:44 -0700 (PDT)
Subject: Re: [RFC PATCH 3/4] cpufreq: Add Active Stats calls tracking
 frequency changes
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        dietmar.eggemann@arm.com, Chris.Redpath@arm.com,
        Beata.Michalska@arm.com, rjw@rjwysocki.net, amit.kachhap@gmail.com
References: <20210622075925.16189-1-lukasz.luba@arm.com>
 <20210622075925.16189-4-lukasz.luba@arm.com>
 <20210622093258.lddlznwsndpw5mju@vireshk-i7>
 <a5d5d6b8-f358-d1d6-86d0-750af76b0cfb@arm.com>
 <20210623031517.tldkue7dcx4bt7gn@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a019ea67-7e9e-8933-baeb-cf866763de3e@arm.com>
Date:   Wed, 23 Jun 2021 10:14:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210623031517.tldkue7dcx4bt7gn@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/23/21 4:15 AM, Viresh Kumar wrote:
> On 22-06-21, 12:07, Lukasz Luba wrote:
>> That cpufreq_stats_record_transition() is present only if
>> CONFIG_CPU_FREQ_STAT is set. I didn't wanted to be dependent on
>> this config.
> 
> Right, but you can also update the dummy
> cpufreq_stats_record_transition() function as well and you won't
> depend on the CONFIG then.

It would look a bit 'hidden', but I can do that.
It will require the header active_stats.h in that cpufreq.h
to add the line in the empty cpufreq_stats_record_transition().

If Rafael would also agree, then I can put it there.
