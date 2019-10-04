Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACEC2CBEDB
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389390AbfJDPRQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 11:17:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:59001 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389165AbfJDPRP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Oct 2019 11:17:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 08:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="205878569"
Received: from spandruv-mobl3.jf.intel.com ([10.255.229.152])
  by fmsmga001.fm.intel.com with ESMTP; 04 Oct 2019 08:17:12 -0700
Message-ID: <56f1e864ed93d45e6328d4d015cfda6406fdda42.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] cpufreq: intel_pstate: Conditional frequency
 invariant accounting
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Date:   Fri, 04 Oct 2019 08:17:11 -0700
In-Reply-To: <1570179472.30086.4.camel@suse.cz>
References: <20191002122926.385-1-ggherdovich@suse.cz>
         <20191002122926.385-3-ggherdovich@suse.cz> <13106850.QMtCbivBLn@kreacher>
         <5d6d601d2647644238fc51621407061e1c29320d.camel@linux.intel.com>
         <1570177786.30086.1.camel@suse.cz>
         <CAJZ5v0jK1kMjQ3gu8KhQmp2Paq9Rb74NPjMQ1HsVRCD3Fct5TQ@mail.gmail.com>
         <1570179472.30086.4.camel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2019-10-04 at 10:57 +0200, Giovanni Gherdovich wrote:
> On Fri, 2019-10-04 at 10:29 +0200, Rafael J. Wysocki wrote:
> > On Fri, Oct 4, 2019 at 10:24 AM Giovanni Gherdovich <
> > ggherdovich@suse.cz> wrote:
> > > 
> > > On Thu, 2019-10-03 at 20:31 -0700, Srinivas Pandruvada wrote:
> > > > On Thu, 2019-10-03 at 20:05 +0200, Rafael J. Wysocki wrote:
> > > > > On Wednesday, October 2, 2019 2:29:26 PM CEST Giovanni
> > > > > Gherdovich
> > > > > wrote:
> > > > > > From: Srinivas Pandruvada <
> > > > > > srinivas.pandruvada@linux.intel.com>
> > > > > > 
> > > > > > intel_pstate has two operating modes: active and passive.
> > > > > > In "active"
> > > > > > mode, the in-built scaling governor is used and in
> > > > > > "passive" mode, the
> > > > > > driver can be used with any governor like "schedutil". In
> > > > > > "active" mode
> > > > > > the utilization values from schedutil is not used and there
> > > > > > is a
> > > > > > requirement from high performance computing use cases, not
> > > > > > to readas
> > > > > > well any APERF/MPERF MSRs.
> > > > > 
> > > > > Well, this isn't quite convincing.
> > > > > 
> > > > > In particular, I don't see why the "don't read APERF/MPERF
> > > > > MSRs" argument
> > > > > applies *only* to intel_pstate in the "active" mode.  What
> > > > > about
> > > > > intel_pstate in the "passive" mode combined with the
> > > > > "performance"
> > > > > governor?  Or any other governor different from "schedutil"
> > > > > for that
> > > > > matter?
> > > > > 
> > > > > And what about acpi_cpufreq combined with any governor
> > > > > different from
> > > > > "schedutil"?
> > > > > 
> > > > > Scale invariance is not really needed in all of those cases
> > > > > right now
> > > > > AFAICS, or is it?
> > > > 
> > > > Correct. This is just part of the patch to disable in active
> > > > mode
> > > > (particularly in HWP and performance mode).
> > > > 
> > > > But this patch is 2 years old. The folks who wanted this,
> > > > disable
> > > > intel-pstate and use userspace governor with acpi-cpufreq. So
> > > > may be
> > > > better to address those cases too.
> > > 
> > > I disagree with "scale invariance is needed only by the schedutil
> > > governor";
> > > the two other users are the CPU's estimated utilization in the
> > > wakeup path,
> > > via cpu_util_without(), as well as the load-balance path, via
> > > cpu_util() which
> > > is used by update_sg_lb_stats().
> > 
> > OK, so there are reasons to run the scale invariance code which are
> > not related to the cpufreq governor in use.
> > 
> > I wonder then why those reasons are not relevant for intel_pstate
> > in
> > the "active" mode.
> > 
> > > Also remember that scale invariance is applied to both PELT
> > > signals util_avg
> > > and load_avg; schedutil uses the former but not the latter.
> > > 
> > > I understand Srinivas patch to disable MSR accesses during the
> > > tick as a
> > > band-aid solution to address a specific use case he cares about,
> > > but I don't
> > > think that extending this approach to any non-schedutil governor
> > > is a good
> > > idea -- you'd be killing load balancing in the process.
> > 
> > But that is also the case for intel_pstate in the "active" mode,
> > isn't it?
> 
> Sure it is.
> 
> Now, what's the performance impact of loosing scale-invariance in
> PELT signals?
> And what's the performance impact of accessing two MSRs at the
> scheduler tick
> on each CPU?
> 
> I am sporting Srinivas' patch because he expressed the concern that
> the losses
> don't justify the gains for a specific class of users
> (supercomputing),
> although I don't fully like the idea (and arguably that should be
> measured).
> 
I understand there are other impact of the scale invariance like in
deadline code, which I didn't see when I submitted this patch.
You can drop this patch at this time if you like. I can poke HPC folks
to test a released kernel.

Thanks,
Srinivas


