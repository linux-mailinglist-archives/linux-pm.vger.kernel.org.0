Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED6F2AB130
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 07:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgKIGU7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 01:20:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65532 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728904AbgKIGU6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 01:20:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A961IRp063334;
        Mon, 9 Nov 2020 01:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=bf5GaV+SF2oWHYvy20N152fznf2lKcXSZpy5TiJBLTY=;
 b=D2dRMjcAHwSAn+joWPwUv+RSmgHs1EZ3ud+pnFQmgSB+2bVlyen40jQG5h55Cm87OVF0
 A+MAzRl6bXs7dnX9wN9LIWqtzo/iun0gVF8DBfSFZzwaty12buIZl5UEDVAj0ahfMRhr
 9wtxjW9t9YH0dQeVuVSoEsR4J8SehawFhnwfxUAk8paHRP6LPWSMJBE9kIk2wYmgHwZ9
 rnTfC7NO5+LC+KcKPu5gqOq+Lfb/SI5PgZEbKyTqN+/NV54X+Feofh+hvMCI827HuIO9
 uxT2viTMd5ZmkaR1HnUVN9tyBBdyyjw41IAuo3CBbbcMOT8bNTz78dAF960m2LKvSNHW kA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34nrevtn7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 01:20:46 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A968WxL001888;
        Mon, 9 Nov 2020 06:20:45 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 34nk77rv7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 06:20:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A96Kg9822741492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Nov 2020 06:20:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B0B9A4060;
        Mon,  9 Nov 2020 06:20:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48115A4062;
        Mon,  9 Nov 2020 06:20:41 +0000 (GMT)
Received: from bostonp9.aus.stglabs.ibm.com (unknown [9.3.23.179])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Nov 2020 06:20:41 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        ego@linux.vnet.ibm.com, Nathan.Fontenot@amd.com,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [RFC v3] cpuidle : Add support for pseudo-cpuidle driver
Date:   Mon,  9 Nov 2020 00:16:12 -0600
Message-Id: <20201109061612.150441-1-huntbag@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_01:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090034
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This option adds support for a testing cpuidle driver, which allows
user to define custom idle states with their respective latencies and
residencies. This is useful for testing the behaviour of governors on
customized set of idle states.

This can be used as of now by specifying a customized set of cpuidle
states in the driver by the user. Will add the capability of this
driver to be used as a module in subsequent patches.

Original idea and discussion for this patch can be found at:
https://lkml.org/lkml/2019/12/17/655

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---

 v1->v2 : Changes adapted from reviews of Randy, Dan and Nathan.
	  There was a divergence from expected behaviour of idle loop
	  in v1. That has been fixed.
 v2->v3 : Added simulated latency while entering into idle states.

 drivers/cpuidle/Kconfig        |   9 +
 drivers/cpuidle/Makefile       |   1 +
 drivers/cpuidle/cpuidle-test.c | 289 +++++++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-test.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c0aeedd66f02..1a0f227d61d6 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -71,6 +71,15 @@ config HALTPOLL_CPUIDLE
 	 before halting in the guest (more efficient than polling in the
 	 host via halt_poll_ns for some scenarios).
 
+config TEST_CPUIDLE
+	tristate "cpuidle test driver"
+	default n
+	help
+	  This option enables a testing cpuidle driver, which allows the user
+	  to define custom idle states with their respective latencies & residencies.
+	  This is useful for testing the behaviour of governors on different
+	  sets of idle states.
+
 endif
 
 config ARCH_NEEDS_CPU_IDLE_COUPLED
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index f07800cbb43f..68ea7dc257b5 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
 obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o
 obj-$(CONFIG_HALTPOLL_CPUIDLE)		  += cpuidle-haltpoll.o
+obj-$(CONFIG_TEST_CPUIDLE)		  += cpuidle-test.o
 
 ##################################################################################
 # ARM SoC drivers
diff --git a/drivers/cpuidle/cpuidle-test.c b/drivers/cpuidle/cpuidle-test.c
new file mode 100644
index 000000000000..17ffce11cafc
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-test.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  cpuidle-test - Test driver for cpuidle.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu.h>
+#include <linux/module.h>
+#include <linux/sched/idle.h>
+#include <linux/sched/clock.h>
+#include <linux/sched/idle.h>
+
+#define CPUIDLE_STATE_MAX	10
+#define MAX_PARAM_LENGTH	100
+
+static unsigned int nr_states = 4;
+static unsigned int sim_type = 1;
+static char name[MAX_PARAM_LENGTH];
+static char latency_us[MAX_PARAM_LENGTH];
+static char residency_us[MAX_PARAM_LENGTH];
+
+
+module_param(nr_states, uint, 0644);
+module_param(sim_type, uint, 0644);
+module_param_string(name, name, MAX_PARAM_LENGTH, 0644);
+module_param_string(latency_us, latency_us, MAX_PARAM_LENGTH, 0644);
+module_param_string(residency_us, residency_us, MAX_PARAM_LENGTH, 0644);
+
+static struct cpuidle_driver test_cpuidle_driver = {
+	.name		= "test_cpuidle",
+	.owner		= THIS_MODULE,
+};
+
+static struct cpuidle_state *cpuidle_state_table __read_mostly;
+
+static struct cpuidle_device __percpu *test_cpuidle_devices;
+static enum cpuhp_state test_hp_idlestate;
+
+
+static int __cpuidle idle_loop(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	u64 time_start;
+
+	local_irq_enable();
+
+	time_start = local_clock();
+	/*
+	 * Simulating entry latency into idle state.
+	 */
+	while (local_clock() - time_start < drv->states[index].exit_latency) {
+	}
+
+	if (!current_set_polling_and_test()) {
+		while (!need_resched())
+			cpu_relax();
+	}
+
+	time_start = local_clock();
+	/*
+	 * Simulating exit latency from idle state.
+	 */
+	while (local_clock() - time_start < drv->states[index].exit_latency) {
+	}
+
+	current_clr_polling();
+
+	return index;
+}
+
+	/*
+	 * Defining user specified custome set of idle states.
+	 */
+static struct cpuidle_state cpuidle_states[CPUIDLE_STATE_MAX] = {
+	{	.name = "snooze",
+		.exit_latency = 0,
+		.target_residency = 0,
+		.enter = idle_loop },
+};
+
+static struct cpuidle_state cpuidle_states_ppc[] = {
+	{	.name = "snooze",
+		.exit_latency = 0,
+		.target_residency = 0,
+		.enter = idle_loop },
+	{
+		.name = "stop0",
+		.exit_latency = 2,
+		.target_residency = 20,
+		.enter = idle_loop },
+	{
+		.name = "stop1",
+		.exit_latency = 5,
+		.target_residency = 50,
+		.enter = idle_loop },
+	{
+		.name = "stop2",
+		.exit_latency = 10,
+		.target_residency = 100,
+		.enter = idle_loop },
+};
+
+static struct cpuidle_state cpuidle_states_intel[] = {
+	{	.name = "poll",
+		.exit_latency = 0,
+		.target_residency = 0,
+		.enter = idle_loop },
+	{
+		.name = "c1",
+		.exit_latency = 2,
+		.target_residency = 2,
+		.enter = idle_loop },
+	{
+		.name = "c1e",
+		.exit_latency = 10,
+		.target_residency = 20,
+		.enter = idle_loop },
+	{
+		.name = "c3",
+		.exit_latency = 80,
+		.target_residency = 211,
+		.enter = idle_loop },
+};
+
+static int cpuidle_cpu_online(unsigned int cpu)
+{
+	struct cpuidle_device *dev;
+
+	dev = per_cpu_ptr(test_cpuidle_devices, cpu);
+	if (!dev->registered) {
+		dev->cpu = cpu;
+		if (cpuidle_register_device(dev)) {
+			pr_notice("cpuidle_register_device %d failed!\n", cpu);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int cpuidle_cpu_dead(unsigned int cpu)
+{
+	struct cpuidle_device *dev;
+
+	dev = per_cpu_ptr(test_cpuidle_devices, cpu);
+	if (dev->registered)
+		cpuidle_unregister_device(dev);
+
+	return 0;
+}
+
+static int cpuidle_driver_init(void)
+{
+	int idle_state;
+	struct cpuidle_driver *drv = &test_cpuidle_driver;
+
+	drv->state_count = 0;
+
+	for (idle_state = 0; idle_state < nr_states; ++idle_state) {
+		/* Is the state not enabled? */
+		if (cpuidle_state_table[idle_state].enter == NULL)
+			continue;
+
+		drv->states[drv->state_count] =	/* structure copy */
+			cpuidle_state_table[idle_state];
+
+		drv->state_count += 1;
+	}
+
+	return 0;
+}
+
+static int add_cpuidle_states(void)
+{
+	/* Parse the module param and initialize the idle states here
+	 * in cpuidle_state_table.
+	 */
+	char *this_param;
+	char *input_name = name;
+	char *input_res = residency_us;
+	char *input_lat = latency_us;
+	int index = 1;
+	long temp;
+	int rc;
+
+	switch (sim_type) {
+	case 1:
+		cpuidle_state_table = cpuidle_states_ppc;
+		return 0;
+	case 2:
+		cpuidle_state_table = cpuidle_states_intel;
+		return 0;
+	case 3:
+		break;
+	default:
+		pr_warn("Sim value out of bound\n");
+		break;
+	}
+
+	if (strnlen(input_name, MAX_PARAM_LENGTH)) {
+		while ((this_param = strsep(&input_name, ",")) && index <= nr_states) {
+			strcpy(cpuidle_states[index].name, this_param);
+			cpuidle_states[index].enter = idle_loop;
+			index++;
+		}
+	}
+
+	if (strnlen(input_res, MAX_PARAM_LENGTH)) {
+		index = 1;
+		while ((this_param = strsep(&input_res, ",")) && index <= nr_states) {
+			rc = kstrtol(this_param, 10, &temp);
+			cpuidle_states[index].target_residency = temp;
+			index++;
+		}
+	}
+
+	if (strnlen(input_lat, MAX_PARAM_LENGTH)) {
+		index = 1;
+		while ((this_param = strsep(&input_lat, ",")) && index <= nr_states) {
+			rc = kstrtol(this_param, 10, &temp);
+			cpuidle_states[index].exit_latency = temp;
+			index++;
+		}
+	}
+
+	cpuidle_state_table = cpuidle_states;
+	return nr_states;
+}
+
+static void test_cpuidle_uninit(void)
+{
+	if (test_hp_idlestate)
+		cpuhp_remove_state(test_hp_idlestate);
+	cpuidle_unregister_driver(&test_cpuidle_driver);
+
+	free_percpu(test_cpuidle_devices);
+	test_cpuidle_devices = NULL;
+}
+
+static int __init test_cpuidle_init(void)
+{
+	int retval;
+
+	add_cpuidle_states();
+	cpuidle_driver_init();
+	retval = cpuidle_register(&test_cpuidle_driver, NULL);
+	if (retval) {
+		printk(KERN_DEBUG "Registration of test driver failed.\n");
+		return retval;
+	}
+
+	test_cpuidle_devices = alloc_percpu(struct cpuidle_device);
+	if (test_cpuidle_devices == NULL) {
+		cpuidle_unregister_driver(&test_cpuidle_driver);
+		return -ENOMEM;
+	}
+
+	retval = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					   "cpuidle/powernv:online",
+					   cpuidle_cpu_online,
+					   cpuidle_cpu_dead);
+
+	if (retval < 0) {
+		test_cpuidle_uninit();
+	} else {
+		test_hp_idlestate = retval;
+		retval = 0;
+	}
+
+	return retval;
+}
+
+static void __exit test_cpuidle_exit(void)
+{
+	test_cpuidle_uninit();
+}
+
+module_init(test_cpuidle_init);
+module_exit(test_cpuidle_exit);
+MODULE_DESCRIPTION("Test Cpuidle Driver");
+MODULE_AUTHOR("Abhishek Goel");
+MODULE_LICENSE("GPL");
+
-- 
2.17.1

