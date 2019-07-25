Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF7D975183
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbfGYOnb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 10:43:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41887 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbfGYOnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 10:43:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190725144329euoutp0291a09cf2513ae5dcde3e536dc9224e72~0rZE7eaWl1229012290euoutp02q
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 14:43:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190725144329euoutp0291a09cf2513ae5dcde3e536dc9224e72~0rZE7eaWl1229012290euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564065809;
        bh=Ez/2lzRMCN6NYZ3shai8lT9fBiOe6bECqNjf1prjnCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTEG5QgvwTIn1g0GOSty/TacUPIcbv3PObP1o+vt6wn93gOiZbY+5MuHIOry8CtSm
         DDaMQ2eOfg+45eA2wISzUo3sPVWIN4pVThtuNOCkjZXoQERvb7KKAB7e0gM/yLpvQy
         96Aco2O1r3epLY5i14uy4EB0jXpBtLiLWEaKCqHg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190725144329eucas1p163aba4ebd10cc83e128eed6d203b7179~0rZEJYqdz1363913639eucas1p1n;
        Thu, 25 Jul 2019 14:43:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.CA.04377.010C93D5; Thu, 25
        Jul 2019 15:43:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190725144328eucas1p1e16c826c18c79af8f9c7283a896266a6~0rZDanIGf0147401474eucas1p1F;
        Thu, 25 Jul 2019 14:43:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190725144328eusmtrp1a5fc98181a4d56eaceea38f4e1307752~0rZDMah3m0724307243eusmtrp1I;
        Thu, 25 Jul 2019 14:43:28 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-9c-5d39c010631d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 32.3E.04146.F00C93D5; Thu, 25
        Jul 2019 15:43:27 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190725144327eusmtip121f6b8fce50ae8e3f4098bf36862baac~0rZCZ9l5S0146301463eusmtip1n;
        Thu, 25 Jul 2019 14:43:27 +0000 (GMT)
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
Subject: [PATCH v4 5/5] devfreq: exynos-bus: remove
 exynos_bus_passive_target()
Date:   Thu, 25 Jul 2019 16:43:00 +0200
Message-Id: <20190725144300.25014-6-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190725144300.25014-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djPc7oCByxjDR591LHYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB7FZZOSmpNZllqkb5fAlTF9nn/Bd8GKq2fKGhg/8HUxcnJICJhI
        fJo3l7GLkYtDSGAFo8Su11PYIZwvjBIdD46yQjifGSV+XlvECNPy9N1NqJbljBL3js5FaJm3
        9iwLSBWbgKrElhkv2UFsEQFlicn3pjODFDEL/GSR2HB5I1hCWCBQ4u2292ANLEANxy/+ZgKx
        eQVcJD583Qi1Tl6ic8dusBpOAVeJv41rGSFqBCVOznwCFmcGqmneOpsZov4tu8SyKWkQtotE
        29o2VghbWOLV8S3sELaMxOnJPSwQdrnE04V9YB9ICLQwSjxo/wiVsJY4fPwiUDMH0AJNifW7
        9EFMCQFHidN7mCFMPokbbwUhLuCTmLRtOlSYV6KjTQhihq7EvP9noA6Qluj6vw7K9pC4/a+V
        aQKj4iwkv8xC8ssshLULGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKa50/+Of9nB
        uOtP0iFGAQ5GJR5ejVWWsUKsiWXFlbmHGCU4mJVEeLfuAArxpiRWVqUW5ccXleakFh9ilOZg
        URLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpgTJD7+EPD4O66CLlHj5/el//A+ujBTS7B9Q9z
        pc4dnONz25nb5n9G+Buj49IZB1iCKh7P/mT+6ITQHl/DUDdDWfO4Bf78XcsrT4ie3V62wfDM
        h4jivxcc3Ti3ij/XU01da640fyejT3rX5IgD3De2Ji49n/+44njWnUqeJJn5rtfWnzm81SXj
        lhJLcUaioRZzUXEiAAK7CRFvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7r8ByxjDfbuMLfYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5eglzF9nn/Bd8GKq2fKGhg/8HUxcnJICJhIPH13kxHEFhJYyihx54g5RFxa
        ovH0aiYIW1jiz7Uuti5GLqCaT4wSm6f9AmtgE1CV2DLjJTuILSKgLDH53nRmkCJmgU5WiRVP
        jrCBJIQF/CU2XjkLNokFqOH4xd9gNq+Ai8SHrxsZITbIS3Tu2M0CYnMKuEr8bVwLdZGLRGP/
        MUaIekGJkzOfgNUwA9U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNz
        NzECI3LbsZ+bdzBe2hh8iFGAg1GJh/fCcstYIdbEsuLK3EOMEhzMSiK8W3cAhXhTEiurUovy
        44tKc1KLDzGaAj0xkVlKNDkfmCzySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphak
        FsH0MXFwSjUwhhV98FsWeuBalaGP+JXD5jenLe04GPzQ+OP95j+3UzWt/6RPfsT/Pm/6x6R1
        yyMeOs289/7Hm8i9VU3W6wQyV50+lPe9/tbmXVfPc19+FrOWc9/+5b8if/23nv6YOe5tkHSH
        eFLVZQc9ThGtL7wHzsm9qnW4YR75Y8ODtyxPGS/dCkjunTH30yUlluKMREMt5qLiRABvQ0sS
        3gIAAA==
X-CMS-MailID: 20190725144328eucas1p1e16c826c18c79af8f9c7283a896266a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190725144328eucas1p1e16c826c18c79af8f9c7283a896266a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190725144328eucas1p1e16c826c18c79af8f9c7283a896266a6
References: <20190725144300.25014-1-k.konieczny@partner.samsung.com>
        <CGME20190725144328eucas1p1e16c826c18c79af8f9c7283a896266a6@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Both functions exynos_bus_passive_target() and exynos_bus_target()
have the same code, so remove exynos_bus_passive_target(). In
exynos_bus_probe() replace it with exynos_bus_target.

Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
This patch is new to this series.

---
 drivers/devfreq/exynos-bus.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index ebb8f46312b6..2aeb6cc07960 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -91,7 +91,7 @@ static int exynos_bus_get_event(struct exynos_bus *bus,
 }
 
 /*
- * Must necessary function for devfreq simple-ondemand governor
+ * devfreq function for both simple-ondemand and passive governor
  */
 static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
 {
@@ -167,36 +167,6 @@ static void exynos_bus_exit(struct device *dev)
 	}
 }
 
-/*
- * Must necessary function for devfreq passive governor
- */
-static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
-					u32 flags)
-{
-	struct exynos_bus *bus = dev_get_drvdata(dev);
-	struct dev_pm_opp *new_opp;
-	int ret;
-
-	/* Get correct frequency for bus. */
-	new_opp = devfreq_recommended_opp(dev, freq, flags);
-	if (IS_ERR(new_opp)) {
-		dev_err(dev, "failed to get recommended opp instance\n");
-		return PTR_ERR(new_opp);
-	}
-
-	dev_pm_opp_put(new_opp);
-
-	/* Change the frequency according to new OPP level */
-	mutex_lock(&bus->lock);
-	ret = dev_pm_opp_set_rate(dev, *freq);
-	if (!ret)
-		bus->curr_freq = *freq;
-
-	mutex_unlock(&bus->lock);
-
-	return ret;
-}
-
 static void exynos_bus_passive_exit(struct device *dev)
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
@@ -417,7 +387,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	goto out;
 passive:
 	/* Initialize the struct profile and governor data for passive device */
-	profile->target = exynos_bus_passive_target;
+	profile->target = exynos_bus_target;
 	profile->exit = exynos_bus_passive_exit;
 
 	/* Get the instance of parent devfreq device */
-- 
2.22.0

