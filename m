Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FF03B2E51
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 13:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFXMAk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 08:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhFXMAi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 08:00:38 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8169C061766
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 04:58:18 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id w21so13611822qkb.9
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1RqI2JihFW90dtNWGF5blyO5heTXmifC8i6Ued20Fk=;
        b=lQsXVaeGXxule94APvdF7Bnow2co1yCB/I6wzKpljT/1r3Rkpn8Dze6/jqPjeBtziU
         MLCixNgRmikLfVu/x6jHaCsBS2SStI28kMbvFV4sUfD3um79gJNKirzR1j+lXT7C5AAo
         HoX+HQuoba75jbm7JiY87Yayfvhjy8uXWL0mmWfPWQl2w0gJ6xXXtHaCnDkbYx46p7EJ
         W1S5AAmSrch+JYw8NHsR4Ow1RBoE27/X9fiS2Gh63xQ757AEv84lrthXiEbIZ4cNdg8M
         PfwQSdoxuVbuI9bJPV3Si2Rl59hPCjPdS+tsATTy8joiw5VsBY8QfppldplIXxDrRWfD
         dgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1RqI2JihFW90dtNWGF5blyO5heTXmifC8i6Ued20Fk=;
        b=XXAGAwId/JV6hN4g5O0/DIW6c6wNiZax9ZJWDb4mwWjyXcrFRXTtsbLNfeMq0OPga0
         Me/PjOwP8UnNZl/xN83Moox3zT5ABdn+vtYPxp2qboQ0gWSmw1dPBrv3bCwwSF+CkwdS
         LdDTIyu1ZfpPD+kWeyBexd+f9qoabr/GivFNQVhn+P55rfksLqWD1A8EwfT6ZlfBam3W
         dgtyOnvhZeefSvWC+VxOz7XsDyG60VSFJu8BkgUVxDoqpO9dviYbCV+/UqBmOqb3sFUG
         T5hf1oakY9iBFnIdwMLzT5UtHGq9uNKrk2l1U5uUBobNMG87SZm/TcCVWJ/pzsXiVoZ/
         cR6g==
X-Gm-Message-State: AOAM530dIBjlghbufnVX5fHoXBYjHDqmyQEzG6kKd/tGNVAyPt3AqCZg
        wzSHEY1KFi+bRriUFrJ6K2zrAA==
X-Google-Smtp-Source: ABdhPJys7RFlneTZdP6BlohacHkjXHy/zUBl1BAWTCn2rilJ+YDX1gn4MV+of48h6TG7m0IL1yCesQ==
X-Received: by 2002:a37:9c84:: with SMTP id f126mr5385436qke.329.1624535897837;
        Thu, 24 Jun 2021 04:58:17 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id w3sm2287173qkp.55.2021.06.24.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 04:58:17 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [Patch v2 3/5] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
Date:   Thu, 24 Jun 2021 07:58:11 -0400
Message-Id: <20210624115813.3613290-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624115813.3613290-1-thara.gopinath@linaro.org>
References: <20210624115813.3613290-1-thara.gopinath@linaro.org>
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

 drivers/cpufreq/qcom-cpufreq-hw.c | 103 ++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f86859bf76f1..241f6f2b441f 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -13,6 +13,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #define LUT_MAX_ENTRIES			40U
 #define LUT_SRC				GENMASK(31, 30)
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
@@ -251,10 +258,79 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
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
+	max_capacity = arch_scale_cpu_capacity(cpumask_first(policy->cpus));
+	capacity = throttled_freq * max_capacity;
+	capacity /= policy->cpuinfo.max_freq;
+	/* Don't pass boost capacity to scheduler */
+	if (capacity > max_capacity)
+		capacity = max_capacity;
+	arch_set_thermal_pressure(policy->cpus, max_capacity - capacity);
+	/*
+	 * If h/w throttled frequency is higher than what cpufreq has requested for, stop
+	 * polling and switch back to interrupt mechanism
+	 */
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
@@ -274,6 +350,23 @@ static const struct of_device_id qcom_cpufreq_hw_match[] = {
 };
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
 
+static void qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy)
+{
+	struct qcom_cpufreq_data *data = policy->driver_data;
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = devm_request_irq(dev, data->lmh_dcvs_irq, qcom_lmh_dcvs_handle_irq,
+			       0, "dcvsh-irq", data);
+	if (ret) {
+		dev_err(dev, "Error %d registering irq %x\n", ret, data->lmh_dcvs_irq);
+		return;
+	}
+	data->policy = policy;
+	INIT_DEFERRABLE_WORK(&data->lmh_dcvs_poll_work, qcom_lmh_dcvs_poll);
+}
+
 static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
 	struct platform_device *pdev = cpufreq_get_driver_data();
@@ -370,6 +463,16 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
 	}
 
+	/* Look for LMh interrupt. If no interrupt line is specified /
+	 * if there is an error, allow cpufreq to be enabled as usual.
+	 */
+	data->lmh_dcvs_irq = platform_get_irq(pdev, index);
+	if (data->lmh_dcvs_irq > 0) {
+		qcom_cpufreq_hw_lmh_init(policy);
+	} else if (data->lmh_dcvs_irq != -ENXIO) {
+		ret = data->lmh_dcvs_irq;
+		goto error;
+	}
 	return 0;
 error:
 	kfree(data);
-- 
2.25.1

