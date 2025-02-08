Return-Path: <linux-pm+bounces-21581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC1A2D4A9
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 08:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E6A1690C2
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 07:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BBE19F101;
	Sat,  8 Feb 2025 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKJtUAdO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A02556E;
	Sat,  8 Feb 2025 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739000972; cv=none; b=NWvJpeUUyYreHZGe409nZhVVdGOnqHDASlxv2aMnIYfPtv7w4B1C5P8Pp/bjb6UXat0lbyhqK1B60R5BjAMLwnud2YLQyo9zLdjCxUivd1jLZ1vPyU32ImBKNr9Vg5rQ6oWjS8bm241NrjXWnUc5vA46RB0Kvb7KnjTEfNLQbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739000972; c=relaxed/simple;
	bh=pgFkK/SJSFj+yChtsSrhKm7PJUCUyugKv/9ic8yFb4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dCM1Df+f+0GjMaxNupiJz4OYTo65s6tlw6B+91NR6m112yr7QCJhxkYCj1ZYfPKSFu3LrVeZE7g8s8sgdLxid00F+weNlUL7eIjYRqPsv1ZS1uQoPhI6qtEzK7EiIAZnMRfWnCSAwY2w00ywMrpJy7gtdZ7Eea1J6A8CdAKaqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKJtUAdO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739000970; x=1770536970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pgFkK/SJSFj+yChtsSrhKm7PJUCUyugKv/9ic8yFb4c=;
  b=kKJtUAdOFv+YS2TIxVOyj4SRJcluMx2hsRb+15pC6+M1smFF5mDhK+pJ
   fPulkoVlIj80DRcuWSCzKlIG5J+tJeTwmj18IboIrYEi4EPt/Mh//3xKj
   rXRbkFg+aTJlWuZV6IKC/f7O/YhkK8fUULQvT5M/GO3xrOBy2f1/RGqam
   WaQOjfxrLP+zxpiBJBNobWTBWe22Jfu9u2MRoMuma6y5f8Etn+UWww9P3
   H0GnHyHAUEq/nW//BUhF5yaChrBNR/p6QX1NkUofLvyFqz8XCvAxTyuft
   Ywel9+5J/ACYOEhlA13zX3cecMky4RgGBuOIzK685SFlrrlPGFgnPD0yY
   g==;
X-CSE-ConnectionGUID: xEKFoFYCRUKMp44bR4rqcQ==
X-CSE-MsgGUID: Fa3iFysSQwCvG/LoI4ufiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39772881"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; 
   d="scan'208";a="39772881"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 23:49:30 -0800
X-CSE-ConnectionGUID: rNgFDb2dQRCl8HwlJcaUzA==
X-CSE-MsgGUID: qWcmz+K7QrCyA/ZUEZm/+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115811996"
Received: from unknown (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.245.243.60])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 23:49:27 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	daniel.lezcano@linaro.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	srinivas.pandruvada@intel.com
Subject: [PATCH] thermal/netlink: Prevent Userspace Segmentation Fault by Adjusting UAPI Header
Date: Sat,  8 Feb 2025 15:49:07 +0800
Message-Id: <20250208074907.5679-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intel-lpmd tool [1], which uses the THERMAL_GENL_ATTR_CPU_CAPABILITY
attribute to receive HFI events from kernel space, encounters a
segmentation fault after commit 1773572863c4 ("thermal: netlink: Add the
commands and the events for the thresholds").

The issue arises because the THERMAL_GENL_ATTR_CPU_CAPABILITY raw value
was changed while intel_lpmd still uses the old value.

Although intel_lpmd can be updated to check the THERMAL_GENL_VERSION and
use the appropriate THERMAL_GENL_ATTR_CPU_CAPABILITY value, the commit
itself is questionable. The commit introduced a new element in the
middle of enum thermal_genl_attr, which affects many existing attributes
and introduces potential risks and unnecessary maintenance burdens for
userspace thermal netlink event users.

Solve the issue by moving the newly introduced
THERMAL_GENL_ATTR_TZ_PREV_TEMP attribute to the end of the
enum thermal_genl_attr. This ensures that all existing thermal generic
netlink attributes remain unaffected.

Link: https://github.com/intel/intel-lpmd [1]
Fixes: 1773572863c4 ("thermal: netlink: Add the commands and the events for the thresholds")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 include/uapi/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index 349718c271eb..46a2633d33aa 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -30,7 +30,6 @@ enum thermal_genl_attr {
 	THERMAL_GENL_ATTR_TZ,
 	THERMAL_GENL_ATTR_TZ_ID,
 	THERMAL_GENL_ATTR_TZ_TEMP,
-	THERMAL_GENL_ATTR_TZ_PREV_TEMP,
 	THERMAL_GENL_ATTR_TZ_TRIP,
 	THERMAL_GENL_ATTR_TZ_TRIP_ID,
 	THERMAL_GENL_ATTR_TZ_TRIP_TYPE,
@@ -54,6 +53,7 @@ enum thermal_genl_attr {
 	THERMAL_GENL_ATTR_THRESHOLD,
 	THERMAL_GENL_ATTR_THRESHOLD_TEMP,
 	THERMAL_GENL_ATTR_THRESHOLD_DIRECTION,
+	THERMAL_GENL_ATTR_TZ_PREV_TEMP,
 	__THERMAL_GENL_ATTR_MAX,
 };
 #define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
-- 
2.34.1


