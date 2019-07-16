Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A66AAA5
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 16:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfGPOeW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 10:34:22 -0400
Received: from foss.arm.com ([217.140.110.172]:35768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfGPOeW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 10:34:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4EA8337;
        Tue, 16 Jul 2019 07:34:21 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E4163F59C;
        Tue, 16 Jul 2019 07:34:19 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:34:17 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
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
Subject: Re: [PATCH v11 3/5] sched/core: uclamp: Propagate system defaults to
 root group
Message-ID: <20190716143417.us3xhksrsaxsl2ok@e110439-lin>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-4-patrick.bellasi@arm.com>
 <20190715164226.GA30262@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190715164226.GA30262@blackbody.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-Jul 18:42, Michal Koutný wrote:
> On Mon, Jul 08, 2019 at 09:43:55AM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > +static void uclamp_update_root_tg(void)
> > +{
> > +	struct task_group *tg = &root_task_group;
> > +
> > +	uclamp_se_set(&tg->uclamp_req[UCLAMP_MIN],
> > +		      sysctl_sched_uclamp_util_min, false);
> > +	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX],
> > +		      sysctl_sched_uclamp_util_max, false);
> > +
> > +	cpu_util_update_eff(&root_task_group.css);
> > +}
> cpu_util_update_eff internally calls css_for_each_descendant_pre() so
> this should be protected with rcu_read_lock().

Right, good catch! Will add in v12.

Cheers,
Patrick


-- 
#include <best/regards.h>

Patrick Bellasi
