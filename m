Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81B3146BE0
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 15:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAWOxe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 09:53:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44763 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgAWOxe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 09:53:34 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200123145333euoutp0207714d562df0b2c5cd02e807fc9252ee~si70RWMVK1739317393euoutp02j
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2020 14:53:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200123145333euoutp0207714d562df0b2c5cd02e807fc9252ee~si70RWMVK1739317393euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579791213;
        bh=Zj9SGg4W8FGzvWUQwtrRGP6fordYE7UZIdbAgofZujY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmLIPvhaNhVKAQuELe7q5wNYebN/LkLw7JXpzGiuV+6Ls6Xu+bTYkUULRzIdazQYi
         8a3l9RqFgJgSFPZE7rA+ghyXvAHibSXGRBypcU0xCcbzAY5IqboQPhl06TnrWcG8qI
         C1/QYtClfdfjr6T11QwDLnUj35KmcRjggE7OcGy8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200123145332eucas1p222754f6a1aeff09800b7e2e5ea57af69~si7zd1A3D3019730197eucas1p2K;
        Thu, 23 Jan 2020 14:53:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 93.8B.61286.C63B92E5; Thu, 23
        Jan 2020 14:53:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200123145332eucas1p2110419ac74304cd32879bddcce0a950f~si7zLRfiR1349913499eucas1p2b;
        Thu, 23 Jan 2020 14:53:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200123145332eusmtrp13284313bae9044626f4a4794b4305a9d~si7zKsRbZ2757127571eusmtrp1V;
        Thu, 23 Jan 2020 14:53:32 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-23-5e29b36cedfb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9E.93.08375.C63B92E5; Thu, 23
        Jan 2020 14:53:32 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200123145331eusmtip2fa32f40a2a9c721d6d87452d4af0946c~si7ysLU8H1819418194eusmtip2h;
        Thu, 23 Jan 2020 14:53:31 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 3/3] PM / devfreq: exynos-nocp: change load and total
 calculations
Date:   Thu, 23 Jan 2020 15:53:13 +0100
Message-Id: <20200123145313.27539-4-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200123145313.27539-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7o5mzXjDF70yVtsnLGe1WLBpxms
        Fv2PXzNbnD+/gd3ibNMbdovLu+awWXzuPcJosfbIXXaL240r2Bw4PTat6mTz6NuyitHj8ya5
        AOYoLpuU1JzMstQifbsErozrU16zFNxSqug81s/awLhcpouRk0NCwESi+8xhxi5GLg4hgRWM
        Eseev2WGcL4wSrztuMsE4XxmlPj0oJcNpmXKgVNQLcsZJabt70NoWfBjDgtIFZuAvsTBsyfB
        bBEBaYnORRPBRjEL7GeS2HTpDTNIQlggRGLHqqdMIDaLgKrEtafvGEFsXgEbiXOPlzNCrJOX
        mN14Gmw1p4CtxNQHC9kgagQlTs58AraAGaimeetsZoj6bnaJO8s4IWwXidmfTjFB2MISr45v
        YYewZSROT+5hgbDLJZ4u7GMHOU5CoIVR4kH7R6iEtcSdc7+AlnEALdCUWL9LHyLsKHFzw2sm
        kLCEAJ/EjbeCECfwSUzaNp0ZIswr0dEmBFGtKvH8VA/UBdISXf/XsULYHhI/Pm1hnMCoOAvJ
        M7OQPDMLYe8CRuZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgcnm9L/jn3Ywfr2UdIhR
        gINRiYdXolczTog1say4MvcQowQHs5IIL2MYUIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKX
        sUIC6YklqdmpqQWpRTBZJg5OqQZG8zmbN97sfjZvw4P5J3wOl8sxMt9qP3X2W5j0Au8b9WXX
        V+9R3Gu0+laQxR35fE211Qvm/FeTK/f+p/z55sUcXT1uzuQzKtvSn9gvtrw2UdO68lZh8YL4
        TaZbgm8sUpkY+6R09hzBXob/O2QEp57QnSO1/s296OB9jlyb/E/o77nKK1p963TpUiWW4oxE
        Qy3mouJEAOTevQwyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4Pd2czZpxBgfm8ltsnLGe1WLBpxms
        Fv2PXzNbnD+/gd3ibNMbdovLu+awWXzuPcJosfbIXXaL240r2Bw4PTat6mTz6NuyitHj8ya5
        AOYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzr
        U16zFNxSqug81s/awLhcpouRk0NCwERiyoFTjCC2kMBSRokHkyMh4tISjadXM0HYwhJ/rnWx
        dTFyAdV8YpQ4fWw5WIJNQF/i4NmTLCC2CFBD56KJTCBFzAJHmSSWHDkBlhAWCJJ41T0JrIFF
        QFXi2tN3YNt4BWwkzj1ezgixQV5iduNpNhCbU8BWYuqDhWwQF9lIfN51nBWiXlDi5MwnYDOZ
        geqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucWGesWJucWleel6yfm5mxiBUbHt2M/NOxgv
        bQw+xCjAwajEwyvRqxknxJpYVlyZe4hRgoNZSYSXMQwoxJuSWFmVWpQfX1Sak1p8iNEU6ImJ
        zFKiyfnAiM0riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cAo48J6
        t+N6gw2jxPID3y+Z/9A/Yd7zOEK9rl/5oNam1LLUju8Jv4yOSXfPvdbBp8hxa9Pa+Y9nNz7e
        wC2bvvfM/Df7D/24XRHT5XH900Qnu1XWG7P7LFzmbC++8y9OtF/25zqm8u4z6c2PS7qX6p+u
        3nLF4gfjkxyT8o3WyzPaF63sCg5U2lmhxFKckWioxVxUnAgAQsUJf6ACAAA=
X-CMS-MailID: 20200123145332eucas1p2110419ac74304cd32879bddcce0a950f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200123145332eucas1p2110419ac74304cd32879bddcce0a950f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200123145332eucas1p2110419ac74304cd32879bddcce0a950f
References: <20200123145313.27539-1-k.konieczny@samsung.com>
        <CGME20200123145332eucas1p2110419ac74304cd32879bddcce0a950f@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are two problems with exynos-nocp driver. First one is reading
bytes and cycle counters and comparing them one to one without taking
into account wcore bus width. Second one is that cycle counter depends
on DREX DRAM clock, not on wcore clock. The latter problem was exposed
by commit 6e7674c3c6df5 ("memory: Add DMC driver for Exynos5422"),
which changes DRAM clock depending on memory read/write pressure and when
it gets at higher freqency, NoCP cycle counter also increases. Note that
both of these problems was there before this commit.
The proposed solution is to use byte counter from NoCP h/w registers
for current wcore bandwidth calculations and derive max bandwidth from
current frequency. While at it, change from bytes to kilobytes to avoid
overflow in later calculations in exynos-bus and devfreq drivers.
Also while at it, remove cycle counters setting and reading and extend
dev_dbg with time interval in miliseconds, percent of load, raw counter
value in hex.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/event/exynos-nocp.c | 61 ++++++++++++-----------------
 1 file changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index ebe9cdf94f54..979ec094cf26 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/devfreq-event.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -60,19 +61,6 @@ static int exynos_nocp_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_update_bits(nocp->regmap, NOCP_COUNTERS_2_SRC,
-				NOCP_CNT_SRC_INTEVENT_MASK,
-				NOCP_CNT_SRC_INTEVENT_CYCLE_MASK);
-	if (ret < 0)
-		goto out;
-
-	ret = regmap_update_bits(nocp->regmap, NOCP_COUNTERS_3_SRC,
-				NOCP_CNT_SRC_INTEVENT_MASK,
-				NOCP_CNT_SRC_INTEVENT_CHAIN_MASK);
-	if (ret < 0)
-		goto out;
-
-
 	/* Set an alarm with a max/min value of 0 to generate StatALARM */
 	ret = regmap_write(nocp->regmap, NOCP_STAT_ALARM_MIN, 0x0);
 	if (ret < 0)
@@ -95,18 +83,6 @@ static int exynos_nocp_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_update_bits(nocp->regmap, NOCP_COUNTERS_2_ALARM_MODE,
-				NOCP_CNT_ALARM_MODE_MASK,
-				NOCP_CNT_ALARM_MODE_MIN_MAX_MASK);
-	if (ret < 0)
-		goto out;
-
-	ret = regmap_update_bits(nocp->regmap, NOCP_COUNTERS_3_ALARM_MODE,
-				NOCP_CNT_ALARM_MODE_MASK,
-				NOCP_CNT_ALARM_MODE_MIN_MAX_MASK);
-	if (ret < 0)
-		goto out;
-
 	/* Enable the measurements by setting AlarmEn and StatEn */
 	ret = regmap_update_bits(nocp->regmap, NOCP_MAIN_CTL,
 			NOCP_MAIN_CTL_STATEN_MASK | NOCP_MAIN_CTL_ALARMEN_MASK,
@@ -145,6 +121,7 @@ static int exynos_nocp_get_event(struct devfreq_event_dev *edev,
 {
 	struct exynos_nocp *nocp = devfreq_event_get_drvdata(edev);
 	unsigned int counter[4];
+	unsigned long dt;
 	int ret;
 
 	/* Read cycle count */
@@ -156,19 +133,29 @@ static int exynos_nocp_get_event(struct devfreq_event_dev *edev,
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_read(nocp->regmap, NOCP_COUNTERS_2_VAL, &counter[2]);
-	if (ret < 0)
-		goto out;
-
-	ret = regmap_read(nocp->regmap, NOCP_COUNTERS_3_VAL, &counter[3]);
-	if (ret < 0)
-		goto out;
-
 	edata->load_count = ((counter[1] << 16) | counter[0]);
-	edata->total_count = ((counter[3] << 16) | counter[2]);
-
-	dev_dbg(&edev->dev, "%s (event: %lu/%lu)\n", edev->desc->name,
-					edata->load_count, edata->total_count);
+	dt = jiffies_to_msecs((long)jiffies - (long)edata->prev_time);
+	if (dt == 0)
+		dt = 1;
+
+	/*
+	 * count load in kB/s
+	 * load = load / 1000 * 1000 / dt
+	 */
+	edata->load_count = edata->load_count / dt;
+
+	/*
+	 * count max bandwidth in kB/s:
+	 * bw = freq * ((bus width in bits / 8) / nr of mem channels) / 1000
+	 * where 128 bits / 8 bits per byte / 4 channels = 4
+	 * so it is: bw = freq * 4 / 1000
+	 */
+	edata->total_count = edata->curr_freq / 250;
+
+	dev_dbg(&edev->dev, "%s (event: %lu/%lu) %lums %lu%% 0x%08x\n",
+		edev->desc->name, edata->load_count, edata->total_count, dt,
+		edata->load_count * 100 / edata->total_count,
+		(counter[1] << 16) | counter[0]);
 
 	return 0;
 
-- 
2.25.0

