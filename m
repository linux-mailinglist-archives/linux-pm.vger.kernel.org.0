Return-Path: <linux-pm+bounces-37896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ED0C554E1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 02:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0F014E191B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 01:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC0B296BB7;
	Thu, 13 Nov 2025 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwva+Hir"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A7F2264CA;
	Thu, 13 Nov 2025 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998083; cv=none; b=dxtWrzvbsoaam5lW/Wm6hqL4FAUj9D6aVzZRj4+iwBKzPN+NhStIijN+tA4v/aWswoC0tBFbXpJZhXup91Q/LMyIZY+3vRSVufd1tbWWhhd1xc02ba8FM6fAQgvbZfl6/5lV4JWMbEeWiGSS5rNSlapU8q5NlJTEkYcDVAb/cAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998083; c=relaxed/simple;
	bh=SPIS5zJSAoavwXl0daXbgthoApNiCSmNvl8So/zRaX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sw/EZ3f+uRMf6lPlSK0p6503qhWNV0MolEfx6VAP7H2yPlG+Ay+2GWCOScBzXE8TukQjduNRAJoQyw2SgJwge0wGEUPRWQZsDMUJMCphMk3j2qwDDdKLxT4tmt9cB4hcLzjR7i7+MPOvcz/o1wUvYzLDSr3+RpXveziIFrZTyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwva+Hir; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762998081; x=1794534081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SPIS5zJSAoavwXl0daXbgthoApNiCSmNvl8So/zRaX0=;
  b=hwva+Hir3Bwp7WVLn4Oro3IlWAiqAmNVKVWSVh4cqb3xQcSUZGjFFYo7
   /Pqjlm/iRazarZsxy3NYC6NkRcRRdOgFHkEnuDcfPCfj/uk1b2u3E1pOA
   KvLLtr3Fi3zSB+qxoxXmMnpzRvJKKnK2Kx09OPWlR7KVdKUp3UwConAcc
   aXKUyQgTL/W+jIm0eILhuCJfBm9NVhz/INiTzCqwmiMCArT25UReYtNFE
   RRoxiiete7wSmym6oEMHUh9W2DuXBLuPjYriSypkdJnU/d9iN+ZDkfsBX
   wMdiOvLkT2udY+NB0opAgfmVuKIFj0MUu9SJ+2hrBx4/PBDj3a0DynV0E
   Q==;
X-CSE-ConnectionGUID: +0PjTJlWTJm1uhc9jwYalg==
X-CSE-MsgGUID: tNwQgqOESvyTj82QCsnuWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="52634728"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="52634728"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 17:41:20 -0800
X-CSE-ConnectionGUID: 1v3oDMBsS4CvtYHzowD35A==
X-CSE-MsgGUID: 3GrdR2jjTb66S5gACvs+nw==
X-ExtLoop1: 1
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa003.fm.intel.com with ESMTP; 12 Nov 2025 17:41:20 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: corbet@lwn.net,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Documentation: thermal: Add documentation for thermal throttle
Date: Wed, 12 Nov 2025 17:41:14 -0800
Message-ID: <20251113014116.196638-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation for Intel thermal throttling reporting events.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/thermal/index.rst   |  1 +
 .../admin-guide/thermal/thermal_throttle.rst  | 84 +++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/admin-guide/thermal/thermal_throttle.rst

diff --git a/Documentation/admin-guide/thermal/index.rst b/Documentation/admin-guide/thermal/index.rst
index 193b7b01a87d..2e0cafd19f6b 100644
--- a/Documentation/admin-guide/thermal/index.rst
+++ b/Documentation/admin-guide/thermal/index.rst
@@ -6,3 +6,4 @@ Thermal Subsystem
    :maxdepth: 1
 
    intel_powerclamp
+   thermal_throttle
diff --git a/Documentation/admin-guide/thermal/thermal_throttle.rst b/Documentation/admin-guide/thermal/thermal_throttle.rst
new file mode 100644
index 000000000000..ab146ffdffca
--- /dev/null
+++ b/Documentation/admin-guide/thermal/thermal_throttle.rst
@@ -0,0 +1,84 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+=======================================
+Intel thermal throttle events reporting
+=======================================
+
+:Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+
+Introduction
+------------
+
+Intel processors have built in automatic and adaptive thermal monitoring mechanisms
+that force the processor to reduce its power consumption in order to operate within
+predetermined temperature limits.
+
+Refer to section "THERMAL MONITORING AND PROTECTION" in the "Intel® 64 and IA-32
+Architectures Software Developer’s Manual Volume 3 (3A, 3B, 3C, & 3D): System
+Programming Guide" for more details.
+
+In general, there are two mechanisms to control the core temperature of the processor.
+They are called "Thermal Monitor 1 (TM1) and Thermal Monitor 2 (TM2)".
+
+The status of the temperature sensor that triggers the thermal monitor (TM1/TM2) is
+indicated through the "thermal status flag" and "thermal status log flag" in the
+IA32_THERM_STATUS MSR for core level and IA32_PACKAGE_THERM_STATUS for package level.
+
+Thermal Status flag, bit 0 — When set, indicates that the processor core temperature
+is currently at the trip temperature of the thermal monitor and that the processor power
+consumption is being reduced via either TM1 or TM2, depending on which is enabled. When
+clear, the flag indicates that the core temperature is below the thermal monitor trip
+temperature. This flag is read only.
+
+Thermal Status Log flag, bit 1 — When set, indicates that the thermal sensor has tripped
+since the last power-up or reset or since the last time that software cleared this flag.
+This flag is a sticky bit; once set it remains set until cleared by software or until a
+power-up or reset of the processor. The default state is clear.
+
+It is possible that when user reads IA32_THERM_STATUS or IA32_PACKAGE_THERM_STATUS,
+TM1/TM2 is not active. In this case, "Thermal Status flag" will read "0" and the
+"Thermal Status Log flag" will be set to show any previous "TM1/TM2" activation. But
+since it needs to be cleared by software, it can't show the number of occurrences of
+"TM1/TM2" activations.
+
+Hence, Linux provides counters of how many times the "Thermal Status flag" was set. Also
+presents how long the "Thermal Status flag" was active in milliseconds. Using these counters,
+users can check if the performance was limited because of thermal events. It is recommended
+to read from sysfs instead of directly reading MSRs as the "Thermal Status Log flag" is reset
+by the driver to implement rate control.
+
+Sysfs Interface
+---------------
+
+Thermal throttling events are presented for each CPU under
+"/sys/devices/system/cpu/cpuX/thermal_throttle/", where "X" is the CPU number.
+
+All these counters are read-only. They can't be reset to 0. So, they can potentially
+overflow after reaching the maximum 64 bit unsigned integer.
+
+``core_throttle_count``
+	This shows how many times "Thermal Status flag" changed from 0 to 1
+	for this CPU. This is a 64 bit counter.
+
+``package_throttle_count``
+	This shows how many times "Thermal Status flag" changed from 0 to 1
+	for this package. Package status is broadcast to all CPUs; all CPUs in
+	the package increment this count. This is a 64-bit counter.
+
+``core_throttle_max_time_ms``
+	This shows the maximum amount of time "Thermal Status flag" was set to 1
+	for this CPU for core level flag.
+
+``package_throttle_max_time_ms``
+	This shows the maximum amount of time "Thermal Status flag" was set to 1
+	for this CPU for package level flag.
+
+``core_throttle_total_time_ms``
+	This shows the cumulative time "Thermal Status flag" was set to 1 for this
+	CPU for core level flag.
+
+``package_throttle_total_time_ms``
+	This shows the cumulative time "Thermal Status flag" was set to 1 for this
+	CPU for package level flag.
+
-- 
2.43.0


