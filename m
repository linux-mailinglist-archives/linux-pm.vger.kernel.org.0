Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7D3B4692
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFYP3H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 11:29:07 -0400
Received: from foss.arm.com ([217.140.110.172]:58660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFYP3H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Jun 2021 11:29:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 399591396;
        Fri, 25 Jun 2021 08:26:46 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.7.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C50B3F694;
        Fri, 25 Jun 2021 08:26:42 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris.Redpath@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, segall@google.com,
        mgorman@suse.de, bristot@redhat.com, CCj.Yeh@mediatek.com
Subject: [PATCH 2/3] PM: EM: Make em_cpu_energy() able to return bigger values
Date:   Fri, 25 Jun 2021 16:26:02 +0100
Message-Id: <20210625152603.25960-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210625152603.25960-1-lukasz.luba@arm.com>
References: <20210625152603.25960-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model (EM) em_cpu_energy() is responsible for providing good
estimation regarding CPUs energy. It contains proper data structures which
are then used during calculation. The values stored in there are in
milli-Watts precision (or in abstract scale) smaller that 0xffff, which use
sufficient unsigned long even on 32-bit machines. There are scenarios where
we would like to provide calculated estimations in a better precision and
the values might be 1000 times bigger. This patch makes possible to use
quite big values for also 32-bit machines.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 3f221dbf5f95..2016f5a706e0 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -101,7 +101,7 @@ void em_dev_unregister_perf_domain(struct device *dev);
  * Return: the sum of the energy consumed by the CPUs of the domain assuming
  * a capacity state satisfying the max utilization of the domain.
  */
-static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
+static inline u64 em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long max_util, unsigned long sum_util,
 				unsigned long allowed_cpu_cap)
 {
@@ -180,7 +180,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 *   pd_nrg = ------------------------                       (4)
 	 *                  scale_cpu
 	 */
-	return ps->cost * sum_util / scale_cpu;
+	return div_u64((u64)ps->cost * sum_util, scale_cpu);
 }
 
 /**
@@ -217,7 +217,7 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
 {
 	return NULL;
 }
-static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
+static inline u64 em_cpu_energy(struct em_perf_domain *pd,
 			unsigned long max_util, unsigned long sum_util,
 			unsigned long allowed_cpu_cap)
 {
-- 
2.17.1

