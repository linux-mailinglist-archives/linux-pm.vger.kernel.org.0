Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BCD27823C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 10:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgIYIKl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 04:10:41 -0400
Received: from foss.arm.com ([217.140.110.172]:38212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYIKl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Sep 2020 04:10:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A3A51045;
        Fri, 25 Sep 2020 01:10:40 -0700 (PDT)
Received: from [10.57.53.72] (unknown [10.57.53.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98FFC3F718;
        Fri, 25 Sep 2020 01:10:38 -0700 (PDT)
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cristian.marussi@arm.com, Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1600238586.git.viresh.kumar@linaro.org>
 <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
 <CAJZ5v0i0aW6jT=DD6ogyfr+bs5LZu7Gn+5A9O_bZxNsnHPojOQ@mail.gmail.com>
 <a4c5a6b9-10f8-34f8-f01d-8b373214d173@arm.com>
 <CAJZ5v0iFjzqTKTPFF5hB5C0TYSQn2rxL_6099gqUwoTARKRnZA@mail.gmail.com>
 <ae5771c8-6297-e447-4449-e39ae2ea5a0e@arm.com>
 <CAJZ5v0hkBnU_W-ZXHTfppu9pVWnQcJHho7DQPi7N7yeLOt5cgg@mail.gmail.com>
 <20200924123921.iiaqw2ufe2utnjtg@vireshk-i7>
 <f57626de-6021-e87d-63ab-33ccc46a2900@arm.com>
 <20200925060954.k5quasxz2epjdmdq@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <8ea6adc5-faf5-d982-9a0e-7cf0a6f20b5f@arm.com>
Date:   Fri, 25 Sep 2020 09:10:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200925060954.k5quasxz2epjdmdq@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/25/20 7:09 AM, Viresh Kumar wrote:
> On 24-09-20, 17:10, Lukasz Luba wrote:
>> Because of supporting this reset file, the code is going to be a bit
>> complex
> 
> I will say not very straight forward, but it isn't complex as well.
> 
>> and also visited from the scheduler. I don't know if the
>> config for stats is enabled for production kernels but if yes,
>> then forcing all to keep that reset code might be too much.
>> For the engineering kernel version is OK.
> 
> I am not sure either if they are enabled for production kernels, but even if it
> then also this code won't hit performance.
> 
>> I would say for most normal checks these sysfs stats are very useful.
>> If there is a need for investigation like you described, the trace
>> event is there, just have to be enabled. Tools like LISA would
>> help with parsing the trace and mapping to some plots or even
>> merging with scheduler context.
> 
> Right, but stats is much easier in my opinion and providing this reset
> functionality does make it easier to track. And that it is already there now.
> 
>>  From time to time some engineers are asking why the stats
>> don't show the values (missing fast-switch tracking). I think
>> they are interested in a simple use case, otherwise they would use the
>> tracing.
> 
> Right and I completely agree with that and so this patchset. I think there
> aren't any serious race conditions here that would make things bad for anyone
> and that this patchset will eventually get in after a little rearrangement.
> 

Fair enough, let see the final implementation. We can check it with perf
the speculative exec and cache util.
