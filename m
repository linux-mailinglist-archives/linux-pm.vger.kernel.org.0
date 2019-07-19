Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7021F6E7B1
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfGSPGF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 11:06:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40853 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbfGSPF7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 11:05:59 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190719150557euoutp0268b8722263c87f24e71db8cb64d818af~y1098m02p1490214902euoutp02I
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 15:05:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190719150557euoutp0268b8722263c87f24e71db8cb64d818af~y1098m02p1490214902euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563548757;
        bh=4LEKrr6dyn5LuFHbBzmuhFKzt96l7/4mbmgXY0tF0XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnh72OSrmUvQAyfKZsPy1Br3N8bSdN8y0N828YgfC+XZlCpBnyXkDdgjgA7iWhmDR
         z/YbJ5KdT7z0y+05QcV+mzCOWRcu28z6HCat5/ALi4iK/EnzB13euVsensfCz9EbEP
         OyXSoB+rwbb6PVsLgvTFkqzxiEPQ7kaayCr/5k3s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719150556eucas1p2657d160e1a600928c5474bf5bac8cb3e~y109Mmd8k2491724917eucas1p2G;
        Fri, 19 Jul 2019 15:05:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D7.73.04325.35CD13D5; Fri, 19
        Jul 2019 16:05:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e~y108Zjc1d3011130111eucas1p1t;
        Fri, 19 Jul 2019 15:05:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719150555eusmtrp2211d3f890d3ddfcdb13091e269bbf12e~y108I2rPx3114831148eusmtrp2A;
        Fri, 19 Jul 2019 15:05:55 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-68-5d31dc53a462
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.9F.04146.25CD13D5; Fri, 19
        Jul 2019 16:05:54 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719150554eusmtip1c2f2d83f62c57ebeb6092f7f91ed66bc~y107WejL02820728207eusmtip1k;
        Fri, 19 Jul 2019 15:05:54 +0000 (GMT)
From:   k.konieczny@partner.samsung.com
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 3/5] devfreq: exynos-bus: convert to use
 dev_pm_opp_set_rate()
Date:   Fri, 19 Jul 2019 17:05:33 +0200
Message-Id: <20190719150535.15501-4-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTURz33Md2FWfXaXhSsZz0ocIXCh11hIXBhb4EQkVptfSiok7bfGQJ
        Wj5SyQcmaCo+ykjUmo9lvhJc4ghfmORWPhBN1NTV0ExJXduult9+/9/j/M+PcyhcOEM6UlHS
        BFYmlcSIeFZE+8D2qHvwlHeoV92SP2opU5BIs7FIour+ERIV9BoAKpxfwdHoaDMfDT9a5aPW
        +QkSjXdV8tB6fj9AZaO9GHrdP81HLzVjGJp8WM9Dq1vDGMp6389HexMtBGqbHeAFCpmmqibA
        tDbk8pi2ujSmT9eDMQXKBsCote8wZr3V5TL/upU4nI2JSmJlnuduW0VO1unI+HzxveKMHF46
        qPXKA5YUpH3h4ogBywNWlJCuB1A1NkFwwwaAFcVFfG5YB1BdvcY/iHTPpe8LrwDUTi3g/yKD
        u3OYycWjT0Jl2bI5YU+7waczpWYTTm8TsHm8xSzY0cGwZKeRMGHCGChs1Jl5AR0EtemdgFt3
        HOZ2dJs9lvRFuNH3Y99jCz8++2bmcaMn420Fzvn1fPhkyyMPUEYcBOenXTjaDn5XK/cbOEND
        ZzXG4WS4UFtgbgPpTABnH+sJTgiAH9RjpOkcnD4FFV2eHH0earrVgDveBmrXbLkb2MDidlNF
        Ey2AOdlCzu0OqwxDJIedYJ7hzT5moKJGSRYB1/JDXcoPdSn/v7cG4A3AgU2Ux0awch8pm+wh
        l8TKE6URHmFxsa3A+OsG99S/OkDvzh0VoCkgshb8/OodKiQlSfKUWBWAFC6yF0wue4YKBeGS
        lPusLO6WLDGGlauAE0WIHAQPLGZvCOkISQIbzbLxrOxAxShLx3QQUlqSasHz0+xpXS/NHDu6
        6bZoGb6eeFX3+0LakG5Ir3l+tmc4/oq+WaTw+0yn6qWBAQJtpb/D5jXfvsK4ZJWDT9uA8TF9
        wk5kWYfEuIuVTGaGq4f4DDWyNHBX3PuiPHMbORMr7NCWZ/SnVSXG/pFlR+y66G5mb3450jjj
        EiAi5JES79O4TC75Cxc0wldxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7pBdwxjDTon2lhsnLGe1eL6l+es
        FvOPnGO16Nv3n9Gi//FrZovz5zewW5xtesNusenxNVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
        LL1+kcniduMKNos3P84yWbTuPcJu8e/aRhaLzQ+OsTkIeayZt4bRY9OqTjaPzUvqPQ6+28Pk
        0bdlFaPH8RvbmTw+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQy7i95B1rQa9NxaTmDrYGxoUGXYycHBICJhK7HzWwdzFycQgJLGWUeNt5
        hBkiIS3ReHo1E4QtLPHnWhcbRNEnRonX3ZMYQRJsAqoSW2a8ZAexRQSUJSbfm84MUsQs0Mkq
        seLJETaQhLBAoMSNDWtYQWwWoIb+1e/AGngFXCRuNOxkhNggL9G5YzcLiM0p4Crx5eB7sBoh
        oJodK+cxQ9QLSpyc+QSshhmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqX
        rpecn7uJERiX24793LyD8dLG4EOMAhyMSjy8H24ZxgqxJpYVV+YeYpTgYFYS4b39Uj9WiDcl
        sbIqtSg/vqg0J7X4EKMp0BMTmaVEk/OBKSOvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJ
        anZqakFqEUwfEwenVAOjx3qDw+lbZzi0S7vc2ufw/t2ObbOj1Bp7F2cseL6g4zJnSyfflcOp
        V16XnFH6kXRU40BctJjOmoL27UrHeKMuy83ukmp6MM+cO28y67oFK4/dyBdPf93+6djsU76f
        zTZMV37ieymu8LV2u5Apx4s3V9Lyf6b9+5Pk8Tzg2rT55WZzH+xMWdCVrMRSnJFoqMVcVJwI
        AACfewjhAgAA
X-CMS-MailID: 20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e
References: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
        <CGME20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reuse opp core code for setting bus clock and voltage. As a side
effect this allow useage of coupled regulators feature (required
for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
uses regulator_set_voltage_triplet() for setting regulator voltage
while the old code used regulator_set_voltage_tol() with fixed
tolerance. This patch also removes no longer needed parsing of DT
property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
it).

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
 drivers/devfreq/exynos-bus.c | 143 +++++++++--------------------------
 1 file changed, 37 insertions(+), 106 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index f391044aa39d..c2147b0912a0 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 
 #define DEFAULT_SATURATION_RATIO	40
-#define DEFAULT_VOLTAGE_TOLERANCE	2
 
 struct exynos_bus {
 	struct device *dev;
@@ -37,9 +36,9 @@ struct exynos_bus {
 
 	unsigned long curr_freq;
 
-	struct regulator *regulator;
+	struct opp_table *opp_table;
+
 	struct clk *clk;
-	unsigned int voltage_tolerance;
 	unsigned int ratio;
 };
 
@@ -99,56 +98,23 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
 	struct dev_pm_opp *new_opp;
-	unsigned long old_freq, new_freq, new_volt, tol;
 	int ret = 0;
 
-	/* Get new opp-bus instance according to new bus clock */
+	/* Get correct frequency for bus. */
 	new_opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(new_opp)) {
 		dev_err(dev, "failed to get recommended opp instance\n");
 		return PTR_ERR(new_opp);
 	}
 
-	new_freq = dev_pm_opp_get_freq(new_opp);
-	new_volt = dev_pm_opp_get_voltage(new_opp);
 	dev_pm_opp_put(new_opp);
 
-	old_freq = bus->curr_freq;
-
-	if (old_freq == new_freq)
-		return 0;
-	tol = new_volt * bus->voltage_tolerance / 100;
-
 	/* Change voltage and frequency according to new OPP level */
 	mutex_lock(&bus->lock);
+	ret = dev_pm_opp_set_rate(dev, *freq);
+	if (!ret)
+		bus->curr_freq = *freq;
 
-	if (old_freq < new_freq) {
-		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
-		if (ret < 0) {
-			dev_err(bus->dev, "failed to set voltage\n");
-			goto out;
-		}
-	}
-
-	ret = clk_set_rate(bus->clk, new_freq);
-	if (ret < 0) {
-		dev_err(dev, "failed to change clock of bus\n");
-		clk_set_rate(bus->clk, old_freq);
-		goto out;
-	}
-
-	if (old_freq > new_freq) {
-		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
-		if (ret < 0) {
-			dev_err(bus->dev, "failed to set voltage\n");
-			goto out;
-		}
-	}
-	bus->curr_freq = new_freq;
-
-	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
-			old_freq, new_freq, clk_get_rate(bus->clk));
-out:
 	mutex_unlock(&bus->lock);
 
 	return ret;
@@ -195,8 +161,8 @@ static void exynos_bus_exit(struct device *dev)
 		dev_warn(dev, "failed to disable the devfreq-event devices\n");
 
 	clk_disable_unprepare(bus->clk);
-	if (bus->regulator)
-		regulator_disable(bus->regulator);
+	if (bus->opp_table)
+		dev_pm_opp_put_regulators(bus->opp_table);
 
 	dev_pm_opp_of_remove_table(dev);
 }
@@ -209,39 +175,23 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
 	struct dev_pm_opp *new_opp;
-	unsigned long old_freq, new_freq;
-	int ret = 0;
+	int ret;
 
-	/* Get new opp-bus instance according to new bus clock */
+	/* Get correct frequency for bus. */
 	new_opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(new_opp)) {
 		dev_err(dev, "failed to get recommended opp instance\n");
 		return PTR_ERR(new_opp);
 	}
 
-	new_freq = dev_pm_opp_get_freq(new_opp);
 	dev_pm_opp_put(new_opp);
 
-	old_freq = bus->curr_freq;
-
-	if (old_freq == new_freq)
-		return 0;
-
 	/* Change the frequency according to new OPP level */
 	mutex_lock(&bus->lock);
+	ret = dev_pm_opp_set_rate(dev, *freq);
+	if (!ret)
+		bus->curr_freq = *freq;
 
-	ret = clk_set_rate(bus->clk, new_freq);
-	if (ret < 0) {
-		dev_err(dev, "failed to set the clock of bus\n");
-		goto out;
-	}
-
-	*freq = new_freq;
-	bus->curr_freq = new_freq;
-
-	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
-			old_freq, new_freq, clk_get_rate(bus->clk));
-out:
 	mutex_unlock(&bus->lock);
 
 	return ret;
@@ -259,20 +209,9 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 					struct exynos_bus *bus)
 {
 	struct device *dev = bus->dev;
-	int i, ret, count, size;
-
-	/* Get the regulator to provide each bus with the power */
-	bus->regulator = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(bus->regulator)) {
-		dev_err(dev, "failed to get VDD regulator\n");
-		return PTR_ERR(bus->regulator);
-	}
-
-	ret = regulator_enable(bus->regulator);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable VDD regulator\n");
-		return ret;
-	}
+	struct opp_table *opp_table;
+	const char *vdd = "vdd";
+	int i, count, size;
 
 	/*
 	 * Get the devfreq-event devices to get the current utilization of
@@ -281,26 +220,29 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	count = devfreq_event_get_edev_count(dev);
 	if (count < 0) {
 		dev_err(dev, "failed to get the count of devfreq-event dev\n");
-		ret = count;
-		goto err_regulator;
+		return count;
 	}
-	bus->edev_count = count;
 
+	bus->edev_count = count;
 	size = sizeof(*bus->edev) * count;
 	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
-	if (!bus->edev) {
-		ret = -ENOMEM;
-		goto err_regulator;
-	}
+	if (!bus->edev)
+		return -ENOMEM;
 
 	for (i = 0; i < count; i++) {
 		bus->edev[i] = devfreq_event_get_edev_by_phandle(dev, i);
-		if (IS_ERR(bus->edev[i])) {
-			ret = -EPROBE_DEFER;
-			goto err_regulator;
-		}
+		if (IS_ERR(bus->edev[i]))
+			return -EPROBE_DEFER;
+	}
+
+	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
+	if (IS_ERR(opp_table)) {
+		i = PTR_ERR(opp_table);
+		dev_err(dev, "failed to set regulators %d\n", i);
+		return i;
 	}
 
+	bus->opp_table = opp_table;
 	/*
 	 * Optionally, Get the saturation ratio according to Exynos SoC
 	 * When measuring the utilization of each AXI bus with devfreq-event
@@ -314,16 +256,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio))
 		bus->ratio = DEFAULT_SATURATION_RATIO;
 
-	if (of_property_read_u32(np, "exynos,voltage-tolerance",
-					&bus->voltage_tolerance))
-		bus->voltage_tolerance = DEFAULT_VOLTAGE_TOLERANCE;
-
 	return 0;
-
-err_regulator:
-	regulator_disable(bus->regulator);
-
-	return ret;
 }
 
 static int exynos_bus_parse_of(struct exynos_bus *bus)
@@ -414,12 +347,8 @@ static int exynos_bus_probe(struct platform_device *pdev)
 
 	/* Parse the device-tree to get the resource information */
 	ret = exynos_bus_parse_of(bus);
-	if (ret < 0) {
-		if (!passive)
-			regulator_disable(bus->regulator);
-
-		return ret;
-	}
+	if (ret < 0)
+		goto err_reg;
 
 	if (passive)
 		goto passive;
@@ -512,10 +441,12 @@ static int exynos_bus_probe(struct platform_device *pdev)
 
 err:
 	clk_disable_unprepare(bus->clk);
-	if (!passive)
-		regulator_disable(bus->regulator);
-
 	dev_pm_opp_of_remove_table(dev);
+err_reg:
+	if (bus->opp_table) {
+		dev_pm_opp_put_regulators(bus->opp_table);
+		bus->opp_table = NULL;
+	}
 
 	return ret;
 }
-- 
2.22.0

