Return-Path: <linux-pm+bounces-29593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D6AAEA2EF
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 17:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205361C20088
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01D42EB5B9;
	Thu, 26 Jun 2025 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCf2Gi26"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615082EA15B;
	Thu, 26 Jun 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952573; cv=none; b=uaNdENjf4l11MIR9zlhyYt5pRs9UEj3O/og4j1GT7IbBS7yZdQgjDAD5T0J5JZWchbolWpt+3J2UM5on9v9ZdOeeiNPPvv+d3GtzKWgco+RlmmybP3H7j2hLLOGU1n3and6h5+pNtVi9tDRtmd/8wqMLIoYpdlqDzsVoW3PDxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952573; c=relaxed/simple;
	bh=9SkHtZxkKa4k+jvotniYhYkbr2Lu60S9ny8pN/OzFlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nGpiCiCdOfZ6/Cx7K4rat/8SbM0pBsozr2fPNaohk5ta+Ng1R4eKc6V04G8ZXoKSoiay7j+gqi22InpAVJrDm5dK6ZgMCnZMzi6qX1QAOQl5x61BQFVTlqiHCqOu6V26tS0gucRkAxzm9LJcMLCWpYu2EHi2bPOGc6jSI5pmmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCf2Gi26; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750952572; x=1782488572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9SkHtZxkKa4k+jvotniYhYkbr2Lu60S9ny8pN/OzFlw=;
  b=WCf2Gi26ALt5qjreLWGMeNH5vSG8lk9cCbZrxA5xJ8HU1oyR2Fqd8STL
   rPYmXSXRYy68PiE+OdNZRvfAQwkfoNsXl8O383hNgY665dhWgBk9f7uj2
   j4vYXOt1ZdvV5fz+m1QPHTaRCAQq+eWP7MOU0QdtKTVT+AVvdJ3CIn1VQ
   fzviq3uV4+axg6sr+6mT2wmzT1/m3w1/dRw4EBKsNEzO5naoFr8761rMZ
   xIAYJGTP1gxq6xCvlDx0ygZAVS3nRo7n1pYTt9u8YQ4m5m5RMrFsIhJbG
   GeNwrMjPigEt5khAX3TIrZzDY5LiwH61TLNmFddCKiWXQ2YRKVlHF8yTq
   A==;
X-CSE-ConnectionGUID: j7S5UOWQT7yTQGK9DIjoFQ==
X-CSE-MsgGUID: QDyDYET0RBKd0kTqs3osuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="63853748"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="63853748"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 08:42:49 -0700
X-CSE-ConnectionGUID: dlmsMlmDQIC0uR695N3/3w==
X-CSE-MsgGUID: gI7PB0ehSBmYN0pCQtVb7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="189743175"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 26 Jun 2025 08:42:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 23A9D2AD; Thu, 26 Jun 2025 18:42:45 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PM: Don't use "proxy" headers
Date: Thu, 26 Jun 2025 18:42:44 +0300
Message-ID: <20250626154244.324265-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pm.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index f0bd8fbae4f2..938b1b446a5d 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -8,14 +8,15 @@
 #ifndef _LINUX_PM_H
 #define _LINUX_PM_H
 
-#include <linux/export.h>
-#include <linux/list.h>
-#include <linux/workqueue.h>
-#include <linux/spinlock.h>
-#include <linux/wait.h>
-#include <linux/timer.h>
-#include <linux/hrtimer.h>
 #include <linux/completion.h>
+#include <linux/export.h>
+#include <linux/hrtimer_types.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/util_macros.h>
+#include <linux/wait.h>
+#include <linux/workqueue_types.h>
 
 /*
  * Callbacks for platform drivers to implement.
-- 
2.47.2


