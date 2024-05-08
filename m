Return-Path: <linux-pm+bounces-7620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A48BF504
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 05:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE211C237C9
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 03:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C819617BCC;
	Wed,  8 May 2024 03:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWP4irtH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49371171A2;
	Wed,  8 May 2024 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715139426; cv=none; b=ElKtybpoMkxXBgc2qUjlKgxaIbbJss5qFJS7E5tMUyg5zSfNVI0zwqIaBu9iymor7m0k++ik1LnDWVzWnSHll5bhSLLYAPF8I7z5c1ioLWX04ihQ6Yu3uzSAg4caAuLVVBMtftNRflu9FUH6icSrakLEhFs4hhVm/Hmct3ypKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715139426; c=relaxed/simple;
	bh=VX4j3o8PuAumvX98LolK5x0BnWOyxYhPrqsi65acJqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=H7QvClJp8UNtN9vRWX0Jkl8cWXZUAoklY5vEf7YZvkbqqi8A/D9o3rrYKoGzr6rL/7jd9R3In30qweLzcgXSh0dB4I6bjY69TE+vcZdqg9rn22OyaNbOFkIe1gtghY40lwitE3NC5YphznfDKa956cV7x64ZqtvkgyK13vXvHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWP4irtH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715139425; x=1746675425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=VX4j3o8PuAumvX98LolK5x0BnWOyxYhPrqsi65acJqo=;
  b=PWP4irtHuQ108ZNBr7YuB4alK36lD8S9r+ieInP4BDA3WyOn8508usPG
   frfX8bA9ZekPjNQE0EwdmBtgW4YaS1MvnffTNG8JHDxVF3wOVYkGI9dZ2
   07ZJIUgu7kD9oNZF2h4+eyHAUT3XfqdAxTLzfVZIviF0lL7sMHTluEaou
   6oOdEFXVLsAqbyznPEu0h84CW2KLC0o+NjOwaGzDzojwAzGLGFIWRjmBX
   ESfnS5BfdfelUjiS5gRH/owDCG9PcPXN7KsBKLXn7HcfbmtJccf3gxVCP
   JitxFgm1k+72dlyViBeVInkJZuyU5cgsSNiymIy3pGcJJoQZEMG0WJsPa
   A==;
X-CSE-ConnectionGUID: ZNtiUPYrS6unZkD3KADRkg==
X-CSE-MsgGUID: Iq+ZyGcDSEegd77kbALTaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10820910"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10820910"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 20:36:54 -0700
X-CSE-ConnectionGUID: YyQ012U5RCqIHJrpvyf/sQ==
X-CSE-MsgGUID: 98kccrMhRkq07nRyGxlmfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33551931"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP; 07 May 2024 20:36:53 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v2 3/4] thermal: intel: hfi: Rename HFI_MAX_THERM_NOTIFY_COUNT
Date: Tue,  7 May 2024 20:43:51 -0700
Message-Id: <20240508034352.18414-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
References: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

When processing a hardware update, HFI generates as many thermal netlink
events as needed to relay all the updated CPU capabilities to user space.
The constant HFI_MAX_THERM_NOTIFY_COUNT is the number of CPU capabilities
updated per each of those events.

Give this constant a more descriptive name.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes since v1:
 * None
---
 drivers/thermal/intel/intel_hfi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index d82b8788b0f8..c6658f8c5cca 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -167,7 +167,7 @@ static DEFINE_MUTEX(hfi_instance_lock);
 
 static struct workqueue_struct *hfi_updates_wq;
 #define HFI_UPDATE_DELAY_MS		100
-#define HFI_MAX_THERM_NOTIFY_COUNT	16
+#define HFI_THERMNL_CAPS_PER_EVENT	16
 
 static void get_hfi_caps(struct hfi_instance *hfi_instance,
 			 struct thermal_genl_cpu_caps *cpu_caps)
@@ -218,14 +218,14 @@ static void update_capabilities(struct hfi_instance *hfi_instance)
 
 	get_hfi_caps(hfi_instance, cpu_caps);
 
-	if (cpu_count < HFI_MAX_THERM_NOTIFY_COUNT)
+	if (cpu_count < HFI_THERMNL_CAPS_PER_EVENT)
 		goto last_cmd;
 
-	/* Process complete chunks of HFI_MAX_THERM_NOTIFY_COUNT capabilities. */
+	/* Process complete chunks of HFI_THERMNL_CAPS_PER_EVENT capabilities. */
 	for (i = 0;
-	     (i + HFI_MAX_THERM_NOTIFY_COUNT) <= cpu_count;
-	     i += HFI_MAX_THERM_NOTIFY_COUNT)
-		thermal_genl_cpu_capability_event(HFI_MAX_THERM_NOTIFY_COUNT,
+	     (i + HFI_THERMNL_CAPS_PER_EVENT) <= cpu_count;
+	     i += HFI_THERMNL_CAPS_PER_EVENT)
+		thermal_genl_cpu_capability_event(HFI_THERMNL_CAPS_PER_EVENT,
 						  &cpu_caps[i]);
 
 	cpu_count = cpu_count - i;
-- 
2.34.1


