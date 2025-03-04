Return-Path: <linux-pm+bounces-23407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C6A4E447
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA568A4C28
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D596B284B24;
	Tue,  4 Mar 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxyBetpH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7ED283CBA;
	Tue,  4 Mar 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101817; cv=none; b=GPvjwd8rkZRVkBrPAjD8I9noVMGGGefiq9sqRV7h+M+fUh8EhYYNvx0zNwuyeYQLvyh77M/bL86+SEAZeqNKx0xhm6opK1FZIrII7L1uHVtwJHgoJDEJAa5UVYpxhd/+1Dc1x9AY1f897yUt1FzZ8RS/bgr4D5cBw5ILnWr9iTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101817; c=relaxed/simple;
	bh=VymNDH1jT+gpaLwW2gldk72PJ+nc5piVYY5i4ZwV7dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e82OytTxKbYbwuVjELiGauhfC/LCncC/VD0jHIiR7PvpeWhg2qwqHYt2ed5k0ubSdadbBLtI4sW0aR+wTIqzKTsSQSKO4yXSNCjl+yP7ubmAY1wo+sdKYf+RnNV0IL6q0yBZEaVDmCAQDyaa44g+4P244l4fkjGNqUUdZNGchaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxyBetpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDE5C4CEE7;
	Tue,  4 Mar 2025 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741101817;
	bh=VymNDH1jT+gpaLwW2gldk72PJ+nc5piVYY5i4ZwV7dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxyBetpHB22VDtA1O0dhruAFFhtLwTWLk31jKstAqV9F5n3SPlaGos5T9vKGmLoPi
	 3733IqwMUxNBi68Y1CAlHnG4dks6kg7qhoFObRiShPD4djf77Rsq4SaWXoQMInQHhd
	 lehz7Cz5C437qExf+YyxmXBG+nQrjdIXHeR2ukpM1QqvoIvY9uQbNrdKf0hRP2y+CB
	 9v1dLMquC0+h5JnY3Y+KA40UELaXc5ui7qwDecuGnzO/NtBrOI9gNRdvYlfGl1FIob
	 5O2AhFUG4L4xGndnGUI5HoRu4QHwb0wXY60rG3GYX+SWsVmoRmsPKy7KTS/zHdynhX
	 AnwpcBbIBC1dg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 4/5] cpufreq/amd-pstate: Add support for raw EPP writes
Date: Tue,  4 Mar 2025 09:23:26 -0600
Message-ID: <20250304152327.1561017-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152327.1561017-1-superm1@kernel.org>
References: <20250304152327.1561017-1-superm1@kernel.org>
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
index 28c02edf6e40b..dcf6e36d693f8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1314,6 +1314,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	struct amd_cpudata *cpudata = policy->driver_data;
 	char str_preference[21];
 	ssize_t ret;
+	bool raw_epp = FALSE;
 	u8 epp;
 
 	if (cpudata->dynamic_epp) {
@@ -1330,6 +1331,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	 * matches an index in the energy_perf_strings array
 	 */
 	ret = kstrtou8(str_preference, 0, &epp);
+	raw_epp = !ret;
 	if (ret) {
 		ret = match_string(energy_perf_strings, -1, str_preference);
 		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
@@ -1349,7 +1351,9 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	return ret ? ret : count;
+	cpudata->raw_epp = raw_epp;
+
+	return count;
 }
 EXPORT_SYMBOL_GPL(store_energy_performance_preference);
 
@@ -1360,6 +1364,9 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 
 	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
+	if (cpudata->raw_epp)
+		return sysfs_emit(buf, "%u\n", epp);
+
 	switch (epp) {
 	case AMD_CPPC_EPP_PERFORMANCE:
 		preference = EPP_INDEX_PERFORMANCE;
@@ -1374,7 +1381,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
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


