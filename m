Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4471BB484
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 05:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgD1D1v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 23:27:51 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48900 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgD1D1v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 23:27:51 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 49B6Xk3rQpzFfDl;
        Mon, 27 Apr 2020 20:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1588044470; bh=jYQGDs775oeWpnjVU5KQQtQdTslfIGrc2wZmpUY24xE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KaTt9WBWuX3+YC46+E95lTIX0T/t2a6+fxKbnsEzRqtMpEJBazUav9JDvnAsnubqh
         cUjZClvRPFdSgFSO0wuPxA8kvfuarmQ2RdV3facq/0ScLZCvcAGaLflMt/hP8mwwgx
         UYqQYyrPM4G9ggTFsjFMQgufNTe4S37yH2o8HkOw=
X-Riseup-User-ID: FFF0C73852467EC62002E944EFC9FFF994A3B9DDD677902FBB2E2AED2180165B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 49B6Xk1jXJzJqbk;
        Mon, 27 Apr 2020 20:27:50 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        chris.p.wilson@intel.com,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCHv2.99 02/11] drm/i915: Adjust PM QoS scaling response frequency based on GPU load.
Date:   Mon, 27 Apr 2020 20:22:49 -0700
Message-Id: <20200428032258.2518-3-currojerez@riseup.net>
In-Reply-To: <20200428032258.2518-1-currojerez@riseup.net>
References: <20200428032258.2518-1-currojerez@riseup.net>
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
GPU to reach higher frequencies, which may be translated into an
improvement in graphics performance to the extent that the workload
remains TDP-limited.  If the workload isn't (anymore) TDP-limited
performance should stay roughly constant, but energy usage will be
divided by a similar factor.

The metric used by this patch in order to determine whether the GPU is
unlikely to be a bottleneck may not be particularly obvious: We only
specify a reduced PM QoS response frequency target whenever both
execlists ELSP ports are simultaneously active, since in that case we
know that the completion of one context will lead to the immediate
execution of another, which means that the GPU can be kept busy
without the execlists submission code rushing to submit a new request,
so CPU latency shouldn't be a concern.

This might miss some workloads that could theoretically benefit from
this optimization, since some applications are unable to keep both
ELSP ports active for a significant fraction of time even though they
are GPU-bound, however using the single-ELSP utilization as metric
would neglect the CPU latency-sensitivity of the execlists submission
code, which would lead to large regressions in x11perf and
jxrendermark.  For that reason this patch takes the rather
conservative approach of restricting the optimization to workloads
that effectively utilize both ELSP ports, which indicates that command
submission latency is unlikely to be an issue.

Note that this is currently only enabled for execlists submission.  It
might be beneficial to do the same thing in combination with GuC
submission, but the metric would be slightly different since we
wouldn't need to care about multiple ELSP ports being in use.

In order to further prevent regressions the optimization is enabled
with a delay in order to avoid performance degradation of applications
that quickly switch back and forth between being GPU-bound and
CPU-bound.  A reduced PM QoS scaling response frequency target will
only be specified if the GPU has been continuously utilized for a long
enough period of time.

v3: Assorted clean-ups (Chris).  Improved documentation (Tvrtko).  Fix
    interaction with single-ELSP preemption (Chris).  Move overload
    signalling to process_csb() to reduce bias due to interrupt
    latency (Francisco).  Rename CPU_RESPONSE_FREQUENCY to
    CPU_SCALING_RESPONSE (Rafael).  Adjust heuristic parameters to
    avoid regressions from other v3 governor changes (Francisco).

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 drivers/gpu/drm/i915/gt/intel_engine_cs.c    |   1 +
 drivers/gpu/drm/i915/gt/intel_engine_types.h |  11 ++
 drivers/gpu/drm/i915/gt/intel_gt_pm.c        | 107 +++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_pm.h        |   3 +
 drivers/gpu/drm/i915/gt/intel_gt_types.h     |  49 +++++++++
 drivers/gpu/drm/i915/gt/intel_lrc.c          |  17 +++
 6 files changed, 188 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index b1f8527f02c8..6b08a9ad2de1 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -517,6 +517,7 @@ void intel_engine_init_execlists(struct intel_engine_cs *engine)
 
 	execlists->queue_priority_hint = INT_MIN;
 	execlists->queue = RB_ROOT_CACHED;
+	atomic_set(&execlists->overload, 0);
 }
 
 static void cleanup_status_page(struct intel_engine_cs *engine)
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_types.h b/drivers/gpu/drm/i915/gt/intel_engine_types.h
index bf395227c99f..9bdb3958dbb7 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_engine_types.h
@@ -275,6 +275,17 @@ struct intel_engine_execlists {
 	 */
 	u8 csb_head;
 
+	/**
+	 * @overload: whether at least two execlist ports are
+	 * currently submitted to the hardware, indicating that CPU
+	 * latency isn't critical in order to maintain the GPU busy.
+	 * We use that to trigger a more energy-efficient response
+	 * mode of CPU power management, since performance degradation
+	 * is unlikely under those conditions, and GPU throughput may
+	 * benefit from the increased TDP budget.
+	 */
+	atomic_t overload;
+
 	I915_SELFTEST_DECLARE(struct st_preempt_hang preempt_hang;)
 };
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm.c b/drivers/gpu/drm/i915/gt/intel_gt_pm.c
index 6bdb74892a1e..0d44ef3a07ad 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_pm.c
@@ -107,6 +107,102 @@ void intel_gt_pm_init_early(struct intel_gt *gt)
 	intel_wakeref_init(&gt->wakeref, gt->uncore->rpm, &wf_ops);
 }
 
+/**
+ * Time increment until the most immediate PM QoS scaling response
+ * frequency update.
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
+static int32_t time_to_sf_qos_update_ns(struct intel_gt *gt)
+{
+	const uint64_t t1 = ktime_get_ns();
+	const uint64_t dt1 = gt->sf_qos.delay_max_ns;
+
+	if (atomic_read_acquire(&gt->sf_qos.active_count)) {
+		const uint64_t t0 = atomic64_read(&gt->sf_qos.time_set_ns);
+
+		return min(dt1, t0 <= t1 ? 0 : t0 - t1);
+	} else {
+		const uint64_t t0 = atomic64_read(&gt->sf_qos.time_clear_ns);
+		const unsigned int shift = gt->sf_qos.delay_slope_shift;
+
+		return -(int32_t)(t1 <= t0 ? 1 :
+				  min(dt1, (t1 - t0) << shift));
+	}
+}
+
+/**
+ * Perform a delayed PM QoS scaling response frequency update.
+ */
+static void intel_gt_sf_qos_update(struct intel_gt *gt)
+{
+	const uint32_t dt = max(0, time_to_sf_qos_update_ns(gt));
+
+	timer_reduce(&gt->sf_qos.timer, jiffies + nsecs_to_jiffies(dt));
+}
+
+/**
+ * Timer that fires once the delay used to switch the PM QoS scaling
+ * response frequency request has elapsed.
+ */
+static void intel_gt_sf_qos_timeout(struct timer_list *timer)
+{
+	struct intel_gt *gt = container_of(timer, struct intel_gt,
+					   sf_qos.timer);
+	const int32_t dt = time_to_sf_qos_update_ns(gt);
+
+	if (dt == 0)
+		cpu_scaling_response_qos_update_request(
+			&gt->sf_qos.req, gt->sf_qos.target_hz);
+	else
+		cpu_scaling_response_qos_update_request(
+			&gt->sf_qos.req, PM_QOS_DEFAULT_VALUE);
+
+	if (dt > 0)
+		intel_gt_sf_qos_update(gt);
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
+	const uint32_t dt = abs(time_to_sf_qos_update_ns(gt));
+
+	atomic64_set(&gt->sf_qos.time_set_ns, ktime_get_ns() + dt);
+
+	if (!atomic_fetch_inc_release(&gt->sf_qos.active_count))
+		intel_gt_sf_qos_update(gt);
+}
+
+/**
+ * Report the end of a period of GPU utilization to PM.
+ *
+ * Must be called once after each call to intel_gt_pm_active_begin().
+ */
+void intel_gt_pm_active_end(struct intel_gt *gt)
+{
+	const uint32_t dt = abs(time_to_sf_qos_update_ns(gt));
+	const unsigned int shift = gt->sf_qos.delay_slope_shift;
+
+	atomic64_set(&gt->sf_qos.time_clear_ns, ktime_get_ns() - (dt >> shift));
+
+	if (!atomic_dec_return_release(&gt->sf_qos.active_count))
+		intel_gt_sf_qos_update(gt);
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
+	cpu_scaling_response_qos_add_request(&gt->sf_qos.req,
+					     PM_QOS_DEFAULT_VALUE);
+
+	gt->sf_qos.delay_max_ns = 10000000;
+	gt->sf_qos.delay_slope_shift = 1;
+	gt->sf_qos.target_hz = 2;
+	timer_setup(&gt->sf_qos.timer, intel_gt_sf_qos_timeout, 0);
 }
 
 static bool reset_engines(struct intel_gt *gt)
@@ -174,6 +278,9 @@ static void gt_sanitize(struct intel_gt *gt, bool force)
 
 void intel_gt_pm_fini(struct intel_gt *gt)
 {
+	del_timer_sync(&gt->sf_qos.timer);
+	cpu_scaling_response_qos_remove_request(&gt->sf_qos.req);
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
index 96890dd12b5f..8aaeb2450d05 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_types.h
@@ -10,6 +10,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/pm_qos.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -97,6 +98,54 @@ struct intel_gt {
 	 * Reserved for exclusive use by the kernel.
 	 */
 	struct i915_address_space *vm;
+
+	/**
+	 * CPU response frequency QoS tracking.
+	 */
+	struct {
+		/** PM QoS request of this device. */
+		struct pm_qos_request req;
+
+		/** Timer used for delayed update of the PM QoS request. */
+		struct timer_list timer;
+
+		/** Response frequency target to use in GPU-bound conditions. */
+		uint32_t target_hz;
+
+		/**
+		 * Maximum delay before the PM QoS request is updated
+		 * after we become GPU-bound.
+		 */
+		uint32_t delay_max_ns;
+
+		/**
+		 * Exponent of delay slope used when the workload
+		 * becomes non-GPU-bound, used to provide greater
+		 * sensitivity to periods of GPU inactivity which may
+		 * indicate that the workload is latency-bound.
+		 */
+		uint32_t delay_slope_shift;
+
+		/**
+		 * Last time intel_gt_pm_active_begin() was called to
+		 * indicate that the GPU is a bottleneck.
+		 */
+		atomic64_t time_set_ns;
+
+		/**
+		 * Last time intel_gt_pm_active_end() was called to
+		 * indicate that the GPU is no longer a bottleneck.
+		 */
+		atomic64_t time_clear_ns;
+
+		/**
+		 * Number of times intel_gt_pm_active_begin() was
+		 * called without a matching intel_gt_pm_active_end().
+		 * Will be greater than zero if the GPU is currently
+		 * considered to be a bottleneck.
+		 */
+		atomic_t active_count;
+	} sf_qos;
 };
 
 enum intel_gt_scratch_field {
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index be5d6b71b6b0..767fa88f4d20 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -2365,6 +2365,12 @@ cancel_port_requests(struct intel_engine_execlists * const execlists)
 
 	smp_wmb(); /* complete the seqlock for execlists_active() */
 	WRITE_ONCE(execlists->active, execlists->inflight);
+
+	if (atomic_xchg(&execlists->overload, 0)) {
+		struct intel_engine_cs *engine =
+			container_of(execlists, typeof(*engine), execlists);
+		intel_gt_pm_active_end(engine->gt);
+	}
 }
 
 static inline void
@@ -2533,12 +2539,23 @@ static void process_csb(struct intel_engine_cs *engine)
 			WRITE_ONCE(execlists->active, execlists->inflight);
 
 			WRITE_ONCE(execlists->pending[0], NULL);
+
+                        if (execlists->inflight[1]) {
+                                if (!atomic_xchg(&execlists->overload, 1))
+                                        intel_gt_pm_active_begin(engine->gt);
+                        } else {
+                                if (atomic_xchg(&execlists->overload, 0))
+                                        intel_gt_pm_active_end(engine->gt);
+                        }
 		} else {
 			GEM_BUG_ON(!*execlists->active);
 
 			/* port0 completed, advanced to port1 */
 			trace_ports(execlists, "completed", execlists->active);
 
+                        if (atomic_xchg(&execlists->overload, 0))
+                                intel_gt_pm_active_end(engine->gt);
+
 			/*
 			 * We rely on the hardware being strongly
 			 * ordered, that the breadcrumb write is
-- 
2.22.1

