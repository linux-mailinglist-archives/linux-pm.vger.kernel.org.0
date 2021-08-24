Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0D3F578E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 07:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhHXFSU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 01:18:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:55331 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhHXFST (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Aug 2021 01:18:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="278249111"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="278249111"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 22:17:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="515282852"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2021 22:17:35 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        lenb@kernel.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH 2/3] powercap: idle_inject: Export symbols
Date:   Mon, 23 Aug 2021 22:17:30 -0700
Message-Id: <20210824051731.2495462-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824051731.2495462-1-srinivas.pandruvada@linux.intel.com>
References: <20210824051731.2495462-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export symbols for interfaces used in other files. In this way the
caller can be a module.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/idle_inject.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 6e1a0043c411..204783dfc432 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -159,6 +159,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 		WRITE_ONCE(ii_dev->idle_duration_us, idle_duration_us);
 	}
 }
+EXPORT_SYMBOL_GPL(idle_inject_set_duration);
 
 /**
  * idle_inject_get_duration - idle and run duration retrieval helper
@@ -182,6 +183,7 @@ void idle_inject_set_latency(struct idle_inject_device *ii_dev,
 {
 	WRITE_ONCE(ii_dev->latency_us, latency_us);
 }
+EXPORT_SYMBOL(idle_inject_set_latency);
 
 /**
  * idle_inject_start - start idle injections
@@ -334,6 +336,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(idle_inject_register);
 
 /**
  * idle_inject_unregister - unregister idle injection control device
@@ -354,6 +357,7 @@ void idle_inject_unregister(struct idle_inject_device *ii_dev)
 
 	kfree(ii_dev);
 }
+EXPORT_SYMBOL_GPL(idle_inject_unregister);
 
 static struct smp_hotplug_thread idle_inject_threads = {
 	.store = &idle_inject_thread.tsk,
-- 
2.30.2

