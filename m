Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60420166000
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 15:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBTOvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 09:51:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53690 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgBTOvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 09:51:37 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200220145135euoutp0113f04cccdf8f79732261545f8bad561e~1I_GH2pJj0558305583euoutp01-
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 14:51:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200220145135euoutp0113f04cccdf8f79732261545f8bad561e~1I_GH2pJj0558305583euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582210295;
        bh=31rmtxOfkOASOvw2DeQhk/to6JwtWb8Z/jmhWawXvnI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KMYMBdsgtt2BjBkAfSqfTuonQOXaWRv02vYejms4G1IzMvgD8cMAjm8QioH39ntng
         16vYfefuCY/wdDrFhliAOKOcTO7QNoCsyskdb/+iHsyJPXbUhbLeVJgz7oMvXxvHVz
         UgRh3wVjsovsSmNjIbG4FUoNWflbcWMP4M2jsY9E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200220145135eucas1p1c3c6c3fd13e5580cb159722a3d8efeb2~1I_F177Uc0784807848eucas1p1w;
        Thu, 20 Feb 2020 14:51:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 29.E9.61286.7FC9E4E5; Thu, 20
        Feb 2020 14:51:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45~1I_FTtluh1480814808eucas1p2S;
        Thu, 20 Feb 2020 14:51:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200220145134eusmtrp102faa4c0b7c8c492e2d69a25198fc0b7~1I_FTDkBX1371113711eusmtrp19;
        Thu, 20 Feb 2020 14:51:34 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-36-5e4e9cf7e0cf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BE.5A.08375.6FC9E4E5; Thu, 20
        Feb 2020 14:51:34 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200220145134eusmtip18cbc83e1398035c3526bcf8ab5ba9057~1I_E3Vml21164811648eusmtip1i;
        Thu, 20 Feb 2020 14:51:34 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] regulator: max14577: Add proper dt-compatible strings
Date:   Thu, 20 Feb 2020 15:51:25 +0100
Message-Id: <20200220145127.21273-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWy7djPc7rf5/jFGRz+wWuxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEdx2aSk5mSWpRbp2yVwZTQcusZWcJKzor2xgb2BcRZHFyMnh4SAicSetVMYuxi5OIQEVjBK
        fOjfAuV8YZRYsmY+M4TzmVHi4eMpTDAtj+eeYwaxhQSWM0qceMwB19G06jJYgk3AUKLrbRcb
        iC0iYCVx+n8H2CRmgRVMEh9/fwKaxMEhLOAl8fsOJ4jJIqAqMWELD0g5r4CtRM+z+6wQu+Ql
        Vm84ANYqIXCdTeLSu4vsEAkXidaemSwQtrDEq+NboOIyEqcn97BANDQDXX1uLTuE08Mocblp
        BiNElbXEnXO/2EA2MwtoSqzfpQ8RdpS4MOUc2G0SAnwSN94KgoSZgcxJ26YzQ4R5JTrahCCq
        1SRmHV8Ht/bghUvMELaHROeZT+wg5UICsRL3jjNNYJSbhbBqASPjKkbx1NLi3PTUYsO81HK9
        4sTc4tK8dL3k/NxNjMA0cPrf8U87GL9eSjrEKMDBqMTDW9HgFyfEmlhWXJl7iFGCg1lJhFeN
        ByjEm5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QD49yLSuVu
        L3dHlF1tW25ho1iXbi+Xv5DnbXmPesmyBJ6UvxbL7Z7wr8lf16/tWtRwzn2bhsIzjl+TvcSm
        sGavimGpPlt/oU5bOpZN4b82o1LqtmlvbxattDPWLZ/8zVBz7eKq0odiJW83LsjnXXJTQaF7
        iq5XUuL2EybfijOSos4X/XRuc1mjxFKckWioxVxUnAgAUE/fp/8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsVy+t/xu7rf5vjFGfy5rGWxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZTQc
        usZWcJKzor2xgb2BcRZHFyMnh4SAicTjueeYQWwhgaWMEjPulULEZSROTmtghbCFJf5c62Lr
        YuQCqvnEKHHr6yoWkASbgKFE11uQBCeHiICNxN3F11hAipgF1jBJNDz8yNTFyMEhLOAl8fsO
        J4jJIqAqMWELD0g5r4CtRM+z+1Dz5SVWbzjAPIGRZwEjwypGkdTS4tz03GJDveLE3OLSvHS9
        5PzcTYzA8Nt27OfmHYyXNgYfYhTgYFTi4a1o8IsTYk0sK67MPcQowcGsJMKrxgMU4k1JrKxK
        LcqPLyrNSS0+xGgKtHsis5Rocj4wNvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqem
        FqQWwfQxcXBKNTBGd3eExi9d2r5I7KoQd8scRxOxKU0fn1b473iyRH71nbPzjoneUl63r83T
        1ym4u8778IITr5foLH4/85FJfC53b5P3plmbElrN9ni8MJKo6Gr1UNe8sIvpvQ7Th2sLn23W
        cpizWIz7+8ZDPNKbK889qvt4mWvB2kfJfdMDl7/TOuhnyeQlGTxNiaU4I9FQi7moOBEAEdSR
        dlUCAAA=
X-CMS-MailID: 20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45
References: <CGME20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device tree compatible strings and create proper modalias structures
to let this driver load automatically if compiled as module, because
max14577 MFD driver creates MFD cells with such compatible strings.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/max14577-regulator.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index 07a150c9bbf2..19e779dd961e 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -238,6 +238,15 @@ static const struct platform_device_id max14577_regulator_id[] = {
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
 		   .name = "max14577-regulator",
-- 
2.17.1

