Return-Path: <linux-pm+bounces-22273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70338A38ED6
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816D93B4DE9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041AD1BCA07;
	Mon, 17 Feb 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9JcgW5F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E31BBBD3;
	Mon, 17 Feb 2025 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830063; cv=none; b=kZuZtVPvYW7Jfq3u6FyUIY8hK/PYpfqOd32h+3u6rojrTDpCekcM0qZNlJrlcMY/n97EfmtkYIc55WO/Y8C18Lkqrm4ivji2f14H1uE302mygds4ZrAU8e4DrTERAIL0e/KPnUHwNO2gTEUd/QD5mbIldonmPIgVzKUt4/QkPOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830063; c=relaxed/simple;
	bh=w2ei7dAroLC14G4mlW/yqVmr6ZqUeR1xKhW7ZCS136U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSn/Xd2JX/G4qO8N83g6+94o3RTFe7zxP0FBOFR/T6pGX9HiQ79L8vB3tbzWrfYDh6lK+zSnzCUtkmLPqqbUyElnpO9sQOFQEK48HxCEG8Yk1z6OIx6eMEz8RX41RjBua6MrUf1/v0ZoqjeHsHpC/t+Gxt3WxWAy3o7TKqTh8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9JcgW5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BBEC4CEE8;
	Mon, 17 Feb 2025 22:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830063;
	bh=w2ei7dAroLC14G4mlW/yqVmr6ZqUeR1xKhW7ZCS136U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9JcgW5FEIMIfKcjt4mLLZFhgD3PgSRnubX+PWJzdqvbX7vJNMUKVXvvYZJeQsZpM
	 D+fRa3wWU13RbB7hmpOVtvENeWXSbBIL+HE9ZCS4KwcVLIb1gQk7BLJU6n0cU2MaU2
	 jPrwrOAYERFqrCdkc5opERlGWAyulkErbsuWovu/KyoID+lO5v+YOMNojngr5Nf6oR
	 uvT6vOhjFT9cK/Yhn8rxp5oLSADn9wiL5SKe+X3lhyWjCZRnz1mpqP76uWw0hY7Xq/
	 F5Qyy0OPrYlez0Y5PrPQwCgCnrh0urfNEfB28rF+FXO+pwEph5lgxlDCFtIcgyv35w
	 eyxMQv4WSSp9w==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 10/18] cpufreq/amd-pstate-ut: Run on all of the correct CPUs
Date: Mon, 17 Feb 2025 16:06:59 -0600
Message-ID: <20250217220707.1468365-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217220707.1468365-1-superm1@kernel.org>
References: <20250217220707.1468365-1-superm1@kernel.org>
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


