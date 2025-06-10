Return-Path: <linux-pm+bounces-28422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4520AAD466B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 01:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048AA174A50
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 23:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BAA26056E;
	Tue, 10 Jun 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SY3FXxtr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE2260562;
	Tue, 10 Jun 2025 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749596665; cv=none; b=lb9bVRyBOfFAAa7FB3ck2zqMsRflIJAXmMbQZKmWiZZmo11PpnrbSEyjARhjl8Qx+9Te79o+5sxFV0FBLue8uMesppH9nz1Z5skCAP5uZ4X+/xjSCAMuKcAg/yFP2v3jrBjTSLAtG5Wo6xpCrjEVK8sMpFKf6c8ITxJzPKhLGn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749596665; c=relaxed/simple;
	bh=ZyM8Fj84cnr+0xuauLNrNUsImkrJpydwtJBb5Ua6enY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hNzmW2y2pUUZufDQb69m0tLTkTRXOfudTzwnKz8ttOxMD46mRxX4z2rWQltrOSGW392kLSBXwQ29Q8Akpm3zAr1FcFPz8Oh+F5CfMLlwsTtFcq232APiy/24L+hijm41efIMPrxb7AAUK1kN4slNdm0ASyhXp8QInuDnmIQi4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SY3FXxtr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749596664; x=1781132664;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZyM8Fj84cnr+0xuauLNrNUsImkrJpydwtJBb5Ua6enY=;
  b=SY3FXxtrjK/G37lZT1kiN3DfJCmBnXnz2+LbzbhF8vN9DjXsUO46qzLq
   +hiR1V4RMrBe5+5hhMRpbMIHwQR0ftMVfUzCRrfHBmNxV/NvL7sfQ9Gjs
   OMcmYSXXPIg+RM3e1d1K03M+3KtmmHsixEn/mXgFI9vk88ypZzkE4k6/C
   9KGbwaudp83BujFQBAzDWFAs0bqXoRf/TmOzyCsPkyxUfj5+UP8GJmzMW
   PVRpiFgdUxjcfTPyUHAOQ1wcCBj8te9nJp1a8fbcGGFCjqYFdsLPjbUzO
   ytrdyblTSrUNyOI5U+Po42evmHt6mk2soM2qbKH9yDJpa2nXhmOraUEic
   Q==;
X-CSE-ConnectionGUID: XmUp/Ze3QGOz0bEUJ+3u/w==
X-CSE-MsgGUID: x+LwYHoeTGW653GoF4Bjrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="50952199"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="50952199"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 16:04:23 -0700
X-CSE-ConnectionGUID: x/pYMbz4RU+ib3g1Xh9eqQ==
X-CSE-MsgGUID: m757W9o5SQSKcUviAqhsqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="151965996"
Received: from iweiny-desk3.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.220.200])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 16:04:20 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/2] platform/x86/intel/pmc: Add Lunar Lake support to Intel PMC SSRAM Telemetry
Date: Tue, 10 Jun 2025 16:04:06 -0700
Message-ID: <20250610230416.622970-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Lunar Lake support to Intel PMC SSRAM Telemetry driver.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h            | 3 +++
 drivers/platform/x86/intel/pmc/ssram_telemetry.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index e136d18b1d38..c1db41cb8334 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -299,6 +299,9 @@ enum ppfear_regs {
 #define PTL_PCD_PMC_MMIO_REG_LEN		0x31A8
 
 /* SSRAM PMC Device ID */
+/* LNL */
+#define PMC_DEVID_LNL_SOCM	0xa87f
+
 /* ARL */
 #define PMC_DEVID_ARL_SOCM	0x777f
 #define PMC_DEVID_ARL_SOCS	0xae7f
diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
index b207247eb5dd..24d5d01805c8 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -187,6 +187,7 @@ static const struct pci_device_id intel_pmc_ssram_telemetry_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_MTL_SOCM) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCM) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_LNL_SOCM) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_pmc_ssram_telemetry_pci_ids);
-- 
2.43.0


