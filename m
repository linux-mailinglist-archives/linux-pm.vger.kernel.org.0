Return-Path: <linux-pm+bounces-32352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC4B2536A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 20:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3642D1668E8
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 18:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6574307497;
	Wed, 13 Aug 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ak68hFxT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28153305E00;
	Wed, 13 Aug 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111339; cv=none; b=o8DaetAPqcniXMxgItv01zIIJeDxD4YDUuTB3pzD5oAjGo+0FWqwGCKA5OEFnSUvC2goZ5CKxxeQbqq6tvpLu0dlf9M/0MhSqQo1xKJvaFT8C1yYdeKZEk6sEO7jsCJW838AoNVk0tH4ohwlHXE/AM8my6vRam2w1XfuuvyMlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111339; c=relaxed/simple;
	bh=MBe+Me2In0xIgcB1VyXX+jo+JmDp0MlroPhu3l7p6Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcixS86WISaoxvF0AtJwMf2YXOjZAIULOy5SD9DhFOEJFdZnSYnK+HTm+FPFy/AKxGpjx1I+l9uCQLjkQoZc4bvGINmOOEji6Es0MyVFBhX5H0Wusn2/+2SSkyfo4HajeUa/bPq7Ttk03Q3DQdr64mTQDfpcTvjUxSfrpVA2TSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ak68hFxT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755111338; x=1786647338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MBe+Me2In0xIgcB1VyXX+jo+JmDp0MlroPhu3l7p6Og=;
  b=Ak68hFxTr0HKHAdADAKVb6+2rgEBSJ5ho+PyyoyPZpX2Y5ms89a88Zct
   taaUJ7NQpapFbeu7zFnBjh+6Gwh00pv9bCGXNmiS7zW3U+NEcyEi5zgJJ
   DTO2E3CEIixAofE3U6pEP6EhBXypB3QTwhtD2GmY1TEVDVww4aQWmFXHa
   qi0lEVZga3y79AsPSljTUv7vf9UX7kt67CiEFDw0LF+AiEaJ7CGMQogf+
   FQoJVL3lQtNHUoGPNUkMmkY3ux8OkaJ/c6NsEXq3OVMoruY3uPUzampR0
   0Xn3d02OuA6qHaky/1agIC3X5GLbkjD4nATqDwdR2pbbxs6H+y9Zoj6pV
   A==;
X-CSE-ConnectionGUID: wKwWvqTeQcWv2Si99tL5dA==
X-CSE-MsgGUID: nffhJCKEQPes+BGaqG9BOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56631244"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="56631244"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:55:35 -0700
X-CSE-ConnectionGUID: s9ZSUkHqS36Xev5UR4k4HA==
X-CSE-MsgGUID: WNYlSPPhQUeC+7PaHGe91w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170755039"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2025 11:55:35 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/5] thermal: intel: int340x: Add module parameter to change slider offset
Date: Wed, 13 Aug 2025 11:55:29 -0700
Message-ID: <20250813185530.635096-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com>
References: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The slider offset value allows the SoC to automatically switch slider
positions in range [SOC_SLIDER … (SOC_SLIDER + slider offset)] based on
internal algorithms to improve power efficiency.

By default, the SoC slider offset is set to 0. This means that SoC is not
allowed to switch slider position.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../processor_thermal_soc_slider.c            | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
index ffc538c9b9e3..bd4ff26a488b 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
@@ -87,6 +87,40 @@ static const struct kernel_param_ops slider_def_balance_ops = {
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
+module_param_cb(slider_offset, &slider_offset_ops, NULL, 0644);
+MODULE_PARM_DESC(slider_offset, "Set slider offset.");
+
 /* Convert from platform power profile option to SoC slider value */
 static int convert_profile_to_power_slider(enum platform_profile_option profile)
 {
@@ -120,6 +154,8 @@ static int convert_power_slider_to_profile(u8 slider)
 #define SLIDER_MASK		GENMASK_ULL(2, 0)
 #define SLIDER_ENABLE_BIT	7
 
+#define SLIDER_OFFSET_MASK	GENMASK_ULL(6, 4)
+
 static void set_soc_power_profile(struct proc_thermal_device *proc_priv, int slider)
 {
 	u64 val;
@@ -128,6 +164,11 @@ static void set_soc_power_profile(struct proc_thermal_device *proc_priv, int sli
 	val &= ~SLIDER_MASK;
 	val |= FIELD_PREP(SLIDER_MASK, slider);
 	val |= BIT(SLIDER_ENABLE_BIT);
+
+	/* Set the slider offset from module params */
+	val &= ~SLIDER_OFFSET_MASK;
+	val |= FIELD_PREP(SLIDER_OFFSET_MASK, slider_offset);
+
 	writeq(val, proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
 }
 
-- 
2.43.0


