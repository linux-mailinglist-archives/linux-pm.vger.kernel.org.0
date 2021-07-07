Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1C3BE65A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhGGKcR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 06:32:17 -0400
Received: from foss.arm.com ([217.140.110.172]:33952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhGGKcR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 06:32:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70EC1ED1;
        Wed,  7 Jul 2021 03:29:37 -0700 (PDT)
Received: from [10.57.1.129] (unknown [10.57.1.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64A7C3F694;
        Wed,  7 Jul 2021 03:29:34 -0700 (PDT)
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
 <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com>
 <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
 <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com>
 <CAKfTPtDk1ANfjR5h_EjErVfQ7=is3n9QOaKKxz81tMHtqUM7jA@mail.gmail.com>
 <297df159-1681-f0a7-843d-f34d86e51d4c@arm.com>
 <CAKfTPtCEo+gkV2TMhOHSnuUyu5BC54o-B4Hb=QbzgT6Dft-PhQ@mail.gmail.com>
 <27916860-33b1-f0a0-acff-4722a733c81b@arm.com>
 <CAKfTPtB2ogGbGBjJNRBB5jvN24q-tXFR+BpJ31fzsTd2=pDTHQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ee3ebbaa-7b6d-416d-2caa-197c2713dd4e@arm.com>
Date:   Wed, 7 Jul 2021 11:29:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB2ogGbGBjJNRBB5jvN24q-tXFR+BpJ31fzsTd2=pDTHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/7/21 11:11 AM, Vincent Guittot wrote:
> On Wed, 7 Jul 2021 at 12:06, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>

[snip]

>> No. It's in 0.1uW scale, so 800Watts. Which is 16 CPUs * 64Watts
> 
> Oh! you want 0.1uW precision .... This doesn't seem realistic at all.
> I'm not even sure that the power model can even reach an accuracy of
> 1mW
> 

True, the EM is registering platform with 1mW precision, but 1uW
precision makes more sense for internal EAS calculation. I don't
force platforms to report 1uW power, I just want to operate on
it internally. PowerCap and DTPM also operate internally on 1uW,
so it's not that unrealistic that some kernel components want
better resolution.

But as Peter suggested, we might skip 32bit platforms for this issue.
I have to discussed this internally.
