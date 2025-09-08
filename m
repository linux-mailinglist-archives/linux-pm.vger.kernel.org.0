Return-Path: <linux-pm+bounces-34186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439AFB49D4A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 01:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8A64E012A
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DAF2DE1FA;
	Mon,  8 Sep 2025 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZYsglFV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223993EA8D;
	Mon,  8 Sep 2025 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372935; cv=none; b=V6dW8HKQ4HHqH9qtaEedXLREHgLZK3+Aq05/BwXzXG8Q6iAUL5H1JudSF4XXBixf/tR7jiEeC1No+U2IuiDYMPaiGqYtZmVnZo3VmApWa5qGOlOT7OsTaEUmZMtwLcxVdG4FKO4jVqqY3JPuHMO/T68BPo01uu326fPYaRYE8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372935; c=relaxed/simple;
	bh=lhAM8KeTbiKt7V0qy8II78kuLQjyiTyKQmMQnPCnJI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYJ8SMrYm8gg06pE4Vngrqj8S5vK62DZUC9n97V6PTqvBEhp+JoodngF1eeJVGxD+ZLD0pNXiFnF0Ezy9k2BQ1RUFhvUusPGvZ7cb8EjBzt3jXIq9H+htKLiGhXXSQO4qPI9VN/mlHIJhwqSPt/4Rz7OBLc3iLp3s0oTPa3Z2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZYsglFV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757372934; x=1788908934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lhAM8KeTbiKt7V0qy8II78kuLQjyiTyKQmMQnPCnJI0=;
  b=OZYsglFVfIhfilUf94skbswwycnniGXixbmujQXDx9UhM5bN/jKUzmfm
   p2beRgehePO3HWTwBjMuLBwGmBpnhEhUWB5aR7KiWc+4H6LLx9VV8faLJ
   Njr3Q2J5SPUSifB9rF/PeCX/xkwDkNtS4zxqWsb/uSlH4TDt47If1wury
   yud0MCHCeSvQy8/QgmcmrJ/TN/D6QcRxa7PomGiAyjROyDTR6ax1HFekf
   Xj5ok68xnJ67wtfCe+5ThdeGmY0fXV1+oBvVeKShoAwxZpshYLI52Vmw4
   wlUhIyCH5qVkDMW88NUDUHHKFGBzaEtbDuxSWY7IffvuQDofOm/83s5Fi
   g==;
X-CSE-ConnectionGUID: 6okHYDh5Rkqa3pF9DXwpWw==
X-CSE-MsgGUID: OrtOcV7xROGSQoval6mKwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="62274848"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="62274848"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 16:08:50 -0700
X-CSE-ConnectionGUID: TaLVyFecQpGW+m7gb0nq2A==
X-CSE-MsgGUID: QEubmJqBTAucgkbNOtXQUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="173723052"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 08 Sep 2025 16:08:50 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Cc: x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	Zhao Liu <zhao1.liu@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v4] cpufreq: ondemand: Update the efficient idle check for Intel extended Families
Date: Mon,  8 Sep 2025 16:06:55 -0700
Message-ID: <20250908230655.2562440-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IO time is considered busy by default for modern Intel processors. The
current check covers recent Family 6 models but excludes the brand new
Families 18 and 19.

According to Arjan van de Ven, the model check was mainly due to a lack
of testing on systems before INTEL_CORE2_MEROM. He suggests considering
all Intel processors as having an efficient idle.

Extend the IO busy classification to all Intel processors starting with
Family 6, including Family 15 (Pentium 4s) and upcoming Families 18/19.

Use an x86 VFM check and move the function to the header file to avoid
using arch-specific #ifdefs in the C file.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v4:
 - Move the function check to the header file as an inline function.
 - Combine x86 specific #ifdefs.

v3: https://lore.kernel.org/lkml/20250826183644.220093-1-sohil.mehta@intel.com/
 - Posting this patch separately since the core family cleanup series
   was merged without it.
 - Improve commit message and code comments.
---
 drivers/cpufreq/cpufreq_ondemand.c | 25 +------------------------
 drivers/cpufreq/cpufreq_ondemand.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 0e65d37c9231..a6ecc203f7b7 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -29,29 +29,6 @@ static struct od_ops od_ops;
 
 static unsigned int default_powersave_bias;
 
-/*
- * Not all CPUs want IO time to be accounted as busy; this depends on how
- * efficient idling at a higher frequency/voltage is.
- * Pavel Machek says this is not so for various generations of AMD and old
- * Intel systems.
- * Mike Chan (android.com) claims this is also not true for ARM.
- * Because of this, whitelist specific known (series) of CPUs by default, and
- * leave all others up to the user.
- */
-static int should_io_be_busy(void)
-{
-#if defined(CONFIG_X86)
-	/*
-	 * For Intel, Core 2 (model 15) and later have an efficient idle.
-	 */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
-			boot_cpu_data.x86 == 6 &&
-			boot_cpu_data.x86_model >= 15)
-		return 1;
-#endif
-	return 0;
-}
-
 /*
  * Find right freq to be set now with powersave_bias on.
  * Returns the freq_hi to be used right now and will set freq_hi_delay_us,
@@ -377,7 +354,7 @@ static int od_init(struct dbs_data *dbs_data)
 	dbs_data->sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR;
 	dbs_data->ignore_nice_load = 0;
 	tuners->powersave_bias = default_powersave_bias;
-	dbs_data->io_is_busy = should_io_be_busy();
+	dbs_data->io_is_busy = od_should_io_be_busy();
 
 	dbs_data->tuners = tuners;
 	return 0;
diff --git a/drivers/cpufreq/cpufreq_ondemand.h b/drivers/cpufreq/cpufreq_ondemand.h
index 1af8e5c4b86f..eb35ec19fa86 100644
--- a/drivers/cpufreq/cpufreq_ondemand.h
+++ b/drivers/cpufreq/cpufreq_ondemand.h
@@ -24,3 +24,25 @@ static inline struct od_policy_dbs_info *to_dbs_info(struct policy_dbs_info *pol
 struct od_dbs_tuners {
 	unsigned int powersave_bias;
 };
+
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+/*
+ * Not all CPUs want IO time to be accounted as busy; this depends on
+ * how efficient idling at a higher frequency/voltage is.
+ *
+ * Pavel Machek says this is not so for various generations of AMD and
+ * old Intel systems. Mike Chan (android.com) claims this is also not
+ * true for ARM.
+ *
+ * Because of this, select a known series of Intel CPUs (Family 6 and
+ * later) by default, and leave all others up to the user.
+ */
+static inline bool od_should_io_be_busy(void)
+{
+	return (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+		boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO);
+}
+#else
+static inline bool od_should_io_be_busy(void) { return false; }
+#endif
-- 
2.43.0


