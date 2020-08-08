Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF2923F553
	for <lists+linux-pm@lfdr.de>; Sat,  8 Aug 2020 01:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHGXtc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Aug 2020 19:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHGXtb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2020 19:49:31 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8727C061756;
        Fri,  7 Aug 2020 16:49:30 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ba10so2408376edb.3;
        Fri, 07 Aug 2020 16:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKEyCj7pFFpDDbRfh/35G3tZRo1tSnQfGYJQmuvMgd8=;
        b=N/adcH8rUHgex1wi/fQB3B2WyGdEuWWxrwT1q3mFE3+wxBBxCgAegFp/XXxQrotqEA
         cD8zWCynjdH8PSm9bpklXjnuW8BgiSdtrnXgXM/57m+5z88VyJQSI6yRgDyT4eJ/jZzD
         BofoG24hggDcAKsf5v9tfLp4R8a8LDAhrrDzy49evHLKMtrZocSh0YG1ZYJHe5h5VOPb
         kuz2U6cMSmX5YZq7R+CFQhc6Le9DlOFq7GxaHTp/uPPkex+pMc9rJfsjtbHnhGbFHQRD
         oK11tL4ktodhspSOoDoEREGb+VfaI9YrMaKu4H/nPly9K1a+Ma/Je3Jp+OTZwBM/hR/+
         YaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fKEyCj7pFFpDDbRfh/35G3tZRo1tSnQfGYJQmuvMgd8=;
        b=Of6DzsDQjePgmUd3urMUuRnJ2VpQFG5x8Enzh5m8UZdc9mHId5Yre/vKr4AMDdUZo4
         1R05Ij3RLZm4teYARGoOymVFsO6HboAUhxVlAaS2U/AbXLg5doInPeCr8wD3PKcqDAjg
         HbB68jqdaI1UTJHKpXLIJwtN1Atxi5MFNYU5322ZJBlUxfNjLQRmu/MAw7+lFdYvDJi5
         8550fuvbPQ3u5rPTsr8zBc//fUUgpNXgApJ/RqUVc/8LpuOzRSPDpmroduOMx/DQTa3Y
         NUUtTrxpVTsOZlw/9oXzw/XytEdqodJLB6ZxlA8asnPWACdINiRilAOPAU2afsliMJGw
         /elQ==
X-Gm-Message-State: AOAM532s28dDbzoL68dHKk0JJmH23emJWqO5d0QvwiM0tgMxtear1I97
        9CsNBPkm/dmFEikWM/cjtqI=
X-Google-Smtp-Source: ABdhPJwxc4h9MhNCuig8ssiOQlHTAeHTXqOb0pvujnZZXH1ki+ctjdYjgIyEO68qZiJm7iW3MvkIyg==
X-Received: by 2002:aa7:cc85:: with SMTP id p5mr11274182edt.369.1596844169541;
        Fri, 07 Aug 2020 16:49:29 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([87.13.195.83])
        by smtp.googlemail.com with ESMTPSA id k17sm6977826eji.28.2020.08.07.16.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 16:49:29 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/2] cpufreq: qcom: Add Krait Cache Scaling support
Date:   Sat,  8 Aug 2020 01:49:11 +0200
Message-Id: <20200807234914.7341-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200807234914.7341-1-ansuelsmth@gmail.com>
References: <20200807234914.7341-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Qcom Krait CPUs use the generic cpufreq-dt driver and doesn't actually
scale the Cache frequency when the CPU frequency is changed. This
companion driver register with the cpu notifier and scale the Cache
based on the max Freq across all core as the CPU cache is shared across
all of them. If provided this also scale the voltage of the regulator
attached to the CPU cache. The scaling logic is based on the CPU freq
and the 3 scaling interval are set by the device dts.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/cpufreq/Kconfig.arm   |   9 ++
 drivers/cpufreq/Makefile      |   1 +
 drivers/cpufreq/krait-cache.c | 213 ++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)
 create mode 100644 drivers/cpufreq/krait-cache.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index c6cbfc8baf72..4ed5e73051df 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -126,6 +126,15 @@ config ARM_OMAP2PLUS_CPUFREQ
 	depends on ARCH_OMAP2PLUS
 	default ARCH_OMAP2PLUS
 
+config ARM_QCOM_KRAIT_CACHE_SCALE
+	tristate "Scaling support for Krait CPU Cache"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  This adds the Scaling support for the Krait CPU Cache shared by
+	  all cores.
+
+	  If in doubt, say N.
+
 config ARM_QCOM_CPUFREQ_NVMEM
 	tristate "Qualcomm nvmem based CPUFreq"
 	depends on ARCH_QCOM
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index f6670c4abbb0..eee53d7e8b09 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
+obj-$(CONFIG_ARM_QCOM_KRAIT_CACHE_SCALE) += krait-cache.o
 obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
 obj-$(CONFIG_ARM_QCOM_CPUFREQ_NVMEM)	+= qcom-cpufreq-nvmem.o
 obj-$(CONFIG_ARM_RASPBERRYPI_CPUFREQ) 	+= raspberrypi-cpufreq.o
diff --git a/drivers/cpufreq/krait-cache.c b/drivers/cpufreq/krait-cache.c
new file mode 100644
index 000000000000..a2a14eb38dc0
--- /dev/null
+++ b/drivers/cpufreq/krait-cache.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/cpufreq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/regulator/consumer.h>
+
+struct krait_data {
+	struct clk *l2_clk; /* L2 clock */
+	unsigned int l2_volt_tol; /* L2 voltage tolerance */
+
+	struct regulator *l2_regulator; /* L2 supply */
+	unsigned int l2_rate[3]; /* L2 bus clock rate */
+
+	unsigned int l2_cpufreq[3]; /* L2 target CPU frequency */
+	unsigned int l2_volt[3]; /* L2 voltage array */
+
+	unsigned long curr_l2_freq;
+	unsigned long curr_l2_volt;
+
+	struct notifier_block nb;
+};
+
+static int krait_cache_notifier(struct notifier_block *nb, unsigned long cmd,
+				void *v)
+{
+	unsigned int target_freq, cpu, cur_cpu, l2_index, tol;
+	unsigned long curr_l2_freq, target_l2_freq;
+	unsigned long curr_l2_vol, target_l2_volt;
+	struct cpufreq_freqs *freqs;
+	struct krait_data *data;
+	struct clk *l2_clk;
+	int ret = 0;
+
+	if (cmd == CPUFREQ_PRECHANGE) {
+		freqs = (struct cpufreq_freqs *)v;
+		target_freq = freqs->new;
+		cur_cpu = freqs->policy->cpu;
+
+		data = container_of(nb, struct krait_data, nb);
+
+		l2_clk = data->l2_clk;
+
+		/* find the max freq across all core */
+		for_each_present_cpu(cpu)
+			if (cpu != cur_cpu)
+				target_freq = max(target_freq,
+						  cpufreq_quick_get(cpu));
+
+		/* find l2_freq and l2_volt  */
+		for (l2_index = 0;
+		     l2_index < 2 && target_freq <= data->l2_cpufreq[l2_index];
+		     l2_index++)
+			break;
+
+		curr_l2_freq = data->curr_l2_freq;
+		target_l2_freq = data->l2_rate[l2_index];
+
+		/* scale only if needed */
+		if (curr_l2_freq != target_l2_freq) {
+			/*
+			 * Set to idle bin if switching from normal to high bin
+			 * or vice versa. It has been notice that a bug is triggered
+			 * in cache scaling when more than one bin is scaled, to fix
+			 * this we first need to transition to the base rate and then
+			 * to target rate
+			 */
+			if (likely(l2_index > 0 &&
+				   curr_l2_freq != data->l2_rate[0])) {
+				ret = clk_set_rate(l2_clk, data->l2_rate[0]);
+				if (ret)
+					goto exit;
+			}
+
+			ret = clk_set_rate(l2_clk, target_l2_freq);
+			if (ret)
+				goto exit;
+
+			data->curr_l2_freq = target_l2_freq;
+
+			curr_l2_vol = data->curr_l2_volt;
+			target_l2_volt = data->l2_volt[l2_index];
+
+			if (curr_l2_vol != target_l2_volt) {
+				tol = target_l2_volt * data->l2_volt_tol / 100;
+				ret = regulator_set_voltage_tol(
+					data->l2_regulator, target_l2_volt,
+					tol);
+				if (ret)
+					goto exit;
+
+				data->curr_l2_volt = target_l2_volt;
+			}
+		}
+	}
+
+exit:
+	return notifier_from_errno(ret);
+}
+
+static int krait_cache_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct clk *l2_clk;
+	struct device_node *vdd;
+	struct krait_data *data;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->l2_clk = clk_get(dev, "l2");
+	if (IS_ERR(l2_clk)) {
+		ret = PTR_ERR(l2_clk);
+		goto exit;
+	}
+
+	ret = of_property_read_u32(node, "voltage-tolerance",
+				   &data->l2_volt_tol);
+	if (ret) {
+		dev_err(dev, "missing voltage tolerance\n");
+		goto exit;
+	}
+
+	ret = of_property_read_u32_array(node, "l2-rates", data->l2_rate, 3);
+	if (ret) {
+		dev_err(dev, "failed to parse L2 rates\n");
+		goto exit;
+	}
+
+	ret = of_property_read_u32_array(node, "l2-cpufreq", data->l2_cpufreq,
+					 3);
+	if (ret) {
+		dev_err(dev, "failed to parse L2 cpufreq range\n");
+		goto exit;
+	}
+
+	ret = of_property_read_u32_array(node, "l2-volt", data->l2_volt, 3);
+	if (ret) {
+		dev_err(dev, "failed to parse L2 volt range\n");
+		goto exit;
+	}
+
+	vdd = of_parse_phandle(node, "l2-supply", 0);
+	if (!vdd) {
+		dev_err(dev, "missing L2 supply\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	data->l2_regulator = devm_regulator_get(dev, vdd->name);
+	if (IS_ERR(data->l2_regulator)) {
+		dev_err(dev, "failed to get l2 supply, error=%pe\n",
+			data->l2_regulator);
+		ret = PTR_ERR(data->l2_regulator);
+		goto exit_vdd;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	data->nb.notifier_call = krait_cache_notifier;
+	cpufreq_register_notifier(&data->nb, CPUFREQ_TRANSITION_NOTIFIER);
+
+exit_vdd:
+	of_node_put(vdd);
+exit:
+	return ret;
+}
+
+static int krait_cache_remove(struct platform_device *pdev)
+{
+	struct krait_data *data = platform_get_drvdata(pdev);
+
+	cpufreq_unregister_notifier(&data->nb, CPUFREQ_TRANSITION_NOTIFIER);
+
+	return 0;
+}
+
+static const struct of_device_id krait_cache_match_table[] = {
+	{ .compatible = "qcom,krait-cache" },
+	{}
+};
+
+static struct platform_driver krait_cache_driver = {
+	.probe		= krait_cache_probe,
+	.remove		= krait_cache_remove,
+	.driver		= {
+		.name   = "krait-cache-scaling",
+		.of_match_table = krait_cache_match_table,
+	},
+};
+
+static int __init krait_cache_init(void)
+{
+	return platform_driver_register(&krait_cache_driver);
+}
+late_initcall(krait_cache_init);
+
+static void __exit krait_cache_exit(void)
+{
+	platform_driver_unregister(&krait_cache_driver);
+}
+module_exit(krait_cache_exit);
+
+MODULE_DESCRIPTION("Krait CPU Cache Scaling driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

