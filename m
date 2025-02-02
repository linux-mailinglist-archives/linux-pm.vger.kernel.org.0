Return-Path: <linux-pm+bounces-21246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9906FA24F2D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12ED8162F17
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFEA1FBC91;
	Sun,  2 Feb 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvqRnfV3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71C1FBC83
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516410; cv=none; b=OLn2u+0TsYveTle7fmGWpADhVOJaR2yeaAkDozjgtFPaw2TErgftp9l97y/IPywVWiRt0C39CmRYoPyFpJwQMCUMzBgtFHxW85ELUBfxx5uO/UAPSc+urYXYklVP4b8+twy+J/SFZIDCSUOIhE1AIjlsm+1HTtBbnJzy2OTylZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516410; c=relaxed/simple;
	bh=SZkNjPY0jaCu7dScCcBFarX5Jns6URGV09FAWZnPqY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLP7i9PjomBbiuPtsadpwMTAtEVnOUj0HGIhmlw6PVg2qR6CrVzlDzufcildJ/VknwkxsXJQD1JiFxMUH7o6Z2K5dzHOl87qH1fXKyV1wTmkBtnTNqWmzP4JPaQG74VIcLytqbh58tl0hFhLpGBKTSHLoKtAS6nZG9lVKBGzo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvqRnfV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C36C4CEE0;
	Sun,  2 Feb 2025 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516409;
	bh=SZkNjPY0jaCu7dScCcBFarX5Jns6URGV09FAWZnPqY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=ZvqRnfV3vsqcl1k2KofxF3HD73qbsWqdwvOSw/qikI8rnDPnA5uHyHofwm/9yybPE
	 Ue8VZ1YjP0A0/YjJCgBH5dyRgE3C6UAwwt3OOtZVxc0bH0L9BDEk15ab4k4IWKiyrr
	 7B6qwCWuA5WN7vQjuFVVfJ/aGdBfXu0rD56Y2/E1hRx1boOzbYvGx6oelVamEzE8uN
	 Muld06qJAU7lpZDyeLJ/iNVSiY2VZJbuA5woinvx6gt2vZ579SfA5HmsGhdQUAkurL
	 mxWkJoW9ohjnwqIGY+ZdOl0mn/qnPlCU8umCNLrekcQad4vBw1vUm567qMkYyIiSfb
	 ZPZ3qOlJ8ooSA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 23/25] tools/power turbostat: Harden one-shot mode against cpu offline
Date: Sun,  2 Feb 2025 11:09:39 -0600
Message-ID: <5499b5ac0b2c661cc37190a23a4aee9308b3d3ee.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

when turbostat interval mode can't migrate to a CPU, it complains,
prints no data, re-initializes with the new CPU configuration
and starts a new interval.

But this strategy in the face of a CPU hotplug offline during an interval
doesn't help in one-shot mode.  When the missing CPU is discovered
at the end of the interval, the forked program has already returned
and there is nothing left for a new interval to measure.

So instead of aborting get_coutners() and delta_cpu() if a missing CPU
is detected, complain, but carry on and output what statistics are
actually present.

Use the same strategy for delta_cpu when aperf:mperf are observed
to have been reset -- complain, but carry on and print data for
the CPUs that are still present.

Interval mode error handling is unchanged.

One-shot mode can now do this:

$ sudo chcpu -e 1 ; sudo ./turbostat --quiet --show PkgWatt,Busy%,CPU chcpu -d 1
CPU 1 enabled
CPU 1 disabled
get_counters: Could not migrate to CPU 1
./turbostat: Counter reset detected
0.036920 sec
CPU	Busy%	PkgWatt
-	0.00	10.00
0	99.73	10.00
1	0.00
2	91.53
3	16.83

Suggested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1f188a0908da..8df08819e7b4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2063,6 +2063,8 @@ int for_all_cpus(int (func) (struct thread_data *, struct core_data *, struct pk
 {
 	int retval, pkg_no, core_no, thread_no, node_no;
 
+	retval = 0;
+
 	for (pkg_no = 0; pkg_no < topo.num_packages; ++pkg_no) {
 		for (node_no = 0; node_no < topo.nodes_per_pkg; node_no++) {
 			for (core_no = 0; core_no < topo.cores_per_node; ++core_no) {
@@ -2078,14 +2080,12 @@ int for_all_cpus(int (func) (struct thread_data *, struct core_data *, struct pk
 					c = GET_CORE(core_base, core_no, node_no, pkg_no);
 					p = GET_PKG(pkg_base, pkg_no);
 
-					retval = func(t, c, p);
-					if (retval)
-						return retval;
+					retval |= func(t, c, p);
 				}
 			}
 		}
 	}
-	return 0;
+	return retval;
 }
 
 int is_cpu_first_thread_in_core(struct thread_data *t, struct core_data *c, struct pkg_data *p)
@@ -3620,12 +3620,10 @@ int delta_cpu(struct thread_data *t, struct core_data *c,
 
 	/* always calculate thread delta */
 	retval = delta_thread(t, t2, c2);	/* c2 is core delta */
-	if (retval)
-		return retval;
 
 	/* calculate package delta only for 1st core in package */
 	if (is_cpu_first_core_in_package(t, c, p))
-		retval = delta_package(p, p2);
+		retval |= delta_package(p, p2);
 
 	return retval;
 }
@@ -5748,6 +5746,8 @@ int for_all_cpus_2(int (func) (struct thread_data *, struct core_data *,
 {
 	int retval, pkg_no, node_no, core_no, thread_no;
 
+	retval = 0;
+
 	for (pkg_no = 0; pkg_no < topo.num_packages; ++pkg_no) {
 		for (node_no = 0; node_no < topo.nodes_per_pkg; ++node_no) {
 			for (core_no = 0; core_no < topo.cores_per_node; ++core_no) {
@@ -5769,14 +5769,12 @@ int for_all_cpus_2(int (func) (struct thread_data *, struct core_data *,
 					p = GET_PKG(pkg_base, pkg_no);
 					p2 = GET_PKG(pkg_base2, pkg_no);
 
-					retval = func(t, c, p, t2, c2, p2);
-					if (retval)
-						return retval;
+					retval |= func(t, c, p, t2, c2, p2);
 				}
 			}
 		}
 	}
-	return 0;
+	return retval;
 }
 
 /*
@@ -9462,10 +9460,9 @@ int fork_it(char **argv)
 	timersub(&tv_odd, &tv_even, &tv_delta);
 	if (for_all_cpus_2(delta_cpu, ODD_COUNTERS, EVEN_COUNTERS))
 		fprintf(outf, "%s: Counter reset detected\n", progname);
-	else {
-		compute_average(EVEN_COUNTERS);
-		format_all_counters(EVEN_COUNTERS);
-	}
+
+	compute_average(EVEN_COUNTERS);
+	format_all_counters(EVEN_COUNTERS);
 
 	fprintf(outf, "%.6f sec\n", tv_delta.tv_sec + tv_delta.tv_usec / 1000000.0);
 
-- 
2.43.0


