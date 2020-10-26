Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE8298594
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 03:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421448AbgJZChE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 22:37:04 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54510 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421447AbgJZChD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 22:37:03 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201026023658epoutp027cc04ba65c8e80795e286c884c152c2b~BakxBcyKv0601006010epoutp02G
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 02:36:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201026023658epoutp027cc04ba65c8e80795e286c884c152c2b~BakxBcyKv0601006010epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603679818;
        bh=IQ2gubulHWd8miLqDQf57qOn1f0ifWqaFESbbayxhdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcnwsXKo4hC/hAXUZnMriZZ1AxZDsXeTvuFuPzSt4I+9s6tmVf+TPeKtt8N8VSPpN
         yslWYqv/SXzOLNJUdnUm2jihJAW5K2w9WIE3YK1hfbOycXbQEU7dKaV2neYL9mn4De
         DvPHP95VbY8o69FVY3l3M6TwlIM7ihHPOkVcFgx4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201026023656epcas1p141c5e9251cda3bb28edd03941b4467eb~BakwAYM-B2197321973epcas1p1B;
        Mon, 26 Oct 2020 02:36:56 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CKJrR6Wc4zMqYkn; Mon, 26 Oct
        2020 02:36:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.5D.09918.746369F5; Mon, 26 Oct 2020 11:36:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201026023654epcas1p3add83f4f2b27b50a322a8c27451b7d98~BakuBZdtG2134021340epcas1p32;
        Mon, 26 Oct 2020 02:36:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201026023654epsmtrp15b2d45ef02c0e949aeedc42b8fdbf563~BakuAYdFc2098820988epsmtrp1Q;
        Mon, 26 Oct 2020 02:36:54 +0000 (GMT)
X-AuditID: b6c32a36-713ff700000026be-6d-5f9636479857
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.A3.08745.646369F5; Mon, 26 Oct 2020 11:36:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201026023654epsmtip2a1e8bad0c3e6b569a786a3244bc13979~BakttavXA1034710347epsmtip2v;
        Mon, 26 Oct 2020 02:36:54 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v6 1/2] PM / devfreq: Add governor feature flag
Date:   Mon, 26 Oct 2020 11:50:37 +0900
Message-Id: <20201026025038.1480-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026025038.1480-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmga672bR4gwV3jCyWXTrKaLFxxnpW
        i4k3rrBYXP/ynNVi9cfHjBZrbh9itPix4RSzRcusRSwWCz7NYLU42/SG3eLyrjlsFp97jzBa
        dH6ZxWaxsKmF3eJ24wo2i5+75rE4CHismbeG0WPH3SWMHjtn3WX32LSqk82jt/kdm8fGdzuY
        PP7O2s/i0bdlFaPH501yAZxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QH8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OL
        S/PS9ZLzc60MDQyMTIEKE7Izbk1ezF6wy7Zi1tPbrA2Md426GDk5JARMJM6cOM7cxcjFISSw
        g1HiTcMGdgjnE6NE1/ZL7CBVQgKfGSXae61gOhqmHYTq2MUosfLHGzYI5wujxJdNC1lAqtgE
        tCT2v7gBlODgEBGIlGg+KQhSwyywg0lid/NFRpAaYQF7iWtvj4BtYBFQlTi0awIziM0rYCnx
        6twUZoht8hKrNxwAszkFrCT2f/gBtllCYCWHxNNlu1kgilwk7q+Yzw5hC0u8Or4FypaSeNnf
        BmVXS6w8eYQNormDUWLL/gusEAljif1LJzOBXMosoCmxfpc+RFhRYufvuWCHMgvwSbz72sMK
        UiIhwCvR0SYEUaIscfnBXSYIW1JicXsnG4TtIfH311lWSKD0Aq36PZVtAqPcLIQNCxgZVzGK
        pRYU56anFhsWGCFH2SZGcELVMtvBOOntB71DjEwcjIcYJTiYlUR458hMjRfiTUmsrEotyo8v
        Ks1JLT7EaAoMvYnMUqLJ+cCUnlcSb2hqZGxsbGFiaGZqaKgkzvtHuyNeSCA9sSQ1OzW1ILUI
        po+Jg1OqgWlyW4rBDwbNlQ2JNUv+tmfpPnCxriq2TNx0Sy76lkDptaSezRNi/0+SNfhXn3dk
        qvfWyDUbDv07ksq6tOK/8gOJqnk/OEwmrHKe2KgQEXe8S2y/4qsz/EHZd33P7mG4xXjJZ1Vy
        690f14w0FYRsHbIXbzyzVn5VbV2XE/v8v9t6FryaI6p3LnLzNX6fs9qLt8v/0eBp+CfuN8fw
        5UTvpreLemZNXfq0zCpgb2my7tqEx4kW3m3nfz7cVn19/e63fg+eWZV//q21/srr7G08yUua
        L0Vk8BwR+xhwp8Cq58K0yEhtJ8k2D+Nvn9jbNp2I9vBeUmgRGrhr//LyyGP7bjP8uV+Rv+Ob
        TIBajmN5iKoSS3FGoqEWc1FxIgAd2ut2MQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSvK6b2bR4g4Vt2hbLLh1ltNg4Yz2r
        xcQbV1gsrn95zmqx+uNjRos1tw8xWvzYcIrZomXWIhaLBZ9msFqcbXrDbnF51xw2i8+9Rxgt
        Or/MYrNY2NTCbnG7cQWbxc9d81gcBDzWzFvD6LHj7hJGj52z7rJ7bFrVyebR2/yOzWPjux1M
        Hn9n7Wfx6NuyitHj8ya5AM4oLpuU1JzMstQifbsEroxbkxezF+yyrZj19DZrA+Ndoy5GTg4J
        AROJhmkHmbsYuTiEBHYwSqz61cUEkZCUmHbxKFCCA8gWljh8uBii5hOjRMOVU6wgNWwCWhL7
        X9xgA7FFBKIlFn/8CDaIWeAEk8TqL7vABgkL2Etce3uEHcRmEVCVOLRrAjOIzStgKfHq3BRm
        iGXyEqs3HACzOQWsJPZ/+AFmCwHVTGhcxjyBkW8BI8MqRsnUguLc9NxiwwKjvNRyveLE3OLS
        vHS95PzcTYzgwNfS2sG4Z9UHvUOMTByMhxglOJiVRHjnyEyNF+JNSaysSi3Kjy8qzUktPsQo
        zcGiJM77ddbCOCGB9MSS1OzU1ILUIpgsEwenVAPTZofeBN/bWyffdDyz98zKnRvcFBK/C82f
        uOyOi9/RjmnWkTwaT60jGn1v8G0J/x4b8GD/H43F90q4lfl3X/4S9fxr2EZLnX2dVTe2TmHc
        WR2jx7GIrytx0pupsudPbDqy+e3++dovT59262OdphP93Cphw96Lq94G7uavYg86uuRc8PTz
        NVpdGgLz3uc1vnLLaOrmcOOTeL6B85LrptMpO1uYBV/fVriZx3Wfs1v9i/oJq1S+GQtybt+I
        s8nv6q2vm8p+PuRg3OULlzM36W8o3nF18szm9JBrWqkKQn/N03dOm+uv2GmZ/XHTTbELDnPr
        BCr6xJJD4u0FHghMz2e4tOZY6BWX/tKLjHM+swtLKLEUZyQaajEXFScCAMYOUu7rAgAA
X-CMS-MailID: 20201026023654epcas1p3add83f4f2b27b50a322a8c27451b7d98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201026023654epcas1p3add83f4f2b27b50a322a8c27451b7d98
References: <20201026025038.1480-1-cw00.choi@samsung.com>
        <CGME20201026023654epcas1p3add83f4f2b27b50a322a8c27451b7d98@epcas1p3.samsung.com>
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

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
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

