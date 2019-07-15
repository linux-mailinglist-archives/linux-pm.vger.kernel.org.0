Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B968881
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfGOMEw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 08:04:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46107 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbfGOMEf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 08:04:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715120433euoutp0129260daa59d6d54d4b74f0c12e22ffe1~xkxct_alA2253222532euoutp01E
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2019 12:04:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715120433euoutp0129260daa59d6d54d4b74f0c12e22ffe1~xkxct_alA2253222532euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563192273;
        bh=wndbjJ1PGZSejlhsLUEs9IzljREn8rRVZ05mblcblBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9OaVATTVIFubx1Ahdcr1Arg7SCFRaiaO3JNmnrxKasoytx216nbvHyCdyi3mN7K2
         lGl5greb7aXwxdSXojkBDI+Nd3Aub9IR4FElW+L5XOcoOaWpbNnoW3hHWo9nA5gTNY
         ogp+laOv4KTnP516D+0hosT6jI46yu9A8xPj5TSA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715120432eucas1p22491aa9dd0b2e89269f7ed794beebff4~xkxb49Lv81889618896eucas1p2x;
        Mon, 15 Jul 2019 12:04:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AD.DC.04377.0DB6C2D5; Mon, 15
        Jul 2019 13:04:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715120431eucas1p215eae81d0ca772d7e2a22a803669068a~xkxa5DO6U0930409304eucas1p2_;
        Mon, 15 Jul 2019 12:04:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715120431eusmtrp153a815272cf08d5500d97e7a383ed989~xkxa4bfsc1141411414eusmtrp1U;
        Mon, 15 Jul 2019 12:04:31 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-e6-5d2c6bd0485d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B3.5B.04146.FCB6C2D5; Mon, 15
        Jul 2019 13:04:31 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190715120430eusmtip1e701886891ad21adb6eb3d398c386157~xkxaJlBak2027820278eusmtip1h;
        Mon, 15 Jul 2019 12:04:30 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
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
Subject: [PATCH v2 2/4] devfreq: exynos-bus: convert to use
 dev_pm_opp_set_rate()
Date:   Mon, 15 Jul 2019 14:04:14 +0200
Message-Id: <20190715120416.3561-3-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715120416.3561-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO+ds5zhaHKfhS4bRoqDMsiz6SrNF/hj1o4sQVIhOPamlc+zo
        LCU0S1MpKyUyyxt2sWF5v2QptJZWmrYJZpglmlhq4tiMrprbWZd/z/tcvvd54WNI2aBoCROj
        TuC0alWsXCyhGtu/dfu8Or42xDfdIsU1BVUi/No2JsIlxm4Rzm2bQ/jiyASJe3qqafwyfZLG
        tSN9ItzbckOMrReMCBf0tBH4nnGQxrdemwg8cLpCjCe/viRwRquRxrN9NRSuG2oXK2TKyuJK
        pKzVZ4uVdTdTlY+nHhHK3Ho9Unb0NxFKa63XPvqwJCCSi43Rcdr1gWGSaLNlVKyZ2H2iMzsl
        DT31z0EuDLCbYOLagDgHSRgZW4HAkv+dFgYbgubsQiQMVgQ/9G3En0jpsyIHlrF3EEz3e/xN
        2MoHRXZBzG6B4aYuh8mdXQH5766SdhPJfqOgureGtgtubDBMmQrmAwxDsSuh981ROy1ld0Gm
        odW5bBlkNz+k7NiFDYLm9+204HGF59c+OHhy3nOm4brjfWAtNJhN0yIhHAQtbz85sRuMd9TT
        Al4KnfnnKQEnwWhZLi2EzyIYOmdxCv7wpMPkKEeyq6GqZb1A74ThjO+EnQZ2EfR/dhU6LIK8
        RvuNdloKWZkywe0DxXNdzgaekDN334mV0PDxAX0JLS/875rC/64p/Le3FJF65MEl8nFRHL9R
        zSWt41VxfKI6al1EfFwtmv90nbMdtmbU8jPcgFgGyRdKFZHeITKRSsefjDMgYEi5u3T7zDwl
        jVSdTOa08aHaxFiONyBPhpJ7SFMWDB2RsVGqBO44x2k47R+VYFyWpKFVLq0rqsp/hUycywp/
        4Vuh+HJ3PE9RNjNmSD2kaw3ISN1SVPIhaECTknDFjbOlFQcf9C27nd50arE1NPnY/ZGtdXkb
        Nl/WFGWxDZ+G93pbA6ctFHSFxRw40mY2q/N2RERIdV76rzlh1e4pOj+J1779YXumz/tl4NFt
        mqlnP9Nmo+UUH63asIbU8qrf92svTnADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7rns3ViDdY2SFlsnLGe1eL6l+es
        FvOPnGO16Nv3n9Gi//FrZovz5zewW5xtesNusenxNVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
        LL1+kcniduMKNos3P84yWbTuPcJu8e/aRhaLzQ+OsTkIeayZt4bRY9OqTjaPzUvqPQ6+28Pk
        0bdlFaPH8RvbmTw+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQy7j08SlbwWuvitOd1Q2MR627GDk5JARMJBacmMvUxcjFISSwlFFi8u0z
        bBAJaYnG06uZIGxhiT/Xutggij4xStx7soQRJMEmYC7xaPsZsCIRAWWJyfemM4MUMQt0skqs
        eHIEbJKwQKDE297DrF2MHBwsAqoSl2+mgYR5BZwl2g7thVogL9G5YzcLiM0p4CKx4/4xdhBb
        CKim5VU/C0S9oMTJmU/AbGag+uats5knMArMQpKahSS1gJFpFaNIamlxbnpusaFecWJucWle
        ul5yfu4mRmBMbjv2c/MOxksbgw8xCnAwKvHwOqRoxwqxJpYVV+YeYpTgYFYS4bX9ChTiTUms
        rEotyo8vKs1JLT7EaAr0w0RmKdHkfGC6yCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKa
        nZpakFoE08fEwSnVwDil3UFvUkTZ/95XVzf58vMLfFq3aadkouznCzz1wfKb9t3hvbP+iusb
        q8CXyy+fDRZ2+h35XZ1PfO6OCAOVYunYooRneTYGq//ZPJfM0+jR2mTkpHCmynux/+T3z1OW
        iCxOXHH6yK6t8iUn13paiUyNt/bUcrDYpxo2R+3/g/ntXbcipk+y3qnEUpyRaKjFXFScCABz
        OpIm3wIAAA==
X-CMS-MailID: 20190715120431eucas1p215eae81d0ca772d7e2a22a803669068a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715120431eucas1p215eae81d0ca772d7e2a22a803669068a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715120431eucas1p215eae81d0ca772d7e2a22a803669068a
References: <20190715120416.3561-1-k.konieczny@partner.samsung.com>
        <CGME20190715120431eucas1p215eae81d0ca772d7e2a22a803669068a@eucas1p2.samsung.com>
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
 drivers/devfreq/exynos-bus.c | 172 ++++++++++++++---------------------
 1 file changed, 66 insertions(+), 106 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 486cc5b422f1..7fc4f76bd848 100644
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
 
@@ -99,56 +98,25 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
 	struct dev_pm_opp *new_opp;
-	unsigned long old_freq, new_freq, new_volt, tol;
 	int ret = 0;
-
-	/* Get new opp-bus instance according to new bus clock */
+	/*
+	 * New frequency for bus may not be exactly matched to opp, adjust
+	 * *freq to correct value.
+	 */
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
@@ -194,10 +162,11 @@ static void exynos_bus_exit(struct device *dev)
 	if (ret < 0)
 		dev_warn(dev, "failed to disable the devfreq-event devices\n");
 
-	if (bus->regulator)
-		regulator_disable(bus->regulator);
+	if (bus->opp_table)
+		dev_pm_opp_put_regulators(bus->opp_table);
 
 	dev_pm_opp_of_remove_table(dev);
+
 	clk_disable_unprepare(bus->clk);
 }
 
@@ -209,39 +178,26 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
 	struct dev_pm_opp *new_opp;
-	unsigned long old_freq, new_freq;
-	int ret = 0;
+	int ret;
 
-	/* Get new opp-bus instance according to new bus clock */
+	/*
+	 * New frequency for bus may not be exactly matched to opp, adjust
+	 * *freq to correct value.
+	 */
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
@@ -259,20 +215,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
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
+	int i, count, size;
 
 	/*
 	 * Get the devfreq-event devices to get the current utilization of
@@ -281,24 +224,20 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	count = devfreq_event_get_edev_count(dev);
 	if (count < 0) {
 		dev_err(dev, "failed to get the count of devfreq-event dev\n");
-		ret = count;
-		goto err_regulator;
+		return count;
 	}
+
 	bus->edev_count = count;
 
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
 	}
 
 	/*
@@ -314,22 +253,15 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
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
 
 static int exynos_bus_parse_of(struct device_node *np,
-			      struct exynos_bus *bus)
+			      struct exynos_bus *bus, bool passive)
 {
 	struct device *dev = bus->dev;
+	struct opp_table *opp_table;
+	const char *vdd = "vdd";
 	struct dev_pm_opp *opp;
 	unsigned long rate;
 	int ret;
@@ -347,11 +279,22 @@ static int exynos_bus_parse_of(struct device_node *np,
 		return ret;
 	}
 
+	if (!passive) {
+		opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
+		if (IS_ERR(opp_table)) {
+			ret = PTR_ERR(opp_table);
+			dev_err(dev, "failed to set regulators %d\n", ret);
+			goto err_clk;
+		}
+
+		bus->opp_table = opp_table;
+	}
+
 	/* Get the freq and voltage from OPP table to scale the bus freq */
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to get OPP table\n");
-		goto err_clk;
+		goto err_regulator;
 	}
 
 	rate = clk_get_rate(bus->clk);
@@ -362,6 +305,7 @@ static int exynos_bus_parse_of(struct device_node *np,
 		ret = PTR_ERR(opp);
 		goto err_opp;
 	}
+
 	bus->curr_freq = dev_pm_opp_get_freq(opp);
 	dev_pm_opp_put(opp);
 
@@ -369,6 +313,13 @@ static int exynos_bus_parse_of(struct device_node *np,
 
 err_opp:
 	dev_pm_opp_of_remove_table(dev);
+
+err_regulator:
+	if (bus->opp_table) {
+		dev_pm_opp_put_regulators(bus->opp_table);
+		bus->opp_table = NULL;
+	}
+
 err_clk:
 	clk_disable_unprepare(bus->clk);
 
@@ -386,6 +337,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	struct exynos_bus *bus;
 	int ret, max_state;
 	unsigned long min_freq, max_freq;
+	bool passive = false;
 
 	if (!np) {
 		dev_err(dev, "failed to find devicetree node\n");
@@ -395,12 +347,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
 	if (!bus)
 		return -ENOMEM;
+
 	mutex_init(&bus->lock);
 	bus->dev = &pdev->dev;
 	platform_set_drvdata(pdev, bus);
+	node = of_parse_phandle(dev->of_node, "devfreq", 0);
+	if (node) {
+		of_node_put(node);
+		passive = true;
+	}
 
 	/* Parse the device-tree to get the resource information */
-	ret = exynos_bus_parse_of(np, bus);
+	ret = exynos_bus_parse_of(np, bus, passive);
 	if (ret < 0)
 		return ret;
 
@@ -410,13 +368,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	node = of_parse_phandle(dev->of_node, "devfreq", 0);
-	if (node) {
-		of_node_put(node);
+	if (passive)
 		goto passive;
-	} else {
-		ret = exynos_bus_parent_parse_of(np, bus);
-	}
+
+	ret = exynos_bus_parent_parse_of(np, bus);
 
 	if (ret < 0)
 		goto err;
@@ -509,6 +464,11 @@ static int exynos_bus_probe(struct platform_device *pdev)
 
 err:
 	dev_pm_opp_of_remove_table(dev);
+	if (bus->opp_table) {
+		dev_pm_opp_put_regulators(bus->opp_table);
+		bus->opp_table = NULL;
+	}
+
 	clk_disable_unprepare(bus->clk);
 
 	return ret;
-- 
2.22.0

