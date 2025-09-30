Return-Path: <linux-pm+bounces-35596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345B3BABA21
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 08:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709E81C197E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 06:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CD208961;
	Tue, 30 Sep 2025 06:05:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D219F43A;
	Tue, 30 Sep 2025 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212319; cv=none; b=kSxTeEOtD6aCLEHCLCMXr8IYuuCraS7AqnoutZk0D+ZVzajNrUUvgkqi+JmQPFkJ2E4HkEk676bAdCa1DCvYBDfdN1YyugYW2YI9X4dJdC8MRbP99H2LZTXDebAGXA44phKbsEjchDxLvXsR1fgmlBc28Dw9GYJGdy2AAExd/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212319; c=relaxed/simple;
	bh=FFjrciq6xtVYbord7UapGyG0KK016/dtECFJhB0/Jeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VKBMYPUf0rxkT1LNbi1H6Fl1DWowC5huuS/6paeNOeWWNvclX2M2f/WjmPvZYrdxuHj9HpNIULRnn0ty2megjj3WPMwiEMqwG+/oPY1FJbtIohlzA6Kcbgk0O6a/MOXluRQxyJJXhVO7owdl6n1lfAnv5icevhspOQISRjXsJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6b7992589dc311f08b9f7d2eb6caa7cf-20250930
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3a4fb1f2-d08e-4142-96e8-e713d835e76d,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:3a4fb1f2-d08e-4142-96e8-e713d835e76d,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:5e799cfc5a13a1bde98f197bf6eb3cad,BulkI
	D:250930140510WS5UWJHS,BulkQuantity:0,Recheck:0,SF:17|19|23|43|66|74|78|10
	2|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 6b7992589dc311f08b9f7d2eb6caa7cf-20250930
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.58.13)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 822274920; Tue, 30 Sep 2025 14:05:09 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH] PM / devfreq: Optimize simple_ondemand by avoiding redundant checks in devfreq_simple_ondemand_func()
Date: Tue, 30 Sep 2025 14:05:04 +0800
Message-Id: <20250930060504.806813-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation performs unnecessary validation checks for
dfso_upthreshold and dfso_downdifferential on every call to
devfreq_simple_ondemand_func(). This is inefficient since this function
is called very frequently during normal operation.

The validation logic should be handled during governor initialization
rather than during each performance evaluation.

To resolve this issue:
- Initialize and store the threshold values in governor_data during D
EVFREQ_GOV_START
- Use the pre-validated values directly from governor_data in
devfreq_simple_ondemand_func()
- Clean up and free governor_data during DEVFREQ_GOV_STOP

This optimization reduces overhead in the hot path and improves
overall performance of the simple_ondemand governor.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/devfreq/governor_simpleondemand.c | 65 ++++++++++++++++++-----
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index c23435736367..40803888e420 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/devfreq.h>
 #include <linux/math64.h>
+#include <linux/slab.h>
 #include "governor.h"
 
 /* Default constants for DevFreq-Simple-Ondemand (DFSO) */
@@ -21,9 +22,11 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	int err;
 	struct devfreq_dev_status *stat;
 	unsigned long long a, b;
-	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
-	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
-	struct devfreq_simple_ondemand_data *data = df->data;
+	unsigned int dfso_upthreshold, dfso_downdifferential;
+	struct devfreq_simple_ondemand_data *data = df->governor_data;
+
+	if (unlikely(!data))
+		return -ENOMEM;
 
 	err = devfreq_update_stats(df);
 	if (err)
@@ -31,12 +34,9 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 
 	stat = &df->last_status;
 
-	if (data) {
-		if (data->upthreshold)
-			dfso_upthreshold = data->upthreshold;
-		if (data->downdifferential)
-			dfso_downdifferential = data->downdifferential;
-	}
+	dfso_upthreshold = data->upthreshold;
+	dfso_downdifferential = data->downdifferential;
+
 	if (dfso_upthreshold > 100 ||
 	    dfso_upthreshold < dfso_downdifferential)
 		return -EINVAL;
@@ -84,16 +84,57 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	return 0;
 }
 
+static int simple_ondemand_init(struct devfreq *devfreq)
+{
+	struct devfreq_simple_ondemand_data *gov_data, *df_data;
+
+
+	gov_data = kzalloc(sizeof(struct devfreq_simple_ondemand_data),
+					      GFP_KERNEL);
+
+	if (!gov_data) {
+		dev_err(&devfreq->dev, "Can't alloc devfreq_simple_ondemand_data\n");
+		return -ENOMEM;
+	}
+
+
+	df_data = devfreq->data;
+	gov_data->upthreshold = DFSO_UPTHRESHOLD;
+	gov_data->downdifferential = DFSO_DOWNDIFFERENCTIAL;
+
+	if (df_data) {
+		if (df_data->upthreshold)
+			gov_data->upthreshold = df_data->upthreshold;
+
+		if (df_data->downdifferential)
+			gov_data->downdifferential = df_data->downdifferential;
+	}
+
+	devfreq->governor_data = gov_data;
+	devfreq_monitor_start(devfreq);
+
+	return 0;
+}
+
+static void simple_ondemand_exit(struct devfreq *devfreq)
+{
+	devfreq_monitor_stop(devfreq);
+	kfree(devfreq->governor_data);
+	devfreq->governor_data = NULL;
+}
+
 static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 				unsigned int event, void *data)
 {
+	int ret = 0;
+
 	switch (event) {
 	case DEVFREQ_GOV_START:
-		devfreq_monitor_start(devfreq);
+		ret = simple_ondemand_init(devfreq);
 		break;
 
 	case DEVFREQ_GOV_STOP:
-		devfreq_monitor_stop(devfreq);
+		simple_ondemand_exit(devfreq);
 		break;
 
 	case DEVFREQ_GOV_UPDATE_INTERVAL:
@@ -112,7 +153,7 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static struct devfreq_governor devfreq_simple_ondemand = {
-- 
2.25.1


