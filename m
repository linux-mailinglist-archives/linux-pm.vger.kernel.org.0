Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5DB69938
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 18:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbfGOQmH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 12:42:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:40512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730503AbfGOQmG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jul 2019 12:42:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70162AF7A;
        Mon, 15 Jul 2019 16:42:05 +0000 (UTC)
Date:   Mon, 15 Jul 2019 18:42:00 +0200
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
Subject: Re: [PATCH v11 2/5] sched/core: uclamp: Propagate parent clamps
Message-ID: <20190715164200.GA30862@blackbody.suse.cz>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708084357.12944-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 08, 2019 at 09:43:54AM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> Since it's possible for a cpu.uclamp.min value to be bigger than the
> cpu.uclamp.max value, ensure local consistency by restricting each
> "protection"
> (i.e. min utilization) with the corresponding "limit" (i.e. max
> utilization).
I think this constraint should be mentioned in the Documentation/....

> +static void cpu_util_update_eff(struct cgroup_subsys_state *css)
> +{
> +	struct cgroup_subsys_state *top_css = css;
> +	struct uclamp_se *uc_se = NULL;
> +	unsigned int eff[UCLAMP_CNT];
> +	unsigned int clamp_id;
> +	unsigned int clamps;
> +
> +	css_for_each_descendant_pre(css, top_css) {
> +		uc_se = css_tg(css)->parent
> +			? css_tg(css)->parent->uclamp : NULL;
> +
> +		for_each_clamp_id(clamp_id) {
> +			/* Assume effective clamps matches requested clamps */
> +			eff[clamp_id] = css_tg(css)->uclamp_req[clamp_id].value;
> +			/* Cap effective clamps with parent's effective clamps */
> +			if (uc_se &&
> +			    eff[clamp_id] > uc_se[clamp_id].value) {
> +				eff[clamp_id] = uc_se[clamp_id].value;
> +			}
> +		}
> +		/* Ensure protection is always capped by limit */
> +		eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);
> +
> +		/* Propagate most restrictive effective clamps */
> +		clamps = 0x0;
> +		uc_se = css_tg(css)->uclamp;
(Nitpick only, reassigning child where was parent before decreases
readibility. IMO)

> +		for_each_clamp_id(clamp_id) {
> +			if (eff[clamp_id] == uc_se[clamp_id].value)
> +				continue;
> +			uc_se[clamp_id].value = eff[clamp_id];
> +			uc_se[clamp_id].bucket_id = uclamp_bucket_id(eff[clamp_id]);
Shouldn't these writes be synchronized with writes from
__setscheduler_uclamp()?

> 
