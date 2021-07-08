Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9037F3BF9C3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 14:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhGHMJo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 08:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhGHMJn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 08:09:43 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B65C061767
        for <linux-pm@vger.kernel.org>; Thu,  8 Jul 2021 05:07:01 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g4so5370526qkl.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jul 2021 05:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5EqCoI6W+ixz0QXctrX2bbY9FLbe4FNwGw/8Zp4eqY=;
        b=NwxHngVwMV5KoKgEA2QxxQEc1jAHqwmnIxsbZ7Su65g+iWfg2s5JW/u2rYYcHbFas/
         G65b/Ga9SDAL3yLj7CuW8K4ZTpr4aOhp1209K+bSIVDt45DCmZ2WgCbQvUSBE+ss/zo4
         VSRhHe3mLGi8CoDoHeJobFC1602geG1EYLShWpz/GrFWezB6Ajc3srwAdXSCw6qHbkvD
         rlvDJ3aR8y3frdweeyZvDj9MfZzblhBA+cOkFex36wSII6xzd7ZqvdhjcfkTfPKcq9Xz
         kMTwSAUd/pKX1Hqj20goRYJfkkFjigD7hgXivEMT52ogly1ywnc2NPsjNflZGJogSO+Z
         6vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5EqCoI6W+ixz0QXctrX2bbY9FLbe4FNwGw/8Zp4eqY=;
        b=LyG3YIq9iRWIxbrQFy0iPVfC7H8VtQM1jzzIVHLvbHtpSeOnt2ZDn107r9jnrYYDW9
         oHa30ngwcNjkckepEZ0H0gz1oEAVGEK0YkMzzZ/uRzlGIMEG1S4GQU/HTIpIbkfvImDN
         owBseteEKk5YJlB4aJXIncwDv51RElYuGaYVkCjEktYxGQVaQrqty8osrGzOHzcaanfy
         OdisbvZX1ADjFB021K43VmJIQQXg/WuN6Gr9FTsjSfUWpCo8tDRLGIBOtYKGR+/ccEif
         saUye6tnZ9O8Un6tSjftKEENhDs9tBf+Zl6sz9veyJDiswLIzLf7l94aDZhc/kaEZDYj
         d8XA==
X-Gm-Message-State: AOAM532klJv9pi7Ktd0bZM3gBgX7/wFQN/E/6V+v3RpFIZsOdHNy66Ra
        2ufw6PABEMD1uVJli/4B3AyK6A==
X-Google-Smtp-Source: ABdhPJx5T+Wt7Ko3p7YIA91aIL4Q+k7tNQDjrpZFMB5Yw+3t0ZzqItF4hozzlJi3ZUzLiG2ZcWN6SA==
X-Received: by 2002:a37:bb81:: with SMTP id l123mr29376033qkf.50.1625746020763;
        Thu, 08 Jul 2021 05:07:00 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id i2sm912541qko.43.2021.07.08.05.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 05:07:00 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [Patch v3 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
Date:   Thu,  8 Jul 2021 08:06:53 -0400
Message-Id: <20210708120656.663851-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708120656.663851-1-thara.gopinath@linaro.org>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interrupt support to notify the kernel of h/w initiated frequency
throttling by LMh. Convey this to scheduler via thermal presssure
interface.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v2->v3:
	- Cosmetic fixes from review comments on the list.
	- Moved all LMh initializations to qcom_cpufreq_hw_lmh_init.
	- Added freeing of LMh interrupt and cancelling the polling worker to
	  qcom_cpufreq_hw_cpu_exit as per Viresh's suggestion.
	- LMh interrupts are now tied to cpu dev and not cpufreq dev. This will be
	  useful for further generation of SoCs where the same interrupt signals
	  multiple cpu clusters.

v1->v2:
	- Introduced qcom_cpufreq_hw_lmh_init to consolidate LMh related initializations
	  as per Viresh's review comment.
	- Moved the piece of code restarting polling/re-enabling LMh interrupt to
	  qcom_lmh_dcvs_notify therby simplifying isr and timer callback as per Viresh's
	  suggestion.
	- Droped cpus from qcom_cpufreq_data and instead using cpus from cpufreq_policy in
	  qcom_lmh_dcvs_notify as per Viresh's review comment.
	- Dropped dt property qcom,support-lmh as per Bjorn's suggestion.
	- Other minor/cosmetic fixes

 drivers/cpufreq/qcom-cpufreq-hw.c | 118 ++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f86859bf76f1..bb5fc700d913 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -7,6 +7,7 @@
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/interconnect.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -22,10 +23,13 @@
 #define CLK_HW_DIV			2
 #define LUT_TURBO_IND			1
 
+#define HZ_PER_KHZ			1000
+
 struct qcom_cpufreq_soc_data {
 	u32 reg_enable;
 	u32 reg_freq_lut;
 	u32 reg_volt_lut;
+	u32 reg_current_vote;
 	u32 reg_perf_state;
 	u8 lut_row_size;
 };
@@ -33,7 +37,10 @@ struct qcom_cpufreq_soc_data {
 struct qcom_cpufreq_data {
 	void __iomem *base;
 	struct resource *res;
+	struct delayed_work lmh_dcvs_poll_work;
 	const struct qcom_cpufreq_soc_data *soc_data;
+	struct cpufreq_policy *policy;
+	int lmh_dcvs_irq;
 };
 
 static unsigned long cpu_hw_rate, xo_rate;
@@ -251,10 +258,84 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 	}
 }
 
+static inline unsigned long qcom_lmh_vote_to_freq(u32 val)
+{
+	return (val & 0x3FF) * 19200;
+}
+
+static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
+{
+	struct cpufreq_policy *policy = data->policy;
+	struct dev_pm_opp *opp;
+	struct device *dev;
+	unsigned long max_capacity, capacity, freq_hz, throttled_freq;
+	unsigned int val, freq;
+
+	/*
+	 * Get the h/w throttled frequency, normalize it using the
+	 * registered opp table and use it to calculate thermal pressure.
+	 */
+	val = readl_relaxed(data->base + data->soc_data->reg_current_vote);
+	freq = qcom_lmh_vote_to_freq(val);
+	freq_hz = freq * HZ_PER_KHZ;
+
+	dev = get_cpu_device(cpumask_first(policy->cpus));
+	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
+	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
+		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
+
+	throttled_freq = freq_hz / HZ_PER_KHZ;
+
+	/* Update thermal pressure */
+
+	max_capacity = arch_scale_cpu_capacity(cpumask_first(policy->cpus));
+	capacity = throttled_freq * max_capacity;
+	capacity /= policy->cpuinfo.max_freq;
+
+	/* Don't pass boost capacity to scheduler */
+	if (capacity > max_capacity)
+		capacity = max_capacity;
+
+	arch_set_thermal_pressure(policy->cpus, max_capacity - capacity);
+
+	/*
+	 * If h/w throttled frequency is higher than what cpufreq has requested for, stop
+	 * polling and switch back to interrupt mechanism
+	 */
+
+	if (throttled_freq >= qcom_cpufreq_hw_get(cpumask_first(policy->cpus)))
+		/* Clear the existing interrupts and enable it back */
+		enable_irq(data->lmh_dcvs_irq);
+	else
+		mod_delayed_work(system_highpri_wq, &data->lmh_dcvs_poll_work,
+				 msecs_to_jiffies(10));
+}
+
+static void qcom_lmh_dcvs_poll(struct work_struct *work)
+{
+	struct qcom_cpufreq_data *data;
+
+	data = container_of(work, struct qcom_cpufreq_data, lmh_dcvs_poll_work.work);
+
+	qcom_lmh_dcvs_notify(data);
+}
+
+static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
+{
+	struct qcom_cpufreq_data *c_data = data;
+
+	/* Disable interrupt and enable polling */
+	disable_irq_nosync(c_data->lmh_dcvs_irq);
+	qcom_lmh_dcvs_notify(c_data);
+
+	return 0;
+}
+
 static const struct qcom_cpufreq_soc_data qcom_soc_data = {
 	.reg_enable = 0x0,
 	.reg_freq_lut = 0x110,
 	.reg_volt_lut = 0x114,
+	.reg_current_vote = 0x704,
 	.reg_perf_state = 0x920,
 	.lut_row_size = 32,
 };
@@ -274,6 +355,35 @@ static const struct of_device_id qcom_cpufreq_hw_match[] = {
 };
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
 
+static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
+{
+	struct qcom_cpufreq_data *data = policy->driver_data;
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+	char irq_name[15];
+	int ret;
+
+	/*
+	 * Look for LMh interrupt. If no interrupt line is specified /
+	 * if there is an error, allow cpufreq to be enabled as usual.
+	 */
+	data->lmh_dcvs_irq = platform_get_irq(pdev, index);
+	if (data->lmh_dcvs_irq <= 0)
+		return data->lmh_dcvs_irq == -EPROBE_DEFER ? -EPROBE_DEFER : 0;
+
+	snprintf(irq_name, sizeof(irq_name), "dcvsh-irq-%u", policy->cpu);
+	ret = devm_request_irq(cpu_dev, data->lmh_dcvs_irq, qcom_lmh_dcvs_handle_irq,
+			       0, irq_name, data);
+	if (ret) {
+		dev_err(&pdev->dev, "Error %d registering irq %x\n", ret, data->lmh_dcvs_irq);
+		return 0;
+	}
+	data->policy = policy;
+	INIT_DEFERRABLE_WORK(&data->lmh_dcvs_poll_work, qcom_lmh_dcvs_poll);
+
+	return 0;
+}
+
 static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
 	struct platform_device *pdev = cpufreq_get_driver_data();
@@ -370,6 +480,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
 	}
 
+	ret = qcom_cpufreq_hw_lmh_init(policy, index);
+	if (ret)
+		goto error;
+
 	return 0;
 error:
 	kfree(data);
@@ -389,6 +503,10 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
+	if (data->lmh_dcvs_irq > 0) {
+		devm_free_irq(cpu_dev, data->lmh_dcvs_irq, data);
+		cancel_delayed_work_sync(&data->lmh_dcvs_poll_work);
+	}
 	kfree(policy->freq_table);
 	kfree(data);
 	iounmap(base);
-- 
2.25.1

