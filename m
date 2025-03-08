Return-Path: <linux-pm+bounces-23666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 272F8A5770C
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 02:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927A11895AB9
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7604D8C11;
	Sat,  8 Mar 2025 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlBOUIiB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845873C38;
	Sat,  8 Mar 2025 01:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741395748; cv=none; b=kAINEI0b1oQ1YWDtgiQX7X+qmU3Q8g5cB7sP3EjVtAL+d7vHSI6SlHB1ETMWJsYHu8w7Trfa2E82LiSYx2Abkq9Grk2oCc+Pj64x2h4NvNm/fnso2XHEyoQUW5wM8l4+ZyLtIszi3UFW2I270g2Aou21txgYOqf31J5tkdZLcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741395748; c=relaxed/simple;
	bh=1Z06EGd0YPfG9SHGEVxJJILprBZqLC9ZMU3X+BG2jvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=npNkw9RrE01V0W7y2+N09K2PCIhZmNFgQug7gsuH7Hp18HGzlmLqobh6xgtTQ/o6gmWi083+vL9Ec5lCVEut2dtAdrqKsgXVUEi6Mbndhra4yifO6rXIYuDq2GGWMY7Wp5UEiHcuOiR1c2nbiTdwM855sa/Mmn0djWo1fyD4iDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlBOUIiB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741395746; x=1772931746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Z06EGd0YPfG9SHGEVxJJILprBZqLC9ZMU3X+BG2jvA=;
  b=nlBOUIiBSMf2LRF1jZTSJHlvQmSWSV/t2x5FjlcjbT6r/OdFuLscS3NM
   tipejXFfezT6WJmXfkQ4LXi3UGr6wq8UZdpeVOaH9w9uMJbOjrRSxW4Tz
   2vWRqG4lhiimgMRYNXqCMSPNiCyV9vWTVSBBScHo2CL35n2lb8UMjE2Qo
   BFuT0dwGNCVJPFuueLJqmcxO6S50G7xhc8Pg5CAYTPFeLXMPkl7gNWrgS
   MxtCx1JOsfrAZGodYm+51vByoXaf1QFJfNrP9lsEOba90emq3QFNBoN03
   y/choAKwAwRDEeQZlecVIc7uj/i6wruG0DupEArAHzJWm5VZ25YZLbyDB
   A==;
X-CSE-ConnectionGUID: 0HiiVhETTbyk9wpD3F8ZGA==
X-CSE-MsgGUID: mRBQncZ7T8m2aAiiim/t4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="67825786"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="67825786"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 17:02:25 -0800
X-CSE-ConnectionGUID: cbvbsfTyTha0ngMUDpRDAw==
X-CSE-MsgGUID: JfpX22owRoqpsLOjbfxt5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120378502"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 17:02:25 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: core: Delay exposing sysfs interface
Date: Fri,  7 Mar 2025 17:02:01 -0800
Message-ID: <20250307-thermal-sysfs-race-v1-1-8a3d4d4ac9c4@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250307-thermal-sysfs-race-808f6f8376f4
X-Mailer: b4 0.15-dev-c25d1
Content-Transfer-Encoding: 8bit

There's a race between initializing the governor and userspace accessing
the sysfs interface. From time to time the Intel graphics CI shows this
signature:

	<1>[] #PF: error_code(0x0000) - not-present page
	<6>[] PGD 0 P4D 0
	<4>[] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
	<4>[] CPU: 3 UID: 0 PID: 562 Comm: thermald Not tainted 6.14.0-rc4-CI_DRM_16208-g7e37396f86d8+ #1
	<4>[] Hardware name: Intel Corporation Twin Lake Client Platform/AlderLake-N LP5 RVP, BIOS TWLNFWI1.R00.5222.A01.2405290634 05/29/2024
	<4>[] RIP: 0010:policy_show+0x1a/0x40

thermald tries to read the policy file between the sysfs files being
created and the governor set by thermal_set_governor(), which causes the
NULL pointer dereference.

Similarly to the hwmon interface, delay exposing the sysfs files to when
the governor is already set.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13655
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
The race window is not that big. I could reproduce it and confirm
the fix by doing this:

1) Add a udelay() in thermal_zone_device_register_with_trips
2) A busy loop cat'ing the file

	$ while [ 1 ]; do
		cat /sys/devices/virtual/thermal/thermal_zone0/policy > /dev/null 2>&1
	  done
3) rebind processor_thermal_device_pci
---
 drivers/thermal/thermal_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2328ac0d8561b..f96ca27109288 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1589,26 +1589,26 @@ thermal_zone_device_register_with_trips(const char *type,
 
 	tz->state = TZ_STATE_FLAG_INIT;
 
+	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
+	if (result)
+		goto remove_id;
+
+	thermal_zone_device_init(tz);
+
+	result = thermal_zone_init_governor(tz);
+	if (result)
+		goto remove_id;
+
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz);
 	if (result)
 		goto remove_id;
 
-	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
-	if (result) {
-		thermal_zone_destroy_device_groups(tz);
-		goto remove_id;
-	}
-	thermal_zone_device_init(tz);
 	result = device_register(&tz->device);
 	if (result)
 		goto release_device;
 
-	result = thermal_zone_init_governor(tz);
-	if (result)
-		goto unregister;
-
 	if (!tz->tzp || !tz->tzp->no_hwmon) {
 		result = thermal_add_hwmon_sysfs(tz);
 		if (result)

---
base-commit: 8aed61b8334e00f4fe5de9f2df1cd183dc328a9d
change-id: 20250307-thermal-sysfs-race-808f6f8376f4

Best regards,
-- 
Lucas De Marchi <lucas.demarchi@intel.com>


