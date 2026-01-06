Return-Path: <linux-pm+bounces-40261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3C0CF6C25
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 06:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CF013079AE0
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 05:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB5D2F659F;
	Tue,  6 Jan 2026 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpjWOGXX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420D2FD1CF;
	Tue,  6 Jan 2026 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767676516; cv=none; b=oBCSj7mlqIVEofPiThhh9kQxBV+VishvA7QgEeHQbynowh01xzse4vFQTU7LBYPnZb2wEGTwIQl042iqP+gwoTLjudhCsj614n+VrfnvBH+oe1wkW3g/WYJPl2w3xLWCgDlDUzq9ziVFD4CKmpdeGOd5htK99psgH4pPPb1tdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767676516; c=relaxed/simple;
	bh=4Xf5M26QhIx7PvxjoOfMxL9jKXnZ/prTFEPkgVcsvr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXEqp92Yk8ktPpZpMmRBFqvZS0itvVdNCd/9ZdYBKed48wRnfVZt3K5bFhotdDkMJctBkFLtF/8SiCStLGb3hAcsvPvc3y7PkKDdXw9VLJ5CDzrsSEf1KU6LMEe1ZJBoJlKDvhHvYgNsSqt05FQoDlAa+TYQP0CcglibO/ZWTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpjWOGXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D559C19421;
	Tue,  6 Jan 2026 05:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767676516;
	bh=4Xf5M26QhIx7PvxjoOfMxL9jKXnZ/prTFEPkgVcsvr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpjWOGXXujo8syr/PZjNquS7Do0X0Szzg27eCgs/OoXjSr0XylK3mDjASskKOppxM
	 cWgFHsGDzZ4v4uS93ngShmiqWgotLXveSZdyfsvTidFiCNT6YIgK3BHQ4VkmWvQh8D
	 KmUFwEAAUAONeYpozmGgcDG1Fzgv0haMIPRvO1VfmusXAd6dAPQ05qeYL8u0JQseal
	 kKQWFSG4FNvu5Xvn0grXbTaKpvA7dyrx+FN93Y/Hfl6LrJVfF5uuhyKY8mzW4Pxli4
	 3PqsG7vADGHAPC9MUUY2hbhrzyZQXWAp3RsjmyEOzXNzEabSxLRGte2YXmN6JM7+VU
	 rl83mOQ85o5YA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 5/5] cpufreq/amd-pstate-ut: Add a unit test for raw EPP
Date: Mon,  5 Jan 2026 23:14:41 -0600
Message-ID: <20260106051441.60093-6-superm1@kernel.org>
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

Ensure that all supported raw EPP values work properly.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 58 +++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 447b9aa5ce40b..d51233b753db6 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/cleanup.h>
 
@@ -35,6 +36,7 @@
 
 #include "amd-pstate.h"
 
+DEFINE_FREE(cleanup_page, void *, if (_T) free_page((unsigned long)_T))
 
 struct amd_pstate_ut_struct {
 	const char *name;
@@ -48,6 +50,7 @@ static int amd_pstate_ut_acpi_cpc_valid(u32 index);
 static int amd_pstate_ut_check_enabled(u32 index);
 static int amd_pstate_ut_check_perf(u32 index);
 static int amd_pstate_ut_check_freq(u32 index);
+static int amd_pstate_ut_epp(u32 index);
 static int amd_pstate_ut_check_driver(u32 index);
 
 static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
@@ -55,6 +58,7 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
 	{"amd_pstate_ut_check_enabled",    amd_pstate_ut_check_enabled    },
 	{"amd_pstate_ut_check_perf",       amd_pstate_ut_check_perf       },
 	{"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       },
+	{"amd_pstate_ut_epp",              amd_pstate_ut_epp              },
 	{"amd_pstate_ut_check_driver",	   amd_pstate_ut_check_driver     }
 };
 
@@ -241,6 +245,60 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
 	return amd_pstate_update_status(mode_str, strlen(mode_str));
 }
 
+static int amd_pstate_ut_epp(u32 index)
+{
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+	void *buf __free(cleanup_page) = NULL;
+	struct amd_cpudata *cpudata;
+	int ret, cpu = 0;
+	u16 epp;
+
+	policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return -ENODEV;
+
+	cpudata = policy->driver_data;
+
+	/* disable dynamic EPP before running test */
+	if (cpudata->dynamic_epp) {
+		pr_debug("Dynamic EPP is enabled, disabling it\n");
+		amd_pstate_clear_dynamic_epp(policy);
+	}
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = amd_pstate_set_mode(AMD_PSTATE_ACTIVE);
+	if (ret)
+		return ret;
+
+	for (epp = 0; epp <= U8_MAX; epp++) {
+		u8 val;
+
+		/* write all EPP values */
+		memset(buf, 0, sizeof(*buf));
+		snprintf(buf, PAGE_SIZE, "%d", epp);
+		ret = store_energy_performance_preference(policy, buf, sizeof(*buf));
+		if (ret < 0)
+			return ret;
+
+		/* check if the EPP value reads back correctly for raw numbers */
+		memset(buf, 0, sizeof(*buf));
+		ret = show_energy_performance_preference(policy, buf);
+		if (ret < 0)
+			return ret;
+		strreplace(buf, '\n', '\0');
+		ret = kstrtou8(buf, 0, &val);
+		if (!ret && epp != val) {
+			pr_err("Raw EPP value mismatch: %d != %d\n", epp, val);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int amd_pstate_ut_check_driver(u32 index)
 {
 	enum amd_pstate_mode mode1, mode2 = AMD_PSTATE_DISABLE;
-- 
2.43.0


