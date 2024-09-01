Return-Path: <linux-pm+bounces-13298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF6396743A
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 04:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F901F21F96
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 02:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FF02BAF3;
	Sun,  1 Sep 2024 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCcZrREp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE12AD13;
	Sun,  1 Sep 2024 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725158975; cv=none; b=pckt+abNviC3pqsnnwTn/NYGfrOx9BvHjNJVWMpc/4ZjkVS7F3jZjShu94UT41kOBorgwbNuvTGaa7KvmBCN7+OIOAoZBqUnQh1gd1ZAYregVZs4tfq8hukRtEipsF6Wyk+vr2vEieVWQ3eg+d3FisZOo2yswzeB20Z/2pGoT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725158975; c=relaxed/simple;
	bh=57Pfzhf5HI0arp2bkDqGJxs6bko+iFrqX0x2e0coG9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3AZPkPRvHbz6E4tEaM+vvsZjPvdLGPSZQFtbc9eDCk6Sid75iXWM39YwP6qge69yzUTh+gFwynD/3602gt4XPm3dTlfA70jj4+uAeNGb5wmjvVEkfT9UTaxZEfxJKHTqPoh65vrV6wHQmwNX4kevQDOmzeaNs4QIzNjJdt79S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCcZrREp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6B9C4CEC5;
	Sun,  1 Sep 2024 02:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725158974;
	bh=57Pfzhf5HI0arp2bkDqGJxs6bko+iFrqX0x2e0coG9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCcZrREpQIa/ITh66+o2YIlCvPMgw6CAHmBXXa5Wmg/UGApyYXdRakHZQnnjiYAVu
	 EX/ztdCuMCCixfl436NTiFnT6aazaecCY02yergBmG1+lNRbdonAGTwoDlk9LfFnSg
	 MyRiAO4vKHn2BYp1QZBr3kCiIOyrQhxT3f2pbCRnE0nHpoCcJ/Jqjltpj1ZuIklbMS
	 gVlRgBxqOlgO7uUL+WEdnS0T+zbb8bZFio11b8hR/Ivl1pwDaVcrDrH/YUI6vGFHPe
	 Zxg7L6l6FLAOAY8o02axX7R+iCkizqt67VRGgkqHg17Uijvpl8YH0o1dEXVSU6l3bY
	 F6CVEUqCy6d0g==
From: Mario Limonciello <superm1@kernel.org>
To: Meng Li <li.meng@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	ptr1337@cachyos.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] cpufreq/amd-pstate: Export symbols for changing modes
Date: Sat, 31 Aug 2024 21:49:11 -0500
Message-ID: <20240901024912.1217014-2-superm1@kernel.org>
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

In order to effectively test all mode switch combinations export
everything necessarily for amd-pstate-ut to trigger a mode switch.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 23 ++++++++++-------------
 drivers/cpufreq/amd-pstate.h | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 073ca9caf52ac..93adde45bebce 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -60,18 +60,6 @@
 #define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
 #define AMD_CPPC_EPP_POWERSAVE			0xFF
 
-/*
- * enum amd_pstate_mode - driver working mode of amd pstate
- */
-enum amd_pstate_mode {
-	AMD_PSTATE_UNDEFINED = 0,
-	AMD_PSTATE_DISABLE,
-	AMD_PSTATE_PASSIVE,
-	AMD_PSTATE_ACTIVE,
-	AMD_PSTATE_GUIDED,
-	AMD_PSTATE_MAX,
-};
-
 static const char * const amd_pstate_mode_string[] = {
 	[AMD_PSTATE_UNDEFINED]   = "undefined",
 	[AMD_PSTATE_DISABLE]     = "disable",
@@ -81,6 +69,14 @@ static const char * const amd_pstate_mode_string[] = {
 	NULL,
 };
 
+const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode)
+{
+	if (mode < 0 || mode >= AMD_PSTATE_MAX)
+		return NULL;
+	return amd_pstate_mode_string[mode];
+}
+EXPORT_SYMBOL_GPL(amd_pstate_get_mode_string);
+
 struct quirk_entry {
 	u32 nominal_freq;
 	u32 lowest_freq;
@@ -1352,7 +1348,7 @@ static ssize_t amd_pstate_show_status(char *buf)
 	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
 }
 
-static int amd_pstate_update_status(const char *buf, size_t size)
+int amd_pstate_update_status(const char *buf, size_t size)
 {
 	int mode_idx;
 
@@ -1369,6 +1365,7 @@ static int amd_pstate_update_status(const char *buf, size_t size)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(amd_pstate_update_status);
 
 static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index cc8bb2bc325aa..cd573bc6b6db8 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -103,4 +103,18 @@ struct amd_cpudata {
 	bool	boost_state;
 };
 
+/*
+ * enum amd_pstate_mode - driver working mode of amd pstate
+ */
+enum amd_pstate_mode {
+	AMD_PSTATE_UNDEFINED = 0,
+	AMD_PSTATE_DISABLE,
+	AMD_PSTATE_PASSIVE,
+	AMD_PSTATE_ACTIVE,
+	AMD_PSTATE_GUIDED,
+	AMD_PSTATE_MAX,
+};
+const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
+int amd_pstate_update_status(const char *buf, size_t size);
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.43.0


