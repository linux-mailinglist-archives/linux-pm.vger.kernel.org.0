Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B098180AC7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 22:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCJVqX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 17:46:23 -0400
Received: from mx1.riseup.net ([198.252.153.129]:49194 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbgCJVqX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 17:46:23 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48cTDt6gqJzFdkG;
        Tue, 10 Mar 2020 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1583876783; bh=JOWEXfrb9UFLH74QE5/WubqsiwOn7tHuUTjmrbOGpZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBy4iS8PUU5iVlG5k0ycH3oBaAc/XqVNoOh8MY5HHxA2Vkntb6binK6Wf72gpRvO2
         /4P1BY2MHQtXYsnhABzgvb/+OMB7+JiR2CmpUyCvjrDjj6mQnpcfdz5UFSTFRQM7B1
         02aFINuYN8SVJlZSmK1KHrNop0teNBwmG/bl6O9A=
X-Riseup-User-ID: E9D8C4D7DC82611EFFCC156B3BA45C28F31077F6DF96799252081EE137E3455D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 48cTDt4mw5zJsJ5;
        Tue, 10 Mar 2020 14:46:22 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 02/10] drm/i915: Adjust PM QoS response frequency based on GPU load.
Date:   Tue, 10 Mar 2020 14:41:55 -0700
Message-Id: <20200310214203.26459-3-currojerez@riseup.net>
In-Reply-To: <20200310214203.26459-1-currojerez@riseup.net>
References: <20200310214203.26459-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This allows CPUFREQ governors to realize when the system becomes
non-CPU-bound due to GPU rendering activity, and cause them to respond
more conservatively to the workload by limiting their response
frequency: CPU energy usage will be reduced when there isn't a good
chance for system performance to scale with CPU frequency due to the
GPU bottleneck.  This leaves additional TDP budget available for the
GPU to reach higher frequencies, which is translated into an
improvement in graphics performance to the extent that the workload
remains TDP-limited (Most non-trivial graphics benchmarks out there
improve significantly in the TDP-constrained platforms where this is
currently enabled, see the cover letter for some numbers).  If the
workload isn't (anymore) TDP-limited performance should stay roughly
constant, but energy usage will be divided by a similar factor.

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 drivers/gpu/drm/i915/gt/intel_engine_cs.c    |   1 +
 drivers/gpu/drm/i915/gt/intel_engine_types.h |   7 ++
 drivers/gpu/drm/i915/gt/intel_gt_pm.c        | 107 +++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_pm.h        |   3 +
 drivers/gpu/drm/i915/gt/intel_gt_types.h     |  12 +++
 drivers/gpu/drm/i915/gt/intel_lrc.c          |  14 +++
 6 files changed, 144 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index 53ac3f00909a..16ebdfa1dfc9 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -504,6 +504,7 @@ void intel_engine_init_execlists(struct intel_engine_cs *engine)
 
 	execlists->queue_priority_hint = INT_MIN;
 	execlists->queue = RB_ROOT_CACHED;
+	atomic_set(&execlists->overload, 0);
 }
 
 static void cleanup_status_page(struct intel_engine_cs *engine)
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_types.h b/drivers/gpu/drm/i915/gt/intel_engine_types.h
index 80cdde712842..1b17b2f0c7a3 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_engine_types.h
@@ -266,6 +266,13 @@ struct intel_engine_execlists {
 	 */
 	u8 csb_head;
 
+	/**
+	 * @overload: whether at least two execlist ports are
+	 * currently submitted to the hardware, indicating that CPU
+	 * latency isn't critical in order to maintain the GPU busy.
+	 */
+	atomic_t overload;
+
 	I915_SELFTEST_DECLARE(struct st_preempt_hang preempt_hang;)
 };
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm.c b/drivers/gpu/drm/i915/gt/intel_gt_pm.c
index 8b653c0f5e5f..f1f859e89a8f 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_pm.c
@@ -107,6 +107,102 @@ void intel_gt_pm_init_early(struct intel_gt *gt)
 	intel_wakeref_init(&gt->wakeref, gt->uncore->rpm, &wf_ops);
 }
 
+/**
+ * Time increment until the most immediate PM QoS response frequency
+ * update.
+ *
+ * May be in the future (return value > 0) if the GPU is currently
+ * active but we haven't updated the PM QoS request to reflect a
+ * bottleneck yet.  May be in the past (return value < 0) if the GPU
+ * isn't fully utilized and we've already reset the PM QoS request to
+ * the default value.  May be zero if a PM QoS request update is due.
+ *
+ * The time increment returned by this function decreases linearly
+ * with time until it reaches either zero or a configurable limit.
+ */
+static int32_t time_to_rf_qos_update_ns(struct intel_gt *gt)
+{
+	const uint64_t t1 = ktime_get_ns();
+	const uint64_t dt1 = gt->rf_qos.delay_max_ns;
+
+	if (atomic_read_acquire(&gt->rf_qos.active_count)) {
+		const uint64_t t0 = atomic64_read(&gt->rf_qos.time_set_ns);
+
+		return min(dt1, t0 <= t1 ? 0 : t0 - t1);
+	} else {
+		const uint64_t t0 = atomic64_read(&gt->rf_qos.time_clear_ns);
+		const unsigned int shift = gt->rf_qos.delay_slope_shift;
+
+		return -(int32_t)(t1 <= t0 ? 1 :
+				  min(dt1, (t1 - t0) << shift));
+	}
+}
+
+/**
+ * Perform a delayed PM QoS response frequency update.
+ */
+static void intel_gt_rf_qos_update(struct intel_gt *gt)
+{
+	const uint32_t dt = max(0, time_to_rf_qos_update_ns(gt));
+
+	timer_reduce(&gt->rf_qos.timer, jiffies + nsecs_to_jiffies(dt));
+}
+
+/**
+ * Timer that fires once the delay used to switch the PM QoS response
+ * frequency request has elapsed.
+ */
+static void intel_gt_rf_qos_timeout(struct timer_list *timer)
+{
+	struct intel_gt *gt = container_of(timer, struct intel_gt,
+					   rf_qos.timer);
+	const int32_t dt = time_to_rf_qos_update_ns(gt);
+
+	if (dt == 0)
+		cpu_response_frequency_qos_update_request(
+			&gt->rf_qos.req, gt->rf_qos.target_hz);
+	else
+		cpu_response_frequency_qos_update_request(
+			&gt->rf_qos.req, PM_QOS_DEFAULT_VALUE);
+
+	if (dt > 0)
+		intel_gt_rf_qos_update(gt);
+}
+
+/**
+ * Report the beginning of a period of GPU utilization to PM.
+ *
+ * May trigger a more energy-efficient response mode in CPU PM, but
+ * only after a certain delay has elapsed so we don't have a negative
+ * impact on the CPU ramp-up latency except after the GPU has been
+ * continuously utilized for a long enough period of time.
+ */
+void intel_gt_pm_active_begin(struct intel_gt *gt)
+{
+	const uint32_t dt = abs(time_to_rf_qos_update_ns(gt));
+
+	atomic64_set(&gt->rf_qos.time_set_ns, ktime_get_ns() + dt);
+
+	if (!atomic_fetch_inc_release(&gt->rf_qos.active_count))
+		intel_gt_rf_qos_update(gt);
+}
+
+/**
+ * Report the end of a period of GPU utilization to PM.
+ *
+ * Must be called once after each call to intel_gt_pm_active_begin().
+ */
+void intel_gt_pm_active_end(struct intel_gt *gt)
+{
+	const uint32_t dt = abs(time_to_rf_qos_update_ns(gt));
+	const unsigned int shift = gt->rf_qos.delay_slope_shift;
+
+	atomic64_set(&gt->rf_qos.time_clear_ns, ktime_get_ns() - (dt >> shift));
+
+	if (!atomic_dec_return_release(&gt->rf_qos.active_count))
+		intel_gt_rf_qos_update(gt);
+}
+
 void intel_gt_pm_init(struct intel_gt *gt)
 {
 	/*
@@ -116,6 +212,14 @@ void intel_gt_pm_init(struct intel_gt *gt)
 	 */
 	intel_rc6_init(&gt->rc6);
 	intel_rps_init(&gt->rps);
+
+	cpu_response_frequency_qos_add_request(&gt->rf_qos.req,
+					       PM_QOS_DEFAULT_VALUE);
+
+	gt->rf_qos.delay_max_ns = 250000;
+	gt->rf_qos.delay_slope_shift = 0;
+	gt->rf_qos.target_hz = 2;
+	timer_setup(&gt->rf_qos.timer, intel_gt_rf_qos_timeout, 0);
 }
 
 static bool reset_engines(struct intel_gt *gt)
@@ -170,6 +274,9 @@ static void gt_sanitize(struct intel_gt *gt, bool force)
 
 void intel_gt_pm_fini(struct intel_gt *gt)
 {
+	del_timer_sync(&gt->rf_qos.timer);
+	cpu_response_frequency_qos_remove_request(&gt->rf_qos.req);
+
 	intel_rc6_fini(&gt->rc6);
 }
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm.h b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
index 60f0e2fbe55c..43f1d45fb0db 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_pm.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
@@ -58,6 +58,9 @@ int intel_gt_resume(struct intel_gt *gt);
 void intel_gt_runtime_suspend(struct intel_gt *gt);
 int intel_gt_runtime_resume(struct intel_gt *gt);
 
+void intel_gt_pm_active_begin(struct intel_gt *gt);
+void intel_gt_pm_active_end(struct intel_gt *gt);
+
 static inline bool is_mock_gt(const struct intel_gt *gt)
 {
 	return I915_SELFTEST_ONLY(gt->awake == -ENODEV);
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_types.h b/drivers/gpu/drm/i915/gt/intel_gt_types.h
index 96890dd12b5f..4bc80c55e6f0 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_types.h
@@ -10,6 +10,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/pm_qos.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -97,6 +98,17 @@ struct intel_gt {
 	 * Reserved for exclusive use by the kernel.
 	 */
 	struct i915_address_space *vm;
+
+	struct {
+		struct pm_qos_request req;
+		struct timer_list timer;
+		uint32_t target_hz;
+		uint32_t delay_max_ns;
+		uint32_t delay_slope_shift;
+		atomic64_t time_set_ns;
+		atomic64_t time_clear_ns;
+		atomic_t active_count;
+	} rf_qos;
 };
 
 enum intel_gt_scratch_field {
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index b9b3f78f1324..a5d7a80b826d 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -1577,6 +1577,11 @@ static void execlists_submit_ports(struct intel_engine_cs *engine)
 	/* we need to manually load the submit queue */
 	if (execlists->ctrl_reg)
 		writel(EL_CTRL_LOAD, execlists->ctrl_reg);
+
+	if (execlists_num_ports(execlists) > 1 &&
+	    execlists->pending[1] &&
+	    !atomic_xchg(&execlists->overload, 1))
+		intel_gt_pm_active_begin(&engine->i915->gt);
 }
 
 static bool ctx_single_port_submission(const struct intel_context *ce)
@@ -2213,6 +2218,12 @@ cancel_port_requests(struct intel_engine_execlists * const execlists)
 	clear_ports(execlists->inflight, ARRAY_SIZE(execlists->inflight));
 
 	WRITE_ONCE(execlists->active, execlists->inflight);
+
+	if (atomic_xchg(&execlists->overload, 0)) {
+		struct intel_engine_cs *engine =
+			container_of(execlists, typeof(*engine), execlists);
+		intel_gt_pm_active_end(&engine->i915->gt);
+	}
 }
 
 static inline void
@@ -2386,6 +2397,9 @@ static void process_csb(struct intel_engine_cs *engine)
 			/* port0 completed, advanced to port1 */
 			trace_ports(execlists, "completed", execlists->active);
 
+			if (atomic_xchg(&execlists->overload, 0))
+				intel_gt_pm_active_end(&engine->i915->gt);
+
 			/*
 			 * We rely on the hardware being strongly
 			 * ordered, that the breadcrumb write is
-- 
2.22.1

