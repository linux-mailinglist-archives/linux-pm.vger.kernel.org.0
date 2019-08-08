Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDBB0866D0
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 18:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404093AbfHHQSD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 12:18:03 -0400
Received: from foss.arm.com ([217.140.110.172]:35660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHQSD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 12:18:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AD301596;
        Thu,  8 Aug 2019 09:18:02 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52AEC3F706;
        Thu,  8 Aug 2019 09:18:01 -0700 (PDT)
Subject: Re: [PATCH] sched/cpufreq: Align trace event behavior of fast
 switching
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190807153340.11516-1-douglas.raillard@arm.com>
 <CAJZ5v0gqqoOzjUMhUgqKzaj8tCegddJphr+MHj5HD2_VAc1QYQ@mail.gmail.com>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <433793e3-14c4-9f3b-d503-76471a98b0af@arm.com>
Date:   Thu, 8 Aug 2019 17:18:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gqqoOzjUMhUgqKzaj8tCegddJphr+MHj5HD2_VAc1QYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 8/7/19 9:40 PM, Rafael J. Wysocki wrote:
> On Wed, Aug 7, 2019 at 5:34 PM Douglas RAILLARD
> <douglas.raillard@arm.com> wrote:
>>
>> Fast switching path only emits an event for the CPU of interest, whereas the
>> regular path emits an event for all the CPUs that had their frequency changed,
>> i.e. all the CPUs sharing the same policy.
>>
>> With the current behavior, looking at cpu_frequency event for a given CPU that
>> is using the fast switching path will not give the correct frequency signal.
> 
> Do you actually have any systems where that is a problem?  If so, then
> what are they?
> 

That happens on Google Pixel 3 smartphone, which uses this cpufreq driver: drivers/cpufreq/qcom-cpufreq-hw.c.

[1] git clone https://git.linaro.org/people/amit.pundir/linux.git -b blueline-mainline-tracking

Thanks,
Douglas
