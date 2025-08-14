Return-Path: <linux-pm+bounces-32413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0DB26FDB
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 21:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973C73ADB06
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 19:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FA9246789;
	Thu, 14 Aug 2025 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d89+KTlM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19061246333;
	Thu, 14 Aug 2025 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755201132; cv=none; b=lQzqrYSlmwDOwTaD9hxofIWoPfmizbNC9n9JjxcYAHECnG/HNy+2ooLLPHW6wUX+u+pjsbe2N4+TzqSYPrQ7TsUNC36KioTytQzfdZ/dnXeXY1N2rLn4q6FZtdYpF4CUSB5m3frYDBJpPc+HOGKdgMRVmaJGlQe8swe5ze63MFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755201132; c=relaxed/simple;
	bh=e1kx8I4goW+FE7U2pIi+3XcbDQGU5mWZJu8IWiQByck=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WU+5QczGsQyCMZEvT7rCISJU2CZLSwFvdw9fnlN8U1Mql6UFcm1GIZWmkU698Uamn1IQ1Vu4CffQTpwOm4ZVqNNyjzjnb7X82bEO8kscpoS2y3QTC++X1lCLM8hwCZYMMO9qIx57ekua/sAGeU8jCdUbTOhLz9cctiyzTX7VU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d89+KTlM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755201131; x=1786737131;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e1kx8I4goW+FE7U2pIi+3XcbDQGU5mWZJu8IWiQByck=;
  b=d89+KTlMZakYD9yeD0WRYtgJeWFKf97UxP4WT99IWESqeT1ZYrJ028+/
   xpi17z/IXJ/tvVf6I15xGNN2WAkAbQP0LqwPeCgzRHPL99ump1WEGzRf7
   uzwl8sWldbhxXDGKzsb+EEiEvx/+hMrQpVSQ2O29XDz0iq07f1hYg2V2D
   jFfRhRe+KLBzzh8v20sYuHs23+TDeA5fo9CHJrnLVU0TueR/O0IkYnnz1
   /BvhiNVZigT7byBzr7J+wwT60EwLKFekNMOi2JGxo9U2uLmJVsB4Q7lvb
   mglfEQCZK/jUtLOJlfxIVdkB09cBlaXacz+/TzvmZ4nc/A/qjkv3QeGtT
   Q==;
X-CSE-ConnectionGUID: +hjcA+W+ShqR5xP6k5kfmA==
X-CSE-MsgGUID: fdh+KWaXTH6I/boKzXQPOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="56734453"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="56734453"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 12:52:09 -0700
X-CSE-ConnectionGUID: JzYJ0BXVTniCPgje69JnmA==
X-CSE-MsgGUID: Sk2Lw+A+TNKbDQjFbJbs1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="171082797"
Received: from jjgreens-desk20.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.223.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 12:52:07 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mpearson@lenovo.com
Subject: [PATCH] platform/x86:intel/pmc: Update Arrow Lake telemetry GUID
Date: Thu, 14 Aug 2025 12:51:35 -0700
Message-ID: <20250814195156.628714-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updated ARL_PMT_DMU_GUID value. Arrow Lake PMT DMU GUID has
been updated after it was released. This updates ensures that
the die c6 value is available in the debug filesystem.

Fixes: 83f168a1a437 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 4a94a4ee031e6..24139617eef61 100644
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


