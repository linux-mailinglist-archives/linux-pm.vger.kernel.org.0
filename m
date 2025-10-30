Return-Path: <linux-pm+bounces-37074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81589C1E23D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 03:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B40188529A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 02:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198C2329C5D;
	Thu, 30 Oct 2025 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9VWIasn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0923D29A
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791675; cv=none; b=PQCfDZyRudK0foI/tYBAofmbNJxUGiVXpmPxNL+TvqvLUvARThTYVk3OaIvk6J4nl2d7aOr9XQx+zQVDXiKdsoWpZCjaBFmYkJhh1q0ZOqKbQ/wPPZsdWlSks3PK/MmTFDiDbk/oIeubPG3YtWwuLUHrvDtOVE+lwQFGgy1TFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791675; c=relaxed/simple;
	bh=BC7Z7+re4D9O/XWYsaJl+D3V2Iv+clTNnSdGgt3z4sE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UvCLFGf5hKOpcpC4p4Q1+SsvoBl3UVtLjNiBK3Sp5csvaNHBN3+pVS+iCArjpITFisOl7fz4TDNV5YlbGZBe2z7I9EM1bCZ3nRrmrIVIqjTCvPQonH/G9gdHW+YrCPdGnwBgj0ik0PvI/b7+G7Bnrmlutq2k12WoU33B3Az7vpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9VWIasn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761791673; x=1793327673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BC7Z7+re4D9O/XWYsaJl+D3V2Iv+clTNnSdGgt3z4sE=;
  b=P9VWIasnghF1N46OIBflBeMHY/+JJYwcFWv8KGwZJ3J5eemaLm5LCpyQ
   YalmfeEbRdK5ZXD2eebV++6/J3Hx5saGPsp/JrxOsvvLErgxmEMqKa3OS
   dJkHm+ey/EvNNSzq4p3WrVS+fCKuly+pWmjYKHK66m6VdQtd0sCPw3jLE
   205HWPLGCDPe+7vIjlGZBo8QmkykEd0nsYbXUe5LloDRCLCjIT4i+Dn0P
   p5NucrtQyFg6ISsNvPnf5vrAwDxOKy1DRaqRTJAIDt25UUEz5DnhKPtnZ
   xQGdsayoeCtvzMdeQNWaRgjT1EgTeeqA2oNAxt9LJ34y4Yh5BjIubAip8
   A==;
X-CSE-ConnectionGUID: /+tRynzZTRuVvP3W0ULtgg==
X-CSE-MsgGUID: vqo8m3W2TwmYrRgTHVOwwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="67577848"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="67577848"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 19:34:32 -0700
X-CSE-ConnectionGUID: CT00S1g+SY+DJ+T4eDDNiw==
X-CSE-MsgGUID: Sj1UncHeQaa6KOu2HZQ+Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="186571202"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa010.fm.intel.com with ESMTP; 29 Oct 2025 19:34:31 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	tony.luck@intel.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v4] ACPI: mrrm: Fix memory leaks and improve error handling
Date: Thu, 30 Oct 2025 08:02:28 +0530
Message-Id: <20251030023228.3956296-1-kaushlendra.kumar@intel.com>
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
Changes in v4:
- Use scnprintf() instead of snprintf() for safer string formatting

Changes in v3:
- Fix memory leak in success path by adding kfree(kobjs) before
  return.

Changes in v2:
- Use local buffer for range names instead of kasprintf/kfree as
  suggested in review.
---
 drivers/acpi/acpi_mrrm.c | 43 ++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index 47ea3ccc2142..c0a5caeff2d7 100644
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
+		scnprintf(name, sizeof(name), "range%d", i);
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


