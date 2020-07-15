Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D183220445
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 07:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgGOFN7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 01:13:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:35302 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgGOFN7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 01:13:59 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200715051355epoutp02d82ef8407e4ba619a8287ccb32bb0211~h1RaSwdKH2064620646epoutp02G
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 05:13:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200715051355epoutp02d82ef8407e4ba619a8287ccb32bb0211~h1RaSwdKH2064620646epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594790036;
        bh=GIdXeG9LsXYkUgrWWOUY0Jh4teDLnJtF0I4YxRoyxug=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FcSvr06b/VwGObhzcsHaKH9FVcrqbeAuRIYtGSEBqEL1ySn01h1nRaLgxU7Zp1R7I
         Xx3FN0PN6n1TYmDo7ts7yKpRfQlu4UjqsOCu+jgGPyc2J8ItRNpsQI0EMYM39BloLo
         Mg8bU3DdbtwARSdJ5w6kcd+okPSQ8Wkv/JwHzaB8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200715051355epcas1p2f5a139c8dee95e82b27438b02b476bed~h1RZs_KC23061530615epcas1p29;
        Wed, 15 Jul 2020 05:13:55 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4B65C56WzRzMqYkX; Wed, 15 Jul
        2020 05:13:53 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.46.19033.1909E0F5; Wed, 15 Jul 2020 14:13:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200715051353epcas1p46ae6b84555180be315752ef69262dfce~h1RXp0kgP0136901369epcas1p4w;
        Wed, 15 Jul 2020 05:13:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200715051353epsmtrp1a3877c73a7eb2f2b0d5eb26e0b147381~h1RXpMRDq0122501225epsmtrp1B;
        Wed, 15 Jul 2020 05:13:53 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-30-5f0e9091b9b4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.6D.08382.1909E0F5; Wed, 15 Jul 2020 14:13:53 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.96]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200715051353epsmtip17fbac96bdc4e0b9c4a65516606bb5d7f~h1RXhq5Rd0927509275epsmtip1e;
        Wed, 15 Jul 2020 05:13:53 +0000 (GMT)
From:   Jeehong Kim <jhez.kim@samsung.com>
To:     jhez.kim@samsung.com, sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dohyung Kim <dh0703.kim@samsung.com>
Subject: [PATCH] power: supply: add "Wireless" to power_supply_type and
 power_supply_type_text
Date:   Wed, 15 Jul 2020 14:38:44 +0900
Message-Id: <20200715053844.12657-1-jhez.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7bCmru7ECXzxBltv6Vsc+reb0eLq0UnM
        Fpd3zWGz+Nx7hNHi9O4SB1aPTas62Tz6tqxi9Pi8SS6AOSrHJiM1MSW1SCE1Lzk/JTMv3VbJ
        OzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdoo5JCWWJOKVAoILG4WEnfzqYov7QkVSEj
        v7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQwMDIFKgyISfjy609jAXL+Cqev41pYFzM08XI
        ySEhYCKx5M9k9i5GLg4hgR2MEtevvWKDcD4xSlz58Y4NpEpI4BujxJ+3lTAdqyb+Y4Qo2sso
        sb11KlT7Z0aJ2e+3sYNUsQloSNxtvscCYosA2U0N0xlBbGaBJIkNd64D2RwcwgIJEqe680DC
        LAKqEvuengMr4RWwlLjw6C0zxDJ5idUbDjCDzJcQ6GeXWN13gw0i4SJx588eJghbWOLV8S3s
        ELaUxMv+NnaoBkaJD2/bobp7gF5Y+ZgVospYorfnAjPIFcwCmhLrd+lDhBUldv6eC3Uon8S7
        rz2sICUSArwSHW1CEKaSxLFV9hDVEhJPvp+HGughsfz2YyZIYMVKbF0yjX0Co+wshPkLGBlX
        MYqlFhTnpqcWGxYYIcfRJkZwItIy28E46e0HvUOMTByMhxglOJiVRHh5uHjjhXhTEiurUovy
        44tKc1KLDzGaAgNsIrOUaHI+MBXmlcQbmhoZGxtbmJiZm5kaK4nz/jvLHi8kkJ5YkpqdmlqQ
        WgTTx8TBKdXAtGy5+8Gj9id/+93ec2Ae2xY3O47fDPMkvzAvjDxgP6vaxGD+bQamrLcP9Vyv
        Zd9lEmue/dnBPtCk+PlO3aqW6duzAz96bnom0sRSJb2hPDOsQUFHf/Hy+ff9ZjLzKBwVOfNs
        auYj6ffxURJZQu3evCuOXGOavJPX73lazK8Zk44uiCyftObtQ6vQSXoXp+7kct1UULxSKlVY
        gL053q6Cl2vupDscn08ENz/fr++4V/RbzIn/SxxWuK69OW+XpaiaX2ay3KFFHZuapkSVN6R2
        GWhNWH6jKcRT5nryHYtT7zf6sfIE+C/asmdC27Snusec/l3Z+f1EVlhmUbFIqNmBp5eCdi/d
        eOxkiJBLicTKfiWW4oxEQy3mouJEAER+QIvNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJMWRmVeSWpSXmKPExsWy7bCSnO7ECXzxBpO3sFkc+reb0eLq0UnM
        Fpd3zWGz+Nx7hNHi9O4SB1aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr48utPYwF
        y/gqnr+NaWBczNPFyMkhIWAisWriP8YuRi4OIYHdjBIfnx1lh0hISBz+cJe1i5EDyBaWOHy4
        GKLmI6PE+sV3wGrYBDQk7jbfYwGxRQS0JBbf3sUGYjMLpEhsO9oHViMsECfx5uhqMJtFQFVi
        39NzjCA2r4ClxIVHb5khdslLrN5wgHkCI88CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6
        yfm5mxjBgaGluYNx+6oPeocYmTgYDzFKcDArifDycPHGC/GmJFZWpRblxxeV5qQWH2KU5mBR
        Eue9UbgwTkggPbEkNTs1tSC1CCbLxMEp1cDUsXE+Y8GUqLBckQ/K6ZWxNddXXQxT/hz31LM1
        k+PAi/RVf2WE1Xdt3iM87fDqT3Vffdj9H7Lk8jX+nBGxqp6ffaKkMKdpSvzvLb8npgqluQV9
        9HkvvkvnXq6a+bYypWexqmf5k7XDDxlpawe0zpzr8GrfuyWczdPbVj4UEd1s5HpyTeFeB+dH
        dzRY38Zmv5i/76FLZsz2BUFHX4udmi/Yrl+hqfhgRsr6A9H52bfiK/29D510Cpg9M+Hjzz6n
        5XH33pxMbCwztMk7nzT9KctX7qWt+7zmb9jF/fZXp6r/1ccc1zfffnTEY+e54grDG5cjjXa6
        lZ2bOjEz58SMa2p3ynU3Rr1pjJn/kWku165pSizFGYmGWsxFxYkA0Y5iRXsCAAA=
X-CMS-MailID: 20200715051353epcas1p46ae6b84555180be315752ef69262dfce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200715051353epcas1p46ae6b84555180be315752ef69262dfce
References: <CGME20200715051353epcas1p46ae6b84555180be315752ef69262dfce@epcas1p4.samsung.com>
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

Reported-by: Jaeho Song <jaeho21.song@samsung.com>
Signed-off-by: Dohyung Kim <dh0703.kim@samsung.com>
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

base-commit: e9919e11e219eaa5e8041b7b1a196839143e9125
--
2.17.1

