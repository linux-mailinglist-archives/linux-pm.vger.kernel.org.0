Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A711DE44B
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 12:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgEVKY6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 06:24:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47267 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgEVKY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 06:24:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200522102455euoutp027f8c96e7e8ac565c43c79286c14ae3ca~RUriI5gbw1699016990euoutp02E
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 10:24:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200522102455euoutp027f8c96e7e8ac565c43c79286c14ae3ca~RUriI5gbw1699016990euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590143096;
        bh=7GdZc7Q1b31TFT7pHieX7lbsi1QDWMFXfS2C5GttQMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AkOugaprEG4zfHmg/+SRZLe+Yt/MJNnkx02dt5vpS7rPHntzR10fSdlpt0J1ByeoS
         QGVQR+gNbfRLBSQqHS6xlmxgrXWA67/0ss7xSnhBNXQduBoToN7VkKqTFS3mTvvcZc
         isO7Qrsvo+HsyIvAbFehQJAn0MpNytZh9LnZrlTM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200522102455eucas1p17473a02d5a35a2e60f2a100d3b85ddb6~RUrh85eWL0639106391eucas1p1z;
        Fri, 22 May 2020 10:24:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FA.DB.61286.778A7CE5; Fri, 22
        May 2020 11:24:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200522102455eucas1p24b695b7f6c533681f544be166ea69200~RUrhVJu8C2193621936eucas1p2G;
        Fri, 22 May 2020 10:24:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200522102455eusmtrp1d7cbcc4d5dab5e290cbc5fc8151c4fb0~RUrhUiuhE3194431944eusmtrp1I;
        Fri, 22 May 2020 10:24:55 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-0b-5ec7a8776166
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 41.90.08375.678A7CE5; Fri, 22
        May 2020 11:24:54 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200522102454eusmtip24d25446144283ea17a799844a07f622f~RUrgwsK_Y3179731797eusmtip2f;
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
Subject: [PATCH v3 2/3] extcon: max14577: Add proper dt-compatible strings
Date:   Fri, 22 May 2020 12:24:47 +0200
Message-Id: <20200522102448.30209-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522102448.30209-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7djPc7rlK47HGSw8q2WxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEdx2aSk5mSWpRbp2yVwZdy9+5W94CpXxeGVB9gaGBs5uxg5OSQETCQ6f35k7WLk4hASWMEo
        cXnzFiYI5wujRPP1zywQzmdGiX37P7HAtdx6yQaRWM4o8fP9QUaQBFjL3UnpIDabgKFE19su
        NhBbRMBK4vT/DmaQBmaBFUwSH39/YgJJCAt4SfQ3b2IGsVkEVCWunPgCNIiDg1fAVqLtexHE
        MnmJ1RsOMIOEOQXsJF6eKgYZIyHwnk2if9YeRogaF4nFnU/YIGxhiVfHt7BD2DISpyf3sEA0
        NDNKPDy3lh3C6QF6tGkGVLe1xJ1zv9hANjALaEqs36UPEXaU6F+/G+weCQE+iRtvBUHCzEDm
        pG3TmSHCvBIdbUIQ1WoSs46vg1t78MIlZgjbQ+LtvAPQQJzIKPFo5gP2CYzysxCWLWBkXMUo
        nlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYIk7/O/5pB+PXS0mHGAU4GJV4eB8kH4sTYk0s
        K67MPcQowcGsJMK7kP9onBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtS
        i2CyTBycUg2MU8QtOnLkPLX676cfSgn5qMe93fDb54rbh//v57jQsSbeJHm5Mse3UnautGXS
        GR+S9ywwv3hmR0t5frj6CfGb/9Yub5m3XZXLoV25ePbnzIQCVR3//+cfWK9Zc8gmnGN+tOJB
        rxkX1wsFXDtxJyTtlh1PY/Oz47uY3db41sc9Pn92ScKtHPedSizFGYmGWsxFxYkAY/KUfg0D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsVy+t/xe7plK47HGay7ZW2xccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZdy9
        +5W94CpXxeGVB9gaGBs5uxg5OSQETCQ6b71k62Lk4hASWMoo8bzxGStEQkbi5LQGKFtY4s+1
        LqiiT4wSU773MIIk2AQMJbregiQ4OUQEbCTuLr7GAlLELLCGSaLh4UcmkISwgJdEf/MmZhCb
        RUBV4sqJL0DNHBy8ArYSbd+LIBbIS6zecIAZJMwpYCfx8lQxSFgIqOL3rhlsExj5FjAyrGIU
        SS0tzk3PLTbUK07MLS7NS9dLzs/dxAgM2G3Hfm7ewXhpY/AhRgEORiUe3gfJx+KEWBPLiitz
        DzFKcDArifAu5D8aJ8SbklhZlVqUH19UmpNafIjRFOikicxSosn5wGjKK4k3NDU0t7A0NDc2
        NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAqPk2bTaH8NN7LsUCG1aH3WqV7Hzp8MKF
        91PLod0N607yHI40nmhs9EC86Ur/f7euvNCLEybOCGpbcFyksm+p7qujYhdMlx472nCJN6vG
        Z2ne5VW/r4SdLNi5kv3bzfvZs4SjV0o1RhxPTq39u//9qcWz648V/Xb5Pb/G/q7tjRRjo5Ps
        uZdkg5RYijMSDbWYi4oTAQGsRlxuAgAA
X-CMS-MailID: 20200522102455eucas1p24b695b7f6c533681f544be166ea69200
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200522102455eucas1p24b695b7f6c533681f544be166ea69200
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200522102455eucas1p24b695b7f6c533681f544be166ea69200
References: <20200522102448.30209-1-m.szyprowski@samsung.com>
        <CGME20200522102455eucas1p24b695b7f6c533681f544be166ea69200@eucas1p2.samsung.com>
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
- sorted of_max14577_muic_dt_match
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
+	{ .compatible = "maxim,max14577-muic",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
+	{ .compatible = "maxim,max77836-muic",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
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

