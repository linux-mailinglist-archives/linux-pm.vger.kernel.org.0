Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9372F69941
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfGOQmz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 12:42:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:40738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729941AbfGOQmy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jul 2019 12:42:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A306AF7A;
        Mon, 15 Jul 2019 16:42:53 +0000 (UTC)
Date:   Mon, 15 Jul 2019 18:42:49 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v11 4/5] sched/core: uclamp: Use TG's clamps to restrict
 TASK's clamps
Message-ID: <20190715164248.GA21982@blackbody.suse.cz>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-5-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190708084357.12944-5-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 08, 2019 at 09:43:56AM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> This mimics what already happens for a task's CPU affinity mask when the
> task is also in a cpuset, i.e. cgroup attributes are always used to
> restrict per-task attributes.
If I am not mistaken when set_schedaffinity(2) call is made that results
in an empty cpuset, the call fails with EINVAL [1].

If I track the code correctly, the values passed to sched_setattr(2) are
checked against the trivial validity (umin <= umax) and later on, they
are adjusted to match the effective clamping of the containing
task_group. Is that correct?

If the user attempted to sched_setattr [a, b], and the effective uclamp
was [c, d] such that [a, b] ∩ [c, d] = ∅, the set uclamp will be
silently moved out of their intended range. Wouldn't it be better to
return with EINVAL too when the intersection is empty (since the user
supplied range won't be attained)?

Michal

[1] http://www.linux-arm.org/git?p=linux-pb.git;a=blob;f=kernel/sched/core.c;h=ddc5fcd4b9cfaa95496b24d8599c03bc140e768e;hb=2c15043a2a2b5d86eb409556cbe1e36d4fd275b5#l1660

