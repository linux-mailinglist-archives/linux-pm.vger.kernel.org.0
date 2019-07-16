Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 172896AE10
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 19:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfGPRzr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 13:55:47 -0400
Received: from foss.arm.com ([217.140.110.172]:38298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfGPRzr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 13:55:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDE032B;
        Tue, 16 Jul 2019 10:55:45 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994253F71A;
        Tue, 16 Jul 2019 10:55:43 -0700 (PDT)
Date:   Tue, 16 Jul 2019 18:55:42 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Paul Turner <pjt@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 2/5] sched/core: uclamp: Propagate parent clamps
Message-ID: <20190716175542.p7vs2muslyuez6lq@e110439-lin>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-3-patrick.bellasi@arm.com>
 <20190715164200.GA30862@blackbody.suse.cz>
 <20190716140706.vuggfigjlys44lkp@e110439-lin>
 <20190716152929.GD32540@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190716152929.GD32540@blackbody.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-Jul 17:29, Michal Koutný wrote:
> On Tue, Jul 16, 2019 at 03:07:06PM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > That note comes from the previous review cycle and it's based on a
> > request from Tejun to align uclamp behaviors with the way the
> > delegation model is supposed to work.
> I saw and hopefully understood that reasoning -- uclamp.min has the
> protection semantics and uclamp.max the limit semantics.
> 
> However, what took me some time to comprehend when the effected
> uclamp.min and uclamp.max cross over, i.e. that uclamp.min is then bound
> by uclamp.max (besides parent's uclamp.min). Your commit message
> explains that and I think it's relevant for the kernel docs file
> itself.

Right, I've just added a paragraph to the cpu.uclamp.min documentation.

> > You right, the synchronization is introduced by a later patch:
> > 
> >    sched/core: uclamp: Update CPU's refcount on TG's clamp changes
> I saw that lock but didn't realize __setscheduler_uclamp() touches only
> task's struct uclamp_se, none of task_group's/css's (which is under
> uclamp_mutex). That seems correct.

Right, the mutex is used only on the cgroup side. That's because the
CGroup API can affect multiple tasks running on different CPUs, thus
we wanna make sure we don't come up with race conditions. In that
path we can also afford to go a bit slower.

In the fast path instead we rely on the rq-locks to ensure
serialization on RUNNABLE tasks clamp updates.

Coming from the __setscheduler_uclamp() side however we don't sync
RUNNABLE tasks immediately. We delay the update to next enqueue
opportunity.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
