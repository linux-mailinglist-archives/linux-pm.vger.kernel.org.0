Return-Path: <linux-pm+bounces-34048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3302B46BEF
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 13:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C22586972
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 11:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5CE285C8A;
	Sat,  6 Sep 2025 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7N3Afya"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF3286430
	for <linux-pm@vger.kernel.org>; Sat,  6 Sep 2025 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757159694; cv=none; b=cO5sz6XQaLq1JohchE8GFTDVujlrrUP6ZXaJ2qxl/sVafpdZb8IAAxcUewiKo56B6CZQ+qJUMBLbBTJZlQ6qLnqFkA2YQZ1tHfmELma3Mu2UNavij3Ci8wWceO9yrT61jsrhDsxbSNaORVtGOefsfpnOp5YGZfiCB8nYTaCXDrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757159694; c=relaxed/simple;
	bh=r41sc+XRDjF3XQUXw4PnPN5StQVN+96du3uTgBW6jwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pzwV0qdWVaHQgrOXj5zXBo3NpwEgxKH5NUYWrI1xO4D8/zGIH/I1BWlrN59uSyqhtGvxN+sdtTUjf0M7TCpDNITGa1ZcrhHvRrRziPHkLZ5bbjlmV4XuW75FaUTZ8bZbGKztDzMkt/CZ//4L5BHyqekIL1uWi15CHEQoNinSrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7N3Afya; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757159693; x=1788695693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r41sc+XRDjF3XQUXw4PnPN5StQVN+96du3uTgBW6jwg=;
  b=S7N3AfyaRuGv9zQA9Q+GQBZkaBuMHjZIc+7qTZTquO79q/LvoOJqwBYc
   gWC0HPCLGYdjdsn4iZIHB7iC+1/UYx7mz16VMllh+jCUWoi7WfQG5NluM
   VJQr5LoPLJqdDxrtsOLQQseLkVDX75HnltAmvFR0kMouYvvSlP6rZG2J2
   oaqXjo8qltqpm/tNpvCYNgrGJcFGZTbidHGuJ7BKQLY82lwfEMUTs3kDN
   ZjMyMMRWc8ITIPmghXSMSAWHa0wyri14VgmM8AsQOEiCcf9Q5SjbQ2RzI
   5Q3iQFW+3ySD+5vj/1hSxlu7QITKlVyGfvIrTjGU5a9840fzQe4lmjIZ0
   Q==;
X-CSE-ConnectionGUID: dMk8k686SGqZ2CuNsF3wnQ==
X-CSE-MsgGUID: ZADQmuqqRgOJTkZfMsh8cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="63128320"
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="63128320"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 04:54:53 -0700
X-CSE-ConnectionGUID: c67sARi7S0SrE6f5Z45w2A==
X-CSE-MsgGUID: lx4w0wzMQlqmcoDxZdxVuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="171646145"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa010.jf.intel.com with ESMTP; 06 Sep 2025 04:54:51 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] cpufreq: conservative: Replace sscanf() with kstrtouint()
Date: Sat,  6 Sep 2025 17:23:16 +0530
Message-Id: <20250906115316.3010384-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sscanf() with kstrtouint() in all sysfs store functions to improve
input validation and security. The kstrtouint() function provides better
error detection, overflow protection, and consistent error handling
compared to sscanf().

The kstrtouint() function provides:
- Robust error detection for invalid input strings
- Built-in overflow protection and boundary checking
- Consistent error reporting (0 for success, negative for failure)

This maintains existing functionality while improving input validation
robustness and following kernel coding best practices for string parsing.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 56500b25d77c..cce6a8d113e1 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -152,9 +152,9 @@ static ssize_t sampling_down_factor_store(struct gov_attr_set *attr_set,
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	unsigned int input;
 	int ret;
-	ret = sscanf(buf, "%u", &input);
+	ret = kstrtouint(buf, 0, &input);
 
-	if (ret != 1 || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
+	if (ret || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
 		return -EINVAL;
 
 	dbs_data->sampling_down_factor = input;
@@ -168,9 +168,9 @@ static ssize_t up_threshold_store(struct gov_attr_set *attr_set,
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int input;
 	int ret;
-	ret = sscanf(buf, "%u", &input);
+	ret = kstrtouint(buf, 0, &input);
 
-	if (ret != 1 || input > 100 || input <= cs_tuners->down_threshold)
+	if (ret || input > 100 || input <= cs_tuners->down_threshold)
 		return -EINVAL;
 
 	dbs_data->up_threshold = input;
@@ -184,10 +184,10 @@ static ssize_t down_threshold_store(struct gov_attr_set *attr_set,
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int input;
 	int ret;
-	ret = sscanf(buf, "%u", &input);
+	ret = kstrtouint(buf, 0, &input);
 
 	/* cannot be lower than 1 otherwise freq will not fall */
-	if (ret != 1 || input < 1 || input >= dbs_data->up_threshold)
+	if (ret || input < 1 || input >= dbs_data->up_threshold)
 		return -EINVAL;
 
 	cs_tuners->down_threshold = input;
@@ -201,9 +201,9 @@ static ssize_t ignore_nice_load_store(struct gov_attr_set *attr_set,
 	unsigned int input;
 	int ret;
 
-	ret = sscanf(buf, "%u", &input);
-	if (ret != 1)
-		return -EINVAL;
+	ret = kstrtouint(buf, 0, &input);
+	if (ret)
+		return ret;
 
 	if (input > 1)
 		input = 1;
@@ -226,10 +226,10 @@ static ssize_t freq_step_store(struct gov_attr_set *attr_set, const char *buf,
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int input;
 	int ret;
-	ret = sscanf(buf, "%u", &input);
+	ret = kstrtouint(buf, 0, &input);
 
-	if (ret != 1)
-		return -EINVAL;
+	if (ret)
+		return ret;
 
 	if (input > 100)
 		input = 100;
-- 
2.34.1


