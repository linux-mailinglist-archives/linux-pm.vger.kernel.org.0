Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E271DE01B
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 08:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgEVGsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 02:48:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32932 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgEVGsJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 02:48:09 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200522064808euoutp020114fa51ac27984b1333f08180a048fe~RRuPnmDrh0992509925euoutp02m
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 06:48:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200522064808euoutp020114fa51ac27984b1333f08180a048fe~RRuPnmDrh0992509925euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590130088;
        bh=smAZi9fZbvDKEfoiWe78k+Q3pnTMoASjWoqnfT0Mfgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Znf8Twb4/P44+pBkOrTx+5xcSMOAqWr019rhl2BTHd3yUVmTnuTNx239INlhJE8WU
         6dSjjDD/AZnU+Cj1o8CpmzxIdA3NpM9zOrFQXxE+yiUuaKXj0TezXEqSAdViZj9HwF
         w3STbNAfc5XmaCgC49zStjOBYrgpIJ8YC2uYTj9M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200522064807eucas1p1d04a18a6955457648aafea0e3a8933cf~RRuPUSd6n2618826188eucas1p1N;
        Fri, 22 May 2020 06:48:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B6.63.60698.7A577CE5; Fri, 22
        May 2020 07:48:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8~RRuOuKOlv0153601536eucas1p2p;
        Fri, 22 May 2020 06:48:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200522064807eusmtrp14542641d7991d48ca334eb8d178195ac~RRuOtlA0M1644516445eusmtrp1A;
        Fri, 22 May 2020 06:48:07 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-10-5ec775a7fffa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.60.07950.7A577CE5; Fri, 22
        May 2020 07:48:07 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200522064806eusmtip2a535114fc83d4aa358c90f0b34e9d5eb~RRuOPY9KK2870328703eusmtip2I;
        Fri, 22 May 2020 06:48:06 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/3] extcon: max14577: Add proper dt-compatible strings
Date:   Fri, 22 May 2020 08:48:00 +0200
Message-Id: <20200522064801.16822-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522064801.16822-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djP87rLS4/HGTw9rGOxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEdx2aSk5mSWpRbp2yVwZXxb2M5UsIarYkr7RNYGxnscXYycHBICJhJ/d79k7GLk4hASWMEo
        8X3OGRYI5wujxMeWfiYI5zOjxPTObkaYlgV3pkIlljNKrPt/lRWupffDbyaQKjYBQ4mut11s
        ILaIgJXE6f8dzCBFzAIrmCQ+/v4EViQs4CVx5NAbsLEsAqoSr3+8BbN5BWwlnnZ1MUGsk5dY
        veEAM4jNKWAnMeHIG7BBEgLv2SQ6b3awQRS5SFx/+4QdwhaWeHV8C5QtI3F6cg8LREMzo8TD
        c2vZIZweRonLTTOgPrKWuHPuF9AkDqD7NCXW79KHCDtKbP2ziwkkLCHAJ3HjrSBImBnInLRt
        OjNEmFeio00IolpNYtbxdXBrD164xAxhe0g8ntUFDa6JjBKT1pxmmsAoPwth2QJGxlWM4qml
        xbnpqcXGeanlesWJucWleel6yfm5mxiBieL0v+NfdzDu+5N0iFGAg1GJh9ci7VicEGtiWXFl
        7iFGCQ5mJRHehfxH44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgST
        ZeLglGpgnDyxcRublHrJD8W4KLnP/QflI1kl1j1huDSxYIpaxe4ztWKC/KLqT/7W7p3J0c10
        esGNuE1f35+18WOTfplqOtV+2pYGib5b9utdRTrv/9p+5iK33W4Wi/hrLLd32vGmmL66vdBh
        0zK1mozt37XiVwT4zAh6bD/t5Pm/ckX7T+3/X/Xpo6PhYyWW4oxEQy3mouJEAB+HQXUQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t/xe7rLS4/HGZy+zmaxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXxb
        2M5UsIarYkr7RNYGxnscXYycHBICJhIL7kxl6mLk4hASWMoosbKtlwkiISNxcloDK4QtLPHn
        WhcbRNEnRon2CeeYQRJsAoYSXW9BEpwcIgI2EncXX2MBKWIWWMMk0fDwI9gkYQEviSOH3jCC
        2CwCqhKvf7wFs3kFbCWednVBbZOXWL3hANhQTgE7iQlH3oDZQkA19+evYpnAyLeAkWEVo0hq
        aXFuem6xkV5xYm5xaV66XnJ+7iZGYNBuO/Zzyw7GrnfBhxgFOBiVeHgfJB+LE2JNLCuuzD3E
        KMHBrCTCu5D/aJwQb0piZVVqUX58UWlOavEhRlOgoyYyS4km5wMjKq8k3tDU0NzC0tDc2NzY
        zEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+PxnT+mBaxeq+S78/1yE84FPMwKX5Z865m4
        SvS01ORdBvPOXpyy7dp88c11Uf3TY4vn2vWH+E3SdJAp8PhruN1V+ukehtSJ2WUTxTf8K35s
        +eVukRpbydlscYts5nu7a2757ufw0bvl0xR5zFCoKn4Hx41FS/ltX/cmT589UT3pPruAr+83
        uSNKLMUZiYZazEXFiQCE38nScAIAAA==
X-CMS-MailID: 20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8
References: <20200522064801.16822-1-m.szyprowski@samsung.com>
        <CGME20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8@eucas1p2.samsung.com>
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
 drivers/extcon/extcon-max14577.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index 32f663436e6e..03af678ddeba 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -782,9 +782,19 @@ static const struct platform_device_id max14577_muic_id[] = {
 };
 MODULE_DEVICE_TABLE(platform, max14577_muic_id);
 
+static const struct of_device_id of_max14577_muic_dt_match[] = {
+	{ .compatible = "maxim,max77836-muic",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
+	{ .compatible = "maxim,max14577-muic",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_max14577_muic_dt_match);
+
 static struct platform_driver max14577_muic_driver = {
 	.driver		= {
 		.name	= "max14577-muic",
+		.of_match_table = of_max14577_muic_dt_match,
 	},
 	.probe		= max14577_muic_probe,
 	.remove		= max14577_muic_remove,
-- 
2.17.1

