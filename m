Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75E36AA47
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 16:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfGPOHM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 10:07:12 -0400
Received: from foss.arm.com ([217.140.110.172]:35434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfGPOHL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 10:07:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 343A6344;
        Tue, 16 Jul 2019 07:07:11 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D33A63F59C;
        Tue, 16 Jul 2019 07:07:08 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:07:06 +0100
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
Subject: Re: [PATCH v11 2/5] sched/core: uclamp: Propagate parent clamps
Message-ID: <20190716140706.vuggfigjlys44lkp@e110439-lin>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-3-patrick.bellasi@arm.com>
 <20190715164200.GA30862@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190715164200.GA30862@blackbody.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Michal,

On 15-Jul 18:42, Michal Koutný wrote:
> On Mon, Jul 08, 2019 at 09:43:54AM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > Since it's possible for a cpu.uclamp.min value to be bigger than the
> > cpu.uclamp.max value, ensure local consistency by restricting each
> > "protection"
> > (i.e. min utilization) with the corresponding "limit" (i.e. max
> > utilization).
> I think this constraint should be mentioned in the Documentation/....

That note comes from the previous review cycle and it's based on a
request from Tejun to align uclamp behaviors with the way the
delegation model is supposed to work.

I guess this part of the documentation:
   https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html?highlight=protections#resource-distribution-models
should already cover the expected uclamp min/max behaviors.

However, I guess "repetita iuvant" in this case. I'll call this out
explicitly in the description of cpu.uclamp.min.

> > +static void cpu_util_update_eff(struct cgroup_subsys_state *css)
> > +{
> > +	struct cgroup_subsys_state *top_css = css;
> > +	struct uclamp_se *uc_se = NULL;
> > +	unsigned int eff[UCLAMP_CNT];
> > +	unsigned int clamp_id;
> > +	unsigned int clamps;
> > +
> > +	css_for_each_descendant_pre(css, top_css) {
> > +		uc_se = css_tg(css)->parent
> > +			? css_tg(css)->parent->uclamp : NULL;
> > +
> > +		for_each_clamp_id(clamp_id) {
> > +			/* Assume effective clamps matches requested clamps */
> > +			eff[clamp_id] = css_tg(css)->uclamp_req[clamp_id].value;
> > +			/* Cap effective clamps with parent's effective clamps */
> > +			if (uc_se &&
> > +			    eff[clamp_id] > uc_se[clamp_id].value) {
> > +				eff[clamp_id] = uc_se[clamp_id].value;
> > +			}
> > +		}
> > +		/* Ensure protection is always capped by limit */
> > +		eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);
> > +
> > +		/* Propagate most restrictive effective clamps */
> > +		clamps = 0x0;
> > +		uc_se = css_tg(css)->uclamp;
> (Nitpick only, reassigning child where was parent before decreases
> readibility. IMO)

Did not checked but I think the compiler will figure out it can still
use a single pointer for both assignments.
I'll let's the compiler to its job and add in a dedicated stack var
for the parent pointer.


> > +		for_each_clamp_id(clamp_id) {
> > +			if (eff[clamp_id] == uc_se[clamp_id].value)
> > +				continue;
> > +			uc_se[clamp_id].value = eff[clamp_id];
> > +			uc_se[clamp_id].bucket_id = uclamp_bucket_id(eff[clamp_id]);
> Shouldn't these writes be synchronized with writes from
> __setscheduler_uclamp()?

You right, the synchronization is introduced by a later patch:

   sched/core: uclamp: Update CPU's refcount on TG's clamp changes

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
