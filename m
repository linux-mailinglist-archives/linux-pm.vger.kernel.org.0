Return-Path: <linux-pm+bounces-16832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053B89B7C11
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 14:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9FB281977
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288FA19EED2;
	Thu, 31 Oct 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0M8UlFE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADE187864;
	Thu, 31 Oct 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382448; cv=none; b=dmDIK6Gt3qiQYpBzaYXTEG8IrfoG1T6f8nAGvPrJwf78jpqd1agm+lDR2ulmkLLuxG1YI49ZLIS5Xx1UT0+V9E0rCGHoVZN8y8yMfqwv0SHgLHgGNX9I65K3LcGYKmhQuXUo5XdR2pgTKGA6dojkf8ys7yAWS6ROGG86RgvW1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382448; c=relaxed/simple;
	bh=wczWP7X4aVSldOCxsqeyGCcHsY5TSebQJtRI7siVN4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGKP61XV/3EXR8ghnk4OHMwR/O6O6KfFgVrhEfmu0oSv97Kuc7hdmJKyfGQB8azAMXZ3yo6SoRg9IFJtPbndOxNOO82KY06uodp8jxqSOXt33QKaIKo8XaJ0/BB/v60eQrtxOk50Uz4le+Z+U7+ONK+5UBlDcsrLvVFWmhPzbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0M8UlFE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730382445; x=1761918445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wczWP7X4aVSldOCxsqeyGCcHsY5TSebQJtRI7siVN4Y=;
  b=f0M8UlFE2QVUJi5irAdeiUgjTsXS/xLfTMRK2yhU7Qn4eu4aCWoojsEy
   H5+4u74uT98W/n3q9Vlf5CBYjyOxgXhvdt9eajNE2YiC8JfglCv4ffo0P
   0FEmqowIbb6RMv+yp5doarLGlUKfmX849bHSrjBakTDWJFSXxMycXN1ga
   HE7jv5YXXQlFqyVxdudA1oCh5+Hw8UZqN+HB+1Wb8lrfu1QJjcQXXVUou
   nwTXN6kfRZe2AKu2ASFQ9ua0NfEBww8wXhOU1EYyZwP+YWz0byYBU9w+x
   EApRMNRR8zkjDobHps+cMN75HAaj9CDIhA5uv4BiKUZ+f1ac/SzJ5FxS5
   A==;
X-CSE-ConnectionGUID: aMlV99HMQAKN6EzIOHHTFQ==
X-CSE-MsgGUID: QW/qZLxYT+ii8pgvi5/kig==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30012245"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30012245"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 06:47:24 -0700
X-CSE-ConnectionGUID: oP/5BPnpSLmOntvn3x69kw==
X-CSE-MsgGUID: HyW4MNjPSvirpJxiwm43LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87766108"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 31 Oct 2024 06:47:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8C5A316D; Thu, 31 Oct 2024 15:47:20 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: WANG Xuerui <kernel@xen0n.name>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] cpufreq: loongson3: Check for error code from devm_mutex_init() call
Date: Thu, 31 Oct 2024 15:46:34 +0200
Message-ID: <20241031134719.2508841-1-andriy.shevchenko@linux.intel.com>
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
v2: renamed loongson --> loongson3 in the Subject (Huacai)
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


