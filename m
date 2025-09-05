Return-Path: <linux-pm+bounces-33991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C0B45968
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 15:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EA816951E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 13:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6B0352FE2;
	Fri,  5 Sep 2025 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVIShrRC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A4350D56;
	Fri,  5 Sep 2025 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079890; cv=none; b=T4mBUfUKg0FdsybQard3nH9IP76iV7fv/TDh1Tz/beNS2lApT6HNI8ZUTdU/UX5LYW/0uZMDh6SZVOgRgX0fbWKoxr2c3rjYKZSF5i8OgofIcxuX4nC5gfIW/gWOiRN5aCD8M/PjFt6Zc4zHTqH93hRnr3b3i56q6Ax8uZqWmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079890; c=relaxed/simple;
	bh=MO/H6RoJQwVx0rcd9VosdsqoSJCVLIh+OTCyOC4yNF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V/8J0PvZrSXiBLADAYTCSFMHQJ3+zZIkMsfcqkFVDsSd+Sa6e6r/TpE1hCrzw1jqFtFj4/+GijovOz05YZCJqZDDo8PzAI1Q6INfd7uXmHXwiPkCaUshMcIITYK9OkAYv9HBs/f++wJ65w3vbvSuUBhOAGA3MI/RDlZOKjQoHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVIShrRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830A1C4CEF1;
	Fri,  5 Sep 2025 13:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757079890;
	bh=MO/H6RoJQwVx0rcd9VosdsqoSJCVLIh+OTCyOC4yNF8=;
	h=From:To:Cc:Subject:Date:From;
	b=tVIShrRCjTgQhefAZ9nH4dNzLg+Oa9YoRK3fGtifwoVeSwVIWuasOhXPJSRiLGPuN
	 /z1Q/waEoo/+6eeWx60Y827WkNpGPjPxhuyTZy9leqjgEhWsEdpUHLk+y7mv5060w0
	 bMeqA+KLQYU9Bx+8pnx9li7i7gowCdhBFe+8l5OEHZf/F2jyruD4SWFzzXj2ZV0Q3q
	 0qcbJoyJbnZbEvyE+/oIvImHjlzSOVGvlykoher8e6PX8Uurbt8bdS6tz7AX4vZCvL
	 Cj2mLoJwzHypMS+6rbFddq71LJT1esaJLg8x+W0lrgGIqCmua8W0j+6KufXaL9ydjW
	 Igh+TItoTW7uQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Kenneth R. Crudup" <kenny@panix.com>
Subject:
 [PATCH v1] PM: EM: Add function for registering a PD without capacity update
Date: Fri, 05 Sep 2025 15:44:45 +0200
Message-ID: <5939134.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The intel_pstate driver manages CPU capacity changes itself and it does
not need an update of the capacity of all CPUs in the system to be
carried out after registering a PD.

Moreover, in some configurations (for instance, an SMT-capable
hybrid x86 system booted with nosmt in the kernel command line) the
em_check_capacity_update() call at the end of em_dev_register_perf_domain()
always fails and reschedules itself to run once again in 1 s, so
effectively it runs in vain every 1 s forever.

To address this, introduce a new variant of em_dev_register_perf_domain(),
called em_dev_register_pd_no_update(), that does not invoke
em_check_capacity_update(), and make intel_pstate use it instead of the
original.

Fixes: 7b010f9b9061 ("cpufreq: intel_pstate: EAS support for hybrid platforms")
Link: https://lore.kernel.org/linux-pm/40212796-734c-4140-8a85-854f72b8144d@panix.com/
Reported-by: Kenneth R. Crudup <kenny@panix.com>
Tested-by: Kenneth R. Crudup <kenny@panix.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
---

Normally, I would place the definition of em_dev_register_pd_no_update()
before the definition of em_dev_register_perf_domain() which called it,
but in this particular case that would cause the real change to be much
harder to grasp.

---
 drivers/cpufreq/intel_pstate.c |    4 ++--
 include/linux/energy_model.h   |   10 ++++++++++
 kernel/power/energy_model.c    |   29 +++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 6 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1034,8 +1034,8 @@ static bool hybrid_register_perf_domain(
 	if (!cpu_dev)
 		return false;
 
-	if (em_dev_register_perf_domain(cpu_dev, HYBRID_EM_STATE_COUNT, &cb,
-					cpumask_of(cpu), false))
+	if (em_dev_register_pd_no_update(cpu_dev, HYBRID_EM_STATE_COUNT, &cb,
+					 cpumask_of(cpu), false))
 		return false;
 
 	cpudata->pd_registered = true;
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -171,6 +171,9 @@ int em_dev_update_perf_domain(struct dev
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				const struct em_data_callback *cb,
 				const cpumask_t *cpus, bool microwatts);
+int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
+				 const struct em_data_callback *cb,
+				 const cpumask_t *cpus, bool microwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
 struct em_perf_table *em_table_alloc(struct em_perf_domain *pd);
 void em_table_free(struct em_perf_table *table);
@@ -350,6 +353,13 @@ int em_dev_register_perf_domain(struct d
 {
 	return -EINVAL;
 }
+static inline
+int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
+				 const struct em_data_callback *cb,
+				 const cpumask_t *cpus, bool microwatts)
+{
+	return -EINVAL;
+}
 static inline void em_dev_unregister_perf_domain(struct device *dev)
 {
 }
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -553,6 +553,30 @@ int em_dev_register_perf_domain(struct d
 				const struct em_data_callback *cb,
 				const cpumask_t *cpus, bool microwatts)
 {
+	int ret = em_dev_register_pd_no_update(dev, nr_states, cb, cpus, microwatts);
+
+	if (_is_cpu_device(dev))
+		em_check_capacity_update();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
+
+/**
+ * em_dev_register_pd_no_update() - Register a perf domain for a device
+ * @dev : Device to register the PD for
+ * @nr_states : Number of performance states in the new PD
+ * @cb : Callback functions for populating the energy model
+ * @cpus : CPUs to include in the new PD (mandatory if @dev is a CPU device)
+ * @microwatts : Whether or not the power values in the EM will be in uW
+ *
+ * Like em_dev_register_perf_domain(), but does not trigger a CPU capacity
+ * update after registering the PD, even if @dev is a CPU device.
+ */
+int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
+				 const struct em_data_callback *cb,
+				 const cpumask_t *cpus, bool microwatts)
+{
 	struct em_perf_table *em_table;
 	unsigned long cap, prev_cap = 0;
 	unsigned long flags = 0;
@@ -636,12 +660,9 @@ int em_dev_register_perf_domain(struct d
 unlock:
 	mutex_unlock(&em_pd_mutex);
 
-	if (_is_cpu_device(dev))
-		em_check_capacity_update();
-
 	return ret;
 }
-EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
+EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
 
 /**
  * em_dev_unregister_perf_domain() - Unregister Energy Model (EM) for a device




