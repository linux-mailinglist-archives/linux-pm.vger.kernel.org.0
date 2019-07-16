Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98726ABE0
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 17:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfGPPgN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 16 Jul 2019 11:36:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:46480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbfGPPgN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 11:36:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55CEEAF1E;
        Tue, 16 Jul 2019 15:36:12 +0000 (UTC)
Date:   Tue, 16 Jul 2019 17:36:10 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20190716153610.GE32540@blackbody.suse.cz>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-4-patrick.bellasi@arm.com>
 <20190715164226.GA30262@blackbody.suse.cz>
 <20190716143417.us3xhksrsaxsl2ok@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190716143417.us3xhksrsaxsl2ok@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 03:34:17PM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > cpu_util_update_eff internally calls css_for_each_descendant_pre() so
> > this should be protected with rcu_read_lock().
> 
> Right, good catch! Will add in v12.
When I responded to your other patch, it occurred to me that since
cpu_util_update_eff goes writing down to child csses, it should take
also uclamp_mutex here to avoid race with direct cgroup attribute
writers.
