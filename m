Return-Path: <linux-pm+bounces-13087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D789634C5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2960EB2313B
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9891AE87D;
	Wed, 28 Aug 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVrfvHGV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E891AE039;
	Wed, 28 Aug 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884181; cv=none; b=NL/GPFF+0xa4uzEzb5xeVaQnbkptvA0dsUJ9RjN+4oAJ7pO++tCfcFUmfiNQGxcT3CnvviRWflVun9hJ6jWEos1vtkydbD6aLZto6SYXSrjzHorWd6oQ8cMn8dlav/fyWRvewWJat3GTO+ecxY0JYcPagZGNmDfNkuyjJLFTi/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884181; c=relaxed/simple;
	bh=9VP1sROSs5b5KFeBaNzoCZgvYbtwS2frW51HAmN2kdA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcNV92foCSQm0g1Gm0kcyLcQFTN0+03MZYBvU7apLGZqo+Zqd8eyAD8a3ztnGEH5ZbuAZYTJTvgaHf/b6dy6TBGzBzkgHKTvFOXtpPgK64JX3dhnWbOH0QMdEcyuHXtapm3tspm16w20d3aYV+KjeBqcfaf9QMdHVr4h2nApEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVrfvHGV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884180; x=1756420180;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9VP1sROSs5b5KFeBaNzoCZgvYbtwS2frW51HAmN2kdA=;
  b=LVrfvHGV3rZS6TNbIbSvthYn4sdnwNEGybffxcx4i8w4aCTmP73md7cJ
   mFK4I1i4TZhlVoOwVFaxiz1zpZuR6odygKgJIukkXRNAkMJAfEnHaW2PH
   TBU8pAIkrxDKiSNvoRzdHYtYXe6GFzOn5HYywSzRAPK1JgKg1Po3iq4xy
   1OOWnwVdyImhWxJ1Z83lwmlkxUzFVkJ3V70QeYg1wP+SHmIikU6LnK5Q3
   /G9FPOwQ6pcnrUMd/e7PLh/iobneGm7tk3c4ber/TCP9n1VooVKtmcBCQ
   3LaADW6uQ+W90F6ta4LpFNGiWv7whjTA/kkfBElp66MKcwn+uiM7TjRnW
   w==;
X-CSE-ConnectionGUID: X2IKvE/uSa242vC7+igWEA==
X-CSE-MsgGUID: fGnPlCQVRnK5FgBKReLaBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23406470"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23406470"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:38 -0700
X-CSE-ConnectionGUID: eiDp5pZVQhuFoDn0zcyjyg==
X-CSE-MsgGUID: aGe0OClcTBqZnLhNGpDctA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271800"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.220.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:38 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 05/11] platform/x86:intel/pmc: Remove unneeded h file inclusion
Date: Wed, 28 Aug 2024 15:29:20 -0700
Message-ID: <20240828222932.1279508-6-xi.pardee@linux.intel.com>
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

telemetry.h header file is not needed in arl.c or mtl.c. Remove
them to avoid confusion.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c | 1 -
 drivers/platform/x86/intel/pmc/mtl.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 870da98ceb41..0460715c58f4 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -10,7 +10,6 @@
 
 #include <linux/pci.h>
 #include "core.h"
-#include "../pmt/telemetry.h"
 
 /* PMC SSRAM PMT Telemetry GUID */
 #define IOEP_LPM_REQ_GUID	0x5077612
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 908b5f8bb6e5..e7f5b650902d 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -10,7 +10,6 @@
 
 #include <linux/pci.h>
 #include "core.h"
-#include "../pmt/telemetry.h"
 
 /* PMC SSRAM PMT Telemetry GUIDS */
 #define SOCP_LPM_REQ_GUID	0x2625030
-- 
2.43.0


