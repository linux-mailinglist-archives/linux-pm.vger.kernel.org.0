Return-Path: <linux-pm+bounces-37017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C264DC19577
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 10:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FFC3A992E
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AF330C36F;
	Wed, 29 Oct 2025 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxfJYcIX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D2311C31
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729140; cv=none; b=DBCIHuHv3G9JwWo9aumGyYdWAe7xKXPMMe7/aT3IKTewFdzUPbmSQB37LL6s+fA6Vulbftyt72Ec58xE/5AQUGSTZyjaTdyOeln+uJkAKA1ED7uIsZsOGROKnauMpRL2KKIFdBzG7vyI68J4znhiImVLwdJEyEC8+/gQvaZFJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729140; c=relaxed/simple;
	bh=bZM1T2863m95Uq1lGMLn+WQPp0J9g+mpfvrBhtYAkyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nh4dQt69PF2YetwncDPP0AtT6GXlQ+U7GVJ+1SxE20hZ4uUUFpBsLTZD0nAq4dO7S82hFDbtULq0oiNWyAiP0N2+k02r0xyh+7ZjC1DFoVSSloatRVOrE85Y6OutRv3rsMxcidHMBJhPG6SUcHn2oGQg5KrsyMCu+5cPoVUwlaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxfJYcIX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761729138; x=1793265138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bZM1T2863m95Uq1lGMLn+WQPp0J9g+mpfvrBhtYAkyI=;
  b=XxfJYcIXE1zbUmf6dWBDxSSKKOBswp9THdHkrsFTpame27OanSI7MoEv
   h/1spOHuHMeAgz+kcPAmLCanC7c7aRX26fBBaOlsomVj496SCnHSsSaIM
   51fsJ+p2tdR4O5feRFweK1T8CwgaW/e4wJBL5NsVz4+GNO62uENBANMaj
   SJ/g0cgLgC+/yU9t33j3VI0RqsXPeig65WHZD1t/oDwW0BtDjT1vv3HiE
   uxoGZS5URqDHxg9Gh6zcSGV07BwZ4VLI68/fg1pP2YGbojzmPsBW0JZ4t
   K1y7b14SPbhFjBsHLLN3S/wa6vWfBcB3dwvD6ANZKxrVkpiF1D5un83y+
   Q==;
X-CSE-ConnectionGUID: des91t3MRDmpReluhmc5Gg==
X-CSE-MsgGUID: WcRFqcDPSliZ6JKwDO2FrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62872605"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="62872605"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 02:12:17 -0700
X-CSE-ConnectionGUID: 6CtQoMkwS6Sy4DFXYAd1qQ==
X-CSE-MsgGUID: aftcZYyeTIOSj5SFNdx3VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185487680"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2025 02:12:16 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	tony.luck@intel.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] ACPI: mrrm: Fix memory leaks and improve error handling
Date: Wed, 29 Oct 2025 14:40:13 +0530
Message-Id: <20251029091013.3682552-1-kaushlendra.kumar@intel.com>
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
Changes in v2:
- Use local buffer for range names instead of kasprintf/kfree as
  suggested in review.

 drivers/acpi/acpi_mrrm.c | 42 ++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index 47ea3ccc2142..1718a35a5f56 100644
--- a/drivers/acpi/acpi_mrrm.c
+++ b/drivers/acpi/acpi_mrrm.c
@@ -149,26 +149,48 @@ ATTRIBUTE_GROUPS(memory_range);
 
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


