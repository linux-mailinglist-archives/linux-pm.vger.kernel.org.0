Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C4C85DB3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 11:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfHHJCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 05:02:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39082 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731832AbfHHJCy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 05:02:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190808090253euoutp02468dbf212fad28bb38e41655d5cc7fbc~45xrbHKuY2175421754euoutp02R
        for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2019 09:02:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190808090253euoutp02468dbf212fad28bb38e41655d5cc7fbc~45xrbHKuY2175421754euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565254973;
        bh=8p/HTcqBHaFPFPbW+xiVQwlLgZVWfwtAhuOxNymIERk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvrGtzMP/2ayrO5MeXygbZVRK6Fpav2rIvsedis0LM8jdIJJk/hLfKFmDqsj4ORF9
         DbYkdVbV5A6VnmXDAnUSbGIsW/zcR/mZj+vhNMD5Em2Onui0ymEdl+s1VhvQKSTivx
         qyfACjGNUdl8exELCwljLbR9hW3Rbk/2y3FRVqrU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190808090252eucas1p206095ba775fec95814dee3c899894099~45xqoev942306123061eucas1p2L;
        Thu,  8 Aug 2019 09:02:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9E.DE.04374.B35EB4D5; Thu,  8
        Aug 2019 10:02:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190808090251eucas1p13df8d776727210a353709405a95f9525~45xpqdnVL0879608796eucas1p16;
        Thu,  8 Aug 2019 09:02:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808090250eusmtrp26248138620f8061c9257f639140005a9~45xpcXTuh0889008890eusmtrp2_;
        Thu,  8 Aug 2019 09:02:50 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-ee-5d4be53b65ae
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0F.A1.04117.A35EB4D5; Thu,  8
        Aug 2019 10:02:50 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190808090250eusmtip2c2b8e8804a447e6021fd60f071fe2e76~45xor407X3179331793eusmtip2x;
        Thu,  8 Aug 2019 09:02:50 +0000 (GMT)
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
Subject: [RESEND PATCH v5 2/4] devfreq: exynos-bus: convert to use
 dev_pm_opp_set_rate()
Date:   Thu,  8 Aug 2019 11:02:32 +0200
Message-Id: <20190808090234.12577-3-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808090234.12577-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURTHuzOzM+PWxjhaXTR6rPTBQO1F3jSiQmF6QUEQKGJrDmr5asd1
        swJNe7mWmgqZmm6UZT6yXR/rW7PNzXxhhq1YKZlmtSqiUUJo7o6R337nnP85538ul8bZDxIn
        OiwyhldGKsLlpJSobpvrcfMePRKwbXbQE+myyyXo/exXCSowdktQatMCQGkjP3DU0/OcQl2J
        FgrpR/olqK8uj0Qzt40AZfc0YajM+JFChe97MTR4pYhElt9dGLrWaKTQfL+OQBXDbeR+livN
        LwWcvjiZ5CoexXMvJhswLrWyGHAmswHjZvQbjlN+0r3BfHhYLK/02HdaGqrVjWDRpj0XtNp3
        ZAKYdtcAmobMLlibEaQBUppligC8W59NiMEsgFOTOUAMZgBMNhslGmBn6xjqT7ExyzwBMElD
        iLzY8fYOZmWS8YSfDZ02dmRcYOanu7h1EM7MEfB5n46yrnZg/GDJEGvVEMwW2JFpsM2UMT5w
        2HIfF3dthMk19bb5dowvLCtuJ0SNPWy/98XG+KImqSrXNh8yExRszEpcMuoDU8aGltgBfjdV
        UiKvhwu1BZjIajj6IJUSm68COHxjmhAL3vClqVdiNYozrrC8zkNMH4BjpiRMfLrV0DxhL3pY
        DTOqrTda0zJ48zorqt1g/kLnkgNnqFl4tsQcnB2wkOlgc86ya3KWXZPzf68W4MVgHa8SIkJ4
        YWckr3YXFBGCKjLE/UxUhB4s/rmOedPPGtD0J6gVMDSQr5K9fnMkgJUoYoW4iFYAaVzuKPsU
        eyiAlQUr4i7yyqhApSqcF1qBM03I18kurRj2Z5kQRQx/juejeeW/KkbbOSWAE2c7TpFTx8av
        t4z6vypXfU2KsffKH1MZXLry5tVmymu/fM14XPKLAY7KiAkUYqXqlQ6huc07Js1pfQ3Kiej5
        k4Mexl+WAunBxzXalsNr+wurnM4X7g7MHKiLN6qA1NO0q1l9OX2rwevpgU0rDVGuDx2/nQ31
        vdSdpUjJP3qrqUROCKGK7VtxpaD4C2oiQjZvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7pWT71jDZZsNLbYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl7Fg42OmguOWFQsWXGFrYPyo18XIySEhYCJx/1o3axcjF4eQwFJGifNb
        FrFBJKQlGk+vZoKwhSX+XOtigyj6xCjxftdKZpAEm4C5xKPtZ8CKRASUJSbfm84MUsQs0Mkq
        seLJEbBJwgIREgu/PgezWQRUJU5P3s4KYvMKuEg8eDOXGWKDvETnjt0sIDangKvE2lUnwWwh
        oJqN769D1QtKnJz5BCzODFTfvHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy020itOzC0uzUvX
        S87P3cQIjMttx35u2cHY9S74EKMAB6MSD2/BCe9YIdbEsuLK3EOMEhzMSiK898o8Y4V4UxIr
        q1KL8uOLSnNSiw8xmgI9MZFZSjQ5H5gy8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRm
        p6YWpBbB9DFxcEo1MDI6VXFsnq255b+em/LTK8cKC7wNtv2eqX/i2FH9CuuISTf+z7H8PtWM
        d7fb3CYByTu7QgtWVQtVhgS0Hfv2fleqmn+Dn8XxC1vZN2sZLOZqj55yT7tm0u6XqYcqIs+p
        blg8Z/Vp/v6qRetteJWVyhVL+L0Sp2fHGcmF1O/4skFLr//mz8w595VYijMSDbWYi4oTAWgC
        gxLhAgAA
X-CMS-MailID: 20190808090251eucas1p13df8d776727210a353709405a95f9525
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808090251eucas1p13df8d776727210a353709405a95f9525
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808090251eucas1p13df8d776727210a353709405a95f9525
References: <20190808090234.12577-1-k.konieczny@partner.samsung.com>
        <CGME20190808090251eucas1p13df8d776727210a353709405a95f9525@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reuse opp core code for setting bus clock and voltage. As a side
effect this allow usage of coupled regulators feature (required
for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
uses regulator_set_voltage_triplet() for setting regulator voltage
while the old code used regulator_set_voltage_tol() with fixed
tolerance. This patch also removes no longer needed parsing of DT
property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
it). After applying changes both functions exynos_bus_passive_target()
and exynos_bus_target() have the same code, so remove
exynos_bus_passive_target(). In exynos_bus_probe() replace it with
exynos_bus_target.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes:
v5:
- squashed last patch into this one, as suggested by Chanwoo Choi
v4:
- remove unrelated changes, add newline before comment

---
 drivers/devfreq/exynos-bus.c | 130 +++++++----------------------------
 1 file changed, 24 insertions(+), 106 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index f34fa26f00d0..2aeb6cc07960 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 
 #define DEFAULT_SATURATION_RATIO	40
-#define DEFAULT_VOLTAGE_TOLERANCE	2
 
 struct exynos_bus {
 	struct device *dev;
@@ -37,9 +36,8 @@ struct exynos_bus {
 
 	unsigned long curr_freq;
 
-	struct regulator *regulator;
+	struct opp_table *opp_table;
 	struct clk *clk;
-	unsigned int voltage_tolerance;
 	unsigned int ratio;
 };
 
@@ -93,62 +91,29 @@ static int exynos_bus_get_event(struct exynos_bus *bus,
 }
 
 /*
- * Must necessary function for devfreq simple-ondemand governor
+ * devfreq function for both simple-ondemand and passive governor
  */
 static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
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
@@ -196,54 +161,10 @@ static void exynos_bus_exit(struct device *dev)
 
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
-	if (bus->regulator)
-		regulator_disable(bus->regulator);
-}
-
-/*
- * Must necessary function for devfreq passive governor
- */
-static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
-					u32 flags)
-{
-	struct exynos_bus *bus = dev_get_drvdata(dev);
-	struct dev_pm_opp *new_opp;
-	unsigned long old_freq, new_freq;
-	int ret = 0;
-
-	/* Get new opp-bus instance according to new bus clock */
-	new_opp = devfreq_recommended_opp(dev, freq, flags);
-	if (IS_ERR(new_opp)) {
-		dev_err(dev, "failed to get recommended opp instance\n");
-		return PTR_ERR(new_opp);
-	}
-
-	new_freq = dev_pm_opp_get_freq(new_opp);
-	dev_pm_opp_put(new_opp);
-
-	old_freq = bus->curr_freq;
-
-	if (old_freq == new_freq)
-		return 0;
-
-	/* Change the frequency according to new OPP level */
-	mutex_lock(&bus->lock);
-
-	ret = clk_set_rate(bus->clk, new_freq);
-	if (ret < 0) {
-		dev_err(dev, "failed to set the clock of bus\n");
-		goto out;
+	if (bus->opp_table) {
+		dev_pm_opp_put_regulators(bus->opp_table);
+		bus->opp_table = NULL;
 	}
-
-	*freq = new_freq;
-	bus->curr_freq = new_freq;
-
-	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
-			old_freq, new_freq, clk_get_rate(bus->clk));
-out:
-	mutex_unlock(&bus->lock);
-
-	return ret;
 }
 
 static void exynos_bus_passive_exit(struct device *dev)
@@ -258,21 +179,19 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 					struct exynos_bus *bus)
 {
 	struct device *dev = bus->dev;
+	struct opp_table *opp_table;
+	const char *vdd = "vdd";
 	int i, ret, count, size;
 
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
+	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		dev_err(dev, "failed to set regulators %d\n", ret);
 		return ret;
 	}
 
+	bus->opp_table = opp_table;
+
 	/*
 	 * Get the devfreq-event devices to get the current utilization of
 	 * buses. This raw data will be used in devfreq ondemand governor.
@@ -313,14 +232,11 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio))
 		bus->ratio = DEFAULT_SATURATION_RATIO;
 
-	if (of_property_read_u32(np, "exynos,voltage-tolerance",
-					&bus->voltage_tolerance))
-		bus->voltage_tolerance = DEFAULT_VOLTAGE_TOLERANCE;
-
 	return 0;
 
 err_regulator:
-	regulator_disable(bus->regulator);
+	dev_pm_opp_put_regulators(bus->opp_table);
+	bus->opp_table = NULL;
 
 	return ret;
 }
@@ -471,7 +387,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	goto out;
 passive:
 	/* Initialize the struct profile and governor data for passive device */
-	profile->target = exynos_bus_passive_target;
+	profile->target = exynos_bus_target;
 	profile->exit = exynos_bus_passive_exit;
 
 	/* Get the instance of parent devfreq device */
@@ -511,8 +427,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
 err_reg:
-	if (!passive)
-		regulator_disable(bus->regulator);
+	if (!passive) {
+		dev_pm_opp_put_regulators(bus->opp_table);
+		bus->opp_table = NULL;
+	}
 
 	return ret;
 }
-- 
2.22.0

