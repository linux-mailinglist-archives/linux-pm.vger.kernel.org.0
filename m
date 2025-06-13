Return-Path: <linux-pm+bounces-28700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C8BAD979F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 23:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C097ACAF6
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 21:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49096265626;
	Fri, 13 Jun 2025 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4z/nB58"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104819D08F;
	Fri, 13 Jun 2025 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851367; cv=none; b=uOc+xq9IOaNUPUWvLY+YYhX0ibT65uqhvJD7XjMzx+ekx7YeL0PNnVXvnYALkQugqtspszZtJokEDqC/2QTGh+rhCOEgZA2LIGasTNJv/RPavTINE1ThxiK0IYIOMonFKKnGP2otJ88Nf+wldt6l/ktklLXPCGX9W1IjpDKKMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851367; c=relaxed/simple;
	bh=urs2hnsQJwCZzHIoPIJEarCIpXTJCaDwpM2e4xSJVyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/YI5d+Z9RnJzKJtXVTe/di+UmBJbwxUTRNX65MAiytOinmihEB00CTZIHlJlHTdLyjbYIcbD+b2NzMBJS0mRdeI4yGW9e3b1PfZTiDEAgLZnVGLxs4jhZgE1gOPJaf3iaar+z5PVC03cUm8KuKCxUVrf6TY4zis4j1sQqQPVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4z/nB58; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749851366; x=1781387366;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=urs2hnsQJwCZzHIoPIJEarCIpXTJCaDwpM2e4xSJVyc=;
  b=Q4z/nB5850L7JfUcljvc7U9zje6GZwdAc5uNn4lQjFNZaFEOMBL3pLsE
   VCqEj53vsDk1wQY3fS+qEqHuPeoqNYEsUjfYFQ7M3APM5IUOeFiBYvPlR
   ix7du1flNgLx061K6XxnQ3BNUuRwf2+ZTkfCQKz//3kxvmGXJDMAd9F1E
   f7O6ivXJW9Tyb/nUqkP6sCadnBsudo499D54oJcnbLTc+MW6mhT6DXSDG
   BP/Cb33iSsOe9/VHlf8AJFNGHIHDd/jODdonRkHRGyZ2roMp4DtE2Hn/I
   A1hBxHPDggKD0Dr+GJtf63ynkk0IGaOXP6ncYZYe2xhSYYzzcqA3g0N/8
   w==;
X-CSE-ConnectionGUID: BSKCO3aJTcKqNLp1E8BT8A==
X-CSE-MsgGUID: wbr7WKfuRI26ofq73j1wMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="69656422"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="69656422"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 14:49:25 -0700
X-CSE-ConnectionGUID: Zvo5RG4cQJKuN76Zzv4ItA==
X-CSE-MsgGUID: +AG4nj0NRtSGdenQ6e++oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="178822019"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa002.jf.intel.com with ESMTP; 13 Jun 2025 14:49:24 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/2] thermal: intel: int340x: Add throttling control interface to PTC
Date: Fri, 13 Jun 2025 14:49:22 -0700
Message-ID: <20250613214923.2910397-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware-based thermal temperature control loops may aggressively
throttle performance to prevent temperature overshoots relative to the
defined target temperature. This can negatively impact performance. User
space may prefer to prioritize performance, even if it results in
temperature overshoots with in acceptable range.

For example, user space might tolerate temperature overshoots when the
device is placed on a desk, as opposed to when it's on a lap. To
accommodate such scenarios, an optional attribute is provided to specify
a tolerance level for temperature overshoots while maintaining acceptable
performance.

Attribute:
thermal_tolerance: This attribute ranges from 0 to 7, where 0 represents
the most aggressive control to avoid any temperature overshoots, and 7
represents a more graceful approach, favoring performance even at the
expense of temperature overshoots.
Note: This level may not scale linearly. For example, a value of 3 does not
necessarily imply a 50% improvement in performance compared to a value of
0.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- Changed commit description
- Change "gain" to "thermal_tolerance" analogous to latency_tolerance.
- Dropped "min_performance" attribute for next patch set

 Documentation/driver-api/thermal/intel_dptf.rst          | 9 +++++++++
 .../intel/int340x_thermal/platform_temperature_control.c | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index ec5769accae0..c51ac793dc06 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -206,6 +206,15 @@ All these controls needs admin privilege to update.
 	Update a new temperature target in milli degree celsius for hardware to
 	use for the temperature control.
 
+``thermal_tolerance`` (RW)
+	This attribute ranges from 0 to 7, where 0 represents
+	the most aggressive control to avoid any temperature overshoots, and
+	7 represents a more graceful approach, favoring performance even at
+	the expense of temperature overshoots.
+	Note: This level may not scale linearly. For example, a value of 3 does
+	not necessarily imply a 50% improvement in performance compared to a
+	value of 0.
+
 Given that this is platform temperature control, it is expected that a
 single user-level manager owns and manages the controls. If multiple
 user-level software applications attempt to write different targets, it
diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
index 2d6504514893..7850e91a6e2c 100644
--- a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
+++ b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
@@ -49,7 +49,7 @@ struct mmio_reg {
 };
 
 #define MAX_ATTR_GROUP_NAME_LEN	32
-#define PTC_MAX_ATTRS		3
+#define PTC_MAX_ATTRS		4
 
 struct ptc_data {
 	u32 offset;
@@ -57,6 +57,7 @@ struct ptc_data {
 	struct attribute *ptc_attrs[PTC_MAX_ATTRS];
 	struct device_attribute temperature_target_attr;
 	struct device_attribute enable_attr;
+	struct device_attribute thermal_tolerance_attr;
 	char group_name[MAX_ATTR_GROUP_NAME_LEN];
 };
 
@@ -78,6 +79,7 @@ static u32 ptc_offsets[PTC_MAX_INSTANCES] = {0x5B20, 0x5B28, 0x5B30};
 static const char * const ptc_strings[] = {
 	"temperature_target",
 	"enable",
+	"thermal_tolerance",
 	NULL
 };
 
@@ -177,6 +179,8 @@ PTC_SHOW(temperature_target);
 PTC_STORE(temperature_target);
 PTC_SHOW(enable);
 PTC_STORE(enable);
+PTC_SHOW(thermal_tolerance);
+PTC_STORE(thermal_tolerance);
 
 #define ptc_init_attribute(_name)\
 	do {\
@@ -193,9 +197,11 @@ static int ptc_create_groups(struct pci_dev *pdev, int instance, struct ptc_data
 
 	ptc_init_attribute(temperature_target);
 	ptc_init_attribute(enable);
+	ptc_init_attribute(thermal_tolerance);
 
 	data->ptc_attrs[index++] = &data->temperature_target_attr.attr;
 	data->ptc_attrs[index++] = &data->enable_attr.attr;
+	data->ptc_attrs[index++] = &data->thermal_tolerance_attr.attr;
 	data->ptc_attrs[index] = NULL;
 
 	snprintf(data->group_name, MAX_ATTR_GROUP_NAME_LEN,
-- 
2.49.0


