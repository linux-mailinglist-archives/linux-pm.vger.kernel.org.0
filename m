Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CED524FF81
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHXOGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 10:06:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49264 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXOGh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 10:06:37 -0400
Received: from 89-64-88-199.dynamic.chello.pl (89.64.88.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 8f3c721494c55bb2; Mon, 24 Aug 2020 16:06:34 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Linux PM' <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/4] cpufreq: intel_pstate: Address some HWP-related oddities
Date:   Mon, 24 Aug 2020 16:06:34 +0200
Message-ID: <1987712.ciOYuZiWKh@kreacher>
In-Reply-To: <000401d6781d$c33910d0$49ab3270$@net>
References: <2283366.Lr8yYYnyev@kreacher> <000401d6781d$c33910d0$49ab3270$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Saturday, August 22, 2020 2:47:05 AM CEST Doug Smythies wrote:
> Hi Rafael,
> 
> On 2020.08.20 09:35 Rafael J. Wysocki wrote:
> > 
> > The purpose of this series is to address some peculiarities related to
> > taking CPUs offline/online and switching between different operation
> > modes with HWP enabled that have become visible after allowing the
> > driver to work in the passive mode with HWP enabled in 5.9-rc1 (and
> > one that was there earlier, but can be addressed easily after the
> > changes madein 5.9-rc1).
> > 
> > Please refer to the patch changelogs for details.
> > 
> > For easier testing/review, the series is available from the git branch at:
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  intel_pstate-testing
> 
> Thanks for that.
> 
> There still seems to be a problem with EPP getting messed up.
> I have not been able to find the exact spot in the code.
> 
> One problem is that EPP can end up as 0, and thereafter stays
> at 0. In sysfs terms, it ends up as "performance" and thereafter
> stays as "performance". Meanwhile I never modified it, and it started
> as "balance_performance".
> 
> It happens when changing from active to passive if the governor is performance.
> If the governor is not performance things work as expected.

One change is missing from the patches in the $subject series and IMO it
doesn't belong to any of them, so please find it appended below (on top
of the $subject series).

With it applied, this particular issue should go away.

> Another problem is that EPP will end up as 128 when changing from passive
> to active.

I don't seem to be able to reproduce this (at least not without involving
system-wide suspend/resume).

Cheers!

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Restore cached EPP value during offline

Because hwp_req_cached contains the effective EPP value (0) when the
"performance" scaling algorithm is used in the active mode, replace
it with the cached EPP value during CPU offline to prevent it from
being used (unexpectedly) after switching over from the active mode
to the passive mode.

Also rename intel_pstate_hwp_force_min_perf() because it will do more
than just forcing the minimum performance now.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -904,12 +904,23 @@ skip_epp:
 	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
 
-static void intel_pstate_hwp_force_min_perf(int cpu)
+static void intel_pstate_hwp_offline(int cpu)
 {
-	u64 value;
+	struct cpudata *cpudata = all_cpu_data[cpu];
+	u64 value = READ_ONCE(cpudata->hwp_req_cached);
 	int min_perf;
 
-	value = all_cpu_data[cpu]->hwp_req_cached;
+	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
+		/*
+		 * In case the EPP has been set to "performance" by the
+		 * active mode "performance" scaling algorithm, replace that
+		 * temporary value with the cached EPP one.
+		 */
+		value &= ~GENMASK_ULL(31, 24);
+		value |= HWP_ENERGY_PERF_PREFERENCE(cpudata->epp_cached);
+		WRITE_ONCE(cpudata->hwp_req_cached, value);
+	}
+
 	value &= ~GENMASK_ULL(31, 0);
 	min_perf = HWP_LOWEST_PERF(all_cpu_data[cpu]->hwp_cap_cached);
 
@@ -2312,7 +2323,7 @@ static int intel_pstate_cpu_offline(stru
 	 * performance on CPU offline to prevent that from happening.
 	 */
 	if (hwp_active)
-		intel_pstate_hwp_force_min_perf(policy->cpu);
+		intel_pstate_hwp_offline(policy->cpu);
 	else
 		intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
 



