Return-Path: <linux-pm+bounces-37999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DA8C5A170
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 22:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A1794E329E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 21:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6A22857C7;
	Thu, 13 Nov 2025 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXRsIDk2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD498524F;
	Thu, 13 Nov 2025 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763068870; cv=none; b=H3+SRv+uaK7Vnsk1Xng9yonBxI7w5kZ6GEjf72DG0K9DzooLiyFWHdk71m27qpduNKF/uwn2PcP8stGmBqv6Bljken7KXDATGlc20HUVh8bcWxCm8h28VuYR7xCbdlYADRVHrD6Tm+FC/4Vxox6sxSF0dTLUT97sx7CWS75K2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763068870; c=relaxed/simple;
	bh=C1w93ekD8kX9qnwcLmEaoPXK5ZLfaJFaiiWBsIgqqaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MgQEeUZBa20mdHiZ9HWnhG2t2utYKT7vCjTHZJr5EPdSZ/GCIk/YhNATOehd2HtnVzhvZ+KVng7c8KSQiceZm903B6iXWthIZn2TkloQKkOR7nTdASEW6U6ytgCOfrwEAB8B7kfhQvh4ZPSgZKuAev1EbyRsA4QW4MQhi3SoZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXRsIDk2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763068868; x=1794604868;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C1w93ekD8kX9qnwcLmEaoPXK5ZLfaJFaiiWBsIgqqaI=;
  b=RXRsIDk2meVolsq0qXk85kTbMUM0nEZZtAV7FoUgJBFahqucrO0egx4F
   98qBNYa6FzmtVnyFixg0QjNZ+iV+m62Cu1WDd1+Z8uN9R4B1lDzCIc8l0
   qVbxTt2JFu/3vVVN1XzrPm+/sfaBYRYxvnuT+j0GtZiLNYnh4IMXK/HLL
   OMcgBMWDBcKRhaL9vTtefE6sNzqUXHNbW4oocODI6cOSHpXN8wRBx3gnA
   lZta4WNmX/Mhgvr0TWKwGlmoI9nlmXBvx4xYz5clmuGqNdteNe039Q+Xp
   n9jdZc3o7SKSrIpctiTn3voxR0JirtOwbJbNxJVUAvxBi1wB0Lz0J4jik
   g==;
X-CSE-ConnectionGUID: htCf67XlSoia0VOhwkwyXA==
X-CSE-MsgGUID: G8WcwPSYTcmbwxuRHm2P6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="68790049"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="68790049"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 13:21:06 -0800
X-CSE-ConnectionGUID: F3rThVyfRzW4pMkNS6dZNQ==
X-CSE-MsgGUID: ixI9dPwMRpaDHfFIYL2ibQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="189243060"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa007.fm.intel.com with ESMTP; 13 Nov 2025 13:21:06 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: corbet@lwn.net,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] Documentation: thermal: Add documentation for thermal throttle
Date: Thu, 13 Nov 2025 13:21:03 -0800
Message-ID: <20251113212104.221632-1-srinivas.pandruvada@linux.intel.com>
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
v2:
 - Addressed comments from Rafael
 - Limit line lengths ~80 columns

 Documentation/admin-guide/thermal/index.rst   |  1 +
 .../admin-guide/thermal/thermal_throttle.rst  | 92 +++++++++++++++++++
 2 files changed, 93 insertions(+)
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
index 000000000000..cac2bc3176ce
--- /dev/null
+++ b/Documentation/admin-guide/thermal/thermal_throttle.rst
@@ -0,0 +1,92 @@
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
+Intel processors have built in automatic and adaptive thermal monitoring
+mechanisms that force the processor to reduce its power consumption in order
+to operate within predetermined temperature limits.
+
+Refer to section "THERMAL MONITORING AND PROTECTION" in the "Intel® 64 and
+IA-32 Architectures Software Developer’s Manual Volume 3 (3A, 3B, 3C, & 3D):
+System Programming Guide" for more details.
+
+In general, there are two mechanisms to control the core temperature of the
+processor. They are called "Thermal Monitor 1 (TM1) and Thermal Monitor 2 (TM2)".
+
+The status of the temperature sensor that triggers the thermal monitor (TM1/TM2)
+is indicated through the "thermal status flag" and "thermal status log flag" in
+the MSR_IA32_THERM_STATUS for core level and MSR_IA32_PACKAGE_THERM_STATUS for
+package level.
+
+Thermal Status flag, bit 0 — When set, indicates that the processor core
+temperature is currently at the trip temperature of the thermal monitor and that
+the processor power consumption is being reduced via either TM1 or TM2, depending
+on which is enabled. When clear, the flag indicates that the core temperature is
+below the thermal monitor trip temperature. This flag is read only.
+
+Thermal Status Log flag, bit 1 — When set, indicates that the thermal sensor has
+tripped since the last power-up or reset or since the last time that software
+cleared this flag. This flag is a sticky bit; once set it remains set until
+cleared by software or until a power-up or reset of the processor. The default
+state is clear.
+
+It is possible that when user reads MSR_IA32_THERM_STATUS or
+MSR_IA32_PACKAGE_THERM_STATUS, TM1/TM2 is not active. In this case,
+"Thermal Status flag" will read "0" and the "Thermal Status Log flag" will be set
+to show any previous "TM1/TM2" activation. But since it needs to be cleared by
+the software, it can't show the number of occurrences of "TM1/TM2" activations.
+
+Hence, Linux provides counters of how many times the "Thermal Status flag" was
+set. Also presents how long the "Thermal Status flag" was active in milliseconds.
+Using these counters, users can check if the performance was limited because of
+thermal events. It is recommended to read from sysfs instead of directly reading
+MSRs as the "Thermal Status Log flag" is reset by the driver to implement rate
+control.
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
+	This shows number of times "Thermal Status flag" changed from 0 to 1 for this
+	CPU since OS boot and thermal vector is initialized. This is a 64 bit counter.
+
+``package_throttle_count``
+	This shows number of times "Thermal Status flag" changed from 0 to 1 for the
+	package containing this CPU since OS boot and thermal vector is initialized.
+	Package status is broadcast to all CPUs; all CPUs in the package increment
+	this count. This is a 64-bit counter.
+
+``core_throttle_max_time_ms``
+	This shows the maximum amount of time for which "Thermal Status flag"
+	has been set to 1 for this CPU at the core level since OS boot and thermal
+	vector is initialized.
+
+``package_throttle_max_time_ms``
+	This shows the maximum amount of time for which "Thermal Status flag"
+	has been set to 1 for the package containing this CPU since OS boot and
+	thermal vector is initialized.
+
+``core_throttle_total_time_ms``
+	This shows the cumulative time for which "Thermal Status flag" has been
+	set to 1 for this CPU for core level since OS boot and thermal vector
+	is initialized.
+
+``package_throttle_total_time_ms``
+	This shows the cumulative time for which "Thermal Status flag" has been set
+	to 1 for the package containing this CPU since OS boot and thermal vector is
+	initialized.
+
-- 
2.43.0


