Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6031F13A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhBRUmM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhBRUk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD00C06178C
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 12:39:49 -0800 (PST)
Date:   Thu, 18 Feb 2021 20:39:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGEDLLYim55k/W/PkPnoL3wurp++J2q0kb4aIwV3cyQ=;
        b=Ob7oMNgqtqMMuM1hJzn4hAW6c2eIh1Rm372cUPejmldNspePQq0d2HA96kJvwgc66O7Ri5
        8v0IbSeytbehSIEiersdQ1Jbe093Hk3/isJEERS2z+8xT2AedPI97UrJuPJa3aQXgnHVRc
        3cZOToR4rIaz7g7pf2NDLI0FsdvNDU0yJr8PVIvqP3M2IfIYgkM97U5wPrSVocXia97Nhg
        blr9SNvtqQ6RY0t2dUJ/nns+T0woQIpXwNsplV8Qrbt8O5+TBmr8/ZBI47DorxliSXbKN2
        TXalMQzwLwtS9VqqagYSq709Bcg8cih49WOFwhEp2pz2wzGGnaWLMK7jKzSlAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGEDLLYim55k/W/PkPnoL3wurp++J2q0kb4aIwV3cyQ=;
        b=xfYzJuUrFq9l9ppF99w/jDvxL5XOvOmE3nJPX21NpyZgxnH2Jzx7ycNRMovkxb7ZTOTx7b
        XZ9FQfjE72fo5JAw==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] iio: adc: qcom-vadc-common: scale
 adcmap_100k_104ef_104fb
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20201204025509.1075506-12-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-12-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <161368078297.20312.2161623554693290487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     24a7dc6fdb75790517401efed202a48dc9f5fa41
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//24a7dc6fdb75790517401efed202a48dc9f5fa41
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Fri, 04 Dec 2020 05:55:05 +03:00
Committer:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CommitterDate: Sat, 16 Jan 2021 18:36:06 

iio: adc: qcom-vadc-common: scale adcmap_100k_104ef_104fb

Scale adcmap_100k_104ef_104fb temp values by the factor of 1000 to
remove extra multiplication in qcom_vadc_scale_therm().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20201204025509.1075506-12-dmitry.baryshkov@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-vadc-common.c | 70 ++++++++++++++---------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 4418438..8682cf1 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -23,40 +23,40 @@ struct vadc_map_pt {
 
 /* Voltage to temperature */
 static const struct vadc_map_pt adcmap_100k_104ef_104fb[] = {
-	{1758,	-40},
-	{1742,	-35},
-	{1719,	-30},
-	{1691,	-25},
-	{1654,	-20},
-	{1608,	-15},
-	{1551,	-10},
-	{1483,	-5},
-	{1404,	0},
-	{1315,	5},
-	{1218,	10},
-	{1114,	15},
-	{1007,	20},
-	{900,	25},
-	{795,	30},
-	{696,	35},
-	{605,	40},
-	{522,	45},
-	{448,	50},
-	{383,	55},
-	{327,	60},
-	{278,	65},
-	{237,	70},
-	{202,	75},
-	{172,	80},
-	{146,	85},
-	{125,	90},
-	{107,	95},
-	{92,	100},
-	{79,	105},
-	{68,	110},
-	{59,	115},
-	{51,	120},
-	{44,	125}
+	{1758,	-40000 },
+	{1742,	-35000 },
+	{1719,	-30000 },
+	{1691,	-25000 },
+	{1654,	-20000 },
+	{1608,	-15000 },
+	{1551,	-10000 },
+	{1483,	-5000 },
+	{1404,	0 },
+	{1315,	5000 },
+	{1218,	10000 },
+	{1114,	15000 },
+	{1007,	20000 },
+	{900,	25000 },
+	{795,	30000 },
+	{696,	35000 },
+	{605,	40000 },
+	{522,	45000 },
+	{448,	50000 },
+	{383,	55000 },
+	{327,	60000 },
+	{278,	65000 },
+	{237,	70000 },
+	{202,	75000 },
+	{172,	80000 },
+	{146,	85000 },
+	{125,	90000 },
+	{107,	95000 },
+	{92,	100000 },
+	{79,	105000 },
+	{68,	110000 },
+	{59,	115000 },
+	{51,	120000 },
+	{44,	125000 }
 };
 
 /*
@@ -418,8 +418,6 @@ static int qcom_vadc_scale_therm(const struct vadc_linear_graph *calib_graph,
 	if (ret)
 		return ret;
 
-	*result_mdec *= 1000;
-
 	return 0;
 }
 
