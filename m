Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD91F14C950
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 12:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgA2LMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 06:12:30 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:63369 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2LMa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 06:12:30 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200129111228epoutp013e836b948d775ab2ef7da02bb342548c~uVyf4DLqS1624016240epoutp01t
        for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2020 11:12:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200129111228epoutp013e836b948d775ab2ef7da02bb342548c~uVyf4DLqS1624016240epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580296348;
        bh=4nSK2ny3tNo0VrNMQDmqHZBNhNBuVxRnMpX7HV+h6Ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gS+EQIdYuCqx0uQmTRw/kIE9iess17Qu82cRMbwo9VDiGNPsMHRCuxoeXlTV0Dean
         kvRh2gq6EPO0ER2Wm2WnLwtK8ykifxXdtAf8Bc51Zo0c8p8g6hdDctt471gHx9tOco
         1/kXQcomMUuaMbsnaX8UqmukiM3/G6yqhIt6nehs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200129111228epcas1p315d3935f6aec38347c027c9dd6455f92~uVyff5ShU0682306823epcas1p3R;
        Wed, 29 Jan 2020 11:12:28 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48716K676dzMqYlp; Wed, 29 Jan
        2020 11:12:25 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.5F.48498.998613E5; Wed, 29 Jan 2020 20:12:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200129111225epcas1p1c262e46a878ad68836a676bc351840bf~uVydFLrVq0933809338epcas1p1-;
        Wed, 29 Jan 2020 11:12:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200129111225epsmtrp2a56f89259ac4e82ac3d0a94ace693d55~uVydEimlP1118811188epsmtrp2R;
        Wed, 29 Jan 2020 11:12:25 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-74-5e316899840d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.EF.10238.998613E5; Wed, 29 Jan 2020 20:12:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200129111225epsmtip11170fbf66e71ad5839e95bf30ad27cbe~uVyc8UnL42784527845epsmtip1Q;
        Wed, 29 Jan 2020 11:12:25 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 2/2] PM / devfreq: Change to DEVFREQ_GOV_UPDATE_INTERVAL
 event name
Date:   Wed, 29 Jan 2020 20:20:02 +0900
Message-Id: <20200129112002.6998-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129112002.6998-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7bCmnu7MDMM4g/evDS0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsDmwem1Z1snn0bVnF6PF5k1wAc1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsbeix1MBdtVK/avW8DY
        wHhZvouRk0NCwERi/ZwTjCC2kMAORokpi0y7GLmA7E+MEi+2n2aBcL4xSlzrfs4K03H23F1W
        iI69jBLd78Ug7C+MElenRYHYbAJaEvtf3GADsUUErCRO/+9gBrGZBVIk+n+fYQGxhQVCJd5f
        XAkWZxFQlVj1bzJYnFfAUuL3vJ8sELvkJVZvOABUw8HBCTRnw4lEkHskBDrYJBbuPs4OUeMi
        cXrjfChbWOLV8S1QtpTE53d72SDsaomVJ4+wQTUzSmzZfwHqGWOJ/UsnM4EsYBbQlFi/Sx8i
        rCix8/dcRoib+STefe1hBSmREOCV6GgTgihRlrj84C4ThC0psbi9E2qVh0TX9h1MkCDpZZT4
        sM5nAqPcLIQFCxgZVzGKpRYU56anFhsWGCFH1yZGcKLSMtvBuOiczyFGAQ5GJR5eByWDOCHW
        xLLiytxDjBIczEoivKKuhnFCvCmJlVWpRfnxRaU5qcWHGE2BATmRWUo0OR+YRPNK4g1NjYyN
        jS1MDM1MDQ2VxHkfRmrGCQmkJ5akZqemFqQWwfQxcXBKNTCafz/8wWhOzbZ7v16URcxmzxT9
        snxv9P6Sdd2vg002/fm++51K/3/3OkOpi5o+CwzLblzgrgiVkX/wIvMS3+WYXfa2H5ubOa6X
        NX5PmfRU7pKMnvuUnJpP058vkfEUNu+JO9h2yLWy8Mh/0bIrPit6RbXOHXx4a2NvdcIDlmnL
        Xjytz70mejhCiaU4I9FQi7moOBEApMYMWGoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSnO7MDMM4gzXN4hYTb1xhsbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0eJ24wo2BzaPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr
        Y+/FDqaC7aoV+9ctYGxgvCzfxcjJISFgInH23F3WLkYuDiGB3YwS239OZoRISEpMu3iUuYuR
        A8gWljh8uBii5hOjxMOpO9lAatgEtCT2v7gBZosI2EjcXXyNBaSeWSBD4v9yJRBTWCBY4uoM
        A5AKFgFViVX/JrOA2LwClhK/5/1kgdgkL7F6wwGwTZwCVhIbTiSChIWASua3XmGZwMi3gJFh
        FaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcEBpae5gvLwk/hCjAAejEg/vDBWDOCHW
        xLLiytxDjBIczEoivKKuhnFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0t
        SC2CyTJxcEo1MJqb88itPJheeFhx7XPWHbvNq77+ucJV8FpH7bKG3cXyIutSh69zji59o1bV
        qtec0zzReVnfp/VxGx81yzZ9UWp9cf5wiMbsnRZxjpOi3+XlzQrecl0g7eDb32KeMtN3hgvy
        nVye9unQWok3DnfMXX9Hzvuol57xe29CEQOvhUz51dvhcwXjLJVYijMSDbWYi4oTAbg5gWIk
        AgAA
X-CMS-MailID: 20200129111225epcas1p1c262e46a878ad68836a676bc351840bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200129111225epcas1p1c262e46a878ad68836a676bc351840bf
References: <20200129112002.6998-1-cw00.choi@samsung.com>
        <CGME20200129111225epcas1p1c262e46a878ad68836a676bc351840bf@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DEVFREQ_GOV_INTERVAL event indicates that update the interval
for polling mode of devfreq device. But, this event name doesn't
specify exactly what to do.

Change DEVFREQ_GOV_INTERVAL event name to DEVFREQ_GOV_UPDATE_INTERVAL
which specifies what to do by event name.

And modify the functio name for DEVFREQ_GOV_UPDATE_INTERVAL
with 'devfreq_' prefix + verb + obejct as following:
- devfreq_interval_update -> devfreq_updatee_interval

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
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

