Return-Path: <linux-pm+bounces-37077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C5C1E6F6
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 06:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440273A3768
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 05:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809121B9C1;
	Thu, 30 Oct 2025 05:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOgpvAVW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB50078F2B
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802577; cv=none; b=MM2XeD2l4ci/Yn1/LoMlK2jE0rbtzvc5HjAL7zHqz2t9ATWnY/8chjuWXWkM6uQP0XpixTl+GfuOn9kGS65Tm5IJahDt+l0V4Eq+Z9ByqYZWiB0/E/MLK/QTTOZaNEdAvBJ9zbbDa9XWSR+lFpQ3co1MhD0DU49EHbngPvyyhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802577; c=relaxed/simple;
	bh=v8pbSyRyGqq9UOAZ3atKWPM/fjKaHtrE5sWJDIwuNJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JbuL06oJUwAXNmyU/sWvnk9yIFNjPnn/TLwMZzch0Rw1L05XYtXXdtnQgsbsYk8BxjCLHesbbdKJE5A1RNDt8McGeAwytHGq7UXbpEmyimZY03VqYqdLeNKcW+D4cK7sgGCTsK+/PVgojJvmE/lE0sJ2dzi1HyYitQr57I5gNjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOgpvAVW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761802575; x=1793338575;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v8pbSyRyGqq9UOAZ3atKWPM/fjKaHtrE5sWJDIwuNJM=;
  b=MOgpvAVW4j0IAJkjjyPm7Ltqm4fZu8VmkP/i0kDiVutYbt4ARW3lGy72
   ioojiRnLL+nPpMA78vldmqVqvNaQ0plFaChDCXy/6BtCa7PCGfvhixMiW
   fAdQRjXK1WlSy7J7VvXtKp2SDxuqCLspxFFuMZKYRHExcwaBx/zkB/6QM
   /k/py/PqA67eXA0f3GAqnYJstOuYn9/BYgMVEozrzXCST7luShlIEVh/g
   a/V3puGyAnDyMdjy6Y9MPMTKre+1Hv6KPTqBOKPYsOAI3pTqETKqzgYdF
   jsF7UCLDtTi2D8ju2D8r+oxxO3TosN7f0y3ar6k8Kawzpp8Ow1aU4ja0m
   w==;
X-CSE-ConnectionGUID: pd1IxaSLQ4ye7BUt3YoRSQ==
X-CSE-MsgGUID: fMDPly8YR/K5u4A+bO8oSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81564920"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="81564920"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 22:36:15 -0700
X-CSE-ConnectionGUID: Y0k0CRIxQ62jVknbEpQN7g==
X-CSE-MsgGUID: 7Luk1U3RStuxC4GLZkz7Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185740197"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2025 22:36:13 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] thermal: Replace sprintf() with sysfs_emit() for sysfs attrs
Date: Thu, 30 Oct 2025 11:04:10 +0530
Message-Id: <20251030053410.311656-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() calls with sysfs_emit() in sysfs show functions to
follow current kernel coding standards. sysfs_emit() is the preferred
method for formatting sysfs output as it provides better bounds checking
and is more secure.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 908cc1bf57f1..82361ed7bda9 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -112,7 +112,7 @@ static ssize_t available_uuids_show(struct device *dev,
 	int length = 0;
 
 	if (!priv->uuid_bitmap)
-		return sprintf(buf, "UNKNOWN\n");
+		return sysfs_emit(buf, "UNKNOWN\n");
 
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
 		if (priv->uuid_bitmap & (1 << i))
@@ -129,7 +129,7 @@ static ssize_t current_uuid_show(struct device *dev,
 	int i, length = 0;
 
 	if (priv->current_uuid_index >= 0)
-		return sprintf(buf, "%s\n",
+		return sysfs_emit(buf, "%s\n",
 			       int3400_thermal_uuids[priv->current_uuid_index]);
 
 	for (i = 0; i <= INT3400_THERMAL_CRITICAL; i++) {
@@ -140,7 +140,7 @@ static ssize_t current_uuid_show(struct device *dev,
 	if (length)
 		return length;
 
-	return sprintf(buf, "INVALID\n");
+	return sysfs_emit(buf, "INVALID\n");
 }
 
 static int int3400_thermal_run_osc(acpi_handle handle, char *uuid_str, int *enable)
@@ -340,7 +340,7 @@ static ssize_t odvp_show(struct device *dev, struct device_attribute *attr,
 
 	odvp_attr = container_of(attr, struct odvp_attr, attr);
 
-	return sprintf(buf, "%d\n", odvp_attr->priv->odvp[odvp_attr->odvp]);
+	return sysfs_emit(buf, "%d\n", odvp_attr->priv->odvp[odvp_attr->odvp]);
 }
 
 static void cleanup_odvp(struct int3400_thermal_priv *priv)
-- 
2.34.1


