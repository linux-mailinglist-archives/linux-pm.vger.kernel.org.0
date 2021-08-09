Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC23E4CD3
	for <lists+linux-pm@lfdr.de>; Mon,  9 Aug 2021 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhHITQi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 15:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbhHITQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 15:16:31 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA052C06179B
        for <linux-pm@vger.kernel.org>; Mon,  9 Aug 2021 12:16:10 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d2so13420065qto.6
        for <linux-pm@vger.kernel.org>; Mon, 09 Aug 2021 12:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M441F/dCOu3tlQKnKAKIoZxwlYnqvhrWCGp9221xVHk=;
        b=B/c2BFtwUODWQxiL/AGJUFkAamP4RWl2XoUfsvJn9QDR9a399/ZTBwmRKwMwje5Xr6
         PKGs4maeDCpAcC6+KCqU2bncXRDT2O3Dr3FJYWR58DTp0kNTmeKCPPZfp8aFP43Kng6X
         N5a08unUtwE7qyyngKRg+vKHpS5Lc6RTfE2EiMMkEg5AEC40NFyuQCB7/cWuCng0T/bl
         wiN2SRRwwCQO9NIb/O9A2GPNt+zQN8b4TvhzyxBKcHJn+6XEAB6CdJuUgQfrTiLAi7TN
         /8JMZE2KVFkCpp+jqHpFS+Jd3JtEKduhcZAJ395eCk6A+KWZz5RP7k7oBXwTOujCqDNr
         r2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M441F/dCOu3tlQKnKAKIoZxwlYnqvhrWCGp9221xVHk=;
        b=oO7MHtleVdog3hIp12gAxjd0fWwToLuyvL6EeqndQfZMXvAL/EvE+XBok1a9ojbv28
         PIJVP1meLBAs/f+bq/2fLGnR+6sXaUlX1e2xWRxZizMQTY5CZGGrCkewCRd9URK+iHKN
         l+O5g445AAveoyXfMy0Uw7BbWNvT8lWXx+8GnurN72eFP0HxTzFCa6bHXbg0zl1dOdVz
         a5hHxB5HKnSvRdBQ6jLJ4cPVn239heDg8vSINRX0xiBPIkIGlPJvi9y2Gl1RgHJPlL5p
         Fb6XRIknegwJajQt3Tb+BweWUw3wxt9T9pbU8hPmu503C2o3/bKwgGHo8pRLyyi/UXqS
         EEbg==
X-Gm-Message-State: AOAM531CS3lpidby1urVUc2JwQubgC0twQr/3uY9vKiChFoCyDqzrclv
        2+jsw8PlwxMpwSHwERdbm6ulbw==
X-Google-Smtp-Source: ABdhPJxdXbXbKOX8+r/7UOK3yqpDMVli5Cpfq8grtLR+wJi5MnzfKHYVWrdAY5AN996Jg+XHn33gNA==
X-Received: by 2002:ac8:5b89:: with SMTP id a9mr7406884qta.282.1628536569797;
        Mon, 09 Aug 2021 12:16:09 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id n14sm7303398qti.47.2021.08.09.12.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 12:16:09 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     steev@kali.org, tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [Patch v5 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
Date:   Mon,  9 Aug 2021 15:16:01 -0400
Message-Id: <20210809191605.3742979-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809191605.3742979-1-thara.gopinath@linaro.org>
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
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

v4->v5:
	- Changed throttle_lock from a spinlock to mutex to take potential
	  race between LMh de-init sequence and reenabling of
	  interrupts/polling after a thermal throttle event.
	- Other cosmetic fixes as pointed out by Viresh.

v3->v4:
	- Dropped devm_ versions of request_irq and free_irq as per comments on
	  mailing list.
	- Introduced locking to prevent race between LMh de-init sequence and
	  re-enabling of interrupts/polling after a thermal throttle event.
	- Moved the LMh de-init sequence to qcom_cpufreq_hw_lmh_exit as per
	  Viresh's review comments
	- Code rearrangement as per Bjorn's review comments.
	- Moved the interrupt handling to threaded interrupt handling since Steev
	  reported some scheduling while atomic bug on the mailing list.

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

 drivers/cpufreq/qcom-cpufreq-hw.c | 147 ++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f86859bf76f1..d9f6da99af3a 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -7,12 +7,14 @@
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/interconnect.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #define LUT_MAX_ENTRIES			40U
 #define LUT_SRC				GENMASK(31, 30)
@@ -22,10 +24,13 @@
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
@@ -34,6 +39,16 @@ struct qcom_cpufreq_data {
 	void __iomem *base;
 	struct resource *res;
 	const struct qcom_cpufreq_soc_data *soc_data;
+
+	/*
+	 * Mutex to synchronize between de-init sequence and re-starting LMh
+	 * polling/interrupts
+	 */
+	struct mutex throttle_lock;
+	int throttle_irq;
+	bool cancel_throttle;
+	struct delayed_work throttle_work;
+	struct cpufreq_policy *policy;
 };
 
 static unsigned long cpu_hw_rate, xo_rate;
@@ -251,10 +266,92 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 	}
 }
 
+static unsigned int qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
+{
+	unsigned int val = readl_relaxed(data->base + data->soc_data->reg_current_vote);
+
+	return (val & 0x3FF) * 19200;
+}
+
+static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
+{
+	unsigned long max_capacity, capacity, freq_hz, throttled_freq;
+	struct cpufreq_policy *policy = data->policy;
+	int cpu = cpumask_first(policy->cpus);
+	struct device *dev = get_cpu_device(cpu);
+	struct dev_pm_opp *opp;
+	unsigned int freq;
+
+	/*
+	 * Get the h/w throttled frequency, normalize it using the
+	 * registered opp table and use it to calculate thermal pressure.
+	 */
+	freq = qcom_lmh_get_throttle_freq(data);
+	freq_hz = freq * HZ_PER_KHZ;
+
+	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
+	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
+		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
+
+	throttled_freq = freq_hz / HZ_PER_KHZ;
+
+	/* Update thermal pressure */
+
+	max_capacity = arch_scale_cpu_capacity(cpu);
+	capacity = mult_frac(max_capacity, throttled_freq, policy->cpuinfo.max_freq);
+
+	/* Don't pass boost capacity to scheduler */
+	if (capacity > max_capacity)
+		capacity = max_capacity;
+
+	arch_set_thermal_pressure(policy->cpus, max_capacity - capacity);
+
+	/*
+	 * In the unlikely case policy is unregistered do not enable
+	 * polling or h/w interrupt
+	 */
+	mutex_lock(&data->throttle_lock);
+	if (data->cancel_throttle)
+		goto out;
+
+	/*
+	 * If h/w throttled frequency is higher than what cpufreq has requested
+	 * for, then stop polling and switch back to interrupt mechanism.
+	 */
+	if (throttled_freq >= qcom_cpufreq_hw_get(cpu))
+		enable_irq(data->throttle_irq);
+	else
+		mod_delayed_work(system_highpri_wq, &data->throttle_work,
+				 msecs_to_jiffies(10));
+
+out:
+	mutex_unlock(&data->throttle_lock);
+}
+
+static void qcom_lmh_dcvs_poll(struct work_struct *work)
+{
+	struct qcom_cpufreq_data *data;
+
+	data = container_of(work, struct qcom_cpufreq_data, throttle_work.work);
+	qcom_lmh_dcvs_notify(data);
+}
+
+static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
+{
+	struct qcom_cpufreq_data *c_data = data;
+
+	/* Disable interrupt and enable polling */
+	disable_irq_nosync(c_data->throttle_irq);
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
@@ -274,6 +371,51 @@ static const struct of_device_id qcom_cpufreq_hw_match[] = {
 };
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
 
+static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
+{
+	struct qcom_cpufreq_data *data = policy->driver_data;
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	char irq_name[15];
+	int ret;
+
+	/*
+	 * Look for LMh interrupt. If no interrupt line is specified /
+	 * if there is an error, allow cpufreq to be enabled as usual.
+	 */
+	data->throttle_irq = platform_get_irq(pdev, index);
+	if (data->throttle_irq <= 0)
+		return data->throttle_irq == -EPROBE_DEFER ? -EPROBE_DEFER : 0;
+
+	data->cancel_throttle = false;
+	data->policy = policy;
+
+	mutex_init(&data->throttle_lock);
+	INIT_DEFERRABLE_WORK(&data->throttle_work, qcom_lmh_dcvs_poll);
+
+	snprintf(irq_name, sizeof(irq_name), "dcvsh-irq-%u", policy->cpu);
+	ret = request_threaded_irq(data->throttle_irq, NULL, qcom_lmh_dcvs_handle_irq,
+				   IRQF_ONESHOT, irq_name, data);
+	if (ret) {
+		dev_err(&pdev->dev, "Error registering %s: %d\n", irq_name, ret);
+		return 0;
+	}
+
+	return 0;
+}
+
+static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
+{
+	if (data->throttle_irq <= 0)
+		return;
+
+	mutex_lock(&data->throttle_lock);
+	data->cancel_throttle = true;
+	mutex_unlock(&data->throttle_lock);
+
+	cancel_delayed_work_sync(&data->throttle_work);
+	free_irq(data->throttle_irq, data);
+}
+
 static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
 	struct platform_device *pdev = cpufreq_get_driver_data();
@@ -370,6 +512,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
 	}
 
+	ret = qcom_cpufreq_hw_lmh_init(policy, index);
+	if (ret)
+		goto error;
+
 	return 0;
 error:
 	kfree(data);
@@ -389,6 +535,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
+	qcom_cpufreq_hw_lmh_exit(data);
 	kfree(policy->freq_table);
 	kfree(data);
 	iounmap(base);
-- 
2.25.1

