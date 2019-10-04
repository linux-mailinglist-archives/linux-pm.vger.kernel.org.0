Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2ACB613
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 10:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfJDIYR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 04:24:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727721AbfJDIYR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Oct 2019 04:24:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 503B9AC8B;
        Fri,  4 Oct 2019 08:24:15 +0000 (UTC)
Message-ID: <1570177786.30086.1.camel@suse.cz>
Subject: Re: [PATCH v2 2/2] cpufreq: intel_pstate: Conditional frequency
 invariant accounting
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Date:   Fri, 04 Oct 2019 10:29:46 +0200
In-Reply-To: <5d6d601d2647644238fc51621407061e1c29320d.camel@linux.intel.com>
References: <20191002122926.385-1-ggherdovich@suse.cz>
         <20191002122926.385-3-ggherdovich@suse.cz> <13106850.QMtCbivBLn@kreacher>
         <5d6d601d2647644238fc51621407061e1c29320d.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2019-10-03 at 20:31 -0700, Srinivas Pandruvada wrote:
> On Thu, 2019-10-03 at 20:05 +0200, Rafael J. Wysocki wrote:
> > On Wednesday, October 2, 2019 2:29:26 PM CEST Giovanni Gherdovich
> > wrote:
> > > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > 
> > > intel_pstate has two operating modes: active and passive. In "active"
> > > mode, the in-built scaling governor is used and in "passive" mode, the
> > > driver can be used with any governor like "schedutil". In "active" mode
> > > the utilization values from schedutil is not used and there is a
> > > requirement from high performance computing use cases, not to readas
> > > well any APERF/MPERF MSRs.
> > 
> > Well, this isn't quite convincing.
> > 
> > In particular, I don't see why the "don't read APERF/MPERF MSRs" argument
> > applies *only* to intel_pstate in the "active" mode.  What about
> > intel_pstate in the "passive" mode combined with the "performance"
> > governor?  Or any other governor different from "schedutil" for that
> > matter?
> > 
> > And what about acpi_cpufreq combined with any governor different from
> > "schedutil"?
> > 
> > Scale invariance is not really needed in all of those cases right now
> > AFAICS, or is it?
> 
> Correct. This is just part of the patch to disable in active mode
> (particularly in HWP and performance mode). 
> 
> But this patch is 2 years old. The folks who wanted this, disable
> intel-pstate and use userspace governor with acpi-cpufreq. So may be
> better to address those cases too.

I disagree with "scale invariance is needed only by the schedutil governor";
the two other users are the CPU's estimated utilization in the wakeup path,
via cpu_util_without(), as well as the load-balance path, via cpu_util() which
is used by update_sg_lb_stats().

Also remember that scale invariance is applied to both PELT signals util_avg
and load_avg; schedutil uses the former but not the latter.

I understand Srinivas patch to disable MSR accesses during the tick as a
band-aid solution to address a specific use case he cares about, but I don't
think that extending this approach to any non-schedutil governor is a good
idea -- you'd be killing load balancing in the process.


Giovanni
