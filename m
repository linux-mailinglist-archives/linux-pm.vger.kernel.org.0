Return-Path: <linux-pm+bounces-33022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E0B3409C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3A048644C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D672A275B1F;
	Mon, 25 Aug 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhNLFZty"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A019274B22;
	Mon, 25 Aug 2025 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128206; cv=none; b=P2KPhHp29VctlrRhTQ9MddNtGakt0KbpqQyXZm/5PDiN++rbDPoahLDaLPi29Kc6d1DzY7yonB10q/XhRXTCGE6G4Mw0V3kAAbgTXkWxjricKu5Ae8QH0V+AI6DfvNw7++OXYMMHoiS3nK87vFgE6lmib41RUyDqA2ru5ZJ5LVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128206; c=relaxed/simple;
	bh=Zmq65eKiHaG1U4j+hmAYUkDFGLE9ww0rzKllwMKYnHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4bRqyaYuQKCyCryuL69uQ1kSmc7/t6AZTxfOm+RlVP4UAovPAXyGVdwPNkb7fjpzBbuHwEx0Ha3DxRXd5SmfRvmbfvNFsZFVJDPGuSDNHpJdYIiKOnuzht+6ug4M4CjJUKlP9DnKJFGZ3L26yskzy76f1tVQhtzj5OdKF4MbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhNLFZty; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756128205; x=1787664205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zmq65eKiHaG1U4j+hmAYUkDFGLE9ww0rzKllwMKYnHE=;
  b=EhNLFZty1j8JWoh6I8ssIxiD5HxxRseUe9kqD0oHSP2pyrrkZil0LqX5
   LW+a88DINfX1KLVyNOYAaMteF4U7E+8yKuSJGcL4QbbqdIr4FMAgIwszj
   FV3d2HMe3b5ivIfbab7YcMB8S2MiMdqA/keVF0jUhrnqCEkHGHAAfBqPw
   dDc10B6dcP6fZk2bjJyyqCjQczV1yN1QoBaHYYX0lvD4fsoQNDykQSDck
   fuxaqaiUSTYWUA0QoWJzU9Zkgr1KsqfMCHIZ+fIHte7w5f2LgtWmIDMJT
   T5jec3roPEYzW+yn4oHH6EpuAoNDY3/jQqNfOxJmKYhAD4k5ciBoItlu2
   A==;
X-CSE-ConnectionGUID: xO1efpQKSPyKBg0mjAE5dg==
X-CSE-MsgGUID: HDwPs2flTMuPI6nWZvejqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58048405"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="58048405"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:23:21 -0700
X-CSE-ConnectionGUID: asJ8o4JfRFC07wtZgVX4/Q==
X-CSE-MsgGUID: uFc/+FGqQV+zTpFIkbPCsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="169485280"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa008.jf.intel.com with ESMTP; 25 Aug 2025 06:23:21 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/4] thermal: intel: int340x: Add module parameter for balanced Slider
Date: Mon, 25 Aug 2025 06:23:14 -0700
Message-ID: <20250825132315.75521-4-srinivas.pandruvada@linux.intel.com>
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

By default, the SoC slider value for the "balanced" platform profile is
set to 3. This update introduces a new module parameter, allowing users
to modify this default value.

The module parameter can be specified during load time to set a custom
slider value for the "balanced" profile. If the module parameter is not
specified at load time and is updated later, the new value will only take
effect after the next write of "balanced" to the sysfs "profile"
attribute.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- Edit description to be more clear

 .../processor_thermal_soc_slider.c            | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
index 3225cb38588c..393ce5246447 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
@@ -53,6 +53,43 @@ static u8 slider_values[] = {
 	[SOC_POWER_SLIDER_POWERSAVE] = SOC_SLIDER_VALUE_MAXIMUM,
 };
 
+/* Lock to protect module param updates */
+static DEFINE_MUTEX(slider_param_lock);
+
+static int slider_balanced_param = SOC_SLIDER_VALUE_BALANCE;
+
+static int slider_def_balance_set(const char *arg, const struct kernel_param *kp)
+{
+	u8 slider_val;
+	int ret;
+
+	guard(mutex)(&slider_param_lock);
+
+	ret = kstrtou8(arg, 16, &slider_val);
+	if (!ret) {
+		if (slider_val > SOC_SLIDER_VALUE_MAXIMUM)
+			return -EINVAL;
+
+		slider_balanced_param = slider_val;
+	}
+
+	return ret;
+}
+
+static int slider_def_balance_get(char *buf, const struct kernel_param *kp)
+{
+	guard(mutex)(&slider_param_lock);
+	return sysfs_emit(buf, "%02x\n", slider_values[SOC_POWER_SLIDER_BALANCE]);
+}
+
+static const struct kernel_param_ops slider_def_balance_ops = {
+	.set = slider_def_balance_set,
+	.get = slider_def_balance_get,
+};
+
+module_param_cb(slider_balance, &slider_def_balance_ops, NULL, 0644);
+MODULE_PARM_DESC(slider_balance, "Set slider default value for balance.");
+
 /* Convert from platform power profile option to SoC slider value */
 static int convert_profile_to_power_slider(enum platform_profile_option profile)
 {
@@ -115,6 +152,10 @@ static int power_slider_platform_profile_set(struct device *dev,
 	if (!proc_priv)
 		return -EOPNOTSUPP;
 
+	guard(mutex)(&slider_param_lock);
+
+	slider_values[SOC_POWER_SLIDER_BALANCE] = slider_balanced_param;
+
 	slider = convert_profile_to_power_slider(profile);
 	if (slider < 0)
 		return slider;
-- 
2.43.0


