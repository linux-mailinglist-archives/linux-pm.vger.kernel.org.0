Return-Path: <linux-pm+bounces-21570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18C8A2D10D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 23:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D404A16D647
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 22:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ED71D6DBF;
	Fri,  7 Feb 2025 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYXAhWR7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C21BC062;
	Fri,  7 Feb 2025 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968982; cv=none; b=BoPdwzwLUj2AdbmdqKEQMpurkKIsNZGVlHdYxqLcqHbCCxedve+2TlF6uPdlQ/1I9UQDJhbdhblGgRK8b6sPQtlotdMcdQ2517cXTWPlO/CE/b5HZMMOIixhjrIXzcHnBeXnj1OXhAG9L8E2GQuaPX3Y0BM3mwVZ8mirYaMDuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968982; c=relaxed/simple;
	bh=Qb8mX05iJ/CpIr04M1dcnLwoixs3E+DHs98OuuHeczM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntQa9VlE/U7uJgQ3ae7GEBMRO+U7YPrTeLhzc8/ed+B7/f9cTDy8feA34OSPgSNwNGPpl7E9MVmvGCx2PrSljRbih0/Eq99DVM6fu1rS9ZnriiH5t9LR493PTveCMhxA1sZeMIFOvkiuN3Kn+ASWWa2tEmHgxKRO0bG9wIFhw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYXAhWR7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738968981; x=1770504981;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Qb8mX05iJ/CpIr04M1dcnLwoixs3E+DHs98OuuHeczM=;
  b=OYXAhWR7PWLVdg2yOGZ3XGXn3FuM3J8+kYe1bsXJGIxubtiyg4NpIQ7L
   Wrg/P8PXMXzjjnPtzLcz7pfmDtsVS5gBxOol7VeepVJ1LX0Yt+eFGDs7n
   Ec00/kyQq0ABxahoAGGRRH4mxKrlvSXcdYGz9lhEfiVUNLh3MfX/GL4mL
   fb3pKww9JgGNx5q2w0iq4K8Fu+ys0Pwzo8F6gY8M8Jghmi+Lh5c/bNEF/
   7bXIakeASXxTan6L688tGA/JPDJMKb1PVssZrE2q5FNyctmmtCOTOeqqA
   7g7SRUSVvBxzWOLO2trNVkRoRkQE6MAVQmck+VQ/juT+cMKx0IydLFYCX
   w==;
X-CSE-ConnectionGUID: ps749xLjTmmgRZb1Xz48bA==
X-CSE-MsgGUID: D6JUDKPDT6GDUDaXzNu6wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38855803"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="38855803"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:20 -0800
X-CSE-ConnectionGUID: PAL+jOlGQC+aWrxR6y4uVA==
X-CSE-MsgGUID: ZtPC4VbtSEic9eLsdzdNOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111421969"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:18 -0800
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
Subject: [PATCH v6 1/6] platform/x86:intel/pmc: Make tgl_core_generic_init() static
Date: Fri,  7 Feb 2025 14:56:07 -0800
Message-ID: <20250207225615.401235-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207225615.401235-1-xi.pardee@linux.intel.com>
References: <20250207225615.401235-1-xi.pardee@linux.intel.com>
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


