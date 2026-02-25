Return-Path: <linux-pm+bounces-43180-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vinuNrg/nmlXUQQAu9opvQ
	(envelope-from <linux-pm+bounces-43180-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 01:18:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE44E18E586
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 01:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 975B3306C13A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9548F1EFFB7;
	Wed, 25 Feb 2026 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8JTrHNA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B59F381AF;
	Wed, 25 Feb 2026 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978675; cv=none; b=Ie/PWdOJUYrSWxJuHYG+2x8fLoBEw3cMOBgCHs7HbRWgkT9zCtnT+r3m5aQbSfCwUBkU9z3UabDhGMi1addUeZl68nntQJlMm5ifTBE6ALudXHMKxKwSyakhRSZbVMFEYHuZP+xP6gNMEIt8tTMveRXnFBFhC7P2QQQW35zzAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978675; c=relaxed/simple;
	bh=gJSYwWNrpcUuy0nEPHIdqhjVPHZ0ifj371xTSfdjVWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGlGqIEDo9Ra0egXkZA85VKaxQexOn77hJikoLO2S8EnQGWsPMvO28R+lMFDw16m2iJqKAxkkY3QJ1JHd0o29ivNizc/oCa6lLddi67Oaxd7zCYTgJjWz1/o2SwiUynLOqJayEoWd9Ta/M4jm3rlqldRK1QvPNLezHG6ItoCCrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8JTrHNA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771978675; x=1803514675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gJSYwWNrpcUuy0nEPHIdqhjVPHZ0ifj371xTSfdjVWw=;
  b=R8JTrHNAgcAnEgzoi3+ngV7dVryLZjbj5eqz2U43Y+NuacG7562N/y4u
   oFEHnu/TAl1sJJXK8FFRbtg5Wt0R7nhz3tNTpd3amFq7+4AKFliHSMTYv
   8uoRxzVX4Wl065Pn3JLrJYSJeQlYVqwSUPF55FMlaU/tLR/y60Gh5Z+JS
   ly1ynmuWqVCC2VzzLgTT0DVnTP1ZQFgnS24GQcgILGYGwJQOe5DFvjHGg
   pYNmdzjWkBjz00bPkLI79MStgYcOWrv+2+F9Ye9jUrl3To4nSoOavomDi
   I1g0Dh/EZ6HsUIuCMpaRV9xoqZCdQlL9lH1UoLIUdgRpev42ONuQ/i4Xl
   g==;
X-CSE-ConnectionGUID: SqAeZHH+TdqaN17nHIqCGg==
X-CSE-MsgGUID: GK+YVUtBStScf8oo1o4pkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72912752"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="72912752"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 16:17:54 -0800
X-CSE-ConnectionGUID: ZuN7BQKlRfeJZFrXvtOh1Q==
X-CSE-MsgGUID: J38oYL4URaejf6NTwyLL3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="220668188"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 16:17:53 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: Fix crash during turbo disable
Date: Tue, 24 Feb 2026 16:17:52 -0800
Message-ID: <20260225001752.890164-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43180-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: EE44E18E586
X-Rspamd-Action: no action

When the system is booted with kernel command line argument "nosmt" or
"maxcpus" to limit the number of CPUs, disabling turbo via:
echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
results in a crash:
PF: supervisor read access in kernel mode
PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP PTI
...
RIP: 0010:store_no_turbo+0x100/0x1f0
 ...

This occurs because for_each_possible_cpu() returns CPUs even if they are
not online. For those CPUs, all_cpu_data[] will be NULL. Since
commit 973207ae3d7c ("cpufreq: intel_pstate: Rearrange max frequency
updates handling code"), all_cpu_data[] is dereferenced even for CPUs
which are not online, causing the NULL pointer dereference.

To fix that pass CPU number to intel_pstate_update_max_freq() and use
all_cpu_data[] for those CPUs for which there is a valid cpufreq policy.

Fixes: 973207ae3d7c ("cpufreq: intel_pstate: Rearrange max frequency updates handling code")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221068
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: <stable@vger.kernel.org> # 6.16+
---
 drivers/cpufreq/intel_pstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a48af3540c74..3ecfa921f9b9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1476,13 +1476,13 @@ static void __intel_pstate_update_max_freq(struct cpufreq_policy *policy,
 	refresh_frequency_limits(policy);
 }
 
-static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
+static bool intel_pstate_update_max_freq(int cpu)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return false;
 
-	__intel_pstate_update_max_freq(policy, cpudata);
+	__intel_pstate_update_max_freq(policy, all_cpu_data[cpu]);
 
 	return true;
 }
@@ -1501,7 +1501,7 @@ static void intel_pstate_update_limits_for_all(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		intel_pstate_update_max_freq(all_cpu_data[cpu]);
+		intel_pstate_update_max_freq(cpu);
 
 	mutex_lock(&hybrid_capacity_lock);
 
@@ -1908,7 +1908,7 @@ static void intel_pstate_notify_work(struct work_struct *work)
 	struct cpudata *cpudata =
 		container_of(to_delayed_work(work), struct cpudata, hwp_notify_work);
 
-	if (intel_pstate_update_max_freq(cpudata)) {
+	if (intel_pstate_update_max_freq(cpudata->cpu)) {
 		/*
 		 * The driver will not be unregistered while this function is
 		 * running, so update the capacity without acquiring the driver
-- 
2.52.0


