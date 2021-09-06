Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A591401830
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 10:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbhIFIqK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 04:46:10 -0400
Received: from foss.arm.com ([217.140.110.172]:53578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhIFIqK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Sep 2021 04:46:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C3B5D6E;
        Mon,  6 Sep 2021 01:45:05 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.18.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E50503F73D;
        Mon,  6 Sep 2021 01:45:03 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, qperret@google.com,
        rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        vincent.donnefort@arm.com
Subject: [PATCH 1/2] PM: EM: fix kernel-doc comments
Date:   Mon,  6 Sep 2021 09:44:52 +0100
Message-Id: <20210906084453.3068-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the kernel-doc comments for the improved Energy Model documentation.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 1834752c5617..39dcadd492b5 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 
 /**
- * em_perf_state - Performance state of a performance domain
+ * struct em_perf_state - Performance state of a performance domain
  * @frequency:	The frequency in KHz, for consistency with CPUFreq
  * @power:	The power consumed at this level (by 1 CPU or by a registered
  *		device). It can be a total power: static and dynamic.
@@ -25,7 +25,7 @@ struct em_perf_state {
 };
 
 /**
- * em_perf_domain - Performance domain
+ * struct em_perf_domain - Performance domain
  * @table:		List of performance states, in ascending order
  * @nr_perf_states:	Number of performance states
  * @milliwatts:		Flag indicating the power values are in milli-Watts
@@ -103,12 +103,12 @@ void em_dev_unregister_perf_domain(struct device *dev);
 
 /**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
-		performance domain
+ *		performance domain
  * @pd		: performance domain for which energy has to be estimated
  * @max_util	: highest utilization among CPUs of the domain
  * @sum_util	: sum of the utilization of all CPUs in the domain
  * @allowed_cpu_cap	: maximum allowed CPU capacity for the @pd, which
-			  might reflect reduced frequency (due to thermal)
+ *			  might reflect reduced frequency (due to thermal)
  *
  * This function must be used only for CPU devices. There is no validation,
  * i.e. if the EM is a CPU type and has cpumask allocated. It is called from
-- 
2.17.1

