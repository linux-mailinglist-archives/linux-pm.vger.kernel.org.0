Return-Path: <linux-pm+bounces-22963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512EBA4571A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA15A3A4901
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94683274256;
	Wed, 26 Feb 2025 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUVgzX42"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D027424D;
	Wed, 26 Feb 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556196; cv=none; b=euEPE5KS/QAYyDYEAmjcYppTxOrKa4yx5uGIvBoTNSahbt3XQ0Jvuub/IZKamI/xMibKu1bqHd2GfVbO1iA86tmIaB481Rl5hyyv+gL7hnsjE/PiaS/GzUzYEQPjqr9ZCK/zFcp80N305AYxAKNDib3kmoW8lionqMtTYGzQi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556196; c=relaxed/simple;
	bh=KEYOxg0MUUgNzwwYusMNxICKVX8fUtEKwCLiqVCxxxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agxvLzmQlEdjwzYqB9gPC4ur5AFfYhwHNpm9Jd+DdJdpUh49JXiPDik4Hc22z/8mBTgrGCuHTp8VUdEaKqY/1s19zNkIbFqSI+bcXQgOF1DKxNyxX/Or5amP9HYjb9bmh7lZGvYjdfJO3lTKLsgGekchdqxXVqISVA63ZYgoEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUVgzX42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6905C4CEED;
	Wed, 26 Feb 2025 07:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556195;
	bh=KEYOxg0MUUgNzwwYusMNxICKVX8fUtEKwCLiqVCxxxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUVgzX42/yZVrJrK5jUjseNUDbFm05QnN9TG5dEkzWFNOcKEvXviQaTCRrP9ptQXR
	 77fbBTsDyCJ8U25/yt1uM6iHQgvFmoi9Oefc91e+3gn89wODXvDLU5n3nyXc5vvqKP
	 ZzKbfQ7K8aAsSglWjBMt6kkan8SIdIIoBRhID6W+MGdgpBo4GA/FTO57r7W75WRb0t
	 3SKJPgCtWWb3bM/61X7jhfOGmpw0rrshdL30p1iISGk17iA0BuBslXjXzylKABF3Mr
	 92G2aHJRqJR/UEllzJu9JY6z5deIVY6QJgsHTmBO8xW8Aaxt5Icz8p8w6sxQ6nibx3
	 AGITId6sFdjpg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 10/19] cpufreq/amd-pstate-ut: Run on all of the correct CPUs
Date: Wed, 26 Feb 2025 01:49:25 -0600
Message-ID: <20250226074934.1667721-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226074934.1667721-1-superm1@kernel.org>
References: <20250226074934.1667721-1-superm1@kernel.org>
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
Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Add tag
v3:
 * Only check online CPUs
 * Update commit message
---
 drivers/cpufreq/amd-pstate-ut.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index cd9a472e8dc3c..2ab3017d7a0bb 100644
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


