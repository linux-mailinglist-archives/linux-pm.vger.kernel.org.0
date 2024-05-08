Return-Path: <linux-pm+bounces-7616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942898BF4FD
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 05:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BA42814A7
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 03:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86571426E;
	Wed,  8 May 2024 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekxUbIjD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D31A2C12;
	Wed,  8 May 2024 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715139422; cv=none; b=DQvoyUkeAjcvCc40IspHx5OxTsppMpZM2aX6ySZRxYbbcJ1jHq1bydYeD94qK2Bw1grjq19QaUiWIzc5g4zHe3L1k+iwgOkDjQF+LnHO2UZtLRNBR2xlSDbh3RKppNnlQSYKttQ+vF5Uw7fdjeS9/Xey4DCFjdFw7+eFIUbvLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715139422; c=relaxed/simple;
	bh=kR97mbQ0Rry62elnu9tL23JQRgk/0e+OWskQwenqFE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UVAOSJ8wyf7YjMwbu9/xLg2kCFxawTWL+mofK9CJJAMAQh9DuvZ53SyrplMAUSiyDv3G6Z39pBJt/tc2hC6xNy0Q0OGmu7lk+6gL0wuzDWj5XZ/SsM16+RqrLRpVdSMw4Wgxa+5pCg+zpsIQEUZ1SjhXu+C0+nNfJuIPCwOYDYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekxUbIjD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715139421; x=1746675421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kR97mbQ0Rry62elnu9tL23JQRgk/0e+OWskQwenqFE0=;
  b=ekxUbIjDqebK5mQi5mQUZxcVWBryOtgnVe7Eba5+fTb6GGK8RG/JSkCN
   ozWG5wLJ2D80P73eISCZNWTal5Pv8xiomlEtGbvizwuKecaaHcwwDjTtu
   YzTWoBVuoiGGT4FTS5s+gcQU5QHnX6jpzwFaAA8+Kyc2z0lZzAVaN/X9K
   nw9ZLFVeA/GwJ9FGM1pOzCha4YXRkq9QwRqFPWUiRmjWTArH59okGQHmD
   dcl/HDzspttDHisAbb1DR9wFzp4T+rqbgMUqte1Fe9T7B6mdb/l6Mq6IJ
   pql1dLvjPMb4YIssL16ybBkJKcPUd/q8MHMdQvzdd5xKo0ZgYrc6dLp82
   A==;
X-CSE-ConnectionGUID: 8YH2gV0LSNSlbCSCmhWdQg==
X-CSE-MsgGUID: Ozsttdn8TCahAvDjIZkS1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10820907"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10820907"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 20:36:54 -0700
X-CSE-ConnectionGUID: sPr03TCfQ/mzWXbDwBqnoQ==
X-CSE-MsgGUID: GsF2qpQeT8aoHHIVck2jwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33551924"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP; 07 May 2024 20:36:52 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v2 1/4] thermal: intel: hfi: Rename HFI_UPDATE_INTERVAL
Date: Tue,  7 May 2024 20:43:49 -0700
Message-Id: <20240508034352.18414-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
References: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The name of the constant HFI_UPDATE_INTERVAL is misleading. It is not a
periodic interval at which HFI updates are processed. It is the delay in
the processing of an HFI update after the arrival of an HFI interrupt.

Acked-by: Zhang Rui <rui.zhang@intel.com>
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
 drivers/thermal/intel/intel_hfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index fbc7f0cd83d7..e2b82d71ab6b 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -166,7 +166,7 @@ static struct hfi_features hfi_features;
 static DEFINE_MUTEX(hfi_instance_lock);
 
 static struct workqueue_struct *hfi_updates_wq;
-#define HFI_UPDATE_INTERVAL		HZ
+#define HFI_UPDATE_DELAY		HZ
 #define HFI_MAX_THERM_NOTIFY_COUNT	16
 
 static void get_hfi_caps(struct hfi_instance *hfi_instance,
@@ -322,7 +322,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	raw_spin_unlock(&hfi_instance->event_lock);
 
 	queue_delayed_work(hfi_updates_wq, &hfi_instance->update_work,
-			   HFI_UPDATE_INTERVAL);
+			   HFI_UPDATE_DELAY);
 }
 
 static void init_hfi_cpu_index(struct hfi_cpu_info *info)
-- 
2.34.1


