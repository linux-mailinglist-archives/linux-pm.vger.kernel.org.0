Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881AE293495
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 08:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391922AbgJTGII (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 02:08:08 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:15742 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730699AbgJTGIH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 02:08:07 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201020060804epoutp02b3e994794eb508d59e107bcf59670733~-nlX926-d1270712707epoutp02H
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 06:08:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201020060804epoutp02b3e994794eb508d59e107bcf59670733~-nlX926-d1270712707epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603174084;
        bh=NSzVXnAAz7onkNyfji5IwK00JaZEH8hanmJSnXheBhc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AlsQ0+PL2QDhCmlk+nKCPsbHp1QLIEu3Qdq3K/MtEQAl5tN3GoJG68Q9jqYM7bf4R
         cKO6Bjrj2JCfr5QxwJRqTJ1XBg85zv38K37T4PR1ntAsq7f04yCHyCsVsLWuxa2FsF
         TdhWsRJJ+eHaaMHvOGWYee4AFaTxKJDvDuwozyqI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201020060804epcas1p495db24ffb39d350ac40c234fe49db694~-nlXelTKW0125201252epcas1p4p;
        Tue, 20 Oct 2020 06:08:04 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4CFjpn4KvRzMqYkb; Tue, 20 Oct
        2020 06:08:01 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.05.09918.1CE7E8F5; Tue, 20 Oct 2020 15:08:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201020060801epcas1p200a266bed7ebfb80fdb38f61b1ac0566~-nlUr-5KQ3227532275epcas1p2S;
        Tue, 20 Oct 2020 06:08:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201020060801epsmtrp21cc156ee3f561aeb2b2a7c4a6cb3ea53~-nlUrX7Gg2482824828epsmtrp2l;
        Tue, 20 Oct 2020 06:08:01 +0000 (GMT)
X-AuditID: b6c32a36-713ff700000026be-55-5f8e7ec16a11
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.1A.08604.0CE7E8F5; Tue, 20 Oct 2020 15:08:00 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201020060800epsmtip2db161338f5a3e4cb99aec44d54c4b8a2~-nlUhk_XA0177901779epsmtip2e;
        Tue, 20 Oct 2020 06:08:00 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH] PM / devfreq: Remove redundant governor_name from struct
 devfreq
Date:   Tue, 20 Oct 2020 15:21:11 +0900
Message-Id: <20201020062111.18842-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7bCmru7Bur54g5aTshYTb1xhsbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0eJ24wo2BzaPTas62Tz6tqxi9Pi8SS6AOSrbJiM1MSW1SCE1Lzk/
        JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdor5JCWWJOKVAoILG4WEnfzqYo
        v7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO2PmxKOsBbt1K5Z8mMXW
        wHhMtYuRk0NCwETi36tXTF2MXBxCAjsYJSade8EO4XxilLjfd4AdpEpI4BujxMRZmV2MHGAd
        h7bqQ9TsZZRo3HqYGcL5wijxd+0BRpAGNgEtif0vbrCB2CICVhKn/3cwg9jMAikS/b/PsIDY
        wgLBEu8754AtYBFQlXj75D0TiM0LVN/17Bs7xHnyEqs3HABbICEwnV1i++T3bBAJF4nGRceZ
        IGxhiVfHt0A1SEl8frcXqqZaYuXJI2wQzR2MElv2X2CFSBhL7F86mQnkHWYBTYn1u/QhwooS
        O3/PZYQ4lE/i3dceVoiPeSU62oQgSpQlLj+4C7VWUmJxeyfUKg+J12+bGCGBFSvRuuQq2wRG
        2VkICxYwMq5iFEstKM5NTy02LDBCjqRNjOCkpGW2g3HS2w96hxiZOBgPMUpwMCuJ8E5g7YsX
        4k1JrKxKLcqPLyrNSS0+xGgKDLCJzFKiyfnAtJhXEm9oamRsbGxhYmhmamioJM77R7sjXkgg
        PbEkNTs1tSC1CKaPiYNTqoEp50Ps5kQp06LjB5/2mR4LPMr7/OAJuT3CGtpP29Ou9h4pEPAQ
        P3RQMcCQUfqUqcadOEXu+F0Tz3ts+H8ic2nw5bopGloRMX6pXy5Vfrq+fvuEe+Y+VZG5r998
        l1NfqxKh+DDqw+rIx1JX4zX3LWSXfcDZYmR21f2YjO9p9Rl8jJa/Z+9Yl/KpbiZLxrGdN5Nc
        0p4pMpxwOffp9BejbHe3WWk9r9tfHbgey7hF7Mqy746xfPGSUkk+hdGMvp17tePvqi3+/K08
        1M/Mr9b/wNzQCpHWh3tv13P+XOjYbvQ0gON1habPLN1/IUt6OT5Zr1zL4ich/CLnUMSvtWs/
        b85om3pBuvZZ4l+md71sP9WUWIozEg21mIuKEwEMpMnJ0wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJMWRmVeSWpSXmKPExsWy7bCSvO6Bur54g45vlhYTb1xhsbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0eJ24wo2BzaPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr
        Y+bEo6wFu3UrlnyYxdbAeEy1i5GDQ0LAROLQVv0uRi4OIYHdjBLdz26xdzFyAsUlJaZdPMoM
        USMscfhwMUTNJ0aJaSdnsIHUsAloSex/cQPMFhGwkbi7+BoLSD2zQIbE/+VKIGFhgUCJ5ztX
        gI1kEVCVePvkPROIzStgJdH17BvUKnmJ1RsOME9g5FnAyLCKUTK1oDg3PbfYsMAwL7Vcrzgx
        t7g0L10vOT93EyM4RLQ0dzBuX/VB7xAjEwfjIUYJDmYlEd4JrH3xQrwpiZVVqUX58UWlOanF
        hxilOViUxHlvFC6MExJITyxJzU5NLUgtgskycXBKNTD5L4yQnpSXyL5cdvOhZT84V5zZvvNd
        jrAwu2zGyRKJvpiV582Zw0rPn2ONiH7mvETK3/iLyOrLQok8Zc55czUaI94s9p2y4HqDJs/5
        ozO0Wc4IcVWfffTrHtO1l2XeHPZya6Kimn69k26Unh/7pXkV/37hk7vuC9w3uvLkbopFtd3v
        8pSmhDD7mRfvlTds/GtkGWKROmmKmLLqwaCmQ8cv/a5pVw+pTRF9cG3puZ3s7jdvW98suTIz
        kk2TeeaE1qjur1I/DvJfXy0++7uhYaOqG5vSB0Wb1htJi5pZruRNMCo43P5Z2NLm+WHe/p38
        D6fwHrDrKanWftdXtZ4vd+oW9lkqBkdWM/qa9z4M+qnEUpyRaKjFXFScCABjsThkgAIAAA==
X-CMS-MailID: 20201020060801epcas1p200a266bed7ebfb80fdb38f61b1ac0566
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201020060801epcas1p200a266bed7ebfb80fdb38f61b1ac0566
References: <CGME20201020060801epcas1p200a266bed7ebfb80fdb38f61b1ac0566@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq structure instance contains the governor_name and a governor
instance. When need to show the governor name, better to use the name
of devfreq_governor structure. So, governor_name variable in struct devfreq
is a redundant and unneeded variable. Remove the redundant governor_name
of struct devfreq and then use the name of devfreq_governor instance.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c  | 18 +++++++-----------
 drivers/devfreq/governor.h |  2 ++
 include/linux/devfreq.h    |  4 ----
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 99df27368628..8fc773bced25 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -811,7 +811,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->dev.release = devfreq_dev_release;
 	INIT_LIST_HEAD(&devfreq->node);
 	devfreq->profile = profile;
-	strscpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
@@ -907,7 +906,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	mutex_lock(&devfreq_list_lock);
 
-	governor = try_then_request_governor(devfreq->governor_name);
+	governor = try_then_request_governor(governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
 			__func__);
@@ -1250,7 +1249,7 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 		int ret = 0;
 		struct device *dev = devfreq->dev.parent;
 
-		if (!strncmp(devfreq->governor_name, governor->name,
+		if (!strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
 			/* The following should never occur */
 			if (devfreq->governor) {
@@ -1312,7 +1311,7 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		int ret;
 		struct device *dev = devfreq->dev.parent;
 
-		if (!strncmp(devfreq->governor_name, governor->name,
+		if (!strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
 			/* we should have a devfreq governor! */
 			if (!devfreq->governor) {
@@ -1407,20 +1406,17 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	 * Start the new governor and create the specific sysfs files
 	 * which depend on new governor.
 	 */
-	strncpy(df->governor_name, new_governor->name, DEVFREQ_NAME_LEN);
 	ret = new_governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
 			 __func__, new_governor->name, ret);
-		strncpy(df->governor_name, prev_governor->name,
-			DEVFREQ_NAME_LEN);
 
 		/* Restore prev_governor when failed to start new governor */
 		ret = prev_governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 		if (ret) {
 			dev_err(dev,
 				"%s: reverting to Governor %s failed (%d)\n",
-				__func__, df->governor_name, ret);
+				__func__, prev_governor->name, ret);
 			df->governor = NULL;
 			goto out;
 		}
@@ -1457,7 +1453,7 @@ static ssize_t available_governors_show(struct device *d,
 	 */
 	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
-				  "%s ", df->governor_name);
+				  "%s ", df->governor->name);
 	/*
 	 * The devfreq device shows the registered governor except for
 	 * immutable governors such as passive governor .
@@ -1900,7 +1896,7 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 
 	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
-		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
+		if (!strncmp(devfreq->governor->name, DEVFREQ_GOV_PASSIVE,
 							DEVFREQ_NAME_LEN)) {
 			struct devfreq_passive_data *data = devfreq->data;
 
@@ -1926,7 +1922,7 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 			"%-30s %-30s %-15s %-10s %10d %12ld %12ld %12ld\n",
 			dev_name(&devfreq->dev),
 			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
-			devfreq->governor_name,
+			devfreq->governor->name,
 			polling_ms ? timer_name[timer] : "null",
 			polling_ms,
 			cur_freq,
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 6458fbb58d27..2af98b8ed7c2 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -13,6 +13,8 @@
 
 #include <linux/devfreq.h>
 
+#define DEVFREQ_NAME_LEN			16
+
 #define to_devfreq(DEV)	container_of((DEV), struct devfreq, dev)
 
 /* Devfreq events */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2f4a74efa6be..82156721f459 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -15,8 +15,6 @@
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 
-#define DEVFREQ_NAME_LEN 16
-
 /* DEVFREQ governor name */
 #define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
 #define DEVFREQ_GOV_PERFORMANCE		"performance"
@@ -139,7 +137,6 @@ struct devfreq_stats {
  *		using devfreq.
  * @profile:	device-specific devfreq profile
  * @governor:	method how to choose frequency based on the usage.
- * @governor_name:	devfreq governor name for use with this devfreq
  * @nb:		notifier block used to notify devfreq object that it should
  *		reevaluate operable frequencies. Devfreq users may use
  *		devfreq.nb to the corresponding register notifier call chain.
@@ -176,7 +173,6 @@ struct devfreq {
 	struct device dev;
 	struct devfreq_dev_profile *profile;
 	const struct devfreq_governor *governor;
-	char governor_name[DEVFREQ_NAME_LEN];
 	struct notifier_block nb;
 	struct delayed_work work;
 
-- 
2.17.1

