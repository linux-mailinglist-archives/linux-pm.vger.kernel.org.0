Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB8F1E7D9B
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 14:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgE2Mty (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 08:49:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47352 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgE2Mtx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 08:49:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200529124952euoutp01a446da4347ba41245b39d888f5e87e9d~TgLE9h-qK2628826288euoutp01E
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 12:49:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200529124952euoutp01a446da4347ba41245b39d888f5e87e9d~TgLE9h-qK2628826288euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590756592;
        bh=vKKWXKKZb66zmci3zWOPhnbVvCuDMc0NgqWOz9mv0L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/GOIXWCzfxFJWcqgWt92wZLQ7QDwjbSdd9q6+dzA7IGFdBlF3UgZUHhBd8k+WpDR
         BuEclZUeWTvwT6NRzgCaHFOG1ZPUCseCXaYfLONSaTOaRfk54u9Jjtc4dMpY7bcg56
         7TSPPW+gx8S0Js/mKmW/Ua4G12f5koksTkfeHspE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200529124951eucas1p16fbbb10363ae6c91a4f31486602e7f78~TgLEY6YrO2815328153eucas1p1j;
        Fri, 29 May 2020 12:49:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 33.74.60698.FE401DE5; Fri, 29
        May 2020 13:49:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200529124951eucas1p213c748fb481a37cf98918caae5e30fd2~TgLEGbgkg2891728917eucas1p2K;
        Fri, 29 May 2020 12:49:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529124951eusmtrp185582db9a7f4f002a908e706edc6df9c~TgLEFnqxP1703417034eusmtrp1B;
        Fri, 29 May 2020 12:49:51 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-f2-5ed104ef29f1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B4.80.08375.FE401DE5; Fri, 29
        May 2020 13:49:51 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529124950eusmtip135d1e103b2e67c978b9fc874ab56cba6~TgLDPzqUl1155411554eusmtip1J;
        Fri, 29 May 2020 12:49:50 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/2] regulator: extract voltage balancing code to the
 separate function
Date:   Fri, 29 May 2020 14:49:39 +0200
Message-Id: <20200529124940.10675-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529124940.10675-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTURT1dabTobE4VCMvLoglSCQqGNQ817gzX8TghxG1WmUEIi2mAyhE
        Da7URlAxKFQ0QDRIEYFSKhoXqA2NVNtStBSxBGLdIYoFXAFtB/Xv3HPuuefel0di4jv8aWSK
        Ip1RKmSpEkKIG1q+W+d/wtuk0QNtM1BdUQ0fFfZ6CNQx+JaPqgZeAWSz1QpQz5VOHhp+puKh
        9rslBPLmmQAqsj3goWqTW4D6vj3loa6r7Th6YnHw0aizDkcq0zCG6obo1UH0HY1bQOu0pwn6
        pfMeQZ8diab1z3NxOl+vBbTZdZtHe3Uhm8gE4YpEJjUlk1FGrdolTD75TLw/P+TgsTwblgNc
        UA0CSEgtgu+6mzA1EJJi6gaAnZ8e83yCmBoEsOZaPCd4AbyZc4lQA9Lv0JbLOb4CQI19lOCK
        P4a+smbgcxPUQqjuV/uFKdRRABtK7f6xGPUTg/fbZvvwZGorzP06hPkwToVDd6vNj0XUStja
        6AXcfrNgVW2Tnw+gVkGnwwh8QyFlFcDm529wrmk99KrKxvFk+MGsF3B4BrRcOINzhuMA9lqr
        BVxxBsD2Y0XjEcvhS+sP/3EYNRfW3I3i6DXw8odfAu7mQOjqD+IOCIQFhksYR4ug6pSY654D
        NeZb/2Kb7Y7xFhqO5M/kHug8gG6biTgHZmn+Z5UCoAXBTAYrT2LYGAVzYAErk7MZiqQFe9Lk
        OvDnQ1lGzUON4MGv3UZAkUAyUVRbbJOK+bJMNktuBJDEJFNEa59apGJRoiwrm1Gm7VRmpDKs
        EUwncUmwKKb8/Q4xlSRLZ/YxzH5G+VflkQHTckDu7uxYjyVGcaTnYsJG0ViHRB66ZVlxcFj4
        2Od1a187w760Nnw+HN1dGdpVjy/NeVFwSOdclodj2+PnbdjcpTkx4N7bWRjnYT/GeYwTFic3
        VCse9smnioorS2Mj6o3SsYGVDjxL/yjSHlWRfL33oWuCYVLJt4AVISOZ2wyDsRFLWiQ4myxb
        GIkpWdlv5J2dukwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7rvWS7GGRx5zmmxccZ6VoupD5+w
        WVz/8pzVYvXHx4wW589vYLd4MPcmk8W3Kx1MFpd3zWGz+Nx7hNFixvl9TBZrj9xlt3jz4yyT
        xe15l1kszpy+xGrx79pGFouOI9+YLTZ+9XAQ9Ng56y67x6ZVnWwed67tYfPo/2vgseVqO4tH
        35ZVjB7Hb2xn8vi8SS6AI0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEvo/WKUEGfXEVT73nmBsYbEl2MHBwSAiYSqxbldjFycQgJLGWUuHPxDnMX
        IydQXEbi5LQGVghbWOLPtS42iKJPjBJrN79jAkmwCRhKdL2FSIgItDJKnH+9ignEYRZoZZFY
        cGcV2ChhgXCJN39ms4HYLAKqEndPnQeL8wrYSpza8ZkRYoW8xOoNB8DinAJ2EtcuHQKLCwHV
        HNjRxDSBkW8BI8MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwJjZduzn5h2MlzYGH2IU4GBU
        4uHdMPN8nBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0OR8Y
        z3kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhj1284xsJo2NVrU
        nl+wMTUiYGPqaf0X/Om/ut9p93z9ItZ1MuKfU4D5zQmxjvkq83UdjvKuls/7qFrqn7Jf705G
        dmDavbZAzuUttx05z3LGHzs0M9m2YtK0A+wrvy8pXf1NOuvy5rtTOKTjneqOH5zpGbJ7yYn6
        N7ffn2VyEF3pIzud53IVx28lluKMREMt5qLiRAD2Y4GtrwIAAA==
X-CMS-MailID: 20200529124951eucas1p213c748fb481a37cf98918caae5e30fd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529124951eucas1p213c748fb481a37cf98918caae5e30fd2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529124951eucas1p213c748fb481a37cf98918caae5e30fd2
References: <20200529124940.10675-1-m.szyprowski@samsung.com>
        <CGME20200529124951eucas1p213c748fb481a37cf98918caae5e30fd2@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move the coupled regulators voltage balancing code to the separate
function and allow to call it from the custom regulator couplers.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/core.c          | 49 ++++++++++++++++++-------------
 include/linux/regulator/coupler.h |  8 +++++
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 941783a14b45..370c655ad8f6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3642,36 +3642,19 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 	return done;
 }
 
-static int regulator_balance_voltage(struct regulator_dev *rdev,
-				     suspend_state_t state)
+int regulator_do_balance_voltage(struct regulator_dev *rdev,
+				 suspend_state_t state, bool skip_coupled)
 {
 	struct regulator_dev **c_rdevs;
 	struct regulator_dev *best_rdev;
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
-	struct regulator_coupler *coupler = c_desc->coupler;
 	int i, ret, n_coupled, best_min_uV, best_max_uV, best_c_rdev;
 	unsigned int delta, best_delta;
 	unsigned long c_rdev_done = 0;
 	bool best_c_rdev_done;
 
 	c_rdevs = c_desc->coupled_rdevs;
-	n_coupled = c_desc->n_coupled;
-
-	/*
-	 * If system is in a state other than PM_SUSPEND_ON, don't check
-	 * other coupled regulators.
-	 */
-	if (state != PM_SUSPEND_ON)
-		n_coupled = 1;
-
-	if (c_desc->n_resolved < n_coupled) {
-		rdev_err(rdev, "Not all coupled regulators registered\n");
-		return -EPERM;
-	}
-
-	/* Invoke custom balancer for customized couplers */
-	if (coupler && coupler->balance_voltage)
-		return coupler->balance_voltage(coupler, rdev, state);
+	n_coupled = skip_coupled ? 1 : c_desc->n_coupled;
 
 	/*
 	 * Find the best possible voltage change on each loop. Leave the loop
@@ -3742,6 +3725,32 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 	return ret;
 }
 
+static int regulator_balance_voltage(struct regulator_dev *rdev,
+				     suspend_state_t state)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	struct regulator_coupler *coupler = c_desc->coupler;
+	bool skip_coupled = false;
+
+	/*
+	 * If system is in a state other than PM_SUSPEND_ON, don't check
+	 * other coupled regulators.
+	 */
+	if (state != PM_SUSPEND_ON)
+		skip_coupled = true;
+
+	if (c_desc->n_resolved < c_desc->n_coupled) {
+		rdev_err(rdev, "Not all coupled regulators registered\n");
+		return -EPERM;
+	}
+
+	/* Invoke custom balancer for customized couplers */
+	if (coupler && coupler->balance_voltage)
+		return coupler->balance_voltage(coupler, rdev, state);
+
+	return regulator_do_balance_voltage(rdev, state, skip_coupled);
+}
+
 /**
  * regulator_set_voltage - set regulator output voltage
  * @regulator: regulator source
diff --git a/include/linux/regulator/coupler.h b/include/linux/regulator/coupler.h
index 0212d6255e4e..5f86824bd117 100644
--- a/include/linux/regulator/coupler.h
+++ b/include/linux/regulator/coupler.h
@@ -62,6 +62,8 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev);
 int regulator_set_voltage_rdev(struct regulator_dev *rdev,
 			       int min_uV, int max_uV,
 			       suspend_state_t state);
+int regulator_do_balance_voltage(struct regulator_dev *rdev,
+				 suspend_state_t state, bool skip_coupled);
 #else
 static inline int regulator_coupler_register(struct regulator_coupler *coupler)
 {
@@ -92,6 +94,12 @@ static inline int regulator_set_voltage_rdev(struct regulator_dev *rdev,
 {
 	return -EINVAL;
 }
+static inline int regulator_do_balance_voltage(struct regulator_dev *rdev,
+					       suspend_state_t state,
+					       bool skip_coupled)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
-- 
2.17.1

