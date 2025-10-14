Return-Path: <linux-pm+bounces-36097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D079BDB701
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 23:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571FA4226D2
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB530B51E;
	Tue, 14 Oct 2025 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLflx9dQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321582D3749;
	Tue, 14 Oct 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478384; cv=none; b=tPlbBS033Tcyzex+C75F/udQl0js/eWi0FmJk3IpYj4At/CMmYQby8RFekBdmgvkf2Dvk8Bgr2czeZba2YQTffLXCHVs7L9g5x4G8L2drySgXxiY+ko2GUUWLchfCXyKSLIT7Ozi/jtNUMqSITfoi2lCEAbF68jGh3z1ge/+s4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478384; c=relaxed/simple;
	bh=9z4sJflRZlFVsU6z+XkSzIlopS8nIYwgDN1Fo3HQpGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpOvWeAsO7kcagBCn1myVVjDHuNf4ISdPEXvDOGOkVKmHkgIfiPR4BpEs78TWRuv42D5U4VpoNWAoRDF4etZrYScPYsSNcBDGv1YmZmiJCUsZYsdR0TfhPT9doj1oPUPVrh/LDcwdlx2718a9jkjh80MC3rNxGct/IX7+TrhTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLflx9dQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760478383; x=1792014383;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9z4sJflRZlFVsU6z+XkSzIlopS8nIYwgDN1Fo3HQpGU=;
  b=MLflx9dQgaMcrIL0qncbLFSKhlp/U+nCnE/bixxPhlr2FfafEg8cy9Rh
   n37H2uBnkThTTQYJnIoOa7TyIRcHgQhkIEEd8aXJstLSTTOdVk/7DkVEu
   CCfB0XGyKzMrZ/3goCJunggU9Erl3LBgDGhHSGr4/15d9Gfw4L+TUfI/1
   CO2JYUsRCCg+rHjc9A5bUfFTSDooUB/nkd7XEP0BlpeEYb68zuEi3ydaD
   xS2J9shNRQ9KB8BMu/Jao07v7PDnH71bH0FtMkaZ6ccUKdwWkMnq8iT/H
   zOSemBvar+nGnS/WB+6tjlla0sm+Mly9tiqSRbFIPBNAaXxWnrDKb5M2d
   Q==;
X-CSE-ConnectionGUID: DoQrKxSXRDuMv4x3bbtMWA==
X-CSE-MsgGUID: VT6rKKXMR1WPvj80z6rWkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62682439"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62682439"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:20 -0700
X-CSE-ConnectionGUID: QTzVV89DSXGlxVbF2EjaNQ==
X-CSE-MsgGUID: Sc0nLIlOQ8aT9bHvV0Wq7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="187300318"
Received: from kcaccard-desk.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.111.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:20 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/6] platform/x86:intel/pmc: Update Arrow Lake telemetry GUID
Date: Tue, 14 Oct 2025 14:45:29 -0700
Message-ID: <20251014214548.629023-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014214548.629023-1-xi.pardee@linux.intel.com>
References: <20251014214548.629023-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update ARL_PMT_DMU_GUID value. Arrow Lake PMT DMU GUID has
been updated after it was released. This updates ensures that
the die C6 value is available in the debug filesystem.

Bugzilla Link: https://bugzilla.kernel.org/show_bug.cgi?id=220421
Fixes: 83f168a1a437 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index f4dadb696a314..d6818bd34768e 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -282,7 +282,7 @@ enum ppfear_regs {
 /* Die C6 from PUNIT telemetry */
 #define MTL_PMT_DMU_DIE_C6_OFFSET		15
 #define MTL_PMT_DMU_GUID			0x1A067102
-#define ARL_PMT_DMU_GUID			0x1A06A000
+#define ARL_PMT_DMU_GUID			0x1A06A102
 
 #define LNL_PMC_MMIO_REG_LEN			0x2708
 #define LNL_PMC_LTR_OSSE			0x1B88
-- 
2.43.0


