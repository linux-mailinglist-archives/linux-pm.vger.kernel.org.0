Return-Path: <linux-pm+bounces-23408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D1A4E3EF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC393BF741
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B676B284B41;
	Tue,  4 Mar 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEQZSg7D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E512284B3A;
	Tue,  4 Mar 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101818; cv=none; b=RPzNQBslPx2Uk3o63JLA8wS+dPDtgprWQQj5JK4KeubqKMzaudWNHiFRcf9SzekOTalk64e6sy4F5tsR1nGu48B91YZwYK7YJQ/NQefEVKS96Oe1HD70q54c3clBUpCWmxoF511kmxuixkM9oz6PEbhGokDcXP2O6blTJFoqmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101818; c=relaxed/simple;
	bh=Ovxkur7Th1bj1n91ym6geZ1kTrWIxYLfjpr2pVhZrw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lly4dqldcTXatuolpx9duNmoSvu6z/7hYVZWrLWOjNr7uK0xSyqoFQE88LAZbbkBzilUluac3eQcFhaPNRMNIcQuXZRI+wXqAgZH97/Uw2uZ8ap2IcVnx9dMjz8gyaVtZKD4ruwuPJGkUrv7u6ECVQBuR75PgCAEm8a+CC/3A/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEQZSg7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA44AC4CEEF;
	Tue,  4 Mar 2025 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741101818;
	bh=Ovxkur7Th1bj1n91ym6geZ1kTrWIxYLfjpr2pVhZrw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEQZSg7DTXo2d31QQQ6pkAwUhAw5E/jJ7NsjHva76xYZ9IWvym/w8bWs+kKcOxi0z
	 iTNP/twrfServawBsR/o0xDynDEJ7G/Z9YjFuZCZgFC3SQ4QNL4oRRQ3eu+6NaENET
	 fjb17bACotIGURQ1PrdSZqrfn/fREQOMkRTobhjTpY1xTItsHUixX+mRkrUOC4yzu3
	 tRng3lp2H5JJpb1HSIZ0w+OCf77pdoRCdt6osug9fYCAIJcdvQZRzvz7D9q3prRl2Y
	 EG0U2i2Ejf4Aiy8oHvw3C11eXz6JQ83f9az3rja8hhIEtbNm+BuRJgFTjQRlSv+cbt
	 SCs62lQs6kBVA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 5/5] cpufreq/amd-pstate-ut: Add a unit test for raw EPP
Date: Tue,  4 Mar 2025 09:23:27 -0600
Message-ID: <20250304152327.1561017-6-superm1@kernel.org>
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


