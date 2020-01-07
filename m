Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180EB131D2A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 02:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgAGB2i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 20:28:38 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:36213 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgAGB2i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 20:28:38 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200107012834epoutp0423c68826e80a6e3495e8a72efe99ca21~ndoaaKIrd1382513825epoutp048
        for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2020 01:28:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200107012834epoutp0423c68826e80a6e3495e8a72efe99ca21~ndoaaKIrd1382513825epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578360514;
        bh=KtwYG9/2PGm4rQZ3lBDvM+ZeSIZzfHcUgOjUaf5kfFg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=GaydIGPgGh/cFlDTUSn5ig69XclhvZofFYIp8WWqzPdVONhAkKij5kbVkT4YcUemQ
         WGi/PwmtOmDIhUxvKfpdKGnn0KCMDcqL2Qt41vtNPSanc13bWeanuxpiF7u45A/djd
         IP0kvm2phGt3ZTzk8FARE+kdn02WYwDJeKxEESYA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200107012834epcas1p49e4d63e8291b54ab8c9a89a647c4e887~ndoZ_mucO1223112231epcas1p4S;
        Tue,  7 Jan 2020 01:28:34 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47sFBk6PqwzMqYkk; Tue,  7 Jan
        2020 01:28:30 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.2C.52419.BBED31E5; Tue,  7 Jan 2020 10:28:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200107012826epcas1p17480af9ce779b3c17f6a815cc78ed25b~ndoSiqAws1561415614epcas1p1v;
        Tue,  7 Jan 2020 01:28:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200107012826epsmtrp1fbd0b95c718f978ea98d703bbf46f792~ndoSiC_GT1341013410epsmtrp1j;
        Tue,  7 Jan 2020 01:28:26 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-87-5e13debb17de
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.7F.06569.ABED31E5; Tue,  7 Jan 2020 10:28:26 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200107012826epsmtip1328a167dc03d7ca8ab7820df8409ee82~ndoSamrmO1818918189epsmtip18;
        Tue,  7 Jan 2020 01:28:26 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH] PM / devfreq: Add missing function description and rename
 static functions
Date:   Tue,  7 Jan 2020 10:35:23 +0900
Message-Id: <20200107013523.27177-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7bCmge7ue8JxBt3rNS0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsDmwem1Z1snn0bVnF6PF5k1wAc1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsaVu28YC/77VNzoWcLc
        wDjVvouRk0NCwERiz7Iepi5GLg4hgR2MEhs+fmaFcD4xSuw/sJIFwvnGKDHzzTr2LkYOsJZD
        H71AuoUE9jJKzGmugKj5wiix8uVBJpAEm4CWxP4XN9hAbBEBK4nT/zuYQWxmgRSJ/t9nWEBs
        YYFYicPfb7KD2CwCqhJbr65mBbF5gerbT/xhgzhPXmL1hgPMIAskBD6ySiw7tw4q4SLxdeJ/
        dghbWOLV8S1QtpTEy/42KLtaYuXJI2wQzR2MElv2X2CFSBhL7F86mQnkG2YBTYn1u/QhwooS
        O3/PZYQ4lE/i3dceVoiHeSU62oQgSpQlLj+4ywRhS0osbu+EOsdDYuXyo2AThYD+mnREZgKj
        7CyE+QsYGVcxiqUWFOempxYbFhgjx9EmRnBK0jLfwbjhnM8hRgEORiUe3gkywnFCrIllxZW5
        hxglOJiVRHgb3QTjhHhTEiurUovy44tKc1KLDzGaAgNvIrOUaHI+MF3mlcQbmhoZGxtbmBia
        mRoaKonzcvy4GCskkJ5YkpqdmlqQWgTTx8TBKdXAyCzJG3j34tMJyz4ZhKdtL3k+wbDLekro
        rSKba7U3NyZ8lhdUCWUpOuawtadv6k8lloSDNRany/jfGST322z7echVp6Y8Jfzprr+LCuMY
        u+c+te9bHle6o6LG3urvBpeoQzULV+WoulW2hiVbRn+zXP70uI2qYGfJnp/he14XL/0SzfOw
        No5diaU4I9FQi7moOBEAs+9uUV8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJJMWRmVeSWpSXmKPExsWy7bCSnO6ue8JxBu0rJS0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsDmwem1Z1snn0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJX
        xpW7bxgL/vtU3OhZwtzAONW+i5GDQ0LAROLQR68uRi4OIYHdjBKLL7xn6WLkBIpLSky7eJQZ
        okZY4vDhYpCwkMAnRonDq51BbDYBLYn9L26wgdgiAjYSdxdfYwEpZxbIkPi/XAkkLCwQLbH0
        2RWwiSwCqhJbr65mBbF5Bawk2k/8YYPYJC+xesMB5gmMPAsYGVYxSqYWFOem5xYbFhjlpZbr
        FSfmFpfmpesl5+duYgQHiJbWDsYTJ+IPMQpwMCrx8FpICccJsSaWFVfmHmKU4GBWEuFtdBOM
        E+JNSaysSi3Kjy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbLxMEp1cA409JSdc/z
        fLO0HJe5C5oul5ZPFenzLRLRObjmhdreGqX2IqWt8Wb8k//YTkspSbqa+1hc4/PBfbFB93hu
        ve9cPOnHPsH18Td3tu+73T7rlMFv00bdvaUyJxZF/VMJ1U5P1wj6ayst8/9I0uEbzzM7Az/o
        /bn+dOfWhpOb1Q5yz3OJVU5YNrdMiaU4I9FQi7moOBEAW0nUygwCAAA=
X-CMS-MailID: 20200107012826epcas1p17480af9ce779b3c17f6a815cc78ed25b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107012826epcas1p17480af9ce779b3c17f6a815cc78ed25b
References: <CGME20200107012826epcas1p17480af9ce779b3c17f6a815cc78ed25b@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename internal function name used by devfreq core without 'devfreq_'
prefix in order to separate them from the exported functions.
And add missing function description for improving the readability.

Lastly, add the comments of devfreq_add_device to increase
the understanding of behavior of devfreq_add_device.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 81 +++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index acd21345a070..254f11b31824 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -48,7 +48,7 @@ static LIST_HEAD(devfreq_list);
 static DEFINE_MUTEX(devfreq_list_lock);
 
 /**
- * find_device_devfreq() - find devfreq struct using device pointer
+ * find_device_devfreq() - Find devfreq struct using device pointer
  * @dev:	device pointer used to lookup device devfreq.
  *
  * Search the list of device devfreqs and return the matched device's
@@ -73,6 +73,13 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 	return ERR_PTR(-ENODEV);
 }
 
+/**
+ * find_available_min_freq() - Find available min frequency via OPP interface
+ * @devfreq:	the devfreq instance
+ *
+ * Find available minimum frequency among the active OPP entries
+ * because could either enable or disable the frequency by using OPP interface.
+ */
 static unsigned long find_available_min_freq(struct devfreq *devfreq)
 {
 	struct dev_pm_opp *opp;
@@ -87,6 +94,13 @@ static unsigned long find_available_min_freq(struct devfreq *devfreq)
 	return min_freq;
 }
 
+/**
+ * find_available_max_freq() - Find available max frequency via OPP interface
+ * @devfreq:	the devfreq instance
+ *
+ * Find available maximum frequency among the active OPP entries
+ * because could either enable or disable the frequency by using OPP interface.
+ */
 static unsigned long find_available_max_freq(struct devfreq *devfreq)
 {
 	struct dev_pm_opp *opp;
@@ -150,11 +164,11 @@ static void get_freq_range(struct devfreq *devfreq,
 }
 
 /**
- * devfreq_get_freq_level() - Lookup freq_table for the frequency
+ * get_freq_level() - Lookup freq_table for the frequency
  * @devfreq:	the devfreq instance
  * @freq:	the target frequency
  */
-static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
+static int get_freq_level(struct devfreq *devfreq, unsigned long freq)
 {
 	int lev;
 
@@ -165,6 +179,13 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
 	return -EINVAL;
 }
 
+/**
+ * set_freq_table() - Fill out the freq_table of devfreq instance
+ * @devfreq:	the devfreq instance
+ *
+ * If freq_table array is NULL, fill out the freq_table array
+ * by using OPP interface because OPP is mandatory.
+ */
 static int set_freq_table(struct devfreq *devfreq)
 {
 	struct devfreq_dev_profile *profile = devfreq->profile;
@@ -218,7 +239,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	if (!devfreq->previous_freq)
 		goto out;
 
-	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
+	prev_lev = get_freq_level(devfreq, devfreq->previous_freq);
 	if (prev_lev < 0) {
 		ret = prev_lev;
 		goto out;
@@ -227,7 +248,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	devfreq->stats.time_in_state[prev_lev] +=
 			cur_time - devfreq->stats.last_update;
 
-	lev = devfreq_get_freq_level(devfreq, freq);
+	lev = get_freq_level(devfreq, freq);
 	if (lev < 0) {
 		ret = lev;
 		goto out;
@@ -246,7 +267,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 EXPORT_SYMBOL(devfreq_update_status);
 
 /**
- * find_devfreq_governor() - find devfreq governor from name
+ * find_devfreq_governor() - Find devfreq governor from name
  * @name:	name of the governor
  *
  * Search the list of devfreq governors and return the matched
@@ -314,8 +335,17 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 	return governor;
 }
 
-static int devfreq_notify_transition(struct devfreq *devfreq,
-		struct devfreq_freqs *freqs, unsigned int state)
+/**
+ * notify_transition() - Send the transition notification
+ * @name:	name of the governor
+ * @freqs:	the data containing the both old and new frequency
+ * @state:	the kind of notification
+ *
+ * Send the transition notification to the registered receivers
+ * in order to inform the frequency change.
+ */
+static int notify_transition(struct devfreq *devfreq,
+			struct devfreq_freqs *freqs, unsigned int state)
 {
 	if (!devfreq)
 		return -EINVAL;
@@ -337,8 +367,17 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
 	return 0;
 }
 
-static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
-			      u32 flags)
+/**
+ * set_target() - Set target frequency of devfreq instance
+ * @devfreq:	the devfreq instance
+ * @new_freq:	the target frequency
+ * @flags:	flags handed from devfreq framework
+ *
+ * Set the target frequency of which is decided by governor
+ * and then is adjusted with constraints.
+ */
+static int set_target(struct devfreq *devfreq,
+			unsigned long new_freq, u32 flags)
 {
 	struct devfreq_freqs freqs;
 	unsigned long cur_freq;
@@ -351,17 +390,17 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 
 	freqs.old = cur_freq;
 	freqs.new = new_freq;
-	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
+	notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
 
 	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
 	if (err) {
 		freqs.new = cur_freq;
-		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+		notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
 		return err;
 	}
 
 	freqs.new = new_freq;
-	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+	notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
 
 	if (devfreq_update_status(devfreq, new_freq))
 		dev_err(&devfreq->dev,
@@ -413,7 +452,7 @@ int update_devfreq(struct devfreq *devfreq)
 		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
 	}
 
-	return devfreq_set_target(devfreq, freq, flags);
+	return set_target(devfreq, freq, flags);
 
 }
 EXPORT_SYMBOL(update_devfreq);
@@ -421,7 +460,6 @@ EXPORT_SYMBOL(update_devfreq);
 /**
  * devfreq_monitor() - Periodically poll devfreq objects.
  * @work:	the work struct used to run devfreq_monitor periodically.
- *
  */
 static void devfreq_monitor(struct work_struct *work)
 {
@@ -739,11 +777,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	static atomic_t devfreq_no = ATOMIC_INIT(-1);
 	int err = 0;
 
+	/* Check the parameter is valid */
 	if (!dev || !profile || !governor_name) {
 		dev_err(dev, "%s: Invalid parameters.\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* Check the device is already added or not */
 	mutex_lock(&devfreq_list_lock);
 	devfreq = find_device_devfreq(dev);
 	mutex_unlock(&devfreq_list_lock);
@@ -754,6 +794,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
+	/* Initialize the devfreq instance */
 	devfreq = kzalloc(sizeof(struct devfreq), GFP_KERNEL);
 	if (!devfreq) {
 		err = -ENOMEM;
@@ -798,6 +839,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	atomic_set(&devfreq->suspend_count, 0);
 
+	/* Register a device for devfreq instance */
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
@@ -807,6 +849,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
+	/* Initialize the statistics of devfreq device behavior */
 	devfreq->stats.trans_table = devm_kzalloc(&devfreq->dev,
 			array3_size(sizeof(unsigned int),
 				    devfreq->profile->max_state,
@@ -831,10 +874,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->stats.total_trans = 0;
 	devfreq->stats.last_update = get_jiffies_64();
 
+	/* Initialize notifiers for informing the transition of devfreq */
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
 	mutex_unlock(&devfreq->lock);
 
+	/* Initialize PM QoS for applying the constraints */
 	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
 				     DEV_PM_QOS_MIN_FREQUENCY, 0);
 	if (err < 0)
@@ -859,6 +904,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	mutex_lock(&devfreq_list_lock);
 
+	/* Find the devfreq governor and start */
 	governor = try_then_request_governor(devfreq->governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
@@ -876,6 +922,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 
+	/* Add the devfreq instance to global devfreq list finally */
 	list_add(&devfreq->node, &devfreq_list);
 
 	mutex_unlock(&devfreq_list_lock);
@@ -1076,7 +1123,7 @@ int devfreq_suspend_device(struct devfreq *devfreq)
 
 	if (devfreq->suspend_freq) {
 		mutex_lock(&devfreq->lock);
-		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
+		ret = set_target(devfreq, devfreq->suspend_freq, 0);
 		mutex_unlock(&devfreq->lock);
 		if (ret)
 			return ret;
@@ -1106,7 +1153,7 @@ int devfreq_resume_device(struct devfreq *devfreq)
 
 	if (devfreq->resume_freq) {
 		mutex_lock(&devfreq->lock);
-		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
+		ret = set_target(devfreq, devfreq->resume_freq, 0);
 		mutex_unlock(&devfreq->lock);
 		if (ret)
 			return ret;
-- 
2.17.1

