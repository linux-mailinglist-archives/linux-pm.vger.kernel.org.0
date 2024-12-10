Return-Path: <linux-pm+bounces-18950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D7E9EBBCA
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537D2280FC6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE437231CB1;
	Tue, 10 Dec 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4K/JEWm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6D423ED4A;
	Tue, 10 Dec 2024 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866013; cv=none; b=jNetGKZqVznEEooxYeFPJmVcDq0qywRuO0lAKPrVJo8l6IQPiBupwDw5Rv23KhK3CeuTRBf0CbjnvezsLiRMaW3OUBByDQjCrd8yqE6g+n3ezJshcMgVUizAtxRe6xJ0G+Kki92xmtw2ELwm7zYelMZIfAjK96YyvzNKfNs+gDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866013; c=relaxed/simple;
	bh=QGEVtB/OI75hknLv7NcDfG2ONAhagOpBfsAXUEcCF+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S3qvIJSxygnoE5xFEvugWLWX4q9Omn6SmGKiyvyxiGUn+vQ3eKmM9lqeWPExEZ6x8bKzi1CZixTD32+HnWVKnSJFRTsy3aw4mFcvZJlCNWzN4EE5VvAt4e7owjCZ87iCgTGzQBh/JD0xunYkHRmsPdJdEhgFas710lNzU78HhTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4K/JEWm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733866012; x=1765402012;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QGEVtB/OI75hknLv7NcDfG2ONAhagOpBfsAXUEcCF+4=;
  b=Q4K/JEWm9maYU+KrQje9yHy6qVGVe1WsTP2Cw4b1hEjz0mK7uH7KSBpj
   TCqtTa7mqkiLKL4Y0AtlzuTRiMSdOTIqaYF0NL4n3E+9H7qgYdkUPCuAL
   2c6m1Bdb2lFtDLFQmuFAOakTdIK7uYPoLazwWtQxxXm0LwFK293gVOwnO
   GXYDSQgXT9p66tPzqjddAe1giJM11uhgS8dvDIygf5E8gBSiP1opL9ClD
   p5P40SHtD54ullX/b2o0EZDUZ0Y8zApG1COV6WD4UMyjHxzVK7itNnBlP
   m0Rs3G1PJeFdz7oxIB0eK3ssaSTNcQQPNV5CqLqhc+teHQUbUtUpw8hrA
   A==;
X-CSE-ConnectionGUID: 4QhdCnilTwSD/kil/k8sZA==
X-CSE-MsgGUID: fhzIY/goQWCQnEDTdxWjcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51641157"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="51641157"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:26:52 -0800
X-CSE-ConnectionGUID: buMF0DY5SnKEzr8jIkMYmQ==
X-CSE-MsgGUID: cVwdL6ZRTb67+fji7Q1kbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="132938472"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.222.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:26:49 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] platform/x86/intel/vsec: Add support for Panther Lake
Date: Tue, 10 Dec 2024 13:26:41 -0800
Message-ID: <20241210212646.239211-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Panther Lake PMT telemetry support.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 4a85aad2475a7..8272f1dd0fbc0 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -423,6 +423,7 @@ static const struct intel_vsec_platform_info lnl_info = {
 #define PCI_DEVICE_ID_INTEL_VSEC_RPL		0xa77d
 #define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
 #define PCI_DEVICE_ID_INTEL_VSEC_LNL_M		0x647d
+#define PCI_DEVICE_ID_INTEL_VSEC_PTL		0xb07d
 static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
@@ -432,6 +433,7 @@ static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_LNL_M, &lnl_info) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_PTL, &mtl_info) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_vsec_pci_ids);
-- 
2.43.0


