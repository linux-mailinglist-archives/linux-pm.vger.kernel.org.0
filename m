Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2022732F87
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 14:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFCMYd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 08:24:33 -0400
Received: from foss.arm.com ([217.140.101.70]:50090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfFCMYd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Jun 2019 08:24:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A38D115A2;
        Mon,  3 Jun 2019 05:24:32 -0700 (PDT)
Received: from darkstar (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67E793F5AF;
        Mon,  3 Jun 2019 05:24:28 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:24:22 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
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
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v9 12/16] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190603122422.GA19426@darkstar>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
 <20190531153545.GE374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531153545.GE374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-May 08:35, Tejun Heo wrote:
> Hello, Patrick.

Hi Tejun!

> On Wed, May 15, 2019 at 10:44:55AM +0100, Patrick Bellasi wrote:
> > Extend the CPU controller with a couple of new attributes util.{min,max}
> > which allows to enforce utilization boosting and capping for all the
> > tasks in a group. Specifically:
> > 
> > - util.min: defines the minimum utilization which should be considered
> > 	    i.e. the RUNNABLE tasks of this group will run at least at a
> > 		 minimum frequency which corresponds to the util.min
> > 		 utilization
> > 
> > - util.max: defines the maximum utilization which should be considered
> > 	    i.e. the RUNNABLE tasks of this group will run up to a
> > 		 maximum frequency which corresponds to the util.max
> > 		 utilization
> 
> Let's please use a prefix which is more specific.  It's clamping the
> utilization estimates of the member tasks which in turn affect
> scheduling / frequency decisions but cpu.util.max reads like it's
> gonna limit the cpu utilization directly.  Maybe just use uclamp?

Being too specific does not risk to expose implementation details?

If that's not a problem and Peter likes:

   cpu.uclamp.{min,max}

that's ok with me.

-- 
#include <best/regards.h>

Patrick Bellasi
