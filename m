Return-Path: <linux-pm+bounces-9215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0708D90939A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 23:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6BA1F243FB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5A8185097;
	Fri, 14 Jun 2024 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJtH3vFp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF501836F7;
	Fri, 14 Jun 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718399428; cv=none; b=o3/tzsV10xcrMEInoOA7C5NDL557+9CFZSjL/xKoiuMlLz4j0qmS9hONd0bXjlh1VI1OyI8eYk+FyeBYlqbpknes36UVibmabuFLDFfTfqfW3GEiCzlhvI+oEhkGqBax/I/2F44z/7OS2EFQkhRrOVr4n2bDjyqpSUjhgr9TDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718399428; c=relaxed/simple;
	bh=JRveOb1aR/lPnUmEJO3eKUrxatx2cKtoGqOUJhUROAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FF8YBKYEwNxHmq/lK6Hs9RSLNWH2WvZorhwgkhNYgqXw9+h4tqI8WwGXRGME0Qs4ndVe6sTxtyT6niQS7RvWX2rPV0PQ/AID47QTTDc5Nfuqq42FRF0+Kyw7kGE7GG703+wE2GuNcDBWNbXd6iFsue8wSJetEiFmgTzEw/6+hnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJtH3vFp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718399426; x=1749935426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JRveOb1aR/lPnUmEJO3eKUrxatx2cKtoGqOUJhUROAs=;
  b=fJtH3vFpd2ayBrtYOm4X8c0pDCMiyhy6UIdPYOQ5YexijamQgxuJg+Ec
   TAfrWpLf6/MwfyHMJ415FIkg2yNxqlrAJU6393CCMc5kBH6LPF844Nnjl
   bn6CN1EeUakIxD1sYAfhZS0UfoaidEAU1Gds5vOkRJSivYi40iFPX7zdl
   euqVbZ3DpyY0Kh8TXKyMPnNkbzKwp/23lHtMvJFfuFos1PL2s4rEeLy+B
   As419gaMCTncoayFF1J6kgZesFiZ+G7ccmSlSHczQv0wziIQZ5NszwtAA
   eAG5T1m1AaDLqhcVXQipfmvFlPaA02VAb+l3DhxO/2TMhF6pwEzSPv+0I
   g==;
X-CSE-ConnectionGUID: hhZZYflJSvm9CJKSt9Jnzw==
X-CSE-MsgGUID: vAEbKV1ZTumJC+yOwMYjug==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="18230029"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="18230029"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 14:10:23 -0700
X-CSE-ConnectionGUID: 9jf+LWzLSsi6qzQAnR2bGg==
X-CSE-MsgGUID: CdIBmVGtRFWTjyuNk4wbxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="44992977"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa003.fm.intel.com with ESMTP; 14 Jun 2024 14:10:23 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v3 2/2] thermal: intel: intel_tcc_cooling: Use a model-specific bitmask for TCC offset
Date: Fri, 14 Jun 2024 14:16:06 -0700
Message-Id: <20240614211606.5896-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614211606.5896-1-ricardo.neri-calderon@linux.intel.com>
References: <20240614211606.5896-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The TCC offset field in the register MSR_TEMPERATURE_TARGET is not
architectural. The TCC library provides a model-specific bitmask. Use it to
determine the maximum TCC offset.

Suggested-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v6.7+
---
Changes since v2:
 * None

Changes since v1:
 * Used renamed function intel_tcc_get_offset_mask().
---
 drivers/thermal/intel/intel_tcc_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 63696e7d7b3c..17110ffa80bb 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -20,7 +20,7 @@ static struct thermal_cooling_device *tcc_cdev;
 static int tcc_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 			     *state)
 {
-	*state = 0x3f;
+	*state = intel_tcc_get_offset_mask();
 	return 0;
 }
 
-- 
2.34.1


