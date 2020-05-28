Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C171E61DB
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 15:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390176AbgE1NLv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 09:11:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46798 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390174AbgE1NLs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 09:11:48 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200528131145euoutp01924b5fff3632e718c15a059618993c16~TM05saaEx1751817518euoutp01w
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 13:11:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200528131145euoutp01924b5fff3632e718c15a059618993c16~TM05saaEx1751817518euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590671505;
        bh=Ln5XpraqHOtmfDWeTOWpT8XBWp+N7299Vcws1RisUJc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UOUPn0o+U3cZa3Y7uETBijeR3akrR7VljsZ709G5W1j4fn0ct50vE1VWSDP2k7ChB
         DUtn68/uGT5VROODS0GWo2F/DkTUJ9PmnyjX0a5XoM+jwIbWy18H7gs6EIG1nZj/EZ
         eoU6avQnNCRLElpxvv7GJNAOP12QffEHC0SQMlWA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200528131144eucas1p2d552391a20ecfea79f6996bf751b6df1~TM05TJwxv2226422264eucas1p2k;
        Thu, 28 May 2020 13:11:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CC.06.60679.098BFCE5; Thu, 28
        May 2020 14:11:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200528131144eucas1p121b9151996fa3f780a5028f68c69d5ba~TM04_7Jgn0067300673eucas1p1c;
        Thu, 28 May 2020 13:11:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200528131144eusmtrp269e2ddd7ce2be429f0626a5831dc074a~TM04_BvzG0932309323eusmtrp2b;
        Thu, 28 May 2020 13:11:44 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-c6-5ecfb890f478
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.2E.08375.098BFCE5; Thu, 28
        May 2020 14:11:44 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200528131143eusmtip2427d92bb6d7f6bdbd7b422e9ef9b1e3f~TM04TeAQg1427714277eusmtip2c;
        Thu, 28 May 2020 13:11:43 +0000 (GMT)
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
Subject: [PATCH] regulator: do not balance regulators without constraints
Date:   Thu, 28 May 2020 15:11:30 +0200
Message-Id: <20200528131130.17984-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzv9zx3zz2ss8dh94smrrfV5H3tZ72MZuvp5Y/+qyUvh2eOvO3O
        y2lrIyNOpJZCwlhl5OXEdV5q0eW2xIm8lJfl1IwhIUJHzkP++7z+vt/v9iNxQRXXmgyNjGGk
        keJwEWHKUbUtdx7LVuv8nKdfuCJlbjUX5Yx+J1D/wjgXVfwaA0inq+Ghb0++YGjxcxqGehoL
        CDSfqQEoV/cGQ5WaYR6a+tOBocHCHg762N7NRWt9Sg5K0yziSPmb9jSnG/KHeXRteTpBD/U1
        E/RdgzNd13ubQ2fVlQNaO/AKo+drbS+RV01PBjPhoXGM1Ol0gKmkLbsWi9YI5UsjedxEkGeh
        ACQJKXeo/ylRAFNSQJUBaNBouSxZAHAptx6wZB5AvUEPthtq3VlWfw5g/cLkTuNhi5pQABOS
        oFygYlpBGA1LKmkjVdyFGQ2cWsXh60/2RmxBnYOlc3O4EXOog3DdkL5Z5lOnYH7py00dUvtg
        Rc1b3PgQpFQ8+GAwjcca3vCDSr0VsoCT2rotfS9cbyjC2EIygKOdlTyW3AGw51YuYFMn4FDn
        CmE8CKeOwOpGJ1b2gqvpKVz2TjM4MG3OLm0G76se4azMh2mpAjZ9COZrq/6Pbenq3lqHhmOP
        yzhGLKB8YdHACpENbPN3ZhUDUA6ETKwsIoSRuUYy8Y4ycYQsNjLEMSgqohZs/KL2Ne2CGjT+
        DWwFFAlEu/k1eTo/AVccJ0uIaAWQxEWW/DMd7X4CfrA44QYjjfKXxoYzslZgQ3JEQr5byYSv
        gAoRxzDXGSaakW67GGlinQiCo/fUFbu0Pi3omQg78O7ij6abU14iH3HzyFjJ+ytW9ql21ocv
        j2QWZnXJVVVfRcv6xnoHL+GujCkbf+Va1rVVb48ku7JxXfOslZvcw5B+PDn+3vnwC01hEgd5
        X0WOfNAsqCrQpylAkjkgbPGcddc3hPU+W0qZqczonykhS+fj94s4MonY5SgulYn/ATXzBu5B
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Pd0JO87HGXz4KmexccZ6VoupD5+w
        WVz/8pzVYvXHx4wW589vYLd4MPcmk8W3Kx1MFpd3zWGz+Nx7hNFixvl9TBZrj9xlt3jz4yyT
        xe15l1kszpy+xGrx79pGFouOI9+YLTZ+9XAQ9Ng56y67x6ZVnWwed67tYfPo/2vgseVqO4tH
        35ZVjB7Hb2xn8vi8SS6AI0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEv49iETUwFR8Qrvt+bydrAOFO4i5GDQ0LARGLHefcuRi4OIYGljBJ3zmxj
        7mLkBIrLSJyc1sAKYQtL/LnWxQZR9IlRYsmUJ+wgCTYBQ4mutxAJEYFWRonzr1cxgTjMAq0s
        EgvurAIbJSzgKbH40ycwm0VAVeL/3042EJtXwFZi1uLNUOvkJVZvOMA8gZFnASPDKkaR1NLi
        3PTcYkO94sTc4tK8dL3k/NxNjMAo2Hbs5+YdjJc2Bh9iFOBgVOLh3TDzfJwQa2JZcWXuIUYJ
        DmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAi2fyCwlmpwPjNC8knhDU0NzC0tDc2NzYzML
        JXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MgnIT626c7mz5Kbmz96pa1ra/k9OORf1bZHnJ
        Xbxh0UPu2Pj9qnwWv7rk205sNp3GERa35BF3xa+ipt9pe5rrzt/MWf8zYe00pg13a124mtbH
        fbsmFh7tU3bnUkSasaNhz9niXWd0k+Z9Ctct/JL88upZY8bJU1jU7rGrRhRbKXm4bs7YfZlL
        iaU4I9FQi7moOBEAyCh4b5gCAAA=
X-CMS-MailID: 20200528131144eucas1p121b9151996fa3f780a5028f68c69d5ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200528131144eucas1p121b9151996fa3f780a5028f68c69d5ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200528131144eucas1p121b9151996fa3f780a5028f68c69d5ba
References: <CGME20200528131144eucas1p121b9151996fa3f780a5028f68c69d5ba@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Balancing coupled regulators must wait until the clients for all of the
coupled regualtors set their constraints, otherwise the balancing code
might change the voltage of the not-yet-constrained regulator to the
value below the bootloader-configured operation point, what might cause a
system crash.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---

This is probably a generalization of the issue aleady observed and
reported here:
https://lore.kernel.org/linux-samsung-soc/20191008101709.qVNy8eijBi0LynOteWFMnTg4GUwKG599n6OyYoX1Abs@z/
https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/
https://lore.kernel.org/linux-pm/cover.1589528491.git.viresh.kumar@linaro.org/

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

I know that adding more and more special cases to the generic code is not
the best idea, but so far I see no other way to fix this issue. The only
other solution that comes to my mind is admiting that it is not possible
to have generic regulator coupler and this needs board-specific code in
all cases. Such code might take care of those corner cases if they are
critical.

Best regards,
Marek Szyprowski
---
 drivers/regulator/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 941783a14b45..c1d77d44186b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3697,10 +3697,21 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			 * the coupled voltages.
 			 */
 			int optimal_uV = 0, optimal_max_uV = 0, current_uV = 0;
+			int cons_uV = 0, cons_max_uV = INT_MAX;
 
 			if (test_bit(i, &c_rdev_done))
 				continue;
 
+			ret = regulator_check_consumers(c_rdevs[i],
+						&cons_uV,
+						&cons_max_uV, state);
+			if (ret < 0)
+				goto out;
+
+			/* no constraints set - ignore */
+			if (cons_uV == 0)
+				continue;
+
 			ret = regulator_get_optimal_voltage(c_rdevs[i],
 							    &current_uV,
 							    &optimal_uV,
-- 
2.17.1

