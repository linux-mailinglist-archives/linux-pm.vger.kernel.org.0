Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4E523C710
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 09:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHEHj2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 03:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgHEHj1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 03:39:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB56C06174A;
        Wed,  5 Aug 2020 00:39:27 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i92so2764730pje.0;
        Wed, 05 Aug 2020 00:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EAu4Xv5+GEzBUioolMyaF0uukE3fe4YKQVPhRE7ah24=;
        b=nGAmX3YexnKwR0dre7CSxOmgRr45TO/L2YtUfAFAFwj/0mN5ymzzqgrHgyktLPeJnK
         sTNqI8DYE3op7kX+WVRV7iLs6gWkcKm19DmZDFXlnR4v0p1+YfW05EWbSOWMsrKmYHkQ
         U3c91bTajpXfmZUicwHDlMzD1zpXtKs87lo/bSHTChseMOqc8AIKc7KdwnTw+cfW7FXt
         VU01u7Ci+349Qq5L1dr5szLg6tJxsVvpw5dQmtzuiA/pEHvW4eFsyivNdDPjJjusrTQx
         TGuFZHE/4L1CmSalrxCTV0dyD5NlY92imgMy71xaQGOa1sqLMrm/JEKi26bBqWG24oLy
         I93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EAu4Xv5+GEzBUioolMyaF0uukE3fe4YKQVPhRE7ah24=;
        b=A2jgn7vf5bB8lYP6kxY5dnqBVWHC2d3UCixgKc2OUDC9j/nN5pyeks2UT5R9/gckxb
         2g99jAqcRPaNnoA/JIsy9tBNYOVLaIN+nFxZ/tEFjrUbndlNcCZTfphXYLSedkGwJmmr
         QdVnG5W9ChiTbisqdbUQEhq4Hj7Azvbu1RjXze8wBMHKbVqLDl3YNuu9jdU1Hjq+1Rn+
         G2sJYERXAuAPAQrutdR2KsG8PkHekVqAXRzX4iAtCKHCbF15TW4uWYM/OPBAOH1Z0fgF
         6RzhNViSOF3smnDQmoXZPPc7AH16xDvY/1fIXAhgcdbarrlYhJyfR5ZsnkmnezR2557E
         G74w==
X-Gm-Message-State: AOAM533Jywm5j3+OYYQj3WrXstpnDuLj69zN335kQWSR01BoyOeFnNTM
        PLilAUhVJYSY3p0X05LthUw=
X-Google-Smtp-Source: ABdhPJxQKMiQqG88q+KKAXhHtCViMVeE+F+k2Qu6X+edHLHitZVnuk83bQuvyhV+2FvktxRcg/2Qqw==
X-Received: by 2002:a17:902:6904:: with SMTP id j4mr1973184plk.198.1596613166499;
        Wed, 05 Aug 2020 00:39:26 -0700 (PDT)
Received: from yangdongdo-OptiPlex-9010.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id r28sm1972871pfg.158.2020.08.05.00.39.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 00:39:25 -0700 (PDT)
From:   Dongdong Yang <contribute.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        yanziily@xiaomi.com, rocking@linux.alibaba.com
Subject: [PATCH v5] sched: Provide USF for the portable equipment.
Date:   Wed,  5 Aug 2020 15:36:21 +0800
Message-Id: <3bbd9a487176a05588e33ff660d4e58efa1fdb10.1596612536.git.yangdongdong@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1596612536.git.yangdongdong@xiaomi.com>
References: <cover.1596612536.git.yangdongdong@xiaomi.com>
In-Reply-To: <cover.1596612536.git.yangdongdong@xiaomi.com>
References: <cover.1596612536.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dongdong Yang <yangdongdong@xiaomi.com>

The power consumption and UI response are more cared for by the portable
equipment users. USF(User Sensitive Feedback factor) auxiliary cpufreq
governor is providing more util adjustment settings to the high level
by scenario identification.

From the view of portable equipment, screen off status usually stands
for no request from the user, however, the kernel is still expected to
notify the user in time on modem, network or powerkey events occur. In
some scenarios, such as listening to music, low power processors, such
as DSP, take more actions and CPU load requirements cut down.  It would
bring more power consumption benefit if high level have interfaces to
adjust utils according to the current scenario and load.

In addition, the portable equipment user usually heavily interact with
devices by touch, and other peripherals. The boost preemptive counts
are marking the load requirement urgent, vice versa. If such feedback
factor could be set to high level according to the scenario, it would
contribute to the power consumption and UI response.

If no USF sysfs inode is set, and no screen on or off event,
adjust_pred_demand shall not be invoked. Once up_l0_r down_r or non_ux_r
be set, adjust_pred_demand shall be called back to update settings
according to high level scenario identification.

We can get about 17% mean power consumption save at listening to music
with speaker on "screen off" scenario, as below statistical data from
7766 XiaoMi devices for two weeks with non_ux_r be set:

        day1         day2         day3         day4
count   7766.000000  7766.000000  7766.000000  7766.000000
mean    88.035525    85.500282    83.829305    86.054997
std     111.049980   108.258834   107.562583   108.558240
min     0.099000     0.037000     0.067000     0.045000
25%     34.765500    34.021750    34.101500    34.423000
50%     54.950000    55.286500    54.189500    54.248500
75%     95.954000    93.942000    91.738000    94.0592500
80%     114.675000   107.430000   106.378000   108.673000
85%     137.851000   129.511000   127.156500   131.750750
90%     179.669000   170.208500   164.027000   172.348000
95%     272.395000   257.845500   247.750500   263.275750
98%     399.034500   412.170400   391.484000   402.835600

        day5         day6        day7         day8
count   7766.000000  7766.00000  7766.000000  7766.000000
mean    82.532677    79.21923    77.611380    81.075081
std     104.870079   101.34819   103.140037   97.506221
min     0.051000     0.02900     0.007000     0.068000
25%     32.873000    33.44400    31.965500    33.863500
50%     52.180500    51.56550    50.806500    53.080000
75%     90.905750    86.82625    83.859250    89.973000
80%     105.455000   99.64700    97.271000    104.225000
85%     128.300000   118.47825   116.570250   126.648250
90%     166.647500   149.18000   150.649500   161.087000
95%     247.208500   224.36050   226.380000   245.291250
98%     393.002000   347.92060   369.791800   378.778600

        day9         day10        day11        day12
count   7766.000000  7766.000000  7766.000000  7766.000000
mean    79.989170    83.859417    78.032930    77.060542
std     104.226122   108.893043   102.561715   99.844276
min     0.118000     0.017000     0.028000     0.039000
25%     32.056250    33.454500    31.176250    30.897750
50%     51.506000    54.056000    48.969500    49.069000
75%     88.513500    92.953500    83.506750    84.096000
80%     102.876000   107.845000   97.717000    98.073000
85%     124.363000   128.288000   118.366500   116.869250
90%     160.557000   167.084000   154.342500   148.187500
95%     231.149000   242.925750   236.759000   228.131250
98%     367.206600   388.619100   385.269100   376.541600

        day13        day14
count   7766.000000  7766.000000
mean    75.528036    73.702878
std     90.750594    86.796016
min     0.066000     0.054000
25%     31.170500    31.608500
50%     48.758500    49.215000
75%     84.522750    83.053000
80%     97.879000    94.875000
85%     116.680250   113.573750
90%     149.083500   144.089500
95%     226.177750   211.488750
98%     347.011100   331.317100

Signed-off-by: Dongdong Yang <yangdongdong@xiaomi.com>
Co-developed-by: Jun Tao <taojun@xiaomi.com>
Co-developed-by: Qiwu Huang <huangqiwu@xiaomi.com>
Co-developed-by: Peng Wang <rocking@linux.alibaba.com>
Signed-off-by: Dongdong Yang <yangdongdong@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |  31 ++
 drivers/cpufreq/Kconfig                            |  11 +
 kernel/sched/Makefile                              |   1 +
 kernel/sched/cpufreq_schedutil.c                   |   5 +
 kernel/sched/usf.c                                 | 314 +++++++++++++++++++++
 5 files changed, 362 insertions(+)
 create mode 100644 kernel/sched/usf.c

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index b555df8..e9a4cfd 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -614,3 +614,34 @@ Description:	SPURR ticks for cpuX when it was idle.
 
 		This sysfs interface exposes the number of SPURR ticks
 		for cpuX when it was idle.
+
+What:		/sys/devices/system/cpu/sched_usf
+		/sys/devices/system/cpu/sched_usf/non_ux_r
+		/sys/devices/system/cpu/sched_usf/up_l0_r
+		/sys/devices/system/cpu/sched_usf/down_r
+Date:		Aug 2020
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	User Sensitive Feedback factor auxiliary scheduling which
+		is providing more util adjustment settings based on schedutil
+		governor to the high level by scenario identification on
+		portable equipment.
+		non_ux_r:
+			The default value is 0.	The range is [-100 , 0].
+			If it falls into [-50, 0), the half of utils, which
+			calculates cpufreq, shall be cut down on screen off.
+			If it falls into [-100, -50), only a quarter of utils
+			are left to continue to calculate cpufreq on screen off.
+
+		up_l0_r:
+			The default value is 0.	The range is [0 , 100].
+			If it falls into (0, 50], a quarter of extra utils,
+			which calculate cpufreq, shall be added on screen on.
+			If it falls into (50, 100], the half of extra utils are
+			added to continue to calculate cpufreq on screen on.
+
+		down_r:
+			The default value is 0.	The range is [-100 , 0].
+			If it falls into [-50, 0), the half of utils, which
+			calculate cpufreq, shall be  cut down on screen on.
+			If it falls into [-100, -50), only a quarter of utils
+			are left to continue to calculate cpufreq on screen on.
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index e917501..a21c6ad 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -224,6 +224,17 @@ config CPUFREQ_DT_PLATDEV
 
 	  If in doubt, say N.
 
+config SCHED_USF
+	bool "User Sensitive Factors for Scheduler"
+	depends on CPU_FREQ_GOV_SCHEDUTIL && FB
+	help
+	  Select this option to enable the adjustment on the cpufreq with
+	  the user sensitive factors on schedule. It is special for mobile
+	  devices which more power care and quick response requirement on
+	  screen on.
+
+	  If unsure, say N.
+
 if X86
 source "drivers/cpufreq/Kconfig.x86"
 endif
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 5fc9c9b..58a0e7b 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += cpufreq_schedutil.o
 obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
 obj-$(CONFIG_PSI) += psi.o
+obj-$(CONFIG_SCHED_USF) += usf.o
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7fbaee2..6f9cb6c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -289,12 +289,17 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 	return min(max, util);
 }
 
+void (*adjust_pred_demand_p)(int cpuid, unsigned long *util,
+			     struct rq *rq) = NULL;
+
 static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 	unsigned long util = cpu_util_cfs(rq);
 	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
 
+	if (unlikely(adjust_pred_demand_p))
+		adjust_pred_demand_p(sg_cpu->cpu, &util, rq);
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
diff --git a/kernel/sched/usf.c b/kernel/sched/usf.c
new file mode 100644
index 0000000..f3183f1
--- /dev/null
+++ b/kernel/sched/usf.c
@@ -0,0 +1,314 @@
+/*
+ * Copyright (C) 2020 XiaoMi Inc.
+ * Author: Yang Dongdong <yangdongdong@xiaomi.com>
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/kthread.h>
+#include <linux/cpu.h>
+#include <linux/sysfs.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kallsyms.h>
+#include <linux/fb.h>
+#include <linux/notifier.h>
+#include "sched.h"
+
+#define BOOST_MIN_V -100
+#define BOOST_MAX_V 100
+#define LEVEL_TOP 3
+
+extern void (*adjust_pred_demand_p)(int cpuid,
+			unsigned long *util, struct rq *rq);
+DEFINE_PER_CPU(unsigned long[PID_MAX_DEFAULT], task_hist_nivcsw);
+
+static struct {
+	bool is_enabled;
+	bool is_screen_on;
+	int sysctl_up_l0;
+	int sysctl_down;
+	int sysctl_non_ux;
+	int usf_up_l0;
+	int usf_down;
+	int usf_non_ux;
+} usf_vdev;
+
+void adjust_pred_demand(int cpuid,
+			unsigned long *util,
+			struct rq *rq)
+{
+	/*
+	 * The initial value of bl_sw_num is the ratio of
+	 * sysctl_sched_latency/sysctl_sched_min_granularity.
+	 * It stands for the basic acceptable fluency.
+	 */
+	u32 bl_sw_num = 3;
+
+	if (!usf_vdev.is_enabled || !rq || !rq->curr ||
+		(rq->curr->pid >= PID_MAX_DEFAULT))
+		return;
+	/*
+	 * usf_non_ux:
+	 *	It comes from non_ux_r, which is the ratio of utils
+	 *	cut down on screen off. There are 3 levels. The default
+	 *	value is 0, which no util is adjusted on calculating
+	 *	utils to select cpufreq. If non_ux_r falls into [-50, 0),
+	 *	usf_non_ux equals 1, and a half of utils, which calculates
+	 *	cpufreq, shall be cut down. If non_ux_r falls into
+	 *	[-100, -50), usf_non_ux equals to 2, only a quarter of
+	 *	utils are left to continue to calculate cpufreq.
+	 *
+	 * usf_up_l0:
+	 *	It comes from sysfs up_l0, which is the ratio of utils
+	 *	boost up on screen on. There are 3 levels. The default
+	 *	value is 0, which no util is adjusted when cpufreq be
+	 *	calculated according it. If up_l0 falls into (0, 50],
+	 *	usf_up_l0 equals to 2. And a quarter of extra utils,
+	 *	which calculate cpufreq, shall be added. If up_l0 falls
+	 *	into (50, 100], usf_up_l0 equals to 1. And the half of
+	 *	extra utils are added to continue to calculate cpufreq.
+	 *
+	 * usf_down:
+	 *	It comes from down_r, which is the ratio of utils cut
+	 *	down on screen on. There are 3 levels. The default value
+	 *	is 0, which no util is adjusted on calculating utils to
+	 *	select cpufreq. If down_r falls into [-50, 0), usf_down
+	 *	equals to 1, and a half of utils, which calculate cpufreq
+	 *	shall be  cut down. If down_r falls into [-100, -50)
+	 *	usf_down equals to 2, and only a quarter of utils are
+	 *	left to continue to calculate cpufreq.
+	 */
+	if (usf_vdev.is_screen_on) {
+		if (rq->curr->nivcsw >
+		    (per_cpu(task_hist_nivcsw, cpuid)[rq->curr->pid]
+		     + bl_sw_num + 1)) {
+			(*util) += (*util) >> usf_vdev.usf_up_l0;
+		} else if (rq->curr->nivcsw <
+			   (per_cpu(task_hist_nivcsw, cpuid)[rq->curr->pid]
+			    + bl_sw_num - 1) && (rq->nr_running < bl_sw_num)) {
+			(*util) >>= usf_vdev.usf_down;
+		}
+		per_cpu(task_hist_nivcsw, cpuid)[rq->curr->pid] =
+		    rq->curr->nivcsw;
+	} else if (rq->curr->mm) {
+		(*util) >>= usf_vdev.usf_non_ux;
+	}
+}
+
+static int usf_lcd_notifier(struct notifier_block *nb,
+			    unsigned long val, void *data)
+{
+	struct fb_event *evdata = data;
+	unsigned int blank;
+
+	if (!evdata)
+		return 0;
+
+	if (val != FB_EVENT_BLANK)
+		return 0;
+
+	if (evdata->data && val == FB_EVENT_BLANK) {
+		blank = *(int *)(evdata->data);
+
+		switch (blank) {
+		case FB_BLANK_POWERDOWN:
+			usf_vdev.is_screen_on = false;
+			if (usf_vdev.sysctl_non_ux != 0)
+				adjust_pred_demand_p = adjust_pred_demand;
+			else
+				adjust_pred_demand_p = NULL;
+
+			break;
+
+		case FB_BLANK_UNBLANK:
+			usf_vdev.is_screen_on = true;
+			if (usf_vdev.sysctl_up_l0 != 0 ||
+			    usf_vdev.sysctl_down != 0)
+				adjust_pred_demand_p = adjust_pred_demand;
+			else
+				adjust_pred_demand_p = NULL;
+			break;
+		default:
+			break;
+		}
+
+		usf_vdev.is_enabled = true;
+		pr_info("%s : usf_vdev.is_screen_on:%b\n",
+				     __func__, usf_vdev.is_screen_on);
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block usf_lcd_nb = {
+	.notifier_call = usf_lcd_notifier,
+	.priority = INT_MAX,
+};
+
+static ssize_t up_l0_r_store(struct device *kobj,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int val = 0;
+	int ret = 0;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val == 0) {
+		usf_vdev.sysctl_up_l0 = val;
+		usf_vdev.usf_up_l0 = 0;
+	} else if ((val > 0) && (val <= BOOST_MAX_V)) {
+		usf_vdev.sysctl_up_l0 = val;
+		usf_vdev.usf_up_l0 = LEVEL_TOP -
+				DIV_ROUND_UP(val, BOOST_MAX_V / 2);
+		ret = count;
+	} else {
+		pr_err("USF BUG: %d should fall into [%d %d]",
+		       val, 0, BOOST_MAX_V);
+		ret = -EINVAL;
+	}
+	if ((usf_vdev.sysctl_up_l0 == 0) &&
+	    (usf_vdev.sysctl_down == 0))
+		adjust_pred_demand_p = NULL;
+	else
+		adjust_pred_demand_p = adjust_pred_demand;
+
+	return ret;
+}
+
+static ssize_t down_r_store(struct device *kobj,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	int val = 0;
+	int ret = 0;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if ((val >= BOOST_MIN_V) && (val <= 0)) {
+		usf_vdev.sysctl_down = val;
+		usf_vdev.usf_down = DIV_ROUND_UP(-val, -BOOST_MIN_V / 2);
+		ret = count;
+	} else {
+		pr_err("USF BUG: %d should fall into [%d %d]",
+		       val, BOOST_MIN_V, 0);
+		ret = -EINVAL;
+	}
+	if ((usf_vdev.sysctl_up_l0 == 0) &&
+	    (usf_vdev.sysctl_down == 0))
+		adjust_pred_demand_p = NULL;
+	else
+		adjust_pred_demand_p = adjust_pred_demand;
+
+	return ret;
+}
+
+static ssize_t non_ux_r_store(struct device *kobj,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	int val = 0;
+	int ret = 0;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if ((val >= BOOST_MIN_V) && (val <= 0)) {
+		usf_vdev.sysctl_non_ux = val;
+		usf_vdev.usf_non_ux = DIV_ROUND_UP(-val, -BOOST_MIN_V / 2);
+		ret = count;
+	} else {
+		pr_err("USF BUG: %d should fall into [%d %d]",
+		       val, BOOST_MIN_V, 0);
+		ret = -EINVAL;
+	}
+	if (usf_vdev.sysctl_non_ux == 0)
+		adjust_pred_demand_p = NULL;
+	else
+		adjust_pred_demand_p = adjust_pred_demand;
+
+	return ret;
+}
+
+#define usf_attr_rw(_name)						\
+static struct device_attribute _name =					\
+__ATTR_RW(_name)
+
+#define usf_show_node(_name, _value)					\
+static ssize_t _name##_show						\
+(struct device *kobj, struct device_attribute *attr,  char *buf)		\
+{									\
+	return sprintf(buf, "%d", usf_vdev.sysctl_##_value);		\
+}
+
+usf_show_node(up_l0_r, up_l0);
+usf_show_node(down_r, down);
+usf_show_node(non_ux_r, non_ux);
+
+usf_attr_rw(up_l0_r);
+usf_attr_rw(down_r);
+usf_attr_rw(non_ux_r);
+
+static struct attribute *sched_usf_attrs[] = {
+	&up_l0_r.attr,
+	&down_r.attr,
+	&non_ux_r.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(sched_usf);
+
+static int __init intera_monitor_init(void)
+{
+	int res = -1;
+	struct device *dev;
+
+	res = fb_register_client(&usf_lcd_nb);
+	if (res < 0) {
+		pr_err("Failed to register usf_lcd_nb!\n");
+		return res;
+	}
+
+	/*
+	 * create a sched_usf in cpu_subsys:
+	 * /sys/devices/system/cpu/sched_usf/...
+	 */
+	dev = cpu_subsys.dev_root;
+	res = sysfs_create_group(&dev->kobj, &sched_usf_group);
+	if (res) {
+		fb_unregister_client(&usf_lcd_nb);
+		return res;
+	}
+
+	return res;
+}
+
+module_init(intera_monitor_init);
+
+static void __exit intera_monitor_exit(void)
+{
+	struct device *dev;
+
+	dev = cpu_subsys.dev_root;
+	sysfs_remove_group(&dev->kobj, &sched_usf_group);
+	fb_unregister_client(&usf_lcd_nb);
+	adjust_pred_demand_p = NULL;
+}
+
+module_exit(intera_monitor_exit);
-- 
2.7.4

