Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9162125898
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 22:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfEUUBZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 16:01:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36400 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfEUUBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 16:01:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so8948662plr.3;
        Tue, 21 May 2019 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Au+NbFoVB7h26BiFh23piIfTCu03ukyEhESCMY5pWqQ=;
        b=lysHNy5N5q2c8xnJVNzGMNqjxZzWq753oa2JBtnERJ7bkE7Aknygqm/ljCEc+ioL12
         BQQcYCJyajMinP/b8jqryJC8fYJplzXiXTRhx9Kq5hVKUxjdfDP/O4S80XJ+X1aBSKI+
         BZ6K0qzpjVBosq2lUSuC8+QKwaaU7TMxk+GULx16h9ig5FFzUyGF/++P/eIa/9DG77cd
         F9555BTwABr/swbjUBfh6TubCH+oEAayQl5x7Zk0wuXUB39MPFvMxNc3dpja2PLxdSZN
         Lp4FhWiEzzAWtd4W5HayvIGZTfkNK6riwfuEf/XOBxHX0nbJkDwrGTtEz0icT4InTPB6
         rPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Au+NbFoVB7h26BiFh23piIfTCu03ukyEhESCMY5pWqQ=;
        b=FGgAT4s1X1w1s0nT+9iyj2NVUI3Yr8bsXPvfvZ/U/UQvPGlNeulWoW1Ato3GcM+4l6
         yV1apvUKFnhYK0x9hifnbl9OlxJgd6c6h0HMJ0ER60igwBfh+zSadw7e7a7rJqC0hmiP
         9QNqnKW07aiB12nM5js1A/kArz3BQfY3Z/Q4FxjkUzOvTeXnIh1tYa/2iqi/eC8QD2zK
         B2DEOqAsdkGU62wUWcZXFOqZ9HjDCF7soshePeY1VXyVYWJUIX2G8liRxiAeqF5wX2Zv
         suOT9d0hQJOYrFeWUaxPucrrNtEZ+yw1Yp3uZbzv82d8TU39H5CdH/4GLwZXl+QAhUAk
         v+sQ==
X-Gm-Message-State: APjAAAXxlqd9xE0rx4RU3R1loxVqctsw4KWcLMyimOaxt3QxGuyK0OMh
        DP22H712U1xOdvA2lnQQi3Q=
X-Google-Smtp-Source: APXvYqxiUyMgVobbSKGjhyYf8M4TJ++mQOirS0lxImbqjyqRXCnNI8HBacB67jV2uPGVBDV/FGGUSw==
X-Received: by 2002:a17:902:8d96:: with SMTP id v22mr9881414plo.282.1558468883476;
        Tue, 21 May 2019 13:01:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b3sm39225272pfr.146.2019.05.21.13.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 13:01:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     james.quinlan@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH RFC] firmware: arm_scmi: Allow for better protocol extensibility
Date:   Tue, 21 May 2019 13:01:09 -0700
Message-Id: <20190521200110.8309-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SCMI specific allows implementors to define their custom protocols
in the 0x80-0xFF space. The current scmi_handle structure requires us to
extend the structure with a set of operations and associated private
data in a way that is not quite scaling well.

Create a 255 bytes structure that contains an opaque pointer to a set of
operations and private data and create two helper functions to retrieve
those based on the protocol identifier. Several options were considered,
like using a linked list but since we could be performance sensitive in
some paths, using an array was faster and simpler.

Convert all call sites to use either scmi_protocol_get_ops() or
scmi_protocol_get_info().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Hi Sudeep,

There could be better ways to deal with that, another could be to avoid
passing the scmi_handle around, but instead pass a scmi_dev instance
which already has a set of operations specific to the protocols already
set and provides storage for private data as well.

Let me know if you find this appropriate either way.

 drivers/clk/clk-scmi.c                     | 29 +++++++++++++----
 drivers/cpufreq/scmi-cpufreq.c             | 37 +++++++++++++++-------
 drivers/firmware/arm_scmi/bus.c            | 10 ++++++
 drivers/firmware/arm_scmi/clock.c          | 10 +++---
 drivers/firmware/arm_scmi/perf.c           | 22 +++++++++----
 drivers/firmware/arm_scmi/power.c          | 11 ++++---
 drivers/firmware/arm_scmi/scmi_pm_domain.c | 14 +++++---
 drivers/firmware/arm_scmi/sensors.c        | 10 +++---
 drivers/hwmon/scmi-hwmon.c                 | 16 +++++++---
 include/linux/scmi_protocol.h              | 27 ++++++++++------
 10 files changed, 130 insertions(+), 56 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index a2287c770d5c..df3ad904f454 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -28,8 +28,11 @@ static unsigned long scmi_clk_recalc_rate(struct clk_hw *hw,
 	int ret;
 	u64 rate;
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	const struct scmi_clk_ops *clk_ops;
 
-	ret = clk->handle->clk_ops->rate_get(clk->handle, clk->id, &rate);
+	clk_ops = scmi_protocol_get_ops(clk->handle, SCMI_PROTOCOL_CLOCK);
+
+	ret = clk_ops->rate_get(clk->handle, clk->id, &rate);
 	if (ret)
 		return 0;
 	return rate;
@@ -68,22 +71,31 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 			     unsigned long parent_rate)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	const struct scmi_clk_ops *clk_ops;
+
+	clk_ops = scmi_protocol_get_ops(clk->handle, SCMI_PROTOCOL_CLOCK);
 
-	return clk->handle->clk_ops->rate_set(clk->handle, clk->id, 0, rate);
+	return clk_ops->rate_set(clk->handle, clk->id, 0, rate);
 }
 
 static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	const struct scmi_clk_ops *clk_ops;
+
+	clk_ops = scmi_protocol_get_ops(clk->handle, SCMI_PROTOCOL_CLOCK);
 
-	return clk->handle->clk_ops->enable(clk->handle, clk->id);
+	return clk_ops->enable(clk->handle, clk->id);
 }
 
 static void scmi_clk_disable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	const struct scmi_clk_ops *clk_ops;
 
-	clk->handle->clk_ops->disable(clk->handle, clk->id);
+	clk_ops = scmi_protocol_get_ops(clk->handle, SCMI_PROTOCOL_CLOCK);
+
+	clk_ops->disable(clk->handle, clk->id);
 }
 
 static const struct clk_ops scmi_clk_ops = {
@@ -126,11 +138,14 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	const struct scmi_handle *handle = sdev->handle;
+	const struct scmi_clk_ops *clk_ops;
+
+	clk_ops = scmi_protocol_get_ops(handle, SCMI_PROTOCOL_CLOCK);
 
-	if (!handle || !handle->clk_ops)
+	if (!handle || !clk_ops)
 		return -ENODEV;
 
-	count = handle->clk_ops->count_get(handle);
+	count = clk_ops->count_get(handle);
 	if (count < 0) {
 		dev_err(dev, "%pOFn: invalid clock output count\n", np);
 		return -EINVAL;
@@ -151,7 +166,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		if (!sclk)
 			return -ENOMEM;
 
-		sclk->info = handle->clk_ops->info_get(handle, idx);
+		sclk->info = clk_ops->info_get(handle, idx);
 		if (!sclk->info) {
 			dev_dbg(dev, "invalid clock info for idx %d\n", idx);
 			continue;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index e6182c89df79..3eb802e78f97 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -29,11 +29,13 @@ static const struct scmi_handle *handle;
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scmi_perf_ops *perf_ops = handle->perf_ops;
 	struct scmi_data *priv = policy->driver_data;
+	const struct scmi_perf_ops *perf_ops;
 	unsigned long rate;
 	int ret;
 
+	perf_ops = scmi_protocol_get_ops(handle, SCMI_PROTOCOL_PERF);
+
 	ret = perf_ops->freq_get(handle, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;
@@ -50,9 +52,11 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	int ret;
 	struct scmi_data *priv = policy->driver_data;
-	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+	const struct scmi_perf_ops *perf_ops;
 	u64 freq = policy->freq_table[index].frequency;
 
+	perf_ops = scmi_protocol_get_ops(handle, SCMI_PROTOCOL_PERF);
+
 	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
 	if (!ret)
 		arch_set_freq_scale(policy->related_cpus, freq,
@@ -64,7 +68,9 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					     unsigned int target_freq)
 {
 	struct scmi_data *priv = policy->driver_data;
-	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+	const struct scmi_perf_ops *perf_ops;
+
+	perf_ops = scmi_protocol_get_ops(handle, SCMI_PROTOCOL_PERF);
 
 	if (!perf_ops->freq_set(handle, priv->domain_id,
 				target_freq * 1000, true)) {
@@ -79,10 +85,13 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 static int
 scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
+	const struct scmi_perf_ops *perf_ops;
 	int cpu, domain, tdomain;
 	struct device *tcpu_dev;
 
-	domain = handle->perf_ops->device_domain_id(cpu_dev);
+	perf_ops = scmi_protocol_get_ops(handle, SCMI_PROTOCOL_PERF);
+
+	domain = perf_ops->device_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
@@ -94,7 +103,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 		if (!tcpu_dev)
 			continue;
 
-		tdomain = handle->perf_ops->device_domain_id(tcpu_dev);
+		tdomain = perf_ops->device_domain_id(tcpu_dev);
 		if (tdomain == domain)
 			cpumask_set_cpu(cpu, cpumask);
 	}
@@ -106,6 +115,7 @@ static int __maybe_unused
 scmi_get_cpu_power(unsigned long *power, unsigned long *KHz, int cpu)
 {
 	struct device *cpu_dev = get_cpu_device(cpu);
+	const struct scmi_perf_ops *perf_ops;
 	unsigned long Hz;
 	int ret, domain;
 
@@ -114,13 +124,15 @@ scmi_get_cpu_power(unsigned long *power, unsigned long *KHz, int cpu)
 		return -ENODEV;
 	}
 
-	domain = handle->perf_ops->device_domain_id(cpu_dev);
+	perf_ops = scmi_protocol_get_ops(handle, SCMI_PROTOCOL_PERF);
+
+	domain = perf_ops->device_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
 	/* Get the power cost of the performance domain. */
 	Hz = *KHz * 1000;
-	ret = handle->perf_ops->est_power_get(handle, domain, &Hz, power);
+	ret = perf_ops->est_power_get(handle, domain, &Hz, power);
 	if (ret)
 		return ret;
 
@@ -138,6 +150,9 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	struct scmi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
 	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
+	const struct scmi_perf_ops *perf_ops;
+
+	perf_ops = scmi_protocol_get_ops(handle, SCMI_PROTOCOL_PERF);
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -145,7 +160,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
+	ret = perf_ops->device_opps_add(handle, cpu_dev);
 	if (ret) {
 		dev_warn(cpu_dev, "failed to add opps to the device\n");
 		return ret;
@@ -184,7 +199,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->cpu_dev = cpu_dev;
-	priv->domain_id = handle->perf_ops->device_domain_id(cpu_dev);
+	priv->domain_id = perf_ops->device_domain_id(cpu_dev);
 
 	policy->driver_data = priv;
 	policy->freq_table = freq_table;
@@ -192,7 +207,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	/* SCMI allows DVFS request for any domain from any CPU */
 	policy->dvfs_possible_from_any_cpu = true;
 
-	latency = handle->perf_ops->transition_latency_get(handle, cpu_dev);
+	latency = perf_ops->transition_latency_get(handle, cpu_dev);
 	if (!latency)
 		latency = CPUFREQ_ETERNAL;
 
@@ -243,7 +258,7 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 
 	handle = sdev->handle;
 
-	if (!handle || !handle->perf_ops)
+	if (!handle || !scmi_protocol_get_ops(handle, SCMI_PROTOCOL_PERF))
 		return -ENODEV;
 
 	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 92f843eaf1e0..f2cf84ed1aad 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -47,6 +47,16 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
+void scmi_protocol_register_ops(struct scmi_handle *handle, u8 protocol_id,
+				const void *ops, void *priv)
+{
+	spin_lock(&protocol_lock);
+	handle->protocols[protocol_id].ops = ops;
+	handle->protocols[protocol_id].priv = priv;
+	spin_unlock(&protocol_lock);
+}
+EXPORT_SYMBOL_GPL(scmi_protocol_register_ops);
+
 static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
 {
 	scmi_prot_init_fn_t fn = idr_find(&scmi_protocols, protocol_id);
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 30fc04e28431..21a072eb4dc7 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -273,7 +273,8 @@ static int scmi_clock_disable(const struct scmi_handle *handle, u32 clk_id)
 
 static int scmi_clock_count_get(const struct scmi_handle *handle)
 {
-	struct clock_info *ci = handle->clk_priv;
+	struct clock_info *ci = scmi_protocol_get_priv(handle,
+						       SCMI_PROTOCOL_CLOCK);
 
 	return ci->num_clocks;
 }
@@ -281,7 +282,8 @@ static int scmi_clock_count_get(const struct scmi_handle *handle)
 static const struct scmi_clock_info *
 scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
 {
-	struct clock_info *ci = handle->clk_priv;
+	struct clock_info *ci = scmi_protocol_get_priv(handle,
+						       SCMI_PROTOCOL_CLOCK);
 	struct scmi_clock_info *clk = ci->clk + clk_id;
 
 	if (!clk->name[0])
@@ -329,8 +331,8 @@ static int scmi_clock_protocol_init(struct scmi_handle *handle)
 			scmi_clock_describe_rates_get(handle, clkid, clk);
 	}
 
-	handle->clk_ops = &clk_ops;
-	handle->clk_priv = cinfo;
+	scmi_protocol_register_ops(handle, SCMI_PROTOCOL_CLOCK,
+				   &clk_ops, cinfo);
 
 	return 0;
 }
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 3c8ae7cc35de..dffbd9fd8844 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -362,7 +362,9 @@ static int scmi_dvfs_device_opps_add(const struct scmi_handle *handle,
 	unsigned long freq;
 	struct scmi_opp *opp;
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi;
+
+	pi = scmi_protocol_get_priv(handle, SCMI_PROTOCOL_PERF);
 
 	domain = scmi_dev_domain_id(dev);
 	if (domain < 0)
@@ -391,9 +393,11 @@ static int scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
 					    struct device *dev)
 {
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi;
 	int domain = scmi_dev_domain_id(dev);
 
+	pi = scmi_protocol_get_priv(handle, SCMI_PROTOCOL_PERF);
+
 	if (domain < 0)
 		return domain;
 
@@ -405,7 +409,8 @@ static int scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
 static int scmi_dvfs_freq_set(const struct scmi_handle *handle, u32 domain,
 			      unsigned long freq, bool poll)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = scmi_protocol_get_priv(handle,
+							   SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	return scmi_perf_level_set(handle, domain, freq / dom->mult_factor,
@@ -417,7 +422,8 @@ static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
 {
 	int ret;
 	u32 level;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = scmi_protocol_get_priv(handle,
+							   SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	ret = scmi_perf_level_get(handle, domain, &level, poll);
@@ -430,12 +436,14 @@ static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
 static int scmi_dvfs_est_power_get(const struct scmi_handle *handle, u32 domain,
 				   unsigned long *freq, unsigned long *power)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi;
 	struct perf_dom_info *dom;
 	unsigned long opp_freq;
 	int idx, ret = -EINVAL;
 	struct scmi_opp *opp;
 
+	pi = scmi_protocol_get_priv(handle, SCMI_PROTOCOL_PERF);
+
 	dom = pi->dom_info + domain;
 	if (!dom)
 		return -EIO;
@@ -496,8 +504,8 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
 		scmi_perf_describe_levels_get(handle, domain, dom);
 	}
 
-	handle->perf_ops = &perf_ops;
-	handle->perf_priv = pinfo;
+	scmi_protocol_register_ops(handle, SCMI_PROTOCOL_PERF,
+				   &perf_ops, pinfo);
 
 	return 0;
 }
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 62f3401a1f01..a18df6e0786b 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -159,14 +159,17 @@ scmi_power_state_get(const struct scmi_handle *handle, u32 domain, u32 *state)
 
 static int scmi_power_num_domains_get(const struct scmi_handle *handle)
 {
-	struct scmi_power_info *pi = handle->power_priv;
+	struct scmi_power_info *pi;
+
+	pi = scmi_protocol_get_priv(handle, SCMI_PROTOCOL_POWER);
 
 	return pi->num_domains;
 }
 
 static char *scmi_power_name_get(const struct scmi_handle *handle, u32 domain)
 {
-	struct scmi_power_info *pi = handle->power_priv;
+	struct scmi_power_info *pi = scmi_protocol_get_priv(handle,
+							   SCMI_PROTOCOL_POWER);
 	struct power_dom_info *dom = pi->dom_info + domain;
 
 	return dom->name;
@@ -207,8 +210,8 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
 		scmi_power_domain_attributes_get(handle, domain, dom);
 	}
 
-	handle->power_ops = &power_ops;
-	handle->power_priv = pinfo;
+	scmi_protocol_register_ops(handle, SCMI_PROTOCOL_POWER,
+				   &power_ops, pinfo);
 
 	return 0;
 }
diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/firmware/arm_scmi/scmi_pm_domain.c
index 87f737e01473..2989fcc7d6bd 100644
--- a/drivers/firmware/arm_scmi/scmi_pm_domain.c
+++ b/drivers/firmware/arm_scmi/scmi_pm_domain.c
@@ -25,7 +25,9 @@ static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
 	int ret;
 	u32 state, ret_state;
 	struct scmi_pm_domain *pd = to_scmi_pd(domain);
-	const struct scmi_power_ops *ops = pd->handle->power_ops;
+	const struct scmi_power_ops *ops;
+
+	ops = scmi_protocol_get_ops(pd->handle, SCMI_PROTOCOL_POWER);
 
 	if (power_on)
 		state = SCMI_POWER_STATE_GENERIC_ON;
@@ -60,11 +62,13 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 	struct genpd_onecell_data *scmi_pd_data;
 	struct generic_pm_domain **domains;
 	const struct scmi_handle *handle = sdev->handle;
+	const struct scmi_power_ops *power_ops;
 
-	if (!handle || !handle->power_ops)
+	power_ops = scmi_protocol_get_ops(handle, SCMI_PROTOCOL_POWER);
+	if (!handle || !power_ops)
 		return -ENODEV;
 
-	num_domains = handle->power_ops->num_domains_get(handle);
+	num_domains = power_ops->num_domains_get(handle);
 	if (num_domains < 0) {
 		dev_err(dev, "number of domains not found\n");
 		return num_domains;
@@ -89,12 +93,12 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 
 		scmi_pd->domain = i;
 		scmi_pd->handle = handle;
-		scmi_pd->name = handle->power_ops->name_get(handle, i);
+		scmi_pd->name = power_ops->name_get(handle, i);
 		scmi_pd->genpd.name = scmi_pd->name;
 		scmi_pd->genpd.power_off = scmi_pd_power_off;
 		scmi_pd->genpd.power_on = scmi_pd_power_on;
 
-		if (handle->power_ops->state_get(handle, i, &state)) {
+		if (power_ops->state_get(handle, i, &state)) {
 			dev_warn(dev, "failed to get state for domain %d\n", i);
 			continue;
 		}
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index b53d5cc9c9f6..a7b0a275f509 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -234,14 +234,16 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 static const struct scmi_sensor_info *
 scmi_sensor_info_get(const struct scmi_handle *handle, u32 sensor_id)
 {
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si = scmi_protocol_get_priv(handle,
+							 SCMI_PROTOCOL_SENSOR);
 
 	return si->sensors + sensor_id;
 }
 
 static int scmi_sensor_count_get(const struct scmi_handle *handle)
 {
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si = scmi_protocol_get_priv(handle,
+							 SCMI_PROTOCOL_SENSOR);
 
 	return si->num_sensors;
 }
@@ -277,8 +279,8 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 
 	scmi_sensor_description_get(handle, sinfo);
 
-	handle->sensor_ops = &sensor_ops;
-	handle->sensor_priv = sinfo;
+	scmi_protocol_register_ops(handle, SCMI_PROTOCOL_SENSOR, &sensor_ops,
+				   sinfo);
 
 	return 0;
 }
diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index a80183a488c5..b8508b0073c4 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -26,9 +26,12 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	const struct scmi_sensor_info *sensor;
 	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
 	const struct scmi_handle *h = scmi_sensors->handle;
+	const struct scmi_sensor_ops *sensor_ops;
+
+	sensor_ops = scmi_protocol_get_ops(h, SCMI_PROTOCOL_SENSOR);
 
 	sensor = *(scmi_sensors->info[type] + channel);
-	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
+	ret = sensor_ops->reading_get(h, sensor->id, false, &value);
 	if (!ret)
 		*val = value;
 
@@ -121,11 +124,14 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	struct hwmon_channel_info *scmi_hwmon_chan;
 	const struct hwmon_channel_info **ptr_scmi_ci;
 	const struct scmi_handle *handle = sdev->handle;
+	const struct scmi_sensor_ops *sensor_ops;
+
+	sensor_ops = scmi_protocol_get_ops(handle, SCMI_PROTOCOL_SENSOR);
 
-	if (!handle || !handle->sensor_ops)
+	if (!handle || !sensor_ops)
 		return -ENODEV;
 
-	nr_sensors = handle->sensor_ops->count_get(handle);
+	nr_sensors = sensor_ops->count_get(handle);
 	if (!nr_sensors)
 		return -EIO;
 
@@ -136,7 +142,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	scmi_sensors->handle = handle;
 
 	for (i = 0; i < nr_sensors; i++) {
-		sensor = handle->sensor_ops->info_get(handle, i);
+		sensor = sensor_ops->info_get(handle, i);
 		if (!sensor)
 			return -EINVAL;
 
@@ -186,7 +192,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	}
 
 	for (i = nr_sensors - 1; i >= 0 ; i--) {
-		sensor = handle->sensor_ops->info_get(handle, i);
+		sensor = sensor_ops->info_get(handle, i);
 		if (!sensor)
 			continue;
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 3105055c00a7..a02129320bfe 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -205,17 +205,24 @@ struct scmi_sensor_ops {
 struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
-	struct scmi_perf_ops *perf_ops;
-	struct scmi_clk_ops *clk_ops;
-	struct scmi_power_ops *power_ops;
-	struct scmi_sensor_ops *sensor_ops;
-	/* for protocol internal use */
-	void *perf_priv;
-	void *clk_priv;
-	void *power_priv;
-	void *sensor_priv;
+	struct scmi_handle_protocols {
+		const void *ops;
+		void *priv;
+	} protocols[255];
 };
 
+static inline const void *scmi_protocol_get_ops(const struct scmi_handle *h,
+						u8 protocol_id)
+{
+	return h->protocols[protocol_id].ops;
+}
+
+static inline void *scmi_protocol_get_priv(const struct scmi_handle *h,
+					   u8 protocol_id)
+{
+	return h->protocols[protocol_id].priv;
+}
+
 enum scmi_std_protocol {
 	SCMI_PROTOCOL_BASE = 0x10,
 	SCMI_PROTOCOL_POWER = 0x11,
@@ -286,4 +293,6 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
 
 typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
 int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
+void scmi_protocol_register_ops(struct scmi_handle *handle, u8 protocol_id,
+				const void *ops, void *priv);
 void scmi_protocol_unregister(int protocol_id);
-- 
2.17.1

