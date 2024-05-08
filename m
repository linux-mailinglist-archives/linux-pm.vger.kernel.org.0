Return-Path: <linux-pm+bounces-7617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778118BF4FF
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 05:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EBD281260
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 03:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF4C15E88;
	Wed,  8 May 2024 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fde7jpnD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE0414A9F;
	Wed,  8 May 2024 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715139424; cv=none; b=kzz36w2WIMV1YD5WBuWwDGegfGRXFMDkZzZ5w4WByoS63kb8mFX+9Lv/EcVntO+SG7dCm4ooXf9MW3NVG83cQcyhCSjcbw3pzweYyo9u7IOuXFSefuSVg1mk4+zeGHwJd9cC9CrR+anyQex7Nj8nBRtcOb41Eh2upp8w2hFxqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715139424; c=relaxed/simple;
	bh=K+HG7L12mRkwMo3ylUVsmFfW2pNh/hN2w+jXyyLa2fE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qQAIbkslFMsw1QzGBpKw0baDhxS3pWsirA3QZjbdAg2vqB/5S1Ey72UHqMLjl7f9KnkcHBJIac6vg1CJmLwARisr6RlmlY9EnSSoS+H8U9fktnR1vt6+gQtk0x6MlopFMB5KnNRH9bdSOKf1Cl0EuZGyyseKtFQ7L22dohYceIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fde7jpnD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715139423; x=1746675423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=K+HG7L12mRkwMo3ylUVsmFfW2pNh/hN2w+jXyyLa2fE=;
  b=fde7jpnDp4N09pNphklmarcMSCAKieauw0waH99wgd979x7uv5eh/vbC
   QbAg/gCZjpTGmX19g+vDGxDwFV0Ur+1h1FM4E9ph8WBghiX8uZA0xQrjz
   gn/LZPTNsf6c/ddWwxOG3BQmZlu7QsQR/qtZWvDoU4D2g8S/57HvnnVBk
   bntPt5u4ZG7VIljT4GTI9IN71J1wL3BgvrBgtHtph3xk9WcGrOskDav6F
   DttqEE7180FmyUh4R5gJj2cW5s81oRLLxjclkL+BB+aKEjywzp/O3PMto
   0HSJ0tmrigmBZ/YJLW03VqqFRMewxsjtB0j+cGPzm2+xHxw+w8zCZzSK2
   Q==;
X-CSE-ConnectionGUID: p76twJoiR9el0vK9PW66kg==
X-CSE-MsgGUID: 5isWQIReQlOFtBA+hYYelQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10820911"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10820911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 20:36:55 -0700
X-CSE-ConnectionGUID: K6MZavhyS/Wv84QMfOZ7uw==
X-CSE-MsgGUID: 5qRDoizsQuKXKBRfgiCGeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33551935"
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
Subject: [PATCH v2 4/4] thermal: intel: hfi: Increase the number of CPU capabilities per netlink event
Date: Tue,  7 May 2024 20:43:52 -0700
Message-Id: <20240508034352.18414-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
References: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The number of updated CPU capabilities per netlink event is hard-coded to
16. On systems with more than 16 CPUs (a common case), it takes more than
one thermal netlink event to relay all the new capabilities after an HFI
interrupt. This adds unnecessary overhead to both the kernel and user space
entities.

Increase the number of CPU capabilities updated per event to 64. Any system
with 64 CPUs or less can now update all the capabilities in a single
thermal netlink event.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes since v2:
 * Dropped the debugfs interface. Instead, increased the size of the
   thermal netlink message size to 64 CPU capabilities.
---
 drivers/thermal/intel/intel_hfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index c6658f8c5cca..a180a98bb9f1 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -167,7 +167,7 @@ static DEFINE_MUTEX(hfi_instance_lock);
 
 static struct workqueue_struct *hfi_updates_wq;
 #define HFI_UPDATE_DELAY_MS		100
-#define HFI_THERMNL_CAPS_PER_EVENT	16
+#define HFI_THERMNL_CAPS_PER_EVENT	64
 
 static void get_hfi_caps(struct hfi_instance *hfi_instance,
 			 struct thermal_genl_cpu_caps *cpu_caps)
-- 
2.34.1


