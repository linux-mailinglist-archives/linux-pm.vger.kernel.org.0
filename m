Return-Path: <linux-pm+bounces-35862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF75DBC9FAE
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952C43A450C
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C092FABF5;
	Thu,  9 Oct 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hicofYhh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEA82FB99E;
	Thu,  9 Oct 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025605; cv=none; b=scx+HxWWwzvHW3QqXJUG680igRma0etvQM6WninsbE/dSnzQo5BPGIMg5tQEWpzQg1kqGOE2uT/LRqEtD4MEpVCPjdJGOwyfFULe1xdEOcV/m8KuWk3dJ+CVdp1qBNTjL8xYL1PTdc7EZSp8Sug1+4LXX4XOH4Kg5gdr9DE1ypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025605; c=relaxed/simple;
	bh=Y0lEqFCh/OtrzyCfm6IZuqcyvjrHHiiSM7TqqV7hQow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmEQTs4KBqYXBh8LKXo0mxFfUGh14UkE7b1Q7m97oh9SZXLB/WxL0GtA9ZTff0gNZMW6acl2iXRCfsSFXIviSfNkXDqAjq7ZZhwndoHYtBhqIZAwGkI3Xz8ua9ms+39kKu/RFmPv5f2LfrDk3kfABcqaTixXs/608ZqsrJh66tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hicofYhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67042C4CEE7;
	Thu,  9 Oct 2025 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025605;
	bh=Y0lEqFCh/OtrzyCfm6IZuqcyvjrHHiiSM7TqqV7hQow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hicofYhhxXSMM8JgZPdemrc5EKn5P/Ykr5831Mzz/83mAF4t0z4UZnJwAY9F9J7Ng
	 IiAV26geThxBfEGawJCTMEvhU+q53VGdXDXe4/8C54x54/XcGyxHWBp9s8I6ENW8LX
	 po7/roB/8eJzlwzStT6ENWTDPqlThuQNjZ2KmWVzzDiwDfJLXT7R/gDi8zId3Y1g68
	 5M+6IA/2IGodXYJ2cQkGcZN0xegYk+38xF63ymGKxFtEtw4XWpqU4AVbxUX1j1scG/
	 RWKFKgEY07vNIs6TT7r906jbbneRdcljx98ZIlJi4K9y78lGngdLitLKuV4m+ONmwD
	 TI5vRWD/U/M9w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] cpufreq: ondemand: Update the efficient idle check for Intel extended Families
Date: Thu,  9 Oct 2025 11:55:37 -0400
Message-ID: <20251009155752.773732-71-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

[ Upstream commit 7f3cfb7943d27a7b61bdac8db739cf0bdc28e87d ]

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
Link: https://patch.msgid.link/20250908230655.2562440-1-sohil.mehta@intel.com
[ rjw: Added empty line after #include ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- The old whitelist was removed and `od_init()` now relies on
  `od_should_io_be_busy()` to set `dbs_data->io_is_busy`
  (`drivers/cpufreq/cpufreq_ondemand.c:360`), so the ondemand governor
  no longer ignores I/O wait load on Intel CPUs whose family number is
  ≥6. Without this, brand‑new Intel families (18/19) and even existing
  family 15 parts default to “I/O idle”, which keeps frequencies low
  under storage-heavy workloads—a clear performance regression on
  shipping hardware that still ships with the ondemand governor.
- The new helper in the header
  (`drivers/cpufreq/cpufreq_ondemand.h:29-50`) checks
  `boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO`, effectively covering
  every Intel CPU from Pentium Pro onward while leaving other vendors
  untouched. The fallback branch still returns false on non-x86 systems
  (`drivers/cpufreq/cpufreq_ondemand.h:48-49`), so the change is tightly
  scoped and backward compatible elsewhere.
- This is a tiny, self-contained tweak (no ABI or architectural churn)
  that simply broadens the existing default to match current Intel
  guidance; users can still override the policy via the existing sysfs
  knob. The only prerequisite is the `x86_vfm` field (commit
  a9d0adce6907, in v6.10 and newer); ensure any target stable branch
  already has it or bring that dependency along.

Next step: 1) If you target a stable series older than v6.10, backport
a9d0adce6907 (“x86/cpu/vfm: Add/initialize x86_vfm field…”) first so
this change builds.

 drivers/cpufreq/cpufreq_ondemand.c | 25 +------------------------
 drivers/cpufreq/cpufreq_ondemand.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 0e65d37c92311..a6ecc203f7b7f 100644
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
index 1af8e5c4b86fd..2ca8f1aaf2e34 100644
--- a/drivers/cpufreq/cpufreq_ondemand.h
+++ b/drivers/cpufreq/cpufreq_ondemand.h
@@ -24,3 +24,26 @@ static inline struct od_policy_dbs_info *to_dbs_info(struct policy_dbs_info *pol
 struct od_dbs_tuners {
 	unsigned int powersave_bias;
 };
+
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+
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
2.51.0


