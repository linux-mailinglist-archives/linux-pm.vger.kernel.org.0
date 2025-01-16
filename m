Return-Path: <linux-pm+bounces-20551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6B2A13D8A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441AE16304E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 15:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E2622A80E;
	Thu, 16 Jan 2025 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0uUZ5yx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED668143736;
	Thu, 16 Jan 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040921; cv=none; b=l7eqCb3RGqy8dnluYQPhBd3G/et4Fj3iHIhpiUskEwCy4ClBpXMQj0QQ1um3ue6UAREGYwNlLn3D0aCXFxzL+YRj0T7G/23yhywH59gq/AO8UiTBFIgOSXMZes6L8TI5+5TL/rhCXOe27Loo4Zi7TsDPypvq+G7l3V+1xHsUWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040921; c=relaxed/simple;
	bh=hpTmuDSx99mcNdj7IgKZsn5fO2X25FiEwHgjt2k4yUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RN4nzvtIuWhWsi5yLVzBwXDhwPE4LPwuQG+1X0KoLjzvu3/74bisncylFvc03N6mNax6qO2KVzVQi/OmXVpYMwx3Un5juws+XvudA+yFqAx7PDNPsWRq5KSOMIgM7tUpFKKn21UUoa92mD647aQLqsuWhEr7eBJn6A6NHjvEZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0uUZ5yx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737040920; x=1768576920;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hpTmuDSx99mcNdj7IgKZsn5fO2X25FiEwHgjt2k4yUU=;
  b=N0uUZ5yxBSfeltOXp3TP8mS8+Sb3GYLpVRJMOE6xWRDNcqjhzSvEuFwo
   97PhCs0knYalRMv6q5DCtCiOvJAjhCtuxoKTlgcZLbMcXwWmauPUfGhra
   lSv/A0ZU8N5wE88E7+YPDC8ucNmcd6eQdEt0Nhdj3sYs4k4Gj+v1Tg4CA
   actFE/50ba9FqLG37wCpJFxlx7l2hepGJ/8+CdJ7zpNmko07RdgNSSzMl
   h4vsJw7rVn95sBXa3JyHsflhUVwkQj+DEHlnox2w7+h6ckSwuWomFAiXk
   C+o9ibh+UbpdhtZhpbOAMCwdc2ve1WDOvA9bC2mCYrmnO6SenzGWyrAQ8
   w==;
X-CSE-ConnectionGUID: a/B4djcsTwOigfY0iliqhQ==
X-CSE-MsgGUID: 7iachxJMR4S6toHeWYLulg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37315519"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="37315519"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:21:59 -0800
X-CSE-ConnectionGUID: KdFLg4+GSPquvUJbgsKqNQ==
X-CSE-MsgGUID: +kOFyR8/STarX3vscFrd+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105374478"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 16 Jan 2025 07:21:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 22D0139C; Thu, 16 Jan 2025 17:21:56 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v1 1/1] PM: Revert "Add EXPORT macros for exporting PM functions"
Date: Thu, 16 Jan 2025 17:21:51 +0200
Message-ID: <20250116152152.147048-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introduced macros are not doing what they intend for.
Also there were no users of them for all this time.
Drop them for good and to avoid possible misleading.

This reverts commit 41a337b40e983db4f0e1602308109f2b93687a06.

Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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


