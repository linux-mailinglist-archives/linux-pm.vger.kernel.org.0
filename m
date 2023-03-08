Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B056AFD44
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 04:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCHDMP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 22:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCHDMO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 22:12:14 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6408A6BD7;
        Tue,  7 Mar 2023 19:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678245133; x=1709781133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mIAti8Y6kXjJsuxUcM8F3YDg8N2myxmijQVm4xumhiU=;
  b=WzAOyiTkliYo2UsdJEsJxmGTTnABGLd79vZ+FJeXk+d5p0j24vysXJX3
   hmRUIX12K3EumFuRRWvxtFNSwtGTgapQLvss/ptcpAoQnhnf3KiO82THx
   9kRv4Dncl4fm55LwDxj8rUKMq7IREVQ6xMQyqnHbh1wQ9N1+QT3b3aulk
   /8EM+rdy9SBTAAWLdsmO117aEUQlHaKoY7PwF2nSgZpxKH7B8LxSHWOjD
   S2QEbxx6n8Z+kzt8Ox+/Jl0dv1Ea5eoH+9+83bcawFbzUQ4lkUrBpIMHF
   TiPfRls5GAyKgYJHJ+GUyRzRyqIdbfp3oPK/y99wjeWjeSwnO3kqZztQu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="336063166"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="336063166"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 19:12:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="800601648"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="800601648"
Received: from xuepengc-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.254.209.214])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 19:12:10 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, error27@gmail.com,
        srinivas.pandruvada@intel.com
Subject: [PATCH] thermal/x86_pkg_temp_thermal: Add lower bound check for sysfs input
Date:   Wed,  8 Mar 2023 11:07:11 +0800
Message-Id: <20230308030711.4362-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When setting a trip point temperature from sysfs, there is an upper
bound check on the user input, but no lower bound check.

As hardware register has 7 bits for a trip point temperature, the offset
to tj_max of the input temperature must be equal to/less than 0x7f.
Or else,
1. bogus temperature is updated into the trip temperature bits.
2. the upper bits of the register can be polluted.

For example,
$ rdmsr 0x1b2
2000003
$ echo -180000 > /sys/class/thermal/thermal_zone1/trip_point_1_temp
$ rdmsr 0x1b2
3980003

Not only the trip point temp is set to 76C on this platform (tj_max is
100), the Power Notification (Bit 24) is also enabled erronously.

Fix the problem by adding lower bound check for sysfs input.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/all/add7a378-4d50-4ba1-81d3-a0c17db25a0b@kili.mountain/
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
Note that I didn't add a Fixes tag here because this problem always
exists, and even the location of this file has been changed.

Note that I didn't cc -stable because this patch doesn't apply to older
kernels due to recent changes. If Rafael thinks this is a stable
material, we can rebase this fix on previous kernel after this patch
hits upstream.
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 1c2de84742df..128ee02596ed 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -124,14 +124,16 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 {
 	struct zone_device *zonedev = tzd->devdata;
 	u32 l, h, mask, shift, intr;
-	int tj_max, ret;
+	int tj_max, val, ret;
 
 	tj_max = intel_tcc_get_tjmax(zonedev->cpu);
 	if (tj_max < 0)
 		return tj_max;
 	tj_max *= 1000;
 
-	if (trip >= MAX_NUMBER_OF_TRIPS || temp >= tj_max)
+	val = (tj_max - temp)/1000;
+
+	if (trip >= MAX_NUMBER_OF_TRIPS || val < 0 || val > 0x7f)
 		return -EINVAL;
 
 	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
@@ -156,7 +158,7 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 	if (!temp) {
 		l &= ~intr;
 	} else {
-		l |= (tj_max - temp)/1000 << shift;
+		l |= val << shift;
 		l |= intr;
 	}
 
-- 
2.25.1

