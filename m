Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7FC96ABC0
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfGPP3d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 11:29:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728004AbfGPP3d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 11:29:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E0B8AF1D;
        Tue, 16 Jul 2019 15:29:32 +0000 (UTC)
Date:   Tue, 16 Jul 2019 17:29:30 +0200
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
Subject: Re: [PATCH v11 2/5] sched/core: uclamp: Propagate parent clamps
Message-ID: <20190716152929.GD32540@blackbody.suse.cz>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-3-patrick.bellasi@arm.com>
 <20190715164200.GA30862@blackbody.suse.cz>
 <20190716140706.vuggfigjlys44lkp@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716140706.vuggfigjlys44lkp@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 03:07:06PM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> That note comes from the previous review cycle and it's based on a
> request from Tejun to align uclamp behaviors with the way the
> delegation model is supposed to work.
I saw and hopefully understood that reasoning -- uclamp.min has the
protection semantics and uclamp.max the limit semantics.

However, what took me some time to comprehend when the effected
uclamp.min and uclamp.max cross over, i.e. that uclamp.min is then bound
by uclamp.max (besides parent's uclamp.min). Your commit message
explains that and I think it's relevant for the kernel docs file
itself.

> You right, the synchronization is introduced by a later patch:
> 
>    sched/core: uclamp: Update CPU's refcount on TG's clamp changes
I saw that lock but didn't realize __setscheduler_uclamp() touches only
task's struct uclamp_se, none of task_group's/css's (which is under
uclamp_mutex). That seems correct.

