Return-Path: <linux-pm+bounces-13732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A9496E23C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 20:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74025B25475
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D2188A02;
	Thu,  5 Sep 2024 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ze+tsMpD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9AA18594F;
	Thu,  5 Sep 2024 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725562136; cv=none; b=uR1TBlsLVbsTXRgIZK0WxhBS+i6niTYZU8Vg7jr0xEgB4idh24q9QIdUM9MS3/e7P4j6PoEdj7Zo+ZxrTeiHLojkEL2W/SSY/LF/s2Ck6NdIfWrS8qQSCQcXP0lFvp/IYQ0QtUf++zT7cv1rQniYrHminfhbb6VZx4KTELV1LcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725562136; c=relaxed/simple;
	bh=ZljIkKUS2LF56585H3POgSW+/xG8s5rlvOrzZoy8J/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NiUn9l2BBhix3m0cJhGKkjYEncq1q/R3Cr3UZrJdqR6gylYFn9+/SutD18wULjpx0QkOxyYpSytjJZBUyeJczLAHvkwlBxFFTfqyrItnDVmyR0QRdm85Olm4fL2O/q+gSYi8P3nuiCbNyZ+ptb/22ZNkPQ71EJ/tU2NSBcCC0I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ze+tsMpD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725562135; x=1757098135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZljIkKUS2LF56585H3POgSW+/xG8s5rlvOrzZoy8J/s=;
  b=Ze+tsMpDXUz9mF8CKTKHuMjM9aP9DB2WQP5NglkoNuDbfXo0shzqoljn
   2QzkXYSJkqC2WlNRuTtkzN8epAu0cNycv4vwiSXMwSMw1fL1w9D2sOXG3
   wHrs7NSEQdo2qUbMfHvaUZ9/evf4KJIeXbc/kXnBYWpQO98eoAm+Kpixe
   A3/RYc/NxHcfw7FbLnnPnVW3vcD4CmyP6QwuyVosEaIl+LonsYZo1dvPV
   Nl2NFMGoJT5rI5wwhaUthN1kDDOej5VBTYAVjdQz4Oxdb18odq0xW+E++
   RaF/wuVXFjIqNed77AEPj8tD9OKB7Bmg9FGoWs0p+GnpjFFbp0G6Ag5LR
   w==;
X-CSE-ConnectionGUID: ELC9Ksm+T7yCK649IgpyVg==
X-CSE-MsgGUID: nwzT1wdCSCWhiOrvZz3mfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="28187977"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="28187977"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 11:48:54 -0700
X-CSE-ConnectionGUID: /+wtgG3KS+ydmXMb+ufECw==
X-CSE-MsgGUID: 8YAd/cYsT/GUYAOpERb1KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70523400"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 05 Sep 2024 11:48:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4D90B31E; Thu, 05 Sep 2024 21:48:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PM: hibernate: Remove unused stub for saveable_highmem_page()
Date: Thu,  5 Sep 2024 21:48:48 +0300
Message-ID: <20240905184848.318978-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When saveable_highmem_page() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

kernel/power/snapshot.c:1369:21: error: unused function 'saveable_highmem_page' [-Werror,-Wunused-function]
 1369 | static inline void *saveable_highmem_page(struct zone *z, unsigned long p)
      |                     ^~~~~~~~~~~~~~~~~~~~~

Fix this by removing unused stub.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/power/snapshot.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 405eddbda4fc..30894d8f0a78 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1365,11 +1365,6 @@ static unsigned int count_highmem_pages(void)
 	}
 	return n;
 }
-#else
-static inline void *saveable_highmem_page(struct zone *z, unsigned long p)
-{
-	return NULL;
-}
 #endif /* CONFIG_HIGHMEM */
 
 /**
-- 
2.43.0.rc1.1336.g36b5255a03ac


