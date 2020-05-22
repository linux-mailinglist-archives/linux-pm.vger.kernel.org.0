Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322781DE01C
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 08:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgEVGsL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 02:48:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49306 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgEVGsJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 02:48:09 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200522064807euoutp015df293dd4c2fbee7ce7d7b381d0c128d~RRuPXYb381799917999euoutp01e
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 06:48:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200522064807euoutp015df293dd4c2fbee7ce7d7b381d0c128d~RRuPXYb381799917999euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590130087;
        bh=zoGnv7c01nBpJYDQXUNSkx7X75BRfdmAGhcR2vRa5m0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=p/U7T0ZVQgL7kY7nvqtcgXkjdvd5ZaLNDo1+u5M7tdmZqYInnLy37fMg90QrwRNKq
         AFLuZU8OSwP4q2J9u/7eVeQ/Va1Ztl/jSHh3RI+FHJPTLXRMaQHSRJS5LQQ79nXW/5
         yTaqOm2YY1BfElGSFPGAJGp6SlnnZaiT8oWzC2DA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200522064807eucas1p13b8779b1d1cd1edbbfcb5352ea46ed90~RRuO8J0gd3153831538eucas1p1w;
        Fri, 22 May 2020 06:48:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 73.9E.61286.7A577CE5; Fri, 22
        May 2020 07:48:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200522064806eucas1p120fc21b6e3ae5783e627a3da3761def3~RRuOR6x9G2818528185eucas1p15;
        Fri, 22 May 2020 06:48:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200522064806eusmtrp176a9b58573bf227de2e987a6d70dfac9~RRuOPkwFd1662516625eusmtrp1h;
        Fri, 22 May 2020 06:48:06 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-17-5ec775a7b0f9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 82.60.07950.6A577CE5; Fri, 22
        May 2020 07:48:06 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200522064806eusmtip2baee80d262bca22389c420cc313cebba~RRuNrhTo62166121661eusmtip2s;
        Fri, 22 May 2020 06:48:05 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/3] regulator: max14577: Add proper dt-compatible
 strings
Date:   Fri, 22 May 2020 08:47:59 +0200
Message-Id: <20200522064801.16822-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7djP87rLS4/HGbz7yWexccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEdx2aSk5mSWpRbp2yVwZSw9/5yp4Bh3xYGHN9gaGJ9zdjFycEgImEi8uMfSxcjFISSwglHi
        4ew9bBDOF0aJ/kmHoJzPjBJvnx1h7mLkBOu4Pv00G4gtJLCcUeL/Zye4jn/rHoAVsQkYSnS9
        7QIrEhGwkjj9v4MZpIhZYAWTxMffn5hAEsIC/hKrpvWygtgsAqoSZx8uZwexeQVsJWa3fmKB
        2CYvsXrDAbBmCYHbbBLXDzWwQSRcJI4tPMMOYQtLvDq+BcqWkTg9uYcFoqEZ6KNza9khnB5G
        ictNMxghqqwl7pz7xQYKAmYBTYn1u/Qhwo4SHVd7WCEhwydx460gSJgZyJy0bTozRJhXoqNN
        CKJaTWLW8XVwaw9euAQNIQ+Jpw1TGUHKhQRiJRqusExglJuFsGoBI+MqRvHU0uLc9NRiw7zU
        cr3ixNzi0rx0veT83E2MwERw+t/xTzsYv15KOsQowMGoxMP7IPlYnBBrYllxZe4hRgkOZiUR
        3oX8R+OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoEk2Xi4JRqYBS9
        /V9yzr+EqFtXZ8wtTrD19rBPzIq1Ou7kVsl7oqZqh6fEOal/ZdLM3DuPK3v7v39SXPgtcP4b
        lelfmly1mBqDXxaFyv4Tu/hOsdL7+opNgs3Mr5Y8nZvz5DXX1G2diq8md68Kc5XQv95/w+iy
        i+Xjr5ZP03g19tZYr+zYGbts1vY1U8U5viqxFGckGmoxFxUnAgDS7DCIAAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xe7rLSo/HGWzYqWyxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZSw9
        /5yp4Bh3xYGHN9gaGJ9zdjFyckgImEhcn36arYuRi0NIYCmjxMaLDewQCRmJk9MaWCFsYYk/
        17qgij4xSrS8/cMCkmATMJToeguS4OQQEbCRuLv4GgtIEbPAGiaJhocfmUASwgK+Es/evmIG
        sVkEVCXOPlwOtoFXwFZidusnFogN8hKrNxxgnsDIs4CRYRWjSGppcW56brGRXnFibnFpXrpe
        cn7uJkZgEG479nPLDsaud8GHGAU4GJV4eB8kH4sTYk0sK67MPcQowcGsJMK7kP9onBBvSmJl
        VWpRfnxRaU5q8SFGU6DlE5mlRJPzgRGSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qBUW/RqUNPTVd+07/PtfnUB5twZ8HHl4ROnPW5uMXx8I/65PPx/zRabL9f
        eDGzonXGUuv6VTZmB99Kf7ix7/PTpdskyzwl+GZ9PC0T4PB25ozGWnaBoItr1nJOfXfPeFZl
        rvotHy370EMi6+KYpU1V5lw+NTfIbdPdbxalNdWfi+Nq9Eo2GojyX1NiKc5INNRiLipOBAAU
        noPaWAIAAA==
X-CMS-MailID: 20200522064806eucas1p120fc21b6e3ae5783e627a3da3761def3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200522064806eucas1p120fc21b6e3ae5783e627a3da3761def3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200522064806eucas1p120fc21b6e3ae5783e627a3da3761def3
References: <CGME20200522064806eucas1p120fc21b6e3ae5783e627a3da3761def3@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device tree compatible strings and create proper modalias structures
to let this driver load automatically if compiled as module, because
max14577 MFD driver creates MFD cells with such compatible strings.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- added .of_match_table pointer
---
 drivers/regulator/max14577-regulator.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index 07a150c9bbf2..4c9ae52b9e87 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -238,10 +238,20 @@ static const struct platform_device_id max14577_regulator_id[] = {
 };
 MODULE_DEVICE_TABLE(platform, max14577_regulator_id);
 
+static const struct of_device_id of_max14577_regulator_dt_match[] = {
+	{ .compatible = "maxim,max77836-regulator",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
+	{ .compatible = "maxim,max14577-regulator",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_max14577_regulator_dt_match);
+
 static struct platform_driver max14577_regulator_driver = {
 	.driver = {
-		   .name = "max14577-regulator",
-		   },
+		.name = "max14577-regulator",
+		.of_match_table = of_max14577_regulator_dt_match,
+	},
 	.probe		= max14577_regulator_probe,
 	.id_table	= max14577_regulator_id,
 };
-- 
2.17.1

