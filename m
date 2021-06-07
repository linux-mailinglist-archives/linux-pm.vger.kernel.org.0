Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42F839D967
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 12:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFGKQu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 06:16:50 -0400
Received: from foss.arm.com ([217.140.110.172]:57194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbhFGKQu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Jun 2021 06:16:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A8AC1063;
        Mon,  7 Jun 2021 03:14:59 -0700 (PDT)
Received: from [192.168.43.77] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 668363F73D;
        Mon,  7 Jun 2021 03:14:56 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <20210607050208.3annn3dtmfrfxpzo@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <db121d81-8397-cbdd-77dc-b70c27230dbc@arm.com>
Date:   Mon, 7 Jun 2021 11:14:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210607050208.3annn3dtmfrfxpzo@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/7/21 6:02 AM, Viresh Kumar wrote:
> On 04-06-21, 12:05, Vincent Donnefort wrote:
>> Some SoCs such as the sd855 have OPPs within the same policy whose cost is
>> higher than others with a higher frequency. Those OPPs are inefficients and
>> it might be interesting for a governor to not use them.
>>
>> Adding a flag, CPUFREQ_INEFFICIENT_FREQ, to mark such OPPs into the
>> frequency table, as well as a new cpufreq_frequency_table member
>> "efficient". This new member will allow a governor to quickly resolve an
>> inefficient frequency to an efficient one.
>>
>> Efficient OPPs point to themselves. Governors must also ensure that the
>> efficiency resolution does not break the policy maximum.
>>
>> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> I was thinking about a different approach when I suggested it.
> 
> - The cpufreq table instead of an index, will have "efficient" as bool.
> 
> - EM will set an OPP as efficient or inefficient, based on the OPP
>    table, there will be a flag for this in the OPP table.
> 
> - The cpufreq table is then created from OPP table and this
>    information is automatically retrieved.
> 

There are some issues with your proposed approach:
The EM doesn't depend on OPP framework (even no header from opp.h)
and we don't want to add this dependency in EM.

The Vincent's proposed implementation doesn't introduce this
dependency.

Regards,
Lukasz
