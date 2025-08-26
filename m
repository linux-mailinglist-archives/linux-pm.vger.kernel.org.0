Return-Path: <linux-pm+bounces-33127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665AEB3724D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 20:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA527A40D9
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9B36CC83;
	Tue, 26 Aug 2025 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3RQ7YuX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4021D3F2;
	Tue, 26 Aug 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233521; cv=none; b=ay8htK8yrhu9ihQLmLESmVU+wuYRxnd5pxL9BEQ7+cVF4loxF8JnmyZrGQWjDHGbViLftsDERsK4f68VEMhisQbux20MLOqXX9MqTw0fLr+a3WnxSoShT3A8iUnCBg0zvKOZq8im+P+f0ZgK3Rzy+Uo2D3HUv0UCeugh5tWFrCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233521; c=relaxed/simple;
	bh=DRL0Rp1rcjZZQCA5vIp6UWC6r6fR8KjmBs3LClzjh0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpUIV0VoOXtM4yUyHiuOhUjR/lD5JyjEv5XFpYA1TF3I3DCUf7XYODTthYU74iCb+og2gI6Cm228/xkkGBkst0v3AOGK+AubuAVM+pFsnAYPMqb6hja05A3hv8rdUK1NySMyUanrZ+cmwzgYb7pGs0oz8dHYhrsMlbKxVaXzKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3RQ7YuX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756233520; x=1787769520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DRL0Rp1rcjZZQCA5vIp6UWC6r6fR8KjmBs3LClzjh0I=;
  b=n3RQ7YuXl13kWXJur7boiLAziKt/G4BkHmA2pR+8cgrdUWuic/dY80py
   brTHHxVwdLLXEjVRUKHx2biINBy+wMxEZxa2+OUGSiom8sMFxkoXapyLm
   lU0s70oxC/yQqm75hxfc3kKDL78QwDX0ct4JCZ5r6uRpn2e9tnBiudoyg
   7EiykleCbWDOAwxI7scqCdZpfg5uXlAIVI4MUx4L8nGzoHnmOVA4RY1uf
   HQ6gnwMg5+xS960iaHVGwWyMdUwVKTbZ29G+tLbkHYqrBsSpl2pvfOsD/
   W44bijZTYMQywAY+3+b0Q51cUhbCvY9YJ0H9Z41Um3IX8jxB/eeWWB90o
   A==;
X-CSE-ConnectionGUID: FTyQ+houRpiul9adFND05w==
X-CSE-MsgGUID: RZ+cTf+oSouXZJIzErgtiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="46061210"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="46061210"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 11:38:40 -0700
X-CSE-ConnectionGUID: sKyHxpUWRXyW54750QISaQ==
X-CSE-MsgGUID: 42xhI/2RQyy3iWzkkH1BCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169581064"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa006.fm.intel.com with ESMTP; 26 Aug 2025 11:38:39 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Cc: x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	Zhao Liu <zhao1.liu@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v3] cpufreq: ondemand: Update the efficient idle check for Intel extended Families
Date: Tue, 26 Aug 2025 11:36:44 -0700
Message-ID: <20250826183644.220093-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IO time is considered busy by default for modern Intel processors. The
current check covers recent Family 6 models but excludes the brand new
Families 18 and 19.

According to Arjan van de Ven, the model check was mainly due to a lack
of testing on systems before INTEL_CORE2_MEROM. He suggests considering
all Intel processors as having an efficient idle.

Extend the IO busy classification to all Intel processors starting with
Family 6, including Family 15 (Pentium 4s) and upcoming Families 18/19.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3:
 - Posting this patch separately since the core family cleanup series
   was merged without it.
 - Improve commit message and code comments.

v2: https://lore.kernel.org/lkml/20250211194407.2577252-7-sohil.mehta@intel.com/
---
 drivers/cpufreq/cpufreq_ondemand.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 0e65d37c9231..3decfc53fe68 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -15,6 +15,10 @@
 #include <linux/tick.h>
 #include <linux/sched/cpufreq.h>
 
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+#endif
+
 #include "cpufreq_ondemand.h"
 
 /* On-demand governor macros */
@@ -41,12 +45,9 @@ static unsigned int default_powersave_bias;
 static int should_io_be_busy(void)
 {
 #if defined(CONFIG_X86)
-	/*
-	 * For Intel, Core 2 (model 15) and later have an efficient idle.
-	 */
+	/* For Intel, Family 6 and later have an efficient idle. */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
-			boot_cpu_data.x86 == 6 &&
-			boot_cpu_data.x86_model >= 15)
+	    boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO)
 		return 1;
 #endif
 	return 0;
-- 
2.43.0


