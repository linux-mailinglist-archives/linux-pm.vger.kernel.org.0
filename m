Return-Path: <linux-pm+bounces-33023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2E5B3409D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A10C207C7C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152EE276057;
	Mon, 25 Aug 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioRcutCW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632FD274FD0;
	Mon, 25 Aug 2025 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128207; cv=none; b=Ad1M82ou+LYg3q63gVhwEnVAr7w+UD41+4diTnsKX4g0RbHSsZ4Hf6VR+T3MGxZtL6ILrFokFi3tgezWOidQAatRogdIKbYavd6ZOG/tv/k9FNcFuK7cshuvTmqDVeOzONM0kz+g6ciWIZPit3DxQrpKUo+XlmI4MlHQPwKGSVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128207; c=relaxed/simple;
	bh=ccYU6C74a+JTG6kZjCkh15K+sN1WrW9c0TizBulC32M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbnLebHYaRENFm0TBhKgJPBOM+y/nEAsuESb3LcI/rhAvZDF3LaWpF3R+XM1O3EvHEgRs8NS5aVrdpu+cBOpmtqmqncDaTkSbzFKiRAIBvPofxtvGffkmm9JzIw6jBlj7n3V1WL3xGDpyGExWPVygWy48dttnxrsTcJVPeRykTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioRcutCW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756128205; x=1787664205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ccYU6C74a+JTG6kZjCkh15K+sN1WrW9c0TizBulC32M=;
  b=ioRcutCWo7mCP41sm71c2GcDd6tRJGTUfpsGKEKqTBNdB49RbONG1Ejh
   JBcer9Lbv6n3gE0DEVD49/fx8JirfuyNPuPUwb1sdaJZZM4bAtSGB0Ajy
   tJSEKRDpB8WP3jQWJsg1uUawgFb4l3m39qG2OkhAkxUtx+XYfHUGKVLXS
   3AUUsfs4Yf2WSNND5jlsoZ3F3VwGE+FntF6zjh/9PlsGrGZUhOemt7LmK
   g4b1I/SpWU83SxvMgzU0FVKLLFU1H79boNm7FLJueOi3K+b1x3mAusBqI
   y+mRzpa4uq4NZacDqSh5QZ39b6jvftfXvQHkMghUx37YOceqjUVt8S6dE
   Q==;
X-CSE-ConnectionGUID: 8/cweqmLRDSWdI8vtsufiQ==
X-CSE-MsgGUID: kgozc2KlRHSRI2zLfR/Jcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58048409"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="58048409"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:23:21 -0700
X-CSE-ConnectionGUID: ZmzszRI5Q1+NU5LTSuXwVw==
X-CSE-MsgGUID: TYYHUkuwR6qMCeSJdL8rVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="169485283"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa008.jf.intel.com with ESMTP; 25 Aug 2025 06:23:21 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 4/4] thermal: intel: int340x: Add module parameter to change slider offset
Date: Mon, 25 Aug 2025 06:23:15 -0700
Message-ID: <20250825132315.75521-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825132315.75521-1-srinivas.pandruvada@linux.intel.com>
References: <20250825132315.75521-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SoC slider value is set by the user (or the default when user has not
modified it). To enhance power efficiency dynamically, the firmware can
optionally auto-adjust the slider value based on the current workload.
This adjustment is governed by an additional parameter known as the
"slider offset". This offset permits the firmware to increase the slider
value up to and including "SoC slider + slider offset".

Add a module parameter to specify this "slier offset" value.

By default, the SoC slider offset is set to 0. This means that SoC is not
allowed to switch slider position.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- Edit description and add comment in the code for the slider_offset

 .../processor_thermal_soc_slider.c            | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
index 393ce5246447..0d79f6a8cb50 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
@@ -90,6 +90,47 @@ static const struct kernel_param_ops slider_def_balance_ops = {
 module_param_cb(slider_balance, &slider_def_balance_ops, NULL, 0644);
 MODULE_PARM_DESC(slider_balance, "Set slider default value for balance.");
 
+static u8 slider_offset;
+
+static int slider_def_offset_set(const char *arg, const struct kernel_param *kp)
+{
+	u8 offset;
+	int ret;
+
+	guard(mutex)(&slider_param_lock);
+
+	ret = kstrtou8(arg, 16, &offset);
+	if (!ret) {
+		if (offset > SOC_SLIDER_VALUE_MAXIMUM)
+			return -EINVAL;
+
+		slider_offset = offset;
+	}
+
+	return ret;
+}
+
+static int slider_def_offset_get(char *buf, const struct kernel_param *kp)
+{
+	guard(mutex)(&slider_param_lock);
+	return sysfs_emit(buf, "%02x\n", slider_offset);
+}
+
+static const struct kernel_param_ops slider_offset_ops = {
+	.set = slider_def_offset_set,
+	.get = slider_def_offset_get,
+};
+
+/*
+ * To enhance power efficiency dynamically, the firmware can optionally
+ * auto-adjust the slider value based on the current workload. This
+ * adjustment is controller by the "slider_offset" module parameter.
+ * This offset permits the firmware to increase the slider value
+ * up to and including "SoC slider + slider offset,".
+ */
+module_param_cb(slider_offset, &slider_offset_ops, NULL, 0644);
+MODULE_PARM_DESC(slider_offset, "Set slider offset.");
+
 /* Convert from platform power profile option to SoC slider value */
 static int convert_profile_to_power_slider(enum platform_profile_option profile)
 {
@@ -130,6 +171,8 @@ static inline void write_soc_slider(struct proc_thermal_device *proc_priv, u64 v
 	writeq(val, proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
 }
 
+#define SLIDER_OFFSET_MASK	GENMASK_ULL(6, 4)
+
 static void set_soc_power_profile(struct proc_thermal_device *proc_priv, int slider)
 {
 	u64 val;
@@ -137,6 +180,11 @@ static void set_soc_power_profile(struct proc_thermal_device *proc_priv, int sli
 	val = read_soc_slider(proc_priv);
 	val &= ~SLIDER_MASK;
 	val |= (FIELD_PREP(SLIDER_MASK, slider) | BIT(SLIDER_ENABLE_BIT));
+
+	/* Set the slider offset from module params */
+	val &= ~SLIDER_OFFSET_MASK;
+	val |= FIELD_PREP(SLIDER_OFFSET_MASK, slider_offset);
+
 	write_soc_slider(proc_priv, val);
 }
 
-- 
2.43.0


