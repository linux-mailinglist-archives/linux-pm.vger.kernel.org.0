Return-Path: <linux-pm+bounces-37053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388DEC1BC95
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72081A20437
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3865F340A67;
	Wed, 29 Oct 2025 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATVHmilc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC30340293
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752737; cv=none; b=dXSbZ0FuwiQ2+lruAhGvWYBapRvBUPvLz1m28yEOVMFZGGQ1Q7Z9ovmsfIvMqGzJGb1HcktFg2DMcpNl7hufLcAmWGWq4hIDXZ9216GURChjMtKs6/6hzb2+kaebz7S5D+x7x3XjyxwaboWLV9QXfHNY8fab1TBJPi5qdFvHCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752737; c=relaxed/simple;
	bh=9/YcU/8GwsRCOq3tKl8GFSswbNX7HfyC5Qz6W/imyGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KCG6ghTHhzDEtbQScflaTXHhCVM6E2xXhV+tPmaqZpuGMx0VixiJZtOhTp8lbTtbuwKv9uFM/dKZCiMjm2QfwrqCGcQxqXWt3Gf70NhAO6qkOVZRjd7F6MuXHSu4KKkx4aL61awfaENvcL7AxgyFUf2QSMCJENeMF3J/Sq3Pw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATVHmilc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761752735; x=1793288735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9/YcU/8GwsRCOq3tKl8GFSswbNX7HfyC5Qz6W/imyGI=;
  b=ATVHmilcfGXZDUOWzD0OEqie+/EWuFtgMfQb7MRdofoFZs4my9OztK5d
   SdvY9mmEkgBCU9HYT/n4aemy80DtmkKZ9T6Ct57Q+ZzHvUE6/FolbhRCY
   VLx7vyZ35JViIma7Jloqx5d7+NqWE/X11JJvwbsdoiCBvczJMGtuPZOSn
   SMvjtwRTsQXYrBfM2dR/pry6jX8s4qYb3YfHM7m5HUL3zOtDRceVMo9IS
   oh2e33t5TI16KXj9e3GF4yiPonsuJ86vDKwUnFq9068iJI1z8wPFDBzbi
   s77V4H/75zpyDD9wX/2g5lKxYZMNMju3DQeRkqs3LaMabPUxSOpk3V9o2
   A==;
X-CSE-ConnectionGUID: oExr3BsGSymvlXT2tyF6/g==
X-CSE-MsgGUID: 71T0PjcgSRO2GHtEyt4Ynw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74167570"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="74167570"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:45:34 -0700
X-CSE-ConnectionGUID: hLwZEUr4RH2pbY0eDvywDw==
X-CSE-MsgGUID: olN6pmyZQQ23KBsvSiVU8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="185397676"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa007.fm.intel.com with ESMTP; 29 Oct 2025 08:45:32 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	tony.luck@intel.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v3] ACPI: mrrm: Fix memory leaks and improve error handling
Date: Wed, 29 Oct 2025 21:13:29 +0530
Message-Id: <20251029154329.3939680-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add proper error handling and resource cleanup to prevent memory leaks
in add_boot_memory_ranges(). The function now checks for NULL return
from kobject_create_and_add(), uses local buffer for range names to
avoid dynamic allocation, and implements a cleanup path that removes
previously created sysfs groups and kobjects on failure.

This prevents resource leaks when kobject creation or sysfs group
creation fails during boot memory range initialization.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v3:
- Fix memory leak in success path by adding kfree(kobjs) before
  return.
Changes in v2:
- Use local buffer for range names instead of kasprintf/kfree as
  suggested in review.

 drivers/acpi/acpi_mrrm.c | 43 ++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index 47ea3ccc2142..a554f6443b4b 100644
--- a/drivers/acpi/acpi_mrrm.c
+++ b/drivers/acpi/acpi_mrrm.c
@@ -149,26 +149,49 @@ ATTRIBUTE_GROUPS(memory_range);
 
 static __init int add_boot_memory_ranges(void)
 {
-	struct kobject *pkobj, *kobj;
+	struct kobject *pkobj, *kobj, **kobjs;
 	int ret = -EINVAL;
-	char *name;
+	char name[16];
+	int i;
 
 	pkobj = kobject_create_and_add("memory_ranges", acpi_kobj);
+	if (!pkobj)
+		return -ENOMEM;
 
-	for (int i = 0; i < mrrm_mem_entry_num; i++) {
-		name = kasprintf(GFP_KERNEL, "range%d", i);
-		if (!name) {
-			ret = -ENOMEM;
-			break;
-		}
+	kobjs = kcalloc(mrrm_mem_entry_num, sizeof(*kobjs), GFP_KERNEL);
+	if (!kobjs) {
+		kobject_put(pkobj);
+		return -ENOMEM;
+	}
 
+	for (i = 0; i < mrrm_mem_entry_num; i++) {
+		snprintf(name, sizeof(name), "range%d", i);
 		kobj = kobject_create_and_add(name, pkobj);
+		if (!kobj) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
 
 		ret = sysfs_create_groups(kobj, memory_range_groups);
-		if (ret)
-			return ret;
+		if (ret) {
+			kobject_put(kobj);
+			goto cleanup;
+		}
+		kobjs[i] = kobj;
 	}
 
+	kfree(kobjs);
+	return 0;
+
+cleanup:
+	for (int j = 0; j < i; j++) {
+		if (kobjs[j]) {
+			sysfs_remove_groups(kobjs[j], memory_range_groups);
+			kobject_put(kobjs[j]);
+		}
+	}
+	kfree(kobjs);
+	kobject_put(pkobj);
 	return ret;
 }
 
-- 
2.34.1


