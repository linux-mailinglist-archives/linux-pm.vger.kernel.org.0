Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082421DE020
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 08:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgEVGsL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 02:48:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49314 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgEVGsK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 02:48:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200522064808euoutp01e9a1dd48245e5bc1c54dc81fb2342dc5~RRuP1751l1773017730euoutp01y
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 06:48:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200522064808euoutp01e9a1dd48245e5bc1c54dc81fb2342dc5~RRuP1751l1773017730euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590130088;
        bh=0hTQEWKi7wyPheUKypdmxyoqMIZkEY5Zo1t9O0iqJzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpqTIFQMQ7vB98GDjvhyFCcygIE7BHDgubM9BWyjZT1fekHXezQGthdlWLoKf6Z1y
         UMDah4w2lzVSwB0vI0dw6q0kk+ODymYcO7HMe9Ty/cInY1jxPEb4jgdfMB87usaA0A
         ZvZEspOm/MYU7jFA0yWgO5woRodVb25UQHYRVnKw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200522064808eucas1p1f1d76ee9c7475cb53a278537fcfb4108~RRuPq2bx92618726187eucas1p1F;
        Fri, 22 May 2020 06:48:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 99.63.60679.8A577CE5; Fri, 22
        May 2020 07:48:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200522064807eucas1p2db9a6fe5599cc9d58ea1fb2d9acc36c7~RRuPT8zLF0152701527eucas1p2_;
        Fri, 22 May 2020 06:48:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200522064807eusmtrp2747a7d61f66f578f4346d579348d947e~RRuPTT_E80701807018eusmtrp2S;
        Fri, 22 May 2020 06:48:07 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-ed-5ec775a804c7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.F3.08375.7A577CE5; Fri, 22
        May 2020 07:48:07 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200522064807eusmtip2c59700c0c307d6aefbf730cb88791f9a~RRuOu9uog2856928569eusmtip2S;
        Fri, 22 May 2020 06:48:07 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/3] power: charger: max14577: Add proper dt-compatible
 strings
Date:   Fri, 22 May 2020 08:48:01 +0200
Message-Id: <20200522064801.16822-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522064801.16822-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djPc7orSo/HGTx5yWaxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEdx2aSk5mSWpRbp2yVwZaw9co6x4D1XxbYTq9gaGBdxdjFyckgImEi8/raApYuRi0NIYAWj
        ROfzl4wQzhdGiR83pkBlPjNKHH7yhx2mZXffU6jEckaJZe9essC1PDxxkBWkik3AUKLrbRcb
        iC0iYCVx+n8HM0gRs8AKJomPvz8xgSSEBUIkTqx7ywJiswioSizZsg9oBQcHr4CtxNEJoRDb
        5CVWbzjADGJzCthJTDjyBmyOhMB7NokFp/uYQeolBFwk9n6PhKgXlnh1fAvUpTIS/3fOZ4Ko
        bwY67txadginh1HictMMRogqa4k7536xgQxiFtCUWL9LHyLsKPHg4wR2iPl8EjfeCoKEmYHM
        SdumQ63llehoE4KoVpOYdXwd3NqDFy4xQ9geEs9mP2KDhM9ERok17TeZJjDKz0JYtoCRcRWj
        eGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgkjj97/iXHYy7/iQdYhTgYFTi4X2QfCxOiDWx
        rLgy9xCjBAezkgjvQv6jcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1I
        LYLJMnFwSjUwljX1TazWrGL90XSBL1ixuSy2a8Pq8pdzDx9+XTq9rMNETpB1/8eLbMtTj+a5
        vi+OdXXLPrf74W9+9vh1tX+iQnMKX9zfz/A28qRcose9CWWvPsV15/qwKC9lcxS9FhkywVfw
        Zm+wfgF/8/LcmSd8n6ZwH1uzdP3PcvFdF2XMdL6ulr5zvc1NiaU4I9FQi7moOBEAb/LaKQ4D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsVy+t/xe7rLS4/HGbT+U7fYOGM9q8XUh0/Y
        LK5/ec5qcf78BnaLy7vmsFl87j3CaLH2yF12i9uNK9gsTu8uceD02LSqk82jb8sqRo/Pm+QC
        mKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MtYe
        OcdY8J6rYtuJVWwNjIs4uxg5OSQETCR29z1l6WLk4hASWMooMaflOjNEQkbi5LQGVghbWOLP
        tS42EFtI4BOjxITjgSA2m4ChRNdbiLiIgI3E3cXXwAYxC6xhkmh4+JEJJCEsECRx7O8adhCb
        RUBVYsmWfUA2BwevgK3E0QmhEPPlJVZvOAC2l1PATmLCkTfMELtsJe7PX8UygZFvASPDKkaR
        1NLi3PTcYkO94sTc4tK8dL3k/NxNjMCA3Xbs5+YdjJc2Bh9iFOBgVOLhfZB8LE6INbGsuDL3
        EKMEB7OSCO9C/qNxQrwpiZVVqUX58UWlOanFhxhNgW6ayCwlmpwPjKa8knhDU0NzC0tDc2Nz
        YzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MgTWHr4Qufq8ir92t+IDd827GXj2//j/L
        HFKzCmv/xmZlHjlo2xfXZCMrG5HRccq58Ozjivz1p758iud5vur8kk1z6wtL7suHdgi5dQlt
        leV67OP0mXXBXEf52+ZzTyxiNSv6c6RBpbV6tmf5K73bfTce7lIWlL/q79y69b5mhjyD4d03
        RmuVWIozEg21mIuKEwHHRVwEbgIAAA==
X-CMS-MailID: 20200522064807eucas1p2db9a6fe5599cc9d58ea1fb2d9acc36c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200522064807eucas1p2db9a6fe5599cc9d58ea1fb2d9acc36c7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200522064807eucas1p2db9a6fe5599cc9d58ea1fb2d9acc36c7
References: <20200522064801.16822-1-m.szyprowski@samsung.com>
        <CGME20200522064807eucas1p2db9a6fe5599cc9d58ea1fb2d9acc36c7@eucas1p2.samsung.com>
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
+	{ .compatible = "maxim,max77836-charger",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
+	{ .compatible = "maxim,max14577-charger",
+	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
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

