Return-Path: <linux-pm+bounces-7618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C288BF501
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 05:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0932B1F22ED5
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 03:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A0417559;
	Wed,  8 May 2024 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuDWTmBH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C461427B;
	Wed,  8 May 2024 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715139425; cv=none; b=Ffj5GwWJBYr8aJ6QuwzkahKQYZy5THcqN1dMAbSDWH9hJZ2LWClSnV7kX0mBDGVKz2pTt19e0DKpFeHmRlqEAPXqfmjIs+2bnmpOjdiQ7W/YZQlMPmHLVSWMDBreRiI0S5Si1VAgWUEI0Wm7ZF2tdsspgPgXeCSDkHREsOtc9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715139425; c=relaxed/simple;
	bh=4EtO7Ihxo5VDSVZMZHwbrvD7dG2Ao6rUGaoUS1eTOZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t4jn4iKRZ/M0oIaaQMe+6EZB5C/ViKdTA8bc+ZEAOaekk3+OLFC7cB60E4QrSwCSOLtYijCLFDmKOMmw1Lf/H3DLtZkrcpvA191di5CHOewegGADOG6ST3IPozLuCD3CBmbSTURl72FTHdJzErUrbX0OdX8KvsW879Zr05gZwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuDWTmBH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715139423; x=1746675423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4EtO7Ihxo5VDSVZMZHwbrvD7dG2Ao6rUGaoUS1eTOZQ=;
  b=MuDWTmBHvTsWhbrxOEr96olWQjMkMNZE5s/xYt2ckswYhjfqk3NkMj3X
   P+oM9UyacdOdR/mtUXS/FYBXN/abFCSdpir1n+R35IjKiEgE9k9fn48Ub
   dQFjBTULSRtJ5U5Prf4IXNzofp5oJJbUlCR60IWZcZQpYGgJ7Jx/xn7Va
   l3x7vPM2t/Ur0ri1QGRS16F1u2AX3IH1fvymvHXRatjrp57b/PrJemHmx
   29TfQaMaOaeuPUHQY/ye9NReJnsVC/uGP+/P5bO5/m7DbWCbPxwmTQKkb
   h5k8Thf7U4V1fLK8fTjxkDkZ6xn5ThY94K1xRdfUV1uDsjchlIR0oyOnE
   Q==;
X-CSE-ConnectionGUID: Uoj6XVXxTRObfBrEF1RRqA==
X-CSE-MsgGUID: LlhtH1cARlS+ek2T2xA0KA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10820909"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10820909"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 20:36:54 -0700
X-CSE-ConnectionGUID: OquyvCiyTdmGzQr/C/CbLg==
X-CSE-MsgGUID: 5s7cCh53TsC+p/h9jzDOtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33551927"
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
Subject: [PATCH v2 2/4] thermal: intel: hfi: Shorten the thermal netlink event delay to 100ms
Date: Tue,  7 May 2024 20:43:50 -0700
Message-Id: <20240508034352.18414-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
References: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The delay between an HFI interrupt and its corresponding thermal netlink
event has so far been hard-coded to CONFIG_HZ jiffies (1 second). This
delay is too long for hardware that generates updates every tens of
milliseconds.

The HFI driver uses a delayed workqueue to send thermal netlink events. No
subsequent events will be sent if there is pending work.

As a result, much of the information of consecutive hardware updates will
be lost if the workqueue delay is too long. User space entities may act on
obsolete data. If the delay is too short, multiple events may overwhelm
listeners.

Set the delay to 100ms to strike a balance between too many and too few
events. Use milliseconds instead of jiffies to improve readability.

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
 * Dropped the debugfs interface. Instead, updated the delay from 1s to
   100ms.
---
 drivers/thermal/intel/intel_hfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index e2b82d71ab6b..d82b8788b0f8 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -166,7 +166,7 @@ static struct hfi_features hfi_features;
 static DEFINE_MUTEX(hfi_instance_lock);
 
 static struct workqueue_struct *hfi_updates_wq;
-#define HFI_UPDATE_DELAY		HZ
+#define HFI_UPDATE_DELAY_MS		100
 #define HFI_MAX_THERM_NOTIFY_COUNT	16
 
 static void get_hfi_caps(struct hfi_instance *hfi_instance,
@@ -322,7 +322,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	raw_spin_unlock(&hfi_instance->event_lock);
 
 	queue_delayed_work(hfi_updates_wq, &hfi_instance->update_work,
-			   HFI_UPDATE_DELAY);
+			   msecs_to_jiffies(HFI_UPDATE_DELAY_MS));
 }
 
 static void init_hfi_cpu_index(struct hfi_cpu_info *info)
-- 
2.34.1


