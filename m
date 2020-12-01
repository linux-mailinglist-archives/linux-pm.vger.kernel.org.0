Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2382CA997
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 18:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbgLAR0f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 12:26:35 -0500
Received: from foss.arm.com ([217.140.110.172]:46826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387494AbgLAR0f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Dec 2020 12:26:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F30D8101E;
        Tue,  1 Dec 2020 09:25:49 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51BAA3F575;
        Tue,  1 Dec 2020 09:25:48 -0800 (PST)
References: <cover.1605770951.git.viresh.kumar@linaro.org> <1fa9994395764ba19cfe6240d8b3c1ce390e8f82.1605770951.git.viresh.kumar@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 2/2] thermal: cpufreq_cooling: Reuse sched_cpu_util() for SMP platforms
In-reply-to: <1fa9994395764ba19cfe6240d8b3c1ce390e8f82.1605770951.git.viresh.kumar@linaro.org>
Date:   Tue, 01 Dec 2020 17:25:46 +0000
Message-ID: <jhjzh2xtp45.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Viresh,

On 19/11/20 07:38, Viresh Kumar wrote:
> As can be clearly seen, the load and requested_power numbers are simply
> incorrect in the idle time based approach and the numbers collected from
> CPU's utilization are much closer to the reality.
>

PELT time-scaling can make the util signals behave strangely from an
external PoV. For instance, on a big.LITTLE system, the rq util of a LITTLE
CPU may suddenly drop if it was stuck on a too-low OPP for some time and
eventually reached the "right" OPP (i.e. got idle time). 

Also, as Peter pointed out in [1], task migrations can easily confuse an
external observer that considers util to be "an image of the recent past".

This will need testing on asymmetric CPU capacity systems, IMO.

[1]: https://lore.kernel.org/r/20201120075527.GB2414@hirez.programming.kicks-ass.net

