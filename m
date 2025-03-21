Return-Path: <linux-pm+bounces-24360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85595A6B2F4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 03:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4DD8A1D50
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 02:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56057E107;
	Fri, 21 Mar 2025 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxh4gFTy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA551E98EF;
	Fri, 21 Mar 2025 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524160; cv=none; b=RNtIyMzPbpbuG+88cw+SNvXKtZcVkGwvOTJw2Ybe6y2jMbE3zssx0qDp2pdiwq4OefwgHwhkqE0s8aadR3P6z3GsTenELAEI05cLcGkPJ+S37vZbuEMPeKqf6b017fJQ66KITIzPJrVdlYXfs/sAs7BiZvSKMIDLMj0zjstkDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524160; c=relaxed/simple;
	bh=Ovxkur7Th1bj1n91ym6geZ1kTrWIxYLfjpr2pVhZrw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naBIFMhPlMNwKW0/+ZArzBcIR+kdVHZH9mSgv5Hd9SwsW5AqIb6UnaS8AIYBjrYxI5A4tlfGFjyku10ghDH6kRNmZ+NhU6p6+itdA0rtjJOs5xeEsG373n23vSbtH3XUnOLUEcvt70D5+GWGgdIml4XFUkpU7mew3QfmYtssbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxh4gFTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FC0C4CEF7;
	Fri, 21 Mar 2025 02:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742524160;
	bh=Ovxkur7Th1bj1n91ym6geZ1kTrWIxYLfjpr2pVhZrw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxh4gFTy0ybOH1FBbRwoZIVC8/faPSWiTXVqtlECiovY8e1kEXNTIcE0KWSLrZjH8
	 FAdbYCZwiOCb2TJFrfA9dvipZD2v60WdywejqzQtJZEDKxqGCSkWfNn9ojjqngvgVQ
	 qFJoQSbL7OFNXStTWlNS6xQvXcFmBcCIipqWN6vRND2zM8SBZFBESlvX4iXIfWlM3y
	 9KjEKdAD8w6mE0dhJdQ6HAi0n0xt1Defx3UGpHsgMqaW35tABKmckPEPIUaIjQcBfE
	 DpgZoGX2F4Y9p5QH0LvRm29Ng3ty2fbV5ugQJCf9kOEx/x4jluIolRyfjnyqsq/NBb
	 zEjJDXnfd+dWw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 5/5] cpufreq/amd-pstate-ut: Add a unit test for raw EPP
Date: Thu, 20 Mar 2025 21:28:58 -0500
Message-ID: <20250321022858.1538173-6-superm1@kernel.org>
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

Ensure that all supported raw EPP values work properly.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 58 +++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index e671bc7d15508..d0c5c0aa3cc94 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/cleanup.h>
 
@@ -33,6 +34,7 @@
 
 #include "amd-pstate.h"
 
+DEFINE_FREE(free_page, void *, if (_T) free_page((unsigned long)_T))
 
 struct amd_pstate_ut_struct {
 	const char *name;
@@ -46,6 +48,7 @@ static int amd_pstate_ut_acpi_cpc_valid(u32 index);
 static int amd_pstate_ut_check_enabled(u32 index);
 static int amd_pstate_ut_check_perf(u32 index);
 static int amd_pstate_ut_check_freq(u32 index);
+static int amd_pstate_ut_epp(u32 index);
 static int amd_pstate_ut_check_driver(u32 index);
 
 static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
@@ -53,6 +56,7 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
 	{"amd_pstate_ut_check_enabled",    amd_pstate_ut_check_enabled    },
 	{"amd_pstate_ut_check_perf",       amd_pstate_ut_check_perf       },
 	{"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       },
+	{"amd_pstate_ut_epp",              amd_pstate_ut_epp              },
 	{"amd_pstate_ut_check_driver",	   amd_pstate_ut_check_driver     }
 };
 
@@ -239,6 +243,60 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
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


