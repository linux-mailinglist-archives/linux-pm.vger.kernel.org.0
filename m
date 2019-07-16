Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA8136AE19
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 20:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfGPSAN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 14:00:13 -0400
Received: from foss.arm.com ([217.140.110.172]:38338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPSAN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 14:00:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9DAE344;
        Tue, 16 Jul 2019 11:00:12 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92D923F71A;
        Tue, 16 Jul 2019 11:00:10 -0700 (PDT)
Date:   Tue, 16 Jul 2019 19:00:08 +0100
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
Subject: Re: [PATCH v11 3/5] sched/core: uclamp: Propagate system defaults to
 root group
Message-ID: <20190716180008.duvovlu2u7gxyhmc@e110439-lin>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-4-patrick.bellasi@arm.com>
 <20190715164226.GA30262@blackbody.suse.cz>
 <20190716143417.us3xhksrsaxsl2ok@e110439-lin>
 <20190716153610.GE32540@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190716153610.GE32540@blackbody.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-Jul 17:36, Michal Koutný wrote:
> On Tue, Jul 16, 2019 at 03:34:17PM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > > cpu_util_update_eff internally calls css_for_each_descendant_pre() so
> > > this should be protected with rcu_read_lock().
> > 
> > Right, good catch! Will add in v12.
> When I responded to your other patch, it occurred to me that since
> cpu_util_update_eff goes writing down to child csses, it should take
> also uclamp_mutex here to avoid race with direct cgroup attribute
> writers.

Yep, I should drop the "dedicated" mutex we have now in
sysctl_sched_uclamp_handler() and use the uclamp_mutex we already
have.

Thanks, Patrick


-- 
#include <best/regards.h>

Patrick Bellasi
