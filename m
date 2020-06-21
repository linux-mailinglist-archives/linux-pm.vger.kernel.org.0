Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE8D202D07
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jun 2020 23:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgFUVfC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 17:35:02 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13103 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgFUVfB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 17:35:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eefd22b0000>; Sun, 21 Jun 2020 14:33:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 21 Jun 2020 14:35:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 21 Jun 2020 14:35:01 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 21 Jun
 2020 21:34:57 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 21 Jun 2020 21:34:57 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eefd27d0001>; Sun, 21 Jun 2020 14:34:57 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <mperttunen@nvidia.com>
Subject: [TEGRA194_CPUFREQ Patch v3 3/4] cpufreq: Add Tegra194 cpufreq driver
Date:   Mon, 22 Jun 2020 03:04:33 +0530
Message-ID: <1592775274-27513-4-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
References: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592775211; bh=Q7Uo6clnvp5ruLH7v7vHTXazZdukWf7fNyAAx+oiEAg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=KeT0KjOorM8M4pWF5bIHI9cOGt+/trl8DPII5ET3Oi19vPO9yFGgRb0eV/HhJ48bF
         4l8y3Tkr4PZvjvQM+ANOGzKR/jLJfunBoPs7LkkfjmHUfzPipNGTajnIb1VTNvkEVH
         +gVZYV4YDmEs2yYixSAsEsL+iU5D6I9r/BnRJUUz1Kmsz2X8l7D+Lj7Unlii74Nnuw
         QefFliIR/7UsQzX4QPVCpaIA6RNg0iGTRvpr1pN61JRa/+VjvC4KOy6XF9n/Fz48VM
         kPM28JQLEu/eBcBe6NDjbsxSJFH6eKoa9Lg51+srTBx0lhp5ka56gZ1hH7Qi558Zyj
         tJYSbZiDrsFzQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for CPU frequency scaling on Tegra194. The frequency
of each core can be adjusted by writing a clock divisor value to
a MSR on the core. The range of valid divisors is queried from
the BPMP.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/Kconfig.arm        |   6 +
 drivers/cpufreq/Makefile           |   1 +
 drivers/cpufreq/tegra194-cpufreq.c | 403 +++++++++++++++++++++++++++++++++++++
 3 files changed, 410 insertions(+)
 create mode 100644 drivers/cpufreq/tegra194-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 15c1a12..f3d8f09 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -314,6 +314,12 @@ config ARM_TEGRA186_CPUFREQ
 	help
 	  This adds the CPUFreq driver support for Tegra186 SOCs.
 
+config ARM_TEGRA194_CPUFREQ
+	tristate "Tegra194 CPUFreq support"
+	depends on ARCH_TEGRA && TEGRA_BPMP
+	help
+	  This adds CPU frequency driver support for Tegra194 SOCs.
+
 config ARM_TI_CPUFREQ
 	bool "Texas Instruments CPUFreq support"
 	depends on ARCH_OMAP2PLUS
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index f6670c4..66b5563 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_ARM_TANGO_CPUFREQ)		+= tango-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
+obj-$(CONFIG_ARM_TEGRA194_CPUFREQ)	+= tegra194-cpufreq.o
 obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
 
diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
new file mode 100644
index 0000000..8de8000
--- /dev/null
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <asm/smp_plat.h>
+
+#include <soc/tegra/bpmp.h>
+#include <soc/tegra/bpmp-abi.h>
+
+#define KHZ                     1000
+#define REF_CLK_MHZ             408 /* 408 MHz */
+#define US_DELAY                500
+#define US_DELAY_MIN            2
+#define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
+#define MAX_CNT                 ~0U
+
+/* cpufreq transisition latency */
+#define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
+
+#define LOOP_FOR_EACH_CPU_OF_CLUSTER(cl) for (cpu = (cl * 2); \
+					cpu < ((cl + 1) * 2); cpu++)
+
+enum cluster {
+	CLUSTER0,
+	CLUSTER1,
+	CLUSTER2,
+	CLUSTER3,
+	MAX_CLUSTERS,
+};
+
+struct tegra194_cpufreq_data {
+	void __iomem *regs;
+	size_t num_clusters;
+	struct cpufreq_frequency_table **tables;
+};
+
+struct tegra_cpu_ctr {
+	u32 cpu;
+	u32 delay;
+	u32 coreclk_cnt, last_coreclk_cnt;
+	u32 refclk_cnt, last_refclk_cnt;
+};
+
+struct read_counters_work {
+	struct work_struct work;
+	struct tegra_cpu_ctr c;
+};
+
+static struct workqueue_struct *read_counters_wq;
+
+
+static enum cluster get_cpu_cluster(u8 cpu)
+{
+	return MPIDR_AFFINITY_LEVEL(cpu_logical_map(cpu), 1);
+}
+
+/*
+ * Read per-core Read-only system register NVFREQ_FEEDBACK_EL1.
+ * The register provides frequency feedback information to
+ * determine the average actual frequency a core has run at over
+ * a period of time.
+ *	[31:0] PLLP counter: Counts at fixed frequency (408 MHz)
+ *	[63:32] Core clock counter: counts on every core clock cycle
+ *			where the core is architecturally clocking
+ */
+static u64 read_freq_feedback(void)
+{
+	u64 val = 0;
+
+	asm volatile("mrs %0, s3_0_c15_c0_5" : "=r" (val) : );
+
+	return val;
+}
+
+u16 map_freq_to_ndiv(struct mrq_cpu_ndiv_limits_response *nltbl, u32 freq)
+{
+	return DIV_ROUND_UP(freq * nltbl->pdiv * nltbl->mdiv,
+			    nltbl->ref_clk_hz / KHZ);
+}
+
+static inline u32 map_ndiv_to_freq(struct mrq_cpu_ndiv_limits_response
+				   *nltbl, u16 ndiv)
+{
+	return nltbl->ref_clk_hz / KHZ * ndiv / (nltbl->pdiv * nltbl->mdiv);
+}
+
+static void tegra_read_counters(struct work_struct *work)
+{
+	struct read_counters_work *read_counters_work;
+	struct tegra_cpu_ctr *c;
+	u64 val;
+
+	/*
+	 * ref_clk_counter(32 bit counter) runs on constant clk,
+	 * pll_p(408MHz).
+	 * It will take = 2 ^ 32 / 408 MHz to overflow ref clk counter
+	 *              = 10526880 usec = 10.527 sec to overflow
+	 *
+	 * Like wise core_clk_counter(32 bit counter) runs on core clock.
+	 * It's synchronized to crab_clk (cpu_crab_clk) which runs at
+	 * freq of cluster. Assuming max cluster clock ~2000MHz,
+	 * It will take = 2 ^ 32 / 2000 MHz to overflow core clk counter
+	 *              = ~2.147 sec to overflow
+	 */
+	read_counters_work = container_of(work, struct read_counters_work,
+					  work);
+	c = &read_counters_work->c;
+
+	val = read_freq_feedback();
+	c->last_refclk_cnt = lower_32_bits(val);
+	c->last_coreclk_cnt = upper_32_bits(val);
+	udelay(c->delay);
+	val = read_freq_feedback();
+	c->refclk_cnt = lower_32_bits(val);
+	c->coreclk_cnt = upper_32_bits(val);
+}
+
+/*
+ * Return instantaneous cpu speed
+ * Instantaneous freq is calculated as -
+ * -Takes sample on every query of getting the freq.
+ *	- Read core and ref clock counters;
+ *	- Delay for X us
+ *	- Read above cycle counters again
+ *	- Calculates freq by subtracting current and previous counters
+ *	  divided by the delay time or eqv. of ref_clk_counter in delta time
+ *	- Return Kcycles/second, freq in KHz
+ *
+ *	delta time period = x sec
+ *			  = delta ref_clk_counter / (408 * 10^6) sec
+ *	freq in Hz = cycles/sec
+ *		   = (delta cycles / x sec
+ *		   = (delta cycles * 408 * 10^6) / delta ref_clk_counter
+ *	in KHz	   = (delta cycles * 408 * 10^3) / delta ref_clk_counter
+ *
+ * @cpu - logical cpu whose freq to be updated
+ * Returns freq in KHz on success, 0 if cpu is offline
+ */
+static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
+{
+	struct read_counters_work read_counters_work;
+	struct tegra_cpu_ctr c;
+	u32 delta_refcnt;
+	u32 delta_ccnt;
+	u32 rate_mhz;
+
+	/*
+	 * udelay() is required to reconstruct cpu frequency over an
+	 * observation window. Using workqueue to call udelay() with
+	 * interrupts enabled.
+	 */
+	read_counters_work.c.cpu = cpu;
+	read_counters_work.c.delay = delay;
+	INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);
+	queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
+	flush_work(&read_counters_work.work);
+	c = read_counters_work.c;
+
+	if (c.coreclk_cnt < c.last_coreclk_cnt)
+		delta_ccnt = c.coreclk_cnt + (MAX_CNT - c.last_coreclk_cnt);
+	else
+		delta_ccnt = c.coreclk_cnt - c.last_coreclk_cnt;
+	if (!delta_ccnt)
+		return 0;
+
+	/* ref clock is 32 bits */
+	if (c.refclk_cnt < c.last_refclk_cnt)
+		delta_refcnt = c.refclk_cnt + (MAX_CNT - c.last_refclk_cnt);
+	else
+		delta_refcnt = c.refclk_cnt - c.last_refclk_cnt;
+	if (!delta_refcnt) {
+		pr_debug("cpufreq: %d is idle, delta_refcnt: 0\n", cpu);
+		return 0;
+	}
+	rate_mhz = ((unsigned long)(delta_ccnt * REF_CLK_MHZ)) / delta_refcnt;
+
+	return (rate_mhz * KHZ); /* in KHz */
+}
+
+static unsigned int tegra194_get_speed(u32 cpu)
+{
+	return tegra194_get_speed_common(cpu, US_DELAY);
+}
+
+static unsigned int tegra194_fast_get_speed(u32 cpu)
+{
+	return tegra194_get_speed_common(cpu, US_DELAY_MIN);
+}
+
+static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
+{
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	int cl = get_cpu_cluster(policy->cpu);
+	u32 cpu;
+
+	if (cl >= data->num_clusters)
+		return -EINVAL;
+
+	policy->cur = tegra194_fast_get_speed(policy->cpu); /* boot freq */
+
+	/* set same policy for all cpus in a cluster */
+	LOOP_FOR_EACH_CPU_OF_CLUSTER(cl)
+		cpumask_set_cpu(cpu, policy->cpus);
+
+	policy->freq_table = data->tables[cl];
+	policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
+
+	return 0;
+}
+
+static void set_cpu_ndiv(void *data)
+{
+	struct cpufreq_frequency_table *tbl = data;
+	u64 ndiv_val = (u64)tbl->driver_data;
+
+	asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
+}
+
+static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
+				       unsigned int index)
+{
+	struct cpufreq_frequency_table *tbl = policy->freq_table + index;
+
+	on_each_cpu_mask(policy->cpus, set_cpu_ndiv, tbl, true);
+
+	return 0;
+}
+
+static struct cpufreq_driver tegra194_cpufreq_driver = {
+	.name = "tegra194",
+	.flags = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS |
+		CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = tegra194_cpufreq_set_target,
+	.get = tegra194_get_speed,
+	.init = tegra194_cpufreq_init,
+	.attr = cpufreq_generic_attr,
+};
+
+static void tegra194_cpufreq_free_resources(void)
+{
+	flush_workqueue(read_counters_wq);
+	destroy_workqueue(read_counters_wq);
+}
+
+static struct cpufreq_frequency_table *
+init_freq_table(struct platform_device *pdev, struct tegra_bpmp *bpmp,
+		unsigned int cluster_id)
+{
+	struct cpufreq_frequency_table *freq_table;
+	struct mrq_cpu_ndiv_limits_response resp;
+	unsigned int num_freqs, ndiv, delta_ndiv;
+	struct mrq_cpu_ndiv_limits_request req;
+	struct tegra_bpmp_message msg;
+	u16 freq_table_step_size;
+	int err, index;
+
+	memset(&req, 0, sizeof(req));
+	req.cluster_id = cluster_id;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_CPU_NDIV_LIMITS;
+	msg.tx.data = &req;
+	msg.tx.size = sizeof(req);
+	msg.rx.data = &resp;
+	msg.rx.size = sizeof(resp);
+
+	err = tegra_bpmp_transfer(bpmp, &msg);
+	if (err)
+		return ERR_PTR(err);
+
+	/*
+	 * Make sure frequency table step is a multiple of mdiv to match
+	 * vhint table granularity.
+	 */
+	freq_table_step_size = resp.mdiv *
+			DIV_ROUND_UP(CPUFREQ_TBL_STEP_HZ, resp.ref_clk_hz);
+
+	dev_dbg(&pdev->dev, "cluster %d: frequency table step size: %d\n",
+		cluster_id, freq_table_step_size);
+
+	delta_ndiv = resp.ndiv_max - resp.ndiv_min;
+
+	if (unlikely(delta_ndiv == 0))
+		num_freqs = 1;
+	else
+		/* We store both ndiv_min and ndiv_max hence the +1 */
+		num_freqs = delta_ndiv / freq_table_step_size + 1;
+
+	num_freqs += (delta_ndiv % freq_table_step_size) ? 1 : 0;
+
+	freq_table = devm_kcalloc(&pdev->dev, num_freqs + 1,
+				  sizeof(*freq_table), GFP_KERNEL);
+	if (!freq_table)
+		return ERR_PTR(-ENOMEM);
+
+	for (index = 0, ndiv = resp.ndiv_min;
+			ndiv < resp.ndiv_max;
+			index++, ndiv += freq_table_step_size) {
+		freq_table[index].driver_data = ndiv;
+		freq_table[index].frequency = map_ndiv_to_freq(&resp, ndiv);
+	}
+
+	freq_table[index].driver_data = resp.ndiv_max;
+	freq_table[index++].frequency = map_ndiv_to_freq(&resp, resp.ndiv_max);
+	freq_table[index].frequency = CPUFREQ_TABLE_END;
+
+	return freq_table;
+}
+
+static int tegra194_cpufreq_probe(struct platform_device *pdev)
+{
+	struct tegra194_cpufreq_data *data;
+	struct tegra_bpmp *bpmp;
+	int err, i;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->num_clusters = MAX_CLUSTERS;
+	data->tables = devm_kcalloc(&pdev->dev, data->num_clusters,
+				    sizeof(*data->tables), GFP_KERNEL);
+	if (!data->tables)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, data);
+
+	bpmp = tegra_bpmp_get(&pdev->dev);
+	if (IS_ERR(bpmp))
+		return PTR_ERR(bpmp);
+
+	read_counters_wq = alloc_workqueue("read_counters_wq", __WQ_LEGACY, 1);
+	if (!read_counters_wq) {
+		dev_err(&pdev->dev, "fail to create_workqueue\n");
+		err = -EINVAL;
+		goto put_bpmp;
+	}
+
+	for (i = 0; i < data->num_clusters; i++) {
+		data->tables[i] = init_freq_table(pdev, bpmp, i);
+		if (IS_ERR(data->tables[i])) {
+			err = PTR_ERR(data->tables[i]);
+			goto put_bpmp;
+		}
+	}
+
+	tegra_bpmp_put(bpmp);
+
+	tegra194_cpufreq_driver.driver_data = data;
+
+	err = cpufreq_register_driver(&tegra194_cpufreq_driver);
+	if (err)
+		goto err_free_res;
+
+	return err;
+
+put_bpmp:
+	tegra_bpmp_put(bpmp);
+err_free_res:
+	tegra194_cpufreq_free_resources();
+	return err;
+}
+
+static int tegra194_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&tegra194_cpufreq_driver);
+	tegra194_cpufreq_free_resources();
+
+	return 0;
+}
+
+static const struct of_device_id tegra194_cpufreq_of_match[] = {
+	{ .compatible = "nvidia,tegra194-ccplex", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);
+
+static struct platform_driver tegra194_ccplex_driver = {
+	.driver = {
+		.name = "tegra194-cpufreq",
+		.of_match_table = tegra194_cpufreq_of_match,
+	},
+	.probe = tegra194_cpufreq_probe,
+	.remove = tegra194_cpufreq_remove,
+};
+module_platform_driver(tegra194_ccplex_driver);
+
+MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
+MODULE_AUTHOR("Sumit Gupta <sumitg@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra194 cpufreq driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

