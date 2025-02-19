Return-Path: <linux-pm+bounces-22501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5B1A3CAD3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD05E177A10
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0A42580D0;
	Wed, 19 Feb 2025 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1GawE7v"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC72580C7;
	Wed, 19 Feb 2025 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999006; cv=none; b=Ify3gmMxoT4qm5DW0Y6ZWEMfrsR0BcMwAVjuqoMZL72c4J+Z0I2OA7rn7ened6zmNJRzOistT/jPLR+LSBJbFJJKon2VNFJt+4yUiUNYvFvrMq7edEFZmY23VZYmjORl+MVrbOzdWlqIvTc1mhILA1OK4L7TYNvaMmzL7MOmmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999006; c=relaxed/simple;
	bh=qoulR5ZpuXYJbCYGjWhsZ3nDirfuGNiyJGe0jvKOh8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqt+Ltjgiw5Eldjn8NmcpSCfrxZPb6fWrelhS/iNnk1WRMpbKX8ErdLk5616c8pnMHS+pjHy+NeYPSPts/GHGnEPhTprmQCK3dJmmF4CCFgN3/TRbk5eBBeAD6AmJN++aLytol6wqQxI/HOvYqChh4YYlNNNjY87qmv4OcRolYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1GawE7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFF5C4CED1;
	Wed, 19 Feb 2025 21:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999006;
	bh=qoulR5ZpuXYJbCYGjWhsZ3nDirfuGNiyJGe0jvKOh8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C1GawE7vpP0LIYrGfXqDVGNYpsF29Urwj4VoK1fVm2yr/uPepSE9C8SlSr75m4wDR
	 T1k7t4+sUe+wQv6kg8DluvsRZcJZBPUARuVC4RdYrBxL13Jq9aEdlyPOQ1Oe17BTiz
	 nBT5J5IDlIIRPVSCNPY3nOtF1JKsVZGL1kdPo2x0XuazK0mNJQbj3SDHm821VVnl11
	 dlPSDS1DDN+TYH0JbToKYKF358IjZufnNnRaR2JwoYwe5KakequNt0nfgr60//kib4
	 uaVCFYtypEsLcxb0w7lBjHttAxW2B1tXKVQfOZVY4YHJh3y7ocSBJb9Ed/Uz6ta6Aj
	 RUtA8ZanXxWwQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 10/19] cpufreq/amd-pstate-ut: Run on all of the correct CPUs
Date: Wed, 19 Feb 2025 15:02:53 -0600
Message-ID: <20250219210302.442954-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219210302.442954-1-superm1@kernel.org>
References: <20250219210302.442954-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

If a CPU is missing a policy or one has been offlined then the unit test
is skipped for the rest of the CPUs on the system.

Instead; iterate online CPUs and skip any missing policies to allow
continuing to test the rest of them.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Only check online CPUs
 * Update commit message
---
 drivers/cpufreq/amd-pstate-ut.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 028527a0019ca..3a541780f374f 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -116,12 +116,12 @@ static int amd_pstate_ut_check_perf(u32 index)
 	struct amd_cpudata *cpudata = NULL;
 	union perf_cached cur_perf;
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
-			break;
+			continue;
 		cpudata = policy->driver_data;
 
 		if (get_shared_mem()) {
@@ -188,12 +188,12 @@ static int amd_pstate_ut_check_freq(u32 index)
 	int cpu = 0;
 	struct amd_cpudata *cpudata = NULL;
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
-			break;
+			continue;
 		cpudata = policy->driver_data;
 
 		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
-- 
2.43.0


