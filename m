Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA406993B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 18:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfGOQmb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 12:42:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:40600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730503AbfGOQmb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jul 2019 12:42:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56C86AF7A;
        Mon, 15 Jul 2019 16:42:30 +0000 (UTC)
Date:   Mon, 15 Jul 2019 18:42:26 +0200
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
Subject: Re: [PATCH v11 3/5] sched/core: uclamp: Propagate system defaults to
 root group
Message-ID: <20190715164226.GA30262@blackbody.suse.cz>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708084357.12944-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 08, 2019 at 09:43:55AM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> +static void uclamp_update_root_tg(void)
> +{
> +	struct task_group *tg = &root_task_group;
> +
> +	uclamp_se_set(&tg->uclamp_req[UCLAMP_MIN],
> +		      sysctl_sched_uclamp_util_min, false);
> +	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX],
> +		      sysctl_sched_uclamp_util_max, false);
> +
> +	cpu_util_update_eff(&root_task_group.css);
> +}
cpu_util_update_eff internally calls css_for_each_descendant_pre() so
this should be protected with rcu_read_lock().

