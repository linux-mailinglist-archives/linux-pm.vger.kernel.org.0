Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42421BF036
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 08:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgD3G0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 02:26:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726337AbgD3G0N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Apr 2020 02:26:13 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A2551286E1224EC0E009;
        Thu, 30 Apr 2020 14:26:08 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 14:25:59 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH] cpufreq: add support for HiSilicon SoC HIP09
Date:   Thu, 30 Apr 2020 14:19:59 +0800
Message-ID: <1588227599-46438-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HiSilicon SoC has a separate System Control Processor(SCP) dedicated for
clock frequency adjustment and has been using the cpufreq driver
'cppc-cpufreq'. New HiSilicon SoC HIP09 add support for CPU Boost, but
ACPI CPPC doesn't support this. In HiSilicon SoC HIP09, each core has
its own clock domain. It is better for the core itself to adjust its
frequency when we require fast response. In this patch, we add a
separate cpufreq driver for HiSilicon SoC HIP09.

We add a new communication interface based on shared memory between OS
and SCP. OS tell SCP the desired frequency through the shared memory.
SCP loops the shared memory and change the frequency when the value in
the shared memory changed. We use '_DSD' method to get shared memory
address and doorbell register address from UEFI. A example of '_DSD'
method is as below.

Device (C002)
{
    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
    Name (_UID, 0x02)  // _UID: Unique ID
        Name (_DSD, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                        Package () {"cpufreq_method", 2},
                        Package () {"shm_base_addr", 0x0000xxxx},
                        Package () {"shm_size", xx},
                        Package () {"doorbell_addr", 0x0000xxxx},
                        Package () {"doorbell_val", 0xxx},
                        Package () {"transition delay", xxxxxxxx},
                }
        })
}

An alternative method is to resue PCCT table to report the shared memory
address and doorbell register address. But we needs to redefine the
registers layout of the shared memory, different from '_CPC', and I don't
know whether it complies with the spec.

I also figure out another way to add CPU Boost for CPPC. I notice the
difference when we describe 'Highest Performance' and 'Nominal
Performance' in the spec.

Highest Performance: the absolute maximum performance an individual
    processor may reach. This performance level may not be sustainable for
    long durations, and may only be achievable if other platform components
    are in a specific state; for example, it may require other processors be
    in an idle state.
Nominal Performance:  the maximum sustained performance level of the
    processor. This is the performance level the platform is expected to be
    able to maintain continuously. All processors are expected to be able to
    sustain their nominal performance state simultaneously.

The current CPPC code does not support CPU BOOST and use 'Highest
Performance' as the maximum performance the CPU can achieve. I think
maybe we can use 'Highest Performance Register' to record the maximum
performance CPU can achieve in Boost Mode, and 'Nominal Performance
Register' to record the maximum performance in Non-Boost Mode. But this
needs modifying the UEFI, and we need to firgure out a way to modify
CPPC driver without influencing the machines using the old UEFI.

When the number of clock domain become enormous, such as hundreds of
cores each has its own clock domain, it will take almost one millisecond
for the SCP to finish frequency adjustment for all the cores. Especially
when turbo calculation is involved, the time will be longer. SCP needs
to calculate how much the clock frequency can boost for each core. So it
is better for each core to adjust its own frequency. But it is not safe
for OS to write frequency adjustment registers directly when CPU Boost is
supported. So we add a new SoC implementation-specific(SiP) Service Call
for this situation.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/cpufreq/Kconfig.arm    |   7 +
 drivers/cpufreq/Makefile       |   1 +
 drivers/cpufreq/hisi-cpufreq.c | 334 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 342 insertions(+)
 create mode 100644 drivers/cpufreq/hisi-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 15c1a12..119310e 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -89,6 +89,13 @@ config ARM_HIGHBANK_CPUFREQ
 
 	  If in doubt, say N.
 
+config ARM_HISILICON_CPUFREQ
+	tristate "HiSilicon SoC CPUFreq driver"
+	depends on ACPI_PROCESSOR
+	default m
+	help
+	  This adds the CPUFreq driver for HiSilicon SoC.
+
 config ARM_IMX6Q_CPUFREQ
 	tristate "Freescale i.MX6 cpufreq support"
 	depends on ARCH_MXC
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index f6670c4..0fa8668 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
 obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
+obj-$(CONFIG_ARM_HISILICON_CPUFREQ) 	+= hisi-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
 obj-$(CONFIG_ARM_IMX_CPUFREQ_DT)	+= imx-cpufreq-dt.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
diff --git a/drivers/cpufreq/hisi-cpufreq.c b/drivers/cpufreq/hisi-cpufreq.c
new file mode 100644
index 0000000..3fda10f
--- /dev/null
+++ b/drivers/cpufreq/hisi-cpufreq.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Hisilicon Limited. */
+
+#include <asm/arch_timer.h>
+#include <linux/acpi.h>
+#include <linux/arm-smccc.h>
+#include <linux/cpu.h>
+#include <linux/cpufeature.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+
+#define HISILICON_SIP_SMC_FAST_CALL_VAL(func_num) \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
+	ARM_SMCCC_OWNER_SIP, (func_num))
+
+#define HISILICON_SIP_SMC_FUNCID_SET_CPUFREQ 1
+#define HISILICON_SIP_SMC_SET_CPUFREQ \
+	HISILICON_SIP_SMC_FAST_CALL_VAL(HISILICON_SIP_SMC_FUNCID_SET_CPUFREQ)
+
+#define HISI_CPUFREQ_METHOD_SMC 1
+/*
+ * OS stores the desired frequency in shared memory. Platform loops the
+ * shared memory.
+ */
+#define HISI_CPUFREQ_METHOD_SHM 2
+/*
+ * OS stores the desired frequency in shared memory and use a doorbell
+ * interrupt to notify the platform.
+ */
+#define HISI_CPUFREQ_METHOD_NOTIFY 3
+
+struct hisi_cpufreq_shm {
+	u64 max_freq;
+	u64 min_freq;
+	u64 turbo_freq;
+	u64 target_freq;
+	u32 clock_domain;
+};
+
+struct hisi_cpufreq_cpudata {
+	u64 max_freq;
+	u64 min_freq;
+	u64 turbo_freq;
+	cpumask_t shared_cpus;
+	void __iomem *doorbell_addr;
+	u32 doorbell_val;
+	u32 transition_delay;
+};
+
+unsigned int hisi_cpufreq_method;
+static DEFINE_PER_CPU(struct hisi_cpufreq_shm *, cpufreq_shm_data);
+static struct hisi_cpufreq_cpudata *cpufreq_cpudata;
+
+static unsigned long hisi_smc_set_freq(unsigned long target_freq)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(HISILICON_SIP_SMC_SET_CPUFREQ, target_freq,
+		      0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static unsigned int hisi_shm_set_freq(unsigned int cpu,
+				       unsigned long target_freq,
+				       bool knock_doorbell)
+{
+	struct hisi_cpufreq_cpudata *cpudata = &cpufreq_cpudata[cpu];
+
+	per_cpu(cpufreq_shm_data, cpu)->target_freq = target_freq;
+
+	if (knock_doorbell)
+		writel(cpudata->doorbell_val, cpudata->doorbell_addr);
+
+	return 0;
+}
+
+static unsigned int hisi_cpufreq_set_freq(unsigned int cpu,
+					  unsigned int target_freq)
+{
+	if (hisi_cpufreq_method == HISI_CPUFREQ_METHOD_SMC)
+		/*
+		 * The caller CPU is also the CPU which needs frequency
+		 * adjustment.
+		 */
+		return hisi_smc_set_freq(target_freq);
+	else
+		return hisi_shm_set_freq(cpu, target_freq,
+					 hisi_cpufreq_method ==
+					 HISI_CPUFREQ_METHOD_NOTIFY);
+}
+
+static unsigned int hisi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	unsigned int cpu = policy->cpu;
+
+	return hisi_cpufreq_set_freq(cpu, target_freq);
+}
+
+static int hisi_cpufreq_set_target(struct cpufreq_policy *policy,
+				   unsigned int target_freq,
+				   unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	freqs.old = policy->cur;
+	freqs.new = target_freq;
+
+	cpufreq_freq_transition_begin(policy, &freqs);
+	ret = hisi_cpufreq_set_freq(cpu, target_freq);
+	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
+
+	return ret;
+}
+
+static void __amu_get_cpufreq(void *arg)
+{
+	u64 core_cnt1, const_cnt1;
+	u64 core_cnt2, const_cnt2;
+	u64 core_delta, const_delta;
+	unsigned int const_freq;
+	unsigned int *cur_freq = arg;
+
+	const_cnt1 = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
+	core_cnt1 = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
+	udelay(2);
+	const_cnt2 = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
+	core_cnt2 = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
+
+	const_delta = const_cnt2 = const_cnt1;
+	core_delta = core_cnt2 - core_cnt1;
+	if (!const_delta || !core_delta) {
+		*cur_freq = 0;
+		return;
+	}
+
+	const_freq = arch_timer_get_cntfrq();
+	*cur_freq = core_delta * const_freq / const_delta;
+}
+
+static unsigned int amu_get_cpufreq(unsigned int cpunum)
+{
+	int cur_freq;
+
+	smp_call_function_single(cpunum, __amu_get_cpufreq, &cur_freq, true);
+
+	return cur_freq;
+}
+
+static unsigned int hisi_cpufreq_get_rate(unsigned int cpunum)
+{
+	unsigned int cur_freq;
+
+	if (cpus_have_cap(ARM64_HAS_AMU_EXTN)) {
+		cur_freq = amu_get_cpufreq(cpunum);
+		if (cur_freq)
+			return cur_freq/1000;
+	}
+
+	return per_cpu(cpufreq_shm_data, cpunum)->target_freq;
+}
+
+static int hisi_cpufreq_verify_policy(struct cpufreq_policy_data *policy)
+{
+	cpufreq_verify_within_cpu_limits(policy);
+	return 0;
+}
+
+static int hisi_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	unsigned int cpu = policy->cpu;
+	struct hisi_cpufreq_cpudata *cpudata = &cpufreq_cpudata[cpu];
+
+	policy->min = cpudata->min_freq;
+	policy->max = cpudata->max_freq;
+	policy->cpuinfo.min_freq = cpudata->min_freq;
+	policy->cpuinfo.max_freq = cpudata->max_freq;
+	policy->transition_delay_us = cpudata->transition_delay;
+	policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
+	policy->fast_switch_possible = true;
+
+	cpumask_copy(policy->cpus, &cpudata->shared_cpus);
+
+	return 0;
+}
+
+static int hisi_cpufreq_set_boost(int state)
+{
+	struct cpufreq_policy *policy;
+	u64 max_freq;
+	unsigned int cpu;
+	int ret;
+
+	for_each_online_cpu(cpu) {
+		if (state)
+			max_freq = cpufreq_cpudata[cpu].turbo_freq;
+		else
+			max_freq = cpufreq_cpudata[cpu].max_freq;
+
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy)
+			continue;
+
+		if (policy->max == max_freq) {
+			cpufreq_cpu_put(policy);
+			continue;
+		}
+
+		policy->max = policy->cpuinfo.max_freq = max_freq;
+		ret = freq_qos_update_request(policy->max_freq_req, max_freq);
+		if (ret < 0) {
+			cpufreq_cpu_put(policy);
+			return ret;
+		}
+
+		cpufreq_cpu_put(policy);
+	}
+
+	return 0;
+}
+
+static struct cpufreq_driver hisi_cpufreq_driver = {
+	.flags = CPUFREQ_CONST_LOOPS,
+	.init = hisi_cpufreq_cpu_init,
+	.verify = hisi_cpufreq_verify_policy,
+	.target = hisi_cpufreq_set_target,
+	.fast_switch = hisi_cpufreq_fast_switch,
+	.get = hisi_cpufreq_get_rate,
+	.set_boost = hisi_cpufreq_set_boost,
+	.name = "hisi_cpufreq",
+};
+
+static int __init hisi_cpufreq_parse_device_property(struct device *dev,
+						     unsigned int cpu)
+{
+	u64 addr;
+	u32 size, val;
+	struct hisi_cpufreq_shm *shm_data;
+
+	if (!hisi_cpufreq_method && device_property_read_u32(dev,
+					"cpufreq_method", &hisi_cpufreq_method))
+		return -ENODEV;
+
+	if (!device_property_read_u64(dev, "shm_base_addr", &addr) &&
+	    !device_property_read_u32(dev, "shm_size", &size))
+		per_cpu(cpufreq_shm_data, cpu) = ioremap(addr, size);
+	else if (hisi_cpufreq_method != HISI_CPUFREQ_METHOD_SMC)
+		return -EINVAL;
+
+	if (!device_property_read_u64(dev, "doorbell_addr", &addr))
+		cpufreq_cpudata[cpu].doorbell_addr = ioremap(addr, 4);
+	else if (hisi_cpufreq_method == HISI_CPUFREQ_METHOD_NOTIFY)
+		return -EINVAL;
+	if (!device_property_read_u32(dev, "doorbell_val", &val))
+		cpufreq_cpudata[cpu].doorbell_val = val;
+
+	if (!device_property_read_u32(dev, "transition_delay", &val))
+		cpufreq_cpudata[cpu].transition_delay = val;
+
+	shm_data = per_cpu(cpufreq_shm_data, cpu);
+	cpufreq_cpudata[cpu].max_freq = shm_data->max_freq;
+	cpufreq_cpudata[cpu].min_freq = shm_data->min_freq;
+	cpufreq_cpudata[cpu].turbo_freq = shm_data->turbo_freq;
+
+	return 0;
+}
+
+static int __init hisi_cpufreq_init(void)
+{
+	struct hisi_cpufreq_cpudata *cpudata;
+	struct device *dev;
+	unsigned int i, j;
+	int ret;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	cpufreq_cpudata = kcalloc(num_possible_cpus(),
+				  sizeof(struct hisi_cpufreq_cpudata),
+				  GFP_KERNEL);
+	if (!cpufreq_cpudata)
+		return -ENOMEM;
+
+	for_each_possible_cpu(i) {
+		dev = get_cpu_device(i);
+		if (!dev)
+			goto failed;
+
+		ret = hisi_cpufreq_parse_device_property(dev, i);
+		if (ret)
+			goto failed;
+	}
+
+	/* parse clock domain info */
+	for_each_possible_cpu(i) {
+		cpudata = &cpufreq_cpudata[i];
+		cpumask_set_cpu(i, &cpudata->shared_cpus);
+
+		for_each_possible_cpu(j) {
+			if (i == j)
+				continue;
+			if (per_cpu(cpufreq_shm_data, i)->clock_domain ==
+			    per_cpu(cpufreq_shm_data, j)->clock_domain)
+				cpumask_set_cpu(j, &cpudata->shared_cpus);
+		}
+	}
+
+	if (cpufreq_register_driver(&hisi_cpufreq_driver))
+		goto failed;
+
+	return 0;
+
+failed:
+	kfree(cpufreq_cpudata);
+	return -ENODEV;
+}
+
+static void __exit hisi_cpufreq_exit(void)
+{
+	cpufreq_unregister_driver(&hisi_cpufreq_driver);
+	kfree(cpufreq_cpudata);
+}
+
+late_initcall(hisi_cpufreq_init);
+module_exit(hisi_cpufreq_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Xiongfeng Wang <wangxiongfeng2@huawei.com>");
+MODULE_DESCRIPTION("HiSilicon CPUFreq driver");
-- 
1.7.12.4

