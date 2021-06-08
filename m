Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD353A06DE
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 00:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhFHWci (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 18:32:38 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:39832 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbhFHWch (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 18:32:37 -0400
Received: by mail-qt1-f182.google.com with SMTP id p21so4798861qtw.6
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kv52q5OkhetJHuJO/uBANPhEtNpMztw2QDevSUVhoyk=;
        b=qQAk0AZFhr3Eil+3IPei4tIjW2vaAakrRLTalW7XSgtVcWkqFdHiOpxd3U2sNdSZSz
         +YKz/4xWcdxqBy6ud1BDevM/KqwTutK62o7az4YWhCVqnvSOR75eNRr1YTyykbe5K45r
         drWiD2zPTROk/V0SMJyk3PdBii3sudFtn7FKtlOkoDSbpbPFonaKHs+RGOnzNDSz3Z4e
         WCQ95YIIPhQH+rrQL9FFYHe339kZgL4At1iH8ORjT7aRf4gj/3TdW7ADVo6/w9dvYZM1
         CgETorKHr/oSFOgBPY7fZJfpmbwpytcallpKLleECHU56EWh5BZ+UWM+UjPztPxEzSvQ
         sF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kv52q5OkhetJHuJO/uBANPhEtNpMztw2QDevSUVhoyk=;
        b=NHqjPhktALgyKoSj7dJhvEscOoN5eHVk5kU3gYMtfK4Cx4O3JxsYuC07O0Z5bli7Et
         gZV0uXyAStVhgzzJUI1wePdQv/0z5YHB36DV8bfmsp3RSokK9Hl4hcdQKZ4yGL/uSAxp
         5XspjtGme4JdPJESX2iApvR/okF76b9DpDn9YFhOpgDpzcNJjyFG5xL+LFxoG5zhrcvs
         0yclOkqSdKqTZuYrZJ5CWJUdTiZCHPnx+r9DbwgkMrO+D61w3Zp9O2cv4jfZ5kjnFViz
         ec5lkQHWq/yKyhSkFnwgBzeTJIxmiBaaKZXZCjhEoi6KDeVi/7PvZnNSqai6jnjQDo8o
         qJQA==
X-Gm-Message-State: AOAM530KO33I+MHxEehBkcOP7iuJNQ4blRfo1C/rNFzaqdzlaYaMXvFA
        5iQbXFDIkB/cQMW/NF9eoXQEog==
X-Google-Smtp-Source: ABdhPJwNri2a83qDkFBegeIl3dnDQu4e9pX9nigPbXBNce7tFPVx2kk8O9XSNvj8CSWBeMmogF62FA==
X-Received: by 2002:ac8:5248:: with SMTP id y8mr19581076qtn.346.1623191370663;
        Tue, 08 Jun 2021 15:29:30 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h19sm10450736qtq.5.2021.06.08.15.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:29:30 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/5] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
Date:   Tue,  8 Jun 2021 18:29:24 -0400
Message-Id: <20210608222926.2707768-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608222926.2707768-1-thara.gopinath@linaro.org>
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
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
 drivers/cpufreq/qcom-cpufreq-hw.c | 100 ++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f86859bf76f1..95e17330aa9d 100644
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
@@ -33,7 +37,11 @@ struct qcom_cpufreq_soc_data {
 struct qcom_cpufreq_data {
 	void __iomem *base;
 	struct resource *res;
+	struct delayed_work lmh_dcvs_poll_work;
 	const struct qcom_cpufreq_soc_data *soc_data;
+	cpumask_var_t cpus;
+	unsigned long throttled_freq;
+	int lmh_dcvs_irq;
 };
 
 static unsigned long cpu_hw_rate, xo_rate;
@@ -251,10 +259,79 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 	}
 }
 
+static inline unsigned long qcom_lmh_vote_to_freq(u32 val)
+{
+	return (val & 0x3FF) * 19200;
+}
+
+static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
+{
+	struct cpufreq_policy policy;
+	struct dev_pm_opp *opp;
+	struct device *dev;
+	unsigned long max_capacity, capacity, freq_hz;
+	unsigned int val, freq;
+
+	val = readl_relaxed(data->base + data->soc_data->reg_current_vote);
+	freq = qcom_lmh_vote_to_freq(val);
+	freq_hz = freq * HZ_PER_KHZ;
+
+	/* Do I need to calculate ceil and floor ? */
+	dev = get_cpu_device(cpumask_first(data->cpus));
+	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
+	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
+		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
+
+	data->throttled_freq = freq_hz / HZ_PER_KHZ;
+
+	cpufreq_get_policy(&policy, cpumask_first(data->cpus));
+
+	/* Update thermal pressure */
+	max_capacity = arch_scale_cpu_capacity(cpumask_first(data->cpus));
+	capacity = data->throttled_freq * max_capacity;
+	capacity /= policy.cpuinfo.max_freq;
+	/* Don't pass boost capacity to scheduler */
+	if (capacity > max_capacity)
+		capacity = max_capacity;
+	arch_set_thermal_pressure(data->cpus, max_capacity - capacity);
+}
+
+static void qcom_lmh_dcvs_poll(struct work_struct *work)
+{
+	struct qcom_cpufreq_data *data;
+
+	data = container_of(work, struct qcom_cpufreq_data, lmh_dcvs_poll_work.work);
+
+	qcom_lmh_dcvs_notify(data);
+	/**
+	 * If h/w throttled frequency is higher than what cpufreq has requested for, stop
+	 * polling and switch back to interrupt mechanism
+	 */
+	if (data->throttled_freq >= qcom_cpufreq_hw_get(cpumask_first(data->cpus)))
+		/* Clear the existing interrupts and enable it back */
+		enable_irq(data->lmh_dcvs_irq);
+	else
+		mod_delayed_work(system_highpri_wq, &data->lmh_dcvs_poll_work,
+				 msecs_to_jiffies(10));
+}
+
+static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
+{
+	struct qcom_cpufreq_data *c_data = data;
+
+	/* Disable interrupt and enable polling */
+	disable_irq_nosync(c_data->lmh_dcvs_irq);
+	qcom_lmh_dcvs_notify(c_data);
+	mod_delayed_work(system_highpri_wq, &c_data->lmh_dcvs_poll_work, msecs_to_jiffies(10));
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
@@ -285,6 +362,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	void __iomem *base;
 	struct qcom_cpufreq_data *data;
 	int ret, index;
+	bool lmh_mitigation_enabled = false;
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -305,6 +383,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	index = args.args[0];
 
+	lmh_mitigation_enabled = of_property_read_bool(pdev->dev.of_node, "qcom,support-lmh");
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
 	if (!res) {
 		dev_err(dev, "failed to get mem resource %d\n", index);
@@ -329,6 +409,11 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto unmap_base;
 	}
 
+	if (!alloc_cpumask_var(&data->cpus, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto unmap_base;
+	}
+
 	data->soc_data = of_device_get_match_data(&pdev->dev);
 	data->base = base;
 	data->res = res;
@@ -347,6 +432,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}
 
+	cpumask_copy(data->cpus, policy->cpus);
 	policy->driver_data = data;
 
 	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
@@ -370,6 +456,20 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
 	}
 
+	if (lmh_mitigation_enabled) {
+		data->lmh_dcvs_irq = platform_get_irq(pdev, index);
+		if (data->lmh_dcvs_irq < 0) {
+			ret = data->lmh_dcvs_irq;
+			goto error;
+		}
+		ret = devm_request_irq(dev, data->lmh_dcvs_irq, qcom_lmh_dcvs_handle_irq,
+				       0, "dcvsh-irq", data);
+		if (ret) {
+			dev_err(dev, "Error %d registering irq %x\n", ret, data->lmh_dcvs_irq);
+			goto error;
+		}
+		INIT_DEFERRABLE_WORK(&data->lmh_dcvs_poll_work, qcom_lmh_dcvs_poll);
+	}
 	return 0;
 error:
 	kfree(data);
-- 
2.25.1

