Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51117166005
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 15:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgBTOvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 09:51:37 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44628 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgBTOvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 09:51:37 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200220145135euoutp02513b33388fb2aa0d9efd8784a352149a~1I_GaIW9G1134211342euoutp02E
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 14:51:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200220145135euoutp02513b33388fb2aa0d9efd8784a352149a~1I_GaIW9G1134211342euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582210295;
        bh=3TDzl1+xMI630MaOVpLHVpnP1uULofqoBm2yuDXOOUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EtteFiMSazcSDneJt6n9a62BnwHe/6f7vmDQhAX0VfpD90a2fQYh6PwW7CGgfmcKz
         sg1aPrwUuUxZh+gURvoYSII6v6v32J0joTcY+fTrcUwMGQdDA2luITcYPOphXkg0vs
         5aJfjngLBkOcgiTjrzRNcsEANPjq/RGKu2eTZoSI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200220145135eucas1p1bb1e76c09a9782fd79b6511f6b506b5c~1I_GEeXUw0784807848eucas1p1y;
        Thu, 20 Feb 2020 14:51:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D9.E9.61286.7FC9E4E5; Thu, 20
        Feb 2020 14:51:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200220145135eucas1p123c4e4523e7e6eb86b64e728d6931cee~1I_Fv1uvC1193311933eucas1p1j;
        Thu, 20 Feb 2020 14:51:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200220145135eusmtrp102166e8dce9b7231dcccc0e49628850c~1I_FvKojT1377513775eusmtrp1g;
        Thu, 20 Feb 2020 14:51:35 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-38-5e4e9cf7fbb5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 69.C7.07950.7FC9E4E5; Thu, 20
        Feb 2020 14:51:35 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200220145134eusmtip15ecddef884a887b76608a80926b5a8bc~1I_FRHZTW1165111651eusmtip1g;
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
Subject: [PATCH 2/3] extcon: max14577: Add proper dt-compatible strings
Date:   Thu, 20 Feb 2020 15:51:26 +0100
Message-Id: <20200220145127.21273-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220145127.21273-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djP87rf5/jFGUy6qmixccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0WLtkbvsFrcbV7BZnN5d4sDpsWlVJ5tH35ZVjB6fN8kF
        MEdx2aSk5mSWpRbp2yVwZZyctpWtoJGz4vPNDWwNjFfYuxg5OSQETCQ+H+plBLGFBFYwShw+
        lNrFyAVkf2GUOLeqhw3C+cwo0XbkJCNMx+YbZ5kgEssZJf5N28gO1zJ56hawuWwChhJdb7vY
        QGwRASuJ0/87mEGKmAVWMEl8/P2JCSQhLOAuMeHsBrCxLAKqEtt3n2YGsXkFbCXebXoEtU5e
        YvWGA2BxTgE7iUkTJoANkhB4zyaxdN4sIIcDyHGRWNJfAVEvLPHq+Bao52QkTk/uYYGob2aU
        eHhuLTuE08MocblpBtQGa4k7536xgQxiFtCUWL9LHyLsKDFx9x5GiPl8EjfeCoKEmYHMSdum
        Q63llehoE4KoVpOYdXwd3NqDFy4xQ9geEl/ftrBAAmgio8S6Q69YJzDKz0JYtoCRcRWjeGpp
        cW56arFhXmq5XnFibnFpXrpecn7uJkZgkjj97/inHYxfLyUdYhTgYFTi4a1o8IsTYk0sK67M
        PcQowcGsJMKrxgMU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJ
        g1OqgTEx9tua6BLeK/8Wqh7peZWisfK3t9bzWpOVV5e0GDk7HO7Q3iSjzT1pzU/GrpBVict+
        vFR7oc7EVWDdPydg0cXluz+7TpbjyVm6lNtMbc6vl439ayZ7nbb4MMFCi+HYqm2Rn/cr3T3j
        nBWaqRXTHf/wofDKN2+ZQ11V7/8Tur/ZX+egeqtZw2QlluKMREMt5qLiRAB0iC7RDgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t/xu7rf5/jFGbRN4rLYOGM9q8XUh0/Y
        LK5/ec5qcf78BnaLy7vmsFl87j3CaLH2yF12i9uNK9gsTu8uceD02LSqk82jb8sqRo/Pm+QC
        mKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mk5O
        28pW0MhZ8fnmBrYGxivsXYycHBICJhKbb5xl6mLk4hASWMoo8XL7CTaIhIzEyWkNrBC2sMSf
        a11sEEWfGCVeLT0DVsQmYCjR9bYLzBYRsJG4u/gaC0gRs8AaJomGhx+ZQBLCAu4SE85uYASx
        WQRUJbbvPs0MYvMK2Eq82/SIEWKDvMTqDQfA4pwCdhKTJkwAs4WAavZsPMo+gZFvASPDKkaR
        1NLi3PTcYiO94sTc4tK8dL3k/NxNjMCg3Xbs55YdjF3vgg8xCnAwKvHwVjT4xQmxJpYVV+Ye
        YpTgYFYS4VXjAQrxpiRWVqUW5ccXleakFh9iNAU6aiKzlGhyPjCi8kriDU0NzS0sDc2NzY3N
        LJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MJqrfuLN3cqxaK5ctqCXc1X8tgWZjeaXd51b
        cyVHZ6na4sd+k1acqTVn9Dv26nPPurVKHs91H72RM/8m/8n5ReKl3T8WfPZ2bXQ7Z+4RGfhV
        UPaN8w7jwB8NK0NnzJkS7rcnfiJfTc3FSf9m5a/50mTxfvHlU8X/TS3jutlT6/PvvhGbvPvA
        BBMlluKMREMt5qLiRAAWCFMvcAIAAA==
X-CMS-MailID: 20200220145135eucas1p123c4e4523e7e6eb86b64e728d6931cee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200220145135eucas1p123c4e4523e7e6eb86b64e728d6931cee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200220145135eucas1p123c4e4523e7e6eb86b64e728d6931cee
References: <20200220145127.21273-1-m.szyprowski@samsung.com>
        <CGME20200220145135eucas1p123c4e4523e7e6eb86b64e728d6931cee@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device tree compatible strings and create proper modalias structures
to let this driver load automatically if compiled as module, because
max14577 MFD driver creates MFD cells with such compatible strings.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/extcon/extcon-max14577.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index 32f663436e6e..6df814cffe37 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -782,6 +782,15 @@ static const struct platform_device_id max14577_muic_id[] = {
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
-- 
2.17.1

