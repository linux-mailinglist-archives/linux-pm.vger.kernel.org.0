Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF291F3841
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 12:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgFIKmg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 06:42:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40477 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgFIKmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 06:42:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200609104232euoutp02e8f334a13f055da0b268d39d523d7917~W2iCvcCIg1777417774euoutp02V
        for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2020 10:42:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200609104232euoutp02e8f334a13f055da0b268d39d523d7917~W2iCvcCIg1777417774euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591699352;
        bh=PLSkqIpsLNlo/H+N+2IqGi7nS8Ifz833svNS45yASaU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Q4cIlDSZwf670+KHd/rCHR4dCy5PsuLxj5Cq1ZOgX3D3Yfw5JrO8SP7Z+uK8fXSdW
         TkkIYqxU5MpGm/AdYPL5qX/VFkK93QlZxPTcE64iAVdeeuPE821sCYyAHS/xeVUl5H
         74msriKs9OS8G6GaU1HitPdA64ZjG8MjagW6iyoY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200609104231eucas1p112b22b13492cea33847f349dce05a938~W2iCAM-H61594015940eucas1p1V;
        Tue,  9 Jun 2020 10:42:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 40.19.61286.7976FDE5; Tue,  9
        Jun 2020 11:42:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200609104230eucas1p2efc14b59c4ccdcb839b54a62fbd8a31c~W2iBlGmiQ2622926229eucas1p2c;
        Tue,  9 Jun 2020 10:42:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200609104230eusmtrp2bdccadc2492619067695f3ce648d7306~W2iBkUG5T2886328863eusmtrp2i;
        Tue,  9 Jun 2020 10:42:30 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-07-5edf67973457
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.A7.07950.6976FDE5; Tue,  9
        Jun 2020 11:42:30 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200609104230eusmtip21b6d4ef4b0fd3602023d5155dcc52158~W2iAvfttR1352613526eusmtip2G;
        Tue,  9 Jun 2020 10:42:30 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v3] soc: samsung: Add simple voltage coupler for Exynos5800
Date:   Tue,  9 Jun 2020 12:42:21 +0200
Message-Id: <20200609104221.21243-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO7t3d9fR4naVPD2oWFgkpFtFnKzsQcHtSUQPKDSX3la5Tdl1
        lf1TaNRaraIITUzFSvNRtrV0mxW1RltMp2iuiTO1hMgaldMeltbc7fHf5/c93+/5/g4cEqNt
        wmnkQU0Oq9UoVFJCjNc/+96yoEDZkyqzeqYiU2GdEF3p6yfQy6G3QlTz+Q1ALS13Raj3WqcA
        fXmhF6B2ezGBQkYnQIUtjwTotrNbhD58axagrpJ2HDV52oTI4Bgl0JjPhCO98wuGTMPMKpqx
        FXWLmDKzjjFXnyGYgO8BwVwYlTGWjtM4c95SDRiXv0HAhMwzt0btFi/PYFUHD7PaxOQ08QF/
        9w1RtmXb0eF+E34C9KwxgCgSUothVdMwbgBikqZuAdiYPwL4YQhA73W9kB9CAFpGf+B/I15f
        4E+kEkBb3gj2L+IONIJxF0HJoSFoIMY5hkqB7sGKyFUY9RyHxe5bEVM0tRH2tJZh44xTcdDr
        bIiwhFoBu0otQr5uFqy5+zjSACm7CL63dhL8wVr4sNT5h6PhgMsi4nkG/GUrFfCBfAD7vLdF
        /HAOwPa8QsC7lsGAdyScJsM7zYd19kReXg2rvndEZEhNgv7g5HEZC+Ol+gKMlyVQf4rm3XNh
        kevOv9onrW0Yzwysdfki+9Phxxsqx4iLYGbR/64yAKpBLKvj1EqWk2vYIwmcQs3pNMqE9Cy1
        GYQ/lGfMNWgFw237HIAigXSixB/7KpUWKg5zuWoHgCQmjZGsafak0pIMRe4xVpu1V6tTsZwD
        TCdxaaxkUfm7FJpSKnLYTJbNZrV/TwVk1LQTQO4umIP9FG52Jc3ZXiJz9T7Nh8F7Pwn1yXMf
        7+/I7DyevKTWvxA3R9W8jrm5qzxJaUyz5u5XzQvMq9Jf7RL1XgvN2nBhZ63mrPrrhHS7Z9Rf
        Fvy0giuu25O3dMehtd3MbPrySkdqdvym5C1FA03ljFGxWzYl0VfBro9LiwkZ10VLce6AQh6P
        aTnFbxQw/wdMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Pd1p6ffjDLp7rCw2zljPajH14RM2
        i+tfnrNarP74mNHi/PkN7BYP5t5ksvh2pYPJ4vKuOWwWn3uPMFrMOL+PyWLtkbvsFm9+nGWy
        uD3vMovFmdOXWC26Dv1ls/h3bSOLRceRb8wWG796OAh57Jx1l91jwaZSj02rOtk87lzbw+bR
        /9fAY8vVdhaPvi2rGD2O39jO5PF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6h
        sXmslZGpkr6dTUpqTmZZapG+XYJexo27S9gLtgRVfH2ykaWB8b5TFyMnh4SAicS5a3dYQGwh
        gaWMEm1TkyDiMhInpzWwQtjCEn+udbFB1HxilGi/ywViswkYSnS9hYiLCMRLnP5/gr2LkYuD
        WeAqi8T/hnawZmEBb4n7FxYwg9gsAqoS545sB7N5BWwlbs/fArVAXmL1hgPMExh5FjAyrGIU
        SS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMiW3Hfm7Zwdj1LvgQowAHoxIP7w3xe3FCrIllxZW5
        hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsRoCrR8IrOUaHI+MF7zSuINTQ3NLSwNzY3N
        jc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwGv+PC21d6fo3XNxseoy+Ua5EKhdr1/k9
        s5yLp03ovictJTJrtli2WGZb9hrBvKOXWzkZ7YKSGWX8vE6e8/zjlzhzUd8Mg+8s5ZfZjvUc
        75728cXhayXfFtT3N1VJP7rHHGnNH2TdfeLiGmcZjierJ9T1hZfHeG7P+3XRPqKv/J7Y6lNT
        zZ4qsRRnJBpqMRcVJwIAxiycuJ8CAAA=
X-CMS-MailID: 20200609104230eucas1p2efc14b59c4ccdcb839b54a62fbd8a31c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200609104230eucas1p2efc14b59c4ccdcb839b54a62fbd8a31c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200609104230eucas1p2efc14b59c4ccdcb839b54a62fbd8a31c
References: <CGME20200609104230eucas1p2efc14b59c4ccdcb839b54a62fbd8a31c@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a simple custom voltage regulator coupler for Exynos5800 SoCs, which
require coupling between "vdd_arm" and "vdd_int" regulators. This coupler
ensures that the voltage values don't go below the bootloader-selected
operation point during the boot process until a the clients sets their
constraints. It is achieved by assuming minimal voltage value equal to
the current value if no constraints are set. This also ensures proper
voltage balancing if any of the client driver is missing.

The balancing code comes from regulator core.c with the 

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This patch is yet another attempt to fix the regulator coupling on
Exynos5800/5422 SoCs. Here are links to the previous attempts and
discussions:

https://lore.kernel.org/linux-samsung-soc/20191008101709.qVNy8eijBi0LynOteWFMnTg4GUwKG599n6OyYoX1Abs@z/
https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/
https://lore.kernel.org/linux-pm/cover.1589528491.git.viresh.kumar@linaro.org/
https://lore.kernel.org/linux-pm/20200528131130.17984-1-m.szyprowski@samsung.com/
https://lore.kernel.org/linux-samsung-soc/57cf3a15-5d9b-7636-4c69-60742e8cfae6@samsung.com/
https://lore.kernel.org/lkml/20200605063724.9030-1-m.szyprowski@samsung.com/

The problem is with "vdd_int" regulator coupled with "vdd_arm" on Odroid
XU3/XU4 boards family. "vdd_arm" is handled by CPUfreq. "vdd_int" is
handled by devfreq. CPUfreq initialized quite early during boot and it
starts changing OPPs and "vdd_arm" value. Sometimes CPU activity during
boot goes down and some low-frequency OPPs are selected, what in turn
causes lowering "vdd_arm". This happens before devfreq applies its
requirements on "vdd_int". Regulator balancing code reduces "vdd_arm"
voltage value, what in turn causes lowering "vdd_int" value to the lowest
possible value. This is much below the operation point of the wcore bus,
which still runs at the highest frequency.

The issue was hard to notice because in the most cases the board managed
to boot properly, even when the regulator was set to lowest value allowed
by the regulator constraints. However, it caused some random issues,
which can be observed as "Unhandled prefetch abort" or low USB stability.

Handling this case in the generic code has been rejected, so the only way
to ensure the desired behavior on Exynos5800-based SoCs is to make a
custom regulator coupler driver. I've tried hard to extract some common
code to simplify the exynos-regulator-coupler driver as much as possible,
but the difference between it and the generic code is so deep that this
approach failed, so indead I simply copied and modified the balancing
code.

Best regards
Marek Szyprowski
---
 arch/arm/mach-exynos/Kconfig                  |   1 +
 drivers/soc/samsung/Kconfig                   |   3 +
 drivers/soc/samsung/Makefile                  |   1 +
 .../soc/samsung/exynos-regulator-coupler.c    | 221 ++++++++++++++++++
 4 files changed, 226 insertions(+)
 create mode 100644 drivers/soc/samsung/exynos-regulator-coupler.c

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 76838255b5fa..f185cd3d4c62 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -118,6 +118,7 @@ config SOC_EXYNOS5800
 	bool "Samsung EXYNOS5800"
 	default y
 	depends on SOC_EXYNOS5420
+	select EXYNOS_REGULATOR_COUPLER
 
 config EXYNOS_MCPM
 	bool
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 19c4d3f1437b..5d7819b52eed 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -43,4 +43,7 @@ config EXYNOS_PM_DOMAINS
 	bool "Exynos PM domains" if COMPILE_TEST
 	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
 
+config EXYNOS_REGULATOR_COUPLER
+	bool "Exynos SoC Regulator Coupler" if COMPILE_TEST
+	depends on ARCH_EXYNOS || COMPILE_TEST
 endif
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 31db65cb7aa3..93285faec416 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
 					exynos5250-pmu.o exynos5420-pmu.o
 obj-$(CONFIG_EXYNOS_PMU_ARM64_DRIVERS)	+= exynos-pm.o exynos5433-pmu.o
 obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
+obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
diff --git a/drivers/soc/samsung/exynos-regulator-coupler.c b/drivers/soc/samsung/exynos-regulator-coupler.c
new file mode 100644
index 000000000000..3cafc1738eb6
--- /dev/null
+++ b/drivers/soc/samsung/exynos-regulator-coupler.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ * Author: Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * Simplified generic volatage coupler from regulator core.c
+ * The main difference is that it keeps current regulator voltage
+ * if consumers didn't apply their contraints yet.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/regulator/coupler.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
+					 int *current_uV,
+					 int *min_uV, int *max_uV,
+					 suspend_state_t state)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
+	struct regulation_constraints *constraints = rdev->constraints;
+	int desired_min_uV = 0, desired_max_uV = INT_MAX;
+	int max_current_uV = 0, min_current_uV = INT_MAX;
+	int highest_min_uV = 0, target_uV, possible_uV;
+	int i, ret, max_spread, n_coupled = c_desc->n_coupled;
+	bool done;
+
+	*current_uV = -1;
+
+	/* Find highest min desired voltage */
+	for (i = 0; i < n_coupled; i++) {
+		int tmp_min = 0;
+		int tmp_max = INT_MAX;
+
+		lockdep_assert_held_once(&c_rdevs[i]->mutex.base);
+
+		ret = regulator_check_consumers(c_rdevs[i],
+						&tmp_min,
+						&tmp_max, state);
+		if (ret < 0)
+			return ret;
+
+		if (tmp_min == 0) {
+			ret = regulator_get_voltage_rdev(c_rdevs[i]);
+			if (ret < 0)
+				return ret;
+			tmp_min = ret;
+		}
+
+		/* apply constraints */
+		ret = regulator_check_voltage(c_rdevs[i], &tmp_min, &tmp_max);
+		if (ret < 0)
+			return ret;
+
+		highest_min_uV = max(highest_min_uV, tmp_min);
+
+		if (i == 0) {
+			desired_min_uV = tmp_min;
+			desired_max_uV = tmp_max;
+		}
+	}
+
+	max_spread = constraints->max_spread[0];
+
+	/*
+	 * Let target_uV be equal to the desired one if possible.
+	 * If not, set it to minimum voltage, allowed by other coupled
+	 * regulators.
+	 */
+	target_uV = max(desired_min_uV, highest_min_uV - max_spread);
+
+	/*
+	 * Find min and max voltages, which currently aren't violating
+	 * max_spread.
+	 */
+	for (i = 1; i < n_coupled; i++) {
+		int tmp_act;
+
+		tmp_act = regulator_get_voltage_rdev(c_rdevs[i]);
+		if (tmp_act < 0)
+			return tmp_act;
+
+		min_current_uV = min(tmp_act, min_current_uV);
+		max_current_uV = max(tmp_act, max_current_uV);
+	}
+
+	/*
+	 * Correct target voltage, so as it currently isn't
+	 * violating max_spread
+	 */
+	possible_uV = max(target_uV, max_current_uV - max_spread);
+	possible_uV = min(possible_uV, min_current_uV + max_spread);
+
+	if (possible_uV > desired_max_uV)
+		return -EINVAL;
+
+	done = (possible_uV == target_uV);
+	desired_min_uV = possible_uV;
+
+	/* Set current_uV if wasn't done earlier in the code and if necessary */
+	if (*current_uV == -1) {
+		ret = regulator_get_voltage_rdev(rdev);
+		if (ret < 0)
+			return ret;
+		*current_uV = ret;
+	}
+
+	*min_uV = desired_min_uV;
+	*max_uV = desired_max_uV;
+
+	return done;
+}
+
+static int exynos_coupler_balance_voltage(struct regulator_coupler *coupler,
+					  struct regulator_dev *rdev,
+					  suspend_state_t state)
+{
+	struct regulator_dev **c_rdevs;
+	struct regulator_dev *best_rdev;
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	int i, ret, n_coupled, best_min_uV, best_max_uV, best_c_rdev;
+	unsigned int delta, best_delta;
+	unsigned long c_rdev_done = 0;
+	bool best_c_rdev_done;
+
+	c_rdevs = c_desc->coupled_rdevs;
+	n_coupled = c_desc->n_coupled;
+
+	/*
+	 * Find the best possible voltage change on each loop. Leave the loop
+	 * if there isn't any possible change.
+	 */
+	do {
+		best_c_rdev_done = false;
+		best_delta = 0;
+		best_min_uV = 0;
+		best_max_uV = 0;
+		best_c_rdev = 0;
+		best_rdev = NULL;
+
+		/*
+		 * Find highest difference between optimal voltage
+		 * and current voltage.
+		 */
+		for (i = 0; i < n_coupled; i++) {
+			/*
+			 * optimal_uV is the best voltage that can be set for
+			 * i-th regulator at the moment without violating
+			 * max_spread constraint in order to balance
+			 * the coupled voltages.
+			 */
+			int optimal_uV = 0, optimal_max_uV = 0, current_uV = 0;
+
+			if (test_bit(i, &c_rdev_done))
+				continue;
+
+			ret = regulator_get_optimal_voltage(c_rdevs[i],
+							    &current_uV,
+							    &optimal_uV,
+							    &optimal_max_uV,
+							    state);
+			if (ret < 0)
+				goto out;
+
+			delta = abs(optimal_uV - current_uV);
+
+			if (delta && best_delta <= delta) {
+				best_c_rdev_done = ret;
+				best_delta = delta;
+				best_rdev = c_rdevs[i];
+				best_min_uV = optimal_uV;
+				best_max_uV = optimal_max_uV;
+				best_c_rdev = i;
+			}
+		}
+
+		/* Nothing to change, return successfully */
+		if (!best_rdev) {
+			ret = 0;
+			goto out;
+		}
+
+		ret = regulator_set_voltage_rdev(best_rdev, best_min_uV,
+						 best_max_uV, state);
+
+		if (ret < 0)
+			goto out;
+
+		if (best_c_rdev_done)
+			set_bit(best_c_rdev, &c_rdev_done);
+
+	} while (n_coupled > 1);
+
+out:
+	return ret;
+}
+
+static int exynos_coupler_attach(struct regulator_coupler *coupler,
+				 struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static struct regulator_coupler exynos_coupler = {
+	.attach_regulator = exynos_coupler_attach,
+	.balance_voltage  = exynos_coupler_balance_voltage,
+};
+
+static int __init exynos_coupler_init(void)
+{
+	if (!of_machine_is_compatible("samsung,exynos5800"))
+		return 0;
+
+	return regulator_coupler_register(&exynos_coupler);
+}
+arch_initcall(exynos_coupler_init);
-- 
2.17.1

