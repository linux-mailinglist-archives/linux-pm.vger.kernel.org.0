Return-Path: <linux-pm+bounces-26465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EB1AA4EF7
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 16:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1CF3BB0CE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B6118B47E;
	Wed, 30 Apr 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNezmNMv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B3149DE8;
	Wed, 30 Apr 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024403; cv=none; b=jEF/NapnWpni0eW8lxLxZ42raL1cKnij5YZTuJLtG59/Wd8rOfdptDItYaeoQiBoTOG+brDzuIQ1sGzeon6/wsU7OpSbkjImROVcIRPgYOGv6CtguTCa5o3a3AXQ6LDPy8ChT8BgbWY0betgCIdngfFJkKcioi6Lm7QgoB04lfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024403; c=relaxed/simple;
	bh=gJY5KpuGymBc06cwncC7Fx2bYurfhjxAo/SRBqouwtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N221FsiWryTbyqZ1Zhfj2ygRCGzM+gBrC/5XgDvmqu97xy4EO8r209rSWyx+iPO1KeQo3huBIu06vZXJx1TaxHPPHWhVetkG8ycMWN+oj7osPFdA5DWmYw+rXtx6Zxz/F6c7OtxmMSH1EXsm4ctH57ASkU5DQpyqS3/v+5HraMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNezmNMv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746024402; x=1777560402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gJY5KpuGymBc06cwncC7Fx2bYurfhjxAo/SRBqouwtU=;
  b=eNezmNMvLaauO5A6/wj8H1MBDLj/IZt1HiZxgctz3HLlPJBkvJeIIQZZ
   m+OecX1QpqrSJBO/P6e74sCr9mt55qczKjgkaX4INRWRoKi4o+rcTvpTx
   bCprQrn4Zu3M1d6QWk3fVjHJy7GUrFPCMs50ewarMoiSHvKhBGkgY94Lm
   6K5PRRqVueFkxgPw1UytlJVDynkB3mbQmKjduQXVFHqa95r1WV8PmSGgT
   TvZNLowqrjHtrT0/hkxtykE0y6ZT9qjKjwIGUHd85o3rJShLh6KScuqiy
   Rz0RTOfZI/Jr+9hd4982hbWfIYRLWt3VjRIImJ8iZFP+hl9vHA3WpTW6l
   g==;
X-CSE-ConnectionGUID: D6ZfClphQq+48xxLSQQUCA==
X-CSE-MsgGUID: S/Avg8K3Rxms+zM3VTeZRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="46933551"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="46933551"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 07:46:41 -0700
X-CSE-ConnectionGUID: 2wrjLOIBRrGWeaAPg2HhCQ==
X-CSE-MsgGUID: VwNQe1UnSdeD4loCSfEDKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="171374969"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 30 Apr 2025 07:46:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8BD6C9F; Wed, 30 Apr 2025 17:46:37 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [rft, PATCH v2 1/1] PM: Don't use "proxy" headers
Date: Wed, 30 Apr 2025 17:42:13 +0300
Message-ID: <20250430144635.3714821-1-andriy.shevchenko@linux.intel.com>
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

v2: fixed obvious missing hrtimer_types.h include (LKP)

It may fail some builds, let's wait for CIs to report any issues before
applying this. But I also encourage to test it locally as much as possible.

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


