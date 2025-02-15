Return-Path: <linux-pm+bounces-22144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A9A36A5E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79082169E44
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AD5193436;
	Sat, 15 Feb 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9CnHvia"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933231925AC;
	Sat, 15 Feb 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580902; cv=none; b=FJaDtX41B8BcTzMcPRs5jJ9PQEOWXVeU/tQPG612Ft9kopXko3IxWeY3QcQwS3J7KuRu4PBVsd7R0SvguoibdKzaO9D0tUyHZe/uRxBNLpSc9EA6bwilebhemCFA7nsQpN4fjfnrY5Zlxru8ZpJSfESopOXxI+SxmtuB46uurnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580902; c=relaxed/simple;
	bh=xNVlLenkvG2vhuYPE5tLdxeYbge7k4Nuv4kwBtl5rD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y25DIHz8xBETGJHWffZbEXAr8N3p5rHBitQbkI3GPQzneBSeOmO9CTeVD7oGunZARLIppoxHZH+U7SkyuqRvMQ/Vu/VR8st3dajnck0NIa3Zi4bOVygjJmwfu4VKU+URlMelCVhqUMLDS3WoKr378GdFmFmesnFVYDBVQuZvsYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9CnHvia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A47C4CEE6;
	Sat, 15 Feb 2025 00:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580902;
	bh=xNVlLenkvG2vhuYPE5tLdxeYbge7k4Nuv4kwBtl5rD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9CnHviagF8D3AVJL73gegi7YXunng4wPOq5gGmz5Y/jWNpgQwJtclG/yBT9NqPAv
	 OUXW/BUGv8KLqs4Xmv5pK8AfELt2PQAcMaCKBgU5vmoP7xJB1kMpE/RjVwCMv3cN6X
	 W5lH+Fi8d1VrSPKQRFlgJgHK9EHJhoteAImf92pv4P+Ia/ed2g6bdbkPe7PEcvRw0f
	 M5sfebFXoCQstgyNHFViwHOW5tfAWPbjRwHZXs7f6Ec8aXVfHN9FfMkO2lUPjbtd6o
	 gWYodg8iYrjCrWtu0Bbx0eIVnx83cWz/s0TMcWqZiqXj3qTE1Uxo8AMGNd/z1x06bj
	 ijsqm4eXXMk7w==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/5] cpufreq/amd-pstate: Add support for raw EPP writes
Date: Fri, 14 Feb 2025 18:54:47 -0600
Message-ID: <20250215005448.1216646-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005448.1216646-1-superm1@kernel.org>
References: <20250215005448.1216646-1-superm1@kernel.org>
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
index 5d5f602ef1407..0d71eaf7366f2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1330,6 +1330,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	struct amd_cpudata *cpudata = policy->driver_data;
 	char str_preference[21];
 	ssize_t ret;
+	bool raw_epp = FALSE;
 	u8 epp;
 
 	if (cpudata->dynamic_epp) {
@@ -1346,6 +1347,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	 * matches an index in the energy_perf_strings array
 	 */
 	ret = kstrtou8(str_preference, 0, &epp);
+	raw_epp = !ret;
 	if (ret) {
 		ret = match_string(energy_perf_strings, -1, str_preference);
 		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
@@ -1365,7 +1367,9 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	return ret ? ret : count;
+	cpudata->raw_epp = raw_epp;
+
+	return count;
 }
 EXPORT_SYMBOL_GPL(store_energy_performance_preference);
 
@@ -1376,6 +1380,9 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 
 	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
+	if (cpudata->raw_epp)
+		return sysfs_emit(buf, "%u\n", epp);
+
 	switch (epp) {
 	case AMD_CPPC_EPP_PERFORMANCE:
 		preference = EPP_INDEX_PERFORMANCE;
@@ -1390,7 +1397,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 		preference = EPP_INDEX_POWERSAVE;
 		break;
 	default:
-		return sysfs_emit(buf, "%u\n", epp);
+		return -EINVAL;
 	}
 
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index f1bbac4faf83d..490fb46f05602 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -106,6 +106,7 @@ struct amd_cpudata {
 	u8	epp_default_ac;
 	u8	epp_default_dc;
 	bool	dynamic_epp;
+	bool	raw_epp;
 	struct notifier_block power_nb;
 
 	/* platform profile */
-- 
2.43.0


