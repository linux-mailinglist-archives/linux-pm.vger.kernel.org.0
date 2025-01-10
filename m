Return-Path: <linux-pm+bounces-20168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A1A083E9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 01:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7299D188C05B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 00:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972F36BFC0;
	Fri, 10 Jan 2025 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVT8ElF8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24D29CE7;
	Fri, 10 Jan 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468781; cv=none; b=oviZHQSSc3LXou19l4cxJGRgXCa+K/4/oFsnA9g4VyYP+3S8PvXJOTi/7zIpG6S8DCoTFKXILJd46CAs9UK05eSa4WMZaSWgi0YVY3CYLoi1qR8qxq10gdyA0Zn5Se1KhyS9KxvCp0tLxZMoWdC4g/8lteF2Qe0NiVuEbJ8Pgjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468781; c=relaxed/simple;
	bh=Qb8mX05iJ/CpIr04M1dcnLwoixs3E+DHs98OuuHeczM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LE329n0mi8GVFu1P84HHDjCUJUxjUwv5jJ9BiR/G8XX/fWmefyLRBM4HbJIhKIFH4l8u0Il++f3ey4WjLjv0uagQkQek3PnYgJTDFZENXETThMS5YxmKudFaLfkXg4FX1pj+C/dPOQWnIys0M+1cpUhLYDhXge8ZFMKXtCyLHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVT8ElF8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736468780; x=1768004780;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Qb8mX05iJ/CpIr04M1dcnLwoixs3E+DHs98OuuHeczM=;
  b=QVT8ElF8N7aqNkrtq2ZMr5AQBblxOjLg92aWUmTqw3/Wd3ciB5U9/nLp
   AcKs53AADAo4xn4DmhqVbfq99ThLF1of7uoPSAfCVpMpi7G1N6KbDvdVP
   +z16tTimoJ1f+gBMUKjxOWfigUG8v2TLbgQqeXxRDlprF3On3PQAjqkgF
   noJWe2mnaw8ahtGpmF4xuEd9luY35klLJZS7KKg02Zho+QA5wN5VUk+c7
   DNZ373/ardzeQ7UVs6brMxggnizH9MLQ/IPsHpk7yuznZPp7e9pzN8xMj
   hOI0eIyEOgeTMgBjXRnoRoiQgU9EnTfFeCGk7Y733KAOysNy9P6nEemvF
   w==;
X-CSE-ConnectionGUID: OOYUHEZaTDKCANSR5MLDXg==
X-CSE-MsgGUID: Q3Ai5dUFQH6fZalX2kHSHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36653479"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36653479"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:17 -0800
X-CSE-ConnectionGUID: XppYVglXSeGfNbYJ5IvLgg==
X-CSE-MsgGUID: vDVsJmdGQkup+uWgKW/6gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104097023"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.222.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:17 -0800
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
Subject: [PATCH v4 1/6] platform/x86:intel/pmc: Make tgl_core_generic_init() static
Date: Thu,  9 Jan 2025 16:26:03 -0800
Message-ID: <20250110002612.244782-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250110002612.244782-1-xi.pardee@linux.intel.com>
References: <20250110002612.244782-1-xi.pardee@linux.intel.com>
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


