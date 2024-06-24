Return-Path: <linux-pm+bounces-9905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689889153AE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 18:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3D61C231BA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13AD19DF61;
	Mon, 24 Jun 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFRlphi8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA019D073;
	Mon, 24 Jun 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246439; cv=none; b=Bl7AZCMmapkxHtRcP7xm8xhhv0pRn5I4efi2UeQRBqrpgZ/qHCtvimuNf+AK2WMWeiN0jAoHS2X2P86hEdFEpORXqUcyqX3sZ+IaL6r4QDHgwwmNWP1gzk0S0ak0lyRrTIL0DOqaRBZMM3GpELq47qH6+IAc4IERS18It2JM/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246439; c=relaxed/simple;
	bh=gQWoEMp5t0Y9g3UhBIyAiLjSmCTWrouWgYwkGd+av4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jbl2R8Njf8LZOxlBgYVZcc4h1O5O3ysMuFOH8hOU8QJmbHwYZSgvevqZ80eGRKi2HSqWifw8eqC/i+FnGU8Tnm6UiLF5eyGooCsa9R9eHw76bJapsWAjeEXxHII8Ycy5627nwr7a6RTxm7KatdhFDDqTo5d8UOldkEKzcGo+wPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFRlphi8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719246439; x=1750782439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gQWoEMp5t0Y9g3UhBIyAiLjSmCTWrouWgYwkGd+av4Q=;
  b=SFRlphi8dBQOv82i9vD8kI7HPJHGFlJcEZwyxvXcInfonzKeF1R8BqWk
   CdVrEGbjR6RcA3/+Z1/tRsiNutf0WPCfF+3qZ31i+e8WTK/pY8zRBnTn9
   AJ+cHgl2xZmJ8PMKdSp30XgYkMe7Hl7mCDueHTClnEwHEl4XJCKKEE1ZW
   5xex++LIb7OZQko/R/H9wVhvHBZyeQGITDcV0EvfxvlHq+15WSFQ1l4hq
   1SUHGTvALUu2rWdr8L3RPtfKETv7oKK2AJ6osdYd3LMR2Qhz8i5BV5wnD
   ODIZ4Wj/kXzmDIMY29QMr0CZDVGvxdyDeYC0Gfby7aIm82EnhpmYdPIRG
   Q==;
X-CSE-ConnectionGUID: dPsXdzkjSVGAVCOeli19DQ==
X-CSE-MsgGUID: QXRzkkeuSbenKEaIvexmKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="26816579"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="26816579"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:27:18 -0700
X-CSE-ConnectionGUID: E3VqrhfcS1ygxX0cYJAejw==
X-CSE-MsgGUID: 9NyfRYSMSke55y++fFR9PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43322750"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa008.fm.intel.com with ESMTP; 24 Jun 2024 09:27:18 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Replace boot_cpu_has()
Date: Mon, 24 Jun 2024 09:27:14 -0700
Message-ID: <20240624162714.1431182-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace boot_cpu_has() with cpu_feature_enabled().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
This is based on comment from Borislov for the change to suppot HWP
highest interrupt.

 drivers/cpufreq/intel_pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d53b99bab687..4ee244f59f54 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1635,7 +1635,7 @@ void notify_hwp_interrupt(void)
 	u64 value, status_mask;
 	unsigned long flags;
 
-	if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
+	if (!hwp_active || !cpu_feature_enabled(X86_FEATURE_HWP_NOTIFY))
 		return;
 
 	status_mask = HWP_GUARANTEED_PERF_CHANGE_STATUS;
@@ -1667,7 +1667,7 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
 {
 	bool cancel_work;
 
-	if (!boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
+	if (!cpu_feature_enabled(X86_FEATURE_HWP_NOTIFY))
 		return;
 
 	/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
-- 
2.44.0


