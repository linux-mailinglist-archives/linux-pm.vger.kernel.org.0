Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C5243C4A3
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 10:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbhJ0IJn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 04:09:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:5207 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239150AbhJ0IJm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Oct 2021 04:09:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="227559470"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="227559470"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 01:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="486559030"
Received: from power-sh.sh.intel.com ([10.239.183.1])
  by orsmga007.jf.intel.com with ESMTP; 27 Oct 2021 01:07:16 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, artem.bityutskiy@linux.intel.com,
        rui.zhang@intel.com
Subject: [PATCH 2/3] intel_idle: cleanup cpuhotplug setup
Date:   Wed, 27 Oct 2021 16:22:36 +0800
Message-Id: <20211027082237.26759-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027082237.26759-1-rui.zhang@intel.com>
References: <20211027082237.26759-1-rui.zhang@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Only limited number of CPUHP_AP_ONLINE_DYN callbacks can be registered,
thus cpuhp_remove_state() should be invoked to release the resource when
it is not used.

Fixes: fb1013a01673 ("intel_idle: Convert to hotplug state machine")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/idle/intel_idle.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ae9d8c43e6a5..e7f2a5f85bf9 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1676,6 +1676,8 @@ static int intel_idle_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+static enum cpuhp_state intel_idle_cpuhp_state;
+
 /**
  * intel_idle_cpuidle_unregister - unregister from cpuidle framework
  */
@@ -1683,6 +1685,8 @@ static void __init intel_idle_cpuidle_unregister(struct cpuidle_driver *drv)
 {
 	int i;
 
+	if (intel_idle_cpuhp_state > 0)
+		cpuhp_remove_state(intel_idle_cpuhp_state);
 	for_each_online_cpu(i)
 		cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
 	cpuidle_unregister_driver(drv);
@@ -1710,11 +1714,11 @@ static int __init intel_idle_cpuidle_register(struct cpuidle_driver *drv)
 		return retval;
 	}
 
-	retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
-				intel_idle_cpu_online, NULL);
-	if (retval < 0) {
+	intel_idle_cpuhp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+		"idle/intel:online", intel_idle_cpu_online, NULL);
+	if (intel_idle_cpuhp_state < 0) {
 		intel_idle_cpuidle_unregister(drv);
-		return retval;
+		return intel_idle_cpuhp_state;
 	}
 	return 0;
 }
-- 
2.17.1

