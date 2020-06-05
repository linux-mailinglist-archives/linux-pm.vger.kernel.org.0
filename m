Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6F31EF170
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 08:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgFEGhe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 02:37:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54696 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgFEGhd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 02:37:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200605063731euoutp0211f393c0fcb7c2e098789cdf1c54cef1~Vkm_S0OJC2354223542euoutp02M
        for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2020 06:37:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200605063731euoutp0211f393c0fcb7c2e098789cdf1c54cef1~Vkm_S0OJC2354223542euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591339051;
        bh=9tj/tEQdb71uWorIGg6XsfrR4cnnT28P6d8/40RKCsQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rrPfO2RiKRV7aQpnYFn2vwE0rlaHDdm42LU9oT6kZHDSvTu1nfXVEJ7UeZhyDAOOG
         wWD1Wdekt4WzQmmTD6/L4q4+xXts7FotdQWoWxCmxCXeYJR7XxpWAjoIzNW+50CdQQ
         aC11iwBZgkYuu/hD7Ktwid0QwPScW28Us2/wSpaY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200605063730eucas1p11dc2ce83c6dddfef3e876f5d216f9fe6~Vkm9vlb7X0280102801eucas1p1v;
        Fri,  5 Jun 2020 06:37:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E6.42.60698.A28E9DE5; Fri,  5
        Jun 2020 07:37:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6~Vkm9FhU3f1352813528eucas1p2G;
        Fri,  5 Jun 2020 06:37:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200605063729eusmtrp153b9abc24a971d7add630ca87d2d616c~Vkm9Ev-Q30319803198eusmtrp1X;
        Fri,  5 Jun 2020 06:37:29 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-03-5ed9e82a548c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.F6.07950.928E9DE5; Fri,  5
        Jun 2020 07:37:29 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200605063729eusmtip279e3516d7b9ff8280c0cc07211ce6c5e~Vkm8QXta80289502895eusmtip2i;
        Fri,  5 Jun 2020 06:37:29 +0000 (GMT)
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
Subject: [PATCH] regulator: do not balance 'boot-on' coupled regulators
 without constraints
Date:   Fri,  5 Jun 2020 08:37:24 +0200
Message-Id: <20200605063724.9030-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju2zlnO0qr4xR8s9AcdCcvGfRBIhkVh8iI6k+i1srT1Lyx47X+
        aEat1ZxamYwyyR/GbKljmUlZmqW5dF7SZmlkmqVpUuqwm+U8y/6973PheV54aUJWSXnRsYkp
        nCpRES8Xu5LVz763bVz/qTcq4Mu0L64qqqDwlYEhMX419ZHC5V8HEbZaKyX43fVeEba/VItw
        V+01MZ7UNiJcZK0TYWNjvwSPzbSK8JviLhK/sHRSeLanisTqRjuBq6bZbW7sfX2/hDUZzovZ
        vp4HYlb3O4A1d58j2VyzAbFNtnsidtLkvY8Odw2O5uJj0ziVf8gR15jLj0pR8gxkDOi+ibLQ
        jIcGudDAbIbTdVZKg1xpGXMLwVihjhCWKQTP6o2ksEwiKBm4gP5ZbnwwOIkyBO3NJmrBkq3L
        lThUYiYQNOMasYPwYLIR3C1pFzkIgvlJwMMOX8fszkRCo32ccswkswpayobmNVImGOwlfyRC
        nA+UVz6eLwVMtQQ+6gudxA4YNvcTwuwOo01mJ74CLJcukoIhB8FAm1EiLBcRdJ0ucl6xFfra
        fsz1o+cqrYOKWn8BDoWnV4zzMDBLwDbuJpReAgXVVwkBloL6rExQrwZ9052F2Pr2TmcdFnJf
        n5kPks3d+F6tJvOQt/5/VglCBuTJpfIJSo4PSuTS/XhFAp+aqPQ7lpRgQnN/ZJltmq5Bdb+O
        NiCGRvLFUluHLUpGKdL4zIQGBDQh95Bub7VEyaTRisyTnCrpsCo1nuMb0HKalHtKg26ORMoY
        pSKFO8FxyZzqHyuiXbyyEIzG+ZT71nRrldmL4oqWHk8dGb+Vu7b99m4zTPkcXKltPWTYM1rm
        GbCl067f23DmVY5XXsQTbUtV6KNTVuPS/SbNhvzi2fCdeW4hw/k/+LCw7olBKgMimyfYz77P
        V79dpssP31Q6FBNqsY6s0X05UJ4dvWtxsjbCv8CWF6n08kmXk3yMInA9oeIVfwHfu+mtQwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4PV3NFzfjDA4/NbfYOGM9q8XUh0/Y
        LK5/ec5qsfrjY0aL8+c3sFs8mHuTyeLblQ4mi8u75rBZfO49wmgx4/w+Jou1R+6yW7z5cZbJ
        4va8yywWZ05fYrX4d20ji0XHkW/MFhu/ejgIeuycdZfdY9OqTjaPO9f2sHn0/zXw2HK1ncWj
        b8sqRo/jN7YzeXzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
        k5Kak1mWWqRvl6CXMWX/YsaCHxIVD/s/MTUw/hDpYuTkkBAwkZj/dBVLFyMXh5DAUkaJnadX
        MEEkZCROTmtghbCFJf5c62KDKPrEKLFu2j6wIjYBQ4mutxAJEYFWRonzr1cxgTjMAq0sEgvu
        rGIGqRIWiJZ4uHMdC4jNIqAqcWr5E7BuXgEbiW8L/rNDrJCXWL3hAPMERp4FjAyrGEVSS4tz
        03OLjfSKE3OLS/PS9ZLzczcxAuNg27GfW3Ywdr0LPsQowMGoxMN74+KNOCHWxLLiytxDjBIc
        zEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQFWj6RWUo0OR8Yo3kl8YamhuYWlobmxubGZhZK
        4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhhPCbJ5GBun7vZ5rDF7/UcPc6PDFv4G11a/DJjQ
        /jvksNRLg2mZZ9/Uz+oUXHBq6kuh5e3cEcHHE2oC/yxh+8mb37YpNlBQkOtv/GPBKi/d7PBP
        4c07OD58y2kzcRO5OClNzP//4Q+79+jVT6tri3084/GMHpWu7SbbTs+23BVhINRzOzi656YS
        S3FGoqEWc1FxIgBd1QSsmQIAAA==
X-CMS-MailID: 20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6
References: <CGME20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Balancing of the 'boot-on' coupled regulators must wait until the clients
set their constraints, otherwise the balancing code might change the
voltage of the not-yet-constrained regulator to the value below the
bootloader-configured operation point, what might cause a system crash.
This is achieved by assuming that, the minimal voltage allowed for the
given 'boot-on' regulator is equal to it's current voltage until
consumers apply their constraints.

Suggested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This is yet another approach to fix the regulator coupling on
Exynos5800/5422 SoCs in the regulator core. I agree with Dmitry that this
issue is generic and if possible it should be handled in the core.

This patchset is another attempt to fix the regulator coupling on
Exynos5800/5422 SoCs. Here are links to the previous attempts and
discussions:

https://lore.kernel.org/linux-samsung-soc/20191008101709.qVNy8eijBi0LynOteWFMnTg4GUwKG599n6OyYoX1Abs@z/
https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/
https://lore.kernel.org/linux-pm/cover.1589528491.git.viresh.kumar@linaro.org/
https://lore.kernel.org/linux-pm/20200528131130.17984-1-m.szyprowski@samsung.com/
https://lore.kernel.org/linux-samsung-soc/57cf3a15-5d9b-7636-4c69-60742e8cfae6@samsung.com/

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

Best regards
Marek Szyprowski
---
 drivers/regulator/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 03154f5b939f..7e9af7ea4bdf 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3553,6 +3553,17 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 		if (ret < 0)
 			return ret;
 
+		/*
+		 * If no constraints set yet and regulator has boot-on flag,
+		 * keep its voltage unchanged
+		 */
+		if (tmp_min == 0 && c_rdevs[i]->constraints->boot_on) {
+			ret = regulator_get_voltage_rdev(c_rdevs[i]);
+			if (ret < 0)
+				return ret;
+			tmp_min = ret;
+		}
+
 		ret = regulator_check_voltage(c_rdevs[i], &tmp_min, &tmp_max);
 		if (ret < 0)
 			return ret;
-- 
2.17.1

