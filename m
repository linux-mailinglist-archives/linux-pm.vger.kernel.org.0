Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A548233263B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 14:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhCINM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 08:12:56 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57914 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230386AbhCINMf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:35 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4BDE2200FA9;
        Tue,  9 Mar 2021 14:12:34 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E1B27200FBB;
        Tue,  9 Mar 2021 14:12:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5CD364033B;
        Tue,  9 Mar 2021 14:12:18 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 09/11] PM / devfreq: governor: optimize simpleondemand get_target_freq
Date:   Tue,  9 Mar 2021 20:58:39 +0800
Message-Id: <1615294733-22761-10-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

devfreq_simple_ondemand_data only needs to be initialized once when
calling devm_devfreq_add_device. It's unnecessary to put the data
check logic in the hot path (.get_target_freq()) where it will be
called all the time during polling. Instead, we only check and initialize
it one time during DEVFREQ_GOV_START.

This also helps check data validability in advance during DEVFREQ_GOV_START
rather than checking it later when running .get_target_freq().

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/governor_simpleondemand.c | 50 +++++++++++++++--------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index ea287b57cbf3..341eb7e9dc04 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -15,15 +15,19 @@
 /* Default constants for DevFreq-Simple-Ondemand (DFSO) */
 #define DFSO_UPTHRESHOLD	(90)
 #define DFSO_DOWNDIFFERENCTIAL	(5)
+
+static struct devfreq_simple_ondemand_data od_default = {
+	.upthreshold = DFSO_UPTHRESHOLD,
+	.downdifferential = DFSO_DOWNDIFFERENCTIAL,
+};
+
 static int devfreq_simple_ondemand_func(struct devfreq *df,
 					unsigned long *freq)
 {
 	int err;
 	struct devfreq_dev_status *stat;
 	unsigned long long a, b;
-	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
-	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
-	struct devfreq_simple_ondemand_data *data = df->data;
+	struct devfreq_simple_ondemand_data *od = df->data;
 
 	err = devfreq_update_stats(df);
 	if (err)
@@ -31,16 +35,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 
 	stat = &df->last_status;
 
-	if (data) {
-		if (data->upthreshold)
-			dfso_upthreshold = data->upthreshold;
-		if (data->downdifferential)
-			dfso_downdifferential = data->downdifferential;
-	}
-	if (dfso_upthreshold > 100 ||
-	    dfso_upthreshold < dfso_downdifferential)
-		return -EINVAL;
-
 	/* Assume MAX if it is going to be divided by zero */
 	if (stat->total_time == 0) {
 		*freq = DEVFREQ_MAX_FREQ;
@@ -55,7 +49,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 
 	/* Set MAX if it's busy enough */
 	if (stat->busy_time * 100 >
-	    stat->total_time * dfso_upthreshold) {
+	    stat->total_time * od->upthreshold) {
 		*freq = DEVFREQ_MAX_FREQ;
 		return 0;
 	}
@@ -68,7 +62,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 
 	/* Keep the current frequency */
 	if (stat->busy_time * 100 >
-	    stat->total_time * (dfso_upthreshold - dfso_downdifferential)) {
+	    stat->total_time * (od->upthreshold - od->downdifferential)) {
 		*freq = stat->current_frequency;
 		return 0;
 	}
@@ -78,17 +72,41 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	a *= stat->current_frequency;
 	b = div_u64(a, stat->total_time);
 	b *= 100;
-	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
+	b = div_u64(b, (od->upthreshold - od->downdifferential / 2));
 	*freq = (unsigned long) b;
 
 	return 0;
 }
 
+static int devfreq_simple_ondemand_check_od(struct devfreq *devfreq)
+{
+	struct devfreq_simple_ondemand_data *od = devfreq->data;
+
+	if (od) {
+		if (!od->upthreshold)
+			od->upthreshold = DFSO_UPTHRESHOLD;
+
+		if (!od->downdifferential)
+			od->downdifferential = DFSO_DOWNDIFFERENCTIAL;
+
+		if (od->upthreshold > 100 ||
+		    od->upthreshold < od->downdifferential)
+			return -EINVAL;
+	} else {
+		od = &od_default;
+	}
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
 		return devfreq_monitor_start(devfreq);
 
 	case DEVFREQ_GOV_STOP:
-- 
2.25.1

