Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43C23D15A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 22:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHET70 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 15:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgHEQmM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 12:42:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF1C034628;
        Wed,  5 Aug 2020 06:12:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g8so5773068wmk.3;
        Wed, 05 Aug 2020 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=srwZS6E/0l7r/CgA4LVzOC1aG7HFShqrxzVtGGn4WfA=;
        b=IhlpHhK2ckI5iP3DR3Jc6ldpkD8CmAjPZTHUAW0bm2yyP0h8jZZL1Cwmm0rebZq5HY
         N84wbmNf9VB+gkr02sY06yDaBylKW5lLewRlFqssJW1IrUTESb+nGM2wxEZzdD2bI7sB
         jZa9Z7ULgpjdOot2LLfvmdA4txiDD6pUbV6+6WT4ODiBf8QxHH+ZLoTya+tOp7GAbiT/
         cPuSvb3bxjixGgGiCsgwtpiYGVLSC+EEsj0V6mu8+D2F4ZJ5ivLO70wsL+2S3DTVXDXC
         cpBkG3eYtaZqE0d/+XQxYuxBtdh5o+iICsy4sv6szYBmj4jC+QGh4KRlg0qkCsXReCJP
         o2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=srwZS6E/0l7r/CgA4LVzOC1aG7HFShqrxzVtGGn4WfA=;
        b=EVpEbHgsZ63cZGAMFsWeVYGLKLNft7Ae0NbtpJWlC7JkseR1eSM74rnx7IeZe45gET
         ht4+2AiSZtEFnBH4eeUll+TGpzUnfxm6uXPHwuJwFdQ7edn692jHzx+CDyXN3zGjE/sn
         Jz3t1Cnxxbb93pUfSUlEJWq+TgWlwepZtyuHlbzPnsTaV/GARx+RLJL6tSkNgu3qtXAX
         39/BvtW6V6r542j7+4QDsrjqvD81MH2HTIwDXBkFwgZKPL/16FzHbGQ6kQLDqzM7j+jx
         9xRwFH3yih7GFAcvDS7WzEz54wpWMD4XAGWHTGHcW8wZkJp+HVheqvg3RXjyv0b2OKxL
         C5zg==
X-Gm-Message-State: AOAM532K4YnYMHfPih9OFYzFC8bf1gxU/rlyJ9DocGr6n9gSwZkLLsx6
        5Sjopei0RP3aNSGZmBuoUG4=
X-Google-Smtp-Source: ABdhPJxm1X+NfSbrsfJom3DeI6LYmR18lUrtAYEvScy+F1e1NLhYLoOcq8zV+jdTkdA51trnYfDmbw==
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr3347935wmj.79.1596633134379;
        Wed, 05 Aug 2020 06:12:14 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-251-1-48.retail.telecomitalia.it. [95.251.1.48])
        by smtp.googlemail.com with ESMTPSA id j11sm2669756wrq.69.2020.08.05.06.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:12:13 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] cpufreq: qcom: Add Krait Cache Scaling support
Date:   Wed,  5 Aug 2020 15:11:58 +0200
Message-Id: <20200805131200.3234-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200805131200.3234-1-ansuelsmth@gmail.com>
References: <20200805131200.3234-1-ansuelsmth@gmail.com>
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
 drivers/cpufreq/krait-cache.c | 218 ++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
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
index 000000000000..77cdd2cb22fc
--- /dev/null
+++ b/drivers/cpufreq/krait-cache.c
@@ -0,0 +1,218 @@
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
+	bool l2_rate_set;
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
+	struct cpufreq_freqs *freqs = (struct cpufreq_freqs *)v;
+	unsigned long l2_freq, target_l2_freq;
+	unsigned long l2_vol, target_l2_volt;
+	struct regulator *l2_regulator;
+	struct krait_data *data;
+	struct clk *l2_clk;
+	int ret = 0;
+
+	data = container_of(nb, struct krait_data, nb);
+
+	if (cmd == CPUFREQ_PRECHANGE) {
+		unsigned int target_freq = freqs->new;
+		int cpu, cur_cpu = freqs->policy->cpu, l2_index, tol = 0;
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
+		l2_freq = data->curr_l2_freq;
+		target_l2_freq = data->l2_rate[l2_index];
+
+		/* scale only if needed */
+		if (l2_freq != target_l2_freq) {
+			/*
+			 * Set to idle bin if switching from normal to high bin
+			 * or vice versa. It has been notice that a bug is triggered
+			 * in cache scaling when more than one bin is scaled, to fix
+			 * this we first need to transition to the base rate and then
+			 * to target rate
+			 */
+			if ((l2_index == 2 && l2_freq == data->l2_rate[1]) ||
+			    (l2_index == 1 && l2_freq == data->l2_rate[2])) {
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
+			l2_regulator = data->l2_regulator;
+			if (l2_regulator) {
+				l2_vol = data->curr_l2_volt;
+				target_l2_volt = data->l2_volt[l2_index];
+
+				if (l2_vol != target_l2_volt) {
+					tol = target_l2_volt *
+					      data->l2_volt_tol / 100;
+					ret = regulator_set_voltage_tol(
+						l2_regulator, target_l2_volt,
+						tol);
+					if (ret)
+						goto exit;
+
+					data->curr_l2_volt = target_l2_volt;
+				}
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
+	struct regulator *l2_regulator;
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
+		goto err;
+	}
+
+	of_property_read_u32(node, "voltage-tolerance", &data->l2_volt_tol);
+
+	of_property_read_u32_array(node, "l2-rates", data->l2_rate, 3);
+	if (data->l2_rate[0] && data->l2_rate[1] && data->l2_rate[2]) {
+		data->l2_rate_set = true;
+		of_property_read_u32_array(node, "l2-cpufreq", data->l2_cpufreq,
+					   3);
+		of_property_read_u32_array(node, "l2-volt", data->l2_volt, 3);
+	} else {
+		dev_warn(dev, "failed to parse L2 rates\n");
+	}
+
+	if (!data->l2_cpufreq[0] && !data->l2_cpufreq[1] &&
+	    !data->l2_cpufreq[2] && data->l2_rate_set) {
+		int i;
+
+		dev_warn(dev,
+			 "failed to parse target cpu freq, using defaults\n");
+		for (i = 0; i < 3; i++)
+			data->l2_cpufreq[i] = data->l2_rate[i];
+	}
+
+	if (data->l2_volt[0] && data->l2_volt[1] && data->l2_volt[2] &&
+	    data->l2_rate_set) {
+		vdd = of_parse_phandle(node, "l2-supply", 0);
+
+		if (vdd) {
+			l2_regulator = devm_regulator_get(dev, vdd->name);
+			if (!IS_ERR(l2_regulator)) {
+				data->l2_regulator = l2_regulator;
+			} else {
+				dev_err(dev,
+					"failed to get l2 supply, error=%pe\n",
+					l2_regulator);
+			}
+
+			of_node_put(vdd);
+		}
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	data->nb.notifier_call = krait_cache_notifier;
+	cpufreq_register_notifier(&data->nb, CPUFREQ_TRANSITION_NOTIFIER);
+
+	return 0;
+
+err:
+	kfree(data);
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

