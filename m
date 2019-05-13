Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7730F1B76C
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfEMNwx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 09:52:53 -0400
Received: from foss.arm.com ([217.140.101.70]:56538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729452AbfEMNwx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 09:52:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEB6680D;
        Mon, 13 May 2019 06:52:52 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63A453F71E;
        Mon, 13 May 2019 06:52:51 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] sched/cpufreq: Make schedutil energy aware
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, quentin.perret@arm.com,
        patrick.bellasi@arm.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, rjw@rjwysocki.net
References: <20190508174301.4828-1-douglas.raillard@arm.com>
 <CAOh2x=k23D_FefOnmLjExj1d+UiothgOmyUk=1mqFknpHNwWGg@mail.gmail.com>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <054f34d5-1b88-9337-501f-321519f5d27c@arm.com>
Date:   Mon, 13 May 2019 14:52:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOh2x=k23D_FefOnmLjExj1d+UiothgOmyUk=1mqFknpHNwWGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh, Rafael,

On 5/13/19 8:12 AM, Viresh Kumar wrote:
> On Wed, May 8, 2019 at 11:57 PM <douglas.raillard@arm.com> wrote:
>>
>> From: Douglas RAILLARD <douglas.raillard@arm.com>
>>
>> Make schedutil cpufreq governor energy-aware.
> 
> Hi Douglas,
> 
> I was wondering on why the cpufreq maintainers weren't cc'd for this set and
> then I noticed that get_maintainers doesn't report us at all for schedutil :(
>
> I have sent a patch to fix that, but please include us as well in the
> future even
> if get_maintainers doesn't report us :)

Looks like it was a mix of me not checking my checklist and get_maintainers
not catching it, I'll make sure both of you are in CC next time :)

> 
> --
> viresh

Thanks,
Douglas
