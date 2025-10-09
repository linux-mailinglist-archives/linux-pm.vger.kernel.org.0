Return-Path: <linux-pm+bounces-35868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B16BCA294
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C35F4FD48B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E85221265;
	Thu,  9 Oct 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsoOXKMk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB8221FF21;
	Thu,  9 Oct 2025 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026686; cv=none; b=JIfGVT4ce0Abx4fruy2KfPmqo7+O+2iS9R0e8++5DqP9Qs78cDCNKiJz/O5SIeBqMpa3CIqu0NpAEKZpjgH//fcx5wSu30sORsctgv+bcAp1n8Kbe9PmUBALJkMakxdqju2sb5cu8YRlZIJwI1OjCpExXk7UoBnrx0WPpL5s5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026686; c=relaxed/simple;
	bh=HSSJ1Qaqpo27FTDdPNyDDR5M+Wsq3o8Vh0hTZZ48Oxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMzzRHY+PCfS8WzxE08JoykkPeFR6gshbHQoeuumtzqQt8GJydVYmZULUqi+kX7EU5gCPuTHKNLlLi1kwJQjiQo2ZXWEYPp9BcwypetsOIHh6IJsvDgJLi7p6pPKq5WexaW6a2bPaHcw9mMPRpkoniKME8i3lI5IPPMTd3aIDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsoOXKMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6229C4CEF7;
	Thu,  9 Oct 2025 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760026685;
	bh=HSSJ1Qaqpo27FTDdPNyDDR5M+Wsq3o8Vh0hTZZ48Oxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsoOXKMk9v7ikFwDTnUPclRi8KyIfAK0Ub/8NLTf5/Lwbil9D5AA3AMTELwYnY53O
	 F6R0/hUq43Ai+7rE9emBNVLwmxT7EysuQVfxttldmBRrDDxBDmh0TCkSVDEW6S60dY
	 ZsW/MgyrpWTTnnq4JQkiL4S9n/6jxtLbKJYoLBbMByzTvVUmGH2xZGdz53avu/IHmP
	 iqkD1qTSWSr+umHnIfhPx9+zCpESWkDDwXx0z7SWAYdBHUBZEP8bWpKf+4uTBYnx/1
	 7aW/8tekkkzNtBkKmoHUvQuV/Zopoc9QWBGg6d/i58gskf4G3/H5Nd0irefuhDrked
	 0qAD/dseKBDag==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 1/6] cpufreq/amd-pstate: Use sysfs_match_string() for epp
Date: Thu,  9 Oct 2025 11:17:51 -0500
Message-ID: <20251009161756.2728199-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009161756.2728199-1-superm1@kernel.org>
References: <20251009161756.2728199-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than scanning the buffer and manually matching the string
use the sysfs macros.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * Drop NULL from energy_perf_strings too (Gautham)
---
 drivers/cpufreq/amd-pstate.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b44f0f7a5ba1c..0bc5013448873 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -118,7 +118,6 @@ static const char * const energy_perf_strings[] = {
 	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
 	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
 	[EPP_INDEX_POWERSAVE] = "power",
-	NULL
 };
 
 static unsigned int epp_values[] = {
@@ -1137,16 +1136,15 @@ static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
 static ssize_t show_energy_performance_available_preferences(
 				struct cpufreq_policy *policy, char *buf)
 {
-	int i = 0;
-	int offset = 0;
+	int offset = 0, i;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		return sysfs_emit_at(buf, offset, "%s\n",
 				energy_perf_strings[EPP_INDEX_PERFORMANCE]);
 
-	while (energy_perf_strings[i] != NULL)
-		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
+	for (i = 0; i < ARRAY_SIZE(energy_perf_strings); i++)
+		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i]);
 
 	offset += sysfs_emit_at(buf, offset, "\n");
 
@@ -1157,15 +1155,10 @@ static ssize_t store_energy_performance_preference(
 		struct cpufreq_policy *policy, const char *buf, size_t count)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	char str_preference[21];
 	ssize_t ret;
 	u8 epp;
 
-	ret = sscanf(buf, "%20s", str_preference);
-	if (ret != 1)
-		return -EINVAL;
-
-	ret = match_string(energy_perf_strings, -1, str_preference);
+	ret = sysfs_match_string(energy_perf_strings, buf);
 	if (ret < 0)
 		return -EINVAL;
 
-- 
2.43.0


