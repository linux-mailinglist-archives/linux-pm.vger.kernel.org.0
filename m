Return-Path: <linux-pm+bounces-16746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312089B6930
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 17:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9151F221A6
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765982141A2;
	Wed, 30 Oct 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeyAtdJ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835CB213EED;
	Wed, 30 Oct 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305783; cv=none; b=jBbmdNE6+7Mf+M77FiRJoHpr0PQ7s2ffWasXZS9LrTkR9Wt3r5yy7Wvd63Cwv0uV+PHgvxJTKZszXR4FuTqPIB19as47jPxynrbnd+r43lkIpttHdr3eptBHNJdFRtE7fT+XASsbrEkAp3NErGAt0VfUEi9lg5soixGWJTJzqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305783; c=relaxed/simple;
	bh=4+0rLzRoLskeGCQVQU4H7vvyGAdZOaHvovCUKmCtG9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knGAV7b+DUCy75vR6PjOwUEQndaFBPcXZBUZ5rvsAtM1CYIenRWQOcoSfYH6N1WeNNEZEYK1WrDvEFPIeZL6xNEESAPGlz+C1PM5iPK1/ixTdiEJ6J+/QvUGJF00ZtlIEMEzAOWiM8T7YZZaKuUxCXu6pLmzVGujyKiESpgqSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeyAtdJ4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730305781; x=1761841781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4+0rLzRoLskeGCQVQU4H7vvyGAdZOaHvovCUKmCtG9w=;
  b=KeyAtdJ4LN2kBVDbYltvHz/zR2eGeE3pbE0lVmKO221/+pAzt547Q13y
   5vsJg8wx2EGc9V8nEf8SUmPyR9t7vK1vN7RhsWk3APZpfNpks4aApiBJg
   SUJSJgdLub1KiYdahRxbn6Wh6YrPjCWOU8Zu7L+0UvIBuKL5eXZCIFJxy
   Vf77SzLBq+ssB3eXECf3J90aKsjlRUEVGbD4tOchwdkuZEctQ5twmWuA1
   DmBOph3fGYDwqLTzZ1tF1vol3kkSi5uvhUoIhJPU30kY5RihhnbdTP51v
   OpDLEpOBthQVTJn3FqP4HYIjgA0Dk0F2zqYf44DLodXD5npZhqOK3Sxkz
   A==;
X-CSE-ConnectionGUID: ng0vrGtERCahtWKlFgRQIg==
X-CSE-MsgGUID: e5ZodlyzRUWM09Fo7eDDzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33706639"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33706639"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:29:40 -0700
X-CSE-ConnectionGUID: BspTwXgIRRW8NQxov3kSFw==
X-CSE-MsgGUID: P5p/n8qYSqmOXF13vHwqiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82682438"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 30 Oct 2024 09:29:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E9DD21CF; Wed, 30 Oct 2024 18:29:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: WANG Xuerui <kernel@xen0n.name>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] cpufreq: loongson: Check for error code from devm_mutex_init() call
Date: Wed, 30 Oct 2024 18:29:30 +0200
Message-ID: <20241030162930.2111255-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if it's not critical, the avoidance of checking the error code
from devm_mutex_init() call today diminishes the point of using devm
variant of it. Tomorrow it may even leak something. Add the missed
check.

Fixes: ccf51454145b ("cpufreq: Add Loongson-3 CPUFreq driver support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/cpufreq/loongson3_cpufreq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index 61ebebf69455..bd34bf0fafa5 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -346,8 +346,11 @@ static int loongson3_cpufreq_probe(struct platform_device *pdev)
 {
 	int i, ret;
 
-	for (i = 0; i < MAX_PACKAGES; i++)
-		devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
+	for (i = 0; i < MAX_PACKAGES; i++) {
+		ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
+		if (ret)
+			return ret;
+	}
 
 	ret = do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
 	if (ret <= 0)
-- 
2.43.0.rc1.1336.g36b5255a03ac


