Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3015823284D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 01:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgG2XoC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 19:44:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:15611 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgG2XoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 19:44:01 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200729234359epoutp0481abbe589957561cfbc73fe169790d81~mXcnPLc7i2069420694epoutp043
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 23:43:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200729234359epoutp0481abbe589957561cfbc73fe169790d81~mXcnPLc7i2069420694epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596066239;
        bh=FJ9gVwUFNk5IbHQ3VCu6a9u2yij9IPe6saBA1KVjsxk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VPAhGrIGgIipEKvcQI2sdfWvReD6z1dUNDI8xKjwYDAJJRk3wES34cXvWcXWl71hx
         02JCgcpUmCZ2Ki0054tY0nifE6IdKm0lA1eLNhQ0UBQpCfBfKpvXsSoQ4tslJ/2FEZ
         fAVh0Xbyy+p9A9a2QE7f0mHVaDeJI1UT6Sw2JLiQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200729234358epcas1p3ec3b03da6648622fbd80ec435c974d8e~mXcm4ns6p1200712007epcas1p33;
        Wed, 29 Jul 2020 23:43:58 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BH99T4K5wzMqYkX; Wed, 29 Jul
        2020 23:43:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.0B.19033.DB9022F5; Thu, 30 Jul 2020 08:43:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200729234356epcas1p483bdaa2460e89b6dd461b45f1650b646~mXcktY0f60338903389epcas1p4N;
        Wed, 29 Jul 2020 23:43:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200729234356epsmtrp14d4fd204edd02b444b9630a202554311~mXcksAT4J2758927589epsmtrp18;
        Wed, 29 Jul 2020 23:43:56 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-bd-5f2209bdcb96
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.33.08303.CB9022F5; Thu, 30 Jul 2020 08:43:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.96]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200729234356epsmtip2adaf9a43f5d1e2fb371f8aa8c3b9a18a~mXckiyc0W3072930729epsmtip2t;
        Wed, 29 Jul 2020 23:43:56 +0000 (GMT)
From:   Jeehong Kim <jhez.kim@samsung.com>
To:     jhez.kim@samsung.com, sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: add "Wireless" to power_supply_type and
 power_supply_type_text
Date:   Thu, 30 Jul 2020 09:09:46 +0900
Message-Id: <20200730000946.15327-1-jhez.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7bCmru5eTqV4g4vz2CyuHp3EbHF51xw2
        i8+9RxgtTu8ucWDx2LSqk82jb8sqRo/Pm+QCmKNybDJSE1NSixRS85LzUzLz0m2VvIPjneNN
        zQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAlikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVS
        C1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3Iy/m9Yzl7wl6fi8YV+lgbGCdxdjJwcEgIm
        Ev8enWEDsYUEdjBK3Fmf0MXIBWR/YpT48PgDC4TzmVHiUfN3NpiOawt/skB07GKU6NqaBVf0
        /cg0VpAEm4CGxN3me2BFIkB2U8N0RhCbWcBK4vXHbvYuRg4OYYEEiVPdeSBhFgFViR/nT4KV
        8ApYSnx9fYoZYpe8xOoNB5hB5ksIdLNL7N6yjwki4SIx7/85dghbWOLV8S1QtpTEy/42doiG
        fqAX3rZDdfcwSvxZ+ZgVospYorfnAjPIFcwCmhLrd+lDhBUldv6eC3Uon8S7rz2sICUSArwS
        HW1CEKaSxLFV9hDVEhJPvp+HqvCQ2NFYBgmSWIkJrw8xTWCUnYUwfgEj4ypGsdSC4tz01GLD
        AiPkKNrECE4+WmY7GCe9/aB3iJGJg/EQowQHs5IIbzuXQrwQb0piZVVqUX58UWlOavEhRlNg
        eE1klhJNzgemv7ySeENTI2NjYwsTM3MzU2Mlcd6Ht4CaBNITS1KzU1MLUotg+pg4OKUamPL+
        6n4IalZwE5D/1putZFPNEzV5uvzcjKfFn2aY5ymo6jofudPZM/fmz7vzCstFLvC9WHruT8qH
        Z2xtk6MYVj4L7Nhl5rnVWtkrw/hbFb+fViSb080GzoK/1V0PK7q27xa5Gyxmnbtk2Z0nq80M
        kyYaFUQEO7BJrTj0Lu27R/9fL9cnjIcmLg/067PhK/yiaXnAtc68aHHazu2CiqLehRestdc3
        7dC5nV6QZrr1aGaj2qO/Uxp6EqebSx0Utrx+xLlSPp7l3saNTur7b8kKMfpIiiT/134yMcS4
        Zm9Pk4SLZNvsQK+Nl6K3fHkSqf/B5q/yZafzO89NdF8VFLI6N9xtg1besoIGzo3C75cqsRRn
        JBpqMRcVJwIACFFdbMcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJMWRmVeSWpSXmKPExsWy7bCSvO4eTqV4g0MXZS2uHp3EbHF51xw2
        i8+9RxgtTu8ucWDx2LSqk82jb8sqRo/Pm+QCmKO4bFJSczLLUov07RK4Mv5vWM5e8Jen4vGF
        fpYGxgncXYycHBICJhLXFv5k6WLk4hAS2MEocWhaNyNEQkLi8Ie7rF2MHEC2sMThw8UQNR8Z
        JR48OckMUsMmoCFxt/keC4gtIqAlsfj2LjYQm1nARuLBnCdgcWGBOIk3R1ezg9gsAqoSP86f
        BJvPK2Ap8fX1KWaIXfISqzccYJ7AyLOAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7u
        JkZwQGhp7WDcs+qD3iFGJg7GQ4wSHMxKIrztXArxQrwpiZVVqUX58UWlOanFhxilOViUxHm/
        zloYJySQnliSmp2aWpBaBJNl4uCUamAKnsu1r0tzopPxVPez6s0Sae4BvNy7D2affp/tFNf7
        54eS3oV9Pb+iJBVtcgL7dOefiZogdIfD9U2hwNn9WZNfTn2bfCMtYpZlO1Nv8rXn8zelvpeZ
        3SVtm7T0sHC+1ySjWTb7BG4vumj4+ab+Of3705US50frHvG2Oz7pJKfEx2+z3p8szJM+e/T2
        NBvxuez9Et2Bl30KDv6b1GpZvPyZyU273vWLunT0djWvrLo44aRZl9G39i0/jddJuRgJtiW9
        /H5q5S7tWH3Gqg/OW0t6v9usufd26leNuS2BWa+n3jM7vX7rlcZJ/1bm31gaWhGtKVoiK6u9
        Q7VkTyDf9Cn2v3dHRdyZ/FWqsJ1V7mSzEktxRqKhFnNRcSIAgCCPa3cCAAA=
X-CMS-MailID: 20200729234356epcas1p483bdaa2460e89b6dd461b45f1650b646
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200729234356epcas1p483bdaa2460e89b6dd461b45f1650b646
References: <CGME20200729234356epcas1p483bdaa2460e89b6dd461b45f1650b646@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In android platform(BatteryMonitor.cpp), SysfsStringEnumMap<int>
supplyTypeMap[] is declred for communication with kernel(sysfs)
and there is "Wireless". But, no type for "Wireless" in kernel.
So, we suggest to add "Wireless" to power_supply_type and
power_supply_type_text.
I hope this will not only synchronize the text values with
android platform, but also help other platforms.

Signed-off-by: Jeehong Kim <jhez.kim@samsung.com>
---
 drivers/power/supply/power_supply_sysfs.c | 1 +
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bc79560229b5..35582b67eff5 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -56,6 +56,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] = {
	[POWER_SUPPLY_TYPE_USB_PD]		= "USB_PD",
	[POWER_SUPPLY_TYPE_USB_PD_DRP]		= "USB_PD_DRP",
	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	= "BrickID",
+	[POWER_SUPPLY_TYPE_WIRELESS]		= "Wireless",
 };

 static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index ac1345a48ad0..c8bad17a9483 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -182,6 +182,7 @@ enum power_supply_type {
	POWER_SUPPLY_TYPE_USB_PD,		/* Power Delivery Port */
	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
+	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
 };

 enum power_supply_usb_type {
--
2.17.1
