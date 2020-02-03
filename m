Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC55150035
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 02:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBCBKC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Feb 2020 20:10:02 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:24081 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgBCBJ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Feb 2020 20:09:59 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200203010956epoutp023f6a771082cb4f32a350512f3e52ed98~vvy2IbsSM0166801668epoutp02h
        for <linux-pm@vger.kernel.org>; Mon,  3 Feb 2020 01:09:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200203010956epoutp023f6a771082cb4f32a350512f3e52ed98~vvy2IbsSM0166801668epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580692196;
        bh=BUMewYx5rWSJ6Wq1oWqSbYdedpvv2YPQrcYYGRikm7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HS1NO8GMjAEp6KPKFzPW748rOkAQAGCrhNXOOsToLyjA6fPRL6kwzusHhqsRTXnlP
         2+q2oxAd4Kl+PxIxdSUbnn5zOqg8Q6jw15qCMGNCHU89q+zEZFpQQSRb0/+hp8NPQK
         mabKmK2+ufISfpxztLYP9Xv9YcV4f89Uuuwj5qHA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200203010956epcas1p28f683e120bb91a48e24eee51aeadeb6d~vvy10Z2IH2741427414epcas1p2a;
        Mon,  3 Feb 2020 01:09:56 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 489qVn3W9GzMqYkn; Mon,  3 Feb
        2020 01:09:53 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.6A.52419.BD2773E5; Mon,  3 Feb 2020 10:09:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200203010946epcas1p1dcf58e3d8c638341a3410e813f68e59d~vvys6Shtc0038000380epcas1p1t;
        Mon,  3 Feb 2020 01:09:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200203010946epsmtrp15e04d7202a358be7f2231f9237533ee2~vvys5tbGT1442914429epsmtrp1M;
        Mon,  3 Feb 2020 01:09:46 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-54-5e3772db458a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.AE.06569.AD2773E5; Mon,  3 Feb 2020 10:09:46 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200203010946epsmtip247212d517c65435a46c3f1b659474acc~vvysvdZXi2247622476epsmtip2k;
        Mon,  3 Feb 2020 01:09:46 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        lukasz.luba@arm.com
Subject: [PATCHv2 2/2] PM / devfreq: Change to DEVFREQ_GOV_UPDATE_INTERVAL
 event name
Date:   Mon,  3 Feb 2020 10:17:33 +0900
Message-Id: <20200203011733.7639-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203011733.7639-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmge7tIvM4g+UP2C0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XCphZ2i9uNK9gc2D3WzFvD6LFpVSebR9+WVYwenzfJBbBEZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2gpFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswtLs1L10vOz7UyNDAwMgUqTMjOuPr2
        BnvBLrWKDf9/sDQw7lXoYuTkkBAwkdi65DIjiC0ksINRYtdx2y5GLiD7E6NEz8mbjBDON0aJ
        72fvssB0/F21iBkisReoatdpKOcLo8SnredZQarYBLQk9r+4wQZiiwhYSZz+38EMYjMLVEp8
        OXcUqIaDQ1ggXOL2LDkQk0VAVeJDRwJIBa+ApcTOtbNZIXbJS6zecACskxNoyt9T+9lBVkkI
        zGCT2DipkR2kV0LAReL1IWuIemGJV8e3sEPYUhIv+9ug7GqJlSePsEH0djBKbNl/AWqBscT+
        pZOZQOYwC2hKrN+lDxFWlNj5ey4jxMV8Eu++9rBCrOKV6GgTgihRlrj84C4ThC0psbi9kw3C
        9pA4ufczEyREehklnjftZ5/AKDcLYcMCRsZVjGKpBcW56anFhgXGyPG1iRGcvrTMdzBuOOdz
        iFGAg1GJh3fGQ7M4IdbEsuLK3EOMEhzMSiK8dVamcUK8KYmVValF+fFFpTmpxYcYTYEBOZFZ
        SjQ5H5ha80riDU2NjI2NLUwMzUwNDZXEeR9GasYJCaQnlqRmp6YWpBbB9DFxcEo1MCY817qw
        gE2IM+GgSpj35ZelBz83TissT5jxb+q5VWFKhsaTTyXfSUrztZx2MyA6+tb1o7o7FtxUzLlz
        T7FwdZJm4+n1UYf4EhrWB0Quf1EdJM8sEPiS82hYwwcO/6qjenUWp1P2fVabEGRgV564UVF1
        9eQX0t8Kvyren/7XT5rXYqJOcufJ40osxRmJhlrMRcWJAAyfaZZ1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsWy7bCSvO6tIvM4g6UXFCwm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XCphZ2i9uNK9gc2D3WzFvD6LFpVSebR9+WVYwenzfJBbBEcdmk
        pOZklqUW6dslcGVcfXuDvWCXWsWG/z9YGhj3KnQxcnJICJhI/F21iBnEFhLYzShxcmo4RFxS
        YtrFo0BxDiBbWOLw4eIuRi6gkk+MEu39qxhBatgEtCT2v7jBBmKLCNhI3F18jQXEZhaol2g7
        s58dxBYWCJWYvLGHBWQOi4CqxIeOBJAwr4ClxM61s1khVslLrN5wAOwETgErib+nIFqFgGo2
        r1nKNIGRbwEjwypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOAw09LawXjiRPwhRgEO
        RiUe3hkPzeKEWBPLiitzDzFKcDArifDWWZnGCfGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8W
        KSSQnliSmp2aWpBaBJNl4uCUamDMmqvbtP62fPi0iDytu846qpKvZUyeXjgm9G4f76KDs8oL
        T8fr5VyV4TgcZ3LH0dLlJceJyMkv17aW1u09G/pxro51NtvWK2Lup3zzDTQk/P8o5vx7vKjK
        6s8nraPGG1jXlu576holu1rTq9WP63RkGGfW1zILJoW1ErMmfTlznd/xzMxJqj+UWIozEg21
        mIuKEwGRiD/4LwIAAA==
X-CMS-MailID: 20200203010946epcas1p1dcf58e3d8c638341a3410e813f68e59d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200203010946epcas1p1dcf58e3d8c638341a3410e813f68e59d
References: <20200203011733.7639-1-cw00.choi@samsung.com>
        <CGME20200203010946epcas1p1dcf58e3d8c638341a3410e813f68e59d@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DEVFREQ_GOV_INTERVAL event indicates that update the interval
for polling mode of devfreq device. But, this event name doesn't
specify exactly what to do.

Change DEVFREQ_GOV_INTERVAL event name to DEVFREQ_GOV_UPDATE_INTERVAL
which specifies what to do by event name.

And modify the function name to DEVFREQ_GOV_UPDATE_INTERVAL
with 'devfreq_' prefix + verb + object as following:
- devfreq_interval_update -> devfreq_updatee_interval

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v1:
- Add reviewed tag of Lukasz
- Fix typo in patch description

 drivers/devfreq/devfreq.c                 | 10 +++++-----
 drivers/devfreq/governor.h                |  4 ++--
 drivers/devfreq/governor_simpleondemand.c |  4 ++--
 drivers/devfreq/tegra30-devfreq.c         |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index cceee8bc3c2f..8494c5f05a73 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -550,14 +550,14 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 EXPORT_SYMBOL(devfreq_monitor_resume);
 
 /**
- * devfreq_interval_update() - Update device devfreq monitoring interval
+ * devfreq_update_interval() - Update device devfreq monitoring interval
  * @devfreq:    the devfreq instance.
  * @delay:      new polling interval to be set.
  *
  * Helper function to set new load monitoring polling interval. Function
- * to be called from governor in response to DEVFREQ_GOV_INTERVAL event.
+ * to be called from governor in response to DEVFREQ_GOV_UPDATE_INTERVAL event.
  */
-void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
+void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay)
 {
 	unsigned int cur_delay = devfreq->profile->polling_ms;
 	unsigned int new_delay = *delay;
@@ -597,7 +597,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 out:
 	mutex_unlock(&devfreq->lock);
 }
-EXPORT_SYMBOL(devfreq_interval_update);
+EXPORT_SYMBOL(devfreq_update_interval);
 
 /**
  * devfreq_notifier_call() - Notify that the device frequency requirements
@@ -1426,7 +1426,7 @@ static ssize_t polling_interval_store(struct device *dev,
 	if (ret != 1)
 		return -EINVAL;
 
-	df->governor->event_handler(df, DEVFREQ_GOV_INTERVAL, &value);
+	df->governor->event_handler(df, DEVFREQ_GOV_UPDATE_INTERVAL, &value);
 	ret = count;
 
 	return ret;
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 5ba3e051b1d0..c07ce77c253d 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -18,7 +18,7 @@
 /* Devfreq events */
 #define DEVFREQ_GOV_START			0x1
 #define DEVFREQ_GOV_STOP			0x2
-#define DEVFREQ_GOV_INTERVAL			0x3
+#define DEVFREQ_GOV_UPDATE_INTERVAL		0x3
 #define DEVFREQ_GOV_SUSPEND			0x4
 #define DEVFREQ_GOV_RESUME			0x5
 
@@ -61,7 +61,7 @@ void devfreq_monitor_start(struct devfreq *devfreq);
 void devfreq_monitor_stop(struct devfreq *devfreq);
 void devfreq_monitor_suspend(struct devfreq *devfreq);
 void devfreq_monitor_resume(struct devfreq *devfreq);
-void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay);
+void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay);
 
 int devfreq_add_governor(struct devfreq_governor *governor);
 int devfreq_remove_governor(struct devfreq_governor *governor);
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 3d809f228619..1b314e1df028 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -96,8 +96,8 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 		devfreq_monitor_stop(devfreq);
 		break;
 
-	case DEVFREQ_GOV_INTERVAL:
-		devfreq_interval_update(devfreq, (unsigned int *)data);
+	case DEVFREQ_GOV_UPDATE_INTERVAL:
+		devfreq_update_interval(devfreq, (unsigned int *)data);
 		break;
 
 	case DEVFREQ_GOV_SUSPEND:
diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 0b65f89d74d5..28b2c7ca416e 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -734,7 +734,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 		devfreq_monitor_stop(devfreq);
 		break;
 
-	case DEVFREQ_GOV_INTERVAL:
+	case DEVFREQ_GOV_UPDATE_INTERVAL:
 		/*
 		 * ACTMON hardware supports up to 256 milliseconds for the
 		 * sampling period.
@@ -745,7 +745,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 		}
 
 		tegra_actmon_pause(tegra);
-		devfreq_interval_update(devfreq, new_delay);
+		devfreq_update_interval(devfreq, new_delay);
 		ret = tegra_actmon_resume(tegra);
 		break;
 
-- 
2.17.1

