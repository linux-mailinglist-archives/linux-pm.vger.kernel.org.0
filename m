Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585A43AAB48
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 07:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhFQFtE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 01:49:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:17924 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhFQFtC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 01:49:02 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210617054652epoutp033f4aa76d1b85f5ca624ad667bd0f7581~JSHX0DeEZ2103621036epoutp03G
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 05:46:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210617054652epoutp033f4aa76d1b85f5ca624ad667bd0f7581~JSHX0DeEZ2103621036epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623908812;
        bh=YkhycMwItQsXct9Ie+LrHnOaX0bytSrZJ0ISUxzczEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+sIcHSUsLVdQtmd7yWB3shodo3u6/siS43XR0+f8ORkd8m/aYZdzrEBnVsOo5d1G
         zbbXFqtP7+VJj1HK50PxODDcUGdOfoZBXmm5ijM+GJ3PgYL186x0cnbXKBMuPRxuzq
         WlWsJgexH260WqiYa6ZTHdgc73yhn93lSdBd3EB4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210617054651epcas1p2cd5037b5a294d98fa445b9a9343b64b1~JSHXVZnUB2425124251epcas1p2g;
        Thu, 17 Jun 2021 05:46:51 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G59zX2353z4x9Pr; Thu, 17 Jun
        2021 05:46:48 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.AA.09736.8C1EAC06; Thu, 17 Jun 2021 14:46:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210617054647epcas1p41cd87f03bc6f5b44b6f2d7a3e5924860~JSHT1Od_t3132231322epcas1p4x;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210617054647epsmtrp1920595a8995e3e5b262cbf3240932e44~JSHT0SzjX1935819358epsmtrp1T;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
X-AuditID: b6c32a39-ea97ca8000002608-f8-60cae1c83c74
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.9D.08637.7C1EAC06; Thu, 17 Jun 2021 14:46:47 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210617054647epsmtip11ecc08f069d1ddecb288a933acbeb5ff~JSHTkh6dd1533015330epsmtip1X;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     andrew-sh.cheng@mediatek.com, hsinyi@chromium.org
Cc:     sibis@codeaurora.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org, cwchoi00@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] PM / devfreq: passive: Reduce duplicate code when
 passive_devfreq case
Date:   Thu, 17 Jun 2021 15:05:46 +0900
Message-Id: <20210617060546.26933-5-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210617060546.26933-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmnu6Jh6cSDNat5bXYvv4Fq8XEG1dY
        LK5/ec5q8eyotsWE1u3MFmeb3rBbXN41h83ic+8RRovbjSvYLLoO/WWzuLbwPasDt8fshoss
        Hpf7epk8ds66y+6xYFOpx6ZVnWweLSf3s3j0bVnF6PF5k1wAR1S2TUZqYkpqkUJqXnJ+SmZe
        uq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QnUoKZYk5pUChgMTiYiV9O5ui/NKS
        VIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7Iwzs5QLdstXfH41hamBcb9k
        FyMnh4SAicTU12fZuhi5OIQEdjBKvJn4gB3C+cQo8WzlH1YI5xujxOGNk9lhWg7f+A3VspdR
        YmHnb6iqL4wSP5b9YwSpYhPQktj/4gYbiC0iYCqx5/BEFpAiZoF7jBKPlp8HSwgLxEpcW3+F
        CcRmEVCV2HxgAlgzr4CVxO3++cwQ6+QlVm84AGZzClhLnFtyB+xACYG/7BLnP52AKnKR+LDp
        K5QtLPHq+BaoW6UkXva3QdnVEitPHmGDaO5glNiy/wIrRMJYYv/SyUBXcACdpymxfpc+RFhR
        YufvuWAHMQvwSbz72sMKUiIhwCvR0SYEUaIscfnBXSYIW1JicXsnG0SJh0RDA9iLQgJ9jBJL
        t3NOYJSbhTB/ASPjKkax1ILi3PTUYsMCU+QY28QITodaljsYp7/9oHeIkYmD8RCjBAezkgiv
        bvGJBCHelMTKqtSi/Pii0pzU4kOMpsCwm8gsJZqcD0zIeSXxhqZGxsbGFiaGZqaGhkrivDvZ
        DiUICaQnlqRmp6YWpBbB9DFxcEo1MB19sd9t6vYQFf/UNYq2s97yzpovcDJe/sLBm22KYlIc
        PEvO6culxxn4WedffWriO1Gxi30jJ+f7af0SM9Zavau45sU1j+H/511reFJ7H1tO49rI2mXc
        mcQTFNQxa/nUP4bnDhne/HnHUOtyXc7ZVn4RtyDb+tlhPZr1koaXJB6mzsu1V/ARCldy/Fh2
        SfQdj9mqiS/O5V2VEcp/4LLjn5R+z6KT5y95FU64svfDyebkTb3mJo8bWEPnL9Jfy9D//n94
        5xzdLReer7N0VfJb+owt00zvmjRfTVWXUOguJ/npFzRuLbA89jz4yUujyK1sqb6dU59sjZi8
        /Un6nadqIqqLVndrm3r3bv3FYtZzTomlOCPRUIu5qDgRADY3S3AQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnO7xh6cSDKYd1bTYvv4Fq8XEG1dY
        LK5/ec5q8eyotsWE1u3MFmeb3rBbXN41h83ic+8RRovbjSvYLLoO/WWzuLbwPasDt8fshoss
        Hpf7epk8ds66y+6xYFOpx6ZVnWweLSf3s3j0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxplZ
        ygW75Ss+v5rC1MC4X7KLkZNDQsBE4vCN32xdjFwcQgK7GSVmfvnNCpGQlJh28ShzFyMHkC0s
        cfhwMUTNJ0aJJbvXgdWwCWhJ7H9xgw2kRkTAXOL4lWiQGmaBV4wS984+BqsRFoiW+DC7jRnE
        ZhFQldh8YAIjiM0rYCVxu38+M8QueYnVGw6A2ZwC1hLnltxhB5kpBFRz/lX6BEa+BYwMqxgl
        UwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgkNWS3MH4/ZVH/QOMTJxMB5ilOBgVhLh1S0+
        kSDEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD00r2ybVn
        2Z2O1zF8k9K4PtPavuf0qhjhVU/mrzjvG1ik43cgsey0wvXc4lOXj5/Y/y+a9Vl+PJtepZvM
        Qd+MnPjPnxl7tFVD+y/HLL8p8Cnk+No9B5nDHGfkPjg+ie/YmuCTomznT1x3tDd8bshbcL5l
        V6wHy9c18yau6BJ5t6PdU215a+ak7+7iYX6lLs69Jso5Hu7TTm5iWntq1fU0Ztcdp/gtz27q
        ejjrYNoRBtaLuXrvE/68XjvPxe7m6vstGfa1/y9qmW1/Uq9xdGHezXtqy36sXTTH1eB2m+6f
        GsnkrLxa52d7OTbsutUcu4vbXfjaoqXh/hes3M5rfVvj3fD40JyHSzdHbT42bfWzvkdKLMUZ
        iYZazEXFiQBD+CNRyAIAAA==
X-CMS-MailID: 20210617054647epcas1p41cd87f03bc6f5b44b6f2d7a3e5924860
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210617054647epcas1p41cd87f03bc6f5b44b6f2d7a3e5924860
References: <20210617060546.26933-1-cw00.choi@samsung.com>
        <CGME20210617054647epcas1p41cd87f03bc6f5b44b6f2d7a3e5924860@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to keep the consistent coding style between passive_devfreq
and passive_cpufreq, use common code for handling required opp property.
Also remove the unneed conditional statement and unify the comment
of both passive_devfreq and passive_cpufreq when getting the target frequency.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor_passive.c | 80 ++++++------------------------
 1 file changed, 15 insertions(+), 65 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 07e864509b7e..7102cb7eb30d 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -91,66 +91,17 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
-	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp, *p_opp;
-	int i, count;
-
-	/*
-	 * If the devfreq device with passive governor has the specific method
-	 * to determine the next frequency, should use the get_target_freq()
-	 * of struct devfreq_passive_data.
-	 */
-	if (p_data->get_target_freq)
-		return p_data->get_target_freq(devfreq, freq);
-
-	/*
-	 * If the parent and passive devfreq device uses the OPP table,
-	 * get the next frequency by using the OPP table.
-	 */
-
-	/*
-	 * - parent devfreq device uses the governors except for passive.
-	 * - passive devfreq device uses the passive governor.
-	 *
-	 * Each devfreq has the OPP table. After deciding the new frequency
-	 * from the governor of parent devfreq device, the passive governor
-	 * need to get the index of new frequency on OPP table of parent
-	 * device. And then the index is used for getting the suitable
-	 * new frequency for passive devfreq device.
-	 */
-	if (!devfreq->profile || !devfreq->profile->freq_table
-		|| devfreq->profile->max_state <= 0)
-		return -EINVAL;
-
-	/*
-	 * The passive governor have to get the correct frequency from OPP
-	 * list of parent device. Because in this case, *freq is temporary
-	 * value which is decided by ondemand governor.
-	 */
-	if (devfreq->opp_table && parent_devfreq->opp_table) {
-		p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent,
-						freq, 0);
-		if (IS_ERR(p_opp))
-			return PTR_ERR(p_opp);
-
-		opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
-						    devfreq->opp_table, p_opp);
-		dev_pm_opp_put(p_opp);
-
-		if (IS_ERR(opp))
-			goto no_required_opp;
-
-		*freq = dev_pm_opp_get_freq(opp);
-		dev_pm_opp_put(opp);
-
-		return 0;
-	}
+	unsigned long target_freq;
+	int i;
+
+	/* Get target freq via required opps */
+	target_freq = get_taget_freq_by_required_opp(parent_devfreq->dev.parent,
+						parent_devfreq->opp_table,
+						devfreq->opp_table, *freq);
+	if (target_freq)
+		goto out;
 
-no_required_opp:
-	/*
-	 * Get the OPP table's index of decided frequency by governor
-	 * of parent device.
-	 */
+	/* Use Interpolation if required opps is not available */
 	for (i = 0; i < parent_devfreq->profile->max_state; i++)
 		if (parent_devfreq->profile->freq_table[i] == *freq)
 			break;
@@ -158,16 +109,15 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 	if (i == parent_devfreq->profile->max_state)
 		return -EINVAL;
 
-	/* Get the suitable frequency by using index of parent device. */
 	if (i < devfreq->profile->max_state) {
-		child_freq = devfreq->profile->freq_table[i];
+		target_freq = devfreq->profile->freq_table[i];
 	} else {
-		count = devfreq->profile->max_state;
-		child_freq = devfreq->profile->freq_table[count - 1];
+		i = devfreq->profile->max_state;
+		target_freq = devfreq->profile->freq_table[i - 1];
 	}
 
-	/* Return the suitable frequency for passive device. */
-	*freq = child_freq;
+out:
+	*freq = target_freq;
 
 	return 0;
 }
-- 
2.17.1

