Return-Path: <linux-pm+bounces-38503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B79C82756
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 21:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EDB3A9D8F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 20:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560DE2E2840;
	Mon, 24 Nov 2025 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGJifXEt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848E258ECC;
	Mon, 24 Nov 2025 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764017883; cv=none; b=fVO4qmgIMIBQHvTQ2NT69CShdDSeF6P16+X/D1Jx4H/Va497k4oHN+3t60DphdfanHuQG04vObMmD7MOXKpuxHuCkOR4oEMw1bV90u7zvw6IXTdQvCtTJyBnsmI868UsTqSf+acCZWSwwBF5BIGBO7A/Pkob4FqSjoPrReWF3Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764017883; c=relaxed/simple;
	bh=raufc+3XLsouSkUORTSPo5aJVO/3e/bC5y5y7d9EAcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nac/eiyXNh+J0afO2to25rqRlDieC7Eldu8ImOtpuc6+N7RzB/AL5SSW7XRslDN+l8QS1USCXUKiMvv8IZ6amwEpB5VvkYX51ZSpkZyPnXUL2m31cmkvWs445jvZ94V9aEo5cpwuElb03k8bf/1Fx6Zn6Dd7WMjwlA3fRdyYhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGJifXEt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764017881; x=1795553881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=raufc+3XLsouSkUORTSPo5aJVO/3e/bC5y5y7d9EAcE=;
  b=bGJifXEtC9TYJGK9gA+D/332n+9ZcY+boWJdeeiAe6QqXza+X3Gl2FVu
   Baaw2/L41H0j5WW87/3X1nYqX+HT1pYSVeVPmNARZv8XvaTGriEoL74S8
   RvlZZO93Wf0o49oa/urn6otJzysA5236M4yxbL1FJ/ETpIDvyqAUKAuDD
   hzzoRPYFfrmeBXM4iawzuujgUCSGRDREtFQ1B38+MEhTQEhPTAooNegqF
   jb/p4P6KIvDn0epbrpxn2OuvstPro6AeofFPouB2KF26Z6aes/FvwvNM9
   TycyPPls6hUw9N1u7vARk8oBvci1JfYM7yEBPwUhB3UI46GrtdujSomea
   g==;
X-CSE-ConnectionGUID: gqPrywJHTjKtMP1cK/Z1BA==
X-CSE-MsgGUID: y5XOgx2+TCCBdzhnrrq0Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="66105533"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="66105533"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 12:57:59 -0800
X-CSE-ConnectionGUID: /D0Q+5vOSXmsPtkYZGDvtw==
X-CSE-MsgGUID: d8Xr5gWgQ6e+sKdb/6tQLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="192902487"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 24 Nov 2025 12:57:58 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2166A9F; Mon, 24 Nov 2025 21:57:57 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 1/1] cpuidle: Update header inclusion
Date: Mon, 24 Nov 2025 21:57:52 +0100
Message-ID: <20251124205752.1328701-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While cleaning up some headers, I got a build error on this file:

drivers/cpuidle/poll_state.c:52:2: error: call to undeclared library function 'snprintf' with type 'int (char *restrict, unsigned long, const char *restrict, ...)'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/cpuidle/poll_state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 9b6d90a72601..c7524e4c522a 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -4,9 +4,13 @@
  */
 
 #include <linux/cpuidle.h>
+#include <linux/export.h>
+#include <linux/irqflags.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
+#include <linux/sprintf.h>
+#include <linux/types.h>
 
 #define POLL_IDLE_RELAX_COUNT	200
 
-- 
2.50.1


