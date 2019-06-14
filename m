Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D904597D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfFNJx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:53:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54583 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfFNJxb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095330euoutp022e78668b825f4961759b47bdbb8cb0d3~oB-Lq21NA1627116271euoutp02h
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190614095330euoutp022e78668b825f4961759b47bdbb8cb0d3~oB-Lq21NA1627116271euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506010;
        bh=UBJ3ezgLAW9CV2O9TqzTmKdZoxg8g/WoDRJ0caW6E6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxDVUCMHZI5qE/wC9K29i6POoMEoyx4OEQAPU3da0KadGYd371vOUAX8OQssNmGLj
         X7May+uFBxZxVT6zgGk9gsxwaUdKhHSDFRvzIyjCD8EiqVTPYvOODyMuXhiplFaR/V
         l3e5O0Srp/hk2+c3ymmImY5WqBiL8mzL3EzkCAiU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614095329eucas1p1ce98ae0453967f72dab00ca69068bc85~oB-K1HjZK1141711417eucas1p1W;
        Fri, 14 Jun 2019 09:53:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FC.A5.04298.99E630D5; Fri, 14
        Jun 2019 10:53:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095328eucas1p24009b3a07322fd12e49eabb7a08baf50~oB-J7Rtcl0493104931eucas1p25;
        Fri, 14 Jun 2019 09:53:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095328eusmtrp2e16c99128fd715a5312311308359cedc~oB-JrfYXQ2148521485eusmtrp2D;
        Fri, 14 Jun 2019 09:53:28 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-38-5d036e99c865
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 77.EA.04140.89E630D5; Fri, 14
        Jun 2019 10:53:28 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095327eusmtip28d79fb68cdea7e6eabe17dc35d640884~oB-IulCQZ2266622666eusmtip21;
        Fri, 14 Jun 2019 09:53:27 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        gregkh@linuxfoundation.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v10 09/13] drivers: devfreq: events: add Exynos PPMU new
 events
Date:   Fri, 14 Jun 2019 11:53:05 +0200
Message-Id: <20190614095309.24100-10-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTURT1dToLSMlYUV7ciFUSIFps4vICrokmo8ZEQvhQg1p1WCIt0AEV
        8aOCuIAVBUEWoRhUtEAKlGAVEGQRA0hBDBIRg2KUyKK0IG4ptp2qf+eee8495yWPwsRD+CIq
        UhnHqpTyKAnhKqx5+sO0OleJha65bV6JKnP0OHo19QlH2pYuHJVODgOUXKwnUGZ7gQB1pilQ
        +vAohkymChI9Txoj0Wv1EjR5+S2Oeh/dJJBF0wJQjumxAJW3DJKop30HGjh7j0DNYxdwZO2r
        FKKGl7vQwC939O3Ze7DVk/k2nSFkvvSnkEy+ukfIPMwbJJkq3SWCaSgoIxlN8gTBPJmoEzBX
        qnWAMXQkMpaqZXvn7nfdeIyNijzBqvw3H3aNqE8Ni/lBnGrtTCPV4CeeClwoSK+FPer3IBW4
        UmL6HoCTfR8E/DAFYPvH7wQ/WAAc784S/LWkjBY5VSUA1n41Cv9ZrIUlNgtFEbQUGnWxdoMH
        nQNg/kiwXYPRDzA4PvAG2Bfz6SDYZbnrwELaG1Z11TpKieit8H6mGePTvGBpRaMDu9j4Vu2Y
        oxKkNRRMyr7jCIP0dmh4F8Dr58PPbdUkj5fA2YdaZ2sOqjW3AI/PwOH0AqcmEDa39eD2Mxjt
        C/WP/Hl6GyxsnBHw191h//g8O43ZYEbNDYynRfDieTGv9oHVl7udQQthSVm28zgDZ2avOx4l
        pjMBvFsXdxV45f3PKgJABzzZeE4RznIyJXtSyskVXLwyXHo0WlEFbP+uw9pmNoLpF0eaAE0B
        iZuoMUAQKsblJ7gERROAFCbxEBUGYqFi0TF5wmlWFX1IFR/Fck1gMSWUeIoS5wwdENPh8jj2
        OMvGsKq/WwHlskgNlCEXKsUbFjS4rT/gq1l1zVzuoz8XNFPry2XvK0o5lJVl3OCV36o/eL+4
        YMXOpUX+m46QZ0JiR2SN/YZOWWWxdvevvIw9Ku+PYZuTDWUnp7ckpgUePOwevFyaWppdERE4
        tE5Wr/HLjSmt8Tl//ep4sl+nYdb4O7035E6Am4r1MFr3S4RchFzmh6k4+R9siQ0rcwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7oz8phjDWbNUrbYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y9jblVbwk63i6Jlu9gbGX6xdjJwcEgImEq2vFzB1MXJxCAksZZR4dGY3C0RCTGLSvu3sELaw
        xJ9rXWwQRZ8YJaYvPw+U4OBgE9CT2LGqECQuIjCHUeJn1zZGEIdZ4CyzxO4Vb5hAuoUF/CUO
        n33HBmKzCKhKbDq3G2w1r4CDxMrJn5ghNshLrN5wAMzmBIofnf+GDWSBkIC9xPcZ/BMY+RYw
        MqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjMFtx35u2cHY9S74EKMAB6MSD+8BK6ZYIdbE
        suLK3EOMEhzMSiK886yZY4V4UxIrq1KL8uOLSnNSiw8xmgLdNJFZSjQ5H5ge8kriDU0NzS0s
        Dc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MOqfY/wVKtkUaRbz7vZFN7a2DZOl
        X3bt1eL5lzifd6Hlc/fGlrMPnORfbPh9OfDi4yc1UX/+b34vouqwttB/WuASl6ev/XaH/y/T
        Mlns/lv8sY5UfKq78m3Jzvg9vb/efWhnPDFtmdWjeSni7OdVpDjvv2v7G9fH2Jh56+zleBO9
        a7HP5rV/jVJiKc5INNRiLipOBAAbKQBQ1wIAAA==
X-CMS-MailID: 20190614095328eucas1p24009b3a07322fd12e49eabb7a08baf50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095328eucas1p24009b3a07322fd12e49eabb7a08baf50
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095328eucas1p24009b3a07322fd12e49eabb7a08baf50
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095328eucas1p24009b3a07322fd12e49eabb7a08baf50@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Define new performance events supported by Exynos5422 SoC counters.
The counters are built-in in Dynamic Memory Controller and provide
information regarding memory utilization.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index c2ea94957501..ce658c262c27 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -89,6 +89,12 @@ static struct __exynos_ppmu_events {
 	PPMU_EVENT(d1-cpu),
 	PPMU_EVENT(d1-general),
 	PPMU_EVENT(d1-rt),
+
+	/* For Exynos5422 SoC */
+	PPMU_EVENT(dmc0_0),
+	PPMU_EVENT(dmc0_1),
+	PPMU_EVENT(dmc1_0),
+	PPMU_EVENT(dmc1_1),
 };
 
 static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
-- 
2.17.1

