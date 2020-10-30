Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2D2A05E0
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgJ3MxQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:53:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60773 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgJ3MxQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 08:53:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201030125304euoutp02ff8f5a3e9cfc9044957853905663e247~Cxj1iQmVL0138901389euoutp02d
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 12:53:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201030125304euoutp02ff8f5a3e9cfc9044957853905663e247~Cxj1iQmVL0138901389euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604062384;
        bh=Y2Z99igfM2psoG8VCoLwnsiBKkGCi6GoAAHYuNMBQ+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7v4WRBN55/ZjdTiulOGWuQTVwo97X6ZXw8UoTFZOeKvUBiw3AAWTjTkj7UiyBBbp
         xyqQkGrnL5ZMmi1Tn5sRhqFuQNm1jy6l/cqHhtcbi42bij64SY1N5HWX+zdPEQ42du
         vZJ1p91j6V+IMkkbBiRVspr3FwP46gplvwrzZKt4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201030125303eucas1p21380954e5f28a6d6f9a01d0de5a009e6~Cxj1RXhFV0100501005eucas1p2I;
        Fri, 30 Oct 2020 12:53:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DC.06.06456.FAC0C9F5; Fri, 30
        Oct 2020 12:53:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201030125303eucas1p14a9de4111ffafc1870527abdea0994c9~Cxj05a9Ql2027520275eucas1p1j;
        Fri, 30 Oct 2020 12:53:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201030125303eusmtrp1ed66128402cefe47ae169de3f99996c7~Cxj04x5es0314503145eusmtrp1f;
        Fri, 30 Oct 2020 12:53:03 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-e0-5f9c0caf7c1d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 20.57.06017.FAC0C9F5; Fri, 30
        Oct 2020 12:53:03 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201030125302eusmtip293f7bc05eee5aec888e610e430a328c7~Cxj0KYcpI1667716677eusmtip2J;
        Fri, 30 Oct 2020 12:53:02 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        s.nawrocki@samsung.com
Subject: [PATCH v7 3/6] PM / devfreq: exynos-bus: Add registration of
 interconnect child device
Date:   Fri, 30 Oct 2020 13:51:46 +0100
Message-Id: <20201030125149.8227-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030125149.8227-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjm2zk7OxMnxyn5YpfpyMhIzezHYUqoKCwsuvwoCHTNPLnKTdmc
        VkQaeal5wZSaWuk0UluocyyL0iidSc5caaahsZIiNM28LCm7Oc+if8/7XL734eUjMWED1588
        rspk1Cp5mpjwwNuffh8IafW8LtuWNxhBO2ryEd1W2cqlRxY/cela6wCXfuWcJWh9p5mgyx1l
        OG23m3j00IPrBL1QYkV0pf0Rh262vuXRY+ebCDq/08qju6cLuXRlxSQRTUnNxkuEdPx1ByF1
        FPVypKUWI5IumDfs4x72iEph0o5nMeqwnUc8FK3TdixjmDrVM3swF/UJdIhPArUDbtlzkQ55
        kEKqCcH4vZc4OywisL7/6VYWEDS+MHL+RZZGqnms0Ijgbv/S/0jLExvuchFUOJT0lCIX9qXi
        oOBjzSqPURMcuFCLubAPJYeZtjcrr5IkTgVBz+cEFy2gJKDTN+PsMhHcMT1etfOpSNBdGnWX
        MPOgYs6XxXEw9PSL2+8DU70WHovXga2ieLUbUBcQFD8c47FDGQJHrwGxrkgYH/hBuEpgVDC0
        Pghj6RjoHnWVIFewF4zOeLP1vaC8XY+xtAAuFghZ90ZYNurd1fyh6MMfd1IK9VUYe51SBB2X
        G/AyJKr+v8uAkBH5MVqNMpXRhKuY7FCNXKnRqlJDj6YrzWjl99h+987fR87B5C5EkUjsKYgW
        XZMJufIszWllFwISE/sKYp/bkoSCFPnpM4w6XabWpjGaLrSWxMV+goj6yUQhlSrPZE4yTAaj
        /qdySL5/LqqLmtkvCT0hQnO6X/vrEhSbtTemLB0bCRlRsz4InJZl3yv920PecRUTOQnpDe3P
        RjclfeGJdAH48K7G7G+SrfpzwVU5dkmexRRrcIo6Cw95H5v/6r1779U9tthjewPPJvfdPAD6
        +NQ1iocxJjywqYW4vSMgPlHCVwkNJSrtRzGuUcjDt2Bqjfwvad9oZjkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e/4Pd31PHPiDfZsk7K4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbXN41h83ic+8RRosZ5/cxWaw9cpfd
        4nbjCjaL1r1H2C0Ov2lntZgx+SWbg4DHplWdbB53ru1h87jffZzJo2/LKkaPz5vkAlij9GyK
        8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLWvznPXHBV
        oOLo+7AGxlO8XYycHBICJhLfr89i72Lk4hASWMoosfjAAcYuRg6ghJTE/BYliBphiT/Xutgg
        aj4xSnza3ckIkmATMJToPdoHZosIeEical3LClLELPCBSWLtg16whLBAvET/o20sIENZBFQl
        jr72BgnzClhJdE1fywKxQF5i9YYDzCA2p4C1RFfnDSaQciGgmrcHqiYw8i1gZFjFKJJaWpyb
        nltspFecmFtcmpeul5yfu4kRGAnbjv3csoOx613wIUYBDkYlHl4H+dnxQqyJZcWVuYcYJTiY
        lUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EaAp00kRmKdHkfGCU5pXEG5oamltYGpobmxubWSiJ
        83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYAz+GFvp9Fz3Y/uCLHlJ+aDbKhKpXC7Hvb9yi0qF
        6/0VNz+5cnpGQoqLXsbuE4/uu534xb9G8py0b6LnnJTM/MK0NL03T1Pm7/HZ7xdT5Piv7arK
        x/93bDfIfzqyq/LVg7ppaus23WqJnifFz3Q8ysVdvaSgs0olvV2myubpAsPNDG2TjzsyKbEU
        ZyQaajEXFScCAI8vPs+aAgAA
X-CMS-MailID: 20201030125303eucas1p14a9de4111ffafc1870527abdea0994c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201030125303eucas1p14a9de4111ffafc1870527abdea0994c9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201030125303eucas1p14a9de4111ffafc1870527abdea0994c9
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125303eucas1p14a9de4111ffafc1870527abdea0994c9@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds registration of a child platform device for the exynos
interconnect driver. It is assumed that the interconnect provider will
only be needed when #interconnect-cells property is present in the bus
DT node, hence the child device will be created only when such a property
is present.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v7, v6:
 - none.

Changes for v5:
 - new patch.
---
 drivers/devfreq/exynos-bus.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 1e684a4..ee300ee 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -24,6 +24,7 @@
 
 struct exynos_bus {
 	struct device *dev;
+	struct platform_device *icc_pdev;
 
 	struct devfreq *devfreq;
 	struct devfreq_event_dev **edev;
@@ -156,6 +157,8 @@ static void exynos_bus_exit(struct device *dev)
 	if (ret < 0)
 		dev_warn(dev, "failed to disable the devfreq-event devices\n");
 
+	platform_device_unregister(bus->icc_pdev);
+
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
 	if (bus->opp_table) {
@@ -168,6 +171,8 @@ static void exynos_bus_passive_exit(struct device *dev)
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
 
+	platform_device_unregister(bus->icc_pdev);
+
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
 }
@@ -432,6 +437,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err;
 
+	/* Create child platform device for the interconnect provider */
+	if (of_get_property(dev->of_node, "#interconnect-cells", NULL)) {
+		    bus->icc_pdev = platform_device_register_data(
+						dev, "exynos-generic-icc",
+						PLATFORM_DEVID_AUTO, NULL, 0);
+
+		    if (IS_ERR(bus->icc_pdev)) {
+			    ret = PTR_ERR(bus->icc_pdev);
+			    goto err;
+		    }
+	}
+
 	max_state = bus->devfreq->profile->max_state;
 	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
 	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
-- 
2.7.4

