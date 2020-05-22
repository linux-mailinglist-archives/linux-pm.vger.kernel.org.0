Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6281DE44D
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 12:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgEVKZC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 06:25:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35670 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbgEVKY6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 06:24:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200522102456euoutp01608613d257b4bffab2383dc6465ef4f4~RUriV8CvV0174001740euoutp017
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 10:24:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200522102456euoutp01608613d257b4bffab2383dc6465ef4f4~RUriV8CvV0174001740euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590143096;
        bh=GiXLlCD7rw4Ddh8ai89LcATFiowzn5HsH3cgIMUtpwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uj5zXZbaXtNP8J+RjMBXfCeofIpZ3qrQvdUGCoDNVidY1hZ6TjT1Knil4Ier15sAB
         oxWIL8HgPqufeoPGZtF2bGFrhPW2ugYrm+0eeMZCDNnxuDogwEXhUcvVWjT4B/f1Zj
         Zx2VXoq7VZaEYF+Gw04/q0FkmQcQIPkXHFEblFO4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200522102455eucas1p2ba4487ef3f697baefc7441d863c17453~RUriGiuPC2413324133eucas1p2L;
        Fri, 22 May 2020 10:24:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BA.60.60698.778A7CE5; Fri, 22
        May 2020 11:24:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200522102455eucas1p13700db68b90ec05bd02d21014b81b656~RUrhy_DwL0694006940eucas1p1F;
        Fri, 22 May 2020 10:24:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200522102455eusmtrp15415b7f8d3c7e68d895d9b5606d5bc1b~RUrhyYhyF3194431944eusmtrp1L;
        Fri, 22 May 2020 10:24:55 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-d6-5ec7a87739ef
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.90.08375.778A7CE5; Fri, 22
        May 2020 11:24:55 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200522102455eusmtip27b49c9738e8c7f997507ed297cabeb54~RUrhQIIn70316003160eusmtip2H;
        Fri, 22 May 2020 10:24:54 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 3/3] power: charger: max14577: Add proper dt-compatible
 strings
Date:   Fri, 22 May 2020 12:24:48 +0200
Message-Id: <20200522102448.30209-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522102448.30209-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djP87rlK47HGTzvN7bYOGM9q8XUh0/Y
        LK5/ec5qcf78BnaLy7vmsFl87j3CaLH2yF12i9uNK9gsTu8uceD02LSqk82jb8sqRo/Pm+QC
        mKO4bFJSczLLUov07RK4Mr4sO8teMJu74tip6gbGE5xdjJwcEgImEv/XfWUGsYUEVjBKfF3t
        18XIBWR/YZRY2LQFKvGZUWL3gxyYhjcTzjNBFC1nlLi89yE7XMeSRddZQarYBAwlut52sYHY
        IgJWEqf/dzCDFDELrGCS+Pj7ExNIQlggRGL5hTssIDaLgKrExRm3wdbxCthKHNi8jw1inbzE
        6g0HgOIcHJwCdhIvTxWDzJEQeM8mcaD5BTNEjYtEw72VUPXCEq+Ob2GHsGUkTk/uYYFoaGaU
        eHhuLTuE0wN0d9MMRogqa4k7536xgWxgFtCUWL9LHyLsKDHjVBdYWEKAT+LGW0GQMDOQOWnb
        dGaIMK9ER5sQRLWaxKzj6+DWHrxwCeo0D4kXH7pZIKE4kVFi/jL2CYzysxB2LWBkXMUonlpa
        nJueWmycl1quV5yYW1yal66XnJ+7iRGYHk7/O/51B+O+P0mHGAU4GJV4eC3SjsUJsSaWFVfm
        HmKU4GBWEuFdyH80Tog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZ
        Jg5OqQZGcf1FIbesnp69olB1vOiA2XfOmCNWjvdszp287hdY9K2F136usXejsfi3ywJHLl9V
        m7FGckNSdZU/r+PmSYXdQe/8Mna+2GDD4ZHsrGZ1ymDatl97ZR4VGl/NMouY8fhnefK9Z9Iq
        t69eMD3cvEJiL+/DIH2l743uV+dNFONZsd0rbW+Xi+o6JZbijERDLeai4kQABVvlLgsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xe7rlK47HGex4LGuxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXxZ
        dpa9YDZ3xbFT1Q2MJzi7GDk5JARMJN5MOM/UxcjFISSwlFHi4reNbBAJGYmT0xpYIWxhiT/X
        usDiQgKfGCXaF5aC2GwChhJdbyHiIgI2EncXX2MBGcQssIZJouHhRyaQhLBAkMTrM0uYQWwW
        AVWJizNug9m8ArYSBzbvg1omL7F6wwGgOAcHp4CdxMtTxRC7bCV+75rBNoGRbwEjwypGkdTS
        4tz03GJDveLE3OLSvHS95PzcTYzAcN127OfmHYyXNgYfYhTgYFTi4X2QfCxOiDWxrLgy9xCj
        BAezkgjvQv6jcUK8KYmVValF+fFFpTmpxYcYTYFumsgsJZqcD4ylvJJ4Q1NDcwtLQ3Njc2Mz
        CyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjMIZx75H6D6a5ySrcOvIAbXKL2fXZ5Z2cz3x
        F+zZyThR5OznEz6GF6xvXxVRXZpR9abxisXbPYV/BZZPlhO4y3pb7NoW3trzLzONK/7ts9Nz
        y0u++4WX5TynhHJ98er+bdtz2o7VtWx5YDgj/2vQzXf7GqPX2SYfkn/ksen1w0lR047ckm33
        iFdiKc5INNRiLipOBABQ/2/1bQIAAA==
X-CMS-MailID: 20200522102455eucas1p13700db68b90ec05bd02d21014b81b656
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200522102455eucas1p13700db68b90ec05bd02d21014b81b656
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200522102455eucas1p13700db68b90ec05bd02d21014b81b656
References: <20200522102448.30209-1-m.szyprowski@samsung.com>
        <CGME20200522102455eucas1p13700db68b90ec05bd02d21014b81b656@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device tree compatible strings and create proper modalias structures
to let this driver load automatically if compiled as module, because
max14577 MFD driver creates MFD cells with such compatible strings.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v3:
- sorted of_max14577_charger_dt_match
v2:
- added .of_match_table pointer
---
 drivers/power/supply/max14577_charger.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index 8a59feac6468..96f4cd1941b2 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -623,9 +623,19 @@ static const struct platform_device_id max14577_charger_id[] = {
 };
 MODULE_DEVICE_TABLE(platform, max14577_charger_id);
 
+static const struct of_device_id of_max14577_charger_dt_match[] = {
+	{ .compatible = "maxim,max14577-charger",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
+	{ .compatible = "maxim,max77836-charger",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_max14577_charger_dt_match);
+
 static struct platform_driver max14577_charger_driver = {
 	.driver = {
 		.name	= "max14577-charger",
+		.of_match_table = of_max14577_charger_dt_match,
 	},
 	.probe		= max14577_charger_probe,
 	.remove		= max14577_charger_remove,
-- 
2.17.1

