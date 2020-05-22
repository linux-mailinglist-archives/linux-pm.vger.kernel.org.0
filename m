Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34971DE449
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 12:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgEVKY4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 06:24:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47257 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbgEVKYz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 06:24:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200522102453euoutp02497da571cf38c6544c3700752a6e9b6f~RUrgCZRDU1688016880euoutp02Z
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 10:24:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200522102453euoutp02497da571cf38c6544c3700752a6e9b6f~RUrgCZRDU1688016880euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590143093;
        bh=yuGCISGtXXxk6Kjio358dgLlQzOgYeCxLlP5RCiJcTI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lvPtxQHRGm0UQNAxNaTOiiHJDFc98wPpB1X2Ux25vfu4l2rBO2TonOHkLkVa8ai0Y
         V2+S/7y4Q8u+0+KzboWS53Nku/TYpoDdLfi/IfM0VFp6NuYJusk8gxYShDvnYb/bBp
         JbZa+z11/aqDdejVO0OdoTj/BzPkAzhudFX7Msvk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200522102453eucas1p2e01a743f877ded1d3cf5c0ca6f29258b~RUrfqX0B41398613986eucas1p2u;
        Fri, 22 May 2020 10:24:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 79.60.60698.578A7CE5; Fri, 22
        May 2020 11:24:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200522102452eucas1p17c18de8f79e27de96474e5fcad6db5fa~RUrfSQnq13204332043eucas1p1A;
        Fri, 22 May 2020 10:24:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200522102452eusmtrp17c082c7b0eaf39af67b0c9a15b5384b2~RUrfRneKU3174731747eusmtrp1g;
        Fri, 22 May 2020 10:24:52 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-cf-5ec7a875664b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3E.BC.07950.478A7CE5; Fri, 22
        May 2020 11:24:52 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200522102452eusmtip286193654d8815aef3f5bc3f03cdc76d8~RUreqrkO90298302983eusmtip2q;
        Fri, 22 May 2020 10:24:52 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 1/3] regulator: max14577: Add proper dt-compatible
 strings
Date:   Fri, 22 May 2020 12:24:46 +0200
Message-Id: <20200522102448.30209-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7djP87qlK47HGeyZz2exccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEdx2aSk5mSWpRbp2yVwZbye8IO94At3xc7LZg2M/VxdjJwcEgImEjNOLWQCsYUEVjBKrL0c
        1sXIBWR/YZTY+3Y6E4TzmVFiUd9eVpiOtkUvWSESyxkldl1cyA7Xcn3eWrBZbAKGEl1vu9hA
        bBEBK4nT/zuYQYqYBVYwSXz8/QmsSFjAX+LX2dfsIDaLgKpEw6MVjCA2r4CtxOJ7n5kh1slL
        rN5wAKxZQuA6m8TVFUuhEi4SP2augLpJWOLV8S3sELaMxOnJPSwQDc2MEg/PrWWHcHoYJS43
        zWCEqLKWuHPuF9B9HEA3aUqs36UPEXaUePn4CDtIWEKAT+LGW0GQMDOQOWnbdGaIMK9ER5sQ
        RLWaxKzj6+DWHrxwCeo0D4l/h6aygpQLCcRKLN4QO4FRbhbCqgWMjKsYxVNLi3PTU4uN81LL
        9YoTc4tL89L1kvNzNzECE8Hpf8e/7mDc9yfpEKMAB6MSD69F2rE4IdbEsuLK3EOMEhzMSiK8
        C/mPxgnxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAuL4z
        +lPy2Z0iKjtX9Tv/DxS9WeO9T91R+UfAnUbf1x96u0X5dM83nKntffj12yvts4f1ZzmICt78
        eSB2V4vxmrvd+x00az+08vhOkUrXmbbmatQijbAVf062Bq9PVLv5fFtN8urXa9RU/802k29a
        +WHqaealGvIC2lW94j93y/VujpoS+zmWQ4mlOCPRUIu5qDgRALZSyS8AAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xe7olK47HGTxv0LXYOGM9q8XUh0/Y
        LK5/ec5qcf78BnaLy7vmsFl87j3CaLH2yF12i9uNK9gsTu8uceD02LSqk82jb8sqRo/Pm+QC
        mKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Ml5P
        +MFe8IW7YudlswbGfq4uRk4OCQETibZFL1m7GLk4hASWMkrM+LKdHSIhI3FyWgMrhC0s8eda
        FxtE0SdGiVeN71lAEmwChhJdb0ESnBwiAjYSdxdfYwEpYhZYwyTR8PAjE0hCWMBX4uq7WWCT
        WARUJRoerWAEsXkFbCUW3/vMDLFBXmL1hgPMExh5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dL
        zs/dxAgMwW3Hfm7Zwdj1LvgQowAHoxIP74PkY3FCrIllxZW5hxglOJiVRHgX8h+NE+JNSays
        Si3Kjy8qzUktPsRoCrR8IrOUaHI+MD7ySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGan
        phakFsH0MXFwSjUwurZs2tPadF9I1FNoEo95zeH8qU7SLJMeWO3YcrWv6OXD1wxnG/fO/POs
        +tL0/EWaE6UOdrqcNYtrmKmgdZ9rpsGCR2Jxy5IYTrF1BB5exrrq8VNO7Ut2FT/fTtgZNZl9
        w8df4ipfLkt0168NTuaSe9R8g7VdiXGpXbvltbVSSQ+dciQrN7jMVmIpzkg01GIuKk4EAFdD
        eIdXAgAA
X-CMS-MailID: 20200522102452eucas1p17c18de8f79e27de96474e5fcad6db5fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200522102452eucas1p17c18de8f79e27de96474e5fcad6db5fa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200522102452eucas1p17c18de8f79e27de96474e5fcad6db5fa
References: <CGME20200522102452eucas1p17c18de8f79e27de96474e5fcad6db5fa@eucas1p1.samsung.com>
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
- sorted of_max14577_regulator_dt_match
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
+	{ .compatible = "maxim,max14577-regulator",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
+	{ .compatible = "maxim,max77836-regulator",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
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

