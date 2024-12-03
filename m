Return-Path: <linux-pm+bounces-18419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8829E1561
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CD2B23B8B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024321E0499;
	Tue,  3 Dec 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uu+yYS4S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A72319CCF9;
	Tue,  3 Dec 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212686; cv=none; b=UN0gvC3lYh9SGBmqx0ewBGUimEbAQRUYBTWOn0Tqxw9DW83OigxTMv3/5xgmEKPjUWrW6kdsoHOUSFAlbGpspzym2fsYPWcQgYLKZBAH4WRk3D7YWSP5L/KU+oLr6vSrvseKnsSjVtxMKsepKlE+4AWYZbm4MhEFlmxp7G9rY2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212686; c=relaxed/simple;
	bh=QXDy5IjLLk2Mod7vhumHaQqfStgg1w95tN0WENVgpsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHtENlxUD4pGtBwA+U0QMyGZkqKyg7bQFe1kz+G9MOhJ4TtgOknz1MTAExrFnEHeOPIvLI5QboiL7ZJP+03Zrdq7hDrK/tXb4OEQnBUXg8wVs9dS9vgrbjFGyfyy5mHYXQ8jd+Groqn56pVyMrJJP5QHEK4w4ZrZZFT0zP9q9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uu+yYS4S; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733212685; x=1764748685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QXDy5IjLLk2Mod7vhumHaQqfStgg1w95tN0WENVgpsI=;
  b=Uu+yYS4S0oW7iXcgKG2IS3MoefrEc54I5YeclS10NgXVvVRo7/IxWLNm
   lD/JpZm30hcTYcBCrTywwheuwHR+Ad34zmZWOJtvzHyBMqTwnYTpYBW3I
   d7tHR33Fzh520iNcjhfdpXjOJ4IDupkLgC1FV3wxA8cbtbhK/yeFo19Aa
   dIdnVXT/098BFhvzpP/3tjJUOfQIBKS4e4KGV+gCSVnbQIGLNqHzk/QBt
   rFddAw1QoKeImWsdYrZtFDVBzZUhYhQ4b015LjNLF72SFX9Y9O28zulBv
   QWOEEncO15o7PcJcLyzXlcN7wPSjIhqmP96IHctrzwEFY3GGd0Y8FcB5A
   g==;
X-CSE-ConnectionGUID: 9OSyNrOPQUueSNRp3MRieg==
X-CSE-MsgGUID: wHFBUcF5QYqd3cJ1aBl4ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32758209"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="32758209"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:58:05 -0800
X-CSE-ConnectionGUID: ynGyqaoJRAe9xXYFdZy6+Q==
X-CSE-MsgGUID: 6truSVWUR0mYamNP+jgYsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93759614"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa007.jf.intel.com with ESMTP; 02 Dec 2024 23:58:03 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH 3/3] ACPI: DPTF: Support Panther Lake
Date: Tue,  3 Dec 2024 15:58:02 +0800
Message-ID: <20241203075802.584741-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203075802.584741-1-rui.zhang@intel.com>
References: <20241203075802.584741-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Panther Lake ACPI IDs for DPTF devices.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c                       | 1 +
 drivers/acpi/dptf/dptf_power.c                          | 2 ++
 drivers/acpi/dptf/int340x_thermal.c                     | 6 ++++++
 drivers/acpi/fan.h                                      | 1 +
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
 6 files changed, 12 insertions(+)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 624fce67ce43..952216c67d58 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -152,6 +152,7 @@ static const struct acpi_device_id pch_fivr_device_ids[] = {
 	{"INTC1064", 0},
 	{"INTC106B", 0},
 	{"INTC10A3", 0},
+	{"INTC10D7", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, pch_fivr_device_ids);
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index 3d3edd81b172..e8caf4106ff9 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -236,6 +236,8 @@ static const struct acpi_device_id int3407_device_ids[] = {
 	{"INTC106D", 0},
 	{"INTC10A4", 0},
 	{"INTC10A5", 0},
+	{"INTC10D8", 0},
+	{"INTC10D9", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 014ada759954..aef7aca2161d 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -55,6 +55,12 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INTC10A3"},
 	{"INTC10A4"},
 	{"INTC10A5"},
+	{"INTC10D4"},
+	{"INTC10D5"},
+	{"INTC10D6"},
+	{"INTC10D7"},
+	{"INTC10D8"},
+	{"INTC10D9"},
 	{""},
 };
 
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index db25a3898af7..488b51e2cb31 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -19,6 +19,7 @@
 	{"INTC1063", }, /* Fan for Meteor Lake generation */ \
 	{"INTC106A", }, /* Fan for Lunar Lake generation */ \
 	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
+	{"INTC10D6", }, /* Fan for Panther Lake generation */ \
 	{"PNP0C0B", } /* Generic ACPI fan */
 
 #define ACPI_FPS_NAME_LEN	20
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 8660ef2175be..5805e08d71be 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -690,6 +690,7 @@ static const struct acpi_device_id int3400_thermal_match[] = {
 	{"INTC1042", 0},
 	{"INTC1068", 0},
 	{"INTC10A0", 0},
+	{"INTC10D4", 0},
 	{}
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index 04aa0afb3b1d..5a925a8df7b3 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -275,6 +275,7 @@ static const struct acpi_device_id int3403_device_ids[] = {
 	{"INTC1062", 0},
 	{"INTC1069", 0},
 	{"INTC10A1", 0},
+	{"INTC10D5", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
-- 
2.43.0


