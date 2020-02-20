Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31244166007
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 15:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBTOvu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 09:51:50 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44634 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgBTOvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 09:51:37 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200220145136euoutp022fcbd9861befed7266dbf3973cab7fd5~1I_Guj8wo1100211002euoutp02O
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 14:51:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200220145136euoutp022fcbd9861befed7266dbf3973cab7fd5~1I_Guj8wo1100211002euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582210296;
        bh=YqMtfkiBvVHazwIHeJte8dn8ntnJBx4eD3U4pauHQgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwuR9dK7TdjAucm5jXqEcHYLlB25aRBgFYlMIRKkpp3h0+jFSk8b1/M8f3R6OESWX
         k6pjGBTMBxvNxpx3PEIdhDwB/npPpVHzja+xWNoeo3toIwObly9cQKBvLwgpGAiWBW
         4G5jOBp3Tchbk1YoLhdMJ8pWH67gAP7hORi3F9NY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200220145136eucas1p2157af29c7f8ac975cec9c637e6f09227~1I_GfsEhs1366513665eucas1p2R;
        Thu, 20 Feb 2020 14:51:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2B.E9.61286.7FC9E4E5; Thu, 20
        Feb 2020 14:51:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200220145135eucas1p1ba181cef65c7a4f91a254ee35e022f08~1I_GHmd8a0784307843eucas1p1q;
        Thu, 20 Feb 2020 14:51:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200220145135eusmtrp1c6139c2fac24f47dfd1498dabfdcea47~1I_GHBU3K1377513775eusmtrp1i;
        Thu, 20 Feb 2020 14:51:35 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-3b-5e4e9cf7113d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1A.C7.07950.7FC9E4E5; Thu, 20
        Feb 2020 14:51:35 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200220145135eusmtip1533674ec21b81c7b6fc98ae954eb47e2~1I_FsqLqD1163211632eusmtip1h;
        Thu, 20 Feb 2020 14:51:35 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] power: charger: max14577: Add proper dt-compatible
 strings
Date:   Thu, 20 Feb 2020 15:51:27 +0100
Message-Id: <20200220145127.21273-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220145127.21273-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djPc7rf5/jFGazYZWWxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEdx2aSk5mSWpRbp2yVwZfyaN42tYDdnRV/fK7YGxn6OLkZODgkBE4kJW7vZQWwhgRWMEgs3
        h3YxcgHZXxgltnS2s0A4nxklfj+eAFTFAdbx6Y4uRHw5o8TJD69Z4TqeTJ3KAjKKTcBQoutt
        FxuILSJgJXH6fwczSBGzwAomiY+/PzGBJIQFAiXerXsKZrMIqErM27mVFcTmFbCV+D9tGTvE
        ffISqzccYAaxOQXsJCZNmAA2SELgPZvE3vUr2SCKXCSWT/zFCGELS7w6vgWqWUbi9OQeFoiG
        ZkaJh+fWskM4PYwSl5tmQHVYS9w594sN5DlmAU2J9bv0IcKOEi0z1zNC/MwnceOtIEiYGcic
        tG06M0SYV6KjTQiiWk1i1vF1cGsPXrjEDGF7SCz6PIsREkITGSVerTrGPoFRfhbCsgWMjKsY
        xVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECk8Tpf8c/7WD8einpEKMAB6MSD29Fg1+cEGti
        WXFl7iFGCQ5mJRFeNR6gEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KL
        YLJMHJxSDYxcgltZK5aUuBxnmq+85pF6Uqimpu8kDbW7f1dsvjzHdLFjZvANncXHpk9f2H/k
        5WvbEK6fJwM9VdSSTHe+ObPkbsVm71WH1n3S95dyP+L87AELH8Ms9Y9ipf+7922KFvxUlJLy
        u5OPt2/nrP60j2WcEv92qDS2Ohx4X+zAZvT8x4btv1bXrL+sxFKckWioxVxUnAgAdhy0yg4D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t/xu7rf5/jFGfxvULHYOGM9q8XUh0/Y
        LK5/ec5qcf78BnaLy7vmsFl87j3CaLH2yF12i9uNK9gsTu8uceD02LSqk82jb8sqRo/Pm+QC
        mKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mn7N
        m8ZWsJuzoq/vFVsDYz9HFyMHh4SAicSnO7pdjFwcQgJLGSW+vJ7M2sXICRSXkTg5rQHKFpb4
        c62LDaLoE6PEzX+7WUASbAKGEl1vQRKcHCICNhJ3F19jASliFljDJNHw8CMTSEJYwF/i+o5z
        7CA2i4CqxLydW8Gm8grYSvyftowdYoO8xOoNB5hBbE4BO4lJEyaA2UJANXs2HmWfwMi3gJFh
        FaNIamlxbnpusZFecWJucWleul5yfu4mRmDIbjv2c8sOxq53wYcYBTgYlXh4Kxr84oRYE8uK
        K3MPMUpwMCuJ8KrxAIV4UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5HxhPeSXxhqaG5haWhubG
        5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGE/Vza74Nk9/VsXBq2dn1lZ8PFpT9sX2
        nF7uNyO59RWzVnXxWQmkyoisC+tfmFI4MUdYlrV9rqCPa/yE6V3vv7gnrPu0N332n//9x9wE
        V3ZxntNlUk3kcdovUJ6998CzDZv0npkGevO+8N1edLU5P+HwryvWwu/3Wszc8HKihXtVY8ER
        nlqTSCWW4oxEQy3mouJEAIuZGm1vAgAA
X-CMS-MailID: 20200220145135eucas1p1ba181cef65c7a4f91a254ee35e022f08
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200220145135eucas1p1ba181cef65c7a4f91a254ee35e022f08
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200220145135eucas1p1ba181cef65c7a4f91a254ee35e022f08
References: <20200220145127.21273-1-m.szyprowski@samsung.com>
        <CGME20200220145135eucas1p1ba181cef65c7a4f91a254ee35e022f08@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device tree compatible strings and create proper modalias structures
to let this driver load automatically if compiled as module, because
max14577 MFD driver creates MFD cells with such compatible strings.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/power/supply/max14577_charger.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index 8a59feac6468..891ba9f6f295 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -623,6 +623,15 @@ static const struct platform_device_id max14577_charger_id[] = {
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
-- 
2.17.1

