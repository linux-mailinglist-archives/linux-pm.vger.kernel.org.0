Return-Path: <linux-pm+bounces-32350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE433B25370
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 20:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3B71C84DF0
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 18:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9676305E1D;
	Wed, 13 Aug 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMfQ0cL7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F4302CB4;
	Wed, 13 Aug 2025 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111338; cv=none; b=BZqBREZ+7vLgpBuS6d96gchtdcBGY2jXXBwX+VMVRsRqaFM0nn4g+FWjIXPvSb9L94xdus39MDyIH2B/nomPtsU7rGLF8yJYkHq97qf1p6GP1KEW4hXfcJoXO4XqwmfbxsJNEOM8NRKoq7FuNyaJc/MHgXscaA0U72Upt/s/ym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111338; c=relaxed/simple;
	bh=U+yATFvwfv8aN0sM1IWxBAe3+5KrxXYsfjmovYr2liQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw6pVyJjwgpkS42B8X0oSYHUn0IRRLuYqf7SvEDzx6a5RreQuD5cORJiHCN1JWSti7OafTlCK23zX00TSJtur0E++Hh95F9paqASUpG8UdxejVrU1QXm31s77ZDNG8nO1/aZHgZwvW3KQA7CvqZUYk9tCQubye5wHaDZPuh56FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMfQ0cL7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755111337; x=1786647337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+yATFvwfv8aN0sM1IWxBAe3+5KrxXYsfjmovYr2liQ=;
  b=fMfQ0cL7XUhq4FSi55FfRR4T57j6MSxkxOTKOW+j6nbXHZ19zIu8MsEY
   2DbkPRWvI8kTeCSKKzzhh1aezkcuZXE3RPyzelwOrqb8e+uAmXEEqmpvx
   J/YApZdDUMBHhfw5DfUaT75E8Z410tdWFo2mBAbChN95lVs+jMm/1nluM
   mKs1xpOR2GvJCLNeXH/5FPnZPe0s6oN0J/d2A8KnlB1sinI/SOQD7VDI7
   uth8TYjeJWw+Il2yFL1XgE0+0w3d/doTBRw+7MroyCYMBsFuJFf/OLsMD
   SkiGREmllDouSZ+KqecmF7HQPHzY3t8/6K5skhFTsWLQGnxNOLb3hZhUz
   Q==;
X-CSE-ConnectionGUID: AdUCzdO8SjqAdPSD+SQgzQ==
X-CSE-MsgGUID: flVEW/94QhSYQDWgph+zZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56631240"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="56631240"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:55:35 -0700
X-CSE-ConnectionGUID: NfMtbdWKSyK/ytWVuMsruw==
X-CSE-MsgGUID: iu7KVGRdQh6NyxyBjWHjcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170755038"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2025 11:55:34 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/5] thermal: intel: int340x: Add module parameter for balanced Slider
Date: Wed, 13 Aug 2025 11:55:28 -0700
Message-ID: <20250813185530.635096-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com>
References: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, the SoC slider value for the "balanced" platform profile is
set to 3. A new module parameter is introduced to allow users to change
this default value. After modifying the module parameter, users must call
an update to the "profile" sysfs attribute for the change to take effect.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../processor_thermal_soc_slider.c            | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
index c492ee937dc7..ffc538c9b9e3 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
@@ -50,6 +50,43 @@ static u8 slider_values[] = {
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
@@ -106,6 +143,10 @@ static int power_slider_platform_profile_set(struct device *dev,
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


