Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E163293354
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 04:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgJTCvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 22:51:02 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:58543 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390842AbgJTCuy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 22:50:54 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201020025049epoutp0196e8fb21a3a73d2656821587eaecb1f1~-k5J3iCvT0468104681epoutp01q
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 02:50:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201020025049epoutp0196e8fb21a3a73d2656821587eaecb1f1~-k5J3iCvT0468104681epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603162249;
        bh=S1F9EiXqIWpMNp9kRz5mWbI6bNg8qsz28wGtwJf1nZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGw8mNNnn3pXxiA6Yr/meJxel6Od7M9xzaDkyN+Xme0D9NrYWZx/HbFKErdz5rvUI
         RFBwTZQcIiOCklhCMPuY1uKjH/9jqSLUVTYu4BI2lXXXRz8ql0sLM0gigQtrgnG8Gt
         n2PORw6fHpL+Pp3iHmFxrjDtm6nfSB9Cy968teYg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201020025048epcas1p10371cc629d644fc1f7c07996cd098b28~-k5JC27_c0036700367epcas1p1y;
        Tue, 20 Oct 2020 02:50:48 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CFdRB3qcSzMqYkk; Tue, 20 Oct
        2020 02:50:46 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.B2.10463.6805E8F5; Tue, 20 Oct 2020 11:50:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201020025045epcas1p2b19bd28d187219bdd1978516f744bf65~-k5F3OUq80098400984epcas1p2e;
        Tue, 20 Oct 2020 02:50:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201020025045epsmtrp159b1e339bcd7beef7bd844cbec893651~-k5F2ZWBc2757727577epsmtrp1w;
        Tue, 20 Oct 2020 02:50:45 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-85-5f8e5086e8b9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.36.08745.5805E8F5; Tue, 20 Oct 2020 11:50:45 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201020025045epsmtip16dfa6b786ef632ba1fd4b4e10053cfae~-k5FlA8Zx0077600776epsmtip1t;
        Tue, 20 Oct 2020 02:50:45 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v4 1/2] PM / devfreq: Add governor feature flag
Date:   Tue, 20 Oct 2020 12:04:06 +0900
Message-Id: <20201020030407.21047-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020030407.21047-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmgW5bQF+8wfo9khbLLh1ltNg4Yz2r
        xcQbV1gsrn95zmqx+uNjRos1tw8xWvzYcIrZomXWIhaLBZ9msFqcbXrDbnF51xw2i8+9Rxgt
        Or/MYrNY2NTCbnG7cQWbxc9d81gcBDzWzFvD6LHj7hJGj52z7rJ7bFrVyebR2/yOzWPjux1M
        Hn9n7Wfx6NuyitHj8ya5AM6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
        xNxUWyUXnwBdt8wcoD+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnF
        pXnpesn5uVaGBgZGpkCFCdkZV4/tYiq4ZVMxo/EcSwNju1EXIweHhICJxIevGV2MXBxCAjsY
        JaZtfcEC4XxilDj2+Cs7hPOZUeJJ2z3mLkZOsI7b1y+xgdhCArsYJTYdNoEo+sIo8XvqeXaQ
        BJuAlsT+FzfYQFaICERKNJ8UBKlhFtjBJLG7+SIjSI2wgL3EwqUnwOpZBFQl+nc1gS3gFbCS
        aJ84jx1imbzE6g0HwOKcAtYSHzr/MYEMkhBYyyEx981uqCIXiScPW9ggbGGJV8e3QMWlJF72
        t0HZ1RIrTx5hg2juYJTYsv8CK0TCWGL/0slMIJcyC2hKrN+lDxFWlNj5ey7YocwCfBLvvvaw
        QsKLV6KjTQiiRFni8oO7TBC2pMTi9k6oEzwk/rdeZoMESh+jxNpNZ1kmMMrNQtiwgJFxFaNY
        akFxbnpqsWGBCXKMbWIEp1Mtix2Mc99+0DvEyMTBeIhRgoNZSYR3AmtfvBBvSmJlVWpRfnxR
        aU5q8SFGU2DoTWSWEk3OByb0vJJ4Q1MjY2NjCxNDM1NDQyVx3j/aHfFCAumJJanZqakFqUUw
        fUwcnFINTLpcRa/FisMPnAmeqc8/89PZyOknA2c67J0isVrJ8vBZy0k8mWcquqVf3TnXoxcc
        pHFVLEri6Xc+ia3v/ObutZrc/WfHsTXLX6iL395y9Iq/q2vO/VecnJXnEyb1Z/hYdy+z3fnI
        cKK++a2Ah4d4PCzbfEzTF21gO95okZ2Xu+7S9c3ctqU7z1nYr94jOXWWu3bShcnN3F0tF1sM
        ni6xmFLwwna+XIXXtwXOx0U3bhZT6/ffyqN1fPLcGx9VXvdZs29q60/dkRf06WKrq+mqfd8m
        VfEvdQozurs+367/w4L3kp9PcZn94j4rt/eUeYIOi9lUxvZJboyPns+bkd/26seF4A8MS8Q+
        HhP0tv+lIqfEUpyRaKjFXFScCABYzsaDMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSnG5rQF+8wexvPBbLLh1ltNg4Yz2r
        xcQbV1gsrn95zmqx+uNjRos1tw8xWvzYcIrZomXWIhaLBZ9msFqcbXrDbnF51xw2i8+9Rxgt
        Or/MYrNY2NTCbnG7cQWbxc9d81gcBDzWzFvD6LHj7hJGj52z7rJ7bFrVyebR2/yOzWPjux1M
        Hn9n7Wfx6NuyitHj8ya5AM4oLpuU1JzMstQifbsEroyrx3YxFdyyqZjReI6lgbHdqIuRk0NC
        wETi9vVLbF2MXBxCAjsYJVqe/GeDSEhKTLt4lLmLkQPIFpY4fLgYouYTo8SRk+9ZQGrYBLQk
        9r+4AVYvIhAtsfjjR2aQImaBE0wSq7/sYgJJCAvYSyxceoIdxGYRUJXo39XEDGLzClhJtE+c
        xw6xTF5i9YYDYHFOAWuJD53/wHqFgGpmHr3PNoGRbwEjwypGydSC4tz03GLDAqO81HK94sTc
        4tK8dL3k/NxNjODA19Lawbhn1Qe9Q4xMHIyHGCU4mJVEeCew9sUL8aYkVlalFuXHF5XmpBYf
        YpTmYFES5/06a2GckEB6YklqdmpqQWoRTJaJg1OqgWl1bInKxnVLPAUeBcpP3P04zCvO+o26
        QvYOpvsWRq7PXzDtXTJH3lEz5tDOu++0+15cubqmbKnYxVuTD8119jIM4+hkPzfpIrfS6gu9
        PNLXlXb38PEbeune3XY7tldQfYLFv1ttO/PadERWMPdyPs10UJ5vWvLn3s7LejvrH5lmf7bZ
        bV39Nf+j6eGdswRLXr21tFc60jRdr+HPskVCJpHrm7vT2ENS7i6cvFCv6ZDrZ+mmVdcfhxVu
        KM1PtZhiadcvvnPlca0Th0XcT5+zP6eYnu67Xn0j502LjcW89VWHRNIYmctYL+3TnGyfkKPM
        /sF9x4GDxWv3PndjF1u2bYXnua6o919Svh5nkfBpeqDEUpyRaKjFXFScCACLyvPb6wIAAA==
X-CMS-MailID: 20201020025045epcas1p2b19bd28d187219bdd1978516f744bf65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201020025045epcas1p2b19bd28d187219bdd1978516f744bf65
References: <20201020030407.21047-1-cw00.choi@samsung.com>
        <CGME20201020025045epcas1p2b19bd28d187219bdd1978516f744bf65@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq governor is able to have the specific flag as follows
in order to implement the specific feature. For example, devfreq allows
user to change the governors on runtime via sysfs interface.
But, if devfreq device uses 'passive' governor, don't allow user to change
the governor. For this case, define the DEVFREQ_GOV_FLAG_IMMUTABLE
and set it to flag of passive governor.

[Definition for governor flag]
- DEVFREQ_GOV_FLAG_IMMUTABLE
  : If immutable flag is set, governor is never changeable to other governors.
- DEVFREQ_GOV_FLAG_IRQ_DRIVEN
  : Devfreq core won't schedule polling work for this governor if value is set.

[Table of governor flag for devfreq governors]
------------------------------------------------------------------------------
                      | simple    | perfor | power | user | passive | tegra30
		      | ondemand  | mance  | save  | space|         |
------------------------------------------------------------------------------
immutable             | X         | X      | X     | X    | O       | O
interrupt_driven      | X(polling)| X      | X     | X    | X       | O (irq)
------------------------------------------------------------------------------

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c          | 25 ++++++++++++++-----------
 drivers/devfreq/governor.h         | 18 ++++++++++++------
 drivers/devfreq/governor_passive.c |  2 +-
 drivers/devfreq/tegra30-devfreq.c  |  4 ++--
 4 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1b236b9e4d9e..a862acfe987e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -31,6 +31,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/devfreq.h>
 
+#define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name) ? true : false)
 #define HZ_PER_KHZ	1000
 
 static struct class *devfreq_class;
@@ -479,7 +480,7 @@ static void devfreq_monitor(struct work_struct *work)
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
-	if (devfreq->governor->interrupt_driven)
+	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
 		return;
 
 	switch (devfreq->profile->timer) {
@@ -509,7 +510,7 @@ EXPORT_SYMBOL(devfreq_monitor_start);
  */
 void devfreq_monitor_stop(struct devfreq *devfreq)
 {
-	if (devfreq->governor->interrupt_driven)
+	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
 		return;
 
 	cancel_delayed_work_sync(&devfreq->work);
@@ -540,7 +541,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 	devfreq->stop_polling = true;
 	mutex_unlock(&devfreq->lock);
 
-	if (devfreq->governor->interrupt_driven)
+	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
 		return;
 
 	cancel_delayed_work_sync(&devfreq->work);
@@ -560,12 +561,13 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 	unsigned long freq;
 
 	mutex_lock(&devfreq->lock);
-	if (!devfreq->stop_polling)
-		goto out;
 
-	if (devfreq->governor->interrupt_driven)
+	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
 		goto out_update;
 
+	if (!devfreq->stop_polling)
+		goto out;
+
 	if (!delayed_work_pending(&devfreq->work) &&
 			devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
@@ -600,10 +602,10 @@ void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay)
 	mutex_lock(&devfreq->lock);
 	devfreq->profile->polling_ms = new_delay;
 
-	if (devfreq->stop_polling)
+	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
 		goto out;
 
-	if (devfreq->governor->interrupt_driven)
+	if (devfreq->stop_polling)
 		goto out;
 
 	/* if new delay is zero, stop polling */
@@ -1370,7 +1372,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
-	} else if (df->governor->immutable || governor->immutable) {
+	} else if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)
+		|| IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1425,7 +1428,7 @@ static ssize_t available_governors_show(struct device *d,
 	 * The devfreq with immutable governor (e.g., passive) shows
 	 * only own governor.
 	 */
-	if (df->governor->immutable) {
+	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
 				  "%s ", df->governor_name);
 	/*
@@ -1436,7 +1439,7 @@ static ssize_t available_governors_show(struct device *d,
 		struct devfreq_governor *governor;
 
 		list_for_each_entry(governor, &devfreq_governor_list, node) {
-			if (governor->immutable)
+			if (IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE))
 				continue;
 			count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
 					   "%s ", governor->name);
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 02cf876244d6..7dbb110a869e 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -25,14 +25,21 @@
 #define DEVFREQ_MIN_FREQ			0
 #define DEVFREQ_MAX_FREQ			ULONG_MAX
 
+/*
+ * Definition of the governor feature flags
+ * - DEVFREQ_GOV_FLAG_IMMUTABLE
+ *   : This governor is never changeable to other governors.
+ * - DEVFREQ_GOV_FLAG_IRQ_DRIVEN
+ *   : The devfreq won't schedule the work for this governor.
+ */
+#define DEVFREQ_GOV_FLAG_IMMUTABLE			BIT(0)
+#define DEVFREQ_GOV_FLAG_IRQ_DRIVEN			BIT(1)
+
 /**
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
  * @name:		Governor's name
- * @immutable:		Immutable flag for governor. If the value is 1,
- *			this governor is never changeable to other governor.
- * @interrupt_driven:	Devfreq core won't schedule polling work for this
- *			governor if value is set to 1.
+ * @flags:		Governor's feature flags
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
@@ -50,8 +57,7 @@ struct devfreq_governor {
 	struct list_head node;
 
 	const char name[DEVFREQ_NAME_LEN];
-	const unsigned int immutable;
-	const unsigned int interrupt_driven;
+	const u64 flags;
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 	int (*event_handler)(struct devfreq *devfreq,
 				unsigned int event, void *data);
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 53a1b1596232..63332e4a65ae 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -158,7 +158,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_passive = {
 	.name = DEVFREQ_GOV_PASSIVE,
-	.immutable = 1,
+	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE,
 	.get_target_freq = devfreq_passive_get_target_freq,
 	.event_handler = devfreq_passive_event_handler,
 };
diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index f5e74c2ede85..faa1aecf2a31 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -765,10 +765,10 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
+	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE
+		| DEVFREQ_GOV_FLAG_IRQ_DRIVEN,
 	.get_target_freq = tegra_governor_get_target,
 	.event_handler = tegra_governor_event_handler,
-	.immutable = true,
-	.interrupt_driven = true,
 };
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
-- 
2.17.1

