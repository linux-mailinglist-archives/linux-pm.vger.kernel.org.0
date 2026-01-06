Return-Path: <linux-pm+bounces-40260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1616ACF6C21
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 06:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1659E30693E9
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 05:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC52FC02F;
	Tue,  6 Jan 2026 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE48U59R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940152F6918;
	Tue,  6 Jan 2026 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767676515; cv=none; b=VM+/WE5hEDn8ZfAXV+BAslQBzQjcdha1KJ4LFs53UqasGCAFkqMuLA4TsODs8jvDxIXSDutr6RHqdDMgOkv1DLZloeTgAiTG34/Bbrr/Jr5KM+yg1vowevXkEJDSiOK+MPtqkXTWAhClIeMf5K7N0eefJj9bsa+4QJAzFkjqLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767676515; c=relaxed/simple;
	bh=Up228IhCXATNfubrE2DCT/+a50HLpsxmqCVz8EXcOsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSu1gmwPg0RIORC2abO1A/vxYYfU6+c5GuXc62sYjkWpD6wZqdJlEscFEBhrpyEK0cv6gS4AtaLibLrK75//3xIDY/rTKJq3tBnNyAv6vKOBpliOUqTQ8l1F5oUqkHWx5+A7fKsa5CqAGMrphgZogiOGeAW0apubURSAZdl4lvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE48U59R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA04C116C6;
	Tue,  6 Jan 2026 05:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767676515;
	bh=Up228IhCXATNfubrE2DCT/+a50HLpsxmqCVz8EXcOsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oE48U59RIRa2DRTKVuSIl09eEahMt9YR7hnvZQuloR+IQueWzqYwhJNkR4Hy8aftm
	 XdROgKzJcVuJpV/7+lU8A0EB8tSlWYAXL+ZXagKURF6mxKVdW7ztowMlpbpG3PWCMs
	 aTTzQfxx22YewO2w0qzKc8RZoCJ3lLyuFWaaEapKpf823xiPH9l0bzW1QlsEGuYSZT
	 EXAYdvcdH3CSIQpNHhDYZFHC1XtmLXfBnbIHVX7QYQDmxdHRVI8cpBThO1kD37V58+
	 jQ25VTsjYEhk0J/7VWcVUeFkx2HVufTGUdxUwnOlEREBrDx6M0K3Me3GRCSqhHiqzy
	 WfxqAXdDBsozA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 4/5] cpufreq/amd-pstate: Add support for raw EPP writes
Date: Mon,  5 Jan 2026 23:14:40 -0600
Message-ID: <20260106051441.60093-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106051441.60093-1-superm1@kernel.org>
References: <20260106051441.60093-1-superm1@kernel.org>
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
index a6745f2358e61..674e76ff9293e 100644
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
index e1ccbbdd56d42..14347baf3cefb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1333,6 +1333,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	ssize_t ret;
+	bool raw_epp = FALSE;
 	u8 epp;
 
 	if (cpudata->dynamic_epp) {
@@ -1345,6 +1346,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	 * matches an index in the energy_perf_strings array
 	 */
 	ret = kstrtou8(buf, 0, &epp);
+	raw_epp = !ret;
 	if (ret) {
 		ret = sysfs_match_string(energy_perf_strings, buf);
 		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
@@ -1364,7 +1366,9 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	return ret ? ret : count;
+	cpudata->raw_epp = raw_epp;
+
+	return count;
 }
 EXPORT_SYMBOL_GPL(store_energy_performance_preference);
 
@@ -1375,6 +1379,9 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 
 	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
+	if (cpudata->raw_epp)
+		return sysfs_emit(buf, "%u\n", epp);
+
 	switch (epp) {
 	case AMD_CPPC_EPP_PERFORMANCE:
 		preference = EPP_INDEX_PERFORMANCE;
@@ -1389,7 +1396,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 		preference = EPP_INDEX_POWERSAVE;
 		break;
 	default:
-		return sysfs_emit(buf, "%u\n", epp);
+		return -EINVAL;
 	}
 
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 9839c7c6558f4..38b575b8ad959 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -110,6 +110,7 @@ struct amd_cpudata {
 	u8	epp_default_ac;
 	u8	epp_default_dc;
 	bool	dynamic_epp;
+	bool	raw_epp;
 	struct notifier_block power_nb;
 
 	/* platform profile */
-- 
2.43.0


