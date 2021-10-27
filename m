Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A8743C4A5
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 10:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbhJ0IJo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 04:09:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:5208 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235817AbhJ0IJo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Oct 2021 04:09:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="227559474"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="227559474"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 01:07:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="486559047"
Received: from power-sh.sh.intel.com ([10.239.183.1])
  by orsmga007.jf.intel.com with ESMTP; 27 Oct 2021 01:07:17 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, artem.bityutskiy@linux.intel.com,
        rui.zhang@intel.com
Subject: [PATCH 3/3] intel_idle: fix cpuidle_device unregistration
Date:   Wed, 27 Oct 2021 16:22:37 +0800
Message-Id: <20211027082237.26759-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027082237.26759-1-rui.zhang@intel.com>
References: <20211027082237.26759-1-rui.zhang@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpuidle_device is allocated as percpu data, and it is registered for every
CPU that has ever been onlined.
When unregistering, checking current online CPUs is not sufficient,
because some cpu may be offlined later with its cpuidle_device registered.

Fix this by using for_each_present_cpu() instead, and unregistering all
the cpuidle_devices that have been registered.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/idle/intel_idle.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index e7f2a5f85bf9..9e916e2adc89 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1687,8 +1687,13 @@ static void __init intel_idle_cpuidle_unregister(struct cpuidle_driver *drv)
 
 	if (intel_idle_cpuhp_state > 0)
 		cpuhp_remove_state(intel_idle_cpuhp_state);
-	for_each_online_cpu(i)
-		cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
+	for_each_present_cpu(i) {
+		struct cpuidle_device *dev;
+
+		dev = per_cpu_ptr(intel_idle_cpuidle_devices, i);
+		if (dev->registered)
+			cpuidle_unregister_device(dev);
+	}
 	cpuidle_unregister_driver(drv);
 	free_percpu(intel_idle_cpuidle_devices);
 }
-- 
2.17.1

