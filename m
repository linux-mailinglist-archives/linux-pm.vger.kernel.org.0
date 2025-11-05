Return-Path: <linux-pm+bounces-37484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE282C3819F
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 22:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71FED4E64D2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9212BDC23;
	Wed,  5 Nov 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bq2ZjPyZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF65296BB3;
	Wed,  5 Nov 2025 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379435; cv=none; b=DWFUfqidpt2Kg5X56o+tjR6DAulvf/KojNUpZT4iA/IcmOaaGJ1gpRxqQc3FNdjgnqvaJTFXmiUP8gvmyM87l6anrucv6DhGOs70gru0CmvUZpjYgmXp8/RUXXnihXOUNReVuvsknnmhcomcgQDUC/DB+lbJO4DWp9yroCYjN+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379435; c=relaxed/simple;
	bh=h99QxrpDx65dbuzm3hB386GTicfeaH47NsdS2pW6NCk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DaqNwSYNPXoZZHFvwShMViKzUekmvqn34YlTV6nQ5KCYWM8j1qOcEyCAbrcDkWPhAeSATQPfoU/8tcOBRady6TI+utAgyS9n64fjk7vyKO2S2gl7/izgW8XX1dWS7J7V68DE7ePqmoLRKuAVmeuvTzaIMEDuvf8MbviKrSIEcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bq2ZjPyZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762379433; x=1793915433;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h99QxrpDx65dbuzm3hB386GTicfeaH47NsdS2pW6NCk=;
  b=bq2ZjPyZ3JT3hqAKmmHx5YEglLAelYpAi7s/z4HAmIMZjEd2q43hWJBb
   C3lUCClVCk0rxiasEoZPjWcsfGNCYB87K2+lg8/KPHi5LSSzTIcCTWE0/
   j2YmQh3QxUUHadqEl+9q8osQ01347b3CzNNIoa0/mDSKKbaPeTyuySVOj
   n7vUTSvrEp6tcw1UvMUhfMzxWKNHb1hEZcT5ZT+jSHDpzx1hQpQGZ5Q4b
   AdjstM1fphtJkVZu24YKutmjJZ+H6OIP2IEhUV826SbGO7Fx4TGUCHkXH
   9H/PfDEj9C6gvwoqbGnbHlFXnwlvPTPraY3f7EwyQg1JsaNXN84Bvslkc
   w==;
X-CSE-ConnectionGUID: VQx8cSTAQa2VYeEaS7Dtiw==
X-CSE-MsgGUID: EmM1sSscRxCmwXXFHnCYMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75622026"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="75622026"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:50:32 -0800
X-CSE-ConnectionGUID: eYPNjgBITBK8yszbgs8sQw==
X-CSE-MsgGUID: RCYBLfsSQoWo0AToBwpCYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="186856283"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.111.12])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:50:32 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/2] platform/x86/intel/vsec: Add support for Wildcat Lake
Date: Wed,  5 Nov 2025 13:50:14 -0800
Message-ID: <20251105215020.1984036-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Wildcat Lake PMT telemetry support.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index f66f0ce8559b1..ecfc7703f2019 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -765,6 +765,7 @@ static const struct intel_vsec_platform_info lnl_info = {
 #define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
 #define PCI_DEVICE_ID_INTEL_VSEC_LNL_M		0x647d
 #define PCI_DEVICE_ID_INTEL_VSEC_PTL		0xb07d
+#define PCI_DEVICE_ID_INTEL_VSEC_WCL		0xfd7d
 static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
@@ -776,6 +777,7 @@ static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_LNL_M, &lnl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_PTL, &mtl_info) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_WCL, &mtl_info) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_vsec_pci_ids);
-- 
2.43.0


