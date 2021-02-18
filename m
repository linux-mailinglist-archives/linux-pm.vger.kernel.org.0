Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A856131F13E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhBRUmZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhBRUkb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946EFC061793
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 12:39:50 -0800 (PST)
Date:   Thu, 18 Feb 2021 20:39:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAOpLtDoZJnnLtKJX7PVE1o7MCO9glP5o5oytI23O1M=;
        b=FpJtmxLAZ9wPzPQEVQRvFbIq2h7m+zOHkHRbmCQ1JQrcvAiE5Txj9z1obI2VCq+Qplkym/
        54elzHa4TzPx3krmXxtBo52LCf1IQT43QOeWYwGCWWqXBSemY9p6pnjqmZUuL+8EBL0zTI
        mtAVrJJixVDJ93PDGkZSLLk4uRelHjuACLKqXBr8igRibt9bMybvXwYmeMbiSwo2nJHmbY
        XWmNcHNOCj10F+GebhGI+LOgESxf1xMuwKWrRwboY9xlUS6dUcbMwsIgh1NTMMYkPzvSOX
        VmHgf/UNi9M5N/MM5aDU52mlklEyy6TiXUw+h325zBC6G6zU7jwMuQkBhjRghw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAOpLtDoZJnnLtKJX7PVE1o7MCO9glP5o5oytI23O1M=;
        b=GGmx+PEaOpI0sjIQe+4/Yxo2u16g1BkzjjEzIHZjIH4BzHm23e4eq4Y1KKsLk8oUCPOnYu
        oSFai2e8cQzG4QAw==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] iio: adc: qcom-vadc-common: simplify
 qcom_vadc_map_voltage_temp
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20201204025509.1075506-11-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-11-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <161368078320.20312.14751335136043488997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     48d2e2ff85ddf7d4e88af2ee12e72818f5315a23
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//48d2e2ff85ddf7d4e88af2ee12e72818f5315a23
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Fri, 04 Dec 2020 05:55:04 +03:00
Committer:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CommitterDate: Sat, 16 Jan 2021 18:34:29 

iio: adc: qcom-vadc-common: simplify qcom_vadc_map_voltage_temp

All volt-temp tables here are sorted in descending order. There is no
need to accout for (unused) ascending table sorting case, so simplify
the conversion function.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20201204025509.1075506-11-dmitry.baryshkov@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-vadc-common.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 0c705bb..4418438 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -346,38 +346,19 @@ static struct qcom_adc5_scale_type scale_adc5_fn[] = {
 static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
 				      u32 tablesize, s32 input, int *output)
 {
-	bool descending = 1;
 	u32 i = 0;
 
 	if (!pts)
 		return -EINVAL;
 
-	/* Check if table is descending or ascending */
-	if (tablesize > 1) {
-		if (pts[0].x < pts[1].x)
-			descending = 0;
-	}
-
-	while (i < tablesize) {
-		if ((descending) && (pts[i].x < input)) {
-			/* table entry is less than measured*/
-			 /* value and table is descending, stop */
-			break;
-		} else if ((!descending) &&
-				(pts[i].x > input)) {
-			/* table entry is greater than measured*/
-			/*value and table is ascending, stop */
-			break;
-		}
+	while (i < tablesize && pts[i].x > input)
 		i++;
-	}
 
 	if (i == 0) {
 		*output = pts[0].y;
 	} else if (i == tablesize) {
 		*output = pts[tablesize - 1].y;
 	} else {
-		/* result is between search_index and search_index-1 */
 		/* interpolate linearly */
 		*output = fixp_linear_interpolate(pts[i - 1].x, pts[i - 1].y,
 						  pts[i].x, pts[i].y,
