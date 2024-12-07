Return-Path: <linux-pm+bounces-18732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B679E7E5E
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 06:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7F21887565
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 05:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19886252;
	Sat,  7 Dec 2024 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvLliw3e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA892E822;
	Sat,  7 Dec 2024 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733549776; cv=none; b=Io46F+bxNV8XAk4y9fVgjZg0rNvfcMyGJjV1PhRUMS+ETAmrOEmQOJa2vVMugqV5GCLW2eIDCZHkRvqCfNf8XB3B6o/ceh/QOy1e4Hk7bdxmr+0+B+SI8YT0A44KUEZ8QgQr6puOLAGfMvtmWJgq9KYeg4KOI+SuayxGmWBMw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733549776; c=relaxed/simple;
	bh=3Sg1wHUHcjKFeWG4YP1Bc6fjnbiiwRV+JHhkOUdoU4I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xng0KMPE/lZJR5/j/06vEqDzNn5hizt0Vy2m181tPQbDRuYF+itaSPHhbZasq8aSrc6DhzNl9KNOd6JZB37CblIeUBChApsZEf4gV2MOgQmmMzMnLgmFSKsgn0YGNnH3DnQcYp8QHP6zxOdTEb7PVgOvmlNNrF41Fw/z4g4DrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvLliw3e; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733549775; x=1765085775;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=3Sg1wHUHcjKFeWG4YP1Bc6fjnbiiwRV+JHhkOUdoU4I=;
  b=kvLliw3edgHaJcFBq5lHxHL6guTlTmsYMpf/bGq0P52eb0n+wWOyFIya
   hbSrMz2U6Tm42tE+50wusr1ul0UnSx6nepqWZ5NrxHa/M99iEDugTjIxO
   UJI0C/wlneD/rfq4tL454DWZivq7qHfKOL2KxzFC4IhGLhLEtXAP61bw8
   dNQLEjHoSXWAJaQew9Gg5dTnhl3zGOnYM9qirmLk+Yp7vCxaJsSNO9h2e
   wUz4oiv6jc4m7RSYVD9iZ605AiF5Tfg2RoixqY70NKa1W1NfvKzjgkiCY
   EltDFCinmbhL8w+Yz9wqgMMqD95WyTravCio3+6cKkwI4F8SJxjWySxeh
   Q==;
X-CSE-ConnectionGUID: hxIIyFcpRaK6zXYFBaus+g==
X-CSE-MsgGUID: 0nNuUvDGRwqyohUhYi4vzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37590264"
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="37590264"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 21:36:15 -0800
X-CSE-ConnectionGUID: /p3olTmYTbScE+9IR8RYyw==
X-CSE-MsgGUID: o+e5BdygRcWCA8trUKQ8tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="99543369"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.37])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 21:36:13 -0800
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
Subject: [PATCH 1/3] platform/x86:intel/pmc: Make tgl_core_generic_init() static
Date: Fri,  6 Dec 2024 21:35:51 -0800
Message-ID: <20241207053607.14806-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241207053607.14806-1-xi.pardee@linux.intel.com>
References: <20241207053607.14806-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make tgl_core_generic_init() a static function as the function has no
callers outside of tgl.c. Remove the prototype in core.h and reorder
the code in tgl.c.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
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


