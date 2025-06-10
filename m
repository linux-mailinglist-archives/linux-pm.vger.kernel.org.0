Return-Path: <linux-pm+bounces-28423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E10AD466D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 01:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66687174DEB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 23:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E85260587;
	Tue, 10 Jun 2025 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQ3rhmpl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0019260574;
	Tue, 10 Jun 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749596667; cv=none; b=qBvaQcEa+j6pLpLeKbPAwnWsF+GTyYQLhcOynJI+REJpW1he5ftD2XtcIa2G+LDcXf4G5GY7iIHAxqNO3Sp9yKpjeZySsO9I/ZJ49FItTwS8qtid3vURIkyXpgy0k+58M078M0O7KOrh6VSwy8q5x7oIQ+o9XK/wSHEhDkFZMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749596667; c=relaxed/simple;
	bh=4GaRJSVvYYYWC551+pTIXBffctNFr1XH5XMWYw7UG+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggCmqLBCT5YR7IOsdQ2YYg6U+E8BUCtA+mzefghKZv9j9WknEbru7EF1QV+V9auxnBhU44xEea9mX1y9L8IFJUMeP/bp8KCCfMUf2GTAuj994HknvUg033sviD5ZJ296serJxIjeYoAk4t6sZai1WU6ay0506Ak49z+QO7QXB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQ3rhmpl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749596666; x=1781132666;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=4GaRJSVvYYYWC551+pTIXBffctNFr1XH5XMWYw7UG+g=;
  b=KQ3rhmplrfRd0PhjX2KNhP2bWbh0FaUoFrXvZewD6d4jFN+XRjXheOt4
   CEKxhZl1Zy3ny/XrlAzqAAZhhGrt0oIDVuADKKrfaS5y+K10GAlQ4WsNe
   4aT7Qte2HJz8ir6svBMt9VDneeC83rbpjFv1uywD4fz92OVatn5WBl8WJ
   zg+2QAlBxCgGeq4ZMfFoeOxQaQocoY1hK68CJCRseJK1jVbCrrj1OZgLU
   k4bi6CdrtSkZazhToGHlkHOsIAdI2MFkZPKg7H+v2l6fhF1nJc6LWqIHI
   kjNO6tn3uIX19VsPS4rLV3IgPEvQLA8VucgHPGL3mNo5v7ZGqQxxVkZ34
   A==;
X-CSE-ConnectionGUID: OxZkJy4ZRKmfapRM4vLbbg==
X-CSE-MsgGUID: phy/fxlIQyWBsYySh0y8bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="50952206"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="50952206"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 16:04:25 -0700
X-CSE-ConnectionGUID: dMNyVREhQZCLI6iRjQsQaA==
X-CSE-MsgGUID: xfsckd/uQIqrsM14Z5ACcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="151966011"
Received: from iweiny-desk3.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.220.200])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 16:04:22 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/2] platform/x86/intel/pmc: Add Panther Lake support to Intel PMC SSRAM Telemetry
Date: Tue, 10 Jun 2025 16:04:07 -0700
Message-ID: <20250610230416.622970-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610230416.622970-1-xi.pardee@linux.intel.com>
References: <20250610230416.622970-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Panther Lake support to Intel PMC SSRAM Telemetry driver.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h            | 4 ++++
 drivers/platform/x86/intel/pmc/ssram_telemetry.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index c1db41cb8334..4a94a4ee031e 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -302,6 +302,10 @@ enum ppfear_regs {
 /* LNL */
 #define PMC_DEVID_LNL_SOCM	0xa87f
 
+/* PTL */
+#define PMC_DEVID_PTL_PCDH	0xe37f
+#define PMC_DEVID_PTL_PCDP	0xe47f
+
 /* ARL */
 #define PMC_DEVID_ARL_SOCM	0x777f
 #define PMC_DEVID_ARL_SOCS	0xae7f
diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
index 24d5d01805c8..93579152188e 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -188,6 +188,8 @@ static const struct pci_device_id intel_pmc_ssram_telemetry_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCM) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_LNL_SOCM) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_PTL_PCDH) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_PTL_PCDP) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_pmc_ssram_telemetry_pci_ids);
-- 
2.43.0


