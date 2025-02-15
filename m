Return-Path: <linux-pm+bounces-22145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ABEA36A63
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 02:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9A81896DB9
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1B1DF963;
	Sat, 15 Feb 2025 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhoKX1i7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1319ABDE;
	Sat, 15 Feb 2025 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580903; cv=none; b=HS1hvDBlyxpyczwa379VYo4qm5OKMHNQsfRI6sWmDIF977P3HDJXIKGXz2+DCtC1+NB7V/YyzqhbdUMbKIzIl2mh8Ujx0/ZozYgH5po8JIHPzCBmGKa0t2JeEmRUypsaAUA2vlghqsZNP3X+z+0U0fPhfkXvySHMwMAh3fSTvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580903; c=relaxed/simple;
	bh=gJBb3JyO4xb+ZhP18SRMcjTy36ZQoLUIZdnq9lF0008=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZQbQpaRthvDsjN3XnVTES+JNak4miwWdoNFbdhWdhrXM+bvo7aWep66RLB3lFuU74Hem7Bc9KTm47wz15lmaxbzez4feck3o0DU7XTVuBqOZOCLbv2ckGRm6Gt2bd2A27sedRYCBN/JZbKm9XlOLMDYrYTNCq8tk6uDBCXt9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhoKX1i7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B8AC4CEE9;
	Sat, 15 Feb 2025 00:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580903;
	bh=gJBb3JyO4xb+ZhP18SRMcjTy36ZQoLUIZdnq9lF0008=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhoKX1i7AugFrX1chA1NAottTknWKSNboE3e9MCu0TV4jrk+qzbGEzRLr00R3hb60
	 hM++KpZpvO207VlYIKDnVp+VHwbsu9NZhJD+FOwZVRqQ29Xw50ywSjoqehTvecQp9c
	 eutnSu+vfHvHnmaQN+pc0bWHuPbe+rrhoG6BoE3V5NlkKaV8fsLK+6eqVH6HrHyf0k
	 NTr4JfNm5aT0EzYLQ/s7pJ6DypYmkAw+h9CAbR/sb8onvQNJfn3B1wm8vyuByM205u
	 LqzAOXfjm07S1bbYA734/B/taeGu2BPDzxKuNVgs8rUWIpqFzdQGaJBUT6Sslvlflo
	 TGaVCCM0hdcMA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5/5] cpufreq/amd-pstate-ut: Add a unit test for raw EPP
Date: Fri, 14 Feb 2025 18:54:48 -0600
Message-ID: <20250215005448.1216646-6-superm1@kernel.org>
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

Ensure that all supported raw EPP values work properly.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 58 +++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 067e9e325102e..b5bf0c37d8037 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/cleanup.h>
 
@@ -32,6 +33,7 @@
 
 #include "amd-pstate.h"
 
+DEFINE_FREE(free_page, void *, if (_T) free_page((unsigned long)_T))
 
 struct amd_pstate_ut_struct {
 	const char *name;
@@ -45,6 +47,7 @@ static int amd_pstate_ut_acpi_cpc_valid(u32 index);
 static int amd_pstate_ut_check_enabled(u32 index);
 static int amd_pstate_ut_check_perf(u32 index);
 static int amd_pstate_ut_check_freq(u32 index);
+static int amd_pstate_ut_epp(u32 index);
 static int amd_pstate_ut_check_driver(u32 index);
 
 static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
@@ -52,6 +55,7 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
 	{"amd_pstate_ut_check_enabled",    amd_pstate_ut_check_enabled    },
 	{"amd_pstate_ut_check_perf",       amd_pstate_ut_check_perf       },
 	{"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       },
+	{"amd_pstate_ut_epp",              amd_pstate_ut_epp              },
 	{"amd_pstate_ut_check_driver",	   amd_pstate_ut_check_driver     }
 };
 
@@ -238,6 +242,60 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
 	return amd_pstate_update_status(mode_str, strlen(mode_str));
 }
 
+static int amd_pstate_ut_epp(u32 index)
+{
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+	void *buf __free(free_page) = NULL;
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
+		memset(buf, 0, sizeof(buf));
+		snprintf(buf, PAGE_SIZE, "%d", epp);
+		ret = store_energy_performance_preference(policy, buf, sizeof(buf));
+		if (ret < 0)
+			return ret;
+
+		/* check if the EPP value reads back correctly for raw numbers */
+		memset(buf, 0, sizeof(buf));
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


