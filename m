Return-Path: <linux-pm+bounces-21354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9038FA2800E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 01:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF251667CD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 00:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FD84C7D;
	Wed,  5 Feb 2025 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOTPrI0g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B5195;
	Wed,  5 Feb 2025 00:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714568; cv=none; b=EbuzGE85wCdT9Hv8mQw2GCOXl3L5VTRETVK9NeTj9ZKMepITQWLXtKmby5slJHHUU01wqMioiiOGTsB9v17dI37NJE85IfK0VFvsgTU6mbyVorjEbrTAziTTDczrA9TS2+/9jHFQyVSeoF5EbV2iyfrJXCeOOx6VqYRwEDMy4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714568; c=relaxed/simple;
	bh=Qb8mX05iJ/CpIr04M1dcnLwoixs3E+DHs98OuuHeczM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+ima/n1Bm4wVJCqqkb4qc+fEcVz8qddBkRqqO37FufAX4u2VD3VMJ/YVu7O8BMKEeL3lyuZbezFBnaWapPLo9vWwPtbj0Vuq1VTsG7Zk1vPxlfdArA2odY3v1uZvaGtVd3CIjQxaas8yPCXV+cnsXsGRsuv3V42BHUMgbdRTbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOTPrI0g; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738714568; x=1770250568;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Qb8mX05iJ/CpIr04M1dcnLwoixs3E+DHs98OuuHeczM=;
  b=lOTPrI0gB61BUr84CMOPcH7V4iyubNUHi4S0PxujlQq1egrk4Kp7hMkR
   bYgaja9tVGV/QkgvFxnuyU4eVVhzNMD7tfqHN6IfCmosv8FuCc+nHBQME
   yTMUigO4UlpcXIGDnHynyHntID7kg6X61PUKb/qQ0o2ATRemx6uhxhT32
   e/leykiqm5zkviluSW+GWx3Xh2/SF5ZARa2V7KAUnr8lIAx+EFx1AVQk8
   b1GLVcwsZNFC/lBL5JRXwQVyAFvzVaaOlCKU6ve94i1EF6Ech6818H2MR
   1AgX4W8FyOFvCZhMMte16A0sji6urI91X84MrU1Yjcx7KAgtTcyZKefKZ
   Q==;
X-CSE-ConnectionGUID: RNdnBziaR9uNbJ+7x6p34w==
X-CSE-MsgGUID: royBWBIQRSqp7QJFwk0aVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39372353"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39372353"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 16:16:06 -0800
X-CSE-ConnectionGUID: hAyJlWIQTySkCF9nyPAoJw==
X-CSE-MsgGUID: g9WXz7CmTwO0P65mN7aplQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="110635680"
Received: from tfalcon-desk.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.223.214])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 16:16:05 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	rajvi0912@gmail.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 1/5] platform/x86:intel/pmc: Make tgl_core_generic_init() static
Date: Tue,  4 Feb 2025 16:15:53 -0800
Message-ID: <20250205001601.689782-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205001601.689782-1-xi.pardee@linux.intel.com>
References: <20250205001601.689782-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make tgl_core_generic_init() a static function as the function has no
callers outside of tgl.c. Remove the prototype in core.h and reorder
the code in tgl.c.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h |  1 -
 drivers/platform/x86/intel/pmc/tgl.c  | 22 +++++++++++-----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index b9d3291d0bf2c..a1886d8e1ef3e 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -597,7 +597,6 @@ int cnp_core_init(struct pmc_dev *pmcdev);
 int icl_core_init(struct pmc_dev *pmcdev);
 int tgl_core_init(struct pmc_dev *pmcdev);
 int tgl_l_core_init(struct pmc_dev *pmcdev);
-int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp);
 int adl_core_init(struct pmc_dev *pmcdev);
 int mtl_core_init(struct pmc_dev *pmcdev);
 int arl_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index e0580de180773..4fec43d212d01 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -285,17 +285,7 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
 	ACPI_FREE(out_obj);
 }
 
-int tgl_l_core_init(struct pmc_dev *pmcdev)
-{
-	return tgl_core_generic_init(pmcdev, PCH_LP);
-}
-
-int tgl_core_init(struct pmc_dev *pmcdev)
-{
-	return tgl_core_generic_init(pmcdev, PCH_H);
-}
-
-int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
+static int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
@@ -317,3 +307,13 @@ int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
 
 	return 0;
 }
+
+int tgl_l_core_init(struct pmc_dev *pmcdev)
+{
+	return tgl_core_generic_init(pmcdev, PCH_LP);
+}
+
+int tgl_core_init(struct pmc_dev *pmcdev)
+{
+	return tgl_core_generic_init(pmcdev, PCH_H);
+}
-- 
2.43.0


