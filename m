Return-Path: <linux-pm+bounces-25041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE4A83026
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571E03BB8A0
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C627C166;
	Wed,  9 Apr 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIRMgaI7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F45C279339;
	Wed,  9 Apr 2025 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225867; cv=none; b=chjLZlZDIPez8s36yD/QOPYHmiPm/kOUMp5+p8DBtDYEZUTBniPA911MO3XOpVC/P5RYiuJ+0eF33saz1RY8PCh/E/xCWwgCSiqks2YGBFEm6AtA6ETvxoNO0u9fkwCwj3bc9mdmaazh751ANtie/QsPBLhBaVmtgQaAcCKfKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225867; c=relaxed/simple;
	bh=5E5F+hoLjXVP6FXdkytWJ2SovbB7Tk5Fht2M09TyW7c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yx2oK3UsXTDKiEDmbgiTUnHFept3693mySQmKFaGB1RMDXaS/bKYM8rTgIU8187dWJNuA2Z750jmWga+pjnlnjSPvQA30Tm8SsHFavGSaFxUGGEb2KHoL40CeRVjbA16zuK8Bt5CykXxzLrFTx8tYYqz/4iEnaJyi0hg0yUzfLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIRMgaI7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744225866; x=1775761866;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=5E5F+hoLjXVP6FXdkytWJ2SovbB7Tk5Fht2M09TyW7c=;
  b=lIRMgaI77f6YXYmCK6yZEE2sDYA1obq4q2c6BgJ4g2/VPmJk7GbKSDE4
   jai+KoMvsWShOhkK8CQSHqtoQqC8oZJxocFf/loADCXrgL3yPtjZXr4EF
   fvBHhiPad6LqQK5UyPpa2/X59u67xuCdTEHX8cH6FrUGHCSTzyQ+FDxuy
   AxlfOS5jhOlixLXTiYcwgSwv4TBn0XOegD3WflRE//JzHL9/5WWotUimL
   1dC55oCmbGDJjMa1Qhn2Wai0DA4p6ouVq0delW2QNnXSeMRCEpA973pkK
   lLSTttkVTbnJ63QvxP/01FO8Z6Bq0RGu5Jy7897JPSUbkgiwPeHUoXQ63
   w==;
X-CSE-ConnectionGUID: 94qgZo5OS7qwLYc/u+yv1Q==
X-CSE-MsgGUID: xrFgPBtnTfefP3LGDNDMlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56386778"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56386778"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:03 -0700
X-CSE-ConnectionGUID: ADAd8pF6T6eRaQtn4TKhTg==
X-CSE-MsgGUID: 6U/5FiOAQUeD2a1oQV1pkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="133401264"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.250])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:02 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 5/8] platform/x86:intel/pmc: Remove unneeded header file inclusion
Date: Wed,  9 Apr 2025 12:10:47 -0700
Message-ID: <20250409191056.15434-6-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409191056.15434-1-xi.pardee@linux.intel.com>
References: <20250409191056.15434-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

telemetry.h header file from PMT is not needed in arl.c or mtl.c.
Remove the cross-driver include to avoid confusion.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c | 1 -
 drivers/platform/x86/intel/pmc/mtl.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index a6b2eb850ff0..0708221d3af1 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -10,7 +10,6 @@
 
 #include <linux/pci.h>
 #include "core.h"
-#include "../pmt/telemetry.h"
 
 /* PMC SSRAM PMT Telemetry GUID */
 #define IOEP_LPM_REQ_GUID	0x5077612
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 8f1b01657277..faa13a7ee688 100644
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


