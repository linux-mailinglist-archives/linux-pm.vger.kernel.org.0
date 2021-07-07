Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5981E3BE650
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 12:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhGGK0g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 06:26:36 -0400
Received: from foss.arm.com ([217.140.110.172]:33810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhGGK0g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 06:26:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D1BB1063;
        Wed,  7 Jul 2021 03:23:56 -0700 (PDT)
Received: from [10.57.1.129] (unknown [10.57.1.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D39F3F694;
        Wed,  7 Jul 2021 03:23:52 -0700 (PDT)
Subject: Re: [PATCH 2/3] PM: EM: Make em_cpu_energy() able to return bigger
 values
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Chris.Redpath@arm.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        segall@google.com, mgorman@suse.de, bristot@redhat.com,
        CCj.Yeh@mediatek.com
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-3-lukasz.luba@arm.com>
 <YOVSu08LpHX5cx/+@hirez.programming.kicks-ass.net>
 <ca9853d1-5ff2-bdac-7581-61bffa3fdaaa@arm.com>
 <YOV7gt67DyYXtBkF@hirez.programming.kicks-ass.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c7603e2f-5830-0731-cc2c-e42d5f6283be@arm.com>
Date:   Wed, 7 Jul 2021 11:23:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YOV7gt67DyYXtBkF@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/7/21 11:01 AM, Peter Zijlstra wrote:
> On Wed, Jul 07, 2021 at 09:09:08AM +0100, Lukasz Luba wrote:
>> For now we would live with this simple code which improves
>> all recent 64bit platforms and is easy to take it into Android
>> common kernel. The next step would be more scattered across
>> other subsystems, so harder to backport to Android 5.4 and others.
> 
> Ah, you *do* only care about 64bit :-) So one option is to only increase
> precision for 64BIT builds, just like we do for scale_load() and
> friends.
> 

Your suggestion is potentially a good compromise :-)
We could leave the 32bit alone and they would have old code and
precision.

Thank you for the comments. Let me discuss this internally with my team.
