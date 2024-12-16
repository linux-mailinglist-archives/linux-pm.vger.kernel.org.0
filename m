Return-Path: <linux-pm+bounces-19337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8281C9F3979
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 20:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EA11885221
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 19:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8836D207DE4;
	Mon, 16 Dec 2024 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q08P3gqB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76A207A34;
	Mon, 16 Dec 2024 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376112; cv=none; b=RMwxEzWZ9eOYYSchs4/3Hjs7Pf52XJv95svrJzFqgOfP/K0Esh/S/OwVEVLXCVBakUAoG2hlS5LDoxRO3rafEfL2w0CTiffB7qr3RGEYPhNR7zU7sG+vKPIhqyLXQ9dEgUa0mJ58sKLy3pOnkRkbBvlUHKOSP5DQXblzgr68LJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376112; c=relaxed/simple;
	bh=nn5FWXRAuRiRSfeNuLuB8sDvu9E6paJwfSJ0W3BXrQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbqG7cvq3SfAgKSF4wJOCXHKgtLW9yX8Xr+fg044Zrxz3yXSzMcYIc30WXHqXECzVaPGM6INlGROxHKVo3xwZHUsrXeYTQtvGRBOtW6M5kHO6W7xhVSt4DiPFGql7ZACUU/fEGmmhqsF3bz4P+4jvTA0D7I6bmmDjuBKQUQ3Eg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q08P3gqB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734376110; x=1765912110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nn5FWXRAuRiRSfeNuLuB8sDvu9E6paJwfSJ0W3BXrQ8=;
  b=Q08P3gqBFxjjnN+Aof5i4YuPTwU3K5fZA9udAN23f0D1zW+faTlaMrd4
   tYouuP3ixZkxuDNdYCxglH8ZjsFOCJYAs89399nAAyobMeMydVPicYHJb
   n3K+AHpd/ghFpf/Cj2c0O5G90i7QUIcgSTzbxnFadlYQSPpFd7o5SjiKj
   ExtVjxDwOAq5iKcluFwaQjbhw5AifRM/FuyQLzPeZzgEjimXBgQMTasz0
   NM/aMGP39SkWO/nuy3G+9FpxmzkH5VWbRT9DvDtCquQZW2y6TMiLUl2AQ
   hYqUlQ7o8AGcI2Sk/qnAkOcqR/7lFZK/Zlm+TIkRbJAPchaeSXDChDziq
   g==;
X-CSE-ConnectionGUID: PrOAp8owS3ihL6Gpj9YkHw==
X-CSE-MsgGUID: u1rPjtriTkGTBaCZLeR9kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="22367896"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="22367896"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 11:08:30 -0800
X-CSE-ConnectionGUID: 6I9rQZ2rS8OfJlDWJGarrg==
X-CSE-MsgGUID: d134EUiXTdGbaqeGoApD6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97327568"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa006.jf.intel.com with ESMTP; 16 Dec 2024 11:08:30 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel: Remove explicit user_space governor selection
Date: Mon, 16 Dec 2024 11:08:21 -0800
Message-ID: <20241216190821.1137162-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently some user space programs like Linux thermald needs to register
to get notifications from both thermal user space governor and also
Thermal netlink. This is required as some messages like HFI (Hardware
Feedback Notifications) requires Thermal netlink.

This results in additional processing in kernel and user space to process
both notifications. The cost of using user space governor using
kobject_uevent is much higher as this is also used by other user space
daemons like udev daemon.

Do not select user_space thermal governor by default. If it is present
user space programs can always use this governor by writing to
"policy" attribute.

Instead from the kernel select THERMAL_NETLINK. Trip temperature
violation can be received by user space programs via thermal netlink
events:
THERMAL_GENL_EVENT_TZ_TRIP_UP
THERMAL_GENL_EVENT_TZ_TRIP_DOWN

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/Kconfig                                   | 2 +-
 drivers/thermal/intel/int340x_thermal/Kconfig                   | 2 +-
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c         | 1 -
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 1 -
 .../intel/int340x_thermal/processor_thermal_device_pci.c        | 1 -
 5 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index a31f2f32996a..9c0f66f9defc 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -22,7 +22,7 @@ config INTEL_TCC
 config X86_PKG_TEMP_THERMAL
 	tristate "X86 package temperature thermal driver"
 	depends on X86_THERMAL_VECTOR
-	select THERMAL_GOV_USER_SPACE
+	select THERMAL_NETLINK
 	select INTEL_TCC
 	default m
 	help
diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index e76b13e44d03..d9a74424c29d 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -6,7 +6,7 @@
 config INT340X_THERMAL
 	tristate "ACPI INT340X thermal drivers"
 	depends on X86_64 && ACPI && PCI
-	select THERMAL_GOV_USER_SPACE
+	select THERMAL_NETLINK
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
 	select ACPI_THERMAL_LIB
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 8660ef2175be..cbfae5b9668c 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -521,7 +521,6 @@ static struct thermal_zone_device_ops int3400_thermal_ops = {
 };
 
 static struct thermal_zone_params int3400_thermal_params = {
-	.governor_name = "user_space",
 	.no_hwmon = true,
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 31ed338eb83c..8dca6a6aceca 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -105,7 +105,6 @@ static int int340x_thermal_read_trips(struct acpi_device *zone_adev,
 }
 
 static struct thermal_zone_params int340x_thermal_params = {
-	.governor_name = "user_space",
 	.no_hwmon = true,
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index e8c0bb536862..b307889103d3 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -272,7 +272,6 @@ static const struct thermal_zone_device_ops tzone_ops = {
 };
 
 static struct thermal_zone_params tzone_params = {
-	.governor_name = "user_space",
 	.no_hwmon = true,
 };
 
-- 
2.47.1


