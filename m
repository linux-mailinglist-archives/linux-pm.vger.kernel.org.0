Return-Path: <linux-pm+bounces-19550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE759F88B8
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 00:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7CC97A2A1A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 23:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76F1F192A;
	Thu, 19 Dec 2024 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X89wgdxR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903E11D433B;
	Thu, 19 Dec 2024 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734652549; cv=none; b=Pr3CX4Ns3cAmIWJjsC3jbdTt2drraAMSK6Jn533or5M+9vva54T2qXYagm+SbBlZ11iqb/SGi0HtTyPmX7SAek0NfAa4MNkXHh41WMdid6ELwhrQLy4byyLk5pNTTWlCOc/bQqiKNpuXPPOVl40/kFjyGMQyR/JNJvlvY57/qIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734652549; c=relaxed/simple;
	bh=Qb8mX05iJ/CpIr04M1dcnLwoixs3E+DHs98OuuHeczM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vwktt2zHAHHwK8VdTlEkMixUFw94/1r7P/S3RaSEV7Wicy++xMbICgIYT4gLMjnD+ztnS3LZ5PESyj5YKj/7top8+4AdlKOsodw6oXPQJLzL9XLryFaFLF4uF/Qhhei0G9aCrDFN3NPW60hQC4wW3KY5fo5TZSBtSHwQaFPocnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X89wgdxR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734652548; x=1766188548;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Qb8mX05iJ/CpIr04M1dcnLwoixs3E+DHs98OuuHeczM=;
  b=X89wgdxRXtvOUd4KvTg9OzLhPl9yPCs7B+6GfSOHWNwmMHEbrj3jfGBd
   p1lHixgrUaXI7wGZAunQ5MBsTKwOPRAHdMPjPqpNa/JCslN5qJUCzNkkk
   4vNB+8Bx10c585XE/eVyGAqJPSdiL4T0JjzuD/R9ogn/DcnwhXF0yE9hZ
   gWYWipKuIKY8YxXevgYSMtlL2rmaAtyC/wXImDPbiSwkOmgh7TEA7CYzb
   qJ0Gr9XFMt7lgNlWY6h7/He735gsw8yPPMx+6kCgVH8hl24JeW4yZHtGQ
   pHghE7kCS2ME7P3MVbJNHkCnF7WttlP55P80+H3K8rx/ATa8N0uDT3HcQ
   w==;
X-CSE-ConnectionGUID: KhJ37VNASV+WLfYI+43+8A==
X-CSE-MsgGUID: 1JOpRzHKTQuFi6Ak/DS5lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="38975810"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="38975810"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 15:55:47 -0800
X-CSE-ConnectionGUID: MbGUImMwTzSouvohZbF5Sw==
X-CSE-MsgGUID: b/NhaAsgRBS3kqwHgGjUaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="98745831"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.167])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 15:55:46 -0800
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
Subject: [PATCH v3 1/3] platform/x86:intel/pmc: Make tgl_core_generic_init() static
Date: Thu, 19 Dec 2024 15:55:38 -0800
Message-ID: <20241219235543.236592-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219235543.236592-1-xi.pardee@linux.intel.com>
References: <20241219235543.236592-1-xi.pardee@linux.intel.com>
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


