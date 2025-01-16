Return-Path: <linux-pm+bounces-20555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB8AA13E0D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86995188BEC2
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E941D22B8D9;
	Thu, 16 Jan 2025 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYfTPtzz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720422B8C7;
	Thu, 16 Jan 2025 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042248; cv=none; b=pwgJthW7vqKyRuTgGtQVItpszaFXzsFr0iIgXoj7+4rAnEXQGMaHrrVPeAWNscvTay0eL8FugYTbKJUmioXVSpqyDD7hsgXY67lR1D8/TuRKOL7/anqKwLtQ01bGeTgn9WC8qQA9vxx5EHUtIdY6WV5rCCx3zKkV6d+yvUxiwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042248; c=relaxed/simple;
	bh=gYpIf6QxJKEt+I+7I0jnGEETh673/Iu/2e1h2YL8aD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9tw4+J4hYvl82MWUSeXRn0+2VpjVyf/oxLVzPDvXz7QuMPY1yO4RvvyBvQy8GhfvHp65kkZbrJhA6/lX+ueYymM1CUwyUUrZeyZh6QqXV3NIhuZGNNCN2ydssiVhZ8B8tqiPVyqhuSz5ReTT82JLxnAga6hAzF6booShK5Invc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYfTPtzz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737042247; x=1768578247;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gYpIf6QxJKEt+I+7I0jnGEETh673/Iu/2e1h2YL8aD4=;
  b=nYfTPtzzU8Lbf1Nfb5HGPrv/Uv8ac8+JHVyBWuA0tR93Wcd5AwigAUhi
   Am/QRRKmMIfomneZevY18VYlACM5Plos1NuJvaowmwBb2gqPDMO1Dik4a
   JY1zsX+727mkbXHl2k75VT8JX9fVUX9BLHU/7g9+mVEWWTATrK/Oi3GJP
   J2IWKrQ9HMw1cwIDZ3I1/uMgP35fA17OEhg6wHt6Be1RpbRPCRsRdSPQ3
   agGnrUjOH/bUeEgUi7oSKsYkuTJNF6iu0ap55hpzEH7T5t2jJfdhJIvap
   Af6+Y5awqbtXBYd2ENIoSjbfIUx12mwUdz6iGylVtUkZ2y/HP2VU8g4AN
   Q==;
X-CSE-ConnectionGUID: gMkHfJxVRQGR9noGcTc/+Q==
X-CSE-MsgGUID: dBfWZhkTQrCYgsDt+HDxxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48850389"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48850389"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:43:59 -0800
X-CSE-ConnectionGUID: rrYC1anVTlyr5eSvfxuxog==
X-CSE-MsgGUID: BK6hIwUDSX6pbdIF5sU3wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110157851"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 16 Jan 2025 07:43:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B4BD239C; Thu, 16 Jan 2025 17:43:55 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v2 1/1] PM: Revert "Add EXPORT macros for exporting PM functions"
Date: Thu, 16 Jan 2025 17:43:29 +0200
Message-ID: <20250116154354.149297-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introduced macros are not doing what they intend for, namely
they won't eliminate the code when CONFIG_PM=n. Also there were
no users of them for all this time.

Drop them for good and to avoid possible misleading.

This reverts commit 41a337b40e983db4f0e1602308109f2b93687a06.

Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: elaborated commit message (Greg), Cc'ed to the original author
 include/linux/pm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 08c37b83fea8..5dae93817141 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -384,12 +384,8 @@ const struct dev_pm_ops name = { \
 
 #ifdef CONFIG_PM
 #define _EXPORT_DEV_PM_OPS(name, license, ns)		_EXPORT_PM_OPS(name, license, ns)
-#define EXPORT_PM_FN_GPL(name)				EXPORT_SYMBOL_GPL(name)
-#define EXPORT_PM_FN_NS_GPL(name, ns)			EXPORT_SYMBOL_NS_GPL(name, "ns")
 #else
 #define _EXPORT_DEV_PM_OPS(name, license, ns)		_DISCARD_PM_OPS(name, license, ns)
-#define EXPORT_PM_FN_GPL(name)
-#define EXPORT_PM_FN_NS_GPL(name, ns)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.43.0.rc1.1336.g36b5255a03ac


