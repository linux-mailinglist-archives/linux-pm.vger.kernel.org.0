Return-Path: <linux-pm+bounces-38076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1474FC5EEC7
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 19:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9533AD150
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805012DF15F;
	Fri, 14 Nov 2025 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPp40Ugh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E862DEA7A;
	Fri, 14 Nov 2025 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146118; cv=none; b=Ndkex4e0e+B2BswaJagLawKqXGdtktsTIVHQyeAirOfe/25ZWAtHgqxTNY9l/Cfem775MqZtznI2+tPDFjZeIv0e1j+s2a90Xa6o36myrcanc2eYdS2sWcvWZQFrXc03pD0VP82VRWvbZ+9s5OdGZEIJ2nQcxYTBYFuUEJP07nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146118; c=relaxed/simple;
	bh=cSvygnB3yc4Q+Fsu1Y/k0FPgOgMfIBN9+zazrIIoF50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fg9rciAtrou09jtxl1S/1YLL6yuiYqKgEe/Puak/vsGDqRUU4BHWOEsVw2Q5ScQwlRXVf/x+b3WICccAd87yno9MCqNblC+xTdACLVHPfjrFrMX/Cc22YcpBo/xiK7WkXrUXP+mOenUvKS2W3/EyPesHyO5NiA1ugGRHDBljm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPp40Ugh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7508C2BCB2;
	Fri, 14 Nov 2025 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763146118;
	bh=cSvygnB3yc4Q+Fsu1Y/k0FPgOgMfIBN9+zazrIIoF50=;
	h=From:To:Cc:Subject:Date:From;
	b=sPp40UghwZYQo9D4U10JPwmpcP8ysfNE7gRkSI11f2kGdnHCcKh3+CLRIvhunnr29
	 UMGZOnVC7iO9w3OQQv9BIB+d5jjLUORv/oURWZy5dWTEEpKsE3ShOJNfOiYgMU07U0
	 7XkrAs8338JRatr8RpAoE4ao5ksCVsSFWjay40c7vJD11wsOaSe2j/7KAikBbgynMC
	 BJ2Cd9J69x/IezmCfwGHN0Xi2rD46xLNLwiwm9RN+SvtUHp1ShVfIlutTR0ovXYRsJ
	 nCLSNApo9ueLBw/pnuKJEze80G7tXc8wy2vXV4/gHjJj4c3Ye8sWkDZGABaR6K/533
	 atdVY3FEg0Asg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] cpufreq: intel_pstate: Eliminate some code duplication
Date: Fri, 14 Nov 2025 19:48:34 +0100
Message-ID: <2829273.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To eliminate some code duplication from the intel_pstate driver,
move the core_get_val() function body to a new function called
get_perf_ctl_val() and make both core_get_val() and atom_get_val()
invoke it to carry out the same computation.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2119,6 +2119,18 @@ static void intel_pstate_hwp_enable(stru
 	intel_pstate_update_epp_defaults(cpudata);
 }
 
+static u64 get_perf_ctl_val(int pstate)
+{
+	u64 val;
+
+	val = (u64)pstate << 8;
+	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled) &&
+	    cpu_feature_enabled(X86_FEATURE_IDA))
+		val |= (u64)1 << 32;
+
+	return val;
+}
+
 static int atom_get_min_pstate(int not_used)
 {
 	u64 value;
@@ -2145,15 +2157,10 @@ static int atom_get_turbo_pstate(int not
 
 static u64 atom_get_val(struct cpudata *cpudata, int pstate)
 {
-	u64 val;
+	u64 val = get_perf_ctl_val(pstate);
 	int32_t vid_fp;
 	u32 vid;
 
-	val = (u64)pstate << 8;
-	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled) &&
-	    cpu_feature_enabled(X86_FEATURE_IDA))
-		val |= (u64)1 << 32;
-
 	vid_fp = cpudata->vid.min + mul_fp(
 		int_tofp(pstate - cpudata->pstate.min_pstate),
 		cpudata->vid.ratio);
@@ -2313,14 +2320,7 @@ static int core_get_turbo_pstate(int cpu
 
 static u64 core_get_val(struct cpudata *cpudata, int pstate)
 {
-	u64 val;
-
-	val = (u64)pstate << 8;
-	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled) &&
-	    cpu_feature_enabled(X86_FEATURE_IDA))
-		val |= (u64)1 << 32;
-
-	return val;
+	return get_perf_ctl_val(pstate);
 }
 
 static int knl_get_aperf_mperf_shift(void)




