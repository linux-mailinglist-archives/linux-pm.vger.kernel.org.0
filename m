Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC134560C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 04:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCWDNl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 23:13:41 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36726 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhCWDNI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 23:13:08 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0EA4F1A1B18;
        Tue, 23 Mar 2021 04:13:07 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 283961A1B04;
        Tue, 23 Mar 2021 04:13:02 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DB246402BB;
        Tue, 23 Mar 2021 04:12:55 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 5/6] PM / devfreq: governor: optimize simpleondemand get_target_freq
Date:   Tue, 23 Mar 2021 10:59:18 +0800
Message-Id: <1616468359-14513-6-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616468359-14513-1-git-send-email-aisheng.dong@nxp.com>
References: <1616468359-14513-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The device profile up_threshold/down_differential only needs to be
initialized once when calling devm_devfreq_add_device. It's unnecessary
to put the data check logic in the hot path (.get_target_freq()) where it
will be called all the time during polling. Instead, we only check and
initialize it one time during DEVFREQ_GOV_START.

This also helps check data validability in advance during DEVFREQ_GOV_START
rather than checking it later when running .get_target_freq().

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
Change Log:
v1->v2:
 * rebase to devfreq-testing
---
 drivers/devfreq/devfreq.c                 | 24 +++++-------------
 drivers/devfreq/governor_simpleondemand.c | 31 +++++++++++++++--------
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index cacda7d1f858..270e51f5318f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1908,9 +1908,7 @@ static ssize_t up_threshold_show(struct device *dev,
 	if (!df->profile)
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", df->profile->up_threshold
-					? df->profile->up_threshold
-					: DEVFREQ_UP_THRESHOLD);
+	return sprintf(buf, "%d\n", df->profile->up_threshold);
 }
 
 static ssize_t up_threshold_store(struct device *dev,
@@ -1934,9 +1932,7 @@ static ssize_t up_threshold_store(struct device *dev,
 	if (value > 100)
 		value = 100;
 
-	down_differential = df->profile->down_differential
-				? df->profile->down_differential
-				: DEVFREQ_DOWN_DIFFERENCTIAL;
+	down_differential = df->profile->down_differential;
 	if (value < down_differential)
 		value = down_differential;
 
@@ -1961,9 +1957,7 @@ static ssize_t down_differential_show(struct device *dev,
 	if (!df->profile)
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", df->profile->down_differential
-					? df->profile->down_differential
-					: DEVFREQ_DOWN_DIFFERENCTIAL);
+	return sprintf(buf, "%d\n", df->profile->down_differential);
 }
 
 static ssize_t down_differential_store(struct device *dev,
@@ -1984,9 +1978,7 @@ static ssize_t down_differential_store(struct device *dev,
 	if (ret != 1)
 		return -EINVAL;
 
-	up_threshold = df->profile->up_threshold
-				? df->profile->up_threshold
-				: DEVFREQ_UP_THRESHOLD;
+	up_threshold = df->profile->up_threshold;
 	if (value > up_threshold)
 		value = up_threshold;
 
@@ -2113,16 +2105,12 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 			polling_ms = 0;
 
 		if (IS_SUPPORTED_ATTR(devfreq->governor->attrs, UP_THRESHOLD))
-			up_threshold = devfreq->profile->up_threshold
-					? devfreq->profile->up_threshold
-					: DEVFREQ_UP_THRESHOLD;
+			up_threshold = devfreq->profile->up_threshold;
 		else
 			up_threshold = 0;
 
 		if (IS_SUPPORTED_ATTR(devfreq->governor->attrs, DOWN_DIFF))
-			down_differential = devfreq->profile->down_differential
-					? devfreq->profile->down_differential
-					: DEVFREQ_DOWN_DIFFERENCTIAL;
+			down_differential = devfreq->profile->down_differential;
 		else
 			down_differential = 0;
 		mutex_unlock(&devfreq->lock);
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 93f6061667d9..3e195b46554a 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -18,8 +18,8 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	int err;
 	struct devfreq_dev_status *stat;
 	unsigned long long a, b;
-	unsigned int dfso_upthreshold = DEVFREQ_UP_THRESHOLD;
-	unsigned int dfso_downdifferential = DEVFREQ_DOWN_DIFFERENCTIAL;
+	unsigned int dfso_upthreshold = df->profile->up_threshold;
+	unsigned int dfso_downdifferential = df->profile->down_differential;
 
 	err = devfreq_update_stats(df);
 	if (err)
@@ -27,15 +27,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 
 	stat = &df->last_status;
 
-	if (df->profile->up_threshold)
-		dfso_upthreshold = df->profile->up_threshold;
-	if (df->profile->down_differential)
-		dfso_downdifferential = df->profile->down_differential;
-
-	if (dfso_upthreshold > 100 ||
-	    dfso_upthreshold < dfso_downdifferential)
-		return -EINVAL;
-
 	/* Assume MAX if it is going to be divided by zero */
 	if (stat->total_time == 0) {
 		*freq = DEVFREQ_MAX_FREQ;
@@ -79,11 +70,29 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	return 0;
 }
 
+static int devfreq_simple_ondemand_check_od(struct devfreq *df)
+{
+	if (!df->profile->up_threshold)
+		df->profile->up_threshold = DEVFREQ_UP_THRESHOLD;
+
+	if (!df->profile->down_differential)
+		df->profile->down_differential = DEVFREQ_DOWN_DIFFERENCTIAL;
+
+	if (df->profile->up_threshold > 100 ||
+	    df->profile->up_threshold < df->profile->down_differential)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 				unsigned int event, void *data)
 {
 	switch (event) {
 	case DEVFREQ_GOV_START:
+		if (devfreq_simple_ondemand_check_od(devfreq))
+			return -EINVAL;
+
 		devfreq_monitor_start(devfreq);
 		break;
 
-- 
2.25.1

