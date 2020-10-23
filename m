Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6C0296C8D
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 12:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461967AbgJWKM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 06:12:58 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:54479 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461950AbgJWKM5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 06:12:57 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201023101251epoutp049aad9669cf05bcf64e56cf6d94a704f9~Al29VMP3D2611726117epoutp04H
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 10:12:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201023101251epoutp049aad9669cf05bcf64e56cf6d94a704f9~Al29VMP3D2611726117epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603447971;
        bh=S1F9EiXqIWpMNp9kRz5mWbI6bNg8qsz28wGtwJf1nZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A1gf1cOYYRW3yngl7QofATzKoxLLjPl8/XK8LS58fwot7tu5nGMT5mt28doqo4bOL
         PFq8lATqE5dVJeNnPUNaHBiwMRwWG8CbiILkhq2afRLi1pcNSZI4vlg7LqKCpL5/vR
         LyZC4VqYpoSQAUudj4RiPKo6RSNi6wLxJxC1wuV0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201023101250epcas1p3f08a5f15f10251dfbb228689866e09a6~Al28RXLqM2804728047epcas1p3j;
        Fri, 23 Oct 2020 10:12:50 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4CHg5q6qBQzMqYkf; Fri, 23 Oct
        2020 10:12:47 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.7D.09543.F9CA29F5; Fri, 23 Oct 2020 19:12:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201023101246epcas1p423f0444201300830fd63f33748dd8952~Al24xJSlN2709927099epcas1p4e;
        Fri, 23 Oct 2020 10:12:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201023101246epsmtrp138ef22675b3525f300adf0de9e85a23d~Al24wK9f50544505445epsmtrp1q;
        Fri, 23 Oct 2020 10:12:46 +0000 (GMT)
X-AuditID: b6c32a35-35dff70000002547-33-5f92ac9f4d36
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.E9.08745.E9CA29F5; Fri, 23 Oct 2020 19:12:46 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201023101246epsmtip24d410d786bb79992a5fa50c597435d97~Al24eWvey3177231772epsmtip2r;
        Fri, 23 Oct 2020 10:12:46 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v5 1/2] PM / devfreq: Add governor feature flag
Date:   Fri, 23 Oct 2020 19:26:31 +0900
Message-Id: <20201023102632.740-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023102632.740-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1AUZRieb29v2WPmaj3JPpiEaymdwwFugaMlIRxhdFH+uBFnKqs5N25b
        GI678/YozIlUCO8Ik5MwuhBEozpAhIup82jm8EANMknFkZEgqwnSkF8HdtmP6bjVqf+e932f
        533e7/1eXKJoxmLwYqOVsxhZA4lFol8MqJITWzqP6tTu6jT6k6vnAd3TeEZKO8ZGUfrG0rSU
        7lj4GdCd435AB7uHJXSV8yRKn1hslNLfHpyJoK95mzA6cHgQ0PYlJ0a3HqyKoMcPfIbRf3ib
        0U0E09ncCRjPxMeAOeuciGDc7XaMOVw5izE9sx6E+dvpQ5n3etsBE3DHamW7SjKLOFbPWZSc
        sdCkLzbyWeT2Al2OTpOuphKpDPoZUmlkS7ksMjdfm7il2BB6B6l8nTWUhVJaVhDI5OcyLaYy
        K6csMgnWLJIz6w3mDHOSwJYKZUY+qdBU+iylVqdoQsTdJUXXL3gR883M8sYDl9H94FBKDZDh
        kEiDjqoWaQ2IxBWEB8Ajn89jYrAI4GjfFBCDAIDHXE2Sh5LJth5ELHgBXOw69UCyBOCHA3fD
        LIxIgL5fx0IFHI8iXoSVQ6tWOBLCg8C+yitghbOayIa/X72OrGCUeBrW1y6FsZyg4fTIMCq6
        xcGO7v5wTxmRAWcGj6IrjSDhwuHC3HzYABK5sP6r50X+anjnYm+EiGPg7SPVD/A+6BoaxESt
        DcBe33dSsZAKfW31yEofCaGCZ7zJYvpJePbP4+E5JcQjcHa5VipayaGtWiFS4uG1WxOIiKPh
        qUN2TMQMtC91oeJOakNr/Oc4qAOxzv8cTgDQDtZwZqGU5wTKTP3/y9wgfKgJGg9w3J1P8gME
        B34AcQkZJe9b79Ap5Hp275ucxaSzlBk4wQ80oeU5JDGPFZpCl2606ihNSmpqKp1GpWsoinxc
        /tcGm05B8KyVK+E4M2d5qENwWcx+5KNGNbPY8ZbCj+fk5S0j03M73jlW3FD+RoXFO9hzOX6P
        g6+w/Ph2w8bXyrPXvmCIGpm9lJ5zRZjmlbbdWt+7M+PrM2/2e8amynP8+aejz22+sNla96rq
        ovW3IZf6lff57/c1/JC9XIPeyTgvyzVtHV73VNBVd49pu32aL+i2TTcNdDqz87uFTWtHd94K
        7tzGF6jQqbi9Dj5tAHl0rML2xJx7WNdc5N9GBkeIn7TqBDq4tS0OEwr7/b9QkS+dVEdnfNDF
        3ujX5wUo9RaV65tzzg1f13/qjn1ZFnPP0Zq4vU4Zr5vcyCftud8an7gqVzMZ+NKj3LXGHmiR
        U/cXJi4NRZKoUMRSCRKLwP4LE2JK5zEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSvO68NZPiDaZ/1rFYdukoo8XGGetZ
        LSbeuMJicf3Lc1aL1R8fM1qsuX2I0eLHhlPMFi2zFrFYLPg0g9XibNMbdovLu+awWXzuPcJo
        0fllFpvFwqYWdovbjSvYLH7umsfiIOCxZt4aRo8dd5cweuycdZfdY9OqTjaP3uZ3bB4b3+1g
        8vg7az+LR9+WVYwenzfJBXBGcdmkpOZklqUW6dslcGVcPbaLqeCWTcWMxnMsDYztRl2MnBwS
        AiYS95ZuZOpi5OIQEtjBKDH5YisLREJSYtrFo8xdjBxAtrDE4cPFEDWfGCXWznrOClLDJqAl
        sf/FDTYQW0QgWmLxx4/MIEXMAieYJFZ/2cUEkhAWsJf4fukqmM0ioCoxuecLmM0rYCHx/Pwp
        qGXyEqs3HGAGsTkFLCXeHJkEFhcCqrnfu51xAiPfAkaGVYySqQXFuem5xYYFRnmp5XrFibnF
        pXnpesn5uZsYwYGvpbWDcc+qD3qHGJk4GA8xSnAwK4nw7lafGC/Em5JYWZValB9fVJqTWnyI
        UZqDRUmc9+ushXFCAumJJanZqakFqUUwWSYOTqkGpph7mx8eObf+0udvDH5LOJRn32H4ffJC
        kWOB14lwy9QJsreuT7FcnLXg28TKjgPucxUMJBx+MV8Un7P2I7dQwKwFOvse2PZM5TI1fuD5
        O3Zy+UGl05931hrs707L2H29lPe7cKJ8ldSpsON/y33s4+bvkV41MUWZ/fqcnF9fXhk5S9u8
        UY9kznPVlBF8utKikaG1Y28IF0PItu8ZYspZ3vtnpAm+N46NOPjb2szrxsXd5g5qli5zf7h0
        6SQ9/nU1Z+azzOxbJ9bOkbUKVjybsVLnr3DbPpmy3Ttdt5sf+LVhQ+w6kbb3d9POB8edCtK6
        eLjcleN+xwalV1uWclSza26NSazU3Mb0QY738mPvDCWW4oxEQy3mouJEAJulr9vrAgAA
X-CMS-MailID: 20201023101246epcas1p423f0444201300830fd63f33748dd8952
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201023101246epcas1p423f0444201300830fd63f33748dd8952
References: <20201023102632.740-1-cw00.choi@samsung.com>
        <CGME20201023101246epcas1p423f0444201300830fd63f33748dd8952@epcas1p4.samsung.com>
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

