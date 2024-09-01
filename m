Return-Path: <linux-pm+bounces-13299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A2896743C
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 04:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A08282CED
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 02:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E84376EC;
	Sun,  1 Sep 2024 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cwn/LY5X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E873364AB;
	Sun,  1 Sep 2024 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725158976; cv=none; b=rd32hiI6yv4aCNuj+rD6wdF4EhgUl5V3iufa5XLUE/qKC0IxySseM6dz9qExPSCzXrpQsG5yf9rfh5o9o6hR5+d036HXJJALosGJqy6C+vx0/bm7cyIuE+ZflJVu+JPRkfZj00tKw3NitvS9Wkz8M7HaV1c+I6FTV3LuQ8AZqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725158976; c=relaxed/simple;
	bh=lmiZoFRv3RC9NTR0pOBpjFGmZGtJhe2ymb6X495LMqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C68BQ+aKjpBLA1eSHuaeK6wwdcQKj8BUyUtc7vCHwaraXFT117X+KsrcFmkqwLIrJb+rkV14wtKmP9Cyxxxt2wlBJgs/whZ4fXgmVYxL9pj1eVFWbSknvAfDFAbYEzbk4ZB1BpESrXJ6RFE5dqde8t3NnnZ1pG3obIGHyr5RCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cwn/LY5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E848CC4CED0;
	Sun,  1 Sep 2024 02:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725158975;
	bh=lmiZoFRv3RC9NTR0pOBpjFGmZGtJhe2ymb6X495LMqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cwn/LY5XU5e0Ey7LoR/osnHgb8U/0bSZADGOgRyJQ01G/XYJIZdvIjKkS/o+U7tVb
	 4ygqrQCwlqr67GA+BA9GLNm3Q+mLBbUHxj7ZXXWpOeCckpbLDAov0LYdpem5odzGeM
	 zFD8a2uUe9T2CFgfFl+sintRzGvQ/g+bMvDKkIUYrPaX6SzpdEwcB6yndGooKa096U
	 /UafOzROviPOH8xJExIAdVDOiy/7Xsc8QdslDjw3gXtC/tiHaZXeAKS88Y1zPJB10j
	 fdG89ZxpPdzCsW4zh8lfjGgqRYNfpDZxeQN9Dgv5cr7xm5MtmQbbwxudKtl9ebKFlF
	 inEqXWplZ+nAg==
From: Mario Limonciello <superm1@kernel.org>
To: Meng Li <li.meng@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	ptr1337@cachyos.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] cpufreq/amd-pstate-ut: Add test case for mode switches
Date: Sat, 31 Aug 2024 21:49:12 -0500
Message-ID: <20240901024912.1217014-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240901024912.1217014-1-superm1@kernel.org>
References: <20240901024912.1217014-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

There is a state machine in the amd-pstate driver utilized for
switches for all modes. To make sure that cleanup and setup works
properly for each mode add a unit test case that tries all
combinations.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 41 ++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index b7318669485e4..c291b3dbec381 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -54,12 +54,14 @@ static void amd_pstate_ut_acpi_cpc_valid(u32 index);
 static void amd_pstate_ut_check_enabled(u32 index);
 static void amd_pstate_ut_check_perf(u32 index);
 static void amd_pstate_ut_check_freq(u32 index);
+static void amd_pstate_ut_check_driver(u32 index);
 
 static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
 	{"amd_pstate_ut_acpi_cpc_valid",   amd_pstate_ut_acpi_cpc_valid   },
 	{"amd_pstate_ut_check_enabled",    amd_pstate_ut_check_enabled    },
 	{"amd_pstate_ut_check_perf",       amd_pstate_ut_check_perf       },
-	{"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       }
+	{"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       },
+	{"amd_pstate_ut_check_driver",	   amd_pstate_ut_check_driver     }
 };
 
 static bool get_shared_mem(void)
@@ -257,6 +259,43 @@ static void amd_pstate_ut_check_freq(u32 index)
 	cpufreq_cpu_put(policy);
 }
 
+static int amd_pstate_set_mode(enum amd_pstate_mode mode)
+{
+	const char *mode_str = amd_pstate_get_mode_string(mode);
+
+	pr_debug("->setting mode to %s\n", mode_str);
+
+	return amd_pstate_update_status(mode_str, strlen(mode_str));
+}
+
+static void amd_pstate_ut_check_driver(u32 index)
+{
+	enum amd_pstate_mode mode1, mode2;
+	int ret;
+
+	for (mode1 = AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX; mode1++) {
+		ret = amd_pstate_set_mode(mode1);
+		if (ret)
+			goto out;
+		for (mode2 = AMD_PSTATE_DISABLE; mode2 < AMD_PSTATE_MAX; mode2++) {
+			if (mode1 == mode2)
+				continue;
+			ret = amd_pstate_set_mode(mode2);
+			if (ret)
+				goto out;
+		}
+	}
+out:
+	if (ret)
+		pr_warn("%s: failed to update status for %s->%s: %d\n", __func__,
+			amd_pstate_get_mode_string(mode1),
+			amd_pstate_get_mode_string(mode2), ret);
+
+	amd_pstate_ut_cases[index].result = ret ?
+					    AMD_PSTATE_UT_RESULT_FAIL :
+					    AMD_PSTATE_UT_RESULT_PASS;
+}
+
 static int __init amd_pstate_ut_init(void)
 {
 	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
-- 
2.43.0


