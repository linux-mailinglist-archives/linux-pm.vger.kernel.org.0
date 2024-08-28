Return-Path: <linux-pm+bounces-13091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A58CE9634D0
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C462872F7
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B31B1418;
	Wed, 28 Aug 2024 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4LggIh1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723E1AED57;
	Wed, 28 Aug 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884184; cv=none; b=GMBWo4HEE/IT/3rupVHiPqhioXTASkqYdwQ9acP/WifMgb3Z4MqVYBpU6FpeiAH289FqAb1fVvSuiVzIJwyyTgL817u8Cc9Vr7PbjWyVSKKDhVte+ylo3GzVFzk+grNq+6zN9pBQE8S15ATHPQ3JTZJg0L0+q3JJW7cZQ3n8zLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884184; c=relaxed/simple;
	bh=j5CDe8gdgBVD/syQL/At/OQPa2s++JMK0Dbr2lVkXso=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIQ87uBqCycJBG0HUxnDNH/RWoYx6i1sEc9xh1F88OYhSyOST1ofBP06TNVE+rkEiZjwOCIna+aC3o5BP/n5NGURcEiAz9n/UimkbL1J7+XBTYdj4ZP4FC1ZbB4o0cG7PosapXPf08dJGqGfc1U0TWgAEFJO5fVSYDCc7pOEHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4LggIh1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884183; x=1756420183;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=j5CDe8gdgBVD/syQL/At/OQPa2s++JMK0Dbr2lVkXso=;
  b=R4LggIh1uGNIwge4jlWoSMIOR2mvunvSp2i1gRK+dJ8974nEqsp7O0xI
   UMglrtNxywn+p3sFAfEquFxmZeR4ePHkz6izKSGjVOtvO2M5oGihuA2YN
   7dTvzcqWfh6kO0h5pet3ArYtqktTDaOQfx8MkjXTwAjqHvRxeDR4aFcQu
   vweqN5Xk9d8JbUmSpWB5tGqhHFro2TF4dAGy3x6GixTJSs8GFBiScD4QW
   X5/76kt7C65XICvaOvO8KChd+0FS4rFRbw942EtUftasIbL/+Yf9o+5zL
   XJaYVh1rdV9K5sVTbgIv9jF3HopWjAS8zqfkIkoxg0vAD/7polhwiOuw+
   w==;
X-CSE-ConnectionGUID: RNkoT0ZkSV+g8zjWtB/nIQ==
X-CSE-MsgGUID: NWaAjW4PSomCY/+9NXWx3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23406491"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23406491"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:41 -0700
X-CSE-ConnectionGUID: rdTcnZP0S4KFXaXfyUWH+Q==
X-CSE-MsgGUID: RlA9bDWdTIurhvSSl84+Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271825"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.220.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:41 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 09/11] platform/x86:intel/pmc: Add Lunar Lake SSRAM devid
Date: Wed, 28 Aug 2024 15:29:24 -0700
Message-ID: <20240828222932.1279508-10-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable SSRAM device Lunar Lake support by adding Lunar Lake SSRAM
devid to Intel SSRAM Telemetry driver.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h            | 3 +++
 drivers/platform/x86/intel/pmc/ssram_telemetry.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 2d62a71ec100..25974f9d329e 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -300,6 +300,9 @@ enum ppfear_regs {
 #define PMC_DEVID_MTL_IOEP	0x7ecf
 #define PMC_DEVID_MTL_IOEM	0x7ebf
 
+/* LNL */
+#define PMC_DEVID_LNL_SOCM	0xa87f
+
 extern const char *pmc_lpm_modes[];
 
 struct pmc_bit_map {
diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
index 1c6cc95bfefa..025013b051c7 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -165,6 +165,7 @@ static int intel_pmc_ssram_telemetry_probe(struct pci_dev *pcidev, const struct
 static const struct pci_device_id intel_pmc_ssram_telemetry_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_MTL_SOCM) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_LNL_SOCM) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_pmc_ssram_telemetry_pci_ids);
-- 
2.43.0


