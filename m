Return-Path: <linux-pm+bounces-13089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748B49634CA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A742F1C2432A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B551AED5F;
	Wed, 28 Aug 2024 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lkhqp6BS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC741AE041;
	Wed, 28 Aug 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884182; cv=none; b=RiZqTENtYR/riiLPDJXTyPHc/uf5AOI4cIT1ExsAFtYhx23lnnGmku5eJ71tGcZb0+S4ElJ5R+hXJvx3lV8jHdoP5A/TzUevKwKJdGi4OWitWVnjbXQ8zuYV8Voxy1YQPvN4b9H4uMk0Rc9hGKyM8dNbVaexBS0ydUSWNGtVBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884182; c=relaxed/simple;
	bh=nlGzb2XDakMPfMwLsZ1Z+hsuuqOdD062OmHH1Ve/V68=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwYUNfIQ9lkAokBwkvGnQrP61OFZyw14Ra+6ej78fhCmSSoUSLFxSbb/FrTZ4j+KIXAxsUApHmbxxH8BHsGKIIoK0lsFHjqO4WytkKAC7dNRX0J+JE+DojWfk/4IZyLuna5bIFLuS39nDQ/a+Z4RhhR7tH9kkAZpQX9qEFOZ+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lkhqp6BS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884180; x=1756420180;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nlGzb2XDakMPfMwLsZ1Z+hsuuqOdD062OmHH1Ve/V68=;
  b=Lkhqp6BS0fgkBpMBxgtJC6kTYpujxiFaWXhPOzGtYaVkEtOGccOigfXe
   U8znVrxLuPO0TxvgY/P9HvNJ6dSiNRw9EdXVNs/npDScB7nOWlmqci4iP
   nVR+n14BIasTTXNEjgnUnw/q+PkJjg8pkbeu0dGAgMasWeVCYlEDzBNYE
   AZt1IOAyK74HTNUDrdTtryZpAeAa/sle/PvwtWOwMpliQhQKGioW+NPEq
   mvRABegTDf2xkpSNm7R4jh0lZPkKB+v50zuQn/EMYK1tcxNn7N7PjgrAL
   Dd0tp1z4YOgjMTTW4ztAx6GRZp/FsD1BriE9ncdkArdYBYcULSrSpaYjp
   g==;
X-CSE-ConnectionGUID: +QkpEe3sRFufJBmNHaZ6QA==
X-CSE-MsgGUID: sS08ARViRbqjMtLPUIDxOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23406475"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23406475"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:39 -0700
X-CSE-ConnectionGUID: oU6i8pJlQf+czJpF6GTxFQ==
X-CSE-MsgGUID: D6onQCTJRZWiT3cnEz+ulg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271804"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.220.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:39 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 06/11] platform/x86:intel/pmc: Remove unneeded io operations
Date: Wed, 28 Aug 2024 15:29:21 -0700
Message-ID: <20240828222932.1279508-7-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove ioremap and iounmap operations that are not needed. ioremap
and iounmap operations are handled by the caller of the pmc_add_pmt
function.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/ssram_telemetry.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
index 4b21d9cf310a..73c727042ca6 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -37,13 +37,7 @@ pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
 	u32 dvsec_offset;
 	u32 table, hdr;
 
-	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
-	if (!ssram)
-		return;
-
 	dvsec_offset = readl(ssram + SSRAM_DVSEC_OFFSET);
-	iounmap(ssram);
-
 	dvsec = ioremap(ssram_base + dvsec_offset, SSRAM_DVSEC_SIZE);
 	if (!dvsec)
 		return;
-- 
2.43.0


