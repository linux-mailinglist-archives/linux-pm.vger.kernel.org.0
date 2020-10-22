Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FAF295E41
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503645AbgJVMWB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 08:22:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:41022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503608AbgJVMWB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 08:22:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5429AEFE;
        Thu, 22 Oct 2020 12:21:59 +0000 (UTC)
Message-ID: <1603369318.3162.21.camel@suse.cz>
Subject: Re: [PATCH v2 1/3] x86, sched: check for counters overflow in
 frequency invariant accounting
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date:   Thu, 22 Oct 2020 14:21:58 +0200
In-Reply-To: <20201022084618.GU2628@hirez.programming.kicks-ass.net>
References: <20200531182453.15254-1-ggherdovich@suse.cz>
         <20200531182453.15254-2-ggherdovich@suse.cz>
         <20201022084618.GU2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-10-22 at 10:46 +0200, Peter Zijlstra wrote:
> On Sun, May 31, 2020 at 08:24:51PM +0200, Giovanni Gherdovich wrote:
> 
> Hi Giovanni!
> 
> > +error:
> > +	pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
> > +	schedule_work(&disable_freq_invariance_work);
> > +}
> 
> I'm getting reports that we trigger this on resume. Would it make sense
> to hook into tsc_{save,restore}_sched_clock_state() (or somewhere near
> there) to reset the state (basically call init_counter_refs() again to
> ensure we're not having to deal with crazy ?

Hello,

right, if the counters keep running while the machine is suspended then the
current code thinks it's a runtime overflow. I'll prepare a patch to fix that,
thanks for the heads-up and the hint.


Giovanni
