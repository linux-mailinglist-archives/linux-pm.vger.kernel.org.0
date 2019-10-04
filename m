Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1FBCB381
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 05:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbfJDDbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 23:31:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:27494 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387463AbfJDDbd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Oct 2019 23:31:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 20:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,254,1566889200"; 
   d="scan'208";a="204174052"
Received: from spandruv-mobl3.jf.intel.com ([10.255.229.152])
  by orsmga002.jf.intel.com with ESMTP; 03 Oct 2019 20:31:31 -0700
Message-ID: <5d6d601d2647644238fc51621407061e1c29320d.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] cpufreq: intel_pstate: Conditional frequency
 invariant accounting
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
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
Date:   Thu, 03 Oct 2019 20:31:30 -0700
In-Reply-To: <13106850.QMtCbivBLn@kreacher>
References: <20191002122926.385-1-ggherdovich@suse.cz>
         <20191002122926.385-3-ggherdovich@suse.cz> <13106850.QMtCbivBLn@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2019-10-03 at 20:05 +0200, Rafael J. Wysocki wrote:
> On Wednesday, October 2, 2019 2:29:26 PM CEST Giovanni Gherdovich
> wrote:
> > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > 
> > intel_pstate has two operating modes: active and passive. In
> > "active"
> > mode, the in-built scaling governor is used and in "passive" mode,
> > the driver can be used with any governor like "schedutil". In
> > "active"
> > mode the utilization values from schedutil is not used and there is
> > a requirement from high performance computing use cases, not to
> > readas well
> > any APERF/MPERF MSRs.
> 
> Well, this isn't quite convincing.
> 
> In particular, I don't see why the "don't read APERF/MPERF MSRs"
> argument
> applies *only* to intel_pstate in the "active" mode.  What about
> intel_pstate
> in the "passive" mode combined with the "performance" governor?  Or
> any other
> governor different from "schedutil" for that matter?
> 
> And what about acpi_cpufreq combined with any governor different from
> "schedutil"?
> 
> Scale invariance is not really needed in all of those cases right now
> AFAICS,
> or is it?
Correct. This is just part of the patch to disable in active mode
(particularly in HWP and performance mode). 

But this patch is 2 years old. The folks who wanted this, disable
intel-pstate and use userspace governor with acpi-cpufreq. So may be
better to address those cases too.

> 
> So is the real concern that intel_pstate in the "active" mode reads
> the MPERF
> and APERF MSRs by itself and that kind of duplicates what the scale
> invariance
> code does and is redundant etc?
It is redundant in non-HWP mode. In HWP and performance (active mode)
we don't use atleast at this time.

Thanks
Srinivas

