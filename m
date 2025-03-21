Return-Path: <linux-pm+bounces-24359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1A7A6B2F1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 03:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC03C8A1735
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 02:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361B1E8824;
	Fri, 21 Mar 2025 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec/Nnzv+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9551E8322;
	Fri, 21 Mar 2025 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524160; cv=none; b=Gqew9L1iJmLjYnuckAAYf/ktsntoZ8YKDOxHbWBaIAo2FIGIRn+GcVPlkpOnlDQtO6TAaac79HSg2QUJ9jA6tdsIdj1juyuybGWoWBhsfoOxog7dIIhMZqdwGATycge6ndfEIbA3An5XAVYfVKxtNSuVUlfVBOIcAQW7iwPdkCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524160; c=relaxed/simple;
	bh=BVcJ0JYgYrhqyixr8TfA1naGsxD4kI+oCcHuHjosDDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjxWUQ3HX1+2tw+NtarjWlGUGYrB/+sV8n5E/HfTCQjfK7GYXtfs8YZA03GFm61MvIZmBGfMa29iPE2777GwDhUaz1eHmULtlVrgnOml3aXxQrvh4Phq174kSekf2CHVcTAwdYDgHbAjDswgxM8G70MACwJWq9CQO/EWQNDgb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec/Nnzv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA34C4CEE7;
	Fri, 21 Mar 2025 02:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742524159;
	bh=BVcJ0JYgYrhqyixr8TfA1naGsxD4kI+oCcHuHjosDDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ec/Nnzv+2QiO+9yOr9CLmcbwbjUMZQ0EiUc8D6k2kxag7OpFbMAaz0kQTahfDF/bI
	 8o7S4vx+KQNUDkp3m4bFR+xvi0MOiXbMbX7yamyN/ka2TgH5VPeFZmteFDmaxkRr/+
	 nhSSGL70IVkNvlMt6JTtr0vL8nOJseHbZqwcBlTt5IfcXqOLtxxLk/u8Fem+6tn6k6
	 nBDfolRN/qDdJieirJ61pTC5lsPFN4x8CpCbDop5eTK7qfbxvQKLf08sFECpXwpj9s
	 uScOormXeRV2L0+cgRGlDmfh9PM0csWv7a3bfScr5UQ3lSvQIiaIdE5VyRI2YRCF8W
	 rK0qI19GWe0aA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 4/5] cpufreq/amd-pstate: Add support for raw EPP writes
Date: Thu, 20 Mar 2025 21:28:57 -0500
Message-ID: <20250321022858.1538173-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321022858.1538173-1-superm1@kernel.org>
References: <20250321022858.1538173-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The energy performance preference field of the CPPC request MSR
supports values from 0 to 255, but the strings only offer 4 values.

The other values are useful for tuning the performance of some
workloads.

Add support for writing the raw energy performance preference value
to the sysfs file.  If the last value written was an integer then
an integer will be returned.  If the last value written was a string
then a string will be returned.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 16 +++++++++++-----
 drivers/cpufreq/amd-pstate.c                | 11 +++++++++--
 drivers/cpufreq/amd-pstate.h                |  1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 36950fb6568c0..0e4d2e0aaeff7 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -280,16 +280,22 @@ A list of all the supported EPP preferences that could be used for
 These profiles represent different hints that are provided
 to the low-level firmware about the user's desired energy vs efficiency
 tradeoff.  ``default`` represents the epp value is set by platform
-firmware. This attribute is read-only.
+firmware. ``custom`` designates that integer values 0-255 may be written
+as well.  This attribute is read-only.
 
 ``energy_performance_preference``
 
 The current energy performance preference can be read from this attribute.
 and user can change current preference according to energy or performance needs
-Please get all support profiles list from
-``energy_performance_available_preferences`` attribute, all the profiles are
-integer values defined between 0 to 255 when EPP feature is enabled by platform
-firmware, but if the dynamic EPP feature is enabled, driver will block writes.
+Coarse named profiles are available in the attribute
+``energy_performance_available_preferences``.
+Users can also write individual integer values between 0 to 255.
+When EPP feature is enabled by platform firmware but if the dynamic EPP feature is
+enabled, driver will ignore the written value. Lower epp values shift the bias
+towards improved performance while a higher epp value shifts the bias towards
+power-savings. The exact impact can change from one platform to the other.
+If a valid integer was last written, then a number will be returned on future reads.
+If a valid string was last written then a string will be returned on future reads.
 This attribute is read-write.
 
 ``boost``
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2a62b12148544..b0de50f390e07 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1318,6 +1318,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	struct amd_cpudata *cpudata = policy->driver_data;
 	char str_preference[21];
 	ssize_t ret;
+	bool raw_epp = FALSE;
 	u8 epp;
 
 	if (cpudata->dynamic_epp) {
@@ -1334,6 +1335,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	 * matches an index in the energy_perf_strings array
 	 */
 	ret = kstrtou8(str_preference, 0, &epp);
+	raw_epp = !ret;
 	if (ret) {
 		ret = match_string(energy_perf_strings, -1, str_preference);
 		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
@@ -1353,7 +1355,9 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	return ret ? ret : count;
+	cpudata->raw_epp = raw_epp;
+
+	return count;
 }
 EXPORT_SYMBOL_GPL(store_energy_performance_preference);
 
@@ -1364,6 +1368,9 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 
 	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
+	if (cpudata->raw_epp)
+		return sysfs_emit(buf, "%u\n", epp);
+
 	switch (epp) {
 	case AMD_CPPC_EPP_PERFORMANCE:
 		preference = EPP_INDEX_PERFORMANCE;
@@ -1378,7 +1385,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 		preference = EPP_INDEX_POWERSAVE;
 		break;
 	default:
-		return sysfs_emit(buf, "%u\n", epp);
+		return -EINVAL;
 	}
 
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index b4c5374762110..b6be2b8fbffbf 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -108,6 +108,7 @@ struct amd_cpudata {
 	u8	epp_default_ac;
 	u8	epp_default_dc;
 	bool	dynamic_epp;
+	bool	raw_epp;
 	struct notifier_block power_nb;
 
 	/* platform profile */
-- 
2.43.0


