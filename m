Return-Path: <linux-pm+bounces-33128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA748B37251
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 20:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589FF3A5E7E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 18:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF70362091;
	Tue, 26 Aug 2025 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z10Y9j3F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC22E3AF1;
	Tue, 26 Aug 2025 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233592; cv=none; b=VltWvF9HgkgwypCTQA+XyDgdOSU+GcD1KPo6o6Hsrc50HHejl168GDPiA0RPwrvYNGpdNqU84L5K0D+tcda9X+/ruUfkpQYxyfg7VyynjQYeWzQ9gfvbZCJ+OKvSRG9PnImXayj/6PtSNEqcAEHTPAOQN0IufbZHn55eobektIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233592; c=relaxed/simple;
	bh=eGUKQUHiZt57yd5d71idNY5FQGaqApInZMHVrZxOda0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xht7PMhMZQ9Y0g/6UXFrZQ1zweZK03+QK+JNIkfYuU3fSlzyXrSUervZJ6kGp5b1cqCL7LnX9OBbslWjCu1Zzc8dwKQP8G0JmA1QR53vLl0TyfmyGA6rfwOKN79Js0gDDWLeRv+wkV9DMAib54xegLPR0IkYZldFSPXCbo7jNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z10Y9j3F; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756233590; x=1787769590;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eGUKQUHiZt57yd5d71idNY5FQGaqApInZMHVrZxOda0=;
  b=Z10Y9j3F17yt8aoBSJvt1WWWnEXuDZerj0lIMhDXJxgzbX9V4DFg7XvD
   4JcmRT/p7vZACo5T8u2b4cY1bDQDVnHUqcld3gNRN2VYeSvF07M8pfyB6
   LkrQMXPcUYTBYbH9lDJnPKbwhsHb23f/RhRfkBPyi4aFFLjHjIzCnc9mG
   gLRI6+gvqgxvWthIU/BzXquTxYdyhvlxemaQjjmIn0hcNwe6HPScXtCEX
   0rJZ1t997WeOczsi8ww7KlMUgENXF23X0P5RF+u9PofZNG/7Rx4PcOaDv
   ywWioVHBfOxObokmE5fxc4bQ4JclR2q+XXYjfGalZIVm1ug4yP5vD6PVD
   g==;
X-CSE-ConnectionGUID: CGP0m+SXTcybMNFROw7O+A==
X-CSE-MsgGUID: kn4l0sWlS+mcJ3AXm/ev2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69921012"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69921012"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 11:39:49 -0700
X-CSE-ConnectionGUID: lQ5noM8sTEC8huUy4vifQw==
X-CSE-MsgGUID: S7TqLLpJSNaBU3RyQmDepQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200537406"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.109.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 11:39:48 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 1/2] platform/x86/intel/pmc: Add Wildcat Lake support to Intel PMC SSRAM Telemetry
Date: Tue, 26 Aug 2025 11:39:42 -0700
Message-ID: <20250826183946.802684-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Wildcat Lake support to Intel PMC SSRAM Telemetry driver.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h            | 3 +++
 drivers/platform/x86/intel/pmc/ssram_telemetry.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 4a94a4ee031e6..160b175ce7066 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -306,6 +306,9 @@ enum ppfear_regs {
 #define PMC_DEVID_PTL_PCDH	0xe37f
 #define PMC_DEVID_PTL_PCDP	0xe47f
 
+/* WCL */
+#define PMC_DEVID_WCL_PCDN	0x4d7f
+
 /* ARL */
 #define PMC_DEVID_ARL_SOCM	0x777f
 #define PMC_DEVID_ARL_SOCS	0xae7f
diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
index 93579152188ef..03fad9331fc0c 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -190,6 +190,7 @@ static const struct pci_device_id intel_pmc_ssram_telemetry_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_LNL_SOCM) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_PTL_PCDH) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_PTL_PCDP) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_WCL_PCDN) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_pmc_ssram_telemetry_pci_ids);
-- 
2.43.0


