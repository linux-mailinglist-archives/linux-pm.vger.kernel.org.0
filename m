Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74784D99
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 15:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbfHGNjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 09:39:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58139 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388452AbfHGNi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 09:38:59 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190807133858euoutp01f37761a663b530b29d85b90ddf81c3e2~4p5c7jFzu2498324983euoutp017
        for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2019 13:38:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190807133858euoutp01f37761a663b530b29d85b90ddf81c3e2~4p5c7jFzu2498324983euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565185138;
        bh=CjwZyowP2SyGv4qfE/HxF+yoeTjTHLNxjLACzBKukg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqZTuv1CcWRC8/YCOLDcc/C+XeqiIdIZ9/Ubs1H+88Wji6XYvFjQUexJoiZVkeaQv
         1iRdPPzeUjtQauWnJEKIx8ZxZlggS6Bw/SNKAT9n0K++6mOQIVKGt5SK4Y8rH9vsf2
         cxCIhIAhpIs7RzkDWYdEUa6V4zqJFDYb2Ua7nm8c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190807133857eucas1p21a53d364906d342b94849ed7fa78e5eb~4p5cLVJC11098810988eucas1p2J;
        Wed,  7 Aug 2019 13:38:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7E.19.04309.174DA4D5; Wed,  7
        Aug 2019 14:38:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190807133856eucas1p2a893cd24096b089307e4216a1033a742~4p5bT0yde1099710997eucas1p2q;
        Wed,  7 Aug 2019 13:38:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190807133856eusmtrp2f02b70f236ecc6e971a43f8c3fc3e8d6~4p5bFhwWl0146501465eusmtrp2E;
        Wed,  7 Aug 2019 13:38:56 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-a8-5d4ad471ec33
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DB.0F.04117.074DA4D5; Wed,  7
        Aug 2019 14:38:56 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190807133855eusmtip2f1ea21a25bffbbee728eb421bb70d871~4p5aYMd4m1919719197eusmtip2c;
        Wed,  7 Aug 2019 13:38:55 +0000 (GMT)
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
Subject: [PATCH v5 1/4] devfreq: exynos-bus: correct clock enable sequence
Date:   Wed,  7 Aug 2019 15:38:35 +0200
Message-Id: <20190807133838.14678-2-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807133838.14678-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djP87qFV7xiDTZtErXYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB7FZZOSmpNZllqkb5fAlbFn+wyWgtuiFbN2hDQwnhfsYuTkkBAw
        kfh4ZylrFyMXh5DACkaJLw8XskE4XxglVszfwgLhfGaU+HrpPStMy/lpT5khEssZJV533mCF
        a7l5cjsbSBWbgKrElhkv2UFsEQFlicn3poN1MAv8ZJHYcHkjWEJYwEuiafI3MJsFqOHh5rdg
        Nq+Ai8ShWaeYIdbJS3Tu2M0CYnMKuEp83TuBEaJGUOLkzCdgcWagmuats8EWSAi8ZZc4dv40
        O0Szi8TCtm5GCFtY4tXxLVBxGYn/O+czQdjlEk8X9rFDNLcwSjxo/8gCkbCWOHz8ItBvHEAb
        NCXW79IHMSUEHCUerY2DMPkkbrwVhDiBT2LSNpAfQcK8Eh1tQhAzdCXm/T8DDThpia7/66Bs
        D4mnj06xTmBUnIXkmVlInpmFsHYBI/MqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwFR3
        +t/xLzsYd/1JOsQowMGoxMPLcMErVog1say4MvcQowQHs5II770yz1gh3pTEyqrUovz4otKc
        1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjKH7637t70jI65Z88SmJhzfLxLtE
        NNdI6BlDT3RbhemVvT8XO4f+fBglJREtKuDqccbqSkiH5/dXpft3bRKqD3O4/3/iG869i+/2
        F2beW9bKktEVWOqY991dM4Wb495C53Oz1riG7NW4K9g9c80r46SG0l7XqTGccr82KdxSmZEu
        xhuZfTZZiaU4I9FQi7moOBEAdXTNnnEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7oFV7xiDTr2yFpsnLGe1eL6l+es
        FvOPnGO16Nv3n9Gi//FrZovz5zewW5xtesNusenxNVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
        LL1+kcniduMKNos3P84yWbTuPcJu8e/aRhaLzQ+OsTkIeayZt4bRY9OqTjaPzUvqPQ6+28Pk
        0bdlFaPH8RvbmTw+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQy9izfQZLwW3Rilk7QhoYzwt2MXJySAiYSJyf9pS5i5GLQ0hgKaPEj6ZT
        jBAJaYnG06uZIGxhiT/Xutggij4xSty8dR6siE1AVWLLjJfsILaIgLLE5HvTwSYxC3SySqx4
        coQNJCEs4CXRNPkbWBELUMPDzW/BbF4BF4lDs04xQ2yQl+jcsZsFxOYUcJX4uncC2AIhoJpF
        BzcyQdQLSpyc+QSshhmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKRXnJhbXJqXrpec
        n7uJERiV24793LKDsetd8CFGAQ5GJR5ehgtesUKsiWXFlbmHGCU4mJVEeO+VecYK8aYkVlal
        FuXHF5XmpBYfYjQFemIis5Rocj4wYeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5N
        LUgtgulj4uCUamC0EazqmvLl+4JuGYEL3P/D3vc9Wfrpkj9TtFhQB69ml3LsItE9/PMZJRV5
        zyR5VwTNOmny636Xjeed1N9rLpRILrU7JXn119dDaTYLoitKGRwrdvo+0/WYv+63h2jffYuo
        2BOTj94XemCc1VPuHHe9x1vCfcm5t8cz+wIVNcX2FNtk69f+uavEUpyRaKjFXFScCADdVKh0
        4AIAAA==
X-CMS-MailID: 20190807133856eucas1p2a893cd24096b089307e4216a1033a742
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190807133856eucas1p2a893cd24096b089307e4216a1033a742
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190807133856eucas1p2a893cd24096b089307e4216a1033a742
References: <20190807133838.14678-1-k.konieczny@partner.samsung.com>
        <CGME20190807133856eucas1p2a893cd24096b089307e4216a1033a742@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Regulators should be enabled before clocks to avoid h/w hang. This
require change in exynos_bus_probe() to move exynos_bus_parse_of()
after exynos_bus_parent_parse_of() and change in error handling.
Similar change is needed in exynos_bus_exit() where clock should be
disabled before regulators.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes:
v5:
- added Acked-by tag
v4:
- move regulator disable after clock disable
- remove unrelated changes
- add disabling regulators in error path in exynos_bus_probe()

---
 drivers/devfreq/exynos-bus.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 486cc5b422f1..f34fa26f00d0 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -194,11 +194,10 @@ static void exynos_bus_exit(struct device *dev)
 	if (ret < 0)
 		dev_warn(dev, "failed to disable the devfreq-event devices\n");
 
-	if (bus->regulator)
-		regulator_disable(bus->regulator);
-
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
+	if (bus->regulator)
+		regulator_disable(bus->regulator);
 }
 
 /*
@@ -386,6 +385,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	struct exynos_bus *bus;
 	int ret, max_state;
 	unsigned long min_freq, max_freq;
+	bool passive = false;
 
 	if (!np) {
 		dev_err(dev, "failed to find devicetree node\n");
@@ -399,27 +399,27 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	bus->dev = &pdev->dev;
 	platform_set_drvdata(pdev, bus);
 
-	/* Parse the device-tree to get the resource information */
-	ret = exynos_bus_parse_of(np, bus);
-	if (ret < 0)
-		return ret;
-
 	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
-	if (!profile) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!profile)
+		return -ENOMEM;
 
 	node = of_parse_phandle(dev->of_node, "devfreq", 0);
 	if (node) {
 		of_node_put(node);
-		goto passive;
+		passive = true;
 	} else {
 		ret = exynos_bus_parent_parse_of(np, bus);
+		if (ret < 0)
+			return ret;
 	}
 
+	/* Parse the device-tree to get the resource information */
+	ret = exynos_bus_parse_of(np, bus);
 	if (ret < 0)
-		goto err;
+		goto err_reg;
+
+	if (passive)
+		goto passive;
 
 	/* Initialize the struct profile and governor data for parent device */
 	profile->polling_ms = 50;
@@ -510,6 +510,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
 err:
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
+err_reg:
+	if (!passive)
+		regulator_disable(bus->regulator);
 
 	return ret;
 }
-- 
2.22.0

