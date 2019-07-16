Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844C46AC5E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388035AbfGPP64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 11:58:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:52420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728121AbfGPP64 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 11:58:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2639DAD05;
        Tue, 16 Jul 2019 15:58:54 +0000 (UTC)
Date:   Tue, 16 Jul 2019 17:58:52 +0200
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
Subject: Re: [PATCH v11 4/5] sched/core: uclamp: Use TG's clamps to restrict
 TASK's clamps
Message-ID: <20190716155852.GF32540@blackbody.suse.cz>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-5-patrick.bellasi@arm.com>
 <20190715164248.GA21982@blackbody.suse.cz>
 <20190716143435.iwwd6fjr3udlqol4@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716143435.iwwd6fjr3udlqol4@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 03:34:35PM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> Am I missing something?
No, it's rather my misinterpretation of the syscall semantics.

> Otherwise, I think the changelog sentence you quoted is just
> misleading.
It certainly mislead me to thinking about the sched_setattr calls as
requests of utilization being in the given interval (substituting 0 or 1 when
only one boundary is given, and further constrained by tg's interval).

I see your point, those are actually two (mostly) independent controls.
Makes sense now.

Thanks,
Michal
