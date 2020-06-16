Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DBF1FA94D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgFPG6i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 02:58:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41367 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPG6h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 02:58:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200616065835euoutp01f691cfccf40c21ae613c66c01eb79913~Y8-gn6syn1675016750euoutp018
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 06:58:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200616065835euoutp01f691cfccf40c21ae613c66c01eb79913~Y8-gn6syn1675016750euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592290715;
        bh=ahT1lzHalZzCJ3mvKSgDWsLds6tJoGY+jhTXBD95Zak=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Ho7qCc9MGzgMR3gc2ZvsPWswAoFGAEH0ERETGKfffzHgDvpTP8SNUldwjE6v1HguE
         Z+dfHHxp7NNJfil2qLRD8n9OTwnr3I96gyKz0MzN/vaN1+a+UPLB6cBqCVQW4SgO1P
         uuZ7YV6RMHyDWOnAH2aiU+q8cmXJ47hOXxOnMx8g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200616065834eucas1p286c9c04645c84a09bbfeab796bf817f8~Y8-gLGD-11405814058eucas1p2u;
        Tue, 16 Jun 2020 06:58:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FB.FE.61286.A9D68EE5; Tue, 16
        Jun 2020 07:58:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200616065834eucas1p268ef16744422664c783b17f0a18c53e2~Y8-fwsnhA1405814058eucas1p2t;
        Tue, 16 Jun 2020 06:58:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200616065834eusmtrp2c760650225d0ed673236eeabf816098f~Y8-fv4Aqb0303603036eusmtrp2d;
        Tue, 16 Jun 2020 06:58:34 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-a3-5ee86d9a1640
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7A.9D.07950.A9D68EE5; Tue, 16
        Jun 2020 07:58:34 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200616065833eusmtip1575cce3ebfa8ec270663df67e722df37~Y8-fCNpvo1155611556eusmtip1h;
        Tue, 16 Jun 2020 06:58:33 +0000 (GMT)
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
Subject: [PATCH RESEND v4] soc: samsung: Add simple voltage coupler for
 Exynos5800
Date:   Tue, 16 Jun 2020 08:58:21 +0200
Message-Id: <20200616065821.29616-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHeXcuO45Wp6n4YmYyLCnICwq9mEU36EB0IYtuaK08qLhN3dS0
        +qBlZfOSBKEMb5WUeN/yNuliU5o2dTKvoZaSpS4tvJKW2ubR+vZ7/s//x/NyOBQmqiWcqXB5
        DKuQS6RiUoDXvF8w7VbLxoK98z75IU12BYEeD4+QqHd2lEAlU18AMpkq+Wgo9yMPzXel8FBn
        fQ6JZtKbAMo2veGhsqZBPpr41cZD/XmdOGo1mgmk0i+RaLlHg6OUpnkMaeaYAyJGpx7kMwXa
        WEZb/IBkBnpekczDJW+mqvs+zmRUFQPG0FfLY2a0rqfsLgoCQlhpeByr8Np/RRC2kNyFR+UE
        xusq04lEoDusAnYUpP1gsu4lqQICSkQXAfihcZLghlnrYJ7AbS0RPQNgqdp13VgaM62VXgA4
        VlWHcSWrUd3gZWOS9oGqSRVpYwc6CDZPP18VMLoFhznNRcC2sKfPwPF6A8/GOL0d9pQnETYW
        0vvgtDkPcNe2wZLKBswmQ1rPh7Udv9cWR6Cxs5Dk2B5aDFV8jl3gii6fxwl3ABxuL+NzQxqA
        nbez1+y9cKB90WpT1jfthBX1Xlx8EFr6n6zGkN4I+yY322LMio9qsjAuFsKUeyKuvQOqDeX/
        zr7rMGMcM7AmI5vgPkoQnHs2xM8Erur/twoAKAZObKxSFsoqfeTsdU+lRKaMlYd6XouUaYH1
        dzIuG6brwJz5qh7QFBBvEJ4/PRosIiRxygSZHkAKEzsID7UZg0XCEEnCDVYReVkRK2WVerCF
        wsVOQt+n40EiOlQSw0awbBSrWN/yKDvnRFBdckEVHf72RMvgSOM1T6Nj892vfx6M/LQPJ90X
        V7Y6Lxgv7d7z+Ufqx2L3W4NMbuDx0r2O55LSvlsSNR4pi+PADkhL/A2T/nq37p6TX7LsTRvH
        fVf6NPligUuhw+xYasQmy1mPb1LB0d7ugtetILph9GaAfiqTlMe3HXPj30uSiXFlmMRnF6ZQ
        Sv4CF9VVCkoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4Xd1ZuS/iDG7dl7bYOGM9q8XUh0/Y
        LK5/ec5qsfrjY0aL8+c3sFs8mHuTyeLblQ4mi8u75rBZfO49wmgx4/w+Jou1R+6yW7z5cZbJ
        4va8yywWZ05fYrXoOvSXzeLftY0sFh1HvjFbbPzq4SDksXPWXXaPBZtKPTat6mTzuHNtD5tH
        /18Djy1X21k8+rasYvQ4fmM7k8fnTXIBnFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqG
        xuaxVkamSvp2NimpOZllqUX6dgl6GT9brrAUzAmu2Lmhl7WBcadzFyMnh4SAicTfF+dZQWwh
        gaWMEkc+ZkPEZSROTmtghbCFJf5c62LrYuQCqvnEKPH7xBMWkASbgKFE11uQBCeHiEC8xOn/
        J9hBipgFrrJI/G9oB+sWFgiSWPHmKlgRi4CqxLV1jWBxXgFbiU+X5jFCbJCXWL3hAPMERp4F
        jAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAqNi27GfW3Ywdr0LPsQowMGoxMMbEfQ8Tog1
        say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGE2Blk9klhJNzgdGbF5JvKGpobmF
        paG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsbNS8PPnfnxtfJ583ebsK/sN7v2
        OxzavaZiI4P97auLL76J3Lxgm3axbaVUXIfypc0fX/29ouexRUbn7tJUtos5i3SyfcuzeLdq
        6ahNSnV9NWXKr6w3rRLq/O+zFzALrt7+hOmc+qbPiiab06d5frrnVNGd23qjJ1WSt1nixxyr
        G0cn1ThVpTIqsRRnJBpqMRcVJwIAdxszZ6ACAAA=
X-CMS-MailID: 20200616065834eucas1p268ef16744422664c783b17f0a18c53e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200616065834eucas1p268ef16744422664c783b17f0a18c53e2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200616065834eucas1p268ef16744422664c783b17f0a18c53e2
References: <CGME20200616065834eucas1p268ef16744422664c783b17f0a18c53e2@eucas1p2.samsung.com>
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

The balancing code comes from the regulator/core.c with the additional
logic for handling regulators without client constraints applied added.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
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
index c7a2003687c7..264185664594 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -37,4 +37,7 @@ config EXYNOS_PM_DOMAINS
 	bool "Exynos PM domains" if COMPILE_TEST
 	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
 
+config EXYNOS_REGULATOR_COUPLER
+	bool "Exynos SoC Regulator Coupler" if COMPILE_TEST
+	depends on ARCH_EXYNOS || COMPILE_TEST
 endif
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index edd1d6ea064d..ecc3a32f6406 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
 					exynos5250-pmu.o exynos5420-pmu.o
 obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
+obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
diff --git a/drivers/soc/samsung/exynos-regulator-coupler.c b/drivers/soc/samsung/exynos-regulator-coupler.c
new file mode 100644
index 000000000000..61a156b44a48
--- /dev/null
+++ b/drivers/soc/samsung/exynos-regulator-coupler.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ * Author: Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * Simplified generic voltage coupler from regulator core.c
+ * The main difference is that it keeps current regulator voltage
+ * if consumers didn't apply their constraints yet.
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

